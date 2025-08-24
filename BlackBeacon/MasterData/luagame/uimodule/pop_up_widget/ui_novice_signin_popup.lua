local Base = require("uimodule.pop_up_widget.ui_popup_base")
local ui = Util.create_child_mt(Base)
local SpineHelper = require("ui.model_rt_view.spine_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local Char_Helper = require("uimodule.character.char_helper")
local REWARD_STATE = {
  LOCK = 1,
  CAN_SIGN = 2,
  CAN_GET = 3,
  DONE = 4
}

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    Base:manual_close()
  end)
  self:set_button("BtnCloseBg", function()
    Base:manual_close()
  end)
  self:set_button("ShowHeroBtn", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  self.v_novice_days = ShareRes.get_comm_value("NewbieSignInPeriod")
  self.v_sign_objs = {}
  self.v_low_update = Global.real_time
  for i = 1, self.v_novice_days do
    local str = "SigninTem" .. i
    self.v_sign_objs[i] = self.v_uiobjects[str]
  end
end

function ui:ui_on_show(widget_id, param)
  self.v_widget_id = widget_id
  self.v_widget_cfg = ShareRes.get_pop_widget_cfg(widget_id)
  self.v_activity_id = param[1]
  self.v_reward_cfg = ShareRes.create("activity.activity_sign_in", self.v_activity_id)
  self:refresh()
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self.v_auto_receive = param[2] and 1 == param[2]
  self.v_uiobjects.touch_bg:SetActive(self.v_auto_receive)
  if self.v_auto_receive then
    self.v_auto_receive_all_timer = Timer:add_timer(nil, 1, self.receive_all_award, self)
  end
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

function ui:ui_on_hide()
  self:clear_spine_rt()
  if self.v_auto_receive_all_timer then
    Timer:remove_timer(self.v_auto_receive_all_timer)
  end
  if self.v_widget_cfg.DailyRepeatPop then
  else
    PopUpWindowMgr:pop_widget_up(self.v_widget_id)
  end
end

function ui:receive_all_award()
  NoviceMgr:request_all_seven_sign_in(self.v_activity_id, self.v_can_receive_days, function()
    self.v_uiobjects.touch_bg:SetActive(false)
    self:refresh_sign_list()
  end)
end

function ui:refresh()
  if self.v_widget_cfg.EndTime then
    self.v_uiobjects.Time:SetActive(true)
    local time_dur = Date.get_time_stamp_by_scheme_id(self.v_widget_cfg.EndTime) - Date.server_time()
    local days = math.ceil(time_dur / 86400)
    self.v_uicompents.TimeLess_txt.text = string.format("剩余%d天", days)
  else
    self.v_uiobjects.Time:SetActive(false)
  end
  self:refresh_show_role()
  self:refresh_sign_list(true)
end

function ui:refresh_show_role()
  local day_cfg = self:_get_show_role()
  self:clear_spine_rt()
  self.v_spine_id = day_cfg.SpineID
  if self.v_spine_id then
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.ShowHero)
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.ShowHero)
  end
end

function ui:_get_show_role()
  local last_show_buddy_day
  for day = 1, self.v_novice_days do
    local state = NoviceMgr:get_reward_get_state(day)
    local cfg = self.v_reward_cfg[day]
    if cfg.BuddyId then
      if state ~= REWARD_STATE.DONE then
        return cfg
      else
        last_show_buddy_day = cfg
      end
    end
  end
  return last_show_buddy_day
end

function ui:refresh_sign_list(reset_scroll)
  local sign_in_data = NoviceMgr:get_seven_sign_in_data(self.v_activity_id)
  self.v_can_get_index = nil
  self.v_can_receive_days = {}
  for index, obj in ipairs(self.v_sign_objs) do
    local state
    if index > sign_in_data.login_day then
      state = REWARD_STATE.LOCK
    else
      local is_received = sign_in_data.reward_bit >> index - 1 & 1
      state = 1 == is_received and REWARD_STATE.DONE or REWARD_STATE.CAN_GET
    end
    self:_refresh_sign_item(index, obj, state)
  end
  local offset
  if self.v_can_get_index then
    offset = 452 - 254 * self.v_can_get_index
  else
    offset = 0
  end
  if reset_scroll then
    self.v_uicompents.Content_rect:SetAnchoredPositionA(offset, 0)
  end
end

function ui:_refresh_sign_item(index, obj, state)
  local data = ShareRes.create("award.award", self.v_reward_cfg[index].AwardId)
  if not data then
    return
  end
  local Got = self:get_child_gameobj("Content/Got", obj)
  local UnComplete = self:get_child_gameobj("Content/UnComplete", obj)
  local BtnGet = self:get_button("Content/BtnGet", obj)
  local DayNum = self:get_text("Content/Bg/DayNum", obj)
  DayNum.text = "0" .. index
  BtnGet:SetActive(state == REWARD_STATE.CAN_GET)
  self.v_can_get_index = self.v_can_get_index or state == REWARD_STATE.CAN_GET and index
  if state == REWARD_STATE.CAN_GET then
    table.insert(self.v_can_receive_days, index)
  end
  Got:SetActive(state == REWARD_STATE.DONE)
  UnComplete:SetActive(state == REWARD_STATE.LOCK)
  local SoldOut = self:get_child_gameobj("Content/SoldOut", obj)
  SoldOut:SetActive(state == REWARD_STATE.DONE)
  local icon = self:get_image("Content/ItemIcon", obj)
  local item_icon = UtilUI.get_item_icon(data.ItemId)
  ResMgr:load_set_icon(icon, item_icon)
  local char_quality_img = self:get_image("Content/CharQuality", obj)
  if self.v_reward_cfg[index].BuddyId then
    local quality_path = Char_Helper.get_char_icon_quality(self.v_reward_cfg[index].BuddyId, Config.CHAR_QUALITY_TYPE.NAME)
    ResMgr:load_set_icon(char_quality_img, quality_path)
    char_quality_img.gameObject:SetActive(true)
  else
    char_quality_img.gameObject:SetActive(false)
  end
  local itemNum = self:get_text("Content/ItemAmount", obj)
  if data.Num > 0 then
    itemNum.gameObject:SetActive(true)
    itemNum.text = data.Num
  else
    itemNum.gameObject:SetActive(false)
  end
  local RareBg = self:get_child_gameobj("Content/RareBg", obj)
  RareBg:SetActive(self.v_reward_cfg[index].IsSpecial > 0)
  local btn = self:get_button(nil, obj)
  self:set_button_listener(btn, function()
    if state == REWARD_STATE.CAN_GET then
      NoviceMgr:request_seven_sign_in(self.v_reward_cfg[index].Id, self.v_activity_id, index, function()
        self:refresh_sign_list()
      end)
    else
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = data.ItemId,
        is_exist_jump = false,
        jump_cb = function()
          self.v_parent_panel:ui_hide()
        end
      })
    end
  end)
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:pop_up_precondition(param)
  local sign_in_data = NoviceMgr:get_seven_sign_in_data(param)
  if not sign_in_data then
    return false
  end
  local novice_days = ShareRes.get_comm_value("NewbieSignInPeriod")
  for i = 1, novice_days do
    if i > sign_in_data.login_day then
      break
    end
    local is_received = sign_in_data.reward_bit >> i - 1 & 1
    if 0 == is_received then
      return true
    end
  end
  return false
end

return ui
