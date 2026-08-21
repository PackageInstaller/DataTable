_class("UIN20AVGGraph", UIController)
UIN20AVGGraph = UIN20AVGGraph

function UIN20AVGGraph:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGGraph:LoadDataOnEnter(TT, res, uiParams)
  self:HandleUpdateFstNodeDataIfFstIn(TT, res)
end

function UIN20AVGGraph:HandleUpdateFstNodeDataIfFstIn(TT, res)
  local nodeId = self.data:FirstNodeId()
  local avgStoryMissionInfo = self.data:GetServerNodeDataByNodeId(nodeId)
  if avgStoryMissionInfo then
    return
  end
  local node = self.data:GetNodeById(nodeId)
  avgStoryMissionInfo = AVGStoryMissionInfo:New()
  avgStoryMissionInfo.mission_id = nodeId
  avgStoryMissionInfo.end_formation_info = AVGStoryFormationInfo:New()
  avgStoryMissionInfo.end_formation_info.leader_hp, avgStoryMissionInfo.end_formation_info.teammate_affinity = node:StartData()
  local com = self.data:GetComponentAVG()
  local ret = com:HandleUpdateNodeData(TT, res, avgStoryMissionInfo, 0)
  if N20AVGData.CheckCode(res) then
  else
    res:SetSucc(false)
  end
end

function UIN20AVGGraph:OnShow(uiParams)
  self.isFromStory = uiParams[1] or false
  self.endId = uiParams[2] or 0
  self.rtSV = self:GetUIComponent("RectTransform", "sv")
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self.rtContent = self:GetUIComponent("RectTransform", "Content")
  self.poolLines = self:GetUIComponent("UISelectObjectPath", "poolLines")
  self.txtCurPos = self:GetUIComponent("UILocalizationText", "txtCurPos")
  self.txtCurPos1 = self:GetUIComponent("UILocalizationText", "txtCurPos1")
  local poolLeader = self:GetUIComponent("UISelectObjectPath", "leader")
  self.leader = poolLeader:SpawnObject("UIN20AVGActor")
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
    local nodeEnd = self.data:GetNodeByEndId(self.endId)
    targetNodeId = nodeEnd.id
  else
    local curNode = self.data:CurNode()
    targetNodeId = curNode.id
  end
  self.rtContent.anchoredPosition = Vector2.zero
  self.fsm:ChangeState(StateAVGGraph.Focus, targetNodeId)
end

function UIN20AVGGraph:OnHide()
end

function UIN20AVGGraph:Flush()
  self:FlushContentSize()
  self:FlushTxtCurPos()
  self:FlushGraph()
  self:FlushLines()
  self:FlushActors()
end

function UIN20AVGGraph:FlushContentSize()
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

function UIN20AVGGraph:FlushTxtCurPos()
  if self.endId > 0 then
    local nodeEnd = self.data:GetNodeByEndId(self.endId)
    self.txtCurPos:SetText(nodeEnd.title)
    self.txtCurPos1:SetText(nodeEnd.title)
  else
    local node = self.data:CurNode()
    self.txtCurPos:SetText(node.title)
    self.txtCurPos1:SetText(node.title)
  end
end

function UIN20AVGGraph:FlushGraph()
  local len = table.count(self.data.dictStoryNode)
  self.poolContent:SpawnObjects("UIN20AVGGraphNodePool", len)
  local uis = self.poolContent:GetAllSpawnList()
  local i = 1
  for id, node in pairs(self.data.dictStoryNode) do
    local ui = uis[i]
    ui:Flush(id, self.endId)
    i = i + 1
  end
end

function UIN20AVGGraph:FlushLines()
  local len = table.count(self.data.lines)
  self.poolLines:SpawnObjects("UIN20AVGGraphLine", len)
  local uis = self.poolLines:GetAllSpawnList()
  local i = 1
  for id, line in pairs(self.data.lines) do
    local ui = uis[i]
    ui:Flush(line)
    i = i + 1
  end
end

function UIN20AVGGraph:FlushActors()
  local hp, strategies = 0, {}
  if self.isFromStory then
    hp, strategies = self.data:CalcCurData()
  else
    local node = self.data:CurNode()
    hp, strategies = node:StartData()
  end
  self.leader:Flush(0, hp)
  local len = table.count(self.data.actorPartners)
  self.poolPartners:SpawnObjects("UIN20AVGActor", len)
  local uis = self.poolPartners:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(i, strategies[i] or 0)
  end
end

function UIN20AVGGraph:GetHideNewNode()
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

function UIN20AVGGraph:btnExitOnClick(go)
  self:CloseDialog()
end

function UIN20AVGGraph:btnLocateOnClick(go)
  local targetNode = self.data:CurNode()
  self.fsm:ChangeState(StateAVGGraph.Focus, targetNode.id)
end

function UIN20AVGGraph:GetWidgetHdie(hideNodeId)
  local uis = self.poolContent:GetAllSpawnList()
  for id, ui in pairs(uis) do
    local uiHide = ui:GetWidgetHide()
    if uiHide and uiHide.node.id == hideNodeId then
      return uiHide
    end
  end
end

StateAVGGraph = {
  Init = 0,
  Focus = 1,
  HideNodeUnlock = 2
}
