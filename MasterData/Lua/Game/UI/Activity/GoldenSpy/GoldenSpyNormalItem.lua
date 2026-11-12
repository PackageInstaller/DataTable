local GoldenSpyBaseItem = require("Game.UI.Activity.GoldenSpy.GoldenSpyBaseItem")
local GoldenSpyNormalItem = class("GoldenSpyNormalItem", GoldenSpyBaseItem)
GoldenSpyNormalItem._mapNodeConfig = {
  HitArea = {
    sNodeName = "HitArea",
    sComponentName = "RectTransform"
  },
  flash = {}
}
GoldenSpyNormalItem._mapEventConfig = {
  GM_GoldenSpy_Show = "OnEvent_GM_GoldenSpy_Show",
  GoldenSpy_ItemUpdateScore = "OnEvent_GoldenSpy_ItemUpdateScore"
}
GoldenSpyNormalItem._mapRedDotConfig = {}

function GoldenSpyNormalItem:InitData()
  local nScore = self.itemCfg.Score
  for _, v in ipairs(self.floorCtrl.levelCtrl.GoldenSpyLevelData:GetBuffData()) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddScore and buffCfg.Params[1] == self.itemCfg.ItemType and self.floorCtrl.levelCtrl.GoldenSpyLevelData:CheckBuffActive(v) then
      nScore = nScore + buffCfg.Params[2]
    end
  end
  self:InitFlash(nScore)
end

function GoldenSpyNormalItem:InitFlash(nScore)
  if self.itemCfg.NeedShowFlash == false then
    return
  end
  self._mapNode.flash:SetActive(nScore >= self.commonCfg.HighValueEffect)
end

function GoldenSpyNormalItem:GetHitArea()
  local tr = self.gameObject:GetComponent("RectTransform")
  local hitArea = {
    nType = self.nHitAreaType,
    center = self._mapNode.HitArea.anchoredPosition + tr.anchoredPosition,
    width = self._mapNode.HitArea.sizeDelta.x,
    height = self._mapNode.HitArea.sizeDelta.y
  }
  return hitArea
end

function GoldenSpyNormalItem:OnSkill_InVision()
  self.floorCtrl:RemoveItem(self)
  self.gameObject:SetActive(false)
end

function GoldenSpyNormalItem:OnSkill_Boom(callback)
  if callback then
    callback()
  end
  if self.gameObject then
    self.gameObject:SetActive(false)
  end
end

function GoldenSpyNormalItem:OnSkill_Frozen(callback)
  if callback then
    callback()
  end
end

function GoldenSpyNormalItem:OnEvent_GoldenSpy_ItemUpdateScore(tbBuff)
  if self.gameObject.activeSelf == false then
    return
  end
  local nScore = self.itemCfg.Score
  for _, v in ipairs(tbBuff) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddScore and buffCfg.Params[1] == self.itemCfg.ItemType and self.floorCtrl.levelCtrl.GoldenSpyLevelData:CheckBuffActive(v) then
      nScore = nScore + buffCfg.Params[2]
    end
  end
  self:InitFlash(nScore)
end

function GoldenSpyNormalItem:OnEvent_GM_GoldenSpy_Show()
  local img = self._mapNode.HitArea:GetComponent("Image")
  if img then
    img.enabled = true
  end
end

return GoldenSpyNormalItem
