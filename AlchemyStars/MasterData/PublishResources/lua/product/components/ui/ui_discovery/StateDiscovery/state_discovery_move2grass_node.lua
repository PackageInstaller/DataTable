_class("StateDiscoveryMove2GrassNode", StateDiscoveryBase)
StateDiscoveryMove2GrassNode = StateDiscoveryMove2GrassNode

function StateDiscoveryMove2GrassNode:OnEnter(TT, ...)
  StateDiscoveryMove2GrassNode.super:OnEnter(TT, ...)
  self:Init()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.grassData = self.mCampaign:GetGraveRobberData()
  self._ui:Lock("StateDiscoveryMove2GrassNode")
  local node, callback
  node, callback = table.unpack({
    ...
  })
  local lastNode = self.grassData:LastNode()
  if lastNode then
    if lastNode.stageId == node.stageId then
    else
      self:Move(TT, lastNode.pos, node.pos)
    end
  else
    local curNode = self._ui:GetCurPosNode()
    self:Move(TT, curNode.pos, node.pos)
  end
  if callback then
    callback()
  end
  self.grassData:SaveLastNode(node)
  self:ChangeState(StateDiscovery.Init)
end

function StateDiscoveryMove2GrassNode:OnExit(TT)
  self._ui:UnLock("StateDiscoveryMove2GrassNode")
end

function StateDiscoveryMove2GrassNode:Move(TT, posStart, posEnd)
  local duration = self._ui:CalcWalkDuration(posStart, posEnd)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryCameraMove, posEnd, duration)
end
