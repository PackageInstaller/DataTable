require("custom_node_static")
require("custom_node")

function CustomNodeConfigStatic.Check_CustomLogicCfg(nodeCfg)
  if nodeCfg.Type and nodeCfg.ID and nodeCfg.Nodes then
    return true
  end
  return false
end

CustomNodeConfigStatic.AddChecker("CustomLogic", CustomNodeConfigStatic.Check_CustomLogicCfg)
_class("CustomLogic", CustomNode)
CustomLogic = CustomLogic

function CustomLogic:Constructor()
  self.InstanceID = -1
  self.nodes = ArrayList:New()
  self.genInfo = nil
  self.varLibImp = {}
  self:RegisterOutsideEvent()
end

function CustomLogic:InitializeNode(cfg, context)
  CustomLogic.super.InitializeNode(self, cfg, context)
  self.genInfo = context.GenInfo
  local usedTempLogicSet = {}
  self:InitializeCheckTemplete(cfg, context, usedTempLogicSet)
end

function CustomLogic:InitializeCheckTemplete(cfg, context, usedTempLogicSet)
  local nodeCfgList = cfg.Nodes
  for i = 1, #nodeCfgList do
    while true do
      local nodeCfg = nodeCfgList[i]
      local templeteID = nodeCfg.LogicTemplete
      if templeteID then
        if usedTempLogicSet[templeteID] then
          break
        end
        usedTempLogicSet[templeteID] = true
        local logiccfg = context.ConfigMng[templeteID]
        if logiccfg then
          self:InitializeCheckTemplete(logiccfg, context, usedTempLogicSet)
          break
        end
        Log.fatal("ERROR: CustomLogic模板找不到 RootLogicID=" .. self.genInfo.ConfigID .. ", templeteID=" .. templeteID)
        break
      end
      local theNode = self:CreateNode(nodeCfg, context)
      theNode:Activate()
      self:AddNode(theNode)
      break
    end
  end
end

function CustomLogic:Destroy()
  local nodes = self.nodes
  for i = 1, nodes:Size() do
    nodes:GetAt(i):Destroy()
  end
  self.nodes:Clear()
  self:ClearInterfaceCache()
  self.varLibImp = nil
  CustomLogic.super.Destroy(self)
end

function CustomLogic:Activate()
  CustomLogic.super.Activate(self)
  local nodes = self.nodes
  for i = 1, nodes:Size() do
    nodes:GetAt(i):Activate()
  end
end

function CustomLogic:Deactivate()
  CustomLogic.super.Deactivate(self)
  local nodes = self.nodes
  for i = 1, nodes:Size() do
    nodes:GetAt(i):Deactivate()
  end
end

function CustomLogic:CollectInterfaceInChildren(interfaceList, funcName)
  local nodes = self.nodes
  for i = 1, nodes:Size() do
    local node = nodes:GetAt(i)
    CustomNodeStatic.TraverseCollectInterface(interfaceList, funcName, node)
  end
end

function CustomLogic:AddNode(node)
  self.nodes:PushBack(node)
  self:CacheInterface(node)
end

function CustomLogic:CacheInterface(node)
  if node.Update then
    self.Nodes_NeedUpdate:PushBack(node)
  end
  CustomNodeStatic.TraverseCollectInterface(self.Nodes_NeedStopCheck, "CanStop", node)
end

function CustomLogic:ClearInterfaceCache(node)
  self.Nodes_NeedUpdate:Clear()
  self.Nodes_NeedStopCheck:Clear()
end

function CustomLogic:RegisterOutsideEvent()
  self.Nodes_NeedUpdate = ArrayList:New()
  self.Nodes_NeedStopCheck = ArrayList:New()
end

function CustomLogic:Update(dt)
  local nodelist = self.Nodes_NeedUpdate
  for i = 1, nodelist:Size() do
    local node = nodelist:GetAt(i)
    if node and node:IsActive() then
      node:Update(dt)
    end
  end
end

function CustomLogic:CanStop()
  local nodelist = self.Nodes_NeedStopCheck
  for i = 1, nodelist:Size() do
    local node = nodelist:GetAt(i)
    if node and node:IsActive() and not node:CanStop() then
      return false
    end
  end
  return true
end

function CustomLogic:CreateNode(nodeCfg, context)
  if not Classes[nodeCfg.Type] then
    Log.warn("CustomLogic:CreateNode unknown type:", nodeCfg.Type)
    return nil
  end
  local node = Classes[nodeCfg.Type]:New()
  node:InitializeNode(nodeCfg, context)
  return node
end
