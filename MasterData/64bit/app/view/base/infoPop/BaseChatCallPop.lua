local var_0_0 = g.core.const.ConstMgr.FormationConst
local var_0_1 = g.core.const.ConstMgr.ShareConst
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.const.ConstMgr.ChatConst
local BaseChatCallPop = class("BaseChatCallPop", require("app.fairyGUI.infoPop.UI_BaseChatCallPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/infoPop/infoPop",
		resName = "BaseChatCallPop",
		pkgName = "infoPop"
	})
end)

function BaseChatCallPop:ctor(arg_2_1)
	self._param = arg_2_1
	self._functionId = arg_2_1.funcId
	self._btnSel = arg_2_1.btnSel or 0

	self:showAtCenter()
	self.m_guildBtn:addClickListener(handler(self, self._guildClick))
	self.m_worldBtn:addClickListener(handler(self, self._onWorldClick))

	self._childComp = nil

	if arg_2_1.title then
		self.m_popPanel:getChild("leftTitle"):setText(arg_2_1.title)
	end

	if arg_2_1.desc then
		self.m_descText:setText(arg_2_1.desc)
	elseif arg_2_1.childComp then
		self._childComp = arg_2_1.childComp

		self.m_placeHolderComp:addChild(arg_2_1.childComp)
	end

	if self:_getInviteInfo(var_0_3.AREA) and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) then
		self.m_worldBtn:setText(g.core.lang:get(109056))
	end

	if self._functionId == g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG then
		self.m_worldBtn:setText(g.core.lang:get(429023))
		self.m_guildBtn:setText(g.core.lang:get(429024))
	elseif self._functionId == g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS then
		self.m_worldBtn:setText(g.core.lang:get(109056))
		self.m_guildBtn:setText(g.core.lang:get(433399))
	end
end

function BaseChatCallPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHAT, self._recvBroadcast, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BULLET_SCREEN_SEND, self._recvBroadcast, self)
	self:showBtnNumber(self._btnSel)
end

function BaseChatCallPop:onUnload()
	fgui.UIPackage:removePackage("ui/share/share")
end

function BaseChatCallPop:_getInviteInfo(arg_5_1)
	for iter_5_0, iter_5_1 in g.core.config.chat_invite_info.ipairs() do
		if iter_5_1.function_id == self._functionId and iter_5_1.channel == arg_5_1 then
			return iter_5_1
		end
	end
end

function BaseChatCallPop:_guildClick()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CHAT) then
		return
	end

	if self._functionId == g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG then
		self:_sendChat(var_0_3.NEW_SLG)
	elseif self._functionId == g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS then
		self:_sendChat(var_0_3.ANCIENTS)
	elseif g.core.model.User.guildData:hasGuild() then
		self:_sendChat(var_0_3.ARMY)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(109051))
	end

	self:_onClose()
end

function BaseChatCallPop:_onWorldClick()
	if self._functionId == var_0_2.TEAM_BATTLE then
		self:_sendChat(var_0_3.TEAM_BATTLE_ZONE)

		return
	end

	if self._functionId == var_0_2.ALLIANCE then
		if self._childComp then
			for iter_7_0, iter_7_1 in ipairs((self._childComp:getSendChannel())) do
				if iter_7_1 == var_0_3.AREA then
					if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) then
						self:_sendChat(iter_7_1)
					end
				else
					self:_sendChat(iter_7_1)
				end
			end
		end

		return
	end

	if self._functionId == g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG then
		self:_sendChat(var_0_3.ALLIANCE)
		self:_onClose()

		return
	end

	if self._functionId == g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS then
		self:_sendChat(var_0_3.AREA)
		self:_onClose()

		return
	end

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_2.CHAT_WORLD) then
		return
	end

	if self:_getInviteInfo(var_0_3.AREA) and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) then
		self:_sendChat(var_0_3.AREA)
	else
		self:_sendChat(var_0_3.WORLD)
	end

	self:_onClose()
end

