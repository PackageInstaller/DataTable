_class("TrapRenderComponent", Object)
TrapRenderComponent = TrapRenderComponent

function TrapRenderComponent:Constructor()
  self._trapID = 0
  self._trapEffectType = nil
  self._trapType = TrapType.None
  self._trapTypeParam = nil
  self._groupId = 0
  self._triggerSkillID = 0
  self._activeSkillID = {}
  self._dieSkillID = 0
  self._preChainSkillID = 0
  self._disappearSkillID = 0
  self._appearSkillID = 0
  self._warningSkillID = 0
  self._moveSkillID = 0
  self._hitSkillID = 0
  self._hideSkillID = 0
  self._showSkillID = 0
  self._victorySkillID = 0
  self._hideUnderAI = false
  self._hideUnderTeam = false
  self._hadPlayDead = false
  self._hadPlayDestroy = false
  self._triggerMaxCount = -1
  self._hadPlaySkill = {}
  self._trapCreationResult = nil
  self._hasShow = false
  self._canPlayHideSkill = true
  self._canPlayShowSkill = true
  self._gridDownEnable = false
  self._appearSkillResultContainer = nil
  self._triggerSkillResultContainer = nil
  self._aurasEffect = nil
  self._aurasBirthAnim = nil
  self._aurasDeathAnim = nil
  self._aurasLoopAnim = nil
  self._aurasGroupID = nil
  self._trapBornRound = nil
  self._prismEffectTrap = false
  self._trapShowLevel = BattleConst.TrapShowLevelDefault
end

function TrapRenderComponent:SetTrapCreationResult(res)
  self._trapCreationResult = res
end

function TrapRenderComponent:GetTrapCreationResult()
  return self._trapCreationResult
end

function TrapRenderComponent:ClearTrapCreationResult()
  self._trapCreationResult = nil
end

function TrapRenderComponent:SetTrapID(trapID)
  self._trapID = trapID
end

function TrapRenderComponent:GetTrapID()
  return self._trapID
end

function TrapRenderComponent:SetTrapType(trapType)
  self._trapType = trapType
end

function TrapRenderComponent:GetTrapType()
  return self._trapType
end

function TrapRenderComponent:SetTypeParam(typeParam)
  if not typeParam then
    return
  end
  self._triggerMaxCount = typeParam.triggerMaxCount or -1
  self._trapTypeParam = typeParam
  local isPrismGrid = typeParam.isPrismGrid
  if isPrismGrid and isPrismGrid == 2 then
    self._prismEffectTrap = true
  end
end

function TrapRenderComponent:GetTriggerMaxCount()
  return self._triggerMaxCount
end

function TrapRenderComponent:GetTrapTypeParam()
  return self._trapTypeParam
end

function TrapRenderComponent:GetIsPrismGrid()
  if not self._trapTypeParam then
    return nil
  end
  return self._trapTypeParam.isPrismGrid
end

function TrapRenderComponent:GetTrapRender_IsBrokenGrid()
  if not self._trapTypeParam then
    return false
  end
  return self._trapTypeParam.isBrokenGrid or false
end

function TrapRenderComponent:GetTrapRender_IsLockedGrid()
  if not self._trapTypeParam then
    return false
  end
  return self._trapTypeParam.isLockGrid or false
end

function TrapRenderComponent:GetTrapRender_IsSuperGrid()
  if not self._trapTypeParam then
    return false
  end
  return self._trapTypeParam.isSuperGrid or false
end

function TrapRenderComponent:GetTrapRender_IsPoorGrid()
  if not self._trapTypeParam then
    return false
  end
  return self._trapTypeParam.isPoorGrid or false
end

function TrapRenderComponent:GetTrapRender_IsAircraftCore()
  if not self._trapTypeParam then
    return false
  end
  return self._trapTypeParam.isAircraftCore or false
end

function TrapRenderComponent:GetTrapRender_IsCastSkillByRound()
  if not self._trapTypeParam then
    return false
  end
  return self._trapTypeParam.isCastSkillByRound or false
end

function TrapRenderComponent:GetTrapRender_IsMaintainColorGrid()
  if not self._trapTypeParam then
    return false
  end
  return self._trapTypeParam.isMaintainColorGrid or false
end

function TrapRenderComponent:SetGroupID(groupId)
  self._groupId = groupId or 0
end

function TrapRenderComponent:GetGroupID()
  return self._groupId
end

