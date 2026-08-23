local BattlePath = require("app.view.battle.BattlePath")
local BattleMarkIconComp = class("BattleMarkIconComp", require("app.fairyGUI.battle.UI_BattleMarkIconComp"))

function BattleMarkIconComp:ctor(arg_1_1)
	return
end

function BattleMarkIconComp:updateView(arg_2_1)
	self.m_roundNumText:setText(arg_2_1.buffTime)
	self.m_iconImg:setURL((BattlePath:getBuffSpinePath(arg_2_1.buffIcon)))
end

return BattleMarkIconComp
