local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Math = require("base.mathx")
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local _clamp = Math.Clamp
local _tinsert = table.insert
local Timer = Global.timer
local LocalStorage = require("utils.localstorage")
local TargetClass = Util.create_child_mt(require("ui.uiobject"))
local TargetItemKey = "ACT_DAILY_TARGET_ITEM_KEY"
local SaticSv = require("ui.widget.static_scroll_view")
local RecordClass = Util.create_child_mt(require("ui.uiobject"))
local RecordItemKey = "ACT_DAILY_RECORD_ITEM_KEY"
local TaskClass = Util.create_child_mt(require("ui.uiobject"))
local TaskItemKey = "ACT_DAILY_TASK_ITEM_KEY"
local TASK_STATE = Config.TASK_STATE
local DAILY_CLICK_BUTTON_KEY = "DAILY_CLICK_BUTTON_KEY"
local SHOOT_TYPE = {RANDOM = 0, ACCURATE = 1}
local TARGET_TYPE = {
  Normal = 1,
  Horizontal = 2,
  Vertical = 3
}
local test_record = {
  {id = 1, count = 10000},
  {id = 5, count = 6666}
}
local selectIndex, shooting_type

function TargetClass:ui_finish_load()
end

function TargetClass:set_data(data)
  local is_invalid = data.is_invalid
  self.v_data = data
  self.v_uiobjects.Ani_Claimed_Break:SetActive(false)
  self.v_uiobjects.Crosshairs:SetActive(false)
  if is_invalid then
    self.v_uiobjects.NotClaimed:SetActive(false)
    self.v_uiobjects.Claimed:SetActive(true)
    self.v_uiobjects.ClaimedView:SetActive(false)
    self.v_uiobjects.Ani_Claimed_In:SetActive(true)
    self.v_uiobjects.Ani_Claimed_Out:SetActive(false)
  else
    self.v_uiobjects.NotClaimed:SetActive(true)
    self.v_uiobjects.Claimed:SetActive(false)
    self.v_uiobjects.Ani_NotClaimed_In:SetActive(true)
    self.v_uiobjects.Ani_NotClaimed_Out:SetActive(false)
    self.v_uiobjects.BirdBreak:SetActive(false)
  end
  local item_toggle = self.v_uicompents.NotClaimedBg_tog
  if data.type ~= TARGET_TYPE.Normal then
    self.v_uiobjects.Qualityimg:SetActive(false)
    self.v_uiobjects.ItemIcon:SetActive(false)
    self.v_uiobjects.BirdGroup:SetActive(true)
    self.v_uiobjects.ItemIconNumText:SetActive(false)
    self.v_uiobjects.ClaimedView:SetActive(false)
    if data.type == TARGET_TYPE.Horizontal then
      self.v_uiobjects.Left:SetActive(true)
      self.v_uiobjects.Up:SetActive(false)
    elseif data.type == TARGET_TYPE.Vertical then
      self.v_uiobjects.Left:SetActive(false)
      self.v_uiobjects.Up:SetActive(true)
    end
  end
  if data.award_id ~= nil then
    self.v_uiobjects.Qualityimg:SetActive(true)
    self.v_uiobjects.ItemIcon:SetActive(true)
    self.v_uiobjects.BirdGroup:SetActive(false)
    self.v_uiobjects.ItemIconNumText:SetActive(true)
    local award_cfg = ShareRes.create("award.award", data.award_id)
    if nil ~= award_cfg then
      local quality = 4 == data.quality and 3 or data.quality
      local item_id = award_cfg.ItemId
      self.v_uiobjects.BirdGroup:SetActive(false)
      local item_path = ShareRes.get_item_icon_path(item_id)
      local item_icon = self.v_uicompents.ItemIcon_img
      local item_quality = self.v_uicompents.Qualityimg_img
      local quality_path = string.format("ActivityDaily1/%s", "ajcj_bg_pz" .. quality)
      local claimed_item = self.v_uicompents.ClaimedItem_img
      ResMgr:load_set_icon(claimed_item, item_path)
      ResMgr:load_set_icon(item_quality, quality_path)
      ResMgr:load_set_icon(item_icon, item_path)
      self.v_uicompents.ClaimedNum_txt.text = award_cfg.Num
      self.v_uicompents.ItemIconNumText_txt.text = award_cfg.Num
    end
  end
  item_toggle.interactable = true
