require("notify_type")
_class("NTBuffLoad", INotifyBase)
NTBuffLoad = NTBuffLoad

function NTBuffLoad:Constructor(enity, casterEntityID)
  self._enity = enity
  self._casterID = casterEntityID
end

function NTBuffLoad:GetNotifyType()
  return NotifyType.BuffLoad
end

function NTBuffLoad:GetNotifyEntity()
  return self._enity
end

function NTBuffLoad:GetCasterEntityID()
  return self._casterID
end

_class("NTBuffUnload", INotifyBase)
NTBuffUnload = NTBuffUnload

function NTBuffUnload:Constructor(enity)
  self._enity = enity
end

function NTBuffUnload:GetNotifyType()
  return NotifyType.BuffUnload
end

function NTBuffUnload:GetNotifyEntity()
  return self._enity
end

_class("NTGameStart", INotifyBase)
NTGameStart = NTGameStart

function NTGameStart:Constructor()
end

function NTGameStart:GetNotifyType()
  return NotifyType.GameStart
end

_class("NTMonsterTurnStart", INotifyBase)
NTMonsterTurnStart = NTMonsterTurnStart

function NTMonsterTurnStart:Constructor()
end

function NTMonsterTurnStart:GetNotifyType()
  return NotifyType.MonsterTurnStart
end

_class("NTMonsterTurnAfterAddBuffRound", INotifyBase)
NTMonsterTurnAfterAddBuffRound = NTMonsterTurnAfterAddBuffRound

function NTMonsterTurnAfterAddBuffRound:Constructor()
end

function NTMonsterTurnAfterAddBuffRound:GetNotifyType()
  return NotifyType.MonsterTurnAfterAddBuffRound
end

_class("NTMonsterTurnAfterDelayedAddBuffRound", INotifyBase)
NTMonsterTurnAfterDelayedAddBuffRound = NTMonsterTurnAfterDelayedAddBuffRound

function NTMonsterTurnAfterDelayedAddBuffRound:GetNotifyType()
  return NotifyType.MonsterTurnAfterDelayedAddBuffRound
end

_class("NTMonsterTurnEnd", INotifyBase)
NTMonsterTurnEnd = NTMonsterTurnEnd

function NTMonsterTurnEnd:Constructor(entity)
  self._ownerEntity = entity
end

function NTMonsterTurnEnd:GetNotifyType()
  return NotifyType.MonsterTurnEnd
end

function NTMonsterTurnEnd:GetNotifyEntity()
  return self._ownerEntity
end

_class("NTMonsterShow", INotifyBase)
NTMonsterShow = NTMonsterShow

function NTMonsterShow:Constructor(monster_entity)
  self.monster_entity = monster_entity
end

function NTMonsterShow:GetNotifyType()
  return NotifyType.MonsterShow
end

function NTMonsterShow:GetNotifyEntity()
  return self.monster_entity
end

_class("NTMonsterDead", INotifyBase)
NTMonsterDead = NTMonsterDead

function NTMonsterDead:Constructor(monsterEntity)
  self._ownerEntity = monsterEntity
end

function NTMonsterDead:GetNotifyType()
  return NotifyType.MonsterDead
end

function NTMonsterDead:GetNotifyEntity()
  return self._ownerEntity
end

_class("NTMonsterDeadStart", INotifyBase)
NTMonsterDeadStart = NTMonsterDeadStart

function NTMonsterDeadStart:Constructor(monsterEntity)
  self._ownerEntity = monsterEntity
  self._defender = monsterEntity
end

function NTMonsterDeadStart:GetNotifyType()
  return NotifyType.MonsterDeadStart
end

function NTMonsterDeadStart:GetNotifyEntity()
  return self._ownerEntity
end

function NTMonsterDeadStart:GetDefenderEntity()
  return self._defender
end

_class("NTMonsterDeadEnd", INotifyBase)
NTMonsterDeadEnd = NTMonsterDeadEnd

function NTMonsterDeadEnd:Constructor(monsterEntity)
  self._ownerEntity = monsterEntity
  self._defender = monsterEntity
end

function NTMonsterDeadEnd:GetNotifyType()
  return NotifyType.MonsterDeadEnd
end

function NTMonsterDeadEnd:GetNotifyEntity()
  return self._ownerEntity
end

function NTMonsterDeadEnd:GetDefenderEntity()
  return self._defender
end

_class("NTPlayerTurnStart", INotifyBase)
NTPlayerTurnStart = NTPlayerTurnStart

function NTPlayerTurnStart:Constructor(teamEntity, formerTeamOrder)
  self._teamEntity = teamEntity
  self._formerTeamOrder = formerTeamOrder
end

function NTPlayerTurnStart:GetNotifyEntity()
  return self._teamEntity
end

function NTPlayerTurnStart:NeedCheckGameTurn()
  return true
end

function NTPlayerTurnStart:GetNotifyType()
  return NotifyType.PlayerTurnStart
end

function NTPlayerTurnStart:GetFormerTeamOrder()
  return self._formerTeamOrder
end

_class("NTPlayerTurnBuffAddRoundEnd", INotifyBase)
NTPlayerTurnBuffAddRoundEnd = NTPlayerTurnBuffAddRoundEnd

function NTPlayerTurnBuffAddRoundEnd:Constructor(teamEntity)
  self._teamEntity = teamEntity
end

function NTPlayerTurnBuffAddRoundEnd:GetNotifyType()
  return NotifyType.PlayerTurnBuffAddRoundEnd
end

function NTPlayerTurnBuffAddRoundEnd:GetNotifyEntity()
  return self._teamEntity
end

function NTPlayerTurnBuffAddRoundEnd:NeedCheckGameTurn()
  return true
end

_class("NTPlayerTurnBuffAddRoundEndAfter", NTPlayerTurnBuffAddRoundEnd)
NTPlayerTurnBuffAddRoundEndAfter = NTPlayerTurnBuffAddRoundEndAfter

function NTPlayerTurnBuffAddRoundEndAfter:GetNotifyType()
  return NotifyType.PlayerTurnBuffAddRoundEndAfter
end

_class("NTPlayerTurnStartLast", INotifyBase)
NTPlayerTurnStartLast = NTPlayerTurnStartLast

function NTPlayerTurnStartLast:Constructor(teamEntity)
  self._teamEntity = teamEntity
end

function NTPlayerTurnStartLast:GetNotifyType()
  return NotifyType.PlayerTurnStartLast
end

function NTPlayerTurnStartLast:GetNotifyEntity()
  return self._teamEntity
end

function NTPlayerTurnStartLast:NeedCheckGameTurn()
  return true
end

_class("NTPlayerTurnEnd", INotifyBase)
NTPlayerTurnEnd = NTPlayerTurnEnd

function NTPlayerTurnEnd:Constructor(teamEntity)
  self._teamEntity = teamEntity
end

function NTPlayerTurnEnd:GetNotifyType()
  return NotifyType.PlayerTurnEnd
end

function NTPlayerTurnEnd:GetNotifyEntity()
  return self._teamEntity
end

function NTPlayerTurnEnd:NeedCheckGameTurn()
  return true
end

_class("NTPlayerPickDrop", INotifyBase)
NTPlayerPickDrop = NTPlayerPickDrop

function NTPlayerPickDrop:Constructor()
end

function NTPlayerPickDrop:GetNotifyType()
  return NotifyType.PlayerPickDrop
end

_class("NTPlayerSuperChain", INotifyBase)
NTPlayerSuperChain = NTPlayerSuperChain

function NTPlayerSuperChain:Constructor()
end

function NTPlayerSuperChain:GetNotifyType()
  return NotifyType.PlayerSuperChain
end

_class("NTMonsterSkillDamageStart", INotifyBase)
NTMonsterSkillDamageStart = NTMonsterSkillDamageStart

function NTMonsterSkillDamageStart:Constructor(monster_entity, skillId)
  self._monster_entity = monster_entity
  self._skillId = skillId
end

function NTMonsterSkillDamageStart:GetNotifyType()
  return NotifyType.MonsterSkillDamageStart
end

function NTMonsterSkillDamageStart:GetNotifyEntity()
  return self._monster_entity
end

function NTMonsterSkillDamageStart:GetSkillID()
  return self._skillId
end

_class("NTMonsterSkillDamageEnd", INotifyBase)
NTMonsterSkillDamageEnd = NTMonsterSkillDamageEnd

function NTMonsterSkillDamageEnd:Constructor(monster_entity, skillId)
  self._monster_entity = monster_entity
  self._skillId = skillId
