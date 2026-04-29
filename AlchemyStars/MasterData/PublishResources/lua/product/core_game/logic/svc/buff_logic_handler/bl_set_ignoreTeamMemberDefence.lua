require("buff_logic_base")
_class("BuffLogicSetIgnoreTeamMemberDefence", BuffLogicBase)
BuffLogicSetIgnoreTeamMemberDefence = BuffLogicSetIgnoreTeamMemberDefence

function BuffLogicSetIgnoreTeamMemberDefence:Constructor(buffInstance, logicParam)
  self._defPercent = tonumber(logicParam.defPercent) or 1
end

function BuffLogicSetIgnoreTeamMemberDefence:DoLogic()
  local petEntity = self._buffInstance:Entity()
  local attributeCmpt = petEntity:Attributes()
  attributeCmpt:SetSimpleAttribute("IgnoreTeamMemberDefence", self._defPercent)
end

function BuffLogicSetIgnoreTeamMemberDefence:DoOverlap(logicParam)
  local newParam = tonumber(logicParam.defPercent) or 1
  self._defPercent = self._defPercent + newParam
end

_class("BuffLogicResetIgnoreTeamMemberDefence", BuffLogicBase)
BuffLogicResetIgnoreTeamMemberDefence = BuffLogicResetIgnoreTeamMemberDefence

function BuffLogicResetIgnoreTeamMemberDefence:Constructor(buffInstance, logicParam)
end

function BuffLogicResetIgnoreTeamMemberDefence:DoLogic()
  local petEntity = self._buffInstance:Entity()
  local attributeCmpt = petEntity:Attributes()
  attributeCmpt:SetSimpleAttribute("IgnoreTeamMemberDefence", 0)
end