end

function TargetClass:on_clear()
end

function RecordClass:ui_finish_load()
end

function RecordClass:set_data(data)
  if nil ~= data then
    local item_count = data.count
    local item_id = data.id
    self.v_uicompents.RecordName_txt.text = ShareRes.get_item_cfg(item_id).Name
    self.v_uicompents.RecordNum_txt.text = item_count
    local item_icon = self.v_uicompents.RecordItem_img
    local item_path = ShareRes.get_item_icon_path(item_id)
    ResMgr:load_set_icon(item_icon, item_path)
  end
end

function RecordClass:on_clear()
end

function ui:ui_finish_load()
  self.v_activity_id = DailyActMgr:get_shooting_game_info().activity_id
  self.v_shooting_target_list = DailyActMgr:get_shooting_game_info().shooting_target_list
  self.v_daily_act_cfg = ShareRes.create("routine_activity.shooting_game", self.v_activity_id)
  self.v_recording = false
  self.v_task = false
  self.v_shoot_type = SHOOT_TYPE.RANDOM
  self.v_requested_record = false
  self.v_core_award_count = 0
  DailyActMgr:request_shooting_game_record(self.v_activity_id)
  self:set_button("RewardBtn", function()
    if not self.v_recording then
      self.v_uiobjects.RecordingPop:SetActive(true)
      self.v_uiobjects.RecordingCloseBtn:SetActive(true)
      self:refresh_reward_record(self.v_reward_record)
      self.v_recording = not self.v_recording
    else
      self.v_uiobjects.RecordingPop:SetActive(false)
      self.v_recording = not self.v_recording
    end
  end)
  self:set_button("RecordingCloseBtn", function()
    self.v_uiobjects.RecordingPop:SetActive(false)
    self.v_recording = not self.v_recording
    self.v_uiobjects.RecordingCloseBtn:SetActive(false)
  end)
  self:set_button("TodayTaskBtn", function()
    if not self.v_task then
      self.v_uiobjects.TaskPop:SetActive(true)
      self.v_task = not self.v_task
      self.v_uiobjects.CloseBtn:SetActive(true)
    else
      self.v_uiobjects.TaskPop:SetActive(false)
      self.v_task = not self.v_task
    end
  end)
  self:set_button("CloseBtn", function()
    self.v_uiobjects.TaskPop:SetActive(false)
    self.v_task = not self.v_task
    self.v_uiobjects.CloseBtn:SetActive(false)
  end)
  self:set_button("ResetBtn", function()
    self:update_daily_click_button()
    if self.v_shoot_type == SHOOT_TYPE.RANDOM then
      self.v_shoot_type = SHOOT_TYPE.ACCURATE
      self:refresh_shoot_type()
      selectIndex = nil
      self:refresh_select_view(true, nil)
      self:play_flashing_ani()
    else
      self.v_shoot_type = SHOOT_TYPE.RANDOM
      self:refresh_shoot_type()
      selectIndex = nil
      self:refresh_select_view(true, nil)
      self:play_flashing_ani()
    end
  end)
  self.v_uiobjects.RedDot:SetActive(false)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.ListContent, TargetClass, TargetItemKey)
  self.v_record_static_sv = SaticSv:new(self, self.v_uiobjects.RecordContent, RecordClass, RecordItemKey)
  self.v_task_static_sv = SaticSv:new(self, self.v_uiobjects.TaskContent, TaskClass, TaskItemKey)
  self.v_targetObj = self.v_uiobjects.RandomCrosshairs
  self.v_random_rect = self.v_uicompents.PlayBg_rect
  self.v_crosshair_rect = self.v_uicompents.RandomCrosshairs_rect
  local rectX, rectY = self.v_random_rect:GetLocalPositionA3()
  self.v_rectWidth, self.v_rectHeight = self.v_random_rect:GetRectWH()
  self.v_rectBounds = {
    left = rectX - self.v_rectWidth / 2,
    right = rectX + self.v_rectWidth / 2,
    bottom = rectY - self.v_rectHeight / 2,
    top = rectY + self.v_rectHeight / 2
  }
  local crosshairWidth, crosshairHeight = self.v_crosshair_rect:GetRectWH()
  self.v_crosshairHalfWidth = crosshairWidth * 0.5
  self.v_crosshairHalfHeight = crosshairHeight * 0.5
  self.v_moveSpeed = 0.05
  self.v_minDistance = 10
  self.v_targetPos = self:GetRandomPositionInRect()
  self.v_shoot_ani_timer = {}
