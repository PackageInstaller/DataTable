local var_0_0 = g.core.model.User.newSlgData
local NewSlgEventPop = class("NewSlgEventPop", function()
	return fgui.GComponent:create({
		resName = "NewSlgEventPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgEventPop:ctor()
	self:getView():center(true)

	self._taskComp = self:getChild("Comp_task")
	self._noticeComp = self:getChild("Comp_notice")
	self._firstKillComp = self:getChild("Comp_firstKill")
	self._tabCtrl = self:getController("tab")

	self._tabCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTabChange))

	self._tabIndex = -1
	self._taskTab = self:getChild("Comp_tab1")
	self._firstKillTab = self:getChild("Comp_tab3")
	self._closeGraph = self:getChild("closeGraph")

	self._closeGraph:addClickListener(handler(self, self.onClose))
	self:getTransition("enter"):play()
end

function NewSlgEventPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYTASKAWARD, handler(self, self._onGetBountyTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLAWARD, handler(self, self._onGetFirstKillAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLINFO, handler(self, self.updateTabRed), self)
	self:_onCtrlTabChange()
	self:updateTabRed()
end

function NewSlgEventPop:updateTabRed()
	self._taskTab:getChild("redPointComp"):setShow(var_0_0:canGetBountyTaskAward())
	self._firstKillTab:getChild("redPointComp"):setShow(var_0_0:canGetFirstKillAward())
end

function NewSlgEventPop:onUnload()
	return
end

function NewSlgEventPop:_onCtrlTabChange()
	local var_6_0 = self._tabCtrl:getSelectedIndex()

	if var_6_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_6_0

	self:_sendMsg()
end

function NewSlgEventPop:_sendMsg()
	if self._tabIndex == 0 then
		self._taskComp:updateView()
	elseif self._tabIndex == 1 then
		self._firstKillComp:updateView()
	end
end

function NewSlgEventPop:_onS2CNewSlgNotice(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._noticeComp:updateView(arg_8_4)
end

function NewSlgEventPop:_onRcvNewSlgModifyNotice(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self._noticeComp:updateForceNotice(arg_9_4.announcement)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetDeclaration({})
end

function NewSlgEventPop:_onGetBountyTaskAward(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_10_4.awards, true)
	end

	self:updateTabRed()
	self._taskComp:updateView()
end

function NewSlgEventPop:_onGetFirstKillAward(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_11_4.awards, true)
	end

	self:updateTabRed()
	self._firstKillComp:updateView()
end

function NewSlgEventPop:onClose()
	if self._isExiting then
		return
	end

	self._isExiting = true

	self:getTransition("back"):play(handler(self, self.onExitPlayFinish))
end

function NewSlgEventPop:onExitPlayFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return NewSlgEventPop
