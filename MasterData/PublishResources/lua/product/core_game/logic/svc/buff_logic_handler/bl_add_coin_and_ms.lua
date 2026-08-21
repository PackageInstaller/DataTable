require("buff_logic_base")
_class("BuffLogicAddCoinAndMs", BuffLogicBase)
BuffLogicAddCoinAndMs = BuffLogicAddCoinAndMs

function BuffLogicAddCoinAndMs:Constructor(buffinstance, logicParam)
  self._addGoldCoin = logicParam.addGoldCoin
  self._addMS = logicParam.addMS
end

function BuffLogicAddCoinAndMs:DoLogic(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local com = teamEntity:BuffComponent()
  com:SetBuffValue("SeasonMazeAddGoldCoin", self._addGoldCoin)
  com:SetBuffValue("SeasonMazeAddMS", self._addMS)
end