end

function ui:ui_on_show()
  self:refresh_time_remaining()
  self:refresh_view()
  self:refresh_task_group()
  self:refresh_target_list()
  self:refresh_shoot_button()
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.refresh_shoot_item_view, self)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_group, self)
  self:bind_auto_mq(Const.MSG_ON_DAILY_RESET, self.check_daily_click_button, self)
  self.v_uicompents.Desc_txt.text = self.v_daily_act_cfg.RuleText
end

function ui:ui_on_update()
  if self.v_shoot_type == SHOOT_TYPE.RANDOM then
    local currentX, currentY = self.v_targetObj.transform:GetLocalPositionA3()
    local currentPos = Vec2.New(currentX, currentY)
    if Vec2.Distance(currentPos, self.v_targetPos) < self.v_minDistance then
      self.v_targetPos = self:GetRandomPositionInRect()
    end
    local newPos = CS.UnityEngine.Vector2.Lerp(currentPos, self.v_targetPos, self.v_moveSpeed * 1)
    newPos.x = _clamp(newPos.x, self.v_rectBounds.left, self.v_rectBounds.right)
    newPos.y = _clamp(newPos.y, self.v_rectBounds.bottom, self.v_rectBounds.top)
    self.v_crosshair_rect:SetLocalPositionA(newPos.x, newPos.y)
  end
  self:refresh_time_remaining()
end

function ui:ui_on_hide()
  self.v_static_sv:clear()
  if not UtilTable.is_empty(self.v_shoot_ani_timer) then
    for _, timer in pairs(self.v_shoot_ani_timer) do
      Timer:remove_timer(timer)
    end
    UtilTable.clear_map(self.v_shoot_ani_timer)
  end
end

function ui:ui_on_destroy()
  self.v_static_sv = nil
  self.v_shoot_ani_timer = nil
end

function ui:GetRandomPositionInRect()
  local effectiveLeft = self.v_rectBounds.left + self.v_crosshairHalfWidth
  local effectiveRight = self.v_rectBounds.right - self.v_crosshairHalfWidth
  local effectiveBottom = self.v_rectBounds.bottom + self.v_crosshairHalfHeight
  local effectiveTop = self.v_rectBounds.top - self.v_crosshairHalfHeight
  local x = effectiveLeft + math.random() * (effectiveRight - effectiveLeft)
  local y = effectiveBottom + math.random() * (effectiveTop - effectiveBottom)
  return Vec2.New(x, y)
end

function ui:refresh_view()
  self.v_shoot_type = SHOOT_TYPE.RANDOM
  self.v_uiobjects.TaskPop:SetActive(false)
  self.v_uiobjects.RecordingPop:SetActive(false)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedDot, RedEnum.ACT_DAILY_01_TASK, RedEnum.ACT_DAILY_01)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.ResetRedDot, RedEnum.SHOOTING_GAME_BUTTON, RedEnum.ACT_DAILY_01)
  self.v_uicompents.AllProgress_txt.text = self.v_daily_act_cfg.CoreMaxCount
  self:refresh_core_progress_view()
  self:check_daily_click_button()
  self.v_uiobjects.RecordingPop:SetActive(false)
  self.v_uiobjects.RecordingCloseBtn:SetActive(false)
  self.v_uiobjects.RewardBtn:SetActive(false)
end

function ui:refresh_core_progress_view()
  local item_id = self.v_daily_act_cfg.CoreAwardId
  local item_icon = self.v_uicompents.ProgressItem_img
  local item_path = ShareRes.get_item_icon_path(item_id)
  ResMgr:load_set_icon(item_icon, item_path)
end

function ui:refresh_time_remaining()
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  local remain_time = self.v_parent_panel:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_data.open_time, activity_cfg.SustainTime)
  self.v_uiobjects.LessTime:SetActive(nil ~= remain_time)
  if nil ~= remain_time then
    self.v_uicompents.LessTime_txt.text = remain_time
  end
end

