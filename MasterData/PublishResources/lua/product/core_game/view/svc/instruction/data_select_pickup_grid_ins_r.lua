require("base_ins_r")
_class("DataSelectPickupGridInstruction", BaseInstruction)
DataSelectPickupGridInstruction = DataSelectPickupGridInstruction

function DataSelectPickupGridInstruction:Constructor(paramList)
  self._gridIndex = tonumber(paramList.gridIndex)
end

function DataSelectPickupGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local pickUpType = self:_GetPickUpType(casterEntity)
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local scopeGridList = renderPickUpComponent:GetAllValidPickUpGridPos()
  phaseContext:SetCurGridPos(scopeGridList[self._gridIndex])
end

function DataSelectPickupGridInstruction:_GetPickUpType(casterEntity)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local world = casterEntity:GetOwnerWorld()
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  return skillConfigData:GetSkillPickType()
end