function BaseChatCallPop:_sendChat(arg_8_1)
	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_3

	if self._functionId == var_0_2.BIO_MAIN then
		if not self:_teamIsExist() then
			return
		end

		local var_8_4 = g.core.model.User.bioData:getTeamInfo()

		var_8_0 = var_8_4.id

		local var_8_5, var_8_6

		if not var_8_4.campaign_id then
			::label_8_0::

			var_8_1 = 0
			var_8_5 = {
				share_type = 3
			}
			var_8_6 = {}
		end

		var_8_6.own_name = var_8_1 > 0 and g.core.config.biography_team_info.get(var_8_1).name or ""
		var_8_5.battle_res_share_title = var_8_6
		var_8_3 = var_8_5
	elseif self._functionId == var_0_2.RECRUIT_ADVANCE then
		local var_8_7 = {}

		for iter_8_0 = 1, #self._param.awards do
			table.insert(var_8_7, {
				type = self._param.awards[iter_8_0].type,
				value = self._param.awards[iter_8_0].value,
				size = self._param.awards[iter_8_0].size
			})
		end

		var_8_3 = {
			share_type = 5,
			recruit_awards = var_8_7
		}
	elseif self._functionId == var_0_2.HOME_LAND_FURNITURE then
		var_8_3 = {
			share_type = 6,
			id = g.core.model.User:getId()
		}
	elseif self._functionId == var_0_2.RECRUIT_ARTIFACT_BASE then
		local var_8_8 = {}

		for iter_8_1 = 1, #self._param.awards do
			table.insert(var_8_8, {
				type = self._param.awards[iter_8_1].type,
				value = self._param.awards[iter_8_1].value,
				size = self._param.awards[iter_8_1].size
			})
		end

		var_8_3 = {
			share_type = 7,
			recruit_awards = var_8_8
		}
	elseif self._functionId == var_0_2.KNIGHT_LINE_UP_6 then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_8,
			id = g.core.model.User:getId(),
			preset_formation_info = self._param.preset_formation_info
		}

		if self._param.preset_formation_info and self._param.preset_formation_info ~= "" then
			var_8_1 = var_0_0.SHARE_IS_PRESET
		end
	elseif self._functionId == var_0_2.GUILD then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_13,
			id = g.core.model.User:getId()
		}
		var_8_0 = g.core.model.User:getGuildId()
	elseif self._functionId == var_0_2.RECRUIT_UNITE_TOKEN_LIMIT then
		local var_8_9 = {}

		for iter_8_2 = 1, #self._param.awards do
			table.insert(var_8_9, {
				type = self._param.awards[iter_8_2].type,
				value = self._param.awards[iter_8_2].value,
				size = self._param.awards[iter_8_2].size
			})
		end

		var_8_1 = 0

		for iter_8_3 = 1, #self._param.param1 do
			if self._param.param1[iter_8_3] and self._param.param1[iter_8_3].isNew then
				var_8_1 = var_8_1 + math.pow(10, iter_8_3 - 1)
			end
		end

		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_10,
			recruit_awards = var_8_9,
			id = self._param.recruitType
		}
	elseif self._functionId == var_0_2.EASTEREGG_LAYER then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_14,
			id = g.core.model.User:getId()
		}
		var_8_1 = self._param.interactionId
		var_8_0 = self._param.eggId
	elseif self._functionId == var_0_2.PUZZLE_GAME then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_12,
			id = g.core.model.User:getId()
		}
		var_8_1 = self._param.level
		var_8_0 = self._param.missionId
	elseif self._functionId == var_0_2.TOUCH_GAME then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_11,
			id = g.core.model.User:getId()
		}
		var_8_1 = self._param.missionId
		var_8_0 = self._param.gameId
	elseif self._functionId == var_0_2.RECRUIT_PET_BASE then
		local var_8_10 = {}

		for iter_8_4 = 1, #self._param.awards do
			table.insert(var_8_10, {
				type = self._param.awards[iter_8_4].type,
				value = self._param.awards[iter_8_4].value,
				size = self._param.awards[iter_8_4].size
			})
		end

		var_8_3 = {
			share_type = 7,
			recruit_awards = var_8_10
		}
	elseif self._functionId == var_0_2.TEAM_PVP then
		if not self:_teamPvpIsExist() then
			return
		end

		local var_8_11 = g.core.model.User.teamPvpData:getTeamInfo()

		var_8_0 = var_8_11.id
		var_8_1 = var_8_11.map_id or 0
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_20
		}
	elseif self._functionId == var_0_2.TEAM_BATTLE then
		local var_8_12 = g.core.model.User.teamBattleData:getTeamUpData():getMyTeam()

		if not var_8_12 then
			g.core.module.ModuleManager:tip(g.core.lang:get(302027))

			return
		end

		var_8_1 = var_8_12.id .. ";" .. var_8_12.level_limit .. ";" .. var_8_12.name
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_22
		}
	elseif self._functionId == var_0_2.ALLIANCE then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_23
		}
		var_8_0 = self._param.allianceId
	elseif self._functionId == var_0_2.NEW_SLG then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_24
		}
		var_8_1 = self._param.team.boss_id .. ";" .. self._param.team.team_id .. ";" .. self._param.team.create_time
	elseif self._functionId == var_0_2.ANCIENTS then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_26
		}
		var_8_1 = self._param.teamId
	elseif self._functionId == var_0_2.ANNIVERSARY then
		var_8_3 = {
			share_type = var_0_1.SHARE_TYPE.TYPE_ID_25
		}
		var_8_0 = self._param.allianceId
	end

	local var_8_13 = self:_getInviteInfo(arg_8_1)
	local var_8_14 = arg_8_1

	if arg_8_1 == var_0_3.AREA or var_8_14 == var_0_3.TEAM_BATTLE_ZONE or var_8_14 == var_0_3.NEW_SLG or var_8_14 == var_0_3.ANCIENTS or var_8_14 == var_0_3.ALLIANCE then
		var_8_14 = var_0_3.CrossType[var_8_14]

		g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
			look = 0,
			content = "",
			type = var_8_14,
			param1 = tostring(var_8_1),
			share = var_8_3,
			invite_id = var_8_13.id,
			unique_id = var_8_0
		})

		return
	end

	g.core.network.GameNetProxy:send_C2S_Chat({
		content = "",
		channel = var_8_14,
		name = g.core.model.User:getName(),
		invite_id = var_8_13.id,
		unique_id = var_8_0,
		param1 = tostring(var_8_1),
		share = var_8_3
	})
	g.core.model.User.chatData:setLastSendConnectTime(arg_8_1)