end

function NTMonsterSkillDamageEnd:GetNotifyType()
  return NotifyType.MonsterSkillDamageEnd
end

function NTMonsterSkillDamageEnd:GetNotifyEntity()
  return self._monster_entity
end

function NTMonsterSkillDamageEnd:GetSkillID()
  return self._skillId
end

_class("NTRoundTurnEnd", INotifyBase)
NTRoundTurnEnd = NTRoundTurnEnd

function NTRoundTurnEnd:Constructor(team)
  self._enemyTeam = team
end

function NTRoundTurnEnd:GetNotifyType()
  return NotifyType.RoundTurnEnd
end

function NTRoundTurnEnd:GetNotifyEntity()
  return self._enemyTeam
end

_class("NTWaveEnter", INotifyBase)
NTWaveEnter = NTWaveEnter

function NTWaveEnter:Constructor(waveNum)
  self._waveNum = waveNum
end

function NTWaveEnter:GetNotifyType()
  return NotifyType.WaveEnter
end

function NTWaveEnter:GetWaveNum()
  return self._waveNum
end

_class("NTWaveTurnStart", INotifyBase)
NTWaveTurnStart = NTWaveTurnStart

function NTWaveTurnStart:Constructor(waveNum)
  self._waveNum = waveNum
end

function NTWaveTurnStart:GetNotifyType()
  return NotifyType.WaveTurnStart
end

function NTWaveTurnStart:GetWaveNum()
  return self._waveNum
end

_class("NTWaveTurnEnd", INotifyBase)
NTWaveTurnEnd = NTWaveTurnEnd

function NTWaveTurnEnd:Constructor(waveNum)
  self._waveNum = waveNum
end

function NTWaveTurnEnd:GetNotifyType()
  return NotifyType.WaveTurnEnd
end

function NTWaveTurnEnd:GetWaveNum()
  return self._waveNum
end

_class("NTTrapSkillStart", INotifyBase)
NTTrapSkillStart = NTTrapSkillStart

function NTTrapSkillStart:Constructor(trapEntity, skillID, triggerEntity)
  self._trapEntity = trapEntity
  self._skillID = skillID
  self._triggerEntity = triggerEntity
  self._isActiveSkillFake = false
end

function NTTrapSkillStart:GetTriggerEntity()
  return self._triggerEntity
end

function NTTrapSkillStart:GetNotifyType()
  return NotifyType.TrapSkillStart
end

function NTTrapSkillStart:GetNotifyEntity()
  return self._trapEntity
end

function NTTrapSkillStart:GetSkillID()
  return self._skillID
end

function NTTrapSkillStart:GetPos()
  return self._trapEntity:GetGridPosition()
end

function NTTrapSkillStart:GetNotifyPos()
  return self._trapEntity:GetGridPosition()
end

function NTTrapSkillStart:GetPosPieceType()
  local boardCmpt = self._trapEntity._world:GetBoardEntity():Board()
  return boardCmpt:GetPieceType(self:GetPos())
end

function NTTrapSkillStart:SetIsActiveSkillFake(bActiveSkill)
  self._isActiveSkillFake = bActiveSkill
end

function NTTrapSkillStart:GetIsActiveSkillFake()
  return self._isActiveSkillFake
end

_class("NTTrapSkillEnd", INotifyBase)
NTTrapSkillEnd = NTTrapSkillEnd

function NTTrapSkillEnd:Constructor(trapEntity, skillID, triggerEntity)
  self._trapEntity = trapEntity
  self._skillID = skillID
  self._triggerEntity = triggerEntity
end

function NTTrapSkillEnd:GetTriggerEntity()
  return self._triggerEntity
end

function NTTrapSkillEnd:GetNotifyType()
  return NotifyType.TrapSkillEnd
end

function NTTrapSkillEnd:GetNotifyEntity()
  return self._trapEntity
end

function NTTrapSkillEnd:GetSkillID()
  return self._skillID
end

_class("NTActiveSkillDamageEnd", INotifyBase)
NTActiveSkillDamageEnd = NTActiveSkillDamageEnd

function NTActiveSkillDamageEnd:Constructor(attacker, damage)
  self._attacker = attacker
  self._damage = damage
end

function NTActiveSkillDamageEnd:GetNotifyType()
  return NotifyType.ActiveSkillDamageEnd
end

function NTActiveSkillDamageEnd:GetNotifyEntity()
  return self._attacker
end

function NTActiveSkillDamageEnd:GetDamage()
  return self._damage
end

function NTActiveSkillDamageEnd:NeedCheckGameTurn()
  return true
end

_class("NTChainSkillDamageEnd", INotifyBase)
NTChainSkillDamageEnd = NTChainSkillDamageEnd

function NTChainSkillDamageEnd:Constructor(attacker, damage, targetMap)
  self._attacker = attacker
  self._damage = damage
  self._targetMap = {}
  if targetMap then
    for _, eid in ipairs(targetMap) do
      self._targetMap[eid] = true
    end
  end
end

function NTChainSkillDamageEnd:GetNotifyType()
  return NotifyType.ChainSkillDamageEnd
end

function NTChainSkillDamageEnd:GetNotifyEntity()
  return self._attacker
end

function NTChainSkillDamageEnd:GetDamage()
  return self._damage
end

function NTChainSkillDamageEnd:GetTargetMap()
  return self._targetMap
end

function NTChainSkillDamageEnd:NeedCheckGameTurn()
  return true
end

function NTChainSkillDamageEnd:SetChainCount(chainCount)
  self._chainCount = chainCount
end

function NTChainSkillDamageEnd:GetChainCount()
  return self._chainCount
end

_class("NTMonsterAttackOrSkillDamageEnd", INotifyBase)
NTMonsterAttackOrSkillDamageEnd = NTMonsterAttackOrSkillDamageEnd

function NTMonsterAttackOrSkillDamageEnd:Constructor(attacker, damage)
  self._attacker = attacker
  self._damage = damage
end

function NTMonsterAttackOrSkillDamageEnd:GetNotifyType()
  return NotifyType.MonsterAttackOrSkillDamageEnd
end

function NTMonsterAttackOrSkillDamageEnd:GetNotifyEntity()
  return self._attacker
end

function NTMonsterAttackOrSkillDamageEnd:GetDamage()
  return self._damage
end

_class("NTBreakHPLock", INotifyBase)
NTBreakHPLock = NTBreakHPLock

function NTBreakHPLock:Constructor(notifyEntity, isUnlockHP)
  self._notifyEntity = notifyEntity
  self._isUnlockHP = isUnlockHP
end

function NTBreakHPLock:GetNotifyType()
  return NotifyType.BreakHPLock
end

function NTBreakHPLock:GetNotifyEntity()
  return self._notifyEntity
end

function NTBreakHPLock:GetIsUnlockHP()
  return self._isUnlockHP
end

_class("NTPowerReady", INotifyBase)
NTPowerReady = NTPowerReady

function NTPowerReady:Constructor(petEntity)
  self._petEntity = petEntity
end

function NTPowerReady:GetNotifyEntity()
  return self._petEntity
end

function NTPowerReady:GetNotifyType()
  return NotifyType.PowerReady
end

function NTPowerReady:NeedCheckGameTurn()
  return true
end

_class("NTCollectSouls", INotifyBase)
NTCollectSouls = NTCollectSouls

function NTCollectSouls:Constructor(casterEntity, soulNum, targetEntityList)
  self._soulNum = soulNum
  self._casterEntity = casterEntity
  self._targetEntityList = targetEntityList
end

function NTCollectSouls:GetNotifyType()
  return NotifyType.CollectSouls
end

function NTCollectSouls:GetSoulNum()
  return self._soulNum
end

function NTCollectSouls:GetNotifyEntity()
  return self._casterEntity
end

function NTCollectSouls:GetTargetEntityList()
  return self._targetEntityList
end

function NTCollectSouls:NeedCheckGameTurn()
  return true
end

_class("NTHPLock", INotifyBase)
NTHPLock = NTHPLock

function NTHPLock:Constructor(index, percent, notifyEntity)
  self._lockPercent = percent
  self._index = index
  self._notifyEntity = notifyEntity
end

function NTHPLock:GetNotifyType()
  return NotifyType.HPLock
end

function NTHPLock:GetLockPercent()
  return self._lockPercent
end

function NTHPLock:GetIndex()
  return self._index
end

function NTHPLock:GetNotifyEntity()
  return self._notifyEntity
end

