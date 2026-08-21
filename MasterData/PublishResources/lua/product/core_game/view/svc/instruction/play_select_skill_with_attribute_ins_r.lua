require("base_ins_r")
_class("PlaySelectSkillWithAttributeInstruction", BaseInstruction)
PlaySelectSkillWithAttributeInstruction = PlaySelectSkillWithAttributeInstruction

function PlaySelectSkillWithAttributeInstruction:Constructor(paramList)
  self._skill = tonumber(paramList.skill)
  self._attribute = paramList.attribute
end

function PlaySelectSkillWithAttributeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillID = 0
  local utilDataSvc = world:GetService("UtilData")
  local attribute = utilDataSvc:GetEntityAttributeByName(casterEntity, self._attribute) or 0
  if 0 < attribute then
    skillID = self._skill + attribute
  end
  if skillID == 0 then
    return
  end
  local playSkillSvc = world:GetService("PlaySkill")
  local configSvc = world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, casterEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  playSkillSvc:_SkillRoutineTask(TT, casterEntity, skillPhaseArray, skillID)
end
