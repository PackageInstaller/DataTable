require("trap_destroy_type")
_class("TrapComponent", Object)
TrapComponent = TrapComponent

function TrapComponent:Constructor()
  self._trapType = TrapType.None
  self._trapEffectType = TrapEffectType.None
  self._trapEffectParam = nil
  self._raceType = TrapRaceType.Player
  self._raceParams = nil
  self._destroyType = TrapDestroyType.DestroyByRound
  self._destroyParam = nil
  self._trapID = 0
  self._orgDir = Vector2(0, 1)
  self._trapLevel = 0
  self._replaceLevel = 0
  self._needDestory = false
  self._isNoHPDead = false
  self._triggerSkillID = 0
  self._fakeTriggerSkillID = 0
  self._appearSkillID = 0
  self._disappearSkillID = 0
  self._dieSkillID = 0
  self._victorySkillID = 0
  self._activeSkillID = {}
  self._preChainSkillID = 0
  self._triggerSkillByRaceType = {}
  self._warningSkillID = 0
  self._moveSkillID = 0
  self._triggerSkillType = TrapSkillType.Normal
  self._appearSkillType = 0
  self._disappearSkillType = 0
  self._dieSkillType = 0
  self._victorySkillType = 0
  self._blockByRaceType = {}
  self._groupId = 0
  self._triggerException = {}
  self._triggerMaxCount = -1
  self._scopeCenterGroupId = 0
  self._isExit = false
  self._isDimensionDoor = false
  self._isSuperGrid = false
  self._isPoorGrid = false
  self._isBrokenGrid = false
  self._isLockedGrid = false
  self._isPrismGrid = false
  self._isAircraftCore = false
  self._isBenumbTrigger = false
  self._isCastSkillByRound = false
  self._isPetTrapCastSkill = false
  self._isSticker = false
  self._isMaintainColorGrid = false
  self._currentTriggerCount = 0
  self._fallWithGrid = false
  self._ownerID = nil
  self._ownerRound = nil
  self._hasSelected = false
  self._hadCalcDead = false
  self._hadCalcSkill = {}
  self._canBePurified = false
  self._recordPieceType = PieceType.None
  self._specialDestroy = false
  self._triggerWhileSpawnEntity = nil
  self._bornRound = nil
  self._isBlockSummon = false
  self._fakeTrapID = nil
  self._auraGroupID = nil
  self._auraRange = nil
end

function TrapComponent:SetTrapID(trapID)
  self._trapID = trapID
end

function TrapComponent:GetTrapID()
  if self:GetFakeTrapID() then
    return self:GetFakeTrapID()
  end
  return self._trapID
end

function TrapComponent:SetTrapType(trapType)
  self._trapType = trapType
end

function TrapComponent:SetTypeParam(typeParam)
  if not typeParam then
    return
  end
  self._triggerException = typeParam.triggerException or {}
  self._triggerMaxCount = typeParam.triggerMaxCount or -1
  self._scopeCenterGroupId = typeParam.ScopeCenter or 0
  self._isExit = typeParam.isExit or false
  self._isDimensionDoor = typeParam.isDimensionDoor or false
  self._isSuperGrid = typeParam.isSuperGrid or false
  self._isPoorGrid = typeParam.isPoorGrid or false
  self._isAircraftCore = typeParam.isAircraftCore or false
  self._isBenumbTrigger = typeParam.isBenumbTrigger or false
  self._isBrokenGrid = typeParam.isBrokenGrid or false
  self._isLockedGrid = typeParam.isLockGrid or false
  self._isPrismGrid = typeParam.isPrismGrid or false
  self._prismScopeType = typeParam.prismScopeType or nil
  self._prismScopeParam = typeParam.prismScopeParam or {}
  self._isSticker = typeParam.isSticker or false
  self._isCastSkillByRound = typeParam.isCastSkillByRound or false
  self._isPetTrapCastSkill = typeParam.isPetTrapCastSkill or false
  self._isBlockSummon = typeParam.isBlockSummon or false
  self._auraGroupID = typeParam.groupID
  self._deadNotPlayDisappear = typeParam.deadNotPlayDisappear
  self._canStayBoardSplice = typeParam.canStayBoardSplice
  self._isMaintainColorGrid = typeParam.isMaintainColorGrid or false
  self._fakeTrapID = typeParam.fakeTrapID
end

function TrapComponent:GetFakeTrapID()
  return self._fakeTrapID
end

function TrapComponent:GetTriggerException()
  return self._triggerException
end

function TrapComponent:GetTriggerMaxCount()
  return self._triggerMaxCount
end

function TrapComponent:GetScopeCenterGroupId()
  return self._scopeCenterGroupId
end

function TrapComponent:FallWithGrid()
  return self._fallWithGrid
end

function TrapComponent:SetFallWithGrid(flag)
  self._fallWithGrid = flag
end

function TrapComponent:GetCurrentTriggerCount()
  return self._currentTriggerCount
end

function TrapComponent:SetCurrentTriggerCount(count)
  self._currentTriggerCount = count
end

