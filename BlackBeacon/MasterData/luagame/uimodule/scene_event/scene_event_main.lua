local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CSHelper = _ENV.CSHelper
local SaticSv = require("ui.widget.static_scroll_view")
local SceneEventItem = require("uimodule.scene_event.scene_event_item")
local MODEL = {
  v_bg_close = {
    "BgClose",
    BIND_TYPE.BUTTON
  },
  v_btn_complete = {
    "BtnComplete",
    BIND_TYPE.BUTTON
  },
  v_btn_return = {
    "BtnReturn",
    BIND_TYPE.BUTTON
  },
  v_choose_obj = {
    "ChooseObj",
    BIND_TYPE.OBJECT
  },
  v_event_desc = {
    "EventDesc",
    BIND_TYPE.TEXT
  },
  v_event_icon = {
    "EventIcon",
    BIND_TYPE.IMAGE
  },
  v_event_title = {
    "EventTitle",
    BIND_TYPE.TEXT
  },
  v_option_content = {
    "OptionContent",
    BIND_TYPE.OBJECT
  },
  v_option_tem = {
    "OptionTem",
    BIND_TYPE.OBJECT
  },
  v_result2 = {
    "Result2",
    BIND_TYPE.IMAGE
  },
  v_result_desc2 = {
    "ResultDesc2",
    BIND_TYPE.TEXT
  },
  v_result_desc = {
    "ResultDesc",
    BIND_TYPE.TEXT
  },
  v_result_icon = {
    "ResultIcon",
    BIND_TYPE.IMAGE
  },
  v_result_now = {
    "ResultNow",
    BIND_TYPE.IMAGE
  },
  v_result_obj = {
    "ResultObj",
    BIND_TYPE.OBJECT
  },
  v_result_other1 = {
    "ResultOther1",
    BIND_TYPE.IMAGE
  },
  v_result_other2 = {
    "ResultOther2",
    BIND_TYPE.IMAGE
  },
  v_result_title = {
    "ResultTitle",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.list_key = "scene_event_item_Key" .. self:ui_get_name()
  self.v_scene_event_list = SaticSv:new(self, self.v_option_content, SceneEventItem, self.list_key)
  self.result_timeline = Util.get_child("Animation/Ani_VX_ResultObj_IN", self.v_object)
  self.red_glow_timeline = Util.get_child("Animation/Ani_RedGlow", self.v_object)
  self.yellow_glow_timeline = Util.get_child("Animation/Ani_YellowGlow", self.v_object)
  self.blue_glow_timeline = Util.get_child("Animation/Ani_BlueGlow", self.v_object)
  self.red_glow_obj = Util.get_child("RedGlow", self.v_event_icon.gameObject)
  self.yellow_glow_obj = Util.get_child("YellowGlow", self.v_event_icon.gameObject)
  self.blue_glow_obj = Util.get_child("BlueGlow", self.v_event_icon.gameObject)
  self.result_red_glow_obj = Util.get_child("FX_UI_RedParticle", self.v_result_icon.gameObject)
  self.result_yellow_glow_obj = Util.get_child("FX_UI_YellowParticle", self.v_result_icon.gameObject)
  self.result_blue_glow_obj = Util.get_child("FX_UI_BlueParticle", self.v_result_icon.gameObject)
  self.v_event_icon.enabled = false
end

function ui:ui_on_show(npc_data, callback)
  SceneEventMgr:set_choose_option_index(-1)
  SceneEventMgr:set_temp_choose_option_index(-1)
  self.npc_id = npc_data.npc_id
  self:show_choose_obj(true)
  self:refresh_scene_event_title()
  self:refresh_scene_event_list()
  self:set_button_listener(self.v_btn_return, function()
    local index = SceneEventMgr:get_choose_option_index()
    if index > -1 then
      callback(npc_data)
    end
    self:ui_hide()
  end)
  self:set_button_listener(self.v_bg_close, function()
    if self.v_result_obj.activeSelf == false then
      return
    end
    if CSHelper.SetPlayableDirectorToFinal(self.result_timeline) then
      return
    end
    local index = SceneEventMgr:get_choose_option_index()
    if index > -1 then
      callback(npc_data)
    end
    self:ui_hide()
  end)
  self:set_button_listener(self.v_btn_complete, function()
    callback(npc_data)
    self:ui_hide()
  end)
  self:register_event()
  self.result_timeline:SetActive(false)
  self:hide_all_glow_and_timeline()
end

function ui:show_choose_obj(value)
  self.v_choose_obj:SetActive(value)
  self.v_result_obj:SetActive(not value)
  self.result_timeline:SetActive(true)
end

function ui:refresh_scene_event_title()
  local title_info = SceneEventMgr:get_npc_title_info(self.npc_id)
  ResMgr:load_set_icon(self.v_event_icon, SceneEventMgr.icon_list[title_info[1]].result)
  self.v_event_title.text = title_info[2]
  self.v_event_desc.text = title_info[3]
end

function ui:refresh_scene_event_list()
  local event_list = SceneEventMgr:get_npc_option_list(self.npc_id)
  self.list = {}
  for i, v in ipairs(event_list) do
    self.list[i] = {}
    self.list[i].index = i
    self.list[i].data = v
  end
  self.v_scene_event_list:update_list(self.list)
end

function ui:refresh_scene_event_result(index)
  local result_info = SceneEventMgr:get_npc_result_info(self.npc_id, index)
  local result_num_str = result_info[1]
  ResMgr:load_set_icon(self.v_result_icon, SceneEventMgr.icon_list[result_num_str].result)
  self.v_result_title.text = result_info[2]
  self.v_result_desc.text = result_info[3]
  self.v_result_desc2.text = ""
  self.v_result2.gameObject:SetActive(false)
  if #result_info > 3 and result_info[4] and "" ~= result_info[4] then
    self.v_result2.gameObject:SetActive(true)
    self.v_result_desc2.text = result_info[4]
  end
  local left_num_str = ""
  local right_num_str = ""
  if "1" == result_num_str then
    left_num_str = "2"
    right_num_str = "3"
  elseif "2" == result_num_str then
    left_num_str = "1"
    right_num_str = "3"
  else
    left_num_str = "1"
    right_num_str = "2"
  end
  ResMgr:load_set_icon(self.v_result_now, SceneEventMgr.icon_list[result_num_str].result_title)
  ResMgr:load_set_icon(self.v_result_other1, SceneEventMgr.icon_list[left_num_str].result_title)
  ResMgr:load_set_icon(self.v_result_other2, SceneEventMgr.icon_list[right_num_str].result_title)
  self.result_yellow_glow_obj:SetActive("1" == result_num_str)
  self.result_blue_glow_obj:SetActive("2" == result_num_str)
  self.result_red_glow_obj:SetActive("3" == result_num_str or "4" == result_num_str)
  if Global.sound_mgr then
    Global.sound_mgr:play_event_result_sound()
  end
end

function ui:on_scene_option_choose_over()
  self:show_choose_obj(false)
  local index = SceneEventMgr:get_choose_option_index()
  self:refresh_scene_event_result(index)
end

function ui:on_scene_option_choose()
  self.red_glow_obj:SetActive(false)
  self.yellow_glow_obj:SetActive(false)
  self.blue_glow_obj:SetActive(false)
  local index = SceneEventMgr:get_temp_choose_option_index()
  local result_num_str = self.list[index].data[1]
  self.yellow_glow_timeline:SetActive("1" == result_num_str)
  self.blue_glow_timeline:SetActive("2" == result_num_str)
  self.red_glow_timeline:SetActive("3" == result_num_str or "4" == result_num_str)
end

function ui:hide_all_glow_and_timeline()
  self.red_glow_obj:SetActive(false)
  self.yellow_glow_obj:SetActive(false)
  self.blue_glow_obj:SetActive(false)
  self.yellow_glow_timeline:SetActive(false)
  self.red_glow_timeline:SetActive(false)
  self.blue_glow_timeline:SetActive(false)
end

function ui:register_event()
  self:bind_auto_mq(Const.ON_SCENE_OPTION_CHOOSE, self.on_scene_option_choose, self)
  self:bind_auto_mq(Const.ON_SCENE_OPTION_CHOOSE_OVER, self.on_scene_option_choose_over, self)
end

function ui:ui_on_hide()
  self.v_scene_event_list:clear()
  self:unbind_all_auto_mq()
end

function ui:ui_on_destroy()
  self.v_scene_event_list = nil
end

return ui
