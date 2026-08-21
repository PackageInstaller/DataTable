_class("NTMonsterMoveOneFinish", INotifyBase)
NTMonsterMoveOneFinish = NTMonsterMoveOneFinish

function NTMonsterMoveOneFinish:Constructor(entity, passedGrids, walkPos, oldPos)
  self._ownerEntity = entity
  self._passedGrids = passedGrids
  self._walkPos = walkPos
  self._oldPos = oldPos
end

function NTMonsterMoveOneFinish:GetNotifyType()
  return NotifyType.MonsterMoveOneFinish
end

function NTMonsterMoveOneFinish:GetNotifyEntity()
  return self._ownerEntity
end

function NTMonsterMoveOneFinish:GetCreateTrapGrids()
  return self._passedGrids
end

function NTMonsterMoveOneFinish:GetWalkPos()
  return self._walkPos
end

function NTMonsterMoveOneFinish:GetOldPos()
  return self._oldPos
end

function NTMonsterMoveOneFinish:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._ownerEntity, self._oldPos, self._walkPos, self:GetNotifyType())
end

_class("NTMonsterIsMoving", INotifyBase)
NTMonsterIsMoving = NTMonsterIsMoving

function NTMonsterIsMoving:Constructor(entity, posSelf)
  self._ownerEntity = entity
  self._posSelf = posSelf
end

function NTMonsterIsMoving:GetNotifyType()
  return NotifyType.MonsterIsMoving
end

function NTMonsterIsMoving:GetNotifyEntity()
  return self._ownerEntity
end

function NTMonsterIsMoving:GetPos()
  return self._posSelf
end

_class("NTPlayerFirstMoveEnd", INotifyBase)
NTPlayerFirstMoveEnd = NTPlayerFirstMoveEnd

function NTPlayerFirstMoveEnd:Constructor(entity, pos)
  self._ownerEntity = entity
  self._gridPos = pos
end

function NTPlayerFirstMoveEnd:GetNotifyType()
  return NotifyType.PlayerFirstMoveEnd
end

function NTPlayerFirstMoveEnd:GetNotifyEntity()
  return self._ownerEntity
end

function NTPlayerFirstMoveEnd:GetCreateTrapGrids()
  return {
    self._gridPos
  }
end

function NTPlayerFirstMoveEnd:NeedCheckGameTurn()
  return true
end

_class("NTPlayerEachMoveStart", INotifyBase)
NTPlayerEachMoveStart = NTPlayerEachMoveStart

function NTPlayerEachMoveStart:Constructor(entity, pos, pieceType, chainIndex, isPetActiveLinkLine)
  self._entity = entity
  self._pos = pos
  self._pieceType = pieceType
  self._chainIndex = chainIndex
  self._isPetActiveLinkLine = isPetActiveLinkLine
end

function NTPlayerEachMoveStart:GetNotifyType()
  return NotifyType.PlayerEachMoveStart
end

function NTPlayerEachMoveStart:GetPos()
  return self._pos
end

function NTPlayerEachMoveStart:GetPosPieceType()
  return self._pieceType
end

function NTPlayerEachMoveStart:GetEntityID()
  return self._entity:GetID()
end

function NTPlayerEachMoveStart:GetNotifyEntity()
  return self._entity
end

function NTPlayerEachMoveStart:GetChainIndex()
  return self._chainIndex
end

function NTPlayerEachMoveStart:NeedCheckGameTurn()
  return true
end

function NTPlayerEachMoveStart:IsPetActiveLinkLine()
  return self._isPetActiveLinkLine
end

_class("NTPlayerEachMoveEnd", INotifyBase)
NTPlayerEachMoveEnd = NTPlayerEachMoveEnd

function NTPlayerEachMoveEnd:Constructor(entity, posNew, pieceType, posOld, chainIndex, isPetActiveLinkLine)
  self._entity = entity
  self._posOld = posOld
  self._posNew = posNew
  self._pieceType = pieceType
  self._chainIndex = chainIndex
  self._isPetActiveLinkLine = isPetActiveLinkLine
end

function NTPlayerEachMoveEnd:GetNotifyType()
  return NotifyType.PlayerEachMoveEnd
end

function NTPlayerEachMoveEnd:GetPos()
  return self._posNew
end

function NTPlayerEachMoveEnd:GetPosNew()
  return self._posNew