function NTHPLock:SetNotifyEntity(notifyEntity)
  self._notifyEntity = notifyEntity
end

_class("NTNotifyTriggerBuff", INotifyBase)
NTNotifyTriggerBuff = NTNotifyTriggerBuff

function NTNotifyTriggerBuff:Constructor(entity)
  self._entity = entity
end

function NTNotifyTriggerBuff:GetNotifyType()
  return NotifyType.NotifyTriggerBuff
end

function NTNotifyTriggerBuff:GetNotifyEntity()
  return self._entity
end

_class("NTNotifyTrainFirstRowPos", INotifyBase)
NTNotifyTrainFirstRowPos = NTNotifyTrainFirstRowPos

function NTNotifyTrainFirstRowPos:Constructor(firstRowPosList, entity)
  self._entity = entity
  self._firstRowPosList = firstRowPosList
end

function NTNotifyTrainFirstRowPos:GetNotifyType()
  return NotifyType.NotifyTrainFirstRowPos
end

function NTNotifyTrainFirstRowPos:GetData()
  return self._firstRowPosList
end

function NTNotifyTrainFirstRowPos:GetNotifyEntity()
  return self._entity
end

function NTNotifyTrainFirstRowPos:NeedCheckGameTurn()
  return true
end

_class("NTEachAddBuff", INotifyBase)
NTEachAddBuff = NTEachAddBuff

function NTEachAddBuff:Constructor(skillId, attacker, defender, attackRange)
  self._skillId = skillId
  self._attacker = attacker
  self._defender = defender
  self._attackRange = attackRange
end

function NTEachAddBuff:GetAttackerEntity()
  return self._attacker
end

function NTEachAddBuff:GetDefenderEntity()
  return self._defender
end

function NTEachAddBuff:GetAttackRange()
  return self._attackRange
end

function NTEachAddBuff:GetNotifyEntity()
  return self._attacker
end

function NTEachAddBuff:GetSkillID()
  return self._skillId
end

function NTEachAddBuff:NeedCheckGameTurn()
  return true
end

_class("NTEachAddBuffStart", NTEachAddBuff)
NTEachAddBuffStart = NTEachAddBuffStart

function NTEachAddBuffStart:GetNotifyType()
  return NotifyType.EachAddBuffStart
end

_class("NTEachAddBuffEnd", NTEachAddBuff)
NTEachAddBuffEnd = NTEachAddBuffEnd

function NTEachAddBuffEnd:Constructor(skillId, attacker, defender, attackRange, buffID, seqID)
  self._buffID = buffID
  self._seqID = seqID
end

function NTEachAddBuffEnd:GetNotifyType()
  return NotifyType.EachAddBuffEnd
end

function NTEachAddBuffEnd:GetBuffID()
  return self._buffID
end

function NTEachAddBuffEnd:GetBuffSeqID()
  return self._seqID
end

_class("NTRandAttackBegin", NotifyAttackBase)
NTRandAttackBegin = NTRandAttackBegin

function NTRandAttackBegin:Constructor(entity)
  self.entity = entity
end

function NTRandAttackBegin:GetNotifyEntity()
  return self.entity
end

function NTRandAttackBegin:NeedCheckGameTurn()
  return true
end

function NTRandAttackBegin:GetNotifyType()
  return NotifyType.RandAttackBegin
end

_class("NTRandAttackEnd", NotifyAttackBase)
NTRandAttackEnd = NTRandAttackEnd

function NTRandAttackEnd:Constructor(entity)
  self._entity = entity
end

function NTRandAttackEnd:GetNotifyEntity()
  return self._entity
end

function NTRandAttackEnd:NeedCheckGameTurn()
  return true
end

function NTRandAttackEnd:GetNotifyType()
  return NotifyType.RandAttackEnd
end

_class("NTTrapAction", INotifyBase)
NTTrapAction = NTTrapAction

function NTTrapAction:Constructor(entity, posAction)
  self._ownerEntity = entity
  self._posAction = posAction
end

function NTTrapAction:GetNotifyType()
  return NotifyType.TrapAction
end

function NTTrapAction:GetNotifyEntity()
  return self._ownerEntity
end

function NTTrapAction:GetPosAction()
  return self._posAction
end

_class("NTGridConvert_ConvertInfo", Object)
NTGridConvert_ConvertInfo = NTGridConvert_ConvertInfo

function NTGridConvert_ConvertInfo:Constructor(pos, before, after)
  self._pos = pos
  self._beforePieceType = before
  self._afterPieceType = after
end

function NTGridConvert_ConvertInfo:GetPos()
  return self._pos
end

function NTGridConvert_ConvertInfo:GetBeforePieceType()
  return self._beforePieceType
end

function NTGridConvert_ConvertInfo:GetAfterPieceType()
  return self._afterPieceType
end

_class("NTGridConvert", INotifyBase)
NTGridConvert = NTGridConvert

function NTGridConvert:Constructor(entity, convertInfoArray)
  self._entity = entity
  self._convertInfoArray = convertInfoArray
  self._convertPosInfoMap = {}
  if convertInfoArray then
    for _, convertInfo in ipairs(convertInfoArray) do
      local pos = convertInfo:GetPos()
      local x = pos.x
      local y = pos.y
      if not self._convertPosInfoMap[x] then
        self._convertPosInfoMap[x] = {}
      end
      self._convertPosInfoMap[x][y] = convertInfo
    end
  end
end

function NTGridConvert:SetSkillType(skillType)
  self._skillType = skillType
end

function NTGridConvert:GetSkillType()
  return self._skillType
end

function NTGridConvert:GetNotifyType()
  return NotifyType.GridConvert
end

function NTGridConvert:GetNotifyEntity()
  if self._entity and self._entity:HasSuperEntity() and self._entity:EntityType():IsSkillHolder() then
    return self._entity:GetSuperEntity()
  end
  return self._entity
end

function NTGridConvert:SetLinkLine(state)
  self._linkLine = state
end

function NTGridConvert:IsLinkLine()
  return self._linkLine == true
end

function NTGridConvert:GetConvertInfoAt(pos)
  return self._convertPosInfoMap[pos.x] and self._convertPosInfoMap[pos.x][pos.y] or nil
end

function NTGridConvert:GetConvertInfoArray()
  return self._convertInfoArray
end

function NTGridConvert:NeedCheckGameTurn()
  return true
end

function NTGridConvert:SetConvertEffectType(val)
  self._convertEffectType = val
end

function NTGridConvert:GetConvertEffectType()
  return self._convertEffectType
end

function NTGridConvert:SetConvertWaterCount(val)
  self._convertWaterCount = val
end

function NTGridConvert:GetConvertWaterCount()
  return self._convertWaterCount
end

function NTGridConvert:GetSubordinateNotify()
  local entity = self:GetNotifyEntity()
  if entity:HasMonsterID() then
    return
  end
  local type = self:GetConvertEffectType()
  if not table.icontains(BattleConst.GCSNotify_SkillEffectTypeList, type) then
    return
  end
  return NTGridConvertSubordinate:New(entity, self._convertInfoArray)
end

_class("NTEnterAuroraTime", INotifyBase)
NTEnterAuroraTime = NTEnterAuroraTime

function NTEnterAuroraTime:Constructor(chainPathStartPos, teamEntity)
  self._chainPathStartPos = chainPathStartPos
  self._teamEntity = teamEntity
end

function NTEnterAuroraTime:GetNotifyType()
  return NotifyType.EnterAuroraTime
end

function NTEnterAuroraTime:GetNotifyPos()
  return self._chainPathStartPos
end

function NTEnterAuroraTime:GetNotifyEntity()
  return self._teamEntity
end

function NTEnterAuroraTime:NeedCheckGameTurn()
  return true
end

_class("NTEnterAuroraTimeInChainSys", INotifyBase)
NTEnterAuroraTimeInChainSys = NTEnterAuroraTimeInChainSys

function NTEnterAuroraTimeInChainSys:Constructor(chainPathStartPos, teamEntity)
  self._chainPathStartPos = chainPathStartPos
  self._teamEntity = teamEntity
end

function NTEnterAuroraTimeInChainSys:GetNotifyType()
  return NotifyType.EnterAuroraTimeInChainSys
end

function NTEnterAuroraTimeInChainSys:GetNotifyPos()
  return self._chainPathStartPos
end

function NTEnterAuroraTimeInChainSys:GetNotifyEntity()
  return self._teamEntity
end

function NTEnterAuroraTimeInChainSys:NeedCheckGameTurn()
  return true
