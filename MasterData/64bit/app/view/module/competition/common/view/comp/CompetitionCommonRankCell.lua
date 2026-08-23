local CompetitionCommonRankCell = class("CompetitionCommonRankCell", require("app.fairyGUI.competition.UI_CompetitionCommonRankCell"))

function CompetitionCommonRankCell:updateCell(arg_1_1)
	self.m_indexComp:updateRankIndex({
		rank = arg_1_1.rank
	})

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.id)

	if var_1_0 then
		self.m_userHeadComp:updateAsUser(var_1_0)
		self.m_userHeadComp:setVisible(true)
		self.m_userNameTxt:setText(var_1_0.name, nil, true)
		self.m_scoreTxt:setText(g.core.lang:get(409753, {
			score = arg_1_1.score
		}))
		self.m_isMySelfController:setSelectedIndex(var_1_0.id == g.core.model.User:getId() and 1 or 0)
	else
		self.m_userHeadComp:setVisible(false)
		self.m_userNameTxt:setText("")
		self.m_scoreTxt:setText("")
		self.m_isMySelfController:setSelectedIndex(0)
	end
end

return CompetitionCommonRankCell