function ui:refresh_shoot_type()
  if self.v_shoot_type == SHOOT_TYPE.RANDOM then
    self.v_uicompents.ShootText_txt.text = "随意射击"
    self.v_uiobjects.RandomCrosshairs:SetActive(true)
    shooting_type = self.v_shoot_type
    self:refresh_shoot_item_view()
  elseif self.v_shoot_type == SHOOT_TYPE.ACCURATE then
    self.v_uicompents.ShootText_txt.text = "精准射击"
    self.v_uiobjects.RandomCrosshairs:SetActive(false)
    shooting_type = self.v_shoot_type
    self:refresh_shoot_item_view()
  end
end

function ui:refresh_target_list()
  self:refresh_shoot_type()
  self.v_shooting_target_list = UtilTable.is_empty(DailyActMgr:get_shooting_game_cache()) and DailyActMgr:get_shooting_game_info().shooting_target_list or DailyActMgr:get_shooting_game_cache().shooting_target_list
  self.v_static_sv:update_list(self.v_shooting_target_list)
  self:play_flashing_ani()
  self:refresh_target_tog()
end

function ui:refresh_shoot_button()
  local ConsumeId = self.v_daily_act_cfg.ConsumeId
  local ConsumeCount = self.v_daily_act_cfg.ConsumeCount
  local AccurateConsumeId = self.v_daily_act_cfg.AccurateConsumeId
  local AccurateConsumeCount = self.v_daily_act_cfg.AccurateConsumeCount
  self.v_allow_shoot = true
  self:set_button("StarBtn", function()
    local possessCount = BagMgr:get_item_num(ConsumeId)
    local accurateCount = BagMgr:get_item_num(AccurateConsumeId)
    if possessCount < ConsumeCount and shooting_type == SHOOT_TYPE.RANDOM then
      Util.show_message_tip(2225)
      return
    elseif accurateCount < AccurateConsumeCount and shooting_type == SHOOT_TYPE.ACCURATE then
      Util.show_message_tip(2225)
      return
    end
    if shooting_type == SHOOT_TYPE.ACCURATE and self.v_allow_shoot then
      if not selectIndex then
        Util.show_message_tip("请选择目标靶")
        return
      end
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_act_bird_shoot_UI_SOUND)
      DailyActMgr:request_activity_shoot(self.v_activity_id, shooting_type, selectIndex)
      self.v_allow_shoot = false
    elseif shooting_type == SHOOT_TYPE.RANDOM and self.v_allow_shoot then
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_act_bird_shoot_UI_SOUND)
      DailyActMgr:request_activity_shoot(self.v_activity_id, shooting_type)
      self.v_allow_shoot = false
    end
    DailyActMgr:request_shooting_game_record(self.v_activity_id)
    selectIndex = nil
  end)
end

function ui:set_allow_shoot()
  self.v_allow_shoot = true
end

function ui:refresh_shoot_item_view()
  local item_id, item_count
  if shooting_type == SHOOT_TYPE.ACCURATE then
    item_id = self.v_daily_act_cfg.AccurateConsumeId
    item_count = self.v_daily_act_cfg.AccurateConsumeCount
  else
    item_id = self.v_daily_act_cfg.ConsumeId
    item_count = self.v_daily_act_cfg.ConsumeCount
  end
  self.v_uicompents.PossessNum_txt.text = BagMgr:get_item_num(item_id)
  self.v_uicompents.DepleteNum_txt.text = item_count
  local item_path = ShareRes.get_item_icon_path(item_id)
  local shoot_item_icon = self.v_uicompents.ShootItem_img
  local possess_item_icon = self.v_uicompents.PossessItem_img
  ResMgr:load_set_icon(shoot_item_icon, item_path)
  ResMgr:load_set_icon(possess_item_icon, item_path)
end

function ui:store_reward_record(award_items)
  self.v_reward_record = award_items
  local core_item_id = self.v_daily_act_cfg.CoreAwardId
  for _, award in pairs(award_items) do
    if award.id == core_item_id then
      self.v_core_award_count = award.count
      goto lbl_17
    end
  end
  ::lbl_17::
  self.v_uicompents.CurrentProgress_txt.text = self.v_core_award_count
end

function ui:refresh_reward_record(award_items)
  if UtilTable.is_empty(award_items) then
    self.v_uiobjects.Empty:SetActive(true)
    self.v_uiobjects.RecordScrollView:SetActive(false)
  else
    self.v_uiobjects.Empty:SetActive(false)
    self.v_uiobjects.RecordScrollView:SetActive(true)
    self:sort_award_items_by_quality(award_items)
    self.v_record_static_sv:update_list(award_items)
  end
  self.v_requested_record = true