end

_class("NTRefreshGridOnPetMoveDone", INotifyBase)
NTRefreshGridOnPetMoveDone = NTRefreshGridOnPetMoveDone

function NTRefreshGridOnPetMoveDone:Constructor(oldChainPathGrid, newChainPathGrid, teamEntity)
  self._oldChainPathGrid = oldChainPathGrid
  self._newChainPathGrid = newChainPathGrid
  self._teamEntity = teamEntity
end

function NTRefreshGridOnPetMoveDone:GetNotifyType()
  return NotifyType.RefreshGridOnPetMoveDone
end

function NTRefreshGridOnPetMoveDone:GetOldChainPathGrid()
  return self._oldChainPathGrid
end

function NTRefreshGridOnPetMoveDone:GetNewChainPathGrid()
  return self._newChainPathGrid
end

function NTRefreshGridOnPetMoveDone:GetNotifyEntity()
  return self._teamEntity
end

function NTRefreshGridOnPetMoveDone:NeedCheckGameTurn()
  return true
end

_class("NTResetGridElement", INotifyBase)
NTResetGridElement = NTResetGridElement

function NTResetGridElement:Constructor(resetGridDataList, notifyEntity)
  self._resetGridDataList = resetGridDataList
  self._notifyEntity = notifyEntity
end

function NTResetGridElement:GetNotifyType()
  return NotifyType.ResetGridElement
end

function NTResetGridElement:GetNotifyEntity()
  return self._notifyEntity
end

function NTResetGridElement:GetResetGridDataList()
  return self._resetGridDataList
end

function NTResetGridElement:NeedCheckGameTurn()
  return true
end

_class("NTGameOver", INotifyBase)
NTGameOver = NTGameOver

function NTGameOver:Constructor(victory, defeatType)
  self.victory = victory
  self.defeatType = defeatType
end

function NTGameOver:GetNotifyType()
  return NotifyType.GameOver
end

function NTGameOver:GetVictory()
  return self.victory
end

function NTGameOver:GetDefeatType()
  return self.defeatType
end

_class("NTNotifyLayerChange", INotifyBase)
NTNotifyLayerChange = NTNotifyLayerChange

function NTNotifyLayerChange:Constructor(layerName, layer, count, notifyPos, entity, layerType, casterEntity)
  self.layerName = layerName
  self._layer = layer
  self._totalCount = count
  self._notifyPos = notifyPos
  self._entity = entity
  self._layerType = layerType
  self._casterEntity = casterEntity
end

function NTNotifyLayerChange:GetNotifyType()
  return NotifyType.NotifyLayerChange
end

function NTNotifyLayerChange:GetLayerName()
  return self.layerName
end

function NTNotifyLayerChange:GetLayer()
  return self._layer
end

function NTNotifyLayerChange:GetTotalCount()
  return self._totalCount
end

function NTNotifyLayerChange:GetNotifyPos()
  return self._notifyPos
end

function NTNotifyLayerChange:GetNotifyEntity()
  return self._entity
end

function NTNotifyLayerChange:SetChangeLayer(change)
  self._changeLayer = change
end

function NTNotifyLayerChange:GetChangeLayer()
  return self._changeLayer
end

function NTNotifyLayerChange:NeedCheckGameTurn()
  return false
end

function NTNotifyLayerChange:GetLayerType()
  return self._layerType
end

function NTNotifyLayerChange:GetCasterEntity()
  return self._casterEntity
end

function NTNotifyLayerChange:SetOverflowLayer(count)
  self._overflowLayer = count
end

function NTNotifyLayerChange:GetOverflowLayer()
  return self._overflowLayer or 0
end

_class("NTPetCreate", INotifyBase)
NTPetCreate = NTPetCreate

function NTPetCreate:Constructor(element, campID, entity, petJob)
  self.element = element
  self.campID = campID
  self._entity = entity
  self._petJob = petJob
end

function NTPetCreate:GetPetJob()
  return self._petJob
end

function NTPetCreate:GetNotifyType()
  return NotifyType.PetCreate
end

function NTPetCreate:GetNotifyEntity()
  return self._entity
end

function NTPetCreate:GetElement()
  return self.element
end

function NTPetCreate:GetCampID()
  return self.campID
end

_class("NTPetActiveSkillPreviousReady", INotifyBase)
NTPetActiveSkillPreviousReady = NTPetActiveSkillPreviousReady

function NTPetActiveSkillPreviousReady:GetNotifyType()
  return NotifyType.PetActiveSkillPreviousReady
end

function NTPetActiveSkillPreviousReady:Constructor(casterEntity)
  self._owner = casterEntity
end

function NTPetActiveSkillPreviousReady:GetNotifyEntity()
  return self._owner
end

function NTPetActiveSkillPreviousReady:NeedCheckGameTurn()
  return true
end

_class("NTReduceShieldLayer", INotifyBase)
NTReduceShieldLayer = NTReduceShieldLayer

function NTReduceShieldLayer:Constructor(entity, layer)
  self._notifyEntity = entity
  self._layer = layer
end

function NTReduceShieldLayer:GetNotifyType()
  return NotifyType.ReduceShieldLayer
end

function NTReduceShieldLayer:GetNotifyEntity()
  return self._notifyEntity
end

function NTReduceShieldLayer:GetNotifyLayer()
  return self._layer
end

_class("NTEachPetChainSkillFinish", INotifyBase)
NTEachPetChainSkillFinish = NTEachPetChainSkillFinish

function NTEachPetChainSkillFinish:Constructor()
end

function NTEachPetChainSkillFinish:GetNotifyType()
  return NotifyType.EachPetChainSkillFinish
end

function NTEachPetChainSkillFinish:GetNotifyEntity()
  return self._notifyEntity
end

function NTEachPetChainSkillFinish:SetNotifyEntity(entity)
  self._notifyEntity = entity
end

function NTEachPetChainSkillFinish:SetChainCount(cnt)
  self._chainCount = cnt
end

function NTEachPetChainSkillFinish:GetChainCount()
  return self._chainCount
end

function NTEachPetChainSkillFinish:NeedCheckGameTurn()
  return true
end

_class("NTChainPathSelectTarget", INotifyBase)
NTChainPathSelectTarget = NTChainPathSelectTarget

function NTChainPathSelectTarget:Constructor()
end

function NTChainPathSelectTarget:GetNotifyType()
  return NotifyType.ChainPathSelectTarget
end

function NTChainPathSelectTarget:GetNotifyEntity()
  return self._notifyEntity
end

function NTChainPathSelectTarget:SetNotifyEntity(entity)
  self._notifyEntity = entity
end

function NTChainPathSelectTarget:SetChainCount(cnt)
  self._chainCount = cnt
end

function NTChainPathSelectTarget:GetChainCount()
  return self._chainCount
end

function NTChainPathSelectTarget:NeedCheckGameTurn()
  return true
end

_class("NTWaitInput", INotifyBase)
NTWaitInput = NTWaitInput

function NTWaitInput:Constructor()
end

function NTWaitInput:GetNotifyType()
  return NotifyType.WaitInput
end

_class("NTAttachMonster", INotifyBase)

function NTAttachMonster:Constructor(casterEntity, targetEntity)
  self._casterEntity = casterEntity
  self._targetEntity = targetEntity
end

function NTAttachMonster:GetNotifyType()
  return NotifyType.AttachMonster
end

function NTAttachMonster:GetNotifyEntity()
  return self._casterEntity
end

function NTAttachMonster:GetDefenderEntity()
  return self._targetEntity
end

_class("NTChangeTeamLeader", INotifyBase)

function NTChangeTeamLeader:Constructor(teamLeader, oldTeamLeader)
  self._teamLeader = teamLeader
  self._oldTeamLeader = oldTeamLeader
end

function NTChangeTeamLeader:GetTeamLeaderPetPstID()
  return self._teamLeader:PetPstID():GetPetPstID()
end

function NTChangeTeamLeader:GetNotifyType()
  return NotifyType.ChangeTeamLeader
end

function NTChangeTeamLeader:GetNotifyEntity()
  return self._teamLeader
end

function NTChangeTeamLeader:NeedCheckGameTurn()
  return true
end

function NTChangeTeamLeader:GetNewTeamLeader()
  return self._teamLeader
end

function NTChangeTeamLeader:GetOldTeamLeader()
  return self._oldTeamLeader
end

_class("NTAddBuffEnd", INotifyBase)
NTAddBuffEnd = NTAddBuffEnd

