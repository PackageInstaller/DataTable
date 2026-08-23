local var_0_0 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")
local BioBaseTeamBeInvitedComp = class("BioBaseTeamBeInvitedComp", require("app.fairyGUI.base_new.UI_TeamPVPBeInvitedComp"))

function BioBaseTeamBeInvitedComp:ctor(arg_1_1)
	self._inviteData = nil

	self.m_agreeBtn:addClickListener(handler(self, self._onJoinClick))
	self.m_cancelBtn:addClickListener(handler(self, self._onRefuseClick))

	self._isOpen = true
	self._leftTime = 10
	self._teamId = 0
	self._inviteType = "bioTeam"
end

function BioBaseTeamBeInvitedComp:onLoad()
	self._scheduleHandler = g.core.common.Scheduler:newSchedule(handler(self, self._scheduleUpdate), 1)
end

function BioBaseTeamBeInvitedComp:onUnload()
	self._isOpen = false

	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end

	self._leftTime = 0
end

function BioBaseTeamBeInvitedComp:hide(arg_4_1)
	if not self._isOpen then
		return
	end

	if arg_4_1 and self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end

	if not arg_4_1 then
		if self.m_openTransition then
			self.m_openTransition:play()
		end
	elseif self._isOpen then
		self._isOpen = false

		if self.m_closeTransition then
			self.m_closeTransition:play(function()
				self:getParent():removeSelf()
			end)
		else
			self:getParent():removeSelf()
		end
	end
end

function BioBaseTeamBeInvitedComp:updateBioTeamInfo(arg_6_1, arg_6_2)
	self._inviteType = "bioTeam"
	self._leftTime = arg_6_2

	local var_6_0 = g.core.config.biography_team_info.fetch(arg_6_1.campaign_id)

	if var_6_0 == nil then
		return
	end

	self._inviteData = arg_6_1
	self._teamId = arg_6_1.team_id

	self:hide(false)
	self.m_chapternName:setText(var_6_0.name)
	self.m_level:setText("Lv." .. arg_6_1.inviter.level)
	self.m_userIocn:updateAsUser(arg_6_1.inviter)
	self.m_playerName:setText(arg_6_1.inviter.name or "", false, true)
	self.m_fightText:setText(var_6_0.fight_power)

	if arg_6_1.inviter.sid ~= g.core.platform.ServerListProxy:getSelectedServer().id then
		self:_updateCrossServerView(arg_6_1.inviter.server_name)
		self.m_serverNameTxt:setVisible(true)
	else
		self.m_serverNameTxt:setVisible(false)
	end
end

function BioBaseTeamBeInvitedComp:updateTeamPVPInfo(arg_7_1, arg_7_2)
	self._inviteType = "teamPVP"
	self._leftTime = arg_7_2

	local var_7_0 = g.core.model.User.teamPvpData:getMapInfo() or {}

	self._inviteData = arg_7_1
	self._teamId = arg_7_1.room_id

	self:hide(false)

	local var_7_1 = {}

	var_7_1.mapName = var_7_0.name or ""

	self.m_chapternName:setText(g.core.lang:get(420503, var_7_1))
	self.m_level:setText("Lv." .. arg_7_1.invite_user.level)
	self.m_userIocn:updateAsUser(arg_7_1.invite_user)
	self.m_playerName:setText(arg_7_1.invite_user.name, false, true)

	if arg_7_1.invite_user.sid ~= g.core.platform.ServerListProxy:getSelectedServer().id then
		self:_updateCrossServerView(arg_7_1.invite_user.server_name)
		self.m_serverNameTxt:setVisible(true)
	else
		self.m_serverNameTxt:setVisible(false)
	end
end

function BioBaseTeamBeInvitedComp:_updateCrossServerView(arg_8_1)
	self.m_serverNameTxt:initRaceTextParams({
		scrollDirection = 1,
		moveType = 1,
		playMode = 2,
		pauseTime = 0.5,
		duration = 3,
		title = arg_8_1 or ""
	})

	local var_8_0 = self.m_serverNameTxt:getContainerSize()
	local var_8_1 = self.m_serverNameTxt:getTextSize()

	self.m_serverNameTxt:setTitleAlign("left")

	if var_8_1.width > var_8_0.width then
		self.m_serverNameTxt:setMoveDistance(var_8_1.width - var_8_0.width)
		self.m_serverNameTxt:setStartPos(cc.p(0, self.m_serverNameTxt:getTextPosition().y))
	end

	self.m_serverNameTxt:play()
end

function BioBaseTeamBeInvitedComp:_onJoinClick()
	if var_0_0 and not var_0_0:checkIsCanShow() then
		return
	end

	self:hide(true)

	if self._inviteType == "bioTeam" then
		g.core.network.GameNetProxy:send_C2S_Biography_ConfirmInvite({
			join = true,
			team_id = self._teamId,
			campaign_id = self._inviteData.campaign_id
		})
	elseif self._inviteType == "teamPVP" then
		g.core.network.GameNetProxy:send_C2S_GroupBattle_ConfirmInvite({
			is_join = true,
			room_id = self._teamId
		})
	end
end

function BioBaseTeamBeInvitedComp:_onRefuseClick()
	if var_0_0 and not var_0_0:checkIsCanShow() then
		return
	end

	self:hide(true)

	if self._inviteType == "bioTeam" then
		g.core.network.GameNetProxy:send_C2S_Biography_ConfirmInvite({
			join = false,
			team_id = self._teamId,
			campaign_id = self._inviteData.campaign_id
		})
	elseif self._inviteType == "teamPVP" then
		g.core.network.GameNetProxy:send_C2S_GroupBattle_ConfirmInvite({
			is_join = false,
			room_id = self._teamId
		})
	end
end

function BioBaseTeamBeInvitedComp:_scheduleUpdate()
	if self._scheduleHandler and self._leftTime > 0 then
		self._leftTime = self._leftTime - 1

		if self._inviteData and self._leftTime <= 0 then
			self:hide(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIOGRAPHY_NOTIFYINVITEE_REMOVE, false, {
				teamId = self._teamId
			})
		end
	end
end

function BioBaseTeamBeInvitedComp:getOpen()
	return self._isOpen
end

return BioBaseTeamBeInvitedComp
