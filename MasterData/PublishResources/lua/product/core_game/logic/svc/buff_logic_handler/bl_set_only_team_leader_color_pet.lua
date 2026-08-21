require("buff_logic_base")
_class("BuffLogicSetOnlyTeamLeaderColorPet", BuffLogicBase)
BuffLogicSetOnlyTeamLeaderColorPet = BuffLogicSetOnlyTeamLeaderColorPet

function BuffLogicSetOnlyTeamLeaderColorPet:Constructor(buffinstance, logicParam)
  self._val = logicParam.Val or 1
end

function BuffLogicSetOnlyTeamLeaderColorPet:DoLogic(notify)
  self._buffComponent:SetBuffValue("OnlyTeamLeaderColorPet", self._val)
  local buffResult = BuffResultSetOnlyTeamLeaderColorPet:New(self._val)
  return buffResult
end
