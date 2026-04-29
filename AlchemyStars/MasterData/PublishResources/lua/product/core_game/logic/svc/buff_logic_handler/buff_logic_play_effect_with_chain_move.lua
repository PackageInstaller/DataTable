local PlayEffectWithChainMoveType = {Normal = 1, Zhongxu = 2}
_enum("PlayEffectWithChainMoveType", PlayEffectWithChainMoveType)
_class("BuffPlayEffectWithChainMoveZhongxuViewParam", Object)
BuffPlayEffectWithChainMoveZhongxuViewParam = BuffPlayEffectWithChainMoveZhongxuViewParam

function BuffPlayEffectWithChainMoveZhongxuViewParam:Constructor(cfgTb)
  if cfgTb then
    self._transAudioID = cfgTb.transAudioID
    self._transAnim = cfgTb.transAnim
    self._revertAnim = cfgTb.revertAnim
    self._transEffectID = cfgTb.transEffectID
    self._transMatAnim = cfgTb.transMatAnim
    self._revertEffectID = cfgTb.revertEffectID
    self._revertMatAnim = cfgTb.revertMatAnim
    self._catShowEffectID = cfgTb.catShowEffectID
    self._catShowMatAnim = cfgTb.catShowMatAnim
    self._catHideEffectID = cfgTb.catHideEffectID
    self._catHideMatAnim = cfgTb.catHideMatAnim
  end
end

_class("BuffLogicPlayEffectWithChainMove", BuffLogicBase)
BuffLogicPlayEffectWithChainMove = BuffLogicPlayEffectWithChainMove

function BuffLogicPlayEffectWithChainMove:Constructor(buffInstance, logicParam)
  self._permanentEffectID = logicParam.permanentEffectID
  self._pieceType = logicParam.pieceType
  self._normalEffectID = logicParam.normalEffectID
  self._specialEffectID = logicParam.specialEffectID
  self._useType = logicParam.useType or PlayEffectWithChainMoveType.Normal
  if self._useType == PlayEffectWithChainMoveType.Zhongxu then
    self._zhongxuSpecialParam = BuffPlayEffectWithChainMoveZhongxuViewParam:New(logicParam.zhongxuSpecialParam)
  end
end

function BuffLogicPlayEffectWithChainMove:DoLogic(notify)
  local notifyType = notify:GetNotifyType()
  if self._useType == PlayEffectWithChainMoveType.Zhongxu and self._world:GetGameTurn() == GameTurnType.RemotePlayerTurn then
    return
  end
  if notifyType == NotifyType.PlayerMoveStart then
    return self:_OnPlayerMoveStart(notify)
  end
  if notifyType ~= NotifyType.PlayerEachMoveStart and notifyType ~= NotifyType.PlayerEachMoveEnd and notifyType ~= NotifyType.PetChainMoveBegin then
    return
  end
  local typeParam = {}
  local e = self._buffInstance:Entity()
  local teamEntity = e:Pet():GetOwnerTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  local notifyPos = notify:GetPos()
  local pieceType = notify:GetPosPieceType()
  local chainPathIndex = notify:GetChainIndex()
  local isStart = notifyPos == chainPath[1]
  local isEnd = notifyPos == chainPath[#chainPath]
  local isMatch = self:_CheckMatchType(chainPath)
  if not isMatch then
    return
  end
  if self._useType == PlayEffectWithChainMoveType.Normal then
  end
  local isSpecial = false
  local moveEffectID = self._normalEffectID
  if 1 < chainPathIndex and chainPathIndex < table.count(chainPath) then
    local lastPos = chainPath[chainPathIndex - 1]
    local lastDir = notifyPos - lastPos
    local nextPos = chainPath[chainPathIndex + 1]
    local curDir = nextPos - notifyPos
    local diffAngle = Vector2.Angle(lastDir, curDir)
    diffAngle = math.floor(diffAngle + 0.5)
    if 90 <= diffAngle then
      isSpecial = true
      moveEffectID = self._specialEffectID
    end
  end
  if self._useType == PlayEffectWithChainMoveType.Zhongxu then
    if notifyType == NotifyType.PetChainMoveBegin then
      if notify:GetEntityID() ~= e:GetID() then
        return
      end
    elseif notify:GetEntityID() ~= e:GetID() then
      return
    end
    local teamCmpt = teamEntity:Team()
    local isTeamLeader = teamCmpt:IsTeamLeaderByEntityId(e:GetID())
    typeParam.isTeamLeader = isTeamLeader
    typeParam.chainPathCount = #chainPath
    typeParam.specialParam = self._zhongxuSpecialParam
  end
  local buffResult = BuffResultPlayEffectWithChainMove:New(notifyType, notifyPos, isStart, isEnd, self._permanentEffectID, moveEffectID, self._useType, typeParam)
  return buffResult
end

function BuffLogicPlayEffectWithChainMove:_CheckMatchType(chainPath)
  if not self._pieceType then
    return true
  end
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  for index = 1, #chainPath do
    local pos = chainPath[index]
    local gridPieceType = boardCmpt:GetPieceType(pos)
    if gridPieceType == self._pieceType then
      return true
    end
  end
  return false
end

function BuffLogicPlayEffectWithChainMove:_OnPlayerMoveStart(notify)
  local notifyType = notify:GetNotifyType()
  local typeParam = {}
  local e = self._buffInstance:Entity()
  local teamEntity = e:Pet():GetOwnerTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  local notifyPos = chainPath[1]
  local isStart = true
  local isEnd = notifyPos == chainPath[#chainPath]
  local moveEffectID = self._normalEffectID
  if self._useType == PlayEffectWithChainMoveType.Zhongxu then
    local teamCmpt = teamEntity:Team()
    local isTeamLeader = teamCmpt:IsTeamLeaderByEntityId(e:GetID())
    typeParam.isTeamLeader = isTeamLeader
    typeParam.chainPathCount = #chainPath
    typeParam.specialParam = self._zhongxuSpecialParam
    local buffResult = BuffResultPlayEffectWithChainMove:New(notifyType, notifyPos, isStart, isEnd, self._permanentEffectID, moveEffectID, self._useType, typeParam)
    return buffResult
  end
end
