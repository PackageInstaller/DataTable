_class("BuffLogicSetMonsterAntiAttackParam", BuffLogicBase)
BuffLogicSetMonsterAntiAttackParam = BuffLogicSetMonsterAntiAttackParam

function BuffLogicSetMonsterAntiAttackParam:Constructor(buffInstance, logicParam)
  self._waitActiveSkillCount = logicParam.WaitActiveSkillCount
  self._maxAntiSkillCountPerRound = logicParam.MaxAntiSkillCountPerRound
  self._antiActiveSkillType = logicParam.AntiActiveSkillType or {-1}
  self._antiSkillEnabled = logicParam.AntiSkillEnabled
end

function BuffLogicSetMonsterAntiAttackParam:DoLogic()
  local entity = self._buffInstance:Entity()
  if not entity then
    return
  end
  local curAttributeCmpt = entity:Attributes()
  if self._waitActiveSkillCount then
    curAttributeCmpt:Modify("WaitActiveSkillCount", self._waitActiveSkillCount)
    curAttributeCmpt:Modify("OriginalWaitActiveSkillCount", self._waitActiveSkillCount)
  end
  if self._maxAntiSkillCountPerRound then
    curAttributeCmpt:Modify("MaxAntiSkillCountPerRound", self._maxAntiSkillCountPerRound)
    curAttributeCmpt:Modify("OriginalMaxAntiSkillCountPerRound", self._maxAntiSkillCountPerRound)
  end
  if self._antiActiveSkillType then
    curAttributeCmpt:Modify("AntiActiveSkillType", self._antiActiveSkillType)
  end
  if self._antiSkillEnabled then
    curAttributeCmpt:Modify("AntiSkillEnabled", self._antiSkillEnabled)
  end
  local buffResult = BuffResultSetMonsterAntiAttackParam:New(entity:GetID())
  return buffResult
end