function TrapComponent:AddCurrentTriggerCount()
  self:SetCurrentTriggerCount(self._currentTriggerCount + 1)
end

function TrapComponent:GetTrapType()
  return self._trapType
end

function TrapComponent:SetNeedDestory(bdestory)
  self._needDestory = bdestory
end

function TrapComponent:GetNeedDestory()
  return self._needDestory
end

function TrapComponent:SetOrgDir(trapRotation)
  self._orgDir = trapRotation
end

function TrapComponent:GetOrgDir()
  return self._orgDir
end

function TrapComponent:SetTrapLevel(trapLevel)
  self._trapLevel = trapLevel
end

function TrapComponent:GetTrapLevel()
  return self._trapLevel
end

function TrapComponent:SetReplaceLevel(replaceLevel)
  self._replaceLevel = replaceLevel
end

function TrapComponent:GetReplaceLevel()
  return self._replaceLevel
end

function TrapComponent:SetTrapEffect(trapEffectType, trapEffectParam)
  self._trapEffectType = trapEffectType or TrapEffectType.None
  self._trapEffectParam = trapEffectParam
end

function TrapComponent:GetTrapEffectType()
  return self._trapEffectType
end

function TrapComponent:IsRuneChange()
  return self._trapEffectType == TrapEffectType.RuneChange
end

function TrapComponent:IsExit()
  return self._isExit
end

function TrapComponent:IsDimensionDoor()
  return self._isDimensionDoor
end

function TrapComponent:IsAircraftCore()
  return self._isAircraftCore
end

function TrapComponent:IsBenumbTrigger()
  return self._isBenumbTrigger
end

function TrapComponent:IsCastSkillByRound()
  return self._isCastSkillByRound
end

function TrapComponent:IsPetTrapCastSkill()
  return self._isPetTrapCastSkill
end

function TrapComponent:GetTrapEffectParam()
  return self._trapEffectParam
end

function TrapComponent:SetTrapRaceType(raceType, raceParam)
  self._raceType = raceType
  self._raceParams = raceParam
end

function TrapComponent:GetTrapRaceType()
  return self._raceType
end

function TrapComponent:GetTrapRaceParam()
  return self._raceParams
end

function TrapComponent:GetTrapDestroyType()
  return self._destroyType
end

function TrapComponent:GetTrapDestroyParam()
  return self._destroyParam
end

local destroyParamTypeList = {
  TrapDestroyType.DestroyByRound,
  TrapDestroyType.DestoryByWave,
  TrapDestroyType.DestroyAtRoundResult
}

function TrapComponent:SetTrapDestroy(trapDestroyType, trapDestroyParam)
  self._destroyType = trapDestroyType
  if table.icontains(destroyParamTypeList, self._destroyType) then
    local num = 0
    if trapDestroyParam then
      num = tonumber(trapDestroyParam[1])
    end
    self._destroyParam = TrapSelfDestroyParam:New(num)
  end
end

function TrapComponent:GetFakeTriggerSkillID()
  return self._fakeTriggerSkillID
end

function TrapComponent:GetTriggerSkillID()
  return self._triggerSkillID
end

function TrapComponent:GetAppearSkillID()
  return self._appearSkillID
end

function TrapComponent:GetDisappearSkillID()
  return self._disappearSkillID
end

function TrapComponent:GetWarningSkillID()
  return self._warningSkillID
end

function TrapComponent:GetMoveSkillID()
  return self._moveSkillID
end

function TrapComponent:GetDieSkillID()
  return self._dieSkillID
end

function TrapComponent:GetActiveSkillID()
  return self._activeSkillID
end

function TrapComponent:SetActiveSkillID(activeSkillID)
  self._activeSkillID = activeSkillID
end

function TrapComponent:GetPreChainSkillID()
  return self._preChainSkillID
end

function TrapComponent:GetVictorySkillID()
  return self._victorySkillID
end

function TrapComponent:GetTriggerSkillByRaceType()
  return self._triggerSkillByRaceType
end

function TrapComponent:SetSkillID(skillID)
  if not skillID then
    return
  end
  self._triggerSkillID = skillID.Trigger or 0
  self._fakeTriggerSkillID = skillID.FakeTrigger
  self._appearSkillID = skillID.Appear or 0
  self._disappearSkillID = skillID.Disappear or 0
  self._dieSkillID = skillID.Die or 0
  self._activeSkillID = {}
  if type(skillID.Active) == "table" then
    table.appendArray(self._activeSkillID, skillID.Active)
  end
  self._preChainSkillID = skillID.PreChain or 0
  self._victorySkillID = skillID.Victory or 0
  self._warningSkillID = skillID.Warning or 0
  self._moveSkillID = skillID.Move or 0
end

function TrapComponent:GetTriggerSkillType()
  return self._triggerSkillType
end

function TrapComponent:SetSkillType(skillID)
  if not skillID then
    return
  end
  self._triggerSkillType = skillID.Trigger or 0
  self._appearSkillType = skillID.Appear or 0
  self._disappearSkillType = skillID.Disappear or 0
  self._dieSkillType = skillID.Die or 0
  self._activeSkillType = skillID.Active or {}
  self._preChainSkillType = skillID.PreChain or 0
  self._victorySkillType = skillID.Victory or 0
