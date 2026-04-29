_class("SkillLogicService", BaseService)
SkillLogicService = SkillLogicService

function SkillLogicService:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._runPos = self._world:GetRunningPosition()
end

function SkillLogicService:Initialize()
  self._chainPathTargetSelector = ChainPathTargetSelector:New(self._world)
  self._normalSkillCalculator = NormalSkillCalculator:New(self._world)
  self._chainSkillCalculator = ChainSkillCalculator:New(self._world)
  self._skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
  self._activeSkillCalculator = ActiveSkillCalculator:New(self._world)
  self._autoBeadSkillCalculator = AutoBeadSkillCalculator:New(self._world)
  self._useSkillCaclulator = true
end

function SkillLogicService:SelectNormalAttackTarget(actorEntity)
  self._chainPathTargetSelector:DoSelectNormalAttackTarget(actorEntity)
end

function SkillLogicService:CalcNormalSkillDamage(actorEntity)
  self._normalSkillCalculator:DoCalculateNormalSkill(actorEntity)
  local svc = self._world:GetService("L2R")
  svc:L2RNormalAttackData(self._normalSkillCalculator, actorEntity)
end

function SkillLogicService:CalcChainSkillDamage(teamEntity, skillCastPos)
  self._chainSkillCalculator:DoCalculateChainSkill(teamEntity, skillCastPos)
end

function SkillLogicService:CalcSkillEffect(castEntity, skillID, skillType, overrideScopeResult)
  self._world:GetSyncLogger():Trace({
    key = "CalcSkillEffect",
    casterID = castEntity:GetID(),
    skillID = skillID
  })
  local configService = self._configService
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilData = self._world:GetService("UtilData")
  skillConfigData = utilData:ProcessAutoBeadSkillConfig(skillConfigData, castEntity)
  local targetType = skillConfigData:GetSkillTargetType()
  local casterPos = castEntity:GridLocation().Position
  local casterDir = castEntity:GridLocation().Direction
  local scopeResult
  local aiCmpt = castEntity:AI()
  if aiCmpt then
    scopeResult = aiCmpt:GetSkillScopeResult()
  end
  scopeResult = scopeResult or utilScopeSvc:CalcSkillScope(skillConfigData, casterPos, castEntity, casterDir)
  if scopeResult == nil then
    Log.error("scopeResult==nil!! skillID=", skillID)
    return
  end
  local skillResult = castEntity:SkillContext():GetResultContainer()
  skillResult:Clear()
  scopeResult:ClearTargetIDs()
  skillResult:SetSkillID(skillID)
  self:_ModifyScopeResult(castEntity, scopeResult)
  if overrideScopeResult then
    Log.info("CalcSkillEffect: scope override by caller. ")
    scopeResult = overrideScopeResult
  end
  local targetEntityIDArray = self._skillScopeTargetSelector:DoSelectSkillTarget(castEntity, targetType, scopeResult, skillID)
  if targetEntityIDArray then
    local pos2ID = {}
    for _, targetEntityID in ipairs(targetEntityIDArray) do
      scopeResult:AddTargetID(targetEntityID)
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      if targetEntity:HasBodyArea() and targetEntity:HasGridLocation() then
        local gridLocationCmpt = targetEntity:GridLocation()
        local bodyAreaCmpt = targetEntity:BodyArea()
        local bodyAreaList = bodyAreaCmpt:GetArea()
        for i, bodyArea in ipairs(bodyAreaList) do
          local curBodyPos = Vector2(gridLocationCmpt.Position.x + bodyArea.x, gridLocationCmpt.Position.y + bodyArea.y)
          local posIdx = Vector2.Pos2Index(curBodyPos)
          if not pos2ID[posIdx] then
            pos2ID[posIdx] = {}
          end
          table.insert(pos2ID[posIdx], targetEntityID)
        end
      end
    end
    for _, gridPos in ipairs(scopeResult:GetAttackRange()) do
      if gridPos._className == "Vector2" then
        local targetEntityIDs = pos2ID[Vector2.Pos2Index(gridPos)]
        if targetEntityIDs then
          for _, targetEntityID in ipairs(targetEntityIDs) do
            scopeResult:AddTargetIDAndPos(targetEntityID, gridPos)
          end
        end
      else
        for _, pos in ipairs(gridPos) do
          local targetEntityIDs = pos2ID[Vector2.Pos2Index(pos)]
          if targetEntityIDs then
            for _, targetEntityID in ipairs(targetEntityIDs) do
              scopeResult:AddTargetIDAndPos(targetEntityID, pos)
            end
          end
        end
      end
    end
  end
  skillResult:SetScopeResult(scopeResult)
  if skillType and skillType == SkillType.Active and castEntity:HasPetPstID() then
    local notifyData = NTActiveSkillAttackStart:New(castEntity)
    notifyData:InitSkillResult(skillID, scopeResult)
    local battleStateCmpt = self._world:BattleStat()
    battleStateCmpt:SetLastActiveSkillID(skillID)
    battleStateCmpt:SetLastActiveSkillCasterID(castEntity:GetID())
    self._world:GetService("Trigger"):Notify(notifyData)
  end
  if castEntity:EntityType():IsSkillHolder() then
    local nt = NTBuffCastSkillAttackBegin:New(castEntity, skillID)
    nt:InitSkillScopeResult(scopeResult)
    self._world:GetService("Trigger"):Notify(nt)
  end
  if castEntity:HasMonsterID() then
    self._world:GetService("Trigger"):Notify(NTMonsterSkillDamageStart:New(castEntity, skillID))
  end
  self._activeSkillCalculator:DoCalculateSkill(castEntity)
  if castEntity:HasMonsterID() then
    self._world:GetService("Trigger"):Notify(NTMonsterSkillDamageEnd:New(castEntity, skillID))
  end
  if castEntity:EntityType():IsSkillHolder() then
    self._world:GetService("Trigger"):Notify(NTBuffCastSkillAttackEnd:New(castEntity, skillID))
  end
