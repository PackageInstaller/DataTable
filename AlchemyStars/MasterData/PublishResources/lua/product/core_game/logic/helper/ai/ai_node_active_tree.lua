local AIActiveAddType = {
  Success = 1,
  Failure = 2,
  All = 3,
  Other = 10
}
_enum("AIActiveAddType", AIActiveAddType)
_class("AIActiveNodeData", Object)
AIActiveNodeData = AIActiveNodeData

function AIActiveNodeData:Constructor(nLogicID, configData)
  self.m_nLogicID = nLogicID
  self.m_configData = configData
  self.m_nextSuccess = nil
  self.m_nextFailed = nil
  self.m_parentNode = nil
end

_class("AIActiveNodeList", Object)
AIActiveNodeList = AIActiveNodeList

function AIActiveNodeList:Constructor()
  self.m_firstNode = nil
  self.m_workNode = nil
end

function AIActiveNodeList:AddNode(workNode, nAddType, nLogicID, configData)
  local newNode = AIActiveNodeData:New(nLogicID, configData)
  if nil == workNode then
    workNode = newNode
  else
    newNode.m_parentNode = workNode
    if AIActiveAddType.All == nAddType then
      workNode.m_nextSuccess = newNode
      workNode.m_nextFailed = newNode
    elseif AIActiveAddType.Success == nAddType then
      workNode.m_nextSuccess = newNode
    elseif AIActiveAddType.Failure == nAddType then
      workNode.m_nextFailed = newNode
    end
  end
  if nil == self.m_firstNode then
    self.m_firstNode = workNode
  end
  return newNode
end

function AIActiveNodeList:ResetWorkNode()
  self.m_workNode = self.m_firstNode
end

function AIActiveNodeList:MoveWorkNode(bSuccess)
  if nil == self.m_workNode then
    return
  end
  if bSuccess then
    self.m_workNode = self.m_workNode.m_nextSuccess
  else
    self.m_workNode = self.m_workNode.m_nextFailed
  end
end

function AIActiveNodeList:Clear()
  self.m_firstNode = nil
  self.m_workNode = nil
end

_class("AIActiveTreeNode", Object)
AIActiveTreeNode = AIActiveTreeNode

function AIActiveTreeNode:Constructor(actionNode, nLogicID, configData)
  self.m_actionNode = actionNode
  self.m_nLogicID = nLogicID
  self.m_configData = configData
  self.m_nextSuccess = nil
  self.m_nextFailed = nil
  self.m_nextOther = nil
  self.m_parentNode = nil
  self.m_bIsHaveInit = false
end

function AIActiveTreeNode:StartWork(nSkillID)
  if self.m_actionNode then
    self.m_actionNode:Reset()
    self.m_actionNode:SetConfigData(self.m_configData)
    self.m_actionNode:SetLogicData(nSkillID)
  end
end

function AIActiveTreeNode:GetTreeID()
  return self.m_nLogicID
end

function AIActiveTreeNode:GetWorkAction()
  return self.m_actionNode
end

function AIActiveTreeNode:GetOtherIndex(otherData)
  local nOtherIndex = 0
  if otherData > AIActiveAddType.Other then
    nOtherIndex = otherData - AIActiveAddType.Other
  end
  return nOtherIndex
end

function AIActiveTreeNode:GetOtherNode(otherData)
  local nOtherIndex = self:GetOtherIndex(otherData)
  return self.m_nextOther[nOtherIndex]
end

function AIActiveTreeNode:AddOtherIndex(otherData, newNode)
  local nOtherIndex = self:GetOtherIndex(otherData)
  if 0 < nOtherIndex then
    if nil == self.m_nextOther then
      self.m_nextOther = {}
    end
    self.m_nextOther[nOtherIndex] = newNode
  end
end

function AIActiveTreeNode:IsHaveInit(bHaveInit)
  return self.m_bIsHaveInit
end

function AIActiveTreeNode:SetHaveInit(bHaveInit)
  self.m_bIsHaveInit = bHaveInit
end

function AIActiveTreeNode:GetLogicID()
  return self.m_nLogicID
end

function AIActiveTreeNode:IsEndNode()
  if not self.m_nextSuccess and not self.m_nextFailed and (not self.m_nextOther or table.count(self.m_nextOther) == 0) then
    return true
  end
  return false
end

_class("AIActiveTree", Object)
AIActiveTree = AIActiveTree

function AIActiveTree:Constructor()
  self.m_rootNode = nil
  self.m_scanNode = nil
  self.m_actionSkill = nil
end

