_class("BT", Object)
BT = BT

function BT.GetTime()
  return os.clock()
end

function BT.iskindof(cls, name)
  if cls.__cname == name then
    return true
  end
  if cls.__supers then
    for _, v in ipairs(cls.__supers) do
      local bvalue = BT.iskindof(v, name)
      if bvalue == true then
        return true
      end
    end
  end
  return false
end

function BT.GetWeight(item)
  local item_type = type(item)
  local v = 0
  while true do
    if item_type == "number" then
      v = item
      break
    end
    if item_type == "function" then
      v = item() or 0
      break
    end
    break
  end
  return v
end

BTState = {
  SUCCESS = 1,
  FAILED = 2,
  READY = 3,
  RUNNING = 4
}
_enum("BTState", BTState)
_class("BehaviourTree", Object)
BehaviourTree = BehaviourTree

function BehaviourTree:Constructor(root)
  self.root = root
end

function BehaviourTree:SetOwner(owner)
  self.owner = owner
  if self.root and self.root.SetOwner and type(self.root.SetOwner) then
    self.root:SetOwner(owner)
  end
end

function BehaviourTree:GetOwner()
  return self.owner
end

function BehaviourTree:ForceUpdate()
  self.forceupdate = true
end

function BehaviourTree:Update()
  local sleeptime = self.root:GetTreeSleepTime()
  if not sleeptime or sleeptime == 0 then
    self.root:Visit()
    self.root:SaveStatus()
    self.root:Step()
  end
  self.forceupdate = false
end

function BehaviourTree:Reset()
  self.root:Reset()
end

function BehaviourTree:Stop()
  self.root:Stop()
end

function BehaviourTree:Suspend()
  self.root:Suspend()
end

function BehaviourTree:Restart()
  self.root:Restart()
end

function BehaviourTree:GetSleepTime()
  if self.forceupdate then
    return 0
  end
  return self.root:GetTreeSleepTime()
end

function BehaviourTree:OnEnter()
  self.root:OnEnter()
end

function BehaviourTree:__tostring()
  return self.root:GetTreeString()
end

_class("BehaviourNode", Object)
BehaviourNode = BehaviourNode

function BehaviourNode:Constructor(children)
  self.name = ""
  self.children = children
  self.status = BTState.READY
  self.lastresult = BTState.READY
  self.owner = nil
  if children then
    for i, k in pairs(children) do
      k.parent = self
    end
  end
end

function BehaviourNode:SetOwner(owner)
  self.owner = owner
  if self.children then
    for k, v in pairs(self.children) do
      if v and v.SetOwner and type(v.SetOwner) == "function" then
        v:SetOwner(owner)
      end
    end
  end
end

function BehaviourNode:GetOwner()
  return self.owner
end

function BehaviourNode:DoToParents(fn)
  if self.parent then
    fn(self.parent)
    return self.parent:DoToParents(fn)
  end
end

function BehaviourNode:GetTreeString(indent)
  indent = indent or ""
  local str = string.format("%s%s>%2.2f\n", indent, self:GetString(), self:GetTreeSleepTime() or 0)
  if self.children then
    for k, v in ipairs(self.children) do
      str = str .. v:GetTreeString(indent .. "   >")
    end
  end
  return str
end

function BehaviourNode:DBString()
  return ""
end

function BehaviourNode:Sleep(t)
  self.nextupdatetime = BT.GetTime() + t
end

function BehaviourNode:GetSleepTime()
  if self.status == BTState.RUNNING and not self.children and not BT.iskindof(self, "ConditionNode") then
    if self.nextupdatetime then
      local time_to = self.nextupdatetime - BT.GetTime()
      if time_to < 0 then
        time_to = 0
      end
      return time_to
    end
    return 0
  end
  return nil
end

function BehaviourNode:GetTreeSleepTime()
  local sleeptime
  if self.children then
    for k, v in ipairs(self.children) do
      if v.status == BTState.RUNNING then
        local t = v:GetTreeSleepTime()
        if t and (not sleeptime or sleeptime > t) then
          sleeptime = t
        end
      end
    end
  end
  local my_t = self:GetSleepTime()
  if my_t and (not sleeptime or sleeptime > my_t) then
    sleeptime = my_t
  end
  return sleeptime
end

function BehaviourNode:GetString()
  local str = ""
  if self.status == BTState.RUNNING then
    str = self:DBString()
  end
  return string.format("%s - %s <%s> (%s)", self.name, self.status or "UNKNOWN", self.lastresult or "?", str)
end

function BehaviourNode:Visit()
  self.status = BTState.FAILED
end

function BehaviourNode:SaveStatus()
  self.lastresult = self.status
  if self.children then
    for k, v in pairs(self.children) do
      v:SaveStatus()
    end
  end
end

function BehaviourNode:Step()
  if self.status ~= BTState.RUNNING then
    self:Reset()
  elseif self.children then
    for k, v in ipairs(self.children) do
      v:Step()
    end
  end
end

function BehaviourNode:Reset()
  if self.status ~= BTState.READY then
    self.status = BTState.READY
    if self.children then
      for idx, child in ipairs(self.children) do
        child:Reset()
      end
    end
  end
end

function BehaviourNode:Stop()
  if self.OnStop then
    self:OnStop()
  end
  if self.children then
    for idx, child in ipairs(self.children) do
      child:Stop()
    end
  end
end

function BehaviourNode:Suspend()
  if self.children then
    for k, v in pairs(self.children) do
      v:Suspend()
    end
  end
end

function BehaviourNode:Restart()
  if self.children then
    for k, v in pairs(self.children) do
      v:Restart()
    end
  end
end

function BehaviourNode:OnEnter()
  if self.children then
    for k, v in pairs(self.children) do
      v:OnEnter()
    end
  end
end
