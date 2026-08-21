local EnumAIGenInfo = {
  Base = 0,
  Monster = 1,
  AiConfig = 2
}
_enum("EnumAIGenInfo", EnumAIGenInfo)
_class("AIGenInfoBase", Object)
AIGenInfoBase = AIGenInfoBase

function AIGenInfoBase:Constructor(world, ownerEntity)
  self.m_world = world
  self.OwnerEntity = ownerEntity
  self._configService = self.m_world:GetService("Config")
  self.CustomLogicConfigTable = AILogicConfig
  self.CustomLogicConfigID = 0
  self.m_listAiSkill = {}
end

function AIGenInfoBase:GetSkillList()
  return self.m_listAiSkill
end

function AIGenInfoBase:SetSkillList(skillList)
  self.m_listAiSkill = skillList
end

function AIGenInfoBase:GetLogicType()
  return self.m_nAiLogicType
end

function AIGenInfoBase:GetGenInfoType()
  return EnumAIGenInfo.Base
end

_class("AIGenInfo", AIGenInfoBase)
AIGenInfo = AIGenInfo

function AIGenInfo:Constructor(world, ownerEntity, configID, monsterID, aiLogicType)
  self.CustomLogicConfigID = configID
  self.m_listAiSkill = self:_InitSkillList(monsterID)
  self.m_nAiLogicType = aiLogicType
end

function AIGenInfo:GetGenInfoType()
  return EnumAIGenInfo.Monster
end

function AIGenInfo:_InitSkillList(nWorkID)
  local monsterID = nWorkID
  monsterID = monsterID or self.OwnerEntity:MonsterID():GetMonsterID()
  local listReturn = {}
  if 0 < monsterID then
    local monsterConfig = self._configService:GetMonsterConfigData()
    listReturn = monsterConfig:GetMonsterSkillIDs(monsterID)
  end
  return listReturn
end

_class("AIGenInfoByConfig", AIGenInfoBase)
AIGenInfoByConfig = AIGenInfoByConfig

function AIGenInfoByConfig:Constructor(world, ownerEntity, nConfigAiKey)
  local aiConfigData = self._configService:GetAiConfigData():GetAiObject(nConfigAiKey)
  self.CustomLogicConfigID = aiConfigData.m_nLogicID
  self._configAiData = aiConfigData
  self.m_listAiSkill = self._configAiData.m_listSkillID
end

function AIGenInfoByConfig:GetGenInfoType()
  return EnumAIGenInfo.AiConfig
end

function AIGenInfoByConfig:GetLogicID()
  return self._configAiData.m_nLogicID
end

function AIGenInfoByConfig:GetLogicType()
  return self._configAiData.m_nLogicType
end

function AIGenInfoByConfig:GetLogicOrder()
  return self._configAiData.m_nLogicOrder
end

function AIGenInfoByConfig:IsPreview()
  return self._configAiData.m_bPreview
end

function AIGenInfoByConfig:GetSkillList()
  return self._configAiData.m_listSkillID
end

function AIGenInfoByConfig:GetExtParam()
  return self._configAiData.m_extParam
end

require("ai_node_new")
_class("AILogicNode", AINewNode)
AILogicNode = AILogicNode

function AILogicNode:Constructor()
  self.InstanceID = -1
  self.GenInfo = nil
  self.m_vecSonNodes = ArrayList:New()
  self.m_mapActionList = {}
  self.m_actionTree = AIActiveTree:New()
  self.m_actionEnd = nil
  self.m_curAiNode = nil
  self.m_curAiNodeStatus = AINewNodeStatus.Success
  self.CustomLogicID = 0
  self.CustomLogicType = ""
  self.m_bCancelLogic = false
  self._parallelID = nil
  self._orderWeight = BattleConst.AIOrderDefaultWeight
  self._myLogicOrder = nil
end

function AILogicNode:SetMyOrder(order)
  self._myLogicOrder = order
end

function AILogicNode:GetLogicOrder()
  return self._myLogicOrder
end

function AILogicNode:SetParallelID(id)
  self._parallelID = id
end

function AILogicNode:RestParallelID()
  self._parallelID = nil
end

function AILogicNode:GetOrderWeight()
  return self._orderWeight
end

function AILogicNode:SetOrderWeight(weight)
  self._orderWeight = weight
end

function AILogicNode:ResetOrderWeight()
  self._orderWeight = BattleConst.AIOrderDefaultWeight
end

function AILogicNode:GetAIConfigID()
  return self.CustomLogicID
end

function AILogicNode:_CreateLogicNode(nSonNodeID, context)
  local cfgSonNode = context.ConfigMng[nSonNodeID]
  local sonNode = Classes[cfgSonNode.Type]:New()
  if sonNode._className == "AILogicNode" then
    sonNode:InitializeNode(cfgSonNode, context, self)
  else
    sonNode:InitializeNode(cfgSonNode, context, self, cfgSonNode.Data)
  end
  return sonNode
