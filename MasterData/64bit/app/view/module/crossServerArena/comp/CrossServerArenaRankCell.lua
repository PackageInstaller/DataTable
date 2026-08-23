local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_2 = g.core.model.User
local CrossServerArenaRankCell = class("CrossServerArenaRankCell", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaRankCell"))

function CrossServerArenaRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function CrossServerArenaRankCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_2 then
		return
	end

	local var_2_0 = arg_2_2.snapshot

	if arg_2_2.snapshot.id == var_0_2:getId() then
		var_2_0.avata_id = var_0_2:getAvataId()
	end

	self.m_isShowBgController:setSelectedIndex((arg_2_1 % 2 == 0 or nil) and (var_0_1.CTRL_SHOW_BG or var_0_1.CTRL_HIDE_BG))
	self.m_userHeadComp:updateAsUser(var_2_0)
	self.m_userHeadComp:setTouchable(false)
	self.m_nameText:setText((g.core.utils.String.transRobotName(var_2_0)))
	self.m_powerText:setText(var_2_0.fight_value)

	if type(var_2_0.guild_name) == "string" and #var_2_0.guild_name > 0 then
		self.m_guildText:setText(var_2_0.guild_name)
	else
		self.m_guildText:setText(g.core.lang:get(302508))
	end

	self.m_lvText:setText(g.core.lang:get(302516, {
		level = var_2_0.level
	}))

	local var_2_1 = arg_2_2.rank
	local var_2_2 = arg_2_2.rank <= var_0_1.TOP_3

	if arg_2_2.rank <= var_0_1.TOP_3 then
		self.m_rankIndexComp:updateRankIndex({
			rank = var_2_1
		})
	else
		self.m_rankText:setText(var_2_1)
	end

	self.m_isTopThreeController:setSelectedIndex((var_2_2 or nil) and (var_0_1.CTRL_TOP3 or var_0_1.CTRL_UN_TOP3))

	local var_2_3 = var_2_0.server_name or g.core.lang:get(411015)

	self.m_serverNameTxt:initRaceTextParams({
		direction = "right",
		moveType = "MOVE_BY",
		playMode = 1,
		pauseTime = 0.5,
		title = var_2_3
	})
	self.m_serverNameTxt:play()
	self.m_scoreTxt:setText(var_0_0:getRankScoreByRank(var_2_1))
end

return CrossServerArenaRankCell
