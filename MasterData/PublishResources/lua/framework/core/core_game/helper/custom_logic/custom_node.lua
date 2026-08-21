_class("ICustomNode", Object)
ICustomNode = ICustomNode

function ICustomNode:InitializeNode(staticConfig, runtimeContext)
end

function ICustomNode:Activate()
end

function ICustomNode:Deactivate()
end

function ICustomNode:IsActive()
end

_class("CustomNodeContext", Object)
CustomNodeContext = CustomNodeContext

function CustomNodeContext:Constructor(genInfo, rootNode, configMng)
  self.GenInfo = genInfo
  self.Logic = rootNode
  self.ConfigMng = configMng
  self.World = genInfo.World
end

_class("CustomNode", ICustomNode)
CustomNode = CustomNode

function CustomNode:Constructor()
  self.isActive = false
  self.varLibRef = nil
end

function CustomNode:Destroy()
  self:Deactivate()
  self.varLibRef = nil
end

function CustomNode:InitializeNode(cfg, context)
  self.varLibRef = context.Logic.varLibImp
  self.Config = cfg
  self.Logic = context.Logic
end

function CustomNode:Activate()
  self.isActive = true
end

function CustomNode:Deactivate()
  self.isActive = false
end

function CustomNode:IsActive()
  return self.isActive
end

function CustomNode:CollectInterface(interfaceList, funcName)
  if self[funcName] then
    interfaceList:PushBack(self)
  end
end

function CustomNode:CollectInterfaceInChildren(interfaceList, funcName)
end

function CustomNode:Parse(param)
  if not param then
    return nil
  end
  if type(param) == "string" then
    local i, j = string.find(param, "BB#")
    if not j then
      return param
    else
      local bb_key = string.sub(param, j + 1, -1)
      return self.varLibRef[bb_key]
    end
  else
    return param
  end
end

function CustomNode:CloneVarLibRef()
  local cloned = {}
  for k, v in pairs(self.varLibRef) do
    cloned[k] = v
  end
  return cloned
end
