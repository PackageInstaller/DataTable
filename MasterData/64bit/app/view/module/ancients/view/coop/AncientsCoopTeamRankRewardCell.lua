local AncientsCoopTeamRankRewardCell = class("AncientsCoopTeamRankRewardCell", require("app.fairyGUI.ancients.UI_AncientsCoopTeamRankRewardCell"))

function var_0_0:ctor()
	self.m_List_award:setVirtual(self)
	self.m_List_award:setItemRenderer(handler(self, self._onRenderListAwardCell))

	self._rewardArr = {}
end

function var_0_0:updateCell(arg_2_1)
	self.m_haveBgController:setSelectedIndex(arg_2_1.index % 2 == 1 and 1 or 0)
	self.m_awardTypeController:setSelectedIndex(arg_2_1.tabIndex == 2 and 1 or 0)

	local var_2_0 = arg_2_1.award

	self.m_Txt_name:updateRangeRankIndex({
		max = arg_2_1.award.maxRank,
		min = arg_2_1.award.minRank
	})

	local var_2_1 = arg_2_1.selfRank or 0

	self.m_is_selfController:setSelectedIndex(var_2_1 >= var_2_0.minRank and var_2_1 <= var_2_0.maxRank and 1 or 0)

	self._rewardArr = var_2_0.data

	self.m_List_award:setNumItems(#self._rewardArr)

	if arg_2_1.tabIndex == 2 then
		self.m_rankingAliasComp:updateComp(({
			7,
			6,
			nil,
			5,
			nil,
			nil,
			nil,
			4,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			3
		})[var_2_0.maxRank])
	end
end

function var_0_0:_onRenderListAwardCell(arg_3_1, arg_3_2)
	self._rewardArr[arg_3_1 + 1].scaleIndex = 4

	arg_3_2:updateIcon(self._rewardArr[arg_3_1 + 1])
end

return var_0_0
