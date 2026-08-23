local GveInstituteRankCell = class("GveInstituteRankCell", require("app.fairyGUI.gve.UI_GveInstituteRankCell"))

function GveInstituteRankCell:updateRank(arg_1_1, arg_1_2)
	if arg_1_2 > 3 then
		self.m_indexController:setSelectedIndex(3)
		self.m_rankTxt:setText(arg_1_2)
	else
		self.m_indexController:setSelectedIndex(arg_1_2 - 1)
	end

	self.m_numberController:setSelectedIndex(arg_1_2 % 2 == 0 and 0 or 1)
	self.m_scoreTxt:setText(arg_1_1.research)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.user_id)

	if not var_1_0 then
		return
	end

	self.m_playerIcon:updateAsUser(var_1_0)
	self.m_playerNameTxt:setText(var_1_0.name)
	self.m_svrNameTxt:setText(var_1_0.server_name)
end

return GveInstituteRankCell