end

function AILogicNode:_CreateActionNode(cfgAction, context)
  local logicWorker = Classes[cfgAction.Type]:New()
  logicWorker:InitializeNode(cfgAction, context, self, cfgAction.Data)
  return logicWorker
end

function AILogicNode:_FindSonNode(nSonNodeID)
  local vecSonNode = self.m_vecSonNodes
  for i = 1, vecSonNode:Size() do
    local sonNode = vecSonNode:GetAt(i)
    if sonNode.CustomLogicID == nSonNodeID then
      return sonNode
    end
  end
  return nil
end

function AILogicNode:_FindSonNodeByClassName(stClassName)
  local mapSonNode = self.m_mapActionList
  for key, value in pairs(mapSonNode) do
    if key == stClassName then
      return value
    end
  end
  return nil
end

function AILogicNode:_FindSonNodeByID(nLogicID)
  local mapSonNode = self.m_mapActionList
  for key, value in pairs(mapSonNode) do
    if value.CustomLogicID == nLogicID then
      return value
    end
  end
  return nil
end

function AILogicNode:_CreateNode_2(configNode, context)
  local newNode
  local stClassName = configNode.Type
  if type(stClassName) == "number" then
    local nSonNodeID = stClassName
    local cfgSonNode = context.ConfigMng[nSonNodeID]
    if not Classes[stClassName] then
      Log.exception("不存在的节点类型：", tostring(stClassName))
      return
    end
    newNode = Classes[stClassName]:New()
    newNode:InitializeNode(cfgSonNode, context, self)
  else
    if not Classes[stClassName] then
      Log.exception("不存在的节点类型：", tostring(stClassName))
      return
    end
    newNode = Classes[stClassName]:New()
    newNode:InitializeNode(configNode, context, self, configNode.Data)
  end
  return newNode
end

function AILogicNode:_FindActionNode(cfgActionNode, context)
  local stClassName = cfgActionNode.Type
  local actionNode = self:_FindSonNodeByClassName(stClassName)
  if nil == actionNode then
    actionNode = self:_CreateNode_2(cfgActionNode, context)
    self.m_mapActionList[stClassName] = actionNode
  end
  return actionNode
end

function AILogicNode:_InitAction(actionTreeNode, nAddType, cfgAction, nLogicID, context)
  if nil == nLogicID or 0 == nLogicID or nil == cfgAction then
    return
  end
  local cfgActionNode = cfgAction[nLogicID]
  if nil == cfgActionNode then
    return
  end
  local nParentLogicID = 0
  if actionTreeNode then
    nParentLogicID = actionTreeNode:GetLogicID()
  end
  local actionNode = self:_FindActionNode(cfgActionNode, context)
  actionNode:SetTreeID(nLogicID)
  local newTreeNode = self.m_actionTree:AddNode(actionTreeNode, nAddType, actionNode, nLogicID, cfgActionNode.Data)
  if newTreeNode:IsHaveInit() then
    return
  end
  if cfgActionNode.success and 0 < cfgActionNode.success and cfgActionNode.success < 2000000000 then
    self:_InitAction(newTreeNode, AIActiveAddType.Success, cfgAction, cfgActionNode.success, context)
  end
  if cfgActionNode.failed and 0 < cfgActionNode.failed and 2000000000 > cfgActionNode.failed then
    self:_InitAction(newTreeNode, AIActiveAddType.Failure, cfgAction, cfgActionNode.failed, context)
  end
  if cfgActionNode.Other then
    local nOtherCount = table.count(cfgActionNode.Other)
    if 0 < nOtherCount then
      for key, value in pairs(cfgActionNode.Other) do
        self:_InitAction(newTreeNode, AIActiveAddType.Other + key, cfgAction, value, context)
      end
    end
  end
  newTreeNode:SetHaveInit(true)
end

function AILogicNode:GetNodesLogicData(nLogicID, nIndex, nDefault)
  local nodeData
  for i = 1, #self.m_configData do
    if self.m_configData[i].ID == nLogicID then
      nodeData = self.m_configData[i]
      break
    end
  end
  if nil == nodeData then
    Log.warn("[AI]，获取从配置文件内读取到的逻辑数据: LogicID = " .. self.CustomLogicID .. ", Type = " .. self.CustomLogicType .. ", FindnLogicID" .. nLogicID .. ", FindIndex = " .. nIndex)
    return nDefault or 0
  end
  if nIndex < 0 or nIndex > #nodeData.NodesData then
    return nDefault or 0
  end
  return nodeData.NodesData[nIndex]
end

function AILogicNode:SetLogicData(logicData)
  AILogicNode.super.SetLogicData(self, logicData)
  self.m_actionMine:SetLogicData(logicData)
