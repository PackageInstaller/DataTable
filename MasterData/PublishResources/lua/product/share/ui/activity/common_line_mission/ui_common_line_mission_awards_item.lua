_class("UICommonLineMissionAwardsItem", UICustomWidget)
UICommonLineMissionAwardsItem = UICommonLineMissionAwardsItem

function UICommonLineMissionAwardsItem:OnShow(uiParams)
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._starCount = self:GetUIComponent("UILocalizationText", "starCount")
  self._items = self:GetUIComponent("UISelectObjectPath", "items")
  self._btnCanGet = self:GetGameObject("BtnCanGet")
  self._btnGot = self:GetGameObject("BtnGot")
  self._needStars = self:GetGameObject("needStars")
  self._needStarCount = self:GetUIComponent("UILocalizationText", "needStarCount")
end

function UICommonLineMissionAwardsItem:SetData(questCmpt, quest, checkCampaignCloseFunc)
  self._questCmpt = questCmpt
  self._quest = quest
  self._checkCampaignCloseFunc = checkCampaignCloseFunc
  local questInfo = quest:QuestInfo()
  self._title:SetText(StringTable.Get(questInfo.QuestName))
  self._starCount:SetText(questInfo.total_progress)
  local status = quest:Status()
  if status == QuestStatus.QUEST_Taken then
    self._btnGot:SetActive(true)
    self._btnCanGet:SetActive(false)
    self._needStars:SetActive(false)
  elseif status == QuestStatus.QUEST_Completed then
    self._btnGot:SetActive(false)
    self._btnCanGet:SetActive(true)
    self._needStars:SetActive(false)
  else
    self._btnGot:SetActive(false)
    self._btnCanGet:SetActive(false)
    self._needStars:SetActive(true)
    self._needStarCount:SetText("<color=#ff5555>" .. questInfo.cur_progress .. "</color>/" .. questInfo.total_progress)
  end
  local rewards = questInfo.rewards
  local uiAssets = self._items:SpawnObjects("UIAsset", #rewards)
  for i = 1, #rewards do
    local reward = rewards[i]
    local uiAsset = uiAssets[i]
    local cfgItem = Cfg.cfg_item[reward.assetid]
    local icon = cfgItem.Icon
    local quality = cfgItem.Color
    uiAsset:SetData(reward.assetid)
    uiAsset:SetItemData({
      showBG = true,
      icon = icon,
      text = reward.count,
      quality = quality
    })
    local eventComponent = uiAsset:AddComponent(UIAssetComponentEvent)
    eventComponent:SetClickCallBack(function(go)
      self:ShowTip(reward.assetid, go)
    end)
  end
end

function UICommonLineMissionAwardsItem:ShowTip(id, go)
  self:CallUIMethod("UICommonLineMissionAwards", "ShowAssetTips", id, go.transform.position)
end

function UICommonLineMissionAwardsItem:BtnCanGetOnClick()
  if self._checkCampaignCloseFunc and self._checkCampaignCloseFunc() then
    return
  end
  self:StartTask(self.DoTakeQuest, self)
end

function UICommonLineMissionAwardsItem:DoTakeQuest(TT)
  self:Lock("UICommonLineMissionAwardsItem:DoTakeQuest")
  local res = AsyncRequestRes:New()
  local ret, rewards = self._questCmpt:HandleQuestTake(TT, res, self._quest:ID())
  if res:GetSucc() then
    self:ShowDialog("UIGetItemController", rewards)
    self:CallUIMethod("UICommonLineMissionAwards", "RefreshUI")
  else
    LogWrapper.LogFatal("HandleQuestTake failed, ret:", ret)
  end
  self:UnLock("UICommonLineMissionAwardsItem:DoTakeQuest")
end