function NTAddBuffEnd:Constructor(entity, buffseq, buffid, buffeff)
  self.entity = entity
  self.buffseq = buffseq
  self.buffid = buffid
  self.buffeff = buffeff
end

function NTAddBuffEnd:GetNotifyType()
  return NotifyType.AddBuffEnd
end

function NTAddBuffEnd:GetNotifyEntity()
  return self.entity
end

function NTAddBuffEnd:GetBuffSeq()
  return self.buffseq
end

function NTAddBuffEnd:GetBuffEffectType()
  return self.buffeff
end

function NTAddBuffEnd:GetBuffID()
  return self.buffid
end

function NTAddBuffEnd:NeedCheckGameTurn()
  return true
end

_class("NTRemoveBuffEnd", INotifyBase)
NTRemoveBuffEnd = NTRemoveBuffEnd

function NTRemoveBuffEnd:Constructor(entity, buffseq, buffid, buffeff)
  self.entity = entity
  self.buffseq = buffseq
  self.buffid = buffid
  self.buffeff = buffeff
end

function NTRemoveBuffEnd:GetNotifyType()
  return NotifyType.RemoveBuffEnd
end

function NTRemoveBuffEnd:GetNotifyEntity()
  return self._entity
end

function NTRemoveBuffEnd:GetBuffSeq()
  return self.buffseq
end

function NTRemoveBuffEnd:GetBuffEffectType()
  return self.buffeff
end

function NTRemoveBuffEnd:GetBuffID()
  return self.buffid
end

function NTRemoveBuffEnd:NeedCheckGameTurn()
  return true
end

_class("NTAddMatchLog", INotifyBase)
NTAddMatchLog = NTAddMatchLog

function NTAddMatchLog:Constructor(info)
  self._info = info
end

function NTAddMatchLog:GetNotifyType()
  return NotifyType.AddMatchLog
end

function NTAddMatchLog:GetMatchLogInfo()
  return self._info
end

_class("NTBeforeHighFrequencyDamageHit", INotifyBase)
NTBeforeHighFrequencyDamageHit = NTBeforeHighFrequencyDamageHit

function NTBeforeHighFrequencyDamageHit:Constructor(entity, hitIndex)
  self._ownerEntity = entity
  self._hitIndex = hitIndex
end

function NTBeforeHighFrequencyDamageHit:GetNotifyType()
  return NotifyType.BeforeHighFrequencyDamageHit
end

function NTBeforeHighFrequencyDamageHit:GetNotifyEntity()
  return self._ownerEntity
end

function NTBeforeHighFrequencyDamageHit:GetHitIndex()
  return self._hitIndex
end

function NTBeforeHighFrequencyDamageHit:NeedCheckGameTurn()
  return true
end

_class("NTAfterHighFrequencyDamageHit", INotifyBase)
NTAfterHighFrequencyDamageHit = NTAfterHighFrequencyDamageHit

function NTAfterHighFrequencyDamageHit:Constructor(entity, hitIndex)
  self._ownerEntity = entity
  self._hitIndex = hitIndex
end

function NTAfterHighFrequencyDamageHit:GetNotifyType()
  return NotifyType.AfterHighFrequencyDamageHit
end

function NTAfterHighFrequencyDamageHit:GetNotifyEntity()
  return self._ownerEntity
end

function NTAfterHighFrequencyDamageHit:GetHitIndex()
  return self._hitIndex
end

function NTAfterHighFrequencyDamageHit:NeedCheckGameTurn()
  return true
end

_class("NTBeforeMazeTeamLeaderSucceed", INotifyBase)
NTBeforeMazeTeamLeaderSucceed = NTBeforeMazeTeamLeaderSucceed

function NTBeforeMazeTeamLeaderSucceed:GetNotifyType()
  return NotifyType.BeforeMazeTeamLeaderSucceed
end

function NTBeforeMazeTeamLeaderSucceed:Constructor(e)
  self._entity = e
end

function NTBeforeMazeTeamLeaderSucceed:GetNotifyEntity()
  return self._entity
end

function NTBeforeMazeTeamLeaderSucceed:NeedCheckGameTurn()
  return true
end

_class("NTWaveSwitch", INotifyBase)
NTWaveSwitch = NTWaveSwitch

function NTWaveSwitch:Constructor(waveNum)
  self._waveNum = waveNum
end

function NTWaveSwitch:GetNotifyType()
  return NotifyType.WaveSwitch
end

function NTWaveSwitch:GetWaveNum()
  return self._waveNum
end

_class("NTWorldBossStageSwitch", INotifyBase)
NTWorldBossStageSwitch = NTWorldBossStageSwitch

function NTWorldBossStageSwitch:Constructor(stage)
  self._stage = stage
end

function NTWorldBossStageSwitch:GetNotifyType()
  return NotifyType.WorldBossStageSwitch
end

_class("NTResetGridFlushTrap", INotifyBase)
NTResetGridFlushTrap = NTResetGridFlushTrap

function NTResetGridFlushTrap:Constructor(trapList)
  self._trapList = trapList
end

function NTResetGridFlushTrap:GetNotifyType()
  return NotifyType.ResetGridFlushTrap
end

function NTResetGridFlushTrap:GetFlushTrapList()
  return self._trapList
end

_class("NTActiveSkillAntiAttack", INotifyBase)
NTActiveSkillAntiAttack = NTActiveSkillAntiAttack

function NTActiveSkillAntiAttack:Constructor(attacker)
  self._attacker = attacker
end

function NTActiveSkillAntiAttack:GetNotifyType()
  return NotifyType.ActiveSkillAntiAttack
end

function NTActiveSkillAntiAttack:GetNotifyEntity()
  return self._attacker
end

function NTActiveSkillAntiAttack:NeedCheckGameTurn()
  return false
end

_class("NTMonsterPostAntiAttack", INotifyBase)
NTMonsterPostAntiAttack = NTMonsterPostAntiAttack

function NTMonsterPostAntiAttack:Constructor(e)
  self._entity = e
end

function NTMonsterPostAntiAttack:GetNotifyType()
  return NotifyType.MonsterPostAntiAttack
end

function NTMonsterPostAntiAttack:GetNotifyEntity()
  return self._entity
end

_class("NTExitAuroraTime", INotifyBase)
NTExitAuroraTime = NTExitAuroraTime

function NTExitAuroraTime:GetNotifyType()
  return NotifyType.ExitAuroraTime
end

_class("NTTrapDead", INotifyBase)
NTTrapDead = NTTrapDead

function NTTrapDead:Constructor(e, trapID)
  self._entity = e
  self._trapID = trapID
end

function NTTrapDead:SetOwnerEntity(entity)
  self._ownerEntity = entity
end

function NTTrapDead:GetOwnerEntity()
  return self._ownerEntity
end

function NTTrapDead:GetTrapID()
  return self._trapID
end

function NTTrapDead:GetNotifyType()
  return NotifyType.TrapDead
end

function NTTrapDead:GetNotifyEntity()
  return self._entity
end

_class("NTTrapDeadStart", INotifyBase)
NTTrapDeadStart = NTTrapDeadStart

function NTTrapDeadStart:Constructor(e)
  self._entity = e
end

function NTTrapDeadStart:GetNotifyType()
  return NotifyType.TrapDeadStart
end

function NTTrapDeadStart:GetNotifyEntity()
  return self._entity
end

function NTTrapDeadStart:SetOwnerEntity(entity)
  self._ownerEntity = entity
end

function NTTrapDeadStart:GetOwnerEntity()
  return self._ownerEntity
end

_class("NTTrapShow", INotifyBase)
NTTrapShow = NTTrapShow

function NTTrapShow:Constructor(e, summoner)
  self._entity = e
  self._summoner = summoner
  self._isFirstSummon = false
end

function NTTrapShow:GetNotifyType()
  return NotifyType.TrapShow
end

function NTTrapShow:GetNotifyEntity()
  return self._entity
end

function NTTrapShow:SetIsFirstSummon(b)
  self._isFirstSummon = b
end

function NTTrapShow:IsFirstSummon()
  return self._isFirstSummon
end

function NTTrapShow:GetOwnerEntity()
  return self._summoner
end

_class("NTEnemyTurnStart", INotifyBase)
NTEnemyTurnStart = NTEnemyTurnStart

function NTEnemyTurnStart:Constructor(entity)
  self._enemyTeam = entity
end

function NTEnemyTurnStart:GetNotifyType()
  return NotifyType.EnemyTurnStart
end

