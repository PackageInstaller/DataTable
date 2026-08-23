local var_0_0 = g.core.model.User.blazingArenaData
local BlazingArenaRankCell = class("BlazingArenaRankCell", require("app.fairyGUI.blazingArena.UI_BlazingArenaRankCell"))

function BlazingArenaRankCell:ctor()
	self._rankId = 0

	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function BlazingArenaRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_isShowBgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	if not arg_2_1 or self._rankId == arg_2_1.id then
		return
	end

	local var_2_0 = arg_2_1.rank
	local var_2_1 = arg_2_1.rank <= 3

	if arg_2_1.rank <= 3 then
		self.m_rankIndexComp:updateRankIndex({
			rank = var_2_0
		})
	else
		self.m_rankText:setText(var_2_0)
	end

	self.m_isTopThreeController:setSelectedIndex(var_2_1 and 1 or 0)

	if arg_2_1.isRobot then
		self:updateAsRobot(arg_2_1)
	else
		self:updateAsPlayer(arg_2_1)
	end
end

function BlazingArenaRankCell:updateAsRobot(arg_3_1)
	local var_3_0 = arg_3_1

	if arg_3_1.isRobot and arg_3_1.fightValue == 0 then
		var_3_0 = var_0_0:combineAndGetNetRobotInfo(arg_3_1)
	end

	self.m_userHeadComp:updateAsUser({
		base_id = var_3_0.knightPic
	})
	self.m_userHeadComp:setVisible(true)
	self.m_userHeadComp:setTouchable(false)
	self.m_nameText:setText(var_3_0.name)
	self.m_lvText:setText(g.core.lang:get(302516, {
		level = var_3_0.userLv
	}))
	self.m_powerText:setText(var_3_0.fightValue)
	self.m_guildText:setText(g.core.lang:get(302508))

	self._rankId = arg_3_1.id
end

function BlazingArenaRankCell:updateAsPlayer(arg_4_1)
	local var_4_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_4_1.id)

	if var_4_0 then
		if var_4_0.id == g.core.model.User:getId() then
			var_4_0.avata_id = g.core.model.User:getAvataId()
		end

		self.m_userHeadComp:updateAsUser(var_4_0)
		self.m_userHeadComp:setVisible(true)
		self.m_userHeadComp:setTouchable(false)
		self.m_nameText:setText((g.core.utils.String.transRobotName(var_4_0)))
		self.m_lvText:setText(g.core.lang:get(302516, {
			level = var_4_0.level
		}))
		self.m_powerText:setText(var_4_0.fight_value)

		if type(var_4_0.guild_name) == "string" and #var_4_0.guild_name > 0 then
			self.m_guildText:setText(var_4_0.guild_name)
		else
			self.m_guildText:setText(g.core.lang:get(302508))
		end

		self._rankId = arg_4_1.id
	else
		self.m_userHeadComp:setVisible(false)
		self.m_nameText:setText("")
		self.m_lvText:setText("")
		self.m_powerText:setText("")
		self.m_guildText:setText(g.core.lang:get(302508))

		self._rankId = 0
	end
end

return BlazingArenaRankCell
