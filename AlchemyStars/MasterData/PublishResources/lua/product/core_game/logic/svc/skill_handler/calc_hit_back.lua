_class("SkillEffectCalc_HitBack", Object)
SkillEffectCalc_HitBack = SkillEffectCalc_HitBack

function SkillEffectCalc_HitBack:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._configService = self._world:GetService("Config")
end

function SkillEffectCalc_HitBack:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local enableByPickNum = skillEffectCalcParam.skillEffectParam:GetEnableByPickNum()
  if enableByPickNum then
    local checkNum = tonumber(enableByPickNum)
    local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
    local component = attacker:ActiveSkillPickUpComponent()
    if component then
      local curPickNum = component:GetAllValidPickUpGridPosCount()
      if curPickNum ~= checkNum then
        return
      end
    end
  end
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_HitBack:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local ctx = attacker:SkillContext()
  if ctx:HasDamageInfoFor(targetID) and not ctx:IsEntityDamaged(targetID) then
    Log.debug("SkillEffectCalcService:HitBackEffect() no hitback for damge==0!!")
    return
  end
  local defender = self._world:GetEntityByID(targetID)
  if not defender then
    return
  end
  local BuffLogicSvc = self._world:GetService("BuffLogic")
  if not BuffLogicSvc:CheckCanBeHitBack(defender) then
    return
  end
  local skillHitBackEffectParam = skillEffectCalcParam.skillEffectParam
  local checkBuffEffect = skillHitBackEffectParam:GetCheckBuffEffect()
  if checkBuffEffect and not defender:BuffComponent():HasBuffEffect(checkBuffEffect) then
    return
  end
  local calcType = skillHitBackEffectParam:GetCalcType()
  local beAttackEntityID = targetID
  local hitbackDistance = skillHitBackEffectParam:GetDistance()
  local hitbackDirType = skillHitBackEffectParam:GetDirType()
  local excludeCasterPos = skillHitBackEffectParam:ExcludeCasterPos()
  local extraParam = skillHitBackEffectParam:GetExtraParam()
  local bUseCasterPos = skillHitBackEffectParam:GetForceUseCasterPos()
  local usePickPosIndex = skillHitBackEffectParam:GetUsePickPosIndex()
  local notCalcBomb = skillHitBackEffectParam:GetNotCalcBomb()
  local ignorePathBlock = skillHitBackEffectParam:GetIgnorePathBlock()
  local backupDirectionPlan = skillHitBackEffectParam:GetBackupDirectionPlan()
  local interactType = skillHitBackEffectParam:GetInteractType()
  local skillConfigData = self._configService:GetSkillConfigData(skillEffectCalcParam.skillID)
  local pickType = skillConfigData:GetSkillPickType()
  local attackerPos = attacker:GridLocation().Position
  if bUseCasterPos then
  elseif skillEffectCalcParam.attackPos then
    attackerPos = skillEffectCalcParam.attackPos
  end
  local ignorePlayerBlock = skillHitBackEffectParam:GetIgnorePlayerBlock()
  local targetLocationCenter = defender:GridLocation():Center()
  local targetBodyArea = defender:BodyArea()
  if pickType == SkillPickUpType.DirectionInstruction then
    local component = attacker:ActiveSkillPickUpComponent()
    if component then
      hitbackDirType = component:GetLastPickUpDirection()
    end
  elseif pickType == SkillPickUpType.Instruction then
    local component = attacker:ActiveSkillPickUpComponent()
    if component then
      local pickList = component:GetAllValidPickUpGridPos()
      if bUseCasterPos then
      elseif usePickPosIndex and 0 < usePickPosIndex and usePickPosIndex <= #pickList then
        attackerPos = pickList[usePickPosIndex]
      else
        attackerPos = component:GetLastPickUpGridPos()
      end
    end
  end
  if hitbackDirType == HitBackDirectionType.SpecifyXCoordinate then
    local utilCalcSvc = self._world:GetService("UtilCalc")
    local dir, distance = utilCalcSvc:_CalcHitBack2SpecifyXCoordinate(defender, extraParam)
    if dir.x == -1 then
      hitbackDirType = HitBackDirectionType.Left
    elseif dir.x == 1 then
      hitbackDirType = HitBackDirectionType.Right
    else
      hitbackDirType = HitBackDirectionType.EightDir
    end
    hitbackDistance = distance
  end
  if calcType == HitBackCalcType.Delay then
    return SkillDelayHitBackEffectResult:New(skillEffectCalcParam.casterEntityID, beAttackEntityID, hitbackDistance, hitbackDirType, attackerPos, skillEffectCalcParam.gridPos, targetLocationCenter, targetBodyArea)
  end
  local type = skillHitBackEffectParam:GetType()
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local attackerDir = attacker:GridLocation().Direction
  local attackerBodyArea = attacker:BodyArea()
  local extraBlockPos = {}
  if skillHitBackEffectParam:IsCasterPosAsBlock() then
    for _, body in ipairs(attackerBodyArea:GetArea()) do
      table.insert(extraBlockPos, attackerPos + body)
    end
  end
  local skillRange = skillEffectCalcParam.skillRange
  local hitBackEffectResult = self._skillEffectService:CalcHitbackEffectResult(attackerPos, attackerDir, attackerBodyArea, beAttackEntityID, hitbackDirType, type, hitbackDistance, calcType, ignorePlayerBlock, excludeCasterPos, attacker, skillRange, notCalcBomb, ignorePathBlock, backupDirectionPlan, interactType, skillHitBackEffectParam:GetSkillType(), extraBlockPos)
  local eLocalTeam = self._world:Player():GetLocalTeamEntity()
  if defender:HasTeam() then
    if eLocalTeam:GetID() == defender:GetID() then
      self._world:BattleStat():AddPlayerSkillHitCount(skillEffectCalcParam.skillID)
    end
  elseif defender:HasPet() then
    local eTeam = defender:Pet():GetOwnerTeamEntity()
    if eTeam:GetID() == eLocalTeam:GetID() then
      self._world:BattleStat():AddPlayerSkillHitCount(skillEffectCalcParam.skillID)
    end
  end
  return hitBackEffectResult
end
