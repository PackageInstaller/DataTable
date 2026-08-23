local BasePlayTimesBubbleComp = class("BasePlayTimesBubbleComp", require("app.fairyGUI.base_new.UI_BasePlayTimesBubbleComp"))

function BasePlayTimesBubbleComp:initData(arg_1_1)
	self._param = arg_1_1
	self._showTime = 0
	self._hideCall = nil
end

function BasePlayTimesBubbleComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_NOTIFY, self._onRecoverOne, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self._onGameTouchFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RESOURCE_CHANGE, self._onRecoverOne, self)
end

function BasePlayTimesBubbleComp:showAction()
	self:cancelAllSchedule()

	if self._param.type then
		local var_3_0 = g.core.model.User.resourceData:getResourceDataByType(self._param.type)

		self._fullTime = var_3_0.time
		self._cfg = g.core.model.User.resourceData:getRecoverCfg(self._param.type)
		self._maxValue = self._cfg.time_limit

		if var_3_0.num >= self._maxValue then
			self.m_stateController:setSelectedIndex(2)
		else
			self.m_stateController:setSelectedIndex(0)
			self:newSchedule(handler(self, self._onUpdateShow), 1)
			self:_onUpdateShow()
		end
	else
		if self._param.isResetRecover then
			self.m_stateController:setSelectedIndex(3)

			return
		end

		if self._param.playNum then
			if self._param.playNum ~= 999 then
				self._cfg = g.core.config.play_num_info.get(self._param.playNum)

				if self._cfg.reset_type == 2 then
					self._addRefreshTime = 86400
				elseif self._cfg.reset_type == 3 then
					self._addRefreshTime = 604800 - g.core.common.ServerTime:secondsFromMonday()
				end
			else
				self._addRefreshTime = 86400
			end

			if ((not self._param.fullTime and self._cfg or nil) and self._cfg.reset) <= self._param.getTimesFunc() then
				self.m_stateController:setSelectedIndex(2)
			else
				if self._cfg and self._cfg.reset_type == 3 then
					self.m_stateController:setSelectedIndex(4)
				else
					self.m_stateController:setSelectedIndex(1)
				end

				self:newSchedule(handler(self, self._onUpdateShow), 1)
				self:_onUpdateShow()
			end
		end
	end
end

function BasePlayTimesBubbleComp:_onGameTouchFinish()
	if self._showTime == g.core.common.ServerTime:getTime() then
		return
	end

	self:hideAction()
end

function BasePlayTimesBubbleComp:setShow(arg_5_1)
	self._hideCall = arg_5_1

	if self._showTime == 0 then
		self._showTime = g.core.common.ServerTime:getTime()

		self:showAction()
	else
		self._showTime = g.core.common.ServerTime:getTime()
	end
end

function BasePlayTimesBubbleComp:hideAction()
	self:cancelAllSchedule()

	self._showTime = 0

	if self._hideCall then
		self._hideCall()
	end
end

function BasePlayTimesBubbleComp:_onUpdateShow()
	if self._param.type then
		local var_7_0 = g.core.common.ServerTime:getTime()

		self._fullTime = self._fullTime or os.time()

		if self._fullTime - var_7_0 <= 0 then
			self:hideAction()

			return
		end

		local var_7_1 = self._cfg.unit_time
		local var_7_2 = self._fullTime - var_7_0 - (self._maxValue - g.core.model.User.resourceData:getResourceDataByType(self._param.type).num - 1) * self._cfg.unit_time

		if var_7_2 < 0 then
			var_7_2 = var_7_2 + var_7_1
		end

		self.m_nextTimeTxt:setText((g.core.common.ServerTime:secondToHMSString(var_7_2)))
		self.m_allTimeTxt:setText(g.core.common.ServerTime:secondToHMSString(self._fullTime - var_7_0))
	elseif self._addRefreshTime then
		local var_7_3 = self._addRefreshTime - g.core.common.ServerTime:secondsFromToday((g.core.common.ServerTime:getTime()))

		if self._cfg and self._cfg.reset_type == 3 then
			self._addRefreshTime = 604800 - g.core.common.ServerTime:secondsFromMonday()
			var_7_3 = self._addRefreshTime
		end

		self.m_nextRefreshTimeTxt:setText(g.core.common.ServerTime:secondToHMSString(var_7_3))
	end

	if g.core.common.ServerTime:getTime() - self._showTime > 3 then
		self:hideAction()

		self._showTime = 0
	end
end

function BasePlayTimesBubbleComp:_onRecoverOne()
	self:showAction()
end

function BasePlayTimesBubbleComp:onUnload()
	self:cancelAllSchedule()
end

return BasePlayTimesBubbleComp
