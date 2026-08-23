local BattleResultStormStationLoseComp = class("BattleResultStormStationLoseComp", require("app.fairyGUI.battleResult.UI_BattleResultStormStationLoseComp"))

function BattleResultStormStationLoseComp:update(arg_1_1)
	self.m_conditionTxt:setText(g.core.lang:get(304624, {
		rank = arg_1_1.rank
	}))
end

return BattleResultStormStationLoseComp
