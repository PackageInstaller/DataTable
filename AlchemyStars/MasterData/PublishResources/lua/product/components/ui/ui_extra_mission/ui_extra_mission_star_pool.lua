_class("UIExtraMissionStarPool", UICustomWidget)
UIExtraMissionStarPool = UIExtraMissionStarPool

function UIExtraMissionStarPool:OnShow()
  self._starPool = self:GetUIComponent("UISelectObjectPath", "starPool")
  self._indexTex = self:GetUIComponent("UILocalizationText", "index")
end

function UIExtraMissionStarPool:SetData(extraMissionIndex, stageIndex, starCount)
  self._indexTex:SetText(extraMissionIndex .. "-" .. stageIndex)
  self._starPool:SpawnObjects("UIExtraMissionNodeStar", starCount)
end
