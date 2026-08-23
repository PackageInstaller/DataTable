local var_0_0 = g.core.model.User.guildData
local var_0_1 = g.core.lang
local var_0_2 = g.core.const.ConstMgr.TeamBattleConst
local var_0_3 = g.core.model.User.teamBattleData
local TeamBattleInvitePlayerPop = class("TeamBattleInvitePlayerPop", require("app.fairyGUI.teamBattle.UI_TeamBattleInvitePlayerPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleInvitePlayerPop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleInvitePlayerPop:ctor()
	self:showAtCenter()

	self._teamData = var_0_3:getTeamUpData()
	self._tabType = var_0_2.INVITE_TAB.FRIEND

	self.m_memberList:setVirtual()
	self.m_memberList:setItemRenderer(handler(self, self._onListRender))
	self.m_memberList:doFairyBatching(false)
	self.m_oneKeyCallBtn:addClickListener(handler(self, self._onClickOneKeyCall))
	self.m_oneKeyInviteBtn:addClickListener(handler(self, self._onClickOneKeyInvite))
	self.m_tabTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
end

function TeamBattleInvitePlayerPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_SEND, self._onInvitePlayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO, self._updateList, self)

	if var_0_0:hasGuild() and not var_0_0:isResponse() then
		g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
	else
		self:_updateList()
	end
end

function TeamBattleInvitePlayerPop:_onChangeTabCtrl()
	self._tabType = self.m_tabTypeController:getSelectedIndex() + 1

	self:_updateList()
end

function TeamBattleInvitePlayerPop:_updateList()
	self.m_emptyTypeController:setSelectedIndex(0)

	self._listData = self._teamData:getInviteTeamData(self._tabType)

	if #self._listData > 0 then
		self.m_memberList:setNumItems(#self._listData)
	else
		self.m_emptyTypeController:setSelectedIndex(self._tabType)

		if self._tabType == var_0_2.INVITE_TAB.GUILD then
			local var_5_0 = g.core.model.User:getGuildId()

			if not var_5_0 or var_5_0 == 0 then
				self.m_emptyTypeController:setSelectedIndex(3)
			end
		end
	end
end

function TeamBattleInvitePlayerPop:_onListRender(arg_6_1, arg_6_2)
	arg_6_2:updateInviteCell(self._listData[arg_6_1 + 1])
end

function TeamBattleInvitePlayerPop:_onClickOneKeyCall()
	local var_7_0 = self._teamData:getMyTeam()

	if not var_7_0 then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	if var_7_0.ready then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	if #var_7_0.members >= var_0_2.TEAM_USER_COUNT then
		g.core.module.ModuleManager:tip(var_0_1:get(420502))

		return
	end

	local var_7_1 = fgui.UIPackage:createObject("teamBattle", "TeamBattleSendMsgComp")

	var_7_1:setTitle((string.gsub(string.gsub(g.core.config.chat_invite_info.get(45).content_1, "#name#", var_7_0.name or ""), "#num#", var_7_0.level_limit or 0)))

	local var_7_2 = require("app.view.base.infoPop.BaseChatCallPop").new({
		childComp = var_7_1,
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_BATTLE
	})

	var_7_2:showBtnNumber(2)
	g.core.module.ModuleManager:pushPopup(var_7_2)
end

function TeamBattleInvitePlayerPop:_onInvitePlayer(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(302044))
	self:_updateList()
end

return TeamBattleInvitePlayerPop
