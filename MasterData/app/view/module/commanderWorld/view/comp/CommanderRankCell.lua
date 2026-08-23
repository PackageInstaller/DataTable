local CommanderRankCell = class("CommanderRankCell", require("app.fairyGUI.commanderWorld.UI_CommanderRankCell"))

function CommanderRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function CommanderRankCell:updateRankCell(arg_2_1, arg_2_2, arg_2_3)
	self.m_rankIndexComp:updateRankIndex({
		rank = arg_2_3
	})
	self.m_haveBgController:setSelectedIndex(arg_2_3 % 2 ~= 0 and 1 or 0)

	if not arg_2_1.id then
		self:showNoDataUI()

		return
	end

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if var_2_0 then
		self.m_headComp:updateAsUser(var_2_0)
		self.m_nameTxt:setText(var_2_0.name)
		self.m_levelTxt:setText(g.core.lang:get(120) .. var_2_0.level)
		self.m_guildNameTxt:setText(var_2_0.guild_name and string.len(var_2_0.guild_name) > 0 and var_2_0.guild_name or g.core.lang:get(1012))
		self.m_scoreTxt:setText(arg_2_1.score)
		self.m_hasRankController:setSelectedIndex(0)
	else
		self:showNoDataUI()
	end
end

function CommanderRankCell:showNoDataUI()
	self.m_hasRankController:setSelectedIndex(1)
	self.m_guildNameTxt:setText(g.core.lang:get(1012))
	self.m_scoreTxt:setText(0)
end

return CommanderRankCell
