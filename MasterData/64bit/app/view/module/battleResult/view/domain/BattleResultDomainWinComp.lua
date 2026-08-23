local BattleResultDomainWinComp = class("BattleResultDomainWinComp", require("app.fairyGUI.battleResult.UI_BattleResultDomainWinComp"))

function BattleResultDomainWinComp:update(arg_1_1)
	self.m_gradeLoader:setURL("ui://domainDungeon/pic_mnly_" .. arg_1_1.grade)
end

return BattleResultDomainWinComp