function NTEnemyTurnStart:GetNotifyEntity()
  return self._enemyTeam
end

function NTEnemyTurnStart:NeedCheckGameTurn()
  return true
end

_class("NTEnemyTurnEnd", INotifyBase)
NTEnemyTurnEnd = NTEnemyTurnEnd

function NTEnemyTurnEnd:Constructor(entity)
  self._enemyTeam = entity
end

function NTEnemyTurnEnd:GetNotifyType()
  return NotifyType.EnemyTurnEnd
end

function NTEnemyTurnEnd:GetNotifyEntity()
  return self._enemyTeam
end

function NTEnemyTurnEnd:NeedCheckGameTurn()
  return true
end

_class("NTMonsterBuffDamageEnd", INotifyBase)
NTMonsterBuffDamageEnd = NTMonsterBuffDamageEnd

function NTMonsterBuffDamageEnd:Constructor(attacker, defender)
  self._attacker = attacker
  self._defender = defender
end

function NTMonsterBuffDamageEnd:GetNotifyType()
  return NotifyType.MonsterBuffDamageEnd
end

function NTMonsterBuffDamageEnd:GetNotifyEntity()
  return self._defender
end

function NTMonsterBuffDamageEnd:NeedCheckGameTurn()
  return false
end

_class("NTBeforeEntityAddBuff", INotifyBase)
NTBeforeEntityAddBuff = NTBeforeEntityAddBuff

function NTBeforeEntityAddBuff:Constructor(entity, buffId, buffEffectType)
  self._entity = entity
  self._buffId = buffId
  self._buffEffectType = buffEffectType
end

function NTBeforeEntityAddBuff:GetNotifyType()
  return NotifyType.BeforeEntityAddBuff
end

function NTBeforeEntityAddBuff:GetNotifyEntity()
  return self._entity
end

function NTBeforeEntityAddBuff:GetBuffId()
  return self._buffId
end

function NTBeforeEntityAddBuff:GetBuffEffectType()
  return self._buffEffectType
end

_class("NTTeamOrderChange", INotifyBase)
NTTeamOrderChange = NTTeamOrderChange

function NTTeamOrderChange:Constructor(teamEntity, oldTeamOrder, newTeamOrder)
  self._teamEntity = teamEntity
  self._oldTeamOrder = oldTeamOrder
  self._newTeamOrder = newTeamOrder
end

function NTTeamOrderChange:GetNotifyType()
  return NotifyType.TeamOrderChange
end

function NTTeamOrderChange:GetNotifyEntity()
  return self._teamEntity
end

function NTTeamOrderChange:GetOldTeamOrder()
  return self._oldTeamOrder
end

function NTTeamOrderChange:GetNewTeamOrder()
  return self._newTeamOrder
end

_class("NTTrapActiveSkillEnd", INotifyBase)
NTTrapActiveSkillEnd = NTTrapActiveSkillEnd

function NTTrapActiveSkillEnd:Constructor(trapEntity, skillID)
  self._trapEntity = trapEntity
  self._skillID = skillID
end

function NTTrapActiveSkillEnd:GetNotifyType()
  return NotifyType.TrapActiveSkillEnd
end

function NTTrapActiveSkillEnd:GetNotifyEntity()
  return self._trapEntity
end

function NTTrapActiveSkillEnd:GetSkillID()
  return self._skillID
end

_class("NTSanValueChange", INotifyBase)
NTSanValueChange = NTSanValueChange

function NTSanValueChange:Constructor(curValue, oldValue, debtValue, modifyTimes)
  self._curValue = curValue
  self._oldValue = oldValue
  self._debtValue = debtValue
  self._modifyTimes = modifyTimes
end

function NTSanValueChange:GetNotifyType()
  return NotifyType.SanValueChange
end

function NTSanValueChange:GetCurValue()
  return self._curValue
end

function NTSanValueChange:GetOldValue()
  return self._oldValue
end

function NTSanValueChange:GetDebtValue()
  return self._debtValue
end

function NTSanValueChange:GetModifyTimes()
  return self._modifyTimes
end

_class("NTDayNightStateChange", INotifyBase)
NTDayNightStateChange = NTDayNightStateChange

function NTDayNightStateChange:Constructor(curState, oldState)
  self._curState = curState
  self._oldState = oldState
end

function NTDayNightStateChange:GetNotifyType()
  return NotifyType.DayNightStateChange
end

function NTDayNightStateChange:GetCurState()
  return self._curState
end

function NTDayNightStateChange:GetOldState()
  return self._oldState
end

_class("NTRideStateChange", INotifyBase)
NTRideStateChange = NTRideStateChange

function NTRideStateChange:Constructor(entity, isRide)
  self._entity = entity
  self._isRide = isRide
end

function NTRideStateChange:GetNotifyType()
  return NotifyType.RideStateChange
end

function NTRideStateChange:GetNotifyEntity()
  return self._entity
end

function NTRideStateChange:GetRideState()
  return self._isRide
end

_class("NTSaveRoundBeginPlayerPosEnd", INotifyBase)
NTSaveRoundBeginPlayerPosEnd = NTSaveRoundBeginPlayerPosEnd

function NTSaveRoundBeginPlayerPosEnd:Constructor(teamEntity)
  self._teamEntity = teamEntity
end

function NTSaveRoundBeginPlayerPosEnd:GetNotifyEntity()
  return self._teamEntity
end

function NTSaveRoundBeginPlayerPosEnd:NeedCheckGameTurn()
  return true
end

function NTSaveRoundBeginPlayerPosEnd:GetNotifyType()
  return NotifyType.SaveRoundBeginPlayerPosEnd
end

_class("NTEffect156MoveOneGrid", INotifyBase)
NTEffect156MoveOneGrid = NTEffect156MoveOneGrid

function NTEffect156MoveOneGrid:Constructor(entity, pos)
  self._entity = entity
  self._pos = pos
end

function NTEffect156MoveOneGrid:GetNotifyType()
  return NotifyType.Effect156MoveOneGrid
end

function NTEffect156MoveOneGrid:GetNotifyEntity()
  return self._entity
end

function NTEffect156MoveOneGrid:GetPos()
  return self._pos
end

_class("NTEffect156MoveFinish", INotifyBase)
NTEffect156MoveFinish = NTEffect156MoveFinish

function NTEffect156MoveFinish:Constructor(entity)
  self._entity = entity
end

function NTEffect156MoveFinish:GetNotifyType()
  return NotifyType.Effect156MoveFinish
end

function NTEffect156MoveFinish:GetNotifyEntity()
  return self._entity
end

_class("NTEffect156MoveFinishBegin", INotifyBase)
NTEffect156MoveFinishBegin = NTEffect156MoveFinishBegin

function NTEffect156MoveFinishBegin:Constructor(entity, walkGridCount)
  self._entity = entity
  self._walkGridCount = walkGridCount
end

function NTEffect156MoveFinishBegin:GetNotifyType()
  return NotifyType.Effect156MoveFinishBegin
end

function NTEffect156MoveFinishBegin:GetNotifyEntity()
  return self._entity
end

function NTEffect156MoveFinishBegin:GetWalkGridCount()
  return self._walkGridCount
end

_class("NTEffect156MoveFinishEnd", INotifyBase)
NTEffect156MoveFinishEnd = NTEffect156MoveFinishEnd

function NTEffect156MoveFinishEnd:Constructor(entity)
  self._entity = entity
end

function NTEffect156MoveFinishEnd:GetNotifyType()
  return NotifyType.Effect156MoveFinishEnd
end

function NTEffect156MoveFinishEnd:GetNotifyEntity()
  return self._entity
end

_class("NTEffect156MoveOneGridBegin", INotifyBase)
NTEffect156MoveOneGridBegin = NTEffect156MoveOneGridBegin

function NTEffect156MoveOneGridBegin:Constructor(entity)
  self._entity = entity
end

function NTEffect156MoveOneGridBegin:GetNotifyType()
  return NotifyType.Effect156MoveOneGridBegin
end

function NTEffect156MoveOneGridBegin:GetNotifyEntity()
  return self._entity
end

_class("NTEffect156MoveOneGridEnd", INotifyBase)
NTEffect156MoveOneGridEnd = NTEffect156MoveOneGridEnd

function NTEffect156MoveOneGridEnd:Constructor(entity)
  self._entity = entity
end

function NTEffect156MoveOneGridEnd:GetNotifyType()
  return NotifyType.Effect156MoveOneGridEnd
end

function NTEffect156MoveOneGridEnd:GetNotifyEntity()
  return self._entity
