local GoldenSpyBaseItem = class("GoldenSpyBaseItem", BaseCtrl)
GoldenSpyBaseItem._mapNodeConfig = {
  HitArea = {
    sNodeName = "HitArea",
    sComponentName = "RectTransform"
  },
  flash = {}
}
GoldenSpyBaseItem._mapEventConfig = {
  GM_GoldenSpy_Show = "OnEvent_GM_GoldenSpy_Show"
}
GoldenSpyBaseItem._mapRedDotConfig = {}

function GoldenSpyBaseItem:Awake()
  self._mapNode.flash:SetActive(false)
end

function GoldenSpyBaseItem:OnEnable()
end

function GoldenSpyBaseItem:OnDisable()
end

function GoldenSpyBaseItem:OnDestroy()
end

function GoldenSpyBaseItem:Init()
  self.nUid = nil
  self.nItemId = nil
  self.trParent = self.gameObject.transform.parent
  self.bFrozen = false
end

function GoldenSpyBaseItem:SetData(data, floorCtrl, commonConfigId)
  self.nUid = data.nUid
  self.nItemId = data.nItemId
  self.itemCfg = ConfigTable.GetData("GoldenSpyItem", self.nItemId)
  self.nHitAreaType = data.nHitAreaType
  self.floorCtrl = floorCtrl
  self.commonConfigId = commonConfigId
  self.commonCfg = ConfigTable.GetData("GoldenSpyConfig", self.commonConfigId)
  self:InitData()
end

function GoldenSpyBaseItem:InitData()
end

function GoldenSpyBaseItem:GetUid()
  return self.nUid
end

function GoldenSpyBaseItem:GetItemCfg()
  return self.itemCfg
end

function GoldenSpyBaseItem:GetWeight()
  return self.itemCfg.Weight
end

function GoldenSpyBaseItem:GetScore()
  return self.itemCfg.Score
end

function GoldenSpyBaseItem:GetHitArea()
  local hitArea = {}
  return hitArea
end

function GoldenSpyBaseItem:GetParent()
  return self.trParent
end

function GoldenSpyBaseItem:StartFloor()
end

function GoldenSpyBaseItem:FinishFloor()
end

function GoldenSpyBaseItem:Pause()
end

function GoldenSpyBaseItem:Resume()
end

function GoldenSpyBaseItem:OnCapture(callback)
  if callback then
    callback()
  end
end

function GoldenSpyBaseItem:OnSkill_InVision(callback)
end

function GoldenSpyBaseItem:OnSkill_Boom(callback)
  if callback then
    callback()
  end
end

function GoldenSpyBaseItem:OnSkill_Frozen(callback)
  if callback then
    callback()
  end
end

function GoldenSpyBaseItem:OnSkill_Frozen_Resume(callback)
  if callback then
    callback()
  end
end

function GoldenSpyBaseItem:OnEvent_GM_GoldenSpy_Show()
  local img = self._mapNode.HitArea:GetComponent("Image")
  if img then
    img.enabled = true
  end
end

return GoldenSpyBaseItem
