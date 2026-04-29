_class("N28StateAVGStoryOver", N28StateAVGStoryBase)
N28StateAVGStoryOver = N28StateAVGStoryOver

function N28StateAVGStoryOver:OnEnter(TT, ...)
  self.key = "N28StateAVGStoryOverOnEnter"
  self:Init()
  local nodeId = self:NodeId()
  local node = self.data:GetNodeById(nodeId)
  AVGLog("------------Story end------------", nodeId, node.storyId)
  local nextNodeId = self:NextNodeId()
  local com = self.data:GetComponentAVG()
  local res = AsyncRequestRes:New()
  if nextNodeId < -1 then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIN28AVGMain)
  else
    self:HandleUpdateNodeData(TT, com, res, node.id, nextNodeId)
    if node:IsEnd() then
      GameGlobal.UIStateManager():ShowDialog("UIN28AVGEnding", node.endId, nodeId)
    elseif nextNodeId < 0 then
      if GameGlobal.UIStateManager():IsShow("UIN28AVGEnding") then
        return
      else
        GameGlobal.UIStateManager():SwitchState(UIStateType.UIN28AVGMain)
      end
    else
      GameGlobal.UIStateManager():CallUIMethod("UIN28AVGStory", "PlayFromBegain", nextNodeId)
    end
  end
end

function N28StateAVGStoryOver:OnExit(TT)
end

function N28StateAVGStoryOver:HandleUpdateNodeData(TT, com, res, nodeId, nextNodeId)
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
  local nodeId = self:NodeId()
  local node = self.data:GetNodeById(nodeId)
  avgStoryMissionInfo.end_formation_info.evidence = table.shallowcopy(self:GetEvidenceDataInCache())
  local ret = com:HandleUpdateNodeData(TT, res, avgStoryMissionInfo, nodeId)
  if N28AVGData.CheckCode(res) then
    self.data:Update()
  end
  GameGlobal.UIStateManager():UnLock(self.key)
end
