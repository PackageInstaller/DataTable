function CustomNodeConfigStatic.Check_FSMNode(cfg)
  if nodeCfg.Nodes then
    return true
  end
  return false
end

CustomNodeConfigStatic.AddChecker("FSMNode", CustomNodeConfigStatic.Check_FSMNode)
_class("FSMNode", CustomNode)
FSMNode = FSMNode

function FSMNode:Constructor()
  self.mStates = ArrayList:New()
  self.mTransition = ArrayList:New()
  self.mCurrentState = nil
  self.mDefaultStateID = nil
end

function FSMNode:InitializeNode(cfg, context)
  FSMNode.super.InitializeNode(self, cfg, context)
  self.OwnerEntity = context.GenInfo.OwnerEntity
  self.MaxTransitionsPerFrame = cfg.MaxTransitionsPerFrame
  local mStates = self.mStates
  mStates:Clear()
  local nodeCfgList = cfg.Nodes
  local logic = context.Logic
  for i = 1, #nodeCfgList do
    local nodeCfg = nodeCfgList[i]
    local subNode = logic:CreateNode(nodeCfg, context)
    CLHelper.Assert(subNode)
    subNode:Deactivate()
    mStates:PushBack(subNode)
  end
  CLHelper.Assert(mStates:Size() > 0)
  if cfg.DefaultState and cfg.DefaultState ~= "" then
    self.mDefaultStateID = cfg.DefaultState
  else
    self.mDefaultStateID = mStates:GetAt(1):StateID()
  end
  local node_transitions = cfg.GlobalTransition
  if node_transitions then
    for i = 1, #node_transitions do
      local nodeCfg = node_transitions[i].Transition
      local subNode = logic:CreateNode(nodeCfg, context)
      CLHelper.Assert(subNode)
      subNode:Deactivate()
      self.mTransition:PushBack({
        subNode,
        node_transitions[i].OnlyOnce
      })
    end
  end
end

function FSMNode:Destroy()
  FSMNode.super.Destroy(self)
  local curState = self.mCurrentState
  if curState ~= nil then
    curState:Exit()
  end
  local mStates = self.mStates
  if mStates ~= nil then
    for i = 1, mStates:Size() do
      local state = mStates:GetAt(i)
      state:Destroy()
    end
  end
  for i = 1, self.mTransition:Size() do
    local transition = self.mTransition:GetAt(i)[1]
    transition:Destroy()
  end
  self.mTransition = nil
  self.mStates = nil
  self.mCurrentState = nil
  self.mDefaultStateID = nil
end

function FSMNode:Update(dt)
  local mStates = self.mStates
  if mStates == nil then
    return
  end
  if self.mCurrentState == nil then
    self.mCurrentState = self:FindState(self.mDefaultStateID)
    if self.mCurrentState then
      self.mCurrentState:Enter()
    end
  end
  for j = 1, self.mTransition:Size() do
    local transition = self.mTransition:GetAt(j)[1]
    local only_once = self.mTransition:GetAt(j)[2]
    local global_trans_goal_state = transition:CheckTransitions()
    if global_trans_goal_state and self.mCurrentState:StateID() ~= global_trans_goal_state then
      self:TransToState(global_trans_goal_state)
      transition:Reset()
      if only_once then
        self.mTransition:RemoveAt(j)
      end
      break
    end
  end
  for i = 1, self.MaxTransitionsPerFrame do
    local oldStateID = self.mCurrentState:StateID()
    local goalStateID
    goalStateID = self.mCurrentState:CheckTransitions()
    if not goalStateID or oldStateID == goalStateID then
      break
    end
    self:TransToState(goalStateID)
  end
  self.mCurrentState:Update(dt)
end

function FSMNode:TransToState(goalStateID)
  local mGoalState = self:FindState(goalStateID)
  if mGoalState then
    self.mCurrentState:Exit()
    self.mCurrentState = mGoalState
    self.mCurrentState:Enter()
  end
end

function FSMNode:CollectInterfaceInChildren(interfaceList, funcName)
  local nodes = self.mStates
  for i = 1, nodes:Size() do
    local node = nodes:GetAt(i)
    CustomNodeStatic.TraverseCollectInterface(interfaceList, funcName, node)
  end
  for i = 1, self.mTransition:Size() do
    local transition_node = self.mTransition:GetAt(i)[1]
    CustomNodeStatic.TraverseCollectInterface(interfaceList, funcName, transition_node)
  end
end

function FSMNode:Activate()
  FSMNode.super.Activate(self)
  local curState = self.mCurrentState
  if curState ~= nil and not curState.IsActive then
    curState:Activate()
  end
  for i = 1, self.mTransition:Size() do
    self.mTransition:GetAt(i)[1]:Activate()
  end
end

function FSMNode:Deactivate()
  FSMNode.super.Deactivate(self)
  local curState = self.mCurrentState
  if curState ~= nil and curState.IsActive then
    curState:Deactivate()
  end
  for i = 1, self.mTransition:Size() do
    self.mTransition:GetAt(i)[1]:Deactivate()
  end
end

function FSMNode:CurrentState()
  return self.mCurrentState
end

function FSMNode:CurrentStateID()
  local mCurrentState = self.mCurrentState
  if mCurrentState then
    return mCurrentState:StateID()
  end
end

function FSMNode:FindState(stateID)
  local mStates = self.mStates
  if not mStates then
    return nil
  end
  for i = 1, mStates:Size() do
    local state = mStates:GetAt(i)
    if state:StateID() == stateID then
      return state
    end
  end
end

function FSMNode:Reset(stateID)
  local mCurrentState = self.mCurrentState
  if mCurrentState then
    mCurrentState:Exit()
    mCurrentState:Deactivate()
  end
  mCurrentState = self:FindState(self.mDefaultStateID)
  self.mCurrentState = mCurrentState
  if mCurrentState then
    mCurrentState:Activate()
    mCurrentState:Enter()
  end
  for i = 1, self.mTransition:Size() do
    self.mTransition:GetAt(i)[1]:Reset()
  end
end

function FSMNode:CanStop()
  return false
end
