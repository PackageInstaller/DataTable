_class("UIActivityBattlePassQuestGroupBtn", UICustomWidget)
UIActivityBattlePassQuestGroupBtn = UIActivityBattlePassQuestGroupBtn
local UIActivityBattlePassQuestGroupBtnState = {
  EState_NotStart = 1,
  EState_Normal = 2,
  EState_Over = 3
}
_enum("UIActivityBattlePassQuestGroupBtnState", UIActivityBattlePassQuestGroupBtnState)

function UIActivityBattlePassQuestGroupBtn:_GetComponents()
  self._state_Normal = self:GetGameObject("state_Normal")
  self._state_NotStart = self:GetGameObject("state_NotStart")
  self._state_Over = self:GetGameObject("state_Over")
  self._selected = self:GetGameObject("selected")
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtTitle_Over = self:GetUIComponent("UILocalizationText", "txtTitle_Over")
  self._red = self:GetGameObject("red")
end

function UIActivityBattlePassQuestGroupBtn:SetData(index, campaign, info, callback)
  self._index = index
  self._campaign = campaign
  self._info = info
  self._callback = callback
  self:_GetComponents()
  self:_Refresh()
end

function UIActivityBattlePassQuestGroupBtn:SetSelected(isSel)
  self._selected:SetActive(isSel)
end

function UIActivityBattlePassQuestGroupBtn:OnShow(uiParams)
  self:_AttachEvents()
end

function UIActivityBattlePassQuestGroupBtn:OnHide()
  self:_DetachEvents()
end

function UIActivityBattlePassQuestGroupBtn:_Refresh()
  self._state = self:_CheckState()
  self:_SetState()
  self:_SetTitle()
  self:_CheckRedPointAll()
end

function UIActivityBattlePassQuestGroupBtn:_SetState()
  self._state_Normal:SetActive(self._state ~= UIActivityBattlePassQuestGroupBtnState.EState_Over)
  self._state_NotStart:SetActive(self._state == UIActivityBattlePassQuestGroupBtnState.EState_NotStart)
  self._state_Over:SetActive(self._state == UIActivityBattlePassQuestGroupBtnState.EState_Over)
end

function UIActivityBattlePassQuestGroupBtn:_SetTitle()
  local index2id = {
    "str_activity_battlepass_tab_quest_group_title_1",
    "str_activity_battlepass_tab_quest_group_title_2",
    "str_activity_battlepass_tab_quest_group_title_3"
  }
  self._txtTitle:SetText(StringTable.Get(index2id[self._index]))
  self._txtTitle_Over:SetText(StringTable.Get(index2id[self._index]))
end

function UIActivityBattlePassQuestGroupBtn:_CheckState()
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if curTime < self._info.m_unlock_time then
    return UIActivityBattlePassQuestGroupBtnState.EState_NotStart
  elseif curTime > self._info.m_close_time then
    return UIActivityBattlePassQuestGroupBtnState.EState_Over
  else
    return UIActivityBattlePassQuestGroupBtnState.EState_Normal
  end
end

function UIActivityBattlePassQuestGroupBtn:NormalBtnOnClick()
  Log.info("UIActivityBattlePassQuestGroupBtn:NormalBtnOnClick")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._callback then
    self._callback(self._index)
  end
end

function UIActivityBattlePassQuestGroupBtn:NotStartBtnOnClick()
  Log.info("UIActivityBattlePassQuestGroupBtn:NotStartBtnOnClick")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = self._info.m_unlock_time
  local stamp = endTime - curTime
  if stamp <= 0 then
    self:_Refresh()
    return
  end
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local str = StringTable.Get("str_activity_battlepass_tab_quest_group_notstart", timeStr)
  ToastManager.ShowToast(str)
end

function UIActivityBattlePassQuestGroupBtn:OverBtnOnClick()
  Log.info("UIActivityBattlePassQuestGroupBtn:OverBtnOnClick")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  ToastManager.ShowToast(StringTable.Get("str_activity_battlepass_tab_quest_group_over"))
end

function UIActivityBattlePassQuestGroupBtn:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIActivityBattlePassQuestGroupBtn:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIActivityBattlePassQuestGroupBtn:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIActivityBattlePassQuestGroupBtn:_CheckRedPointAll()
  local index2component = {
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3
  }
  local componentId = index2component[self._index]
  self:_CheckRedPoint(self._red, componentId)
end

function UIActivityBattlePassQuestGroupBtn:_CheckRedPoint(obj, ...)
  local bShow = self._campaign and UIActivityBattlePassHelper.CheckComponentRedPoint(self._campaign, ...)
  obj:SetActive(bShow)
end
