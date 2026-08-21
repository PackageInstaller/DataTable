_class("StateAVGStoryOver", StateAVGStoryBase)
StateAVGStoryOver = StateAVGStoryOver

function StateAVGStoryOver:OnEnter(TT, ...)
  self.key = "StateAVGStoryOverOnEnter"
  self:Init()
  local nodeId = self:NodeId()
  local node = self.data:GetNodeById(nodeId)
  AVGLog("------------Story end------------", nodeId, node.storyId)
  local nextNodeId = self:NextNodeId()
  local com = self.data:GetComponentAVG()
  local res = AsyncRequestRes:New()
  self:HandleUpdateNodeData(TT, com, res, node.id, nextNodeId)
  if node:IsEnd() then
    GameGlobal.UIStateManager():ShowDialog("UIN20AVGEnding", node.endId)
  elseif nextNodeId < 0 then
    if GameGlobal.UIStateManager():IsShow("UIN20AVGEnding") then
      return
    else
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIN20AVGMain)
    end
  else
    GameGlobal.UIStateManager():CallUIMethod("UIN20AVGStory", "PlayFromBegain", nextNodeId)
  end
end

function StateAVGStoryOver:OnExit(TT)
end

function StateAVGStoryOver:HandleUpdateNodeData(TT, com, res, nodeId, nextNodeId)
  GameGlobal.UIStateManager():Lock(self.key)
  nextNodeId = nextNodeId < 0 and 0 or nextNodeId
  local avgStoryMissionInfo = self.data:GetServerNodeDataByNodeId(nextNodeId)
  if not avgStoryMissionInfo then
    avgStoryMissionInfo = AVGStoryMissionInfo:New()
    avgStoryMissionInfo.mission_id = nextNodeId
    avgStoryMissionInfo.end_formation_info = AVGStoryFormationInfo:New()
  end
  if not table.icontains(avgStoryMissionInfo.from_nodes, nodeId) then
    table.insert(avgStoryMissionInfo.from_nodes, nodeId)
  end
  avgStoryMissionInfo.end_formation_info.leader_hp, avgStoryMissionInfo.end_formation_info.teammate_affinity = self:CalcCurData()
  local ret = com:HandleUpdateNodeData(TT, res, avgStoryMissionInfo, nodeId)
  if N20AVGData.CheckCode(res) then
    self.data:Update()
  end
  GameGlobal.UIStateManager():UnLock(self.key)
end