end

function BaseChatCallPop:_onClose()
	if self._inClose then
		return
	end

	self._inClose = true

	if self._functionId == var_0_2.GUILD or self._functionId == var_0_2.PUZZLE_GAME then
		if not self.hasEntered then
			g.core.module.ModuleManager:popComponent()

			self.hasEntered = true
		end
	else
		g.core.module.ModuleManager:checkAndPlayPopExitAnim()
	end
end

function BaseChatCallPop:_recvBroadcast()
	g.core.module.ModuleManager:tip(g.core.lang:get(109052))
	self:_onClose()
end

function BaseChatCallPop:_teamIsExist()
	local var_11_0 = g.core.model.User.bioData:getTeamInfo()

	if not var_11_0 or var_11_0.id == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(302027))
		self:_onClose()

		return false
	end

	return true
end

function BaseChatCallPop:_teamPvpIsExist()
	local var_12_0 = g.core.model.User.teamPvpData:getTeamInfo()

	if not var_12_0 or var_12_0.id == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(302027))
		self:_onClose()

		return false
	end

	return true
end

function BaseChatCallPop:showBtnNumber(arg_13_1)
	if arg_13_1 == 1 or arg_13_1 == 2 then
		self.m_btnNumberController:setSelectedIndex(arg_13_1 - 1)
	end
end

return BaseChatCallPop
