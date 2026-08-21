_class("UIBattlePassCN1QuestCell", UICustomWidget)
UIBattlePassCN1QuestCell = UIBattlePassCN1QuestCell
local QuestDateType = {QDT_None = 0, QDT_Client_Week = 1}
_enum("QuestDateType", QuestDateType)

function UIBattlePassCN1QuestCell:OnShow(uiParams)
end

function UIBattlePassCN1QuestCell:OnHide()
end

function UIBattlePassCN1QuestCell:SetData(index, campaign, quest, status, componentInfo, clickCallback, tipsCallback)
  self._index = index
  self._campaign = campaign
  self._quest = quest:QuestInfo()
  self._state = status or CampaignQuestStatus.CQS_Over
  self._componentInfo = componentInfo
  self._clickCallback = clickCallback
  self._tipsCallback = tipsCallback
  self._cfgInfo = Cfg.cfg_quest[self._quest.quest_id]
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_Refresh()
end

function UIBattlePassCN1QuestCell:_Refresh()
  self:_SetTitle()
  self:_SetItem()
  self:_SetProgress()
  self:_SetState(self._state)
  self:_SetDaily()
end

function UIBattlePassCN1QuestCell:PlayAnimationInSequence(index)
  local animName, duration = "UIeff_UIBattlePassCN1QuestCell_in1", 367
  local delay = index * 60
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", animName, delay, duration, nil, false)
end

function UIBattlePassCN1QuestCell:_SetTitle()
  local title = StringTable.Get(self._quest.CondDesc)
  UIWidgetHelper.SetLocalizationText(self, "_txt_title", title)
end

function UIBattlePassCN1QuestCell:_SetItem()
  local roleAsset = self._quest.rewards and self._quest.rewards[1]
  UIWidgetHelper.SetLocalizationText(self, "_txt_item", roleAsset.count)
end

function UIBattlePassCN1QuestCell:_GetProgressStyleInfo()
  local tb = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_Progress")
  return tb._txt_prg_Color1.textColor, tb._txt_prg_Color2.textColor
end

function UIBattlePassCN1QuestCell:_SetProgress()
  local text = ""
  local cur, total = self._quest.cur_progress, self._quest.total_progress
  local color1, color2 = self:_GetProgressStyleInfo()
  if self._quest.ShowType == 1 then
    local c, d = math.modf(cur * 100 / total)
    if c < 1 and 0 < d then
      c = 1
    end
    text = c .. "%"
    text = UIActivityHelper.GetColorText(color1, text)
  elseif self._quest.ShowType == 2 then
    if self._quest.status == QuestStatus.QUEST_Accepted then
      text = UIActivityHelper.GetColorText(color1, 0, color2, "/" .. 1)
    else
      text = UIActivityHelper.GetColorText(color1, 1, color2, "/" .. 1)
    end
  else
    text = UIActivityHelper.GetColorText(color1, cur, color2, "/" .. total)
  end
  UIWidgetHelper.SetLocalizationText(self, "_txt_prg", text)
end

