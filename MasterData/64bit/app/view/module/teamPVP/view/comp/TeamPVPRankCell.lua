local var_0_0 = g.core.model.User.teamPvpData
local TeamPVPRankCell = class("TeamPVPRankCell", require("app.fairyGUI.teamPVP.UI_TeamPVPRankCell"))

function TeamPVPRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function TeamPVPRankCell:updateRankCell(arg_2_1, arg_2_2)
	self.m_haveBgController:setSelectedIndex(arg_2_2 % 2 ~= 0 and 1 or 0)
	self.m_rankIndexComp:updateRankIndex({
		rank = arg_2_2
	})

	if not arg_2_1 then
		self.m_hasRankController:setSelectedIndex(1)

		return
	end

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if var_2_0 then
		self.m_headComp:updateAsUser(var_2_0)
		self.m_nameTxt:setText(var_2_0.name)
		self.m_levelTxt:setText(g.core.lang:get(120) .. var_2_0.level)
		self.m_serverName:setText(var_2_0.server_name)
		self.m_fightValueTxt:setText(arg_2_1.second)
		self.m_honorNum:setText(arg_2_1.score)

		local var_2_1 = var_0_0:getTitleInfoByBaseId((var_0_0:getTitleIdByHonor(arg_2_1.score)))

		if var_2_1 then
			self.m_rankLoader:setURL(g.core.common.Path:getTeamPVPBadge128(var_2_1.title_res))
		end

		self.m_hasRankController:setSelectedIndex(0)
	else
		self.m_hasRankController:setSelectedIndex(1)
	end
end

return TeamPVPRankCell
