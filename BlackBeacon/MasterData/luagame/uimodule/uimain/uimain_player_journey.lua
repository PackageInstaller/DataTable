local Base = require("ui.uibase")
local LoopListClass = require("ui.widget.infinite_loop_list")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local PLAYER_JOURNEY_ITEM = require("uimodule.uimain.uimain_player_journey_item")
local PLAYER_JOURNEY_AWARD_ITEM = "PLAYER_JOURNEY_AWARD_ITEM"
local JOURNEY_STATE = Config.CommonDefine.JOURNEY_STATE
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_award_content = {
    "AwardContent",
    BIND_TYPE.OBJECT
  },
  v_award_name = {
    "AwardName",
    BIND_TYPE.TEXT
  },
  v_award_tem = {
    "AwardTem",
    BIND_TYPE.BUTTON
  },
  v_award = {
    "Award",
    BIND_TYPE.OBJECT
  },
  v_bg_ret = {
    "BgRet",
    BIND_TYPE.IMAGE
  },
  v_btn_receive = {
    "BtnReceive",
    BIND_TYPE.BUTTON
  },
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_condition = {
    "Condition",
    BIND_TYPE.TEXT
  },
  v_got = {
    "Got",
    BIND_TYPE.IMAGE
  },
  v_lv_content = {
    "LvContent",
    BIND_TYPE.OBJECT
  },
  v_lv_list = {
    "LvList",
    BIND_TYPE.IMAGE
  },
  v_un_complete = {
    "UnComplete",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BgRet", function()
    self:do_hide()
  end)
  self:set_button("BtnRet1", function()
    self:do_hide()
  end)
  self:set_button("BtnReceive", function()
    if self.v_cur_select_idx and self.v_data_list[self.v_cur_select_idx] then
      PlayerJourneyMgr:req_journey_gain_reward(self.v_data_list[self.v_cur_select_idx].Id)
    end
  end)
  self.v_loop_list = LoopListClass:new(self, self.v_uiobjects.LvList, PLAYER_JOURNEY_ITEM)
  self:register_exist_auto_template(PLAYER_JOURNEY_AWARD_ITEM, self.v_award_tem, self.v_award_content)
end

function ui:do_hide()
  if self.v_is_hiding then
    return
  end
  self.v_is_hiding = true
  if self.v_hide_cb then
    self.v_hide_cb()
  end
  self.v_uiobjects.Ani_UIPlayerLvAward_Out:SetActive(true)
  if self.v_hide_timer then
    Timer:remove_timer(self.v_hide_timer)
  end
  self.v_hide_timer = Timer:add_timer("uimain_player_journey_hide_ui", 0.4, function()
    self:ui_hide()
  end)
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_JOURNEY_UPDATE, self._refresh_data_list, self)
  self:bind_auto_mq(Const.MSG_ON_JOURNEY_ITEM_CLICK, self.on_select_item_msg, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.on_ui_show_event, self)
  self:bind_auto_mq(Const.MSG_ON_JUMP_TO_SYS, self.ui_hide, self)
end

function ui:ui_on_show(hide_cb)
  self.v_is_hiding = false
  self.v_uiobjects.Ani_UIPlayerLvAward_Out:SetActive(false)
  self.v_hide_cb = hide_cb
  self:_regist_client_event()
  self:_refresh_data_list()
end

function ui:ui_on_hide()
  self.v_uiobjects.Ani_UIPlayerLvAward_Out:SetActive(false)
  if self.v_hide_timer then
    Timer:remove_timer(self.v_hide_timer)
    self.v_hide_timer = nil
  end
  self.v_loop_list:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_loop_list:ui_on_destroy()
end

function ui:_refresh_data_list()
  self.v_data_list = PlayerJourneyMgr:get_journey_list()
  local count = self.v_data_list and #self.v_data_list or 0
  if 0 == count then
    return
  end
  self.v_cur_select_idx = PlayerJourneyMgr:get_first_not_gained_lv()
  for idx, v in pairs(self.v_data_list) do
    v.selected = idx == self.v_cur_select_idx
  end
  self.v_loop_list:refresh_data(self.v_data_list)
  local content = self.v_loop_list.v_scrollret.content
  local viewport = self.v_loop_list.v_scrollret.viewport
  local space = self.v_loop_list.v_scrollviewex.spacing.x
  local cell_width = self.v_loop_list.v_scrollviewex.m_CellTemplateTrans.rect.width
  local v_width = viewport.rect.width
  local x_pos = -((cell_width + space) * (self.v_cur_select_idx - 1) + cell_width / 2 - v_width / 2)
  content:SetLocalPositionA(x_pos, 0, 0)
  self:on_select_item(self.v_cur_select_idx)
end

function ui:on_ui_show_event(msg)
  if not msg then
    return
  end
  local ui_name = msg.mm_obj
  if "uidrawcard_movie" == ui_name then
    self:ui_hide()
  end
end

function ui:on_select_item_msg(msg)
  local id = msg.mm_x
  self:on_select_item(id)
end

function ui:on_select_item(id)
  if id ~= self.v_cur_select_idx then
    local item = self.v_loop_list:get_item_ui(self.v_cur_select_idx)
    if item then
      item:set_selected(false)
    end
    self.v_data_list[self.v_cur_select_idx].selected = false
    self.v_cur_select_idx = id
  end
  self.v_data_list[id].selected = true
  self:_refresh_view()
end

function ui:_refresh_view()
  local data = self.v_data_list[self.v_cur_select_idx]
  self.v_award_name.text = data.Title
  self.v_condition.text = ShareRes.get_condition_desc(data.Condition)
  self.v_uiobjects.BtnReceive:SetActive(data.state == JOURNEY_STATE.COMPLETE)
  self.v_uiobjects.UnComplete:SetActive(data.state == JOURNEY_STATE.UNCOMPLETE)
  self.v_uiobjects.Got:SetActive(data.state == JOURNEY_STATE.GAINED)
  self.v_uiobjects.Condition:SetActive(data.state == JOURNEY_STATE.UNCOMPLETE)
  self.v_award:SetActive(data.unlock)
  if data.unlock then
    self:_refresh_award(data.AwardGroup)
  end
end

function ui:_refresh_award(award_group)
  self:give_back_auto_cache(PLAYER_JOURNEY_AWARD_ITEM)
  local award_list = ShareRes.get_awards(award_group)
  if not award_list then
    return
  end
  for _, v in ipairs(award_list) do
    local award_item = self:get_auto_cache(PLAYER_JOURNEY_AWARD_ITEM)
    local item_obj = ITEM_OBJ_COM:ui_wrap(self, award_item)
    local data = {
      id = v.ItemId,
      count = v.Num,
      cb = function()
        UIMgr:get_ui("itemTip"):ui_show({
          item_id = v.ItemId,
          jump_cb = function()
            self:ui_hide()
          end
        })
      end
    }
    item_obj:set_data(data)
  end
end

return ui