function UIBattlePassCN1QuestCell:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [CampaignQuestStatus.CQS_NotStart] = {
      "state_NotStart",
      "_bg_Mask"
    },
    [CampaignQuestStatus.CQS_Accepted] = {
      "state_Accepted"
    },
    [CampaignQuestStatus.CQS_Completed] = {
      "state_Completed"
    },
    [CampaignQuestStatus.CQS_Taken] = {
      "state_Taken",
      "_bg_Mask",
      "_bg_Taken"
    },
    [CampaignQuestStatus.CQS_Over] = {"state_Over", "_bg_Mask"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIBattlePassCN1QuestCell:_GetDailyStyleInfo(widget, state)
  local tb = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_Daily")
  local dateType = self._cfgInfo.DateType or 0
  if dateType == nil or dateType == 0 then
    local convert = {
      _bg_daily = {
        [CampaignQuestStatus.CQS_NotStart] = "_bg_daily_Extra",
        [CampaignQuestStatus.CQS_Accepted] = "_bg_daily_Normal",
        [CampaignQuestStatus.CQS_Completed] = "_bg_daily_Normal",
        [CampaignQuestStatus.CQS_Taken] = "_bg_daily_Extra",
        [CampaignQuestStatus.CQS_Over] = "_bg_daily_Extra"
      },
      _bg_time = {
        [CampaignQuestStatus.CQS_NotStart] = "_bg_time_Extra",
        [CampaignQuestStatus.CQS_Accepted] = "_bg_time_Normal",
        [CampaignQuestStatus.CQS_Completed] = "_bg_time_Normal",
        [CampaignQuestStatus.CQS_Taken] = "_bg_time_Extra",
        [CampaignQuestStatus.CQS_Over] = "_bg_time_Extra"
      }
    }
    return tb[convert[widget][state]]
  elseif dateType == QuestDateType.QDT_Client_Week then
    local convert = {
      _bg_daily = {
        [CampaignQuestStatus.CQS_NotStart] = "_bg_daily_Extra",
        [CampaignQuestStatus.CQS_Accepted] = "_bg_dateType_Normal",
        [CampaignQuestStatus.CQS_Completed] = "_bg_dateType_Normal",
        [CampaignQuestStatus.CQS_Taken] = "_bg_dateType_Normal",
        [CampaignQuestStatus.CQS_Over] = "_bg_daily_Extra"
      },
      _bg_time = {
        [CampaignQuestStatus.CQS_NotStart] = "_bg_time_Extra",
        [CampaignQuestStatus.CQS_Accepted] = "_bg_time_Normal",
        [CampaignQuestStatus.CQS_Completed] = "_bg_time_Normal",
        [CampaignQuestStatus.CQS_Taken] = "_bg_time_Normal",
        [CampaignQuestStatus.CQS_Over] = "_bg_time_Extra"
      }
    }
    return tb[convert[widget][state]]
  end
end

function UIBattlePassCN1QuestCell:_GetStrId(isDailyShow, isDateTypeShow)
  if isDailyShow then
    return {
      [CampaignQuestStatus.CQS_NotStart] = "str_activity_battlepass_n5_task_start_time",
      [CampaignQuestStatus.CQS_Accepted] = "str_activity_battlepass_n5_daily_task",
      [CampaignQuestStatus.CQS_Completed] = "str_activity_battlepass_n5_daily_task",
      [CampaignQuestStatus.CQS_Taken] = "str_activity_battlepass_n5_task_refresh_time",
      [CampaignQuestStatus.CQS_Over] = "str_activity_battlepass_tab_quest_over"
    }
  end
  if isDateTypeShow and self._cfgInfo.DateType == QuestDateType.QDT_Client_Week then
    return {
      [CampaignQuestStatus.CQS_NotStart] = "str_activity_battlepass_n5_task_start_time",
      [CampaignQuestStatus.CQS_Accepted] = "str_common_bp_weekly_task",
      [CampaignQuestStatus.CQS_Completed] = "str_common_bp_weekly_task",
      [CampaignQuestStatus.CQS_Taken] = "str_common_bp_weekly_task",
      [CampaignQuestStatus.CQS_Over] = "str_activity_battlepass_tab_quest_over"
    }
  end
end

function UIBattlePassCN1QuestCell:_SetDaily()
  local questId = self._quest.quest_id
  local timeInfo = self._componentInfo.m_quest_time_param_map[questId]
  local isDailyShow = self._state == CampaignQuestStatus.CQS_NotStart or timeInfo.m_need_daily_reset
  local isDateTypeShow = self:_CheckDateTypeLegal(timeInfo)
  local isShow = isDailyShow or isDateTypeShow
  self:GetGameObject("_dailyTime"):SetActive(isShow)
  if not isShow then
    return
  end
  local strId = self:_GetStrId(isDailyShow, isDateTypeShow)
  local text = StringTable.Get(strId[self._state])
  UIWidgetHelper.SetLocalizationText(self, "_txt_daily", text)
  local widgetName = "_bg_daily"
  local styleInfo = self:_GetDailyStyleInfo(widgetName, self._state)
  UIStyleHelper.FitStyle_Widget(styleInfo, self, widgetName)
  local isShowTime = not isDateTypeShow or self._state ~= CampaignQuestStatus.CQS_Taken
  local endTime = self:_CalcTime()
  self:_SetRemainingTime("_dailyTime", endTime, isShowTime)
  widgetName = "_bg_time"
  styleInfo = self:_GetDailyStyleInfo(widgetName, self._state)
  UIStyleHelper.FitStyle_Widget(styleInfo, self._time, widgetName)
end

function UIBattlePassCN1QuestCell:_CheckDateTypeLegal(timeInfo)
  local isShow = false
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if self._cfgInfo.DateType and self._cfgInfo.DateType == QuestDateType.QDT_Client_Week then
    isShow = true
  end
  return isShow
end

function UIBattlePassCN1QuestCell:_SetRemainingTime(widgetName, endTime, isShowTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  self._time = obj
  local isShow = endTime ~= nil and isShowTime == true
  obj:GetGameObject():SetActive(isShow)
  if not isShow then
    return
  end
  obj:SetCustomTimeStr_Common_2()
  obj:SetData(endTime, nil, nil)
end

function UIBattlePassCN1QuestCell:_CalcTime()
  local questId = self._quest.quest_id
  local timeInfo = self._componentInfo.m_quest_time_param_map[questId]
  local state2time = {
    [CampaignQuestStatus.CQS_NotStart] = timeInfo.m_open_time,
    [CampaignQuestStatus.CQS_Accepted] = timeInfo.m_end_time,
    [CampaignQuestStatus.CQS_Completed] = timeInfo.m_end_time
  }
  if timeInfo.m_need_daily_reset then
    state2time[CampaignQuestStatus.CQS_Taken] = timeInfo.m_end_time
  end
  return state2time[self._state]
end

function UIBattlePassCN1QuestCell:AcceptedBtnOnClick()
  self._module = GameGlobal.GetModule(QuestModule)
  local jumpModule = self._module.uiModule
  if jumpModule == nil then
    Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
    return
  end
  local fromParam = {}
  table.insert(fromParam, QuestType.QT_Daily)
  jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
  local jumpType = self._quest.JumpID
  local jumpParams = self._quest.JumpParam
  jumpModule:SetJumpUIData(jumpType, jumpParams)
  jumpModule:Jump()
end

function UIBattlePassCN1QuestCell:CompletedBtnOnClick()
  if self._clickCallback then
    self._clickCallback(self._quest)
  end
end
