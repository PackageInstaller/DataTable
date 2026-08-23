local var_0_1 = {
	433338,
	433339,
	433340
}
local AncientsCoopTeamInvitePop = class("AncientsCoopTeamInvitePop", require("app.fairyGUI.ancients.UI_AncientsCoopTeamInvitePop"), function()
	return fgui.GComponent:create({
		resName = "AncientsCoopTeamInvitePop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)

function var_0_2:ctor()
	self:getView():center(true)
	self.m_Btn_search:addClickListener(handler(self, self._onClickBtnSearch))
	self.m_List_team:setVirtual(self)
	self.m_List_team:setItemRenderer(handler(self, self._onRenderListTeamCell))
	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_ComPopPanel:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.ANCIENTS_COOP_INVITE)
	self.m_is_finalController:setSelectedIndex(g.core.model.User.ancientsData:isFinalState() and 1 or 0)

	self._inviteTeamArr = {}
	self._applyTeamArr = {}
	self._searchTeamArr = {}
	self._showTeamArr = {}

	g.core.model.User.ancientsData:resetFinalInvite()
end

function var_0_2:onLoad()
	g.core.network.GameNetProxy:send_C2S_Ancient_GetInvitationList({})
	g.core.network.GameNetProxy:send_C2S_Ancient_GetApplyRecord({})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETAPPLYRECORD, handler(self, self._onRevGetApplyRecord), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETINVITATIONLIST, handler(self, self._onRevGetInviteList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_SEARCH, handler(self, self._onRevGetSearchList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_REQJOIN, handler(self, self._onUpdateApplyRecord), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DELETEAPPLY, handler(self, self._onUpdateApplyRecord), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_CONFIRMINVITE, handler(self, self._onUpdateInvitationList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateTeam), self)
end

function var_0_2:_onChangeTabCtrl()
	self.m_Comp_empty:setTitle((g.core.lang:get(var_0_1[self.m_typeController:getSelectedIndex() + 1])))
	self:_updateTeam()
end

function var_0_2:_updateTeam(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = self.m_typeController:getSelectedIndex()

	if var_5_0 == 0 then
		self._showTeamArr = self._inviteTeamArr

		self.m_List_team:setNumItems(#self._inviteTeamArr)
		self.m_is_emptyController:setSelectedIndex(#self._inviteTeamArr == 0 and 1 or 0)
	elseif var_5_0 == 1 then
		self._showTeamArr = self._applyTeamArr

		self.m_List_team:setNumItems(#self._applyTeamArr)
		self.m_is_emptyController:setSelectedIndex(#self._applyTeamArr == 0 and 1 or 0)
	elseif var_5_0 == 2 then
		self._showTeamArr = self._searchTeamArr

		self.m_List_team:setNumItems(#self._searchTeamArr)
		self.m_is_emptyController:setSelectedIndex(#self._searchTeamArr == 0 and 1 or 0)
	end
end

function var_0_2:_onRevGetApplyRecord(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._applyTeamArr = arg_6_4.teams or {}

	self:_onChangeTabCtrl()
end

function var_0_2:_onRevGetInviteList(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._inviteTeamArr = arg_7_4.teams or {}

	self:_onChangeTabCtrl()
end

function var_0_2:_onRevGetSearchList(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._searchTeamArr = arg_8_4.teams or {}

	if #self._searchTeamArr == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433335))
	end

	self:_onChangeTabCtrl()
end

function var_0_2._onUpdateApplyRecord(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.network.GameNetProxy:send_C2S_Ancient_GetApplyRecord({})
end

function var_0_2._onUpdateInvitationList(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	g.core.network.GameNetProxy:send_C2S_Ancient_GetInvitationList({})
end

function var_0_2:_onClickBtnSearch()
	local var_11_0 = self.m_Label_seek:getText()

	if string.find(var_11_0, "^%s+$") or var_11_0 == "" then
		g.core.module.ModuleManager:tip(g.core.lang:get(433333))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_Search({
		content = var_11_0
	})
end

function var_0_2:_onRenderListTeamCell(arg_12_1, arg_12_2)
	arg_12_2:updateCell({
		type = self.m_typeController:getSelectedIndex(),
		team = self._showTeamArr[arg_12_1 + 1]
	})
end

return var_0_2