end

function NTPlayerEachMoveEnd:GetOldPos()
  return self._posOld
end

function NTPlayerEachMoveEnd:GetPosPieceType()
  return self._pieceType
end

function NTPlayerEachMoveEnd:GetEntityID()
  return self._entity:GetID()
end

function NTPlayerEachMoveEnd:GetNotifyEntity()
  return self._entity
end

function NTPlayerEachMoveEnd:SetPieceEffectType(pieceEffectType)
  self._pieceEffectType = pieceEffectType
end

function NTPlayerEachMoveEnd:GetPieceEffectType()
  return self._pieceEffectType
end

function NTPlayerEachMoveEnd:GetChainIndex()
  return self._chainIndex
end

function NTPlayerEachMoveEnd:NeedCheckGameTurn()
  return true
end

function NTPlayerEachMoveEnd:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._entity, self._posOld, self._posNew, self:GetNotifyType())
end

function NTPlayerEachMoveEnd:GetNotifyPos()
  return self._posNew
end

function NTPlayerEachMoveEnd:GetAttackPos()
  return self._posNew
end

function NTPlayerEachMoveEnd:IsPetActiveLinkLine()
  return self._isPetActiveLinkLine
end

_class("NTPetChainMoveBegin", INotifyBase)
NTPetChainMoveBegin = NTPetChainMoveBegin

function NTPetChainMoveBegin:Constructor(entity, posNew, pieceType, posOld, chainIndex)
  self._entity = entity
  self._posOld = posOld
  self._posNew = posNew
  self._pieceType = pieceType
  self._chainIndex = chainIndex
end

function NTPetChainMoveBegin:GetNotifyType()
  return NotifyType.PetChainMoveBegin
end

function NTPetChainMoveBegin:GetPos()
  return self._posNew
end

function NTPetChainMoveBegin:GetPosPieceType()
  return self._pieceType
end

function NTPetChainMoveBegin:GetEntityID()
  return self._entity:GetID()
end

function NTPetChainMoveBegin:GetNotifyEntity()
  return self._entity
end

function NTPetChainMoveBegin:SetPieceEffectType(pieceEffectType)
  self._pieceEffectType = pieceEffectType
end

function NTPetChainMoveBegin:GetPieceEffectType()
  return self._pieceEffectType
end

function NTPetChainMoveBegin:GetChainIndex()
  return self._chainIndex
end

function NTPetChainMoveBegin:NeedCheckGameTurn()
  return true
end

function NTPetChainMoveBegin:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._entity, self._posOld, self._posNew, self:GetNotifyType())
end

_class("NTTeamLeaderEachMoveStart", INotifyBase)
NTTeamLeaderEachMoveStart = NTTeamLeaderEachMoveStart

function NTTeamLeaderEachMoveStart:Constructor(entity, pos, pieceType, oldPos)
  self._entity = entity
  self._pos = pos
  self._pieceType = pieceType
  self._oldPos = oldPos
end

function NTTeamLeaderEachMoveStart:GetNotifyType()
  return NotifyType.TeamLeaderEachMoveStart
end

function NTTeamLeaderEachMoveStart:GetPos()
  return self._pos
end

function NTTeamLeaderEachMoveStart:GetPosPieceType()
  return self._pieceType
end

function NTTeamLeaderEachMoveStart:GetEntityID()
  return self._entity:GetID()
end

function NTTeamLeaderEachMoveStart:NeedCheckGameTurn()
  return true
end

function NTTeamLeaderEachMoveStart:GetNotifyEntity()
  return self._entity
end

function NTTeamLeaderEachMoveStart:GetOldPos()
  return self._oldPos
end

_class("NTTeamEachMoveStart", NTTeamLeaderEachMoveStart)
NTTeamEachMoveStart = NTTeamEachMoveStart

function NTTeamEachMoveStart:GetNotifyType()
  return NotifyType.TeamEachMoveStart
end

_class("NTTeamLeaderEachMoveEnd", INotifyBase)
NTTeamLeaderEachMoveEnd = NTTeamLeaderEachMoveEnd

function NTTeamLeaderEachMoveEnd:Constructor(entity, pos, pieceType, oldPos)
  self._entity = entity
  self._pos = pos
  self._pieceType = pieceType
  self._oldPos = oldPos
end

