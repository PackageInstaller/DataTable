_class("SkillEffectCalc_SummonOnFixPosLimit", Object)
SkillEffectCalc_SummonOnFixPosLimit = SkillEffectCalc_SummonOnFixPosLimit

function SkillEffectCalc_SummonOnFixPosLimit:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SummonOnFixPosLimit:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParamSummon = skillEffectCalcParam.skillEffectParam
  local trapID = skillEffectParamSummon:GetTrapID()
  local limitCount = skillEffectParamSummon:GetLimitCount()
  local posList = skillEffectParamSummon:GetFixPosList()
  local summonCount = skillEffectParamSummon:GetSummonCount()
  local ignoreBlock = skillEffectParamSummon:IgnoreBlock()
  local blockFlag = BlockFlag.SummonTrap
  if ignoreBlock then
    blockFlag = 0
  end
  local battleFlags = self._world:BattleFlags()
  local summonIndex = battleFlags:GetSummonOnFixPosLimitIndex()
  local index = 0
  local summonPosList = {}
  for i = 1, summonCount do
    index = math.fmod(summonIndex + i, #posList)
    if index == 0 then
      index = #posList
    end
    if limitCount >= table.count(summonPosList) then
      table.insert(summonPosList, posList[index])
    else
      Log.debug("")
    end
  end
  battleFlags:SetSummonOnFixPosLimitIndex(index)
  local result = SkillEffectResultSummonOnFixPosLimit:New(trapID, summonPosList)
  local destroyEntityIDList = {}
  local entityIDList = battleFlags:GetSummonOnFixPosLimitEntityID(trapID)
  local meantimeCount = #summonPosList + #entityIDList
  local curIndex = 1
  while limitCount < meantimeCount do
    local curEntityID = entityIDList[curIndex]
    meantimeCount = meantimeCount - 1
    curIndex = curIndex + 1
    table.insert(destroyEntityIDList, curEntityID)
  end
  result:SetDestroyEntityIDList(destroyEntityIDList)
  return result
end