end

function ui:refresh_target_tog()
  local items = self.v_static_sv:get_items()
  local first_not_claimed_index
  for i, item in ipairs(items) do
    if item.v_data.is_invalid == false and not first_not_claimed_index then
      item.v_uicompents.NotClaimedBg_tog.isOn = true
      self:refresh_select_view(true, nil)
      first_not_claimed_index = i
    end
    item:set_toggle("NotClaimedBg", function(is_on)
      if is_on then
        self:refresh_select_view(is_on, i)
      end
    end)
  end
end

function ui:refresh_select_view(is_on, index)
  local items = self.v_static_sv:get_items()
  for idx, item in ipairs(items) do
    if shooting_type == SHOOT_TYPE.ACCURATE then
      if is_on and idx == index then
        item.v_uiobjects.Crosshairs:SetActive(true)
        selectIndex = index
        print("selectIndex", selectIndex)
      else
        item.v_uiobjects.Crosshairs:SetActive(false)
      end
    elseif shooting_type == SHOOT_TYPE.RANDOM then
      item.v_uiobjects.Crosshairs:SetActive(false)
      if is_on and idx == index then
        local award_id = self.v_shooting_target_list[index].award_id
        if award_id then
          local item_id = ShareRes.create("award.award", award_id).ItemId
          UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
        end
      end
    end
  end
end

function ui:init_task_list()
  local task_group = {}
  local task_group_cfg = ShareRes.create("routine_activity.shooting_game_task_group")
  local task_list = {}
  for _, v in pairs(task_group_cfg) do
    _tinsert(task_list, v)
  end
  table.sort(task_list, function(a, b)
    return a.TaskPriority <= b.TaskPriority
  end)
  local index = 1
  local not_get_award = false
  for idx, data in pairs(task_list) do
    task_group[index] = {}
    local current_task_id
    local full_complete_count = 0
    local current_task_index
    local total_count = #data.TaskList
    for i, task_id in pairs(data.TaskList) do
      local task_state = TaskMgr:get_task_state(task_id)
      if task_state == TASK_STATE.RECEIVE and nil == current_task_id then
        current_task_id = task_id
        current_task_index = i
      elseif task_state == TASK_STATE.COMPLETE and nil == current_task_id then
        current_task_id = task_id
        current_task_index = i
        not_get_award = true
      elseif task_state == TASK_STATE.GET_REWARD then
        full_complete_count = full_complete_count + 1
      end
    end
    if full_complete_count ~= total_count and current_task_id then
      task_group[index].current_task_index = current_task_index
      task_group[index].complete_count = full_complete_count
      task_group[index].current_task_id = current_task_id
      task_group[index].total_count = total_count
      index = index + 1
    else
      task_group[index] = nil
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.ACT_DAILY_01_TASK, not_get_award)
  return task_group
end

function ui:refresh_task_group()
  local task_group = self:init_task_list()
  if UtilTable.is_empty(task_group) then
    self.v_uiobjects.TaskContent:SetActive(false)
    self.v_uiobjects.TaskEmpty:SetActive(true)
  else
    self.v_uiobjects.TaskEmpty:SetActive(false)
    self.v_uiobjects.TaskContent:SetActive(true)
    self.v_task_static_sv:update_list(task_group)
  end
end

function TaskClass:ui_finish_load()
end

