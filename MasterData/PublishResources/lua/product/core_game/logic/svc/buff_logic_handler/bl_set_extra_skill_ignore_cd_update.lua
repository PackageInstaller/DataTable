_class("BuffLogicSetExtraSkillIgnoreCdUpdate", BuffLogicBase)
BuffLogicSetExtraSkillIgnoreCdUpdate = BuffLogicSetExtraSkillIgnoreCdUpdate

function BuffLogicSetExtraSkillIgnoreCdUpdate:Constructor(buffInstance, logicParam)
  self._extraSkillIndex = tonumber(logicParam.extraSkillIndex)
  self._ignore = tonumber(logicParam.ignore)
end

function BuffLogicSetExtraSkillIgnoreCdUpdate:DoLogic()
  local e = self:GetEntity()
  if not e:HasSkillInfo() then
    return
  end
  local cSkillInfo = e:SkillInfo()
  if cSkillInfo then
    local bIgnore = self._ignore == 1
    cSkillInfo:SetExtraSkillIgnoreCdUpdate(self._extraSkillIndex, bIgnore)
  end
  return
end
