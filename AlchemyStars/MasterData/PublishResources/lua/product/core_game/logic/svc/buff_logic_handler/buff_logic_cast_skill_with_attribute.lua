_class("BuffLogicCastSkillWithAttribute", BuffLogicBase)
BuffLogicCastSkillWithAttribute = BuffLogicCastSkillWithAttribute

function BuffLogicCastSkillWithAttribute:Constructor(buffInstance, logicParam)
  self._skill = logicParam.skill
  self._attribute = logicParam.attribute
  self._skillHolderName = logicParam.skillHolderName
  self._useNotifyEntityPos = logicParam.useNotifyEntityPos or 0
end

function BuffLogicCastSkillWithAttribute:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = e
  end
  local skillID
  local attributesComponent = e:Attributes()
  local attribute = attributesComponent:GetAttribute(self._attribute) or 0
  if 0 < attribute then
    skillID = self._skill[attribute]
  end
  if not skillID then
    return
  end
  local skillHolder
  if self._skillHolderName == "self" then
    skillHolder = e
  elseif not self._skillHolderName then
    local entityService = self._world:GetService("LogicEntity")
    skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.SkillHolder)
    self._skillHolderName = "SkillHolder" .. skillHolder:GetID()
    e:AddSkillHolder(self._skillHolderName, skillHolder:GetID())
    skillHolder:AddSuperEntity(e)
    skillHolder:SuperEntityComponent():SetBuffSkillHolderCasterEntityID(casterEntity:GetID())
    skillHolder:ReplaceAlignment(e:Alignment():GetAlignmentType())
    skillHolder:ReplaceGameTurn(e:GameTurn():GetGameTurn())
  else
    local skillHolderName = self._skillHolderName .. e:GetID()
    local skillHolderID = e:GetSkillHolder(skillHolderName)
    if not skillHolderID then
      local entityService = self._world:GetService("LogicEntity")
      skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.SkillHolder)
      e:AddSkillHolder(skillHolderName, skillHolder:GetID())
      skillHolder:AddSuperEntity(e)
      skillHolder:SuperEntityComponent():SetBuffSkillHolderCasterEntityID(casterEntity:GetID())
      skillHolder:ReplaceAlignment(e:Alignment():GetAlignmentType())
      skillHolder:ReplaceGameTurn(e:GameTurn():GetGameTurn())
    else
      skillHolder = self._world:GetEntityByID(skillHolderID)
    end
  end
  if skillHolder:HasSuperEntity() then
    local superEntity = skillHolder:SuperEntityComponent():GetSuperEntity()
    local superAttributesComponent = superEntity:Attributes()
    if not skillHolder:HasAttributes() then
      skillHolder:AddAttributes()
    end
    local modifierDic = superAttributesComponent:CloneAttributes()
    skillHolder:Attributes():SetModifierDic(modifierDic)
    local element = superEntity:Element()
    skillHolder:ReplaceElement(element:GetPrimaryType())
  end
  if self._useNotifyEntityPos == 1 then
    skillHolder:SetGridPosition(e:GetGridPosition())
  end
  local skillLogicSvc = self._world:GetService("SkillLogic")
  skillLogicSvc:CalcSkillEffect(skillHolder, skillID)
  local result = skillHolder:SkillContext():GetResultContainer()
  local buffResult = BuffResultCastSkillWithAttribute:New(skillID, skillHolder:GetID(), result)
  return buffResult
end

_class("BuffLogicCastSkill_ByAction", BuffLogicBase)
BuffLogicCastSkill_ByAction = BuffLogicCastSkill_ByAction

function BuffLogicCastSkill_ByAction:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
  self._actionAI_Name = logicParam.actionName
  self._actionAI_Data = logicParam.actionData
end

function BuffLogicCastSkill_ByAction:DoLogic(notify)
  local entityWork = self._buffInstance:Entity()
  local actionAi = Classes[self._actionAI_Name]:New()
  actionAi:SetInitialize(self._world, entityWork)
  actionAi:SetConfigData(self._actionAI_Data)
  actionAi:Activate()
  actionAi:Update()
  if AINewNodeStatus.Failure == actionAi:GetStatues() then
    return nil
  end
  local skillID = self._skillID
  if 0 < skillID then
    local skillLogicSvc = self._world:GetService("SkillLogic")
    skillLogicSvc:CalcSkillEffect(entityWork, skillID)
    local result = entityWork:SkillContext():GetResultContainer()
    Log.debug("BuffLogicCastSkill_ByAction entityID=", entityWork:GetID(), " skillID=", skillID)
    local result = BuffResultCastSkill_ByAction:New(skillID, result)
    return result
  end
end
