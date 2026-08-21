_class("SkillEffectCalcTrapSummonMonster", Object)
SkillEffectCalcTrapSummonMonster = SkillEffectCalcTrapSummonMonster

function SkillEffectCalcTrapSummonMonster:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._configService = self._world:GetService("Config")
end

function SkillEffectCalcTrapSummonMonster:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local param = skillEffectCalcParam.skillEffectParam
  local casterID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterID)
  local type = param:GetSummonType()
  local monsterIDList = param:GetMonsterIDList()
  local delay = param:GetDelay()
  local attCpt = casterEntity:Attributes()
  local curRound = self._world:BattleStat():GetLevelTotalRoundCount()
  local trapBeginCastRound = attCpt:GetAttribute("TrapBeginCastRound")
  local trapCmpt = casterEntity:Trap()
  local bornRound = trapCmpt:GetTrapBornRound()
  local interval = param:GetInterval()
  local trapOpenState = attCpt:GetAttribute("OpenState")
  if not trapBeginCastRound then
    trapBeginCastRound = curRound
    attCpt:SetSimpleAttribute("TrapBeginCastRound", curRound)
  end
  local result = SkillEffectTrapSummonMonsterResult:New()
  local summonMonsterIndex = attCpt:GetAttribute("TrapNextMonsterIndex")
  local summonDone = attCpt:GetAttribute("TrapSummonDone")
  local canSummon = true
  local summonRound = attCpt:GetAttribute("TrapNextSummonMonsterRound")
  if delay ~= 0 then
    if delay + bornRound == curRound + 1 and trapOpenState == 0 then
      do
        result:SetTrapOpenStateChange(true)
        attCpt:Modify("OpenState", 1)
        result:SetTrapOpenState(1)
        local res = DataAttributeResult:New(casterID, "OpenState", 1)
        self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
      end
    else
      if delay > curRound - bornRound then
        goto lbl_210
      end
      summonMonsterIndex = summonMonsterIndex or 1
      if not summonDone or summonDone ~= 1 then
        if not self:IsCasterPosBlock(casterEntity, summonMonsterIndex, monsterIDList, type) then
          canSummon = false
        end
        summonRound = summonRound or curRound
        if summonRound == curRound + 1 then
          do
            result:SetTrapOpenStateChange(true)
            attCpt:Modify("OpenState", 1)
            result:SetTrapOpenState(1)
            local res = DataAttributeResult:New(casterID, "OpenState", 1)
            self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
          end
        elseif not (curRound < summonRound) and canSummon then
          summonRound = summonRound + interval + 1
          attCpt:SetSimpleAttribute("TrapNextSummonMonsterRound", summonRound)
          goto lbl_150
          goto lbl_210
          ::lbl_150::
          if type == TrapSummonMonsterType.SequenceType then
            if summonMonsterIndex + 1 > #monsterIDList then
              attCpt:SetSimpleAttribute("TrapSummonDone", 1)
            end
          elseif type == TrapSummonMonsterType.CycleType and summonMonsterIndex > #monsterIDList then
            summonMonsterIndex = 1
          end
          if canSummon then
            local monsterID = monsterIDList[summonMonsterIndex]
            result = self:SummonMonster(casterEntity, monsterID)
            attCpt:SetSimpleAttribute("TrapNextMonsterIndex", summonMonsterIndex + 1)
            if 0 < interval then
              result:SetTrapOpenStateChange(true)
              attCpt:Modify("OpenState", 0)
              result:SetTrapOpenState(0)
              local res = DataAttributeResult:New(casterID, "OpenState", 0)
              self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
            end
          end
        end
      end
    end
  end
  ::lbl_210::
  return {result}
end

function SkillEffectCalcTrapSummonMonster:IsCasterPosBlock(casterEntity, summonMonsterIndex, monsterIDList, type)
  local bodyAreCpt = casterEntity:BodyArea()
  local casterPos = casterEntity:GetGridPosition()
  local monsterConfigData = self._configService:GetMonsterConfigData()
  if summonMonsterIndex > #monsterIDList and type == TrapSummonMonsterType.CycleType then
    summonMonsterIndex = 1
  end
  local monsterID = monsterIDList[summonMonsterIndex]
  if not monsterID then
    return false
  end
  local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
  local blockFlag
  if monsterRaceType == MonsterRaceType.Fly then
    blockFlag = BlockFlag.MonsterFly
  elseif monsterRaceType == MonsterRaceType.Land then
    blockFlag = BlockFlag.MonsterLand
  end
  local bodyArea = bodyAreCpt:GetArea()
  local boardSvc = self._world:GetService("BoardLogic")
  for i, pos in ipairs(bodyArea) do
    local newPos = pos + casterPos
    if boardSvc:IsPosBlock(newPos, blockFlag) then
      return false
    end
  end
  return true
end

function SkillEffectCalcTrapSummonMonster:SummonMonster(casterEntity, monsterID)
  local bodyAreCpt = casterEntity:BodyArea()
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  local monsterTransformParam = MonsterTransformParam:New(monsterID)
  local casterPos = casterEntity:GetGridPosition()
  local casterDir = casterEntity:GetGridDirection()
  monsterTransformParam:SetPosition(casterPos)
  monsterTransformParam:SetForward(casterDir)
  monsterTransformParam:SetRotation(casterDir)
  local monsterEntity = monsterCreationSvc:CreateMonster(monsterTransformParam)
  monsterEntity:AddSummoner(casterEntity:GetID())
  local result = SkillEffectTrapSummonMonsterResult:New(monsterEntity:GetID())
  result:SetMonsterTransformParam(monsterTransformParam)
  return result
end
