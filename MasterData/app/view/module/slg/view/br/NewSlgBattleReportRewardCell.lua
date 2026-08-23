local NewSlgBattleReportRewardCell = class("NewSlgBattleReportRewardCell", require("app.fairyGUI.newSlg.UI_NewSlgBattleReportRewardCell"))

function NewSlgBattleReportRewardCell:updateReportReward(arg_1_1, arg_1_2, arg_1_3)
	if arg_1_2 then
		self.m_itemIcon:setURL(g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION
		}).icon_mini)
		self.m_numText:setText("x" .. arg_1_3)
	else
		self.m_itemIcon:setURL(g.core.common.Goods:convert(arg_1_1).icon_mini)
		self.m_numText:setText("x" .. arg_1_1.size)
	end
end

return NewSlgBattleReportRewardCell