function NTTeamLeaderEachMoveEnd:GetNotifyType()
  return NotifyType.TeamLeaderEachMoveEnd
end

function NTTeamLeaderEachMoveEnd:GetPos()
  return self._pos
end

function NTTeamLeaderEachMoveEnd:GetPosPieceType()
  return self._pieceType
end

function NTTeamLeaderEachMoveEnd:GetEntityID()
  return self._entity:GetID()
end

function NTTeamLeaderEachMoveEnd:GetNotifyEntity()
  return self._entity
end

function NTTeamLeaderEachMoveEnd:SetPieceEffectType(pieceEffectType)
  self._pieceEffectType = pieceEffectType
end

function NTTeamLeaderEachMoveEnd:GetPieceEffectType()
  return self._pieceEffectType
end

function NTTeamLeaderEachMoveEnd:NeedCheckGameTurn()
  return true
end

function NTTeamLeaderEachMoveEnd:GetOldPos()
  return self._oldPos
end

_class("NTTeamEachMoveEnd", NTTeamLeaderEachMoveEnd)
NTTeamEachMoveEnd = NTTeamEachMoveEnd

function NTTeamEachMoveEnd:GetNotifyType()
  return NotifyType.TeamEachMoveEnd
end

_class("NTTeleport", INotifyBase)
NTTeleport = NTTeleport

function NTTeleport:Constructor(entity, posOld, posNew)
  self._ownerEntity = entity
  self._posOld = posOld
  self._posNew = posNew
end

function NTTeleport:GetNotifyType()
  return NotifyType.Teleport
end

function NTTeleport:GetNotifyEntity()
  return self._ownerEntity
end

function NTTeleport:GetPosOld()
  return self._posOld
end

function NTTeleport:GetPosNew()
  return self._posNew
end

function NTTeleport:NeedCheckGameTurn()
  return true
end

function NTTeleport:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._ownerEntity, self._posOld, self._posNew, self:GetNotifyType())
end

_class("NTHitBackEnd", INotifyBase)
NTHitBackEnd = NTHitBackEnd

function NTHitBackEnd:Constructor(attacker, defender, posStart, posEnd, dir, realHitBackDistance)
  self._attacker = attacker
  self._defender = defender
  self._posStart = posStart
  self._posEnd = posEnd
  self._dir = dir
  self._realHitBackDistance = realHitBackDistance
end

function NTHitBackEnd:GetNotifyType()
  return NotifyType.HitBackEnd
end

function NTHitBackEnd:GetNotifyEntity()
  return self._attacker
end

function NTHitBackEnd:GetDefender()
  return self._defender
end

function NTHitBackEnd:GetDefenderId()
  return self._defender:GetID()
end

function NTHitBackEnd:GetPosStart()
  return self._posStart
end

function NTHitBackEnd:GetPosEnd()
  return self._posEnd
end

function NTHitBackEnd:GetDistance()
  return Vector2.Distance(self._posStart, self._posEnd)
end

function NTHitBackEnd:NeedCheckGameTurn()
  return true
end

function NTHitBackEnd:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._defender, self._posStart, self._posEnd, self:GetNotifyType())
end

function NTHitBackEnd:GetHitBackDir()
  return self._dir
end

_class("NTTractionEnd", INotifyBase)
NTTractionEnd = NTTractionEnd

function NTTractionEnd:Constructor(attacker, defender, posStart, posEnd, path)
  self._attacker = attacker
  self._defender = defender
  self._posStart = posStart
  self._posEnd = posEnd
  self._path = path
end

function NTTractionEnd:GetNotifyType()
  return NotifyType.TractionEnd
end

function NTTractionEnd:GetNotifyEntity()
  return self._attacker
end

function NTTractionEnd:GetDefender()
  return self._defender
end

function NTTractionEnd:GetDefenderId()
  return self._defender:GetID()
end

function NTTractionEnd:GetPosStart()
  return self._posStart
end

function NTTractionEnd:GetPosEnd()
  return self._posEnd
end

function NTTractionEnd:NeedCheckGameTurn()
  return true
end

function NTTractionEnd:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._defender, self._posStart, self._posEnd, self:GetNotifyType())
end

function NTTractionEnd:GetDistance()
  return Vector2.Distance(self._posStart, self._posEnd)
end

