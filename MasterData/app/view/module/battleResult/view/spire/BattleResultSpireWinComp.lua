local BattleResultSpireWinComp = class("BattleResultSpireWinComp", require("app.fairyGUI.battleResult.UI_BattleResultSpireTipComp"))

function BattleResultSpireWinComp:update(arg_1_1)
	self.m_title:setText(arg_1_1.titleTips)
end

return BattleResultSpireWinComp