function AIActiveTree:AddNode(workNode, nAddType, actionNode, nLogicID, configData)
  local returnNode
  if nil == workNode then
    workNode = AIActiveTreeNode:New(actionNode, nLogicID, configData)
    returnNode = workNode
  else
    local newNode = self:FindTreeNode(self.m_rootNode, nLogicID)
    if nil == newNode then
      newNode = AIActiveTreeNode:New(actionNode, nLogicID, configData)
      newNode.m_parentNode = workNode
    end
    if AIActiveAddType.All == nAddType then
      workNode.m_nextSuccess = newNode
      workNode.m_nextFailed = newNode
    elseif AIActiveAddType.Success == nAddType then
      workNode.m_nextSuccess = newNode
    elseif AIActiveAddType.Failure == nAddType then
      workNode.m_nextFailed = newNode
    else
      workNode:AddOtherIndex(nAddType, newNode)
    end
    returnNode = newNode
  end
  if nil == self.m_rootNode then
    self.m_rootNode = workNode
  end
  return returnNode
end

function AIActiveTree:Clear()
  self.m_rootNode = nil
end

function AIActiveTree:ClearScanNode()
  self.m_scanNode = nil
end

function AIActiveTree:GetWorkNode()
  if nil == self.m_scanNode then
    return nil
  end
  return self.m_scanNode
end

function AIActiveTree:GetWorkAction()
  if nil == self.m_scanNode then
    return nil
  end
  return self.m_scanNode.m_actionNode
end

function AIActiveTree:ResetWorkNode()
  self.m_scanNode = self.m_rootNode
  if self.m_actionSkill then
    self.m_actionSkill:Update()
  end
end

function AIActiveTree:IsTreeValid()
  if nil == self.m_rootNode then
    return false
  end
  return true
end

function AIActiveTree:MoveWorkNode(nStatus)
  if nil == self.m_scanNode then
    return
  end
  local preActionNode = self.m_scanNode:GetWorkAction()
  local preActionTreeID = self.m_scanNode:GetTreeID()
  if AINewNodeStatus.Success == nStatus then
    self.m_scanNode = self.m_scanNode.m_nextSuccess
  elseif AINewNodeStatus.Failure == nStatus then
    self.m_scanNode = self.m_scanNode.m_nextFailed
  elseif nStatus > AINewNodeStatus.Other then
    local nextOther = self.m_scanNode:GetOtherNode(nStatus)
    self.m_scanNode = nextOther
  else
    self.m_scanNode = nil
  end
  local nextActionNode
  local nextActionIsEnd = false
  local nextActionTreeID
  if self.m_scanNode then
    nextActionNode = self.m_scanNode:GetWorkAction()
    nextActionIsEnd = self.m_scanNode:IsEndNode()
    nextActionTreeID = self.m_scanNode:GetTreeID()
  end
  preActionNode:PrintActionSwitchLog(preActionNode, preActionTreeID, nextActionNode, nextActionTreeID, nStatus, nextActionIsEnd)
end

function AIActiveTree:GetCurTreeID()
  return self.m_scanNode:GetTreeID()
end

function AIActiveTree:GetActionSkillID(preview)
  if self.m_actionSkill then
    return self.m_actionSkill:GetActionSkillIDEx(preview)
  end
  return 0
end

function AIActiveTree:FindTreeNode_Ex(rootNode, nLogicID)
  if nil == rootNode then
    return nil
  end
  if nLogicID == rootNode.m_nLogicID then
    return rootNode
  end
  local listWork = rootNode.m_nextOther
  if nil == listWork then
    listWork = {}
  end
  listWork[#listWork + 1] = rootNode.m_nextSuccess
  listWork[#listWork + 1] = rootNode.m_nextFailed
  local findNode
  for key, value in ipairs(listWork) do
    findNode = self:FindTreeNode(value, nLogicID)
    if findNode then
      break
    end
  end
  return findNode
end

function AIActiveTree:FindTreeNode(rootNode, nLogicID)
  if nil == rootNode then
    return nil
  end
  if nLogicID == rootNode.m_nLogicID then
    return rootNode
  end
  local findNode
  findNode = self:FindTreeNode(rootNode.m_nextSuccess, nLogicID)
  if findNode then
    return findNode
  end
  findNode = self:FindTreeNode(rootNode.m_nextFailed, nLogicID)
  if findNode then
    return findNode
  end
  if rootNode.m_nextOther then
    for key, value in ipairs(rootNode.m_nextOther) do
      findNode = self:FindTreeNode(value, nLogicID)
      if findNode then
        break
      end
    end
  end
  return findNode
end

function AIActiveTree:ReSelectWorkSkill()
  if self.m_actionSkill then
    self.m_actionSkill:Update()
  end
end
