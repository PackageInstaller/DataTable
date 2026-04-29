_class("UIActivityNPlusSixEventCompleteController", UIController)
UIActivityNPlusSixEventCompleteController = UIActivityNPlusSixEventCompleteController

function UIActivityNPlusSixEventCompleteController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_HALLOWEEN, ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._buildComponentInfo = self._localProcess:GetComponentInfo(ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD)
  local eventInfo = self._buildComponentInfo.event_info
  self._eventCount = #eventInfo.cur_event_list
end

function UIActivityNPlusSixEventCompleteController:OnShow(uiParams)
  self._eventData = uiParams[1]
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._des = self:GetUIComponent("UILocalizationText", "Des")
  self._title:SetText(self._eventData:GetTitle())
  self._des:SetText(StringTable.Get("str_n_plus_six_event_complete_tips", self._eventCount))
  self._contents = self:GetUIComponent("UISelectObjectPath", "Content")
  local rewards = self._eventData:GetRewards()
  self._contents:SpawnObjects("UIActivityNPlusSixEventRewardItem", #rewards)
  local items = self._contents:GetAllSpawnList()
  for i = 1, #items do
    items[i]:Refresh(rewards[i], true)
  end
  self:AttachEvent(GameEventType.NPlusSixShowEventCompleteRewardTips, self.ShowTips)
end

function UIActivityNPlusSixEventCompleteController:OnHide()
  self:DetachEvent(GameEventType.NPlusSixShowEventCompleteRewardTips, self.ShowTips)
end

function UIActivityNPlusSixEventCompleteController:ConfirmBtnOnClick()
  self:CloseDialog()
end

function UIActivityNPlusSixEventCompleteController:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end