end

function SkillLogicService:UpdateRenderSkillRoutine(casterEntity, key)
  local svc = self._world:GetService("L2R")
  svc:L2ROneSkillData(casterEntity, key)
  casterEntity:ReplaceSkillContext()
end

function SkillLogicService:_ModifyScopeResult(casterEntity, scopeResult)
  if not casterEntity:HasPetPstID() then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local attackRange
  if attackRange ~= nil then
    scopeResult:SetAttackRange(attackRange)
  end
end

function SkillLogicService:_CalcSkillCastPos(casterEntity)
  if casterEntity:HasPetPstID() then
  else
  end
end

function SkillLogicService:ApplyAbsorbPhantom(result)
  if result:GetTargetEntityID() then
    local phantom = self._world:GetEntityByID(result:GetTargetEntityID())
    if not phantom:HasPhantomComponent() then
      Log.fatal("目标非幻象，不可吸收")
      return
    end
    local owner = self._world:GetEntityByID(phantom:PhantomComponent():GetOwnerEntityID())
    local damageInfo = DamageInfo:New(result:GetRecoverHP(), DamageType.Recover)
    local calcDamageSvc = self:GetService("CalcDamage")
    calcDamageSvc:AddTargetHP(owner:GetID(), damageInfo)
    result:SetRecoverHP(damageInfo:GetDamageValue())
    result:SetDamageInfo(damageInfo)
    local sBoard = self._world:GetService("BoardLogic")
    sBoard:RemoveEntityBlockFlag(phantom, phantom:GridLocation().Position)
    phantom:AddDeadMark()
    local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
    sMonsterShowLogic:_DoLogicDead(phantom)
  end
end

function SkillLogicService:CheckNormalSkill(skillID)
  if not skillID or skillID == 0 then
    return false
  end
  local configServer = self._world:GetService("Config")
  local config = configServer:GetSkillConfigData(skillID)
  if config:GetSkillType() == SkillType.Normal then
    return true
  end
  return false
end

function SkillLogicService:CheckAutoBeadSkill(skillID)
  if not skillID or skillID == 0 then
    return false
  end
  local configServer = self._world:GetService("Config")
  local config = configServer:GetSkillConfigData(skillID)
  if config:GetSkillType() == SkillType.AutoBeadSkill then
    return true
  end
  return false
end

function SkillLogicService:CalcAISkillResult(aiEntity, skillID, aiResult)
  self:CalcSkillEffect(aiEntity, skillID)
  local skillEffectResultContainer = aiEntity:SkillContext():GetResultContainer()
  skillEffectResultContainer:SetSkillID(skillID)
  aiResult:SetResultContainer(skillEffectResultContainer)
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local totalDamage = 0
  if damageResultArray then
    for _, damageResult in ipairs(damageResultArray) do
      totalDamage = totalDamage + damageResult:GetTotalDamage()
    end
  end
  if aiEntity:HasMonsterID() and 0 < totalDamage then
    self._world:GetService("Trigger"):Notify(NTMonsterAttackOrSkillDamageEnd:New(aiEntity, totalDamage))
  end
  aiEntity:ReplaceSkillContext()
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
end

function SkillLogicService:SelectTeam(teamEntity, pieceType)
  self._chainPathTargetSelector:DoSelectTeam(teamEntity, pieceType)
end

function SkillLogicService:UpdateTeamGridLocationByChainPath(teamEntity, chainPath)
  local castPos = chainPath[#chainPath]
  local newDirection = teamEntity:GetGridDirection()
  if 1 < #chainPath then
    newDirection = chainPath[#chainPath] - chainPath[#chainPath - 1]
  end
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, entityPet in ipairs(pets) do
    entityPet:SetGridLocation(castPos, newDirection)
    entityPet:GridLocation():SetMoveLastPosition(castPos)
  end
  teamEntity:SetGridLocation(castPos, newDirection)
  teamEntity:GridLocation():SetMoveLastPosition(castPos)
end

function SkillLogicService:IsSelectEntitySkill(skillID)
  if not skillID or skillID == 0 then
    return false
  end
  local configServer = self._world:GetService("Config")
  local config = configServer:GetSkillConfigData(skillID)
  local selectMode = config:GetTargetSelectionModeConfig()
  if selectMode and selectMode == SkillTargetSelectionMode.Entity then
    return true
  end
  return false
end

function SkillLogicService:IsSelectGridSkill(skillID)
  if not skillID or skillID == 0 then
    return false
  end
  local configServer = self._world:GetService("Config")
  local config = configServer:GetSkillConfigData(skillID)
  local selectMode = config:GetTargetSelectionModeConfig()
  if not selectMode or selectMode == SkillTargetSelectionMode.Grid then
    return true
  end
  return false
end

function SkillLogicService:CalcAutoBeadSkillDamage(teamEntity, skillCastPos)
  self._autoBeadSkillCalculator:DoCalculateAutoBeadSkill(teamEntity, skillCastPos)
end
