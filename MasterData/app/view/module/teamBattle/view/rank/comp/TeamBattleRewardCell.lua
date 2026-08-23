local TeamBattleRewardCell = class("TeamBattleRewardCell", require("app.fairyGUI.teamBattle.UI_TeamBattleRewardCell"))

function TeamBattleRewardCell:ctor()
	self._rewardList = nil

	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderTeamBattleAwardList))
end

function TeamBattleRewardCell:_onRenderTeamBattleAwardList(arg_2_1, arg_2_2)
	self._rewardList[arg_2_1 + 1].scaleIndex = 4
	self._rewardList[arg_2_1 + 1].hideNum = false

	arg_2_2:updateIcon(self._rewardList[arg_2_1 + 1])
end

function TeamBattleRewardCell:updateCell(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1 or {}

	if not next(var_3_0) then
		return
	end

	self.m_hasBgController:setSelectedIndex(arg_3_2 % 2 == 0 and 1 or 0)

	if var_3_0.minRank <= 3 then
		self.m_rankIndexComp:updateRankIndex({
			rank = var_3_0.minRank
		})
		self.m_rankIndexComp:setVisible(true)
		self.m_rankTxt:setVisible(false)
	else
		self.m_rankIndexComp:setVisible(false)
		self.m_rankTxt:setText((g.core.lang:get(302510, {
			rank1 = var_3_0.minRank,
			rank2 = var_3_0.maxRank
		})))
		self.m_rankTxt:setVisible(true)
	end

	self._rewardList = var_3_0.data

	self.m_rewardList:setNumItems(#self._rewardList)
end

return TeamBattleRewardCell
