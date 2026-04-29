_class("BuffLogicSetChainRate", BuffLogicBase)
BuffLogicSetChainRate = BuffLogicSetChainRate

function BuffLogicSetChainRate:Constructor(buffInstance, logicParam)
  self._chainRate = logicParam.chainRate or 1
end

function BuffLogicSetChainRate:DoLogic(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCmpt = teamEntity:BuffComponent()
  buffCmpt:SetBuffValue("ChainRate", self._chainRate)
end