end

function TrapComponent:SetTriggerByRace(triggerByRace)
  self._triggerSkillByRaceType = triggerByRace
end

function TrapComponent:GetBlockByRaceType()
  return self._blockByRaceType
end

function TrapComponent:SetBlockByRaceType(blockByRaceType)
  self._blockByRaceType = blockByRaceType
end

function TrapComponent:SetGroupID(groupId)
  self._groupId = groupId or 0
end

function TrapComponent:GetGroupID()
  return self._groupId
end

function TrapComponent:SetGroupTriggerTrapID(trapID)
  self._groupTriggerTrapID = trapID
end

function TrapComponent:GetGroupTriggerTrapID()
  return self._groupTriggerTrapID
end

function TrapComponent:GetOwnerID()
  return self._ownerID
end

function TrapComponent:IsTrapHaveOwner(nOwnerRound)
  if nil == self._ownerRound or nOwnerRound > self._ownerRound then
    return false
  end
  return self._ownerID
end

function TrapComponent:SetOwner(nOwnerID, nOwnerRound)
  self._ownerID = nOwnerID
  self._ownerRound = nOwnerRound
end

function TrapComponent:SetBombSelected(selected)
  self._hasSelected = selected
end

function TrapComponent:IsBombSelected()
  return self._hasSelected
end

function TrapComponent:SetReplaceTrap(replaceTrap)
  self._replaceTrap = replaceTrap
end

function TrapComponent:GetReplaceTrap()
  return self._replaceTrap
end

function TrapComponent:IsHadCalcDead()
  return self._hadCalcDead
end

function TrapComponent:SetHadCalcDead()
  self._hadCalcDead = true
end

function TrapComponent:IsSuperGrid()
  return self._isSuperGrid
end

function TrapComponent:IsPoorGrid()
  return self._isPoorGrid
end

function TrapComponent:IsBrokenGrid()
  return self._isBrokenGrid
end

function TrapComponent:IsLockedGrid()
  return self._isLockedGrid
end

function TrapComponent:IsPrismGrid()
  return self._isPrismGrid
end

function TrapComponent:GetPrismGridValue()
  return self._isPrismGrid
end

function TrapComponent:GetCustomPrismGridScopeType()
  return self._prismScopeType
end

function TrapComponent:GetCustomPrismGridScopeParam()
  return self._prismScopeParam
end

function TrapComponent:IsSticker()
  return self._isSticker
end

function TrapComponent:SetHadCalcSkill(skillID)
  table.insert(self._hadCalcSkill, skillID)
end

function TrapComponent:IsSkillHadCalc(skillID)
  if not skillID then
    return false
  end
  return table.icontains(self._hadCalcSkill, skillID)
end

function TrapComponent:SetCanBePurified(b)
  self._canBePurified = b
end

function TrapComponent:CanBePurified()
  return self._canBePurified
end

function TrapComponent:SetRecordPieceType(pieceType)
  self._recordPieceType = pieceType
end

function TrapComponent:GetRecordPieceType()
  return self._recordPieceType
end

function TrapComponent:SetSpecialDestroy(specialestroy)
  self._specialDestroy = specialestroy
end

function TrapComponent:GetSpecialDestroy()
  return self._specialDestroy
end

function TrapComponent:SetTriggerWhileSpawnEntity(e)
  self._triggerWhileSpawnEntity = e
end

function TrapComponent:GetTriggerWhileSpawnEntity()
  return self._triggerWhileSpawnEntity
end

function TrapComponent:SetTrapBornRound(round)
  self._bornRound = round
end

function TrapComponent:GetTrapBornRound()
  return self._bornRound
end

function TrapComponent:IsBlockSummon()
  return self._isBlockSummon
end

function TrapComponent:GetAuraGroupID()
  return self._auraGroupID
end

function TrapComponent:GetDeadNotPlayDisappear()
  return self._deadNotPlayDisappear
end

function TrapComponent:GetCanStayBoardSplice()
  return self._canStayBoardSplice
end

function TrapComponent:SetAuraRange(auraRange)
  self._auraRange = auraRange
end

function TrapComponent:GetAuraRange()
  return self._auraRange
end

function TrapComponent:SetCantAutoSkill(cantAutoSkill)
  self._cantAutoSkill = cantAutoSkill
end

function TrapComponent:GetCantAutoSkill()
  return self._cantAutoSkill
end

function TrapComponent:IsMaintainColorGrid()
  return self._isMaintainColorGrid
end

function Entity:Trap()
  return self:GetComponent(self.WEComponentsEnum.Trap)
end

function Entity:HasTrap()
  return self:HasComponent(self.WEComponentsEnum.Trap)
end

function Entity:AddTrap()
  local index = self.WEComponentsEnum.Trap
  local component = TrapComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceTrap()
  local index = self.WEComponentsEnum.Trap
  local component = TrapComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveTrap()
  if self:HasTrap() then
    self:RemoveComponent(self.WEComponentsEnum.Trap)
  end
end
