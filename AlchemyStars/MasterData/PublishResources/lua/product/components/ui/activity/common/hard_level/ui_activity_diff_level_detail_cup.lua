_class("UIActivityDiffLevelDetailCup", UICustomWidget)
UIActivityDiffLevelDetailCup = UIActivityDiffLevelDetailCup

function UIActivityDiffLevelDetailCup:OnShow(uiParam)
  self._descTex = self:GetUIComponent("UILocalizationText", "desc")
  self._awardGo = self:GetGameObject("award")
  self._awardIcon = self:GetUIComponent("RawImageLoader", "awardIcon")
  self._awardCount = self:GetUIComponent("UILocalizationText", "awardCount")
  self._complete = self:GetGameObject("Complete")
  self._uncomplete = self:GetGameObject("UnComplete")
end

function UIActivityDiffLevelDetailCup:SetData(data)
  self._descTex:SetText(data:GetDes())
  local complete = data:IsComplete()
  self._complete:SetActive(complete)
  self._uncomplete:SetActive(not complete)
  if complete then
    self._awardGo:SetActive(false)
  else
    self._awardGo:SetActive(true)
  end
  self._awardIcon:LoadImage(data:GetRewardIcon())
  self._awardCount:SetText(data:GetRewardCount())
end
