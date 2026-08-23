local var_0_0 = g.core.const.ConstMgr.CrossServerArenaConst
local CrossServerArenaGuildRankCell = class("CrossServerArenaGuildRankCell", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaGuildRankCell"))

function CrossServerArenaGuildRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function CrossServerArenaGuildRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_isShowBgController:setSelectedIndex((arg_2_1 % 2 == 0 or nil) and (var_0_0.CTRL_SHOW_BG or var_0_0.CTRL_HIDE_BG))

	local var_2_0 = arg_2_1 + 1 <= var_0_0.TOP_3

	self.m_isTopThreeController:setSelectedIndex((arg_2_1 + 1 <= var_0_0.TOP_3 or nil) and (var_0_0.CTRL_TOP3 or var_0_0.CTRL_UN_TOP3))

	if var_2_0 then
		self.m_rankIndexComp:updateRankIndex({
			rank = arg_2_1 + 1
		})
	else
		self.m_rankText:setText(arg_2_1 + 1)
	end

	if not arg_2_2 then
		self.m_hasRankController:setSelectedIndex(0)

		return
	end

	self.m_hasRankController:setSelectedIndex(1)
	self.m_guildNameTxt:setText(arg_2_2.snapshot.name)

	local var_2_1 = g.core.platform.ServerListProxy:getServerBySid(arg_2_2.snapshot.sid)
	local var_2_2 = 411036
	local var_2_3 = {
		guild = arg_2_2.snapshot.name
	}

	if var_2_1 then
		var_2_3.server = var_2_1.name or g.core.lang:get(411015)
	end

	self.m_guildNameTxt:setText(g.core.lang:get(var_2_2, var_2_3))
	self.m_scoreTxt:setText(arg_2_2.score)
	self.m_efficiencyTxt:setText(g.core.lang:get(411034, {
		num = g.core.model.User.crossServerArenaData:getAdditionByRank(arg_2_1 + 1)
	}))
end

return CrossServerArenaGuildRankCell
