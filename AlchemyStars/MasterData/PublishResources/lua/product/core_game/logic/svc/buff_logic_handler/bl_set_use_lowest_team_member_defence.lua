require("buff_logic_base")
_class("BuffLogicSetUseLowestTeamMemberDefence", BuffLogicBase)
BuffLogicSetUseLowestTeamMemberDefence = BuffLogicSetUseLowestTeamMemberDefence

function BuffLogicSetUseLowestTeamMemberDefence:Constructor(buffInstance, logicParam)
end

function BuffLogicSetUseLowestTeamMemberDefence:DoLogic()
  local holderEntity = self._buffInstance:Entity()
  local attributeCmpt = holderEntity:Attributes()
  if attributeCmpt then
    attributeCmpt:SetSimpleAttribute("UseLowestTeamMemberDefence", 1)
  end
end

function BuffLogicSetUseLowestTeamMemberDefence:DoOverlap(logicParam)
  self:DoLogic()
end

_class("BuffLogicResetUseLowestTeamMemberDefence", BuffLogicBase)
BuffLogicResetUseLowestTeamMemberDefence = BuffLogicResetUseLowestTeamMemberDefence

function BuffLogicResetUseLowestTeamMemberDefence:Constructor(buffInstance, logicParam)
end

function BuffLogicResetUseLowestTeamMemberDefence:DoLogic()
  local holderEntity = self._buffInstance:Entity()
  local attributeCmpt = holderEntity:Attributes()
  if attributeCmpt then
    attributeCmpt:SetSimpleAttribute("UseLowestTeamMemberDefence", 0)
  end
end
