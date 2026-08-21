_class("BuffLogicDeleteWaringArea", BuffLogicBase)
BuffLogicDeleteWaringArea = BuffLogicDeleteWaringArea

function BuffLogicDeleteWaringArea:Constructor(buffInstance, logicParam)
  self._skillHolderName = logicParam.skillHolderName or "self"
end

function BuffLogicDeleteWaringArea:DoLogic()
  local e = self._buffInstance:Entity()
  local skillHolder
  local skillHolderName = self._skillHolderName .. e:GetID()
  local skillHolderID = e:GetSkillHolder(skillHolderName)
  if skillHolderID then
    skillHolder = self._world:GetEntityByID(skillHolderID)
  end
  if not skillHolder then
    return
  end
  local result = BuffResultDeleteWaringArea:New(skillHolderID)
  return result
end
