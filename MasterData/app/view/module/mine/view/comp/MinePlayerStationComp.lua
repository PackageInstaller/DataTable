local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.model.User.mineData
local var_0_2 = {
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO] = "ui://mine/pic_qsmy_dijiaoguo",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG] = "ui://mine/pic_qsmy_dilindong",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI] = "ui://mine/pic_qsmy_didongxi",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN] = "ui://mine/pic_qsmy_dilijin"
}
local MinePlayerStationComp = class("MinePlayerStationComp", require("app.fairyGUI.mine.UI_MinePlayerStationComp"))

function MinePlayerStationComp:ctor()
	self._knightComp = nil
	self._hasUser = false
	self._cityUser = nil
	self._isSelf = false
end

function MinePlayerStationComp:updatePlayer(arg_2_1)
	self._hasUser = false
	self._cityUser = nil
	self._isSelf = false

	local var_2_0 = arg_2_1.cityUser

	self.m_diLoader:setURL(var_0_2[tonumber(arg_2_1.struct:getCfg().camp)])
	self:clearAllEff()

	if var_2_0 then
		self.m_hasPlayerController:setSelectedIndex(1)

		local var_2_1 = var_2_0.user
		local var_2_2 = var_2_0.user.id == g.core.model.User:getId()

		self._isSelf = var_2_2

		self.m_ownController:setSelectedIndex(var_2_2 and 1 or 0)

		if var_2_2 then
			self.m_miningComp:addEffectSpine({
				isLoop = true,
				name = "eff_ui_mine_mining"
			})

			if var_0_1:isMeHasShield() then
				self:addShieldEff()
				self.m_timeStr:setText(var_0_1:getShieldLastTimeStr())
			end
		elseif self:checkShieldInTime(var_2_0.shield_end_time or 0) then
			self:addShieldEff()
		end

		self.m_hpProcessComp:setMax(g.core.config.mine_parameter_info.indexOf(1).max_hp)
		self.m_hpProcessComp:setValue(var_2_0.power)
		self.m_playerNameTxt:setText(var_2_1.name)
		self.m_guildNameTxt:setText(var_2_1.guild_name)

		local var_2_4, var_2_5 = g.core.lang:getFormatServerName(var_2_1.server_name)

		self.m_guildNameTxt:setText(var_2_1.guild_name .. var_2_5)

		if self._knightComp then
			self._knightComp:removeSelf()
		end

		local var_2_6 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(var_2_1)

		var_2_6.showMainRole = true
		self._knightComp = CommonKnight.new(var_2_6)

		self.m_playerHolder:addChild(self._knightComp)

		if var_2_2 or g.core.model.User.guildData:hasGuild() and var_2_0.user.guild_id == g.core.model.User.guildData:getGuildId() then
			self.m_isEnemyController:setSelectedIndex(0)
		else
			self.m_isEnemyController:setSelectedIndex(1)
		end
	end

	local var_2_7 = checkbool(var_2_0)

	self.m_hasPlayerController:setSelectedIndex(var_2_7 and 1 or 0)

	self._hasUser = var_2_7
	self._cityUser = var_2_0
end

function MinePlayerStationComp:onCD()
	if not self._hasUser then
		return
	end

	if self._isSelf then
		if var_0_1:isMeHasShield() then
			if not self._shieldEff then
				self:addShieldEff()
			end

			self.m_timeStr:setText(var_0_1:getShieldLastTimeStr())
		else
			self:clearShieldEff()
		end
	elseif self:checkShieldInTime(self._cityUser.shield_end_time or 0) then
		if not self._shieldEff then
			self:addShieldEff()
		end
	else
		self:clearShieldEff()
	end
end

function MinePlayerStationComp:checkShieldInTime(arg_4_1)
	return arg_4_1 >= g.core.common.ServerTime:getTime()
end

function MinePlayerStationComp:addShieldEff()
	self.m_hasShieldController:setSelectedIndex(1)

	if not self._shieldEff then
		self._shieldEff = self.m_miningComp:addEffectSpine({
			name = "eff_ui_mine_shield",
			scale = 0.8,
			isLoop = true
		})

		self.m_hasShieldController:setSelectedIndex(1)
	end
end

function MinePlayerStationComp:clearShieldEff()
	self.m_hasShieldController:setSelectedIndex(0)

	if self._shieldEff then
		self._shieldEff:removeSelf()

		self._shieldEff = nil

		self.m_hasShieldController:setSelectedIndex(0)
	end
end

function MinePlayerStationComp:clearAllEff()
	self:clearShieldEff()
	self.m_miningComp:removeAllEffect()
end

return MinePlayerStationComp
