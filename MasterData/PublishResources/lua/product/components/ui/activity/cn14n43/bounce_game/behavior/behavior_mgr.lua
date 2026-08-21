_class("BehaviorMgr", Object)
BehaviorMgr = BehaviorMgr

function BehaviorMgr:Constructor()
  self._behaviors = {}
end

function BehaviorMgr:GetBehavior(name)
  return self._behaviors[name]
end

function BehaviorMgr:AddBehavior(behavior)
  local name = behavior:Name()
  self._behaviors[name] = behavior
end

function BehaviorMgr:RemoveBehavior(behavior)
  local name = behavior:Name()
  self._behaviors[name] = nil
end

function BehaviorMgr:Show()
  for k, v in pairs(self._behaviors) do
    v:Show()
  end
end

function BehaviorMgr:Reset()
  for k, v in pairs(self._behaviors) do
    v:Reset()
  end
end

function BehaviorMgr:Release()
  for k, v in pairs(self._behaviors) do
    v:Release()
  end
end