_class("NTTransportEachMoveEnd", INotifyBase)
NTTransportEachMoveEnd = NTTransportEachMoveEnd

function NTTransportEachMoveEnd:Constructor(entity, posOld, posNew)
  self._ownerEntity = entity
  self._posOld = posOld
  self._posNew = posNew
end

function NTTransportEachMoveEnd:GetNotifyType()
  return NotifyType.TransportEachMoveEnd
end

function NTTransportEachMoveEnd:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._ownerEntity, self._posOld, self._posNew, self:GetNotifyType())
end

function NTTransportEachMoveEnd:GetNotifyEntity()
  return self._ownerEntity
end

function NTTransportEachMoveEnd:GetPosOld()
  return self._posOld
end

function NTTransportEachMoveEnd:GetPosNew()
  return self._posNew
end

_class("NTDimensionTransport", INotifyBase)
NTDimensionTransport = NTDimensionTransport

function NTDimensionTransport:Constructor(entity, posOld, posNew)
  self._ownerEntity = entity
  self._posOld = posOld
  self._posNew = posNew
end

function NTDimensionTransport:GetNotifyType()
  return NotifyType.DimensionTransport
end

function NTDimensionTransport:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._ownerEntity, self._posOld, self._posNew, self:GetNotifyType())
end

function NTDimensionTransport:GetNotifyEntity()
  return self._ownerEntity
end

function NTDimensionTransport:GetPosOld()
  return self._posOld
end

function NTDimensionTransport:GetPosNew()
  return self._posNew
end

_class("NTEntityMoveEnd", INotifyBase)
NTEntityMoveEnd = NTEntityMoveEnd

function NTEntityMoveEnd:Constructor(entity, posOld, posNew, parentNotifyType)
  self._ownerEntity = entity
  self._posOld = posOld
  self._posNew = posNew
  self._parentNotifyType = parentNotifyType
end

function NTEntityMoveEnd:GetNotifyType()
  return NotifyType.EntityMoveEnd
end

function NTEntityMoveEnd:GetParentNotifyType()
  return self._parentNotifyType
end

function NTEntityMoveEnd:GetNotifyEntity()
  return self._ownerEntity
end

function NTEntityMoveEnd:GetPosOld()
  return self._posOld
end

function NTEntityMoveEnd:GetPosNew()
  return self._posNew
end

_class("NTPlayerMoveStart", INotifyBase)
NTPlayerMoveStart = NTPlayerMoveStart

function NTPlayerMoveStart:Constructor()
end

function NTPlayerMoveStart:GetNotifyType()
  return NotifyType.PlayerMoveStart
end

function NTPlayerMoveStart:SetChainCount(chainCount)
  self._chainCount = chainCount
end

function NTPlayerMoveStart:GetChainCount()
  return self._chainCount
end

function NTPlayerMoveStart:SetChainPathType(type)
  self._elementType = type
end

function NTPlayerMoveStart:GetChainPathType()
  return self._elementType
end

function NTPlayerMoveStart:SetTeamEntity(e)
  self._teamEntity = e
end

function NTPlayerMoveStart:GetTeamEntity()
  return self._teamEntity
end

function NTPlayerMoveStart:GetNotifyEntity()
  return self._teamEntity
end

_class("NTSyncMoveEachMoveEnd", INotifyBase)
NTSyncMoveEachMoveEnd = NTSyncMoveEachMoveEnd

function NTSyncMoveEachMoveEnd:Constructor(entity, posNew, posOld, pathIndex)
  self._entity = entity
  self._posNew = posNew
  self._posOld = posOld
  self._pathIndex = pathIndex
end

function NTSyncMoveEachMoveEnd:GetNotifyType()
  return NotifyType.SyncMoveEachMoveEnd
end

function NTSyncMoveEachMoveEnd:GetPos()
  return self._posNew
end

function NTSyncMoveEachMoveEnd:GetOldPos()
  return self._posOld
end

function NTSyncMoveEachMoveEnd:GetEntityID()
  return self._entity:GetID()
end

function NTSyncMoveEachMoveEnd:GetNotifyEntity()
  return self._entity
end

function NTSyncMoveEachMoveEnd:NeedCheckGameTurn()
  return true
end

function NTSyncMoveEachMoveEnd:GetNotifyPos()
  return self._posNew
end