end

_class("NTEffect158AttackBegin", INotifyBase)
NTEffect158AttackBegin = NTEffect158AttackBegin

function NTEffect158AttackBegin:Constructor(entity)
  self._entity = entity
end

function NTEffect158AttackBegin:GetNotifyType()
  return NotifyType.Effect158AttackBegin
end

function NTEffect158AttackBegin:GetNotifyEntity()
  return self._entity
end

_class("NTEffect158AttackEnd", INotifyBase)
NTEffect158AttackEnd = NTEffect158AttackEnd

function NTEffect158AttackEnd:Constructor(entity)
  self._entity = entity
end

function NTEffect158AttackEnd:GetNotifyType()
  return NotifyType.Effect158AttackEnd
end

function NTEffect158AttackEnd:GetNotifyEntity()
  return self._entity
end

_class("NTMinosAbsorbTrap", INotifyBase)
NTMinosAbsorbTrap = NTMinosAbsorbTrap

function NTMinosAbsorbTrap:Constructor(e)
  self._entity = e
end

function NTMinosAbsorbTrap:GetTrapID()
  local trapCmpt = self._entity:Trap()
  if not trapCmpt then
    return nil
  end
  local trapID = trapCmpt:GetTrapID()
  return trapID
end

function NTMinosAbsorbTrap:GetNotifyType()
  return NotifyType.MinosAbsorbTrap
end

function NTMinosAbsorbTrap:GetNotifyEntity()
  return self._entity
end

_class("NTSuperGridTriggerEnd", INotifyBase)
NTSuperGridTriggerEnd = NTSuperGridTriggerEnd

function NTSuperGridTriggerEnd:Constructor(v2Pos)
  self._pos = v2Pos
end

function NTSuperGridTriggerEnd:GetTriggerPos()
  return self._pos
end

function NTSuperGridTriggerEnd:GetNotifyType()
  return NotifyType.SuperGridTriggerEnd
end

_class("NTPoorGridTriggerEnd", INotifyBase)
NTPoorGridTriggerEnd = NTPoorGridTriggerEnd

function NTPoorGridTriggerEnd:Constructor(v2Pos)
  self._pos = v2Pos
end

function NTPoorGridTriggerEnd:GetTriggerPos()
  return self._pos
end

function NTPoorGridTriggerEnd:GetNotifyType()
  return NotifyType.PoorGridTriggerEnd
end

_class("NTSelectRoundTeamNormalBefore", INotifyBase)
NTSelectRoundTeamNormalBefore = NTSelectRoundTeamNormalBefore

function NTSelectRoundTeamNormalBefore:Constructor(elementType, chainPath)
  self._elementType = elementType
  self._chainPath = chainPath
end

function NTSelectRoundTeamNormalBefore:GetNotifyType()
  return NotifyType.SelectRoundTeamNormalBefore
end

function NTSelectRoundTeamNormalBefore:GetChainPathType()
  return self._elementType
end

function NTSelectRoundTeamNormalBefore:GetChainPath()
  return self._chainPath
end

_class("NTPetMinosAbsorbTrap", INotifyBase)
NTPetMinosAbsorbTrap = NTPetMinosAbsorbTrap

function NTPetMinosAbsorbTrap:Constructor(trapEntity, triggerEntity)
  self._trapEntity = trapEntity
  self._triggerEntity = triggerEntity
end

function NTPetMinosAbsorbTrap:GetTrapID()
  local trapCmpt = self._trapEntity:Trap()
  if not trapCmpt then
    return nil
  end
  local trapID = trapCmpt:GetTrapID()
  return trapID
end

function NTPetMinosAbsorbTrap:GetNotifyType()
  return NotifyType.PetMinosAbsorbTrap
end

function NTPetMinosAbsorbTrap:GetNotifyEntity()
  return self._trapEntity
end

function NTPetMinosAbsorbTrap:GetTriggerEntity()
  return self._triggerEntity
end

function NTPetMinosAbsorbTrap:GetNotifyPos()
  return self._trapEntity:GetGridPosition()
end

function NTPetMinosAbsorbTrap:GetPos()
  return self._trapEntity:GetGridPosition()
end

_class("NTCoffinMusumeSkillChangeLight", INotifyBase)
NTCoffinMusumeSkillChangeLight = NTCoffinMusumeSkillChangeLight

function NTCoffinMusumeSkillChangeLight:Constructor(selectedLightID)
  self._selectedLightID = selectedLightID
end

function NTCoffinMusumeSkillChangeLight:GetSelectLightID()
  return self._selectedLightID
end

function NTCoffinMusumeSkillChangeLight:GetNotifyType()
  return NotifyType.CoffinMusumeSkillChangeLight
end

_class("NTCoffinMusumeLightChanged", INotifyBase)
NTCoffinMusumeLightChanged = NTCoffinMusumeLightChanged

function NTCoffinMusumeLightChanged:GetNotifyType()
  return NotifyType.CoffinMusumeLightChanged
end

_class("NTExChangeGridColor", INotifyBase)
NTExChangeGridColor = NTExChangeGridColor

function NTExChangeGridColor:Constructor(gridPosList)
  self._gridPosList = gridPosList
end

function NTExChangeGridColor:GetConvertInfoAt(pos)
  for gridPos, gridType in pairs(self._gridPosList) do
    if gridPos.x == pos.x and gridPos.y == pos.y then
      return true
    end
  end
  return false
end

function NTExChangeGridColor:GetNotifyType()
  return NotifyType.ExChangeGridColor
end

_class("NTPet1601781SkillHolderBase", INotifyBase)
NTPet1601781SkillHolderBase = NTPet1601781SkillHolderBase

function NTPet1601781SkillHolderBase:GetNotifyType()
  return self.__NotifyType
end

function NTPet1601781SkillHolderBase:Constructor(skillType, casterPos, multiCastCount)
  self._triggerSkillType = skillType
  self._casterPos = casterPos
  self._multiCastCount = multiCastCount
end

function NTPet1601781SkillHolderBase:GetSkillType()
  return self._triggerSkillType
end

function NTPet1601781SkillHolderBase:GetCasterPos()
  return self._casterPos
end

function NTPet1601781SkillHolderBase:GetMultiCastCount()
  return self._multiCastCount
end

_class("NTPet1601781SkillHolder1", NTPet1601781SkillHolderBase)
NTPet1601781SkillHolder1 = NTPet1601781SkillHolder1
NTPet1601781SkillHolder1.__NotifyType = NotifyType.Pet1601781SkillHolder1
_class("NTPet1601781SkillHolder2", NTPet1601781SkillHolderBase)
NTPet1601781SkillHolder2 = NTPet1601781SkillHolder2
NTPet1601781SkillHolder2.__NotifyType = NotifyType.Pet1601781SkillHolder2
_class("NTPet1601781SkillHolder3", NTPet1601781SkillHolderBase)
NTPet1601781SkillHolder3 = NTPet1601781SkillHolder3
NTPet1601781SkillHolder3.__NotifyType = NotifyType.Pet1601781SkillHolder3
_class("NTSE189NormalEachAttackEnd", INotifyBase)
NTSE189NormalEachAttackEnd = NTSE189NormalEachAttackEnd

function NTSE189NormalEachAttackEnd:Constructor(entity)
  self._entity = entity
end

function NTSE189NormalEachAttackEnd:GetNotifyType()
  return NotifyType.SE189NormalEachAttackEnd
end

function NTSE189NormalEachAttackEnd:GetNotifyEntity()
  return self._entity
end

_class("NTBenumbed", INotifyBase)
NTBenumbed = NTBenumbed

function NTBenumbed:Constructor(entity)
  self._entity = entity
end

function NTBenumbed:GetNotifyType()
  return NotifyType.Benumbed
end

function NTBenumbed:GetNotifyEntity()
  return self._entity
end

_class("NTCovCrystalPrism", INotifyBase)
NTCovCrystalPrism = NTCovCrystalPrism

function NTCovCrystalPrism:Constructor(tTargetPieces)
  self.tTargetPieces = tTargetPieces
  self._convertPosInfoMap = {}
  if tTargetPieces then
    for _, data in ipairs(tTargetPieces) do
      local pos = data.pos
      local x = pos.x
      local y = pos.y
      if not self._convertPosInfoMap[x] then
        self._convertPosInfoMap[x] = {}
      end
      self._convertPosInfoMap[x][y] = data.pieceType
    end
  end
end

function NTCovCrystalPrism:GetNotifyType()
  return NotifyType.CovCrystalPrism