end

function AILogicNode:InitializeNode(cfg, context, parentNode)
  AILogicNode.super.InitializeNode(self, cfg, context, parentNode, cfg.Nodes)
  self.CustomLogicID = cfg.ID
  self.CustomLogicType = cfg.Type
  self.GenInfo = context.GenInfo
  if cfg.ActionEnd and "" ~= cfg.ActionEnd then
    self.m_actionEnd = self:_CreateActionNode(cfg.ActionEnd, context)
  end
  if cfg.Action then
    local nRootLogicID = cfg.Action.rootID or 1
    if not cfg.Action[nRootLogicID] then
      Log.exception("AI:", cfg.ID, "需要一个正确的Root,当前Root:", nRootLogicID, "不存在")
    end
    self:_InitAction(nil, AIActiveAddType.All, cfg.Action, nRootLogicID, context)
    if cfg.ActionSkill then
      self.m_actionTree.m_actionSkill = self:_CreateActionNode(cfg.ActionSkill, context)
    end
  end
  local vecSonNodes = self.m_vecSonNodes
  local cfgNodesData = cfg.Nodes
  if cfg.Nodes and #cfg.Nodes > 0 then
    for key, value in pairs(cfgNodesData) do
      local nSonNodeID = value.ID
      local sonNode = self:_CreateLogicNode(nSonNodeID, context)
      vecSonNodes:PushBack(sonNode)
    end
  end
end

function AILogicNode:Reset()
  AILogicNode.super.Reset(self)
  self.m_curAiNode = nil
  self.m_bCancelLogic = false
  self.m_curAiNodeStatus = AINewNodeStatus.Success
  local vecSonNodes = self.m_vecSonNodes
  for i = 1, vecSonNodes:Size() do
    vecSonNodes:GetAt(i):Reset()
  end
  if self.m_actionEnd then
    self.m_actionEnd:Reset()
  end
  self.m_actionTree:ClearScanNode()
end

function AILogicNode:OnBegin()
  self.m_curAiNode = nil
  self.m_curAiNodeStatus = AINewNodeStatus.Success
  self.m_actionTree:ResetWorkNode()
end

function AILogicNode:OnUpdate()
  repeat
    if self.m_curAiNode then
      if self.m_curAiNode:IsEnableStart() then
        self.m_curAiNode:Update()
      end
      if self.m_bCancelLogic then
        self.m_curAiNode:Reset()
        self.m_curAiNode = nil
        return AINewNodeStatus.Failure
      end
      if self.m_curAiNode:IsRunning() then
        return AINewNodeStatus.Running
      else
        self.m_curAiNodeStatus = self.m_curAiNode:GetStatues()
        self.m_actionTree:MoveWorkNode(self.m_curAiNodeStatus)
        self.m_curAiNode:Reset()
        self.m_curAiNode = nil
      end
    end
    if nil == self.m_curAiNode then
      self.m_curAiNode = self:_FindWorkSonNode()
    end
  until nil == self.m_curAiNode
  return self.m_curAiNodeStatus
end

function AILogicNode:OnEnd()
  if self.m_curAiNode then
    self.m_curAiNode:Reset()
    self.m_curAiNode = nil
  end
  if self.m_actionEnd then
    self.m_actionEnd:Update()
    if false == self.m_actionEnd:IsSuccess() then
      self:Reset()
    end
  end
end

function AILogicNode:UpdateSkillAction()
  if self.m_actionTree and self.m_actionTree.m_actionSkill then
    self.m_actionTree.m_actionSkill:Reset()
    self.m_actionTree.m_actionSkill:Update()
  end
end

function AILogicNode:GetActionSkillID(preview)
  local nSkillID = self.m_actionTree:GetActionSkillID(preview)
  if nSkillID and 0 < nSkillID then
    return nSkillID
  end
  if EDITOR and not preview then
    Log.exception("GetSkillID Failed ", Log.traceback())
  end
  Log.fatal("GetSkillID Failed ", Log.traceback())
  return 0
end

function AILogicNode:GetLogicNodeParent()
  return self.m_logicOwn or self
end

function AILogicNode:ReSelectWorkSkill()
  self.m_actionTree:ReSelectWorkSkill()
end

function AILogicNode:_FindWorkSonNode()
  if self.m_actionTree:IsTreeValid() then
    local treeNode = self.m_actionTree:GetWorkNode()
    if nil == treeNode then
      return nil
    end
    treeNode:StartWork(self.m_actionTree:GetActionSkillID())
    return treeNode:GetWorkAction()
  end
  return nil
end

function AILogicNode:SetActive(bActive)
  if bActive then
    self:Activate()
  else
    self:Deactivate()
  end
end

function AILogicNode:CancelLogic()
  self.m_bCancelLogic = true
  self:SetActive(false)
end
