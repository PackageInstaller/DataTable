local ChangeSkillFinalByPassiveAndEnergyCostMode = {Full = 1, CurrentRound = 2}
_enum("ChangeSkillFinalByPassiveAndEnergyCostMode", ChangeSkillFinalByPassiveAndEnergyCostMode)
_class("BuffLogicChangeSkillFinalByPassiveAndEnergyCost", BuffLogicBase)
BuffLogicChangeSkillFinalByPassiveAndEnergyCost = BuffLogicChangeSkillFinalByPassiveAndEnergyCost

function BuffLogicChangeSkillFinalByPassiveAndEnergyCost:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList_changeSkillFinalByPassiveAndEnergyCost = logicParam.effectList
  self._range = logicParam.range
  self._val = logicParam.val
  self._maxVal = logicParam.maxVal
  self._mode = logicParam.mode
end

local function getFinalCount(mode, round, active, passive)
  local activeCount = 0
  local passiveCount = 0
  if mode == ChangeSkillFinalByPassiveAndEnergyCostMode.Full then
    for _, v in pairs(active) do
      activeCount = activeCount + v
    end
    for _, v in pairs(passive) do
      passiveCount = passiveCount + v
    end
  else
    activeCount = active[round] or 0
    passiveCount = passive[round] or 0
  end
  return activeCount + passiveCount
end

function BuffLogicChangeSkillFinalByPassiveAndEnergyCost:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList_changeSkillFinalByPassiveAndEnergyCost) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
  local cBuff = self:GetBuffComponent()
  local activeSkillEnergyCostCount = cBuff:GetBuffValue("ActiveSkillEnergyCostCountByRound") or {}
  local passiveSkillCount = cBuff:GetBuffValue("PassiveSkillCostCountByRound") or {}
  local round = self._world:BattleStat():GetLevelTotalRoundCount()
  local count = getFinalCount(self._mode, round, activeSkillEnergyCostCount, passiveSkillCount)
  if count <= 0 then
    return
  end
  local changeValue = 0
  if count > self._range[#self._range] then
    count = self._maxVal
  else
    for i = #self._range, 1, -1 do
      local edge = self._range[i]
      if count < edge then
        changeValue = self._val[i]
      end
    end
  end
  for _, paramType in ipairs(self._buffInstance._effectList_changeSkillFinalByPassiveAndEnergyCost) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, changeValue)
  end
end

function BuffLogicChangeSkillFinalByPassiveAndEnergyCost:DoOverlap()
  self:DoLogic()
end

_class("BuffLogicRevertSkillFinalByPassiveAndEnergyCost", BuffLogicBase)
BuffLogicRevertSkillFinalByPassiveAndEnergyCost = BuffLogicRevertSkillFinalByPassiveAndEnergyCost

function BuffLogicRevertSkillFinalByPassiveAndEnergyCost:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList_changeSkillFinalByPassiveAndEnergyCost) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