function TaskClass:set_data(data)
  local task_id = data.current_task_id
  local task_state = TaskMgr:get_task_state(task_id)
  local task_cfg = ShareRes.create("condition.task", task_id)
  if not task_cfg then
    return
  end
  local award_group_cfg = ShareRes.create("award.award_group", task_cfg.Award)
  local award_id = ShareRes.create("award.award_group", task_cfg.Award)[1]
  local award_cfg = ShareRes.create("award.award", award_id)
  if nil ~= award_cfg then
    local item_id = award_cfg.ItemId
    local item_path = ShareRes.get_item_icon_path(item_id)
    local item_quality_path = ShareRes.get_item_quality_path(item_id)
    local item_icon = self.v_uicompents.ItemIcon_img
    local item_quality = self.v_uicompents.ItemQuality_img
    ResMgr:load_set_icon(item_icon, item_path)
    ResMgr:load_set_icon(item_quality, item_quality_path)
    self.v_uicompents.ItemNum_txt.text = award_cfg.Num
  end
  if task_state == TASK_STATE.RECEIVE then
    self.v_uiobjects.Finish:SetActive(false)
    self.v_uiobjects.NoFinish:SetActive(true)
  else
    self.v_uiobjects.Finish:SetActive(true)
    self.v_uiobjects.NoFinish:SetActive(false)
  end
  self.v_uicompents.LeftCurrentNum_txt.text = data.current_task_index
  self.v_uicompents.LeftTasktNum_txt.text = data.total_count
  self.v_uicompents.TaskName_txt.text = task_cfg.Desc
  local cur_value, target_value = TaskMgr:get_task_progress_value_by_id(task_id)
  if target_value <= cur_value then
    self.v_uicompents.RightCurrentNum_txt.text = target_value
  else
    self.v_uicompents.RightCurrentNum_txt.text = cur_value
  end
  self.v_uicompents.RightTaskNum_txt.text = target_value
  self:set_button("Finish", function()
    TaskMgr:submit_task(task_id, function()
      UIMgr:try_get_visible_ui("ui_activity_daily1"):refresh_task_group()
      UIMgr:try_get_visible_ui("ui_activity_daily1"):refresh_shoot_type()
    end)
  end)
end

function TaskClass:on_clear()
end

function ui:play_shoot_ani(target_list)
  local items = self.v_static_sv:get_items()
  for i, item in ipairs(items) do
    for idx, target in ipairs(target_list) do
      if i == target.index then
        self.v_uiobjects.RandomCrosshairs:SetActive(false)
        item.v_uiobjects.BirdBreak:SetActive(true)
        item.v_uiobjects.Crosshairs:SetActive(true)
        local timer = Timer:add_timer("target_out_ani", 1.2, function()
          item.v_uiobjects.Crosshairs:SetActive(false)
          item.v_uiobjects.NotClaimed:SetActive(false)
          item.v_uiobjects.Claimed:SetActive(true)
          item.v_uiobjects.ClaimedView:SetActive(self.v_shooting_target_list[i].award_id)
          item.v_uiobjects.Ani_Claimed_Break:SetActive(true)
          self.v_uiobjects.RandomCrosshairs:SetActive(false)
        end)
        _tinsert(self.v_shoot_ani_timer, timer)
      else
        item.v_uiobjects.Crosshairs:SetActive(false)
      end
    end
  end
end

function ui:play_flashing_ani()
  local items = self.v_static_sv:get_items()
  for i, item in ipairs(items) do
    if shooting_type == SHOOT_TYPE.ACCURATE then
      item.v_uiobjects.Fx_BgGlow1:SetActive(true)
    else
      item.v_uiobjects.Fx_BgGlow1:SetActive(false)
    end
  end
end

function ui:update_daily_click_button()
  LocalStorage:save_int(DAILY_CLICK_BUTTON_KEY, Date.server_time(), true)
  RedPointMgr:enable_redpoint(RedEnum.SHOOTING_GAME_BUTTON, false)
end

function ui:check_daily_click_button()
  local last_open_timestamp = LocalStorage:load_int(DAILY_CLICK_BUTTON_KEY, 0, true)
  local is_daily_first = Date.is_daily_first(last_open_timestamp)
  RedPointMgr:enable_redpoint(RedEnum.SHOOTING_GAME_BUTTON, is_daily_first)
end

function ui:sort_award_items_by_quality(items)
  table.sort(items, function(a, b)
    local a_quality = ShareRes.get_item_cfg(a.id).Quality
    local b_quality = ShareRes.get_item_cfg(b.id).Quality
    if a_quality == b_quality then
      return a.id < b.id
    end
    return a_quality >= b_quality
  end)
end

function ui:on_shooting_game_partly_update()
  local ui_activity = UIMgr:try_get_visible_ui("ui_activity")
  local timer = Timer:add_timer("shooting_game_partial_ani", 2.1, function()
    ui_activity:set_full_mask_active(false)
    self:set_allow_shoot()
    self:refresh_target_list()
  end)
  _tinsert(self.v_shoot_ani_timer, timer)
end

function ui:on_shooting_game_update()
  local timer = Timer:add_timer("shooting_game_ani", 2, function()
    self:set_allow_shoot()
    self:refresh_target_list()
  end)
  _tinsert(self.v_shoot_ani_timer, timer)
end

return ui