function NTSyncMoveEachMoveEnd:GetPathIndex()
  return self._pathIndex
end

_class("NTForceMovement", INotifyBase)
NTForceMovement = NTForceMovement

function NTForceMovement:Constructor(entity, posOld, posNew)
  self._ownerEntity = entity
  self._posOld = posOld
  self._posNew = posNew
end

function NTForceMovement:GetNotifyType()
  return NotifyType.ForceMovement
end

function NTForceMovement:GetNotifyEntity()
  return self._ownerEntity
end

function NTForceMovement:GetPosOld()
  return self._posOld
end

function NTForceMovement:GetPosNew()
  return self._posNew
end

function NTForceMovement:NeedCheckGameTurn()
  return true
end

function NTForceMovement:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._ownerEntity, self._posOld, self._posNew, self:GetNotifyType())
end

_class("NTSnakeHeadMoved", INotifyBase)
NTSnakeHeadMoved = NTSnakeHeadMoved

function NTSnakeHeadMoved:Constructor(entity, posNew, posOld)
  self._entity = entity
  self._posOld = posOld
  self._posNew = posNew
end

function NTSnakeHeadMoved:GetNotifyType()
  return NotifyType.SnakeHeadMoved
end

function NTSnakeHeadMoved:GetPos()
  return self._posNew
end

function NTSnakeHeadMoved:GetOldPos()
  return self._posOld
end

function NTSnakeHeadMoved:GetEntityID()
  return self._entity:GetID()
end

function NTSnakeHeadMoved:GetNotifyEntity()
  return self._entity
end

function NTSnakeHeadMoved:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._entity, self._posOld, self._posNew, self:GetNotifyType())
end

_class("NTSnakeTailMoved", INotifyBase)
NTSnakeTailMoved = NTSnakeTailMoved

function NTSnakeTailMoved:Constructor(entity, posNew, posOld)
  self._entity = entity
  self._posOld = posOld
  self._posNew = posNew
end

function NTSnakeTailMoved:GetNotifyType()
  return NotifyType.SnakeTailMoved
end

function NTSnakeTailMoved:GetPos()
  return self._posNew
end

function NTSnakeTailMoved:GetOldPos()
  return self._posOld
end

function NTSnakeTailMoved:GetEntityID()
  return self._entity:GetID()
end

function NTSnakeTailMoved:GetNotifyEntity()
  return self._entity
end

function NTSnakeTailMoved:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._entity, self._posOld, self._posNew, self:GetNotifyType())
end

_class("NTMonsterSkillMoved", INotifyBase)
NTMonsterSkillMoved = NTMonsterSkillMoved

function NTMonsterSkillMoved:Constructor(entity, posNew, posOld)
  self._entity = entity
  self._posOld = posOld
  self._posNew = posNew
end

function NTMonsterSkillMoved:GetNotifyType()
  return NotifyType.MonsterSkillMoved
end

function NTMonsterSkillMoved:GetPos()
  return self._posNew
end

function NTMonsterSkillMoved:GetOldPos()
  return self._posOld
end

function NTMonsterSkillMoved:GetEntityID()
  return self._entity:GetID()
end

function NTMonsterSkillMoved:GetNotifyEntity()
  return self._entity
end

function NTMonsterSkillMoved:GetSubordinateNotify()
  return NTEntityMoveEnd:New(self._entity, self._posOld, self._posNew, self:GetNotifyType())
end

_class("NTAfterPieceRefreshBeginChainSkill", INotifyBase)
NTAfterPieceRefreshBeginChainSkill = NTAfterPieceRefreshBeginChainSkill

function NTAfterPieceRefreshBeginChainSkill:Constructor(entity, chainPath)
  self._entity = entity
  self._chainPath = chainPath
end

function NTAfterPieceRefreshBeginChainSkill:GetChainPathCount()
  return #self._chainPath
end

function NTAfterPieceRefreshBeginChainSkill:GetBeginPos()
  return self._chainPath[1]
end

function NTAfterPieceRefreshBeginChainSkill:GetEntityID()
  return self._entity:GetID()
end

function NTAfterPieceRefreshBeginChainSkill:GetNotifyEntity()
  return self._entity
end

function NTAfterPieceRefreshBeginChainSkill:GetNotifyType()
  return NotifyType.AfterPieceRefreshBeginChainSkill
end
