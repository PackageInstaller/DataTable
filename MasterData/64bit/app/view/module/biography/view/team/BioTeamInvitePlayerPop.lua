local var_0_0 = {
	GUILD = 2,
	FRIEND = 1
}
local var_0_1 = g.core.model.User.bioData
local BioTeamInvitePlayerPop = class("BioTeamInvitePlayerPop", require("app.fairyGUI.biography.UI_BioTeamInvitePlayerPop"), function()
	return fgui.GComponent:create({
		pkgName = "biography",
		resName = "BioTeamInvitePlayerPop",
		pkgPath = "ui/biography/biography"
	}, ...)
end)

function BioTeamInvitePlayerPop:ctor()
	self:showAtCenter()

	self._tabType = var_0_0.FRIEND

	self.m_memberList:setVirtual()
	self.m_memberList:setItemRenderer(handler(self, self._onListRender))
	self.m_memberList:doFairyBatching(false)
	self.m_oneKeyCallBtn:addClickListener(handler(self, self._onClickOneKeyCall))
	self.m_tabTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self:_onChangeTabCtrl()
end

function BioTeamInvitePlayerPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_INVITEROBOT, self._onInviteRobot, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_INVITEPLAYER, self._onInvitePlayer, self)
end

function BioTeamInvitePlayerPop:_onChangeTabCtrl()
	self._tabType = self.m_tabTypeController:getSelectedIndex() + 1

	self:_updateList()
end

function BioTeamInvitePlayerPop:_updateList()
	self.m_emptyTypeController:setSelectedIndex(0)

	self._listData = var_0_1:getInviteTeamData(self._tabType)

	if #self._listData < 1 then
		self.m_emptyTypeController:setSelectedIndex(self._tabType)

		if self._tabType == 2 then
			local var_5_0 = g.core.model.User:getGuildId()

			if not var_5_0 or var_5_0 == 0 then
				self.m_emptyTypeController:setSelectedIndex(3)
			end
		end
	end

	self.m_memberList:setNumItems(#self._listData)
end

function BioTeamInvitePlayerPop:_onListRender(arg_6_1, arg_6_2)
	arg_6_2:update(self._listData[arg_6_1 + 1])
end

function BioTeamInvitePlayerPop:_onClickOneKeyCall()
	local var_7_0 = g.core.lang
	local var_7_1 = var_0_1:getTeamInfo().campaign_id or 0
	local var_7_2 = g.core.config.biography_team_info.fetch(var_7_1)

	if var_7_1 > 0 and var_7_2 then
		local var_7_3 = var_7_2.name or ""

		if var_7_3 ~= "" then
			local var_7_4 = fgui.UIPackage:createObject("biography", "BioTeamSendMsgComp")

			var_7_4:setTitle((var_7_0:get(302064, {
				name = var_7_3
			})))
			g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseChatCallPop").new({
				childComp = var_7_4,
				funcId = g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN
			}))
		end
	end
end

function BioTeamInvitePlayerPop:_onInviteRobot()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function BioTeamInvitePlayerPop:_onInvitePlayer()
	g.core.module.ModuleManager:tip(g.core.lang:get(302044))
	self:_updateList()
end

return BioTeamInvitePlayerPop
