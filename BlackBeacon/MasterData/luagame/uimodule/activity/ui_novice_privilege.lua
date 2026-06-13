local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")

function ui:ui_finish_load()
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.BtnStrengthRedPoint, RedEnum.GIVE_ENERGY_VALUE, RedEnum.NOVICE_PRIVILEGE)
  self:set_button("BtnStrengthOn", function()
    self:on_receive_click()
  end)
  self.v_btn_receive = self:get_button("BtnRecive_", self.v_uiobjects.Privilege1)
  self.v_btn_receive_effect1 = self:get_child_gameobj("BtnRecive_/Fx_IconBg", self.v_uiobjects.Privilege1)
  self.v_btn_receive_effect2 = self:get_child_gameobj("BtnRecive_/Fx_IconBg (1)", self.v_uiobjects.Privilege1)
  self.v_time_obj = self:get_child_gameobj("BtnRecive_/Time_", self.v_uiobjects.Privilege1)
  self.v_time_text = self:get_text("BtnRecive_/Time_/Text", self.v_uiobjects.Privilege1)
  self.v_award_num_bg_obj = self:get_child_gameobj("BtnRecive_/AwardNumBg_", self.v_uiobjects.Privilege1)
  self.v_award_num_text = self:get_text("BtnRecive_/AwardNumBg_/AwardNum_", self.v_uiobjects.Privilege1)
  self:set_button_listener(self.v_btn_receive, function()
    self:on_receive_click()
  end)
  self:set_button("BtnStrengthOff", function()
    NewbieTowerMgr:check_in_get_give_energy_value(self.v_give_energy_value_privilege_cfg.Id, true)
  end)
  self.v_privilege_cfgs = ShareRes.get_all_privilege_cfg()
  self.v_privilege_list = {
    self.v_uiobjects.Privilege1,
    self.v_uiobjects.Privilege2,
    self.v_uiobjects.Privilege3,
    self.v_uiobjects.Privilege4
  }
  self:set_button("ShowHeroBtn", function()
    self:play_spine_anim()
  end)
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  self.v_activity_cfg = ShareRes.get_activity_cfg(activity_id)
  self:refresh()
  self:set_refresh_timer()
  self.v_low_update = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
end

function ui:ui_on_hide()
  if self.v_refresh_timer then
    Timer:remove_timer(self.v_refresh_timer)
    self.v_refresh_timer = nil
  end
  self:clear_spine_rt()
end

function ui:on_receive_click()
  if self.v_give_energy_value_privilege_cfg and NewbieTowerMgr:check_in_get_give_energy_value(self.v_give_energy_value_privilege_cfg.Id, true) then
    local function cb()
      self:refresh()
      
      self:refresh_left_time()
      self:play_spine_anim()
    end
    
    NewbieTowerMgr:req_get_privilege_award(self.v_give_energy_value_privilege_cfg.Id, cb)
  end
end

function ui:play_spine_anim()
  if self.v_anim_data.record_data.play_start then
    if self.v_anim_data.record_data.play_interrupt then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  else
    SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
  end
end

function ui:set_refresh_timer()
  self:refresh_left_time()
  local in_time = self.v_left_time <= 0
  if in_time then
    local server_time = Date.server_time()
    local diff = self.v_end_timestamp - server_time + 1
    if diff > 0 then
      self.v_refresh_timer = Timer:add_timer("refresh_privilege", diff, function()
        self:refresh()
        self.v_refresh_timer = nil
        self:refresh_left_time()
      end)
    end
  end
end

function ui:refresh_left_time()
  local cfg = self.v_give_energy_value_privilege_cfg
  local last_receive_time = NewbieTowerMgr:get_privilege_last_reward_time(cfg.Id)
  local time_table = {}
  for index = 3, #cfg.Arg do
    table.insert(time_table, cfg.Arg[index])
  end
  self.v_left_time, self.v_end_timestamp = Date.get_left_time(time_table, last_receive_time)
  self:refresh_award_state()
end

function ui:refresh()
  self:refresh_privilege()
end

function ui:refresh_privilege()
  for index, privilege_cfg in ipairs(self.v_privilege_cfgs) do
    if privilege_cfg.IsOn and privilege_cfg.IsOn > 0 then
      self:set_privilege(self.v_privilege_list[index], privilege_cfg)
    end
  end
end

