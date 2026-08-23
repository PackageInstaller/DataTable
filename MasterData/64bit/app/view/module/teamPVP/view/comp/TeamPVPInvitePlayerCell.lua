local TeamPVPInvitePlayerCell = class("TeamPVPInvitePlayerCell", require("app.fairyGUI.teamPVP.UI_TeamPVPInvitePlayerCell"))

function TeamPVPInvitePlayerCell:ctor(arg_1_1)
	self.m_inviteBtn:addClickListener(handler(self, self._onClickInvite))
end

function TeamPVPInvitePlayerCell:updateInviteCell(arg_2_1)
	self._info = arg_2_1

	self.m_userIcon:updateAsUser(self._info)
	self.m_name:setText((self._info.robot_type and self._info.robot_type ~= 0 and self._info.robot_type ~= 999 or nil) and g.core.config.robot_info.get(self._info.base_id).name .. g.core.lang:get(302042), false, true)

	if self._info.guild_name and #self._info.guild_name > 0 then
		self.m_guildName:setText(self._info.guild_name)
	else
		self.m_guildName:setText(g.core.lang:get(302055))
	end

	self.m_fightValue:setText(self._info.fight_value)

	if arg_2_1.sid and g.core.platform.ServerListProxy:isOtherServerUser(arg_2_1.sid) then
		self.m_isCrossServerController:setSelectedIndex(1)
		self:_updateCrossServerView(arg_2_1.server_name or "")
	else
		self.m_isCrossServerController:setSelectedIndex(0)
	end

	local var_2_1 = g.core.model.User.teamPvpData:getFriendCd(self._info.id)

	self.leftTime = var_2_1

	self.m_inviteStateController:setSelectedIndex(0)

	if self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end

	if var_2_1 and var_2_1 > 0 then
		self.m_leftTime:setText(g.core.lang:get(302045, {
			time = var_2_1
		}))
		self.m_inviteStateController:setSelectedIndex(1)

		self._schedule = self:newSchedule(handler(self, self.updateMyCd), 1)
	end
end

function TeamPVPInvitePlayerCell:_updateCrossServerView(arg_3_1)
	self.m_serverNameTxt:initRaceTextParams({
		moveType = 1,
		pauseTime = 0.5,
		scrollDirection = 1,
		playMode = 2,
		duration = 3,
		title = arg_3_1 or ""
	})

	local var_3_0 = self.m_serverNameTxt:getContainerSize()
	local var_3_1 = self.m_serverNameTxt:getTextSize()

	self.m_serverNameTxt:setTitleAlign("left")

	if var_3_1.width > var_3_0.width then
		self.m_serverNameTxt:setMoveDistance(var_3_1.width - var_3_0.width)
		self.m_serverNameTxt:setStartPos(cc.p(var_3_1.width - var_3_0.width, self.m_serverNameTxt:getTextPosition().y))
	end

	self.m_serverNameTxt:play()
end

function TeamPVPInvitePlayerCell:updateMyCd()
	local var_4_0 = false

	if self.leftTime then
		if self.leftTime > 0 then
			self.leftTime = self.leftTime - 1

			self.m_leftTime:setText(g.core.lang:get(302045, {
				time = self.leftTime
			}))
		else
			var_4_0 = true
		end
	else
		var_4_0 = true
	end

	self.m_inviteStateController:setSelectedIndex(var_4_0 and 0 or 1)

	if var_4_0 and self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end
end

function TeamPVPInvitePlayerCell:onUnload()
	if self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end
end

function TeamPVPInvitePlayerCell:_onClickInvite()
	if self._info.robot_type and self._info.robot_type ~= 0 and self._info.robot_type ~= 999 then
		g.core.network.GameNetProxy:send_C2S_GroupBattle_InviteRobot({})
	else
		g.core.network.GameNetProxy:send_C2S_GroupBattle_Invite({
			user_id = self._info.id
		})
	end
end

return TeamPVPInvitePlayerCell
