require("collector")
_class("Systems", Object)
Systems = Systems

function Systems:Constructor()
  Log.debug("Systems:Constructor()")
  self._initializeSystems = {}
  self._executeSystems = {}
  self._cleanupSystems = {}
  self._tearDownSystems = {}
  self.IsSystems = true
end

function Systems:Add(system)
  if system.Initialize then
    local sysList = self._initializeSystems
    sysList[#sysList + 1] = system
  end
  if system.Execute then
    local sysList = self._executeSystems
    sysList[#sysList + 1] = system
  end
  if system.Cleanup then
    local sysList = self._cleanupSystems
    sysList[#sysList + 1] = system
  end
  if system.TearDown then
    local sysList = self._tearDownSystems
    sysList[#sysList + 1] = system
  end
  return self
end

function Systems:Initialize()
  local sysList = self._initializeSystems
  for i = 1, #sysList do
    sysList[i]:Initialize()
  end
end

function Systems:Execute()
  local sysList = self._executeSystems
  for i = 1, #sysList do
    local sys = sysList[i]
    sys:Execute()
  end
end

function Systems:Cleanup()
  local sysList = self._cleanupSystems
  for i = 1, #sysList do
    local sys = sysList[i]
    sys:Cleanup()
  end
end

function Systems:TearDown()
  local sysList = self._tearDownSystems
  for i = 1, #sysList do
    sysList[i]:TearDown()
  end
end

function Systems:ActivateReactiveSystems()
  local executeSystems = self._executeSystems
  for i = 1, #executeSystems do
    local sys = executeSystems[i]
    if sys.IsReactiveSystem then
      sys:Activate()
    end
    if sys.IsSystems then
      sys:ActivateReactiveSystems()
    end
  end
end

function Systems:DeactivateReactiveSystems()
  local executeSystems = self._executeSystems
  for i = 1, #executeSystems do
    local sys = executeSystems[i]
    if sys.IsReactiveSystem then
      sys:Deactivate()
    end
    if sys.IsSystems then
      sys:DeactivateReactiveSystems()
    end
  end
end

function Systems:ClearReactiveSystems()
  local executeSystems = self._executeSystems
  for i = 1, #executeSystems do
    local sys = executeSystems[i]
    if sys.IsReactiveSystem then
      sys:Clear()
    end
    if sys.IsSystems then
      sys:ClearReactiveSystems()
    end
  end
end
