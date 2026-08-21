require("base_ins_r")
_class("PlayScorpionSummonMonsterInstruction", BaseInstruction)
PlayScorpionSummonMonsterInstruction = PlayScorpionSummonMonsterInstruction

function PlayScorpionSummonMonsterInstruction:Constructor(paramList)
end

function PlayScorpionSummonMonsterInstruction:GetCacheResource()
  local t = {}
  return t
end

function PlayScorpionSummonMonsterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local service = world:GetService("PlaySkillInstruction")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ScorpionSummon)
  if not resultArray then
    return
  end
  for i = 1, #resultArray do
    local result = resultArray[i]
    local summonType = result:GetSummonType()
    if summonType == SkillEffectEnum_SummonType.Monster then
      local summonReslut = result:GetSummonResult()
      for _, _result in ipairs(summonReslut) do
        service:ShowSummonAction(TT, world, _result)
      end
    end
    local nt = NTScorpionSummonEnd:New(result:GetGroupID())
    world:GetService("PlayBuff"):PlayBuffView(TT, nt)
  end
end
