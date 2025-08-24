local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local INPUT_FIELD = UnityEngine.UI.InputField
local DEBUG_SPINE_KEY = "DEBUG_SPINE_KEY"
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local MODEL = {
  v_spine_id_input = {
    "SpineIDInput",
    BIND_TYPE.OBJECT
  },
  v_spine_list = {
    "SpineList",
    BIND_TYPE.OBJECT
  },
  v_spine = {
    "Spine",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_spine_input = Util.get_component(nil, self.v_spine_id_input, INPUT_FIELD)
  self.v_spine_id = nil
  self:set_button("BtnMain", function()
    self:ui_hide()
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("Confirm", function()
    self.v_spine_id = tonumber(self.v_spine_input.text)
    self:refresh()
  end)
  self:set_button("OpenSpinelist", function()
    self.v_spine_list:SetActive(not self.v_spine_list.activeSelf)
  end)
  self:set_button("SpineClick", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  self:register_exist_auto_template(DEBUG_SPINE_KEY, self.v_uiobjects.SpineData, self.v_uiobjects.SpineContent)
end

function ui:refresh()
  if self.v_spine_id then
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_spine)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_spine)
  end
end

function ui:refresh_list()
  self:give_back_auto_cache(DEBUG_SPINE_KEY)
  local spine_id_list = ShareRes.get_spine_cfg()
  for _, info in pairs(spine_id_list) do
    local obj = self:get_auto_cache(DEBUG_SPINE_KEY)
    local text = Util.get_text("SpineInfo", obj)
    local desc = info.Id .. " : " .. info.SpineRes
    text.text = desc
    local btn = Util.get_button(nil, obj)
    self:set_button_listener(btn, function()
      self.v_spine_input.text = info.Id
      self.v_spine_id = info.Id
    end)
  end
end

function ui:ui_on_show()
  self.v_low_update = Global.real_time
  self.v_start_time = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self:refresh_list()
end

function ui:ui_on_hide()
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

return ui
