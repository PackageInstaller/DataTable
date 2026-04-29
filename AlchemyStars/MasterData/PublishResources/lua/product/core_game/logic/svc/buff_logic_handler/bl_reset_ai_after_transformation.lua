_class("BuffLogicResetAIAfterTransformation", BuffLogicBase)
BuffLogicResetAIAfterTransformation = BuffLogicResetAIAfterTransformation

function BuffLogicResetAIAfterTransformation:Constructor(buffInstance, logicParam)
end

function BuffLogicResetAIAfterTransformation:DoLogic()
  local myCasterEntity = self._buffInstance:Entity()
  if not myCasterEntity:HasAI() then
    return
  end
  myCasterEntity:AI():SetRuntimeData("RoundCount", 0)
  myCasterEntity:AI():SetRuntimeData("NextRoundCount", 1)
  local MonsterID = myCasterEntity:MonsterID():GetMonsterID()
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local monsterStep = monsterConfigData:GetMonsterStep(MonsterID)
  local attributeCmpt = myCasterEntity:Attributes()
  attributeCmpt:Modify("Mobility", monsterStep, 1, MultModifyOperator.PLUS)
  myCasterEntity:AI():SetMobilityTotal(monsterStep)
  local aiList = monsterConfigData:GetMonsterAIID(MonsterID)
  myCasterEntity:ReplaceAI(AILogicPeriodType.Main, aiList[1], nil, true)
  local monsterAntiAttackAIIDList = monsterConfigData:GetMonsterAntiAttackAIID(MonsterID)
  if monsterAntiAttackAIIDList then
    myCasterEntity:ReplaceAI(AILogicPeriodType.Anti, monsterAntiAttackAIIDList[1], nil, true)
  else
    myCasterEntity:ClearAI(AILogicPeriodType.Anti)
  end
  myCasterEntity:AI():ReSelectWorkSkill()
end
