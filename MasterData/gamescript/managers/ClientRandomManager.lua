local ClientRandomManager, Super = System.NewClass("ClientRandomManager", Manager)

function ClientRandomManager:ctor()
  Super.ctor(self)
end

function ClientRandomManager:Awake(binder)
  Super.Awake(self)
end

function ClientRandomManager:GetRandomCalculateVerification()
  local addends_1 = math.random(1, 20)
  local addends_2 = math.random(1, 20)
  local sum = addends_1 + addends_2
  return {
    addends_1 = addends_1,
    addends_2 = addends_2,
    sum = sum
  }
end

function ClientRandomManager:OnDestroy()
  Super.OnDestroy(self)
end

return ClientRandomManager
