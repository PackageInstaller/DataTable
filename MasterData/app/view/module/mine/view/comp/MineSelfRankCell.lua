local MineSelfRankCell = class("MineSelfRankCell", require("app.fairyGUI.mine.UI_MineSelfRankCell"))

function MineSelfRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function MineSelfRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_bgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	local var_2_0 = arg_2_1.rankUnit

	self.m_rankController:setSelectedIndex(arg_2_1.rankUnit.rank > 3 and 3 or var_2_0.rank - 1)

	if var_2_0.rank > 3 then
		self.m_rankTxt:setText(var_2_0.rank)
	end

	self.m_scoreTxt:setText(var_2_0.score)

	local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_0.id)

	if var_2_1 then
		self.m_playerNameTxt:setText(var_2_1.name)
		self.m_levelTxt:setText(g.core.lang:get(120) .. var_2_1.level)

		if var_2_1.guild_id and var_2_1.guild_id ~= 0 then
			self.m_guildController:setSelectedIndex(1)
			self.m_guideName:setText(var_2_1.guild_name)
		else
			self.m_guildController:setSelectedIndex(0)
		end

		self.m_IconComp:updateAsUser(var_2_1)
		self.m_IconComp:setVisible(true)
	else
		self.m_playerNameTxt:setText("")
		self.m_levelTxt:setText("")
		self.m_guideName:setText("")
		self.m_guildController:setSelectedIndex(0)
		self.m_IconComp:setVisible(false)
	end
end

return MineSelfRankCell
