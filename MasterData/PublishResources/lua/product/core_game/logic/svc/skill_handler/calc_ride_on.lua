_class("SkillEffectCalc_RideOn", Object)
SkillEffectCalc_RideOn = SkillEffectCalc_RideOn

function SkillEffectCalc_RideOn:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._rideSvc = self._world:GetService("RideLogic")
end

function SkillEffectCalc_RideOn:DoSkillEffectCalculator(skillEffectCalcParam)
  local fixedPos
  if skillEffectCalcParam.skillRange._className and skillEffectCalcParam.skillRange._className == "Vector2" then
    fixedPos = skillEffectCalcParam.skillRange
  else
    fixedPos = skillEffectCalcParam.skillRange[1]
  end
  if not fixedPos then
    return
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local curMountID
  if casterEntity:HasRide() then
    local rideCmpt = casterEntity:Ride()
    curMountID = rideCmpt:GetMountID()
  end
  local effectParam = skillEffectCalcParam.skillEffectParam
  local monsterClassID = effectParam:GetMonsterClassID()
  local monsterMountID, teleportPos = self:CalcMonsterState(monsterClassID, fixedPos)
  if monsterMountID and curMountID == monsterMountID then
    return
  end
  local trapID = effectParam:GetTrapID()
  local utilDataSvc = self._world:GetService("UtilData")
  local finalPos = fixedPos
  if teleportPos then
    finalPos = teleportPos
  end
  local trapMountID = utilDataSvc:GetTrapAtPosByTrapID(finalPos, trapID)
  if trapMountID and curMountID == trapMountID then
    return
  end
  local summonPosList = {}
  if not trapMountID then
    table.insert(summonPosList, finalPos)
  end
  local height = effectParam:GetTrapHeight()
  local centerOffset = Vector2.zero
  if monsterMountID then
    height = effectParam:GetMonsterHeight()
    centerOffset = effectParam:GetMonsterOffset()
  end
  local casterPos = casterEntity:GetGridPosition()
  local result = SkillEffectRideOnResult:New(curMountID, casterPos, monsterMountID, trapMountID, trapID, summonPosList, height, centerOffset)
  return result
end

function SkillEffectCalc_RideOn:CalcMonsterState(monsterClassID, fixedPos)
  if not monsterClassID then
    return nil
  end
  local monsterEntity
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() and monsterClassID == e:MonsterID():GetMonsterClassID() then
      monsterEntity = e
    end
  end
  if not monsterEntity then
    return nil
  end
  local needChangePos = false
  local buffCmpt = monsterEntity:BuffComponent()
  if buffCmpt then
    if not buffCmpt:HasBuffEffect(BuffEffectType.Palsy) then
      return monsterEntity:GetID()
    else
      local bodyArea = monsterEntity:BodyArea():GetArea()
      local pos = monsterEntity:GetGridPosition()
      for _, bodyPos in ipairs(bodyArea) do
        local curPos = pos + bodyPos
        if curPos == fixedPos then
          needChangePos = true
          break
        end
      end
    end
  end
  if not needChangePos then
    return nil, nil
  end
  local centerPos = monsterEntity:GetGridPosition()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalc = utilScopeSvc:GetSkillScopeCalc()
  local boardSvc = self._world:GetService("BoardLogic")
  local maxLen = boardSvc:GetCurBoardMaxLen()
  for ringCount = 1, maxLen do
    local scopeRes = skillCalc:ComputeScopeRange(SkillScopeType.AroundBodyArea, {0, ringCount}, centerPos, bodyArea)
    local posList = scopeRes:GetAttackRange()
    for _, value in ipairs(posList) do
      if not utilScopeSvc:IsPosHaveMonsterOrPet(value) then
        return nil, value
      end
    end
  end
end
