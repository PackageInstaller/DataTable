local Instantiate = CS.UnityEngine.GameObject.Instantiate
local CSDestroy = CS.UnityEngine.GameObject.Destroy
local GearItemHiddenAward, Super = System.NewClass("GearItemHiddenAward", GearItemBase)

function GearItemHiddenAward:OnTriggerChild(svrData)
  self:OpenEventPanel(svrData)
end

function GearItemHiddenAward:OnLoad()
  Super.OnLoad(self)
  if self:IsRemoved() then
    return
  end
  self.isVisible = false
  self:SetRenderEnable(false)
  local prefab = ResLoadMgr.LoadAsset("UI/UI_Dbgcopy/UI_Dbgcopy_New/UI_Effects_explore_yty_vx.prefab", self)
  local go = Instantiate(prefab, self.tf)
  self.hideEffectGo = go
  local particleSystem = go:GetComponent(typeof(CS.UnityEngine.ParticleSystem))
  go.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
  if self.timerId then
    TimerManager.Instance:StopTimer(self.timerId)
  end
  self.timerId = TimerManager.Instance:CreateTimer(5, -1, function()
    local mistMgr = self.manager:GetComponent(MapMistManager)
    if not mistMgr then
      TimerManager.Instance:StopTimer(self.timerId)
      return
    end
    if not mistMgr:IsInMist(self:GetGridPos()) and not IsNil(particleSystem) then
      particleSystem:Play()
    end
  end)
end

function GearItemHiddenAward:OnGearClick(...)
  Super.OnGearClick(self, ...)
  self:DisposeEffect()
end

function GearItemHiddenAward:DisposeEffect()
  if self.hideEffectGo then
    CSDestroy(self.hideEffectGo)
    self.hideEffectGo = nil
  end
end

function GearItemHiddenAward:ClearTimer()
  if self.timerId then
    TimerManager.Instance:StopTimer(self.timerId)
    self.timerId = nil
  end
end

function GearItemHiddenAward:OnRemove()
  Super.OnRemove(self)
  self:DisposeEffect()
  self:ClearTimer()
end

function GearItemHiddenAward:Dispose()
  Super.Dispose(self)
  self:DisposeEffect()
  self:ClearTimer()
end

return GearItemHiddenAward
