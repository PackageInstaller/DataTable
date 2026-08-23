local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.teamPvpData
local var_0_2 = g.core.common.Drops
local var_0_3 = g.core.config.group_battle_score_info
local BattleResultTeamPvpRewardComp = class("BattleResultTeamPvpRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultTeamPvpRewardComp"))

function BattleResultTeamPvpRewardComp:ctor()
	self._report = nil
	self._rewardList = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onListAwardRenderer))
	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))
end

function BattleResultTeamPvpRewardComp:_onListAwardRenderer(arg_2_1, arg_2_2)
	arg_2_2._inAnim = arg_2_2._inAnim or arg_2_2.getSharedTrans(arg_2_2, "listIconUiLeftIn", "ItemBagList", arg_2_2)

	arg_2_2:updateIcon(self._rewardList[arg_2_1 + 1])
end

function BattleResultTeamPvpRewardComp:_onTransAward()
	if self._dropParams then
		self.m_rewardList:setNumItems(#self._dropParams)
		self.m_rewardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
	end
end

function BattleResultTeamPvpRewardComp:update(arg_4_1)
	self._rewardList = {}
	self._report = var_0_1:getBattleReport()

	if not self._report then
		return
	end

	self.m_scoreTxt:setText("+" .. self._report.user_add_honor)

	if self._report.user_add_score > 0 then
		table.insert(self._rewardList, var_0_0:convert({
			type = var_0_0.TYPE_RESOURCE,
			value = var_0_0.RESOURCE.TYPE_TEAM_PVP,
			size = self._report.user_add_score
		}))
	end

	if not var_0_1:isMyselfHelp() then
		local var_4_0 = var_0_3.fetch((g.core.model.User:getLevel()))

		if var_4_0 then
			for iter_4_0, iter_4_1 in ipairs((var_0_2:getGoodsArray((self._report.isWin or nil) and (var_4_0.win_reward or var_4_0.defeat_reward)))) do
				table.insert(self._rewardList, iter_4_1)
			end
		end
	end

	local var_4_1 = #self._rewardList

	self.m_rewardList:setNumItems(#self._rewardList)
	self.m_noRewardTxt:setVisible(var_4_1 == 0)
end

return BattleResultTeamPvpRewardComp
