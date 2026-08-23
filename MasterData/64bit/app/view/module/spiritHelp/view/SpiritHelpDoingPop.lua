local var_0_0 = g.core.model.User.spiritHelpData
local var_0_1 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_2 = g.core.event.EventManager
local SpiritHelpDoingPop = class("SpiritHelpDoingPop", require("app.fairyGUI.spiritHelp.UI_SpiritHelpDoingPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/spiritHelp/spiritHelp",
		resName = "SpiritHelpDoingPop",
		pkgName = "spiritHelp",
		isFullScreen = false
	}, ...)
end)

function SpiritHelpDoingPop:ctor()
	self._doingList = {}
	self._curDoingIndex = 0
	self._curDoing = nil
	self._stepSchedule = nil
	self._logList = {}
	self._idIndexDict = {}
	self._isDoing = false

	self:initView()
	self:starDoing()
end

function SpiritHelpDoingPop:starDoing()
	self._doingList = var_0_0:getCurDoingList()
	self._curDoingIndex = 0
	self._curDoing = nil
	self._isDoing = true

	self:exitAndDoNext()
	self:addStepSchedule()
	self.m_popPanel.m_closeBtn:setVisible(false)
end

function SpiritHelpDoingPop:initView()
	self:showAtCenter()
	self.m_logList:setVirtual()
	self.m_logList:doFairyBatching(false)
	self.m_logList:setItemRenderer(handler(self, self._onLogListRenderer))
	self.m_logList:setItemProvider(handler(self, self._onLogListItemProvider))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickClose))
end

function SpiritHelpDoingPop:_onClickClose()
	if self._isDoing then
		self._isDoing = false
	elseif self._curDoing and self._curDoing:hasSending() then
		return
	else
		self:dispatchCompEvent("doing_pop_end")
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function SpiritHelpDoingPop:endDoing()
	self._isDoing = false

	self.m_popPanel.m_closeBtn:setVisible(true)
	self:_exitDoing()
	g.core.network.GameNetProxy:send_C2S_SpiritHelp_GetInfo({})
	self:updateLog({
		spiritId = 0,
		isEnd = true
	})
end

function SpiritHelpDoingPop:_onLogListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateLogCell(self._logList[arg_7_1 + 1])
end

function SpiritHelpDoingPop:_onLogListItemProvider(arg_8_1)
	if self._logList[arg_8_1 + 1].isEnd then
		return "ui://spiritHelp/SpiritHelpLogEndCell"
	else
		return "ui://spiritHelp/SpiritHelpLogCell"
	end
end

function SpiritHelpDoingPop:onLoad()
	var_0_2:addEventListener(g.core.event.enum.SPIRIT_HELP_NET_ERROR, handler(self, self.onS2CNetError), self)
end

function SpiritHelpDoingPop:onS2CNetError(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if self._curDoing then
		self._curDoing:refreshState()
		self:updateLog({
			doingState = var_0_1.DOING_STATE.FAIL,
			awards = {},
			cost = {},
			failText = arg_10_4.ret,
			spiritId = self._curDoing:getInfo().id
		})
		self:exitAndDoNext()
	end
end

function SpiritHelpDoingPop:addStepSchedule()
	self._stepSchedule = self._stepSchedule or self:newSchedule(handler(self, self.checkStep), 1)
	self._stepCount = 0
end

function SpiritHelpDoingPop:checkStep()
	if not self._curDoing then
		return
	end

	self._stepCount = self._stepIndex == self._curDoingIndex and self._stepCount + 1 or 0

	if self._stepCount > var_0_1.STEP_COUNT then
		self._stepCount = 0

		self._curDoing:refreshState()
		self:updateLog({
			doingState = var_0_1.DOING_STATE.FAIL,
			spiritId = self._curDoing:getInfo().id
		})
		self:exitAndDoNext()
	end
end

function SpiritHelpDoingPop:exitAndDoNext()
	self:_exitDoing()

	if self._isDoing then
		self:newScheduleOnce(handler(self, self._doNext), 0.5)
	end
end

function SpiritHelpDoingPop:_doNext()
	self._curDoingIndex = self._curDoingIndex + 1
	self._stepIndex = self._curDoingIndex

	if self._doingList[self._curDoingIndex] then
		for iter_14_0, iter_14_1 in pairs((self._doingList[self._curDoingIndex]:getNeedAddEventList())) do
			var_0_2:addEventListener(iter_14_0, handler(self, self.onS2CNet), self)
		end

		self._doingList[self._curDoingIndex]:resetDoingData()
	end

	self._curDoing = self._doingList[self._curDoingIndex]

	self:doing()
end

function SpiritHelpDoingPop:doing()
	if self._curDoing then
		if not self._isDoing and not self._curDoing:hasSending() then
			self:endDoing()

			return
		end

		if not self._curDoing:isFinish() then
			self._curDoing:doing()
		end

		if self._curDoing:isDone() then
			self:exitAndDoNext()
		else
			self:updateLog({
				spiritId = self._curDoing:getInfo().id
			})
		end
	else
		self:cancelStepSchedule()
		self:endDoing()
	end
end

function SpiritHelpDoingPop:_exitDoing()
	if self._curDoing then
		for iter_16_0, iter_16_1 in pairs((self._curDoing:getNeedAddEventList())) do
			var_0_2:removeListenerWithEvent(self, iter_16_0)
		end
	end

	self._curDoing = nil
end

function SpiritHelpDoingPop:cancelStepSchedule()
	if self._stepSchedule then
		self:cancelSchedule(self._stepSchedule)
	end

	self._stepSchedule = nil
end

function SpiritHelpDoingPop:onS2CNet(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if self._curDoing and self._curDoing:onBaseS2CNet(arg_18_1, arg_18_2, arg_18_3, arg_18_4) then
		self._stepCount = 0

		self:updateLog(self._curDoing:getLogSuccessParams(arg_18_4))
	end

	self:doing()
end

function SpiritHelpDoingPop:updateLog(arg_19_1)
	arg_19_1.time = g.core.common.ServerTime:getTime()

	local var_19_0 = self._idIndexDict[arg_19_1.spiritId]

	if not self._idIndexDict[arg_19_1.spiritId] then
		arg_19_1.isNew = true

		table.insert(self._logList, arg_19_1)

		self._idIndexDict[arg_19_1.spiritId] = #self._logList
	else
		arg_19_1.isNew = false

		table.merge(self._logList[var_19_0], arg_19_1)
	end

	if arg_19_1.doingState == var_0_1.DOING_STATE.SUCCESS or arg_19_1.doingState == var_0_1.DOING_STATE.FAIL then
		var_0_0:addLogByLog(self._logList[var_19_0])
		var_0_0:saveLogJsonData()
	end

	self.m_logList:setNumItems(#self._logList)
	self.m_logList:scrollToView(#self._logList - 1)
end

return SpiritHelpDoingPop
