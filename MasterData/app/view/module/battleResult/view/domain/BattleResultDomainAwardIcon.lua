local BattleResultDomainAwardIcon = class("BattleResultDomainAwardIcon", require("app.fairyGUI.battleResult.UI_BattleResultDomainAwardIcon"))

function BattleResultDomainAwardIcon:ctor()
	self.getSharedTrans(self, "listIconUiLeftIn", "ItemBagList", self)
end

function BattleResultDomainAwardIcon:updateAwardIcon(arg_2_1)
	self.m_iconComp:updateIcon(arg_2_1.award)
	self.m_isFirstController:setSelectedIndex(arg_2_1.isFirst and 1 or 0)
end

return BattleResultDomainAwardIcon