function TrapRenderComponent:SetSkillID(skillID)
  if not skillID then
    return
  end
  self._triggerSkillID = skillID.Trigger or 0
  self._activeSkillID = skillID.Active or {}
  self._appearSkillID = skillID.Appear or 0
  self._dieSkillID = skillID.Die or 0
  self._preChainSkillID = skillID.PreChain or 0
  self._disappearSkillID = skillID.Disappear or 0
  self._warningSkillID = skillID.Warning or 0
  self._moveSkillID = skillID.Move or 0
  self._hitSkillID = skillID.Hit or 0
  self._hideSkillID = skillID.Hide or 0
  self._showSkillID = skillID.Show or 0
  self._victorySkillID = skillID.Victory or 0
end

function TrapRenderComponent:GetDieSkillID()
  return self._dieSkillID
end

function TrapRenderComponent:GetPreChainSkillID()
  return self._preChainSkillID
end

function TrapRenderComponent:GetHitSkillID()
  return self._hitSkillID
end

function TrapRenderComponent:GetHideSkillID()
  return self._hideSkillID
end

function TrapRenderComponent:GetShowSkillID()
  return self._showSkillID
end

function TrapRenderComponent:GetVictorySkillID()
  return self._victorySkillID
end

function TrapRenderComponent:GetAppearSkillID()
  return self._appearSkillID
end

function TrapRenderComponent:GetDisappearSkillID()
  return self._disappearSkillID
end

function TrapRenderComponent:GetWarningSkillID()
  return self._warningSkillID
end

function TrapRenderComponent:GetMoveSkillID()
  return self._moveSkillID
end

function TrapRenderComponent:GetTriggerSkillID()
  return self._triggerSkillID
end

function TrapRenderComponent:GetActiveSkillID()
  return self._activeSkillID
end

function TrapRenderComponent:SetHideUnderAI(hide)
  self._hideUnderAI = hide
end

function TrapRenderComponent:GetHideUnderAI()
  return self._hideUnderAI
end

function TrapRenderComponent:SetHideUnderTeam(hide)
  self._hideUnderTeam = hide
end

function TrapRenderComponent:GetHideUnderTeam()
  return self._hideUnderTeam
end

function TrapRenderComponent:GetHadPlayDead()
  return self._hadPlayDead
end

function TrapRenderComponent:SetHadPlayDead()
  self._hadPlayDead = true
end

function TrapRenderComponent:GetHadPlayDestroy()
  return self._hadPlayDestroy
end

function TrapRenderComponent:SetHadPlayDestroy()
  self._hadPlayDestroy = true
end

function TrapRenderComponent:SetHadPlaySkill(skillID)
  table.insert(self._hadPlaySkill, skillID)
end

function TrapRenderComponent:IsSkillHadPlay(skillID)
  if not skillID then
    return false
  end
  return table.icontains(self._hadPlaySkill, skillID)
end

function TrapRenderComponent:SetTrapLevel(trapLevel)
  self._trapLevel = trapLevel
end

function TrapRenderComponent:GetTrapLevel()
  return self._trapLevel
end

function TrapRenderComponent:SetGroupTriggerTrapID(id)
  self._groupTriggerTrapID = id
end

function TrapRenderComponent:GetGroupTriggerTrapID()
  return self._groupTriggerTrapID
end

function TrapRenderComponent:IsHasShow()
  return self._hasShow
end

function TrapRenderComponent:SetHasShowState(state)
  self._hasShow = state
end

function TrapRenderComponent:IsTrapCanPlayShowSkill()
  return self._canPlayShowSkill
end

function TrapRenderComponent:SetTrapCanPlayShowSkill(canPlay)
  self._canPlayShowSkill = canPlay
end

function TrapRenderComponent:IsTrapCanPlayHideSkill()
  return self._canPlayHideSkill
end

function TrapRenderComponent:SetTrapCanPlayHideSkill(canPlay)
  self._canPlayHideSkill = canPlay
end

function TrapRenderComponent:IsNeedGridDown()
  return self._gridDownEnable
end

function TrapRenderComponent:SetNeedGridDownEnable(enable)
  self._gridDownEnable = enable
end

function TrapRenderComponent:SetTrapRenderEffectType(typeParam)
  self._trapEffectType = typeParam
end

function TrapRenderComponent:GetTrapRenderEffectType()
  return self._trapEffectType
end

function TrapRenderComponent:SetAppearSkillResultContainer(container)
  self._appearSkillResultContainer = container
end

function TrapRenderComponent:GetAppearSkillResultContainer()
  return self._appearSkillResultContainer
end

function TrapRenderComponent:SetTriggerSkillResultContainer(container)
  self._triggerSkillResultContainer = container
end

function TrapRenderComponent:GetTriggerSkillResultContainer()
  return self._triggerSkillResultContainer
end

function TrapRenderComponent:SetTriggerSkillTriggeredEntity(e)
  self._triggerSkillTriggeredEntity = e
end

function TrapRenderComponent:GetTriggerSkillTriggeredEntity()
  return self._triggerSkillTriggeredEntity
