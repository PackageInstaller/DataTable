_class("UICommonLineMissionAwards", UIController)
UICommonLineMissionAwards = UICommonLineMissionAwards

function UICommonLineMissionAwards:OnShow(uiParams)
  self._questCmpt = uiParams[1]
  self._checkCampaignCloseFunc = uiParams[2]
  self._questsUIPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemTipsPool = self:GetUIComponent("UISelectObjectPath", "assetTips")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._starCountTxt = self:GetUIComponent("UILocalizationText", "starCountTxt")
  self._starCountTitle = self:GetUIComponent("UILocalizationText", "starCountTitle")
  self._starCountTxt:SetText(uiParams[3])
  local campaignID = self._questCmpt:ComponentInfo().m_campaign_id
  self._starCountTitle:SetText(StringTable.Get("str_activity_story_star_" .. campaignID))
  self:RefreshUI()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityClose)
end

function UICommonLineMissionAwards:RefreshUI()
  local questList = self._questCmpt:GetQuestInfo()
  local questUIList = self._questsUIPool:SpawnObjects("UICommonLineMissionAwardsItem", #questList)
  local widgetHeight = 231
  local spacing = 0
  local yComplete = 0
  local yAccepted = 0
  for i = 1, #questUIList do
    questUIList[i]:SetData(self._questCmpt, questList[i], self._checkCampaignCloseFunc)
    local status = questList[i]:Status()
    if status == QuestStatus.QUEST_Completed and yComplete == 0 then
      yComplete = i
    elseif status == QuestStatus.QUEST_Accepted and yAccepted == 0 then
      yAccepted = i
    end
  end
  local y
  if yComplete ~= 0 then
    y = yComplete
  elseif yAccepted ~= 0 then
    y = yAccepted
  else
    y = #questUIList
  end
  local yLength = (y - 1) * (widgetHeight + spacing)
  self._contentRect.anchoredPosition = Vector2(self._contentRect.anchoredPosition.x, yLength)
end

function UICommonLineMissionAwards:CloseBtnOnClick()
  self:CloseDialog()
end

function UICommonLineMissionAwards:BGOnClick()
  self:CloseDialog()
end

function UICommonLineMissionAwards:OnActivityClose(id)
  self:CloseDialog()
end

function UICommonLineMissionAwards:ShowAssetTips(id, pos)
  if not self._assetTips then
    self._assetTips = self._itemTipsPool:SpawnObject("UISelectInfo")
  end
  self._assetTips:SetData(id, pos)
end
