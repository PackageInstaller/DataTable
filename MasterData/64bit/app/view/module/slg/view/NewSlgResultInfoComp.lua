local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.Goods
local NewSlgResultInfoComp = class("NewSlgResultInfoComp", require("app.fairyGUI.newSlg.UI_NewSlgResultInfoComp"))

function NewSlgResultInfoComp:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAllianceAwardItemRender))
	self.m_kingAwardList:setVirtual()
	self.m_kingAwardList:setItemRenderer(handler(self, self._onKingAwardItemRender))
end

function NewSlgResultInfoComp:_onAllianceAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._allianceRewards[arg_2_1 + 1])
end

function NewSlgResultInfoComp:_onKingAwardItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._kingRewards[arg_3_1 + 1])
end

function NewSlgResultInfoComp:updateInfoComp(arg_4_1)
	local var_4_0 = var_0_0:packUser()

	if var_4_0 then
		self.m_userIconComp:updateAsUser(var_4_0)
		self.m_userNameTxt:setText(var_4_0.name)
		self.m_allianceNameTxt:setText(g.core.lang:get(429552) .. (var_0_0:getAllianceName() or ""))
	end

	local var_4_1 = var_0_1:convert({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION
	})

	if var_4_1 then
		self.m_conLoader:setURL(var_4_1.icon_mini)
		self.m_kingConLoader:setURL(var_4_1.icon_mini)
	end

	local var_4_2 = g.core.lang:get(429553)

	if arg_4_1[1].rankData.rank == 0 then
		self.m_noRankTxt:setVisible(true)
		self.m_contributionTxt:setText(var_4_2 .. arg_4_1[1].rankData.num .. g.core.lang:get(429554))
	else
		self.m_noRankTxt:setVisible(false)
		self.m_contributionTxt:setText(var_4_2 .. arg_4_1[1].rankData.num .. g.core.lang:get(429555, {
			rank = arg_4_1[1].rankData.rank
		}))

		self._allianceRewards = arg_4_1[1].awardArr

		self.m_awardList:setNumItems(#self._allianceRewards)
	end

	local var_4_3

	if g.core.model.User.newSlgData:getSName() == "S2" then
		var_4_3 = arg_4_1[3]

		self.m_seasonViewController:setSelectedIndex(1)
	else
		var_4_3 = arg_4_1[2]

		self.m_seasonViewController:setSelectedIndex(0)
	end

	if var_4_3.rankData.rank == 0 then
		self.m_noRankTxt1:setVisible(true)
		self.m_kingContributionTxt:setText(var_4_2 .. var_4_3.rankData.num .. g.core.lang:get(429554))
	else
		self.m_noRankTxt1:setVisible(false)
		self.m_kingContributionTxt:setText(var_4_2 .. var_4_3.rankData.num .. g.core.lang:get(429555, {
			rank = var_4_3.rankData.rank
		}))

		self._kingRewards = var_4_3.awardArr

		self.m_kingAwardList:setNumItems(#self._kingRewards)
	end
end

return NewSlgResultInfoComp
