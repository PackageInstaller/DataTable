local GoldenSpyBaseTrap = class("GoldenSpyBaseTrap", BaseCtrl)
GoldenSpyBaseTrap._mapNodeConfig = {
  TriggerArea = {
    sNodeName = "TriggerArea",
    sComponentName = "RectTransform"
  }
}
GoldenSpyBaseTrap._mapEventConfig = {
  GM_GoldenSpy_Show = "OnEvent_GM_GoldenSpy_Show"
}
GoldenSpyBaseTrap._mapRedDotConfig = {}

function GoldenSpyBaseTrap:Awake()
end

function GoldenSpyBaseTrap:OnEnable()
end

function GoldenSpyBaseTrap:OnDisable()
end

function GoldenSpyBaseTrap:OnDestroy()
end

function GoldenSpyBaseTrap:Init()
end

function GoldenSpyBaseTrap:SetData(data, floorCtrl)
  self.nTrapId = data.nTrapId
  self.floorCtrl = floorCtrl
  self.trapCfg = ConfigTable.GetData("GoldenSpyObstacle", self.nTrapId)
  if self.trapCfg == nil then
    return
  end
  self:InitData()
end

function GoldenSpyBaseTrap:InitData()
end

function GoldenSpyBaseTrap:StartFloor()
end

function GoldenSpyBaseTrap:GetTriggerArea()
  local triggerArea = {}
  return triggerArea
end

function GoldenSpyBaseTrap:FinishFloor()
end

function GoldenSpyBaseTrap:Pause()
end

function GoldenSpyBaseTrap:Resume()
end

function GoldenSpyBaseTrap:OnSkill_Frozen(callback)
  if callback then
    callback()
  end
end

function GoldenSpyBaseTrap:OnSkill_Frozen_Resume(callback)
  if callback then
    callback()
  end
end

function GoldenSpyBaseTrap:SetHookIsInvincible()
  self.floorCtrl:SetHookIsInvincible(true)
end

function GoldenSpyBaseTrap:OnEvent_GM_GoldenSpy_Show()
  local img = self._mapNode.TriggerArea:GetComponent("Image")
  if img then
    img.enabled = true
  end
end

return GoldenSpyBaseTrap
