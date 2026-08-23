local var_0_0 = g.core.lang
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local var_0_2 = g.core.model.User.teamPvpData
local TeamPVPInvitePlayerPop = class("TeamPVPInvitePlayerPop", require("app.fairyGUI.teamPVP.UI_TeamPVPInvitePlayerPop"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPInvitePlayerPop",
		pkgPath = "ui/teamPVP/teamPVP",
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPInvitePlayerPop:ctor()
	self:showAtCenter()

	self._tabType = var_0_1.INVITE_TAB.FRIEND

	self.m_memberList:setVirtual()
	self.m_memberList:setItemRenderer(handler(self, self._onListRender))
	self.m_memberList:doFairyBatching(false)
	self.m_oneKeyCallBtn:addClickListener(handler(self, self._onClickOneKeyCall))
	self.m_oneKeyInviteBtn:addClickListener(handler(self, self._onClickOneKeyInvite))
	self.m_tabTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
end

function TeamPVPInvitePlayerPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_INVITEROBOT, self._onInviteRobot, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_INVITE, self._onInvitePlayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_INVITEELIST, self._onChangeTabCtrl, self)
	g.core.network.GameNetProxy:send_C2S_GroupBattle_InviteeList({})
end

function TeamPVPInvitePlayerPop:_onChangeTabCtrl()
	self._tabType = self.m_tabTypeController:getSelectedIndex() + 1

	self:_updateList()
end

function TeamPVPInvitePlayerPop:_updateList()
	self.m_emptyTypeController:setSelectedIndex(0)

	self._listData = var_0_2:getInviteTeamData(self._tabType)

	if #self._listData > 0 then
		self.m_memberList:setNumItems(#self._listData)
	else
		self.m_emptyTypeController:setSelectedIndex(self._tabType)

		if self._tabType == var_0_1.INVITE_TAB.GUILD then
			local var_5_0 = g.core.model.User:getGuildId()

			if not var_5_0 or var_5_0 == 0 then
				self.m_emptyTypeController:setSelectedIndex(3)
			end
		end
	end
end

function TeamPVPInvitePlayerPop:_onListRender(arg_6_1, arg_6_2)
	arg_6_2:updateInviteCell(self._listData[arg_6_1 + 1])
end

function TeamPVPInvitePlayerPop:_onClickOneKeyCall()
	local var_7_0 = var_0_2:getTeamInfo()

	if not var_7_0 then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	local var_7_1 = var_7_0.map_id or 0
	local var_7_2 = #var_7_0.users

	for iter_7_0, iter_7_1 in ipairs(var_7_0.users) do
		if iter_7_1.npc_type and iter_7_1.npc_type > 0 then
			var_7_2 = var_7_2 - 1
		end
	end

	if var_7_2 >= var_0_1.REQUIRED_PLAYER_NUM then
		g.core.module.ModuleManager:tip(var_0_0:get(420502))

		return
	end

	local var_7_3 = g.core.config.group_battle_map_info.fetch(var_7_1)

	if var_7_3 then
		local var_7_4 = var_7_3.name or ""

		if var_7_4 ~= "" then
			local var_7_5 = fgui.UIPackage:createObject("teamPVP", "TeamPVPSendMsgComp")

			var_7_5:setTitle((string.gsub(g.core.config.chat_invite_info.get(39).content_1, "#battle_name#", var_7_4)))
			g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseChatCallPop").new({
				childComp = var_7_5,
				funcId = g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_PVP
			}))
		end
	end
end

function TeamPVPInvitePlayerPop:_onClickOneKeyInvite()
	local var_8_0 = var_0_2:getTeamInfo()

	if not var_8_0 then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	local var_8_1 = #var_8_0.users

	for iter_8_0, iter_8_1 in ipairs(var_8_0.users) do
		if iter_8_1.npc_type and iter_8_1.npc_type > 0 then
			var_8_1 = var_8_1 - 1
		end
	end

	if var_8_1 >= var_0_1.REQUIRED_PLAYER_NUM then
		g.core.module.ModuleManager:tip(var_0_0:get(420502))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	g.core.network.GameNetProxy:send_C2S_GroupBattle_InviteRobot({})
end

function TeamPVPInvitePlayerPop:_onInviteRobot()
	g.core.module.ModuleManager:tip(g.core.lang:get(420501))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamPVPInvitePlayerPop:_onInvitePlayer()
	g.core.module.ModuleManager:tip(g.core.lang:get(302044))
	self:_updateList()
end

return TeamPVPInvitePlayerPop
