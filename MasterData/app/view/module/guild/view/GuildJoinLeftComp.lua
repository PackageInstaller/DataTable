local var_0_0 = g.core.const.ConstMgr.GuildCommonConst
local var_0_1 = g.core.model.User.guildData
local AllianceInfoPop = require("app.view.module.alliance.view.pop.AllianceInfoPop")
local GuildJoinLeftComp = class("GuildJoinLeftComp", require("app.fairyGUI.guild.UI_GuildJoinLeftComp"))

function GuildJoinLeftComp:ctor(arg_1_1)
	self.m_copyTouchComp:addClickListener(handler(self, self._onCopy))
	self.m_chatBtn:addClickListener(handler(self, self._goToChat))
	self.m_applyBtn:addClickListener(handler(self, self._applyJoinGuild))
	self.m_lookAllianceBtn:addClickListener(handler(self, self._onLookAlliance))

	self._isFullMember = false
	self._isLevelLimit = false
end

function GuildJoinLeftComp:_onLookAlliance()
	if self._guildData.alliance_id and self._guildData.alliance_id ~= 0 then
		g.core.module.ModuleManager:pushPopup(AllianceInfoPop.new({
			allianceId = self._guildData.alliance_id
		}), {
			touchDisappear = true
		})
	end
end

function GuildJoinLeftComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO, handler(self, self._onGetOtherGuildInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REQJOIN, handler(self, self._onRcvJoinGuild), self)
end

function GuildJoinLeftComp:_onGetOtherGuildInfo(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4 then
		self._guildData = arg_4_4.guild
		self._memberData = arg_4_4.members
		self._guildId = arg_4_4.guild_id
	end
end

function GuildJoinLeftComp:updateView(arg_5_1)
	var_0_1:updateGuildApplyState({
		self._guildData
	})
	self.m_guildIcon:updateInfo({
		style = 2,
		data = self._guildData
	})
	self.m_idTxt:disableAutoChange()
	self.m_idTxt:setText("ID:" .. tostring(self._guildData.show_id or self._guildData.id))
	self.m_nameTxt:setText(self._guildData.name)
	self.m_leaderNameTxt:setText(self._guildData.leader_name)
	self.m_levelTxt:setText("Lv." .. self._guildData.level)

	self._baseData = var_0_1:getCfg(self._guildData.level)

	self.m_memberSizeTxt:setText(#self._memberData .. "/" .. self._baseData.number)

	self._isFullMember = #self._memberData == self._baseData.number

	self.m_fightValueTxt:setText(self._guildData.fight_value)

	local var_5_0 = self._guildData.apply_level
	local var_5_1 = g.core.model.User:getLevel()

	self.m_limitLevelTxt:setText(g.core.lang:get(109515, {
		level = self._guildData.apply_level
	}))

	self._isLevelLimit = var_5_1 < var_5_0
	self._isNeedConfirm = false

	if self._guildData.confirm then
		self.m_auditTxt:setText(g.core.lang:get(109504))

		self._isNeedConfirm = true
	else
		self.m_auditTxt:setText(g.core.lang:get(109505))
	end

	self.m_declarationTxt:setText(self._guildData.declaration)

	local var_5_2 = ""
	local var_5_3

	self.m_isShowApplyController:setSelectedIndex(arg_5_1.isShowApplyBtn and 1 or 0)

	if arg_5_1.isShowApplyBtn then
		if self._guildData.isApply then
			var_5_3 = var_0_0.applyState.CANCEL_APPLY
			var_5_2 = g.core.lang:get(109506)
		elseif not self._guildData.confirm then
			var_5_3 = var_0_0.applyState.DIRECT_JOIN
			var_5_2 = g.core.lang:get(109508)
		elseif self._guildData.confirm then
			var_5_3 = var_0_0.applyState.NEED_CONFIRM
			var_5_2 = g.core.lang:get(109508)
		end

		self.m_applyBtn:setTitle(var_5_2)
	end

	self._applySate = var_5_3

	if self._guildData.alliance_id and self._guildData.alliance_id ~= 0 then
		self.m_hasAllianceController:setSelectedIndex(1)
		self.m_allianceName:setText(self._guildData.alliance_name)
	else
		self.m_hasAllianceController:setSelectedIndex(0)
		self.m_allianceName:setText(g.core.lang:get(109642))
	end
end

function GuildJoinLeftComp:_applyJoinGuild()
	if self._isFullMember then
		g.core.module.ModuleManager:tip(g.core.lang:get(109509))

		return
	end

	if self._isLevelLimit then
		g.core.module.ModuleManager:tip(g.core.lang:get(109510))

		return
	end

	if self._applySate == var_0_0.applyState.NEED_CONFIRM or self._applySate == var_0_0.applyState.DIRECT_JOIN then
		local var_6_0 = g.core.model.User:getUserData().join_guild_limit or 0

		if not math.uint64_lt(var_6_0, g.core.common.ServerTime:getTime(), true) then
			g.core.module.ModuleManager:tip(g.core.lang:get(109512, {
				time = g.core.common.ServerTime:getLeftDHMSFormat(var_6_0)
			}))
		else
			if self._applySate == var_0_0.applyState.NEED_CONFIRM then
				self._applySate = var_0_0.applyState.CANCEL_APPLY

				g.core.module.ModuleManager:tip(g.core.lang:get(109511))
				self.m_applyBtn:setTitle(g.core.lang:get(109506))
			end

			g.core.network.GameNetProxy:send_C2S_Guild_ReqJoin({
				guild_id = self._guildId
			})
		end

		return
	elseif self._applySate == var_0_0.applyState.CANCEL_APPLY then
		self._applySate = var_0_0.applyState.NEED_CONFIRM

		self.m_applyBtn:setTitle(g.core.lang:get(109508))
		g.core.network.GameNetProxy:send_C2S_Guild_DeleteApply({
			guild_id = self._guildId
		})

		return
	end
end

function GuildJoinLeftComp:_onRcvJoinGuild(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.join then
		g.core.module.ModuleManager:tip(g.core.lang:get(109513, {
			name = arg_7_4.guild_name
		}))
		g.core.module.ModuleManager:popModule()
		g.core.module.ModuleManager:replaceModule(g.view.entrance.GUILD_MAIN)
	end
end

function GuildJoinLeftComp:_onCopy()
	g.core.module.ModuleManager:tip(g.core.lang:get(109551))
	g.core.platform.PlatformProxy:copyToClipboard(tostring(self._guildId))
end

function GuildJoinLeftComp:_goToChat()
	if g.core.model.User.chatData:isInBlackList(self._guildData.leader_id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109617))

		return
	end

	if g.core.model.User:getId() == self._guildData.leader_id then
		g.core.module.ModuleManager:tip(g.core.lang:get(109618))

		return
	end

	local var_9_0 = {
		id = self._guildData.leader_id,
		name = self._guildData.leader_name,
		base_id = self._guildData.leader_base_id
	}

	g.core.model.User.chatData:setPrivateChatPInfo(var_9_0)
	g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.CHAT, {
		type = g.core.const.ConstMgr.ChatConst.SINGLE,
		user = var_9_0
	})
end

return GuildJoinLeftComp
