local LinearFsm = System.NewClass("LinearFsm")

function LinearFsm:ctor(owner)
  self.owner = owner
  self.stageFsmList = {}
  self.fsmStep = 0
end

function LinearFsm:Awake()
end

function LinearFsm:OnBind(binder)
  self.binder = binder
  binder:onDestroy(function()
    self:OnDestroy()
  end)
end

function LinearFsm:StartUpdateTimer()
  self.binder:BindTimer(0, -1, System.fn(self, self.UpdateStageFsm), nil)
end

function LinearFsm:AddState(state)
  table.insert(self.stageFsmList, state)
  state:SetParent(self)
end

function LinearFsm:GotoState(stateCls, isForce, ...)
  for i, state in ipairs(self.stageFsmList) do
    if state.__name == stateCls.__name then
      local curFsm = self.stageFsmList[self.fsmStep]
      if curFsm and curFsm:IsEntered() then
        curFsm:Exit()
        curFsm:Reset()
      end
      self.fsmStep = i
      if isForce then
        self.stageFsmList[self.fsmStep]:DoEnter(...)
      else
        self:UpdateStageFsm()
      end
      return
    end
  end
  Logger.Error("状态 %s 不存在", stateCls.__name, debug.traceback())
end

function LinearFsm:GetState(stateCls)
  for i, state in ipairs(self.stageFsmList) do
    if state.__name == stateCls.__name then
      return state
    end
  end
end

function LinearFsm:IsStateEntered(stateCls)
  local state = self:GetState(stateCls)
  return state.isEntered
end

function LinearFsm:UpdateStageFsm()
  local curFsm = self.stageFsmList[self.fsmStep]
  if curFsm and curFsm:IsEntered() then
    if not curFsm:CheckExit() then
      return
    end
    curFsm:Exit()
    Logger.Info("状态 %s 结束", curFsm.__name, debug.traceback())
    self.fsmStep = self.fsmStep + 1
    curFsm:Reset()
  end
  for step = math.max(1, self.fsmStep), #self.stageFsmList do
    local nextFsm = self.stageFsmList[step]
    if not nextFsm:IsValid() then
      Logger.Info("状态 %s 无效跳过", nextFsm.__name, debug.traceback())
      nextFsm:Reset()
      self.fsmStep = step
    else
      if nextFsm:CheckEnter() then
        self.fsmStep = step
        nextFsm:DoEnter()
      end
      break
    end
  end
end

function LinearFsm:OnDestroy()
  for _, fsm in ipairs(self.stageFsmList) do
    fsm:OnDestroy()
  end
end

return LinearFsm