end

function TrapRenderComponent:SetTrapBornRound(round)
  self._trapBornRound = round
end

function TrapRenderComponent:GetTrapBornRound()
  return self._trapBornRound
end

function TrapRenderComponent:InitByTrapData(trapID, trapData)
  self:SetTrapID(trapID)
  self:SetTrapType(trapData.TrapType)
  self:SetTrapRenderEffectType(trapData.TrapEffectType)
  self:SetTypeParam(trapData.TypeParam)
  self:SetGroupID(trapData.GroupID)
  self:SetSkillID(trapData.SkillID)
  self:SetHideUnderAI(trapData.HideUnderAI == 1)
  self:SetHideUnderTeam(trapData.HideUnderTeam == 1)
  self:SetTrapLevel(trapData.TrapLevel)
  self:SetGroupTriggerTrapID(trapData.GroupTriggerTrapID)
  self:SetTrapShowLevel(trapData.TrapShowLevel or BattleConst.TrapShowLevelDefault)
  if trapData.TrapType == TrapType.Auras then
    self._auraRangeSkillID = trapData.TypeParam.rangeSkillID
    self._aurasEffect = trapData.TypeParam.lineEffect
    self._aurasBirthAnim = trapData.TypeParam.birthAnim
    self._aurasDeathAnim = trapData.TypeParam.deathAnim
    self._aurasLoopAnim = trapData.TypeParam.loopAnim
    self._aurasBirthDelay = trapData.TypeParam.birthDelay or 0
    self._aurasDeathDelay = trapData.TypeParam.deathDelay or 0
    self._aurasGroupID = trapData.TypeParam.groupID
    self._aurasEntityList = {}
    self._aurasStatus = nil
    self._aurasFinish = true
    self._aurasRadius = trapData.TypeParam.radius or 0.5
  end
end

function TrapRenderComponent:GetAurasBirthDelay()
  return self._aurasBirthDelay
end

function TrapRenderComponent:GetAurasDeathDelay()
  return self._aurasDeathDelay
end

function TrapRenderComponent:GetAurasBirthAnim()
  return self._aurasBirthAnim
end

function TrapRenderComponent:GetAurasDeathAnim()
  return self._aurasDeathAnim
end

function TrapRenderComponent:GetAurasLoopAnim()
  return self._aurasLoopAnim
end

function TrapRenderComponent:GetAurasLoopDelay()
  return self._aurasLoopDelay
end

function TrapRenderComponent:GetAurasRangeSkillID()
  return self._auraRangeSkillID
end

function TrapRenderComponent:GetAurasEffect()
  return self._aurasEffect
end

function TrapRenderComponent:HasAurasGroupID()
  return self._aurasGroupID ~= nil
end

function TrapRenderComponent:GetAurasGroupID()
  return self._aurasGroupID
end

function TrapRenderComponent:GetAurasStatus()
  return self._aurasStatus
end

function TrapRenderComponent:SetAurasStatus(state)
  self._aurasStatus = state
  self._aurasFinish = false
end

function TrapRenderComponent:IsAurasFinish()
  return self._aurasFinish
end

function TrapRenderComponent:SetAurasFinish()
  self._aurasFinish = true
end

function TrapRenderComponent:AddMyAurasEntity(entityID)
  table.insert(self._aurasEntityList, entityID)
end

function TrapRenderComponent:GetAllAurasEntity()
  return self._aurasEntityList
end

function TrapRenderComponent:ClearAurasEntity()
  self._aurasEntityList = {}
end

function TrapRenderComponent:GetAurasRadius()
  return self._aurasRadius
end

function TrapRenderComponent:GetDeadNotPlayDisappear()
  if not self._trapTypeParam then
    return
  end
  return self._trapTypeParam.deadNotPlayDisappear
end

function TrapRenderComponent:IsPrismEffectTrap()
  return self._prismEffectTrap
end

function TrapRenderComponent:SetTrapShowLevel(level)
  self._trapShowLevel = level
end

function TrapRenderComponent:GetTrapShowLevel()
  return self._trapShowLevel
end

function Entity:TrapRender()
  return self:GetComponent(self.WEComponentsEnum.TrapRender)
end

function Entity:HasTrapRender()
  return self:HasComponent(self.WEComponentsEnum.TrapRender)
end

function Entity:AddTrapRender()
  local index = self.WEComponentsEnum.TrapRender
  local component = TrapRenderComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceTrapRender()
  local index = self.WEComponentsEnum.TrapRender
  local component = TrapRenderComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveTrapRender()
  if self:HasTrapRender() then
    self:RemoveComponent(self.WEComponentsEnum.TrapRender)
  end
end
