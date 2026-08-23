local var_0_0 = g.core.model.User.newSlgData
local NewSlgFirstKillComp = class("NewSlgFirstKillComp")

function NewSlgFirstKillComp:ctor()
	self._listTeam = {}
	self._tabComp = {}
	self._tabCount = g.core.const.ConstMgr.NewSlgConst.FIRST_KILL_MAX_TAB
	self._teamArr = {}
	self._firstKillIds = {}

	for iter_1_0 = 1, self._tabCount do
		self._listTeam[iter_1_0] = self:getChild("List_teams" .. iter_1_0)

		self._listTeam[iter_1_0]:setVirtual(self)
		self._listTeam[iter_1_0]:setItemRenderer(handler(self, self._onRenderListTeamCell))

		self._tabComp[iter_1_0] = self:getChild("Comp_tab" .. iter_1_0)
		self._teamArr[iter_1_0] = {}
	end

	self._tabCtrl = self:getController("tab")

	self._tabCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTabChange))

	self._tabIndex = 0
	self._sended = false
	self._firstKillPassed = {}
	self._autoScroll = {
		false,
		false
	}
end

function NewSlgFirstKillComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLINFO, handler(self, self._onRcvFirstKillInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateList), self)
	self:updateTabRed()
end

function NewSlgFirstKillComp:updateTabRed()
	for iter_3_0 = 1, self._tabCount do
		self._tabComp[iter_3_0]:getChild("redPointComp"):setShow(var_0_0:canGetFirstKillAwardByType(iter_3_0))
	end
end

function NewSlgFirstKillComp:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "NewSlgFirstKillCell_clickAward" then
		g.core.network.GameNetProxy:send_C2S_NewSlg_FirstKillAward({
			id = arg_4_2.id
		})
	else
		self:dispatchCompEvent(arg_4_1, arg_4_2)
	end
end

function NewSlgFirstKillComp:_onCtrlTabChange()
	local var_5_0 = self._tabCtrl:getSelectedIndex()

	if var_5_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_5_0

	self:_sendMsg()
end

function NewSlgFirstKillComp:updateWithUserList()
	self:_updateList()
end

function NewSlgFirstKillComp:_onRenderListTeamCell(arg_7_1, arg_7_2)
	local var_7_0 = self._teamArr[self._tabIndex + 1][arg_7_1 + 1] or {}

	arg_7_2:updateCell(var_7_0, (var_7_0 or nil) and (self._firstKillPassed[var_7_0.id] or nil))
end

function NewSlgFirstKillComp:updateView()
	self:_sendMsg()
end

function NewSlgFirstKillComp:_updateList()
	self._listTeam[self._tabIndex + 1]:setNumItems(#self._teamArr[self._tabIndex + 1])

	if not self._autoScroll[self._tabIndex + 1] then
		local var_9_0 = 0

		for iter_9_0, iter_9_1 in ipairs(self._teamArr[self._tabIndex + 1]) do
			if g.core.model.User.newSlgData:canGetFirstKillAwardById(iter_9_1.id) then
				var_9_0 = iter_9_0 - 1

				break
			end
		end

		if var_9_0 > 0 then
			self._listTeam[self._tabIndex + 1]:scrollToView(var_9_0)
		end

		self._autoScroll[self._tabIndex + 1] = true
	end

	self:updateTabRed()
end

function NewSlgFirstKillComp:_sendMsg()
	if not self._sended then
		if not self._firstKillIds[self._tabIndex + 1] then
			for iter_10_0, iter_10_1 in g.core.config.new_slg_first_kill_info.ipairs() do
				if not self._firstKillIds[iter_10_1.type] then
					self._firstKillIds[iter_10_1.type] = {}
					self._teamArr[iter_10_1.type] = {}
				end

				table.insert(self._firstKillIds[iter_10_1.type], iter_10_1.id)
				table.insert(self._teamArr[iter_10_1.type], iter_10_1)
			end
		end

		for iter_10_2 = 1, self._tabCount do
			if self._firstKillIds[iter_10_2] and #self._firstKillIds[iter_10_2] > 0 then
				g.core.network.GameNetProxy:send_C2S_NewSlg_FirstKillInfo({
					ids = self._firstKillIds[iter_10_2]
				})
			end
		end

		self._sended = true
	else
		self:_updateList()
	end
end

function NewSlgFirstKillComp:_onRcvFirstKillInfo(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	for iter_11_0, iter_11_1 in ipairs(arg_11_4.first_kills or {}) do
		self._firstKillPassed[iter_11_1.id] = iter_11_1
	end

	self:_updateList()
end

return NewSlgFirstKillComp
