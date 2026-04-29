_class("SkillEffectCalc_SummonMeantimeLimit", Object)
SkillEffectCalc_SummonMeantimeLimit = SkillEffectCalc_SummonMeantimeLimit

function SkillEffectCalc_SummonMeantimeLimit:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SummonMeantimeLimit:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParamSummon = skillEffectCalcParam.skillEffectParam
  local trapID = skillEffectParamSummon:GetTrapID()
  local limitCount = skillEffectParamSummon:GetLimitCount()
  local trapDieSkillID = skillEffectParamSummon:GetTrapDieSkillID()
  local absPosArray = skillEffectParamSummon:GetAbsPosArray()
  local ignoreBlock = skillEffectParamSummon:IgnoreBlock()
  local replaceAttr = skillEffectParamSummon:GetReplaceAttr()
  local blockFlag = BlockFlag.SummonTrap
  if ignoreBlock then
    blockFlag = 0
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local posRange = skillEffectCalcParam.skillRange
  if absPosArray and 0 < #absPosArray then
    posRange = absPosArray
  end
  local summonPosList = {}
  for _, gridPos in ipairs(posRange) do
    if trapServiceLogic:CanSummonTrapOnPos(gridPos, trapID, blockFlag, false) and limitCount >= table.count(summonPosList) and self:_CheckOverlapCanSummon(gridPos, trapID, skillEffectCalcParam) then
      table.insert(summonPosList, gridPos)
    end
  end
  if #summonPosList == 0 then
    return
  end
  local result = SkillEffectResultSummonMeantimeLimit:New(trapID, summonPosList)
  local destroyEntityID = {}
  local skillResultList = {}
  local battleFlags = self._world:BattleFlags()
  local summonMeantimeLimitEntityID = {}
  local checkTrapIDs = skillEffectParamSummon:GetCheckTrapID()
  for i, checkTrapID in ipairs(checkTrapIDs) do
    local entityIDList = battleFlags:GetSummonMeantimeLimitEntityID(checkTrapID)
    table.appendArray(summonMeantimeLimitEntityID, entityIDList)
  end
  table.sort(summonMeantimeLimitEntityID, function(a, b)
    return a < b
  end)
  local meantimeCount = table.count(summonMeantimeLimitEntityID) + table.count(summonPosList)
  for _, gridPos in ipairs(summonPosList) do
    for _, entityID in ipairs(summonMeantimeLimitEntityID) do
      local targetEntity = self._world:GetEntityByID(entityID)
      if targetEntity and not targetEntity:HasDeadMark() and targetEntity:GetGridPosition() == gridPos and targetEntity:Trap():GetTrapLevel() ~= -1 then
        meantimeCount = meantimeCount - 1
      end
    end
  end
  local curIndex = 1
  while limitCount < meantimeCount do
    local curEntityID = summonMeantimeLimitEntityID[curIndex]
    meantimeCount = meantimeCount - 1
    curIndex = curIndex + 1
    table.insert(destroyEntityID, curEntityID)
    if trapDieSkillID and 0 < trapDieSkillID then
      local curEntity = self._world:GetEntityByID(curEntityID)
      local skillLogicSvc = self._world:GetService("SkillLogic")
      skillLogicSvc:CalcSkillEffect(curEntity, trapDieSkillID)
      local skillResult = curEntity:SkillContext():GetResultContainer()
      table.insert(skillResultList, skillResult)
    end
  end
  result:SetDestroyEntityID(destroyEntityID)
  result:SetTrapDieSkillResult(skillResultList)
  result:SetReplaceAttr(replaceAttr)
  return result
end

function SkillEffectCalc_SummonMeantimeLimit:_CheckOverlapCanSummon(pos, trapId, skillEffectCalcParam)
  local skillEffectParamSummon = skillEffectCalcParam.skillEffectParam
  if not skillEffectParamSummon:IsTrapOverlap() then
    local boardCmpt = self._world:GetBoardEntity():Board()
    local repeatTraps = boardCmpt:GetPieceEntities(pos, function(e)
      local isOwner = false
      if e:HasSummoner() then
        if e:Summoner():GetSummonerEntityID() == skillEffectCalcParam.casterEntityID then
          isOwner = true
        else
          local summonerID = e:Summoner():GetSummonerEntityID()
          local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
          if casterEntity:HasPet() then
            local cTeam = casterEntity:Pet():GetOwnerTeamEntity():Team()
            local entities = cTeam:GetTeamPetEntities()
            for _, petEntity in ipairs(entities) do
              if summonerID == petEntity:GetID() then
                isOwner = true
                break
              end
            end
          end
        end
      else
        isOwner = true
      end
      return isOwner and e:HasTrap() and e:Trap():GetTrapID() == trapId and not e:HasDeadMark()
    end)
    if 0 < #repeatTraps then
      return false
    else
      return true
    end
  else
    return true
  end
end
