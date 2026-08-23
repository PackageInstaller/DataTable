local TeamBattleRankCell = class("TeamBattleRankCell", require("app.fairyGUI.teamBattle.UI_TeamBattleRankCell"))

function TeamBattleRankCell:updateBattleRankCell(arg_1_1, arg_1_2)
	self.m_isTop3Controller:setSelectedIndex(arg_1_2 <= 3 and 1 or 0)
	self.m_rankIndexComp:updateRankIndex({
		rank = arg_1_2
	})
	self.m_rankTxt:setText(arg_1_2)
	self.m_teamNameTxt:setText(arg_1_1.name)
	self.m_hasBgController:setSelectedIndex(arg_1_2 % 2)

	for iter_1_0 = 1, 3 do
		self["m_userComp" .. iter_1_0]:setVisible(false)
	end

	for iter_1_1, iter_1_2 in ipairs(arg_1_1.members or {}) do
		local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_1_2)

		if var_1_0 then
			self["m_userComp" .. iter_1_1]:updateUserIcon(var_1_0)
			self["m_userComp" .. iter_1_1]:setVisible(true)
		end
	end

	self.m_scoreTxt:setText(arg_1_1.score)
end

return TeamBattleRankCell
