_class("UISeasonMazeScroreRewarditem", UICustomWidget)
UISeasonMazeScroreRewarditem = UISeasonMazeScroreRewarditem

function UISeasonMazeScroreRewarditem:InitWidget()
  self.rewardPool = self:GetUIComponent("UISelectObjectPath", "reward")
  self.progressText = self:GetUIComponent("UILocalizationText", "progress")
  self.canvasGroup = self:GetUIComponent("CanvasGroup", "canvasGroup")
  self.bgselect = self:GetGameObject("bgselect")
  self.mask = self:GetGameObject("mask")
  self.rect = self:GetUIComponent("RectTransform", "root")
end

function UISeasonMazeScroreRewarditem:OnShow()
  self:InitWidget()
end

function UISeasonMazeScroreRewarditem:SetData(roleAssets, progress, state, tips, uictrl)
  self.uictrl = uictrl
  self.state = state
  self.progress = progress
  self.rewardPool:SpawnObjects("UISeasonMazeItem", #roleAssets)
  local spawnList = self.rewardPool:GetAllSpawnList()
  for i = 1, #roleAssets do
    local roleAsset = roleAssets[i]
    local obj = SeasonMazeEffect:New()
    obj.type = SeasonMazeEffectType.SMET_Once
    obj.id = roleAsset.assetid
    obj.value_min = roleAsset.count
    obj.value_max = roleAsset.count
    spawnList[i]:SetData(obj, tips, 1)
  end
  self.progressText:SetText(self.progress)
  if state == CampaignPointProgressStatus.CPPS_Taken then
    self.mask:SetActive(true)
    self.canvasGroup.alpha = 0.3
    self.bgselect:SetActive(false)
  elseif state == CampaignPointProgressStatus.CPPS_Completed then
    self.bgselect:SetActive(true)
    self.mask:SetActive(false)
    self.canvasGroup.alpha = 1
  else
    self.bgselect:SetActive(false)
    self.mask:SetActive(false)
    self.canvasGroup.alpha = 1
  end
end

function UISeasonMazeScroreRewarditem:GetProgress()
  return self.progress
end

function UISeasonMazeScroreRewarditem:SetSelect(progress)
end

function UISeasonMazeScroreRewarditem:BgOnClick()
  self.uictrl:OnRewardProgressSelect(self.progress, self.state)
end

function UISeasonMazeScroreRewarditem:GetBottomPosY()
  return math.abs(self.rect.anchoredPosition.y) + self.rect.sizeDelta.y / 2
end
