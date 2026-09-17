local this = class("moduleKiboArenaSimulatorPoint", G_UIModuleBase)

function this.bind()
  return {
    txt_blue = nil,
    txt_red = nil,
    txt_time = nil
  }
end

function this.methods()
  return {}
end

function this:openModules(options)
  if not CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboRingSimulator then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self.onPointChangedHandler = self.onPointChangedHandler or handler(self, self.onPointChanged)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SimulatorPointChange, self.onPointChangedHandler)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SimulatorPointChange, self.onPointChangedHandler)
  self.duelTime = 300
  self.updateHandler = self.updateHandler or handler(self, self.tick)
  self.updateTimer = self.updateTimer or Timer.repeated(0.1, self.updateHandler, self, self.gameObject)
end

function this:onPointChanged(e, v)
  local camp = v:GetObject(0)
  local point = v:GetFloat(1)
  if camp == C_ECampType.Red then
    self.bind.txt_red = tostring(point)
  elseif camp == C_ECampType.Blue then
    self.bind.txt_blue = tostring(point)
  end
end

function this:close()
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SimulatorPointChange, self.onPointChangedHandler)
  if self.updateTimer then
    Timer.remove(self.updateTimer)
  end
end

function this:tick()
  self.leftTime = self.duelTime - math.floor(C_KiboDuelSystemMgr:GetDuelTime())
  self.bind.txt_time = tostring(self.leftTime)
end

function this:refresh()
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
