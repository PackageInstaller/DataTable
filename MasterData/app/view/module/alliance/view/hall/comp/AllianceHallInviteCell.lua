local var_0_0 = g.core.common.Path
local var_0_2 = g.core.model.User.allianceData
local var_0_4 = g.core.model.User.snapShotCacheData
local var_0_5 = g.core.const.ConstMgr.SnapShotCacheConst
local AllianceHallInviteCell = class("AllianceHallInviteCell", require("app.fairyGUI.alliance.UI_AllianceHallInviteCell"))

function AllianceHallInviteCell:ctor()
	self._inviteGuildId = 0
	self._guildSnapShot = nil
	self._allianceInvite = nil
	self._isInvite = false

	self.m_inviteBtn:addClickListener(handler(self, self._onClickInviteBtn))
end

function AllianceHallInviteCell:updateInviteCell(arg_2_1)
	self._inviteGuildId = arg_2_1

	local var_2_0 = var_0_4:getSnapShot(var_0_5.SNAP_SHOT_KEY.GUILD, arg_2_1)

	if var_2_0 then
		self._guildSnapShot = var_2_0

		self.m_guildPic:setURL(var_0_0:getGuildMidIconById(var_2_0.icon))
		self.m_guildName:setText(var_2_0.name or "")
		self.m_memberNum:setText(var_2_0.member_num or 0)
		self.m_powerTxt:setText(var_2_0.fight_value or 0)
		self.m_serverName:setText(var_0_2:getGuildServerName(var_2_0))

		local var_2_1 = {}

		var_2_1.level = var_2_0.level or 0

		self.m_level:setText(g.core.lang:get(2052, var_2_1))
	end

	self._allianceInvite = var_0_2:getAllianceInviteByGuildId(arg_2_1)
	self._isInvite = checkbool(self._allianceInvite)

	self.m_isInviteController:setSelectedIndex(self._isInvite and 1 or 0)
end

function AllianceHallInviteCell:_onClickInviteBtn()
	if not self._guildSnapShot then
		return
	end

	if not self._isInvite then
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_Invite({
			guild_id = self._guildSnapShot.id
		})
	else
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_CancelInvite({
			guild_id = self._guildSnapShot.id
		})
	end
end

return AllianceHallInviteCell
