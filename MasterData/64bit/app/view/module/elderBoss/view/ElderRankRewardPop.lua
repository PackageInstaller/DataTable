local var_0_0 = g.core.const.ConstMgr.ElderBossConst
local ElderRankRewardPop = class("ElderRankRewardPop", require("app.fairyGUI.elderBoss.UI_ElderRankRewardPop"), function()
	return fgui.GComponent:create({
		resName = "ElderRankRewardPop",
		pkgName = "elderBoss",
		pkgPath = "ui/elderBoss/elderBoss"
	}, ...)
end)

function ElderRankRewardPop:ctor()
	self:showAtCenter()

	self._awardData = {}

	self:_initData()
	self:_initView()
end

function ElderRankRewardPop:_initData()
	self._awardData[1] = g.core.common.RankAward:getRankAwardArray(var_0_0.RANK_AWARD_TYPE_MAX)
	self._awardData[2] = g.core.common.RankAward:getRankAwardArray(var_0_0.RANK_AWARD_TYPE_TOTAL)
	self._awardData[3] = g.core.common.RankAward:getRankAwardArray(var_0_0.RANK_AWARD_TYPE_GUILD)
end

function ElderRankRewardPop:_initView()
	self.m_tabIndexController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabIndexChanged))
	self.m_rewardShowList:setVirtual()
	self.m_rewardShowList:setItemRenderer(handler(self, self._onRewardListRenderer))
	self:_onTabIndexChanged()
end

function ElderRankRewardPop:_onRewardListRenderer(arg_5_1, arg_5_2)
	local var_5_0 = self.m_tabIndexController:getSelectedIndex()

	arg_5_2:updateView(self._awardData[var_5_0 + 1][arg_5_1 + 1], var_5_0)
end

function ElderRankRewardPop:_onTabIndexChanged()
	self.m_rewardShowList:setNumItems(#self._awardData[self.m_tabIndexController:getSelectedIndex() + 1])
end

return ElderRankRewardPop
