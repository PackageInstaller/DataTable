local GoldenSpyBaseItem = require("Game.UI.Activity.GoldenSpy.GoldenSpyBaseItem")
local GoldenSpySafeBoxItem = class("GoldenSpySafeBoxItem", GoldenSpyBaseItem)
GoldenSpySafeBoxItem._mapNodeConfig = {
  HitArea = {
    sNodeName = "HitArea",
    sComponentName = "RectTransform"
  },
  flash = {}
}
GoldenSpySafeBoxItem._mapEventConfig = {
  GM_GoldenSpy_Show = "OnEvent_GM_GoldenSpy_Show"
}
GoldenSpySafeBoxItem._mapRedDotConfig = {}

function GoldenSpySafeBoxItem:InitData()
  local nWeightMin = self.itemCfg.Params[1]
  local nWeightMax = self.itemCfg.Params[2]
  local nScoreMin = self.itemCfg.Params[3]
  local nScoreMax = self.itemCfg.Params[4]
  self.nWeight = math.random(nWeightMin, nWeightMax)
  self.nScore = math.random(nScoreMin, nScoreMax)
end

function GoldenSpySafeBoxItem:GetWeight()
  return self.nWeight
end

function GoldenSpySafeBoxItem:GetScore()
  return self.nScore
end

function GoldenSpySafeBoxItem:GetHitArea()
  local tr = self.gameObject:GetComponent("RectTransform")
  local hitArea = {
    nType = self.nHitAreaType,
    center = self._mapNode.HitArea.anchoredPosition + tr.anchoredPosition,
    width = self._mapNode.HitArea.sizeDelta.x,
    height = self._mapNode.HitArea.sizeDelta.y
  }
  return hitArea
end

function GoldenSpySafeBoxItem:OnSkill_InVision()
  self.floorCtrl:RemoveItem(self)
  self.gameObject:SetActive(false)
end

function GoldenSpySafeBoxItem:OnSkill_Boom(callback)
  if callback then
    callback()
  end
  if self.gameObject then
    self.gameObject:SetActive(false)
  end
end

function GoldenSpySafeBoxItem:OnSkill_Frozen(callback)
  if callback then
    callback()
  end
end

function GoldenSpySafeBoxItem:OnEvent_GM_GoldenSpy_Show()
  local img = self._mapNode.HitArea:GetComponent("Image")
  if img then
    img.enabled = true
  end
end

return GoldenSpySafeBoxItem
