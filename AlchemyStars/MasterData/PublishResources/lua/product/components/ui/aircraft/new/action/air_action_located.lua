_class("AirActionLocated", AirActionBase)
AirActionLocated = AirActionLocated

function AirActionLocated:Constructor(pet, target, floor)
  if target == nil then
    Log.fatal("[AircraftMove] 移动目标点为空")
  end
  self._pet = pet
  if not self._pet:IsAlive() then
    self:Log("星灵已被销毁：", self._pet:TemplateID())
  end
  self._target = target
  self._navMeshAgent = self._pet:NaviMesh()
  self._navMeshAgent.speed = 0.9
  self._navMeshAgent.areaMask = 1 << floor + 2
  self._pet:SetNaviEnable(true)
end

function AirActionLocated:Start()
  self._pet:Anim_Stand()
  self._pet:SetPosition(self._target)
  self._running = false
end

function AirActionLocated:Update(deltaTimeMS)
  if not self._running then
    return
  end
end

function AirActionLocated:IsOver()
  return not self._running
end

function AirActionLocated:Stop()
  self._running = false
end

function AirActionLocated:GetPets()
  return {
    self._pet
  }
end
