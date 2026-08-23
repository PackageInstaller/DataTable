local var_0_0 = g.core.model.User.snapShotCacheData
local NewSlgBossInvitePop = class("NewSlgBossInvitePop", function()
	return fgui.GComponent:create({
		resName = "NewSlgBossInvitePop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgBossInvitePop:ctor(arg_2_1)
	self:showAtCenter()

	self._bossTeam = arg_2_1.bossTeam
	self._btnCall = self:getChild("Btn_call")

	self._btnCall:addClickListener(handler(self, self._onClickBtnCall))

	self._comEmpty = self:getChild("Com_empty")
	self._listPlayer = self:getChild("List_player")

	self._listPlayer:setVirtual(self)
	self._listPlayer:setItemRenderer(handler(self, self._onRenderListPlayerCell))

	self._tabCtrl = self:getController("tab")

	self._tabCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTabChange))

	self._isEmptyCtrl = self:getController("is_empty")
	self._tabIndex = 0
	self._userArr = {}
	self._allianceUserArr = {}
	self._friendArr = {}
	self._msgMax = 0
	self._guildArr = {}
	self._invitedArr = {}
end

function NewSlgBossInvitePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SNAPSHOT_ONLINEUSERS, handler(self, self._onAllianceMemberList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TIPS_SET, handler(self, self._onMailSend), self)
	self:_sendMsg()
end

function NewSlgBossInvitePop:_onMailSend(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(429019))

	self._invitedArr[arg_4_4.target_id] = true

	self:_onAllianceMemberList()
end

function NewSlgBossInvitePop:_onAllianceMemberList()
	self._allianceUserArr = var_0_0:getSnapShotsByGroup(1)

	self:_dealUserArr()
	self:_updateList()
end

function NewSlgBossInvitePop:_sendMsg()
	if not var_0_0:checkSendGroup(1) then
		self:_onAllianceMemberList()
	end
end

function NewSlgBossInvitePop:_dealUserArr()
	self._userArr = {}

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(self._bossTeam.users or {}) do
		var_7_0[iter_7_1.user_id] = true
	end

	for iter_7_2, iter_7_3 in ipairs(self._allianceUserArr) do
		if not var_7_0[iter_7_3.id] then
			table.insert(self._userArr, iter_7_3)
		end
	end
end

function NewSlgBossInvitePop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "NewSlgBossInviteCell_onClickBtnInvite" then
		if self._invitedArr[arg_8_2.user.id] then
			g.core.module.ModuleManager:tip(g.core.lang:get(429026))

			return
		end

		g.core.network.GameNetProxy:send_C2S_Tips_Set({
			id = 2,
			expire_time = self._bossTeam.create_time + g.core.model.User.newSlgData:getBossTeamGatherTotalTime(),
			params = self._bossTeam.boss_id .. ":" .. self._bossTeam.team_id .. ":" .. self._bossTeam.create_time .. ":" .. g.core.model.User:getId(),
			target_id = arg_8_2.user.id
		})
	end
end

function NewSlgBossInvitePop:_updateList()
	self._isEmptyCtrl:setSelectedIndex(#self._userArr == 0 and 1 or 0)
	self._listPlayer:setNumItems(#self._userArr)
end

function NewSlgBossInvitePop:_onClickBtnCall()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.BaseChatCallPop").new({
		desc = g.core.lang:get(429020),
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG,
		team = self._bossTeam
	})))
end

function NewSlgBossInvitePop:_onRenderListPlayerCell(arg_11_1, arg_11_2)
	arg_11_2:updateCell(self._userArr[arg_11_1 + 1], self._invitedArr[self._userArr[arg_11_1 + 1].id])
end

return NewSlgBossInvitePop