function ui:set_privilege(obj, privilege_cfg)
  local btn_panel = self:get_child_gameobj("BtnPanel_", obj)
  local btn_detail = self:get_button("BtnDetail_", btn_panel)
  local btn_jump = self:get_button("BtnJump_", btn_panel)
  if privilege_cfg.ButtonFuncType == Config.PRIVILEGE_BUTTON_TYPE.NOT_ACTIVE then
    btn_panel:SetActive(false)
  elseif privilege_cfg.ButtonFuncType == Config.PRIVILEGE_BUTTON_TYPE.SHOW_TIPS then
    btn_detail.gameObject:SetActive(true)
    btn_jump.gameObject:SetActive(false)
    self:set_button_listener(btn_detail, function()
      if not Util.is_empty(privilege_cfg.Param) then
        local ui_name = Global.uiconfig.prefab_to_ui[privilege_cfg.Param]
        if ui_name then
          local pop_ui = UIMgr:get_ui(ui_name)
          if pop_ui then
            pop_ui:ui_show(self.v_activity_id)
            pop_ui.v_privilege_id = privilege_cfg.Id
          else
            Log.Error("特权弹窗失败, id:", privilege_cfg.Id, privilege_cfg.Param)
          end
        else
          Log.Error("特权弹窗失败, id:", privilege_cfg.Id, privilege_cfg.Param)
        end
      end
    end)
  elseif privilege_cfg.ButtonFuncType == Config.PRIVILEGE_BUTTON_TYPE.JUMP then
    btn_detail.gameObject:SetActive(false)
    btn_jump.gameObject:SetActive(true)
    self:set_button_listener(btn_jump, function()
      if not Util.is_empty(privilege_cfg.Param) then
        SysOpenMgr:jump_to_sys(tonumber(privilege_cfg.Param), true)
      end
    end)
  end
  if privilege_cfg.Type == Config.PRIVILEGE_TYPE.GIVE_ENERGY_VALUE then
    self.v_give_energy_value_privilege_cfg = privilege_cfg
    self:refresh_get_award_state(privilege_cfg)
  end
  local title = self:get_text("Info_/Title_", obj)
  title.text = privilege_cfg.Name
  local desc = self:get_text("Desc_", obj)
  desc.text = privilege_cfg.Desc
end

function ui:refresh_get_award_state(privilege_cfg)
  self.v_award_num_text.text = privilege_cfg.Arg[2]
  if NewbieTowerMgr:check_in_get_give_energy_value(privilege_cfg.Id) then
    self:set_btn_strength_on(true)
    return
  end
  self:set_btn_strength_on(false)
end

function ui:set_btn_strength_on(is_on)
  RedPointMgr:enable_redpoint(RedEnum.GIVE_ENERGY_VALUE, is_on)
  self.v_uiobjects.BtnStrengthOn:SetActive(is_on)
  self.v_uicompents.BtnStrengthOff_btn.enabled = not is_on
  local spine_id
  if is_on then
    spine_id = ShareRes.get_newbie_privilege()[1].CanGetSpineID
  else
    spine_id = ShareRes.get_newbie_privilege()[1].NoGetSpineID
  end
  if spine_id and spine_id ~= self.v_spine_id then
    self.v_spine_id = spine_id
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.ShowHero)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.ShowHero)
  end
end

function ui:ui_on_update()
  self:refresh_time_remaining()
  self:refresh_award_timer()
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

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:clear_spine_rt()
  self.v_spine_id = nil
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:refresh_award_state()
  local is_received = self.v_left_time > 0
  Util.apply_grey_ex(self.v_btn_receive, is_received)
  self.v_btn_receive_effect1:SetActive(not is_received)
  self.v_btn_receive_effect2:SetActive(not is_received)
  self.v_time_obj:SetActive(is_received)
  self.v_award_num_bg_obj:SetActive(not is_received)
  if self.v_left_time > 0 then
    self.v_finish_time = Date.server_time() + self.v_left_time
  else
    self.v_finish_time = nil
  end
end

function ui:refresh_award_timer()
  if not (self.v_finish_time and self.v_left_time) or self.v_left_time <= 0 then
    return
  end
  if Date.server_time() >= self.v_finish_time then
    self.v_left_time = -1
    self.v_finish_time = nil
    self:refresh_award_state()
    self:clear_spine_rt()
    self:refresh()
    self.v_refresh_timer = nil
    return
  end
  local desc = Date.get_time_formate_4(self.v_finish_time - Date.server_time(), true)
  self.v_time_text.text = desc
end

function ui:refresh_time_remaining()
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  local remain_time = self.v_parent_panel:get_time_remaining(self.v_activity_cfg.TimeType, self.v_activity_cfg.StopTime, activity_data.open_time, self.v_activity_cfg.SustainTime)
  if remain_time then
    self.v_uicompents.LimitTimeNum_txt.text = remain_time
  end
end

return ui
