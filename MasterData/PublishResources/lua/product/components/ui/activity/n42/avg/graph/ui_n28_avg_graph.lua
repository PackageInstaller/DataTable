_class("UIN28AVGGraph", UIController)
UIN28AVGGraph = UIN28AVGGraph

function UIN28AVGGraph:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGGraph:LoadDataOnEnter(TT, res, uiParams)
  self:HandleUpdateFstNodeDataIfFstIn(TT, res)
end

function UIN28AVGGraph:HandleUpdateFstNodeDataIfFstIn(TT, res)
  local nodeId = self.data:FirstNodeId()
  local avgStoryMissionInfo = self.data:GetServerNodeDataByNodeId(nodeId)
  if avgStoryMissionInfo then
    return
  end
  local node = self.data:GetNodeById(nodeId)
  avgStoryMissionInfo = AVGStoryMissionInfo:New()
  avgStoryMissionInfo.mission_id = nodeId
  avgStoryMissionInfo.end_formation_info = AVGStoryFormationInfo:New()
  avgStoryMissionInfo.end_formation_info.leader_hp, avgStoryMissionInfo.end_formation_info.teammate_affinity, avgStoryMissionInfo.end_formation_info.evidence = node:StartData()
  local com = self.data:GetComponentAVG()
  local ret = com:HandleUpdateNodeData(TT, res, avgStoryMissionInfo, 0)
  if N28AVGData.CheckCode(res) then
  else
    res:SetSucc(false)
  end
end

function UIN28AVGGraph:OnShow(uiParams)
  self.isFromStory = uiParams[1] or false
  self.endId = uiParams[2] or 0
  self.nodeId = uiParams[3] or 101
  self.rtSV = self:GetUIComponent("RectTransform", "sv")
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self.rtContent = self:GetUIComponent("RectTransform", "Content")
  self.poolLines = self:GetUIComponent("UISelectObjectPath", "poolLines")
  self.txtCurPos = self:GetUIComponent("UILocalizationText", "txtCurPos")
  self.txtCurPos1 = self:GetUIComponent("UILocalizationText", "txtCurPos1")
  local poolLeader = self:GetUIComponent("UISelectObjectPath", "leader")
  self.leader = poolLeader:SpawnObject("UIN28AVGActor")
  self.poolPartners = self:GetUIComponent("UISelectObjectPath", "partners")
  self.data:Update()
  self:Flush()
  self.fsm = StateMachineManager:GetInstance():CreateStateMachine("StateAVGGraph", StateAVGGraph)
  self.fsm:SetData(self)
  self.fsm:Init(StateAVGGraph.Init)
  local targetNodeId = 0
  local hideNode = self:GetHideNewNode()
  if hideNode then
    targetNodeId = hideNode.id
    local ui = self:GetWidgetHdie(targetNodeId)
    if ui then
      ui.new:SetActive(false)
      ui.lock:SetActive(true)
    end
  elseif self.endId > 0 then
    targetNodeId = self.nodeId
  else
    local curNode = self.data:CurNode()
    targetNodeId = curNode.id
  end
  self.rtContent.anchoredPosition = Vector2.zero
  self.fsm:ChangeState(StateAVGGraph.Focus, targetNodeId)
end

function UIN28AVGGraph:OnHide()
end

function UIN28AVGGraph:Flush()
  self:FlushContentSize()
  self:FlushTxtCurPos()
  self:FlushGraph()
  self:FlushLines()
  self:FlushActors()
end

function UIN28AVGGraph:FlushContentSize()
  local size = Vector2.zero
  local minX, minY = 9999, 9999
  local maxX, maxY = -9999, -9999
  for id, node in pairs(self.data.dictStoryNode) do
    local isVisibleHideNode = node:IsHide() and node:IsSatisfyVisible()
    local isVisibleNode = node:State()
    if isVisibleHideNode or isVisibleNode then
      local pos = node.pos
      if minX > pos.x then
        minX = pos.x
      end
      if minY > pos.y then
        minY = pos.y
      end
      if maxX < pos.x then
        maxX = pos.x
      end
      if maxY < pos.y then
        maxY = pos.y
      end
    end
  end
  local expandX, expandY = 800, 600
  size.x = maxX - minX + expandX
  size.y = maxY - minY + expandY
  self.rtContent.sizeDelta = size
end

function UIN28AVGGraph:FlushTxtCurPos()
  if self.endId > 0 then
    local nodeEnd = self.data:GetNodeById(self.nodeId)
    self.txtCurPos:SetText(nodeEnd.title)
    self.txtCurPos1:SetText(nodeEnd.title)
  else
    local node = self.data:CurNode()
    self.txtCurPos:SetText(node.title)
    self.txtCurPos1:SetText(node.title)
  end
end

function UIN28AVGGraph:FlushGraph()
  local len = table.count(self.data.dictStoryNode)
  self.poolContent:SpawnObjects("UIN28AVGGraphNodePool", len)
  local uis = self.poolContent:GetAllSpawnList()
  local i = 1
  for id, node in pairs(self.data.dictStoryNode) do
    local ui = uis[i]
    ui:Flush(id, self.endId, self.nodeId)
    i = i + 1
  end
end

function UIN28AVGGraph:FlushLines()
  local len = table.count(self.data.lines)
  self.poolLines:SpawnObjects("UIN28AVGGraphLine", len)
  local uis = self.poolLines:GetAllSpawnList()
  local i = 1
  for id, line in pairs(self.data.lines) do
    local ui = uis[i]
    ui:Flush(line)
    i = i + 1
  end
end

function UIN28AVGGraph:FlushActors()
  local hp, strategies = 0, {}
  if self.isFromStory then
    hp, strategies = self.data:CalcCurData()
  else
    local node = self.data:CurNode()
    hp, strategies = node:StartData()
  end
  self.leader:Flush(0, hp)
  local len = table.count(self.data.actorPartners)
  self.poolPartners:SpawnObjects("UIN28AVGActor", len)
  local uis = self.poolPartners:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(i, strategies[i] or 0)
  end
end

function UIN28AVGGraph:GetHideNewNode()
  local targetNode
  for id, node in pairs(self.data.dictStoryNode) do
    if node:IsHide() and node:IsSatisfyVisible() and node:IsHideNew() then
      if targetNode then
        if targetNode.id < node.id then
          targetNode = node
        end
      else
        targetNode = node
      end
    end
  end
  return targetNode
end

function UIN28AVGGraph:BtnExitOnClick(go)
  self:CloseDialog()
end

function UIN28AVGGraph:BtnLocateOnClick(go)
  local targetNode = self.data:CurNode()
  self.fsm:ChangeState(StateAVGGraph.Focus, targetNode.id)
end

function UIN28AVGGraph:GetWidgetHdie(hideNodeId)
  local uis = self.poolContent:GetAllSpawnList()
  for id, ui in pairs(uis) do
    local uiHide = ui:GetWidgetHide()
    if uiHide and uiHide.node.id == hideNodeId then
      return uiHide
    end
  end
end

local StateAVGGraph = {
  Init = 0,
  Focus = 1,
  HideNodeUnlock = 2
}
_enum("StateAVGGraph", StateAVGGraph)
