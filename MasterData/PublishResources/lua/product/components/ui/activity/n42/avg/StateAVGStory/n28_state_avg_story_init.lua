_class("N28StateAVGStoryInit", N28StateAVGStoryBase)
N28StateAVGStoryInit = N28StateAVGStoryInit

function N28StateAVGStoryInit:OnEnter(TT, ...)
  self.key = "N28StateAVGStoryInitOnEnter"
  GameGlobal.UIStateManager():Lock(self.key)
  self:Init()
  self:InitStoryManager()
  self.data:InitNodes()
  self:ClearPassSectionIds()
  self:InitEvidenceBookShowStatus()
  self:ClearShowEvienceCount()
  self:CopyEvidenceDataInCache()
  self.ui:ClearSelectedOptionIds()
  local nodeId = self:NodeId()
  local node = self.data:GetNodeById(nodeId)
  self:NextNodeId(node.defaultNextId)
  self:HandleSetCurrentLocation(TT, node.id, function()
    self.fsm:ChangeState(N28StateAVGStory.Play)
  end, function()
    GameGlobal.UIStateManager():UnLock(self.key)
  end)
  AVGLog("------------Story start------------", nodeId, node.storyId)
end

function N28StateAVGStoryInit:OnExit(TT)
  GameGlobal.UIStateManager():UnLock(self.key)
end
