require("base_ins_r")
_class("DataSelectNextDeadTargetInstruction", BaseInstruction)
DataSelectNextDeadTargetInstruction = DataSelectNextDeadTargetInstruction

function DataSelectNextDeadTargetInstruction:Constructor(paramList)
end

function DataSelectNextDeadTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  if not damageResultArray or #damageResultArray == 0 then
    return false
  end
  local targetEntityList = {}
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    if targetEntity and not table.intable(targetEntityList, targetEntity) then
      table.insert(targetEntityList, targetEntity)
    end
  end
  local deadMonsterIDList = {}
  for _, entity in ipairs(targetEntityList) do
    local view = entity:View()
    local renderCurHP = entity:HP():GetRedHP()
    if view and renderCurHP == 0 then
      table.insert(deadMonsterIDList, entity:GetID())
    end
  end
  local damageIndex = phaseContext:GetCurDamageResultIndex()
  damageIndex = damageIndex + 1
  phaseContext:SetCurDamageResultIndex(damageIndex)
  if damageIndex > #deadMonsterIDList or #deadMonsterIDList == 0 then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local targetEntityID = deadMonsterIDList[damageIndex]
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