end

function NTCovCrystalPrism:GetConvertInfoAt(pos)
  return self._convertPosInfoMap[pos.x] and self._convertPosInfoMap[pos.x][pos.y] or nil
end

_class("NTEquipRefineUIStateChange", INotifyBase)
NTEquipRefineUIStateChange = NTEquipRefineUIStateChange

function NTEquipRefineUIStateChange:Constructor(entity, state)
  self._entity = entity
  self._state = state
end

function NTEquipRefineUIStateChange:GetNotifyType()
  return NotifyType.EquipRefineUIStateChange
end

function NTEquipRefineUIStateChange:GetNotifyEntity()
  return self._entity
end

function NTEquipRefineUIStateChange:GetRefineUIState()
  return self._state
end

_class("NTAddControlBuffEnd", INotifyBase)
NTAddControlBuffEnd = NTAddControlBuffEnd

function NTAddControlBuffEnd:Constructor(entity, buffSeq, buffID, buffEffType)
  self._entity = entity
  self._buffSeq = buffSeq
  self._buffID = buffID
  self._buffEffType = buffEffType
end

function NTAddControlBuffEnd:GetNotifyType()
  return NotifyType.AddControlBuffEnd
end

function NTAddControlBuffEnd:GetNotifyEntity()
  return self._entity
end

function NTAddControlBuffEnd:GetBuffSeq()
  return self._buffSeq
end

function NTAddControlBuffEnd:GetBuffID()
  return self._buffID
end

function NTAddControlBuffEnd:GetBuffEffectType()
  return self._buffEffType
end

function NTAddControlBuffEnd:NeedCheckGameTurn()
  return true
end

_class("NTActiveSkillCostCasterHPEnd", INotifyBase)
NTActiveSkillCostCasterHPEnd = NTActiveSkillCostCasterHPEnd

function NTActiveSkillCostCasterHPEnd:Constructor(attacker, damage)
  self._attacker = attacker
  self._damage = damage
end

function NTActiveSkillCostCasterHPEnd:GetNotifyType()
  return NotifyType.ActiveSkillCostCasterHPEnd
end

function NTActiveSkillCostCasterHPEnd:GetNotifyEntity()
  return self._attacker
end

function NTActiveSkillCostCasterHPEnd:GetDamage()
  return self._damage
end

function NTActiveSkillCostCasterHPEnd:NeedCheckGameTurn()
  return true
end

_class("NTSpliceBoardBegin", INotifyBase)
NTSpliceBoardBegin = NTSpliceBoardBegin

function NTSpliceBoardBegin:Constructor(trapEntity)
  self._trapEntity = trapEntity
end

function NTSpliceBoardBegin:GetNotifyType()
  return NotifyType.SpliceBoardBegin
end

function NTSpliceBoardBegin:GetNotifyEntity()
  return self._trapEntity
end

_class("NTSpliceBoardEnd", INotifyBase)
NTSpliceBoardEnd = NTSpliceBoardEnd

function NTSpliceBoardEnd:Constructor(trapEntity)
  self._trapEntity = trapEntity
end

function NTSpliceBoardEnd:GetNotifyType()
  return NotifyType.SpliceBoardEnd
end

function NTSpliceBoardEnd:GetNotifyEntity()
  return self._trapEntity
end

_class("NTTrapShowEnd", INotifyBase)
NTTrapShowEnd = NTTrapShowEnd

function NTTrapShowEnd:Constructor(e, summoner, pos, bodyArea)
  self._entity = e
  self._summoner = summoner
  self._isFirstSummon = false
  self._pos = pos
  self._bodyArea = bodyArea
end

function NTTrapShowEnd:GetNotifyBodyArea()
  return self._bodyArea
end

function NTTrapShowEnd:GetNotifyPos()
  return self._pos
end

function NTTrapShowEnd:GetNotifyType()
  return NotifyType.TrapShowEnd
end

function NTTrapShowEnd:GetNotifyEntity()
  return self._entity
end

function NTTrapShowEnd:SetIsFirstSummon(b)
  self._isFirstSummon = b
end

function NTTrapShowEnd:IsFirstSummon()
  return self._isFirstSummon
end

function NTTrapShowEnd:GetOwnerEntity()
  return self._summoner
end

_class("NTPopStarScoreChange", INotifyBase)
NTPopStarScoreChange = NTPopStarScoreChange

function NTPopStarScoreChange:Constructor()
  self._changeNum = 0
  self._cumulativeTriggerNum = 0
end

function NTPopStarScoreChange:GetNotifyType()
  return NotifyType.PopStarScoreChange
end

function NTPopStarScoreChange:SetPopChangeNum(popNum)
  self._changeNum = popNum
end

function NTPopStarScoreChange:GetPopChangeNum()
  return self._changeNum
end

function NTPopStarScoreChange:SetCumulativeTriggerNum(num)
  self._cumulativeTriggerNum = num
end

function NTPopStarScoreChange:GetCumulativeTriggerNum()
  return self._cumulativeTriggerNum
end

_class("NTPopStarEnd", INotifyBase)
NTPopStarEnd = NTPopStarEnd

function NTPopStarEnd:Constructor(popNum)
  self._popNum = popNum
end

function NTPopStarEnd:GetNotifyType()
  return NotifyType.PopStarEnd
end

function NTPopStarEnd:GetPopNum()
  return self._popNum
end

_class("NTMoveTrap", INotifyBase)
NTMoveTrap = NTMoveTrap

function NTMoveTrap:Constructor(e, summoner, pos, bodyArea)
  self._entity = e
  self._summoner = summoner
  self._pos = pos
  self._bodyArea = bodyArea
end

function NTMoveTrap:GetNotifyBodyArea()
  return self._bodyArea
end

function NTMoveTrap:GetNotifyPos()
  return self._pos
end

function NTMoveTrap:GetNotifyType()
  return NotifyType.MoveTrap
end

function NTMoveTrap:GetNotifyEntity()
  return self._entity
end

function NTMoveTrap:IsFirstSummon()
  return false
end

function NTMoveTrap:GetOwnerEntity()
  return self._summoner
end

_class("NTRoleTurnResultState", INotifyBase)
NTRoleTurnResultState = NTRoleTurnResultState

function NTRoleTurnResultState:Constructor()
end

function NTRoleTurnResultState:GetNotifyType()
  return NotifyType.RoleTurnResultState
end

_class("NTMonsterRoundBeforeTrapRoundCount", INotifyBase)
NTMonsterRoundBeforeTrapRoundCount = NTMonsterRoundBeforeTrapRoundCount

function NTMonsterRoundBeforeTrapRoundCount:Constructor(entity)
  self._entity = entity
end

function NTMonsterRoundBeforeTrapRoundCount:GetNotifyType()
  return NotifyType.MonsterRoundBeforeTrapRoundCount
end

function NTMonsterRoundBeforeTrapRoundCount:GetNotifyEntity()
  return self._entity
end

_class("NTMarchEnd", INotifyBase)
NTMarchEnd = NTMarchEnd

function NTMarchEnd:Constructor()
end

function NTMarchEnd:GetNotifyType()
  return NotifyType.MarchEnd
end

_class("NTClientUnscaledCountDownFinish", INotifyBase)
NTClientUnscaledCountDownFinish = NTClientUnscaledCountDownFinish

function NTClientUnscaledCountDownFinish:Constructor(flagID)
  self._flagID = flagID
end

function NTClientUnscaledCountDownFinish:GetNotifyType()
  return NotifyType.ClientUnscaledCountDownFinish
end

function NTClientUnscaledCountDownFinish:GetFlagID()
  return self._flagID
end

_class("NTAfterEntityAddBuff", INotifyBase)
NTAfterEntityAddBuff = NTAfterEntityAddBuff

function NTAfterEntityAddBuff:Constructor(entity, buffId, buffEffectType, buffSeq)
  self._entity = entity
  self._buffId = buffId
  self._buffEffectType = buffEffectType
  self._buffSeq = buffSeq
end

function NTAfterEntityAddBuff:GetBuffSeq()
  return self._buffSeq
end

function NTAfterEntityAddBuff:GetNotifyType()
  return NotifyType.AfterEntityAddBuff
end

function NTAfterEntityAddBuff:GetNotifyEntity()
  return self._entity
end

function NTAfterEntityAddBuff:GetBuffId()
  return self._buffId
end

function NTAfterEntityAddBuff:GetBuffEffectType()
  return self._buffEffectType
end
