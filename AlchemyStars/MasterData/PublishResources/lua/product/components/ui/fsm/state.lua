_class("State", Object)
State = State

function State:Constructor(enumValue)
  self.EnumValue = enumValue
end

function State:OnEnter(TT, ...)
end

function State:OnExit(TT)
end

function State:OnUpdate(deltaTimeMS)
end

function State:Destroy()
  self.fsm = nil
end

function State.CreateInstance(className, enum)
  local cls = _G[className]
  if not cls then
    Log.error("### no class : ", className)
  end
  if not cls.New then
    Log.error("### no New in class : ", className)
  end
  local s = cls:New(enum)
  return s
end

function State:SetFsm(fsm)
  self.fsm = fsm
end

function State:GetFsm()
  return self.fsm
end

function State:ChangeState(enumValue, ...)
  self.fsm:ChangeState(enumValue, ...)
end
