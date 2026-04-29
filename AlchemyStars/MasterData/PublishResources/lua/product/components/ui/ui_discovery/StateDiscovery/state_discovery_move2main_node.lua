_class("StateDiscoveryMove2MainNode", StateDiscoveryBase)
StateDiscoveryMove2MainNode = StateDiscoveryMove2MainNode

function StateDiscoveryMove2MainNode:OnEnter(TT, ...)
  StateDiscoveryMove2MainNode.super:OnEnter(TT, ...)
  self:Init()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.grassData = self.mCampaign:GetGraveRobberData()
  self._ui:Lock("StateDiscoveryMove2MainNode")
  local targetNodeId, callback
  targetNodeId, callback = table.unpack({
    ...
  })
  local lastNode = self.grassData:LastNode()
  if not lastNode then
    Log.fatal("### StateDiscoveryMove2MainNode LastNode nil.")
    return
  end
  local targetPos = self._data:GetPosByNodeId(targetNodeId)
  self:Move(TT, lastNode.pos, targetPos)
  self._data:SetCurPosNodeId(targetNodeId)
  if callback then
    callback()
  end
  self.grassData:SaveLastNode(nil)
  self:ChangeState(StateDiscovery.Init)
end

function StateDiscoveryMove2MainNode:OnExit(TT)
  self._ui:UnLock("StateDiscoveryMove2MainNode")
end

function StateDiscoveryMove2MainNode:Move(TT, posStart, posEnd)
  local duration = self._ui:CalcWalkDuration(posStart, posEnd)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryCameraMove, posEnd, duration)
end
