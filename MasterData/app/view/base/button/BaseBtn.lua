local BaseBtn = class("BaseBtn")

function BaseBtn:ctor(arg_1_1)
	self._param = arg_1_1
	self.m_buttonController = self:getController("button")
	self.m_styleController = self:getController("style")
	self.m_titleColorController = self:getController("titleColor")
	self.m_loader = self:getChild("loader")
	self.m_title = self:getChild("title")
	self._delayClick = false
	self._funcUnlock = self:getRootChild("funcUnlockComp")
	self._baseScalex = self:getScaleX()
	self._baseScaley = self:getScaleY()
	self._rate = self._param and self._param[1] and self._param[1] == "small" and 0.97 or 1.05
	self._sound = g.core.const.ConstMgr.SoundConst.Sound.CLICK_ENTER

	if self.m_buttonController then
		self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChanged))
	end

	self:addClickListener(handler(self, self._onClick))
end

function BaseBtn:onLoad()
	if self._redPointId and self.m_redPointComp then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end
end

function BaseBtn:_onChanged()
	local var_3_0 = self.m_buttonController:getSelectedIndex()

	if var_3_0 ~= 1 then
		self:setScale(self._baseScalex, self._baseScaley)

		if self._pushed then
			self._pushed = false
		end
	elseif var_3_0 == 1 then
		self:setScale(self._baseScalex * self._rate, self._baseScaley * self._rate)

		self._pushed = true
	end
end

function BaseBtn:_onClick()
	if self._sound then
		g.core.sound.SoundManager:playSound(self._sound)
	end

	if self._redPoint then
		self._redPoint:response()
	end

	if self._delayClick then
		self:setTouchable(false)
		self:newScheduleOnce(handler(self, function(arg_5_0)
			arg_5_0:setTouchable(true)
		end), 1)
	end
end

function BaseBtn:showRedPoint()
	if self._redPoint then
		self._redPoint:setDefaultStyle(self._redPoint.STYLE_RED_POINT)
	end
end

function BaseBtn:showRedPointArrow()
	if self._redPoint then
		self._redPoint:setDefaultStyle(self._redPoint.STYLE_ARROW)
	end
end

function BaseBtn:showRedPointLeftHint(arg_8_1)
	if self._redPointLeft then
		self._redPointLeft:setDefaultStyle(self._redPoint.STYLE_HINT)
		self._redPointLeft:setHintText(arg_8_1)
	end
end

function BaseBtn:bindRedPoint(arg_9_1)
	if self._redPoint then
		self._redPoint:bindCondition(arg_9_1)
	end
end

function BaseBtn:bindRedPointLeft(arg_10_1)
	if self._redPointLeft then
		self._redPointLeft:bindCondition(arg_10_1)
	end
end

function BaseBtn:refreshRedPoint(arg_11_1)
	if self._redPoint then
		self._redPoint:refresh(arg_11_1)
	end
end

function BaseBtn:refreshRedPointLeft(arg_12_1)
	if self._redPointLeft then
		self._redPointLeft:refresh(arg_12_1)
	end
end

function BaseBtn:setRedPointData(arg_13_1)
	if self._redPoint then
		self._redPoint:setData(arg_13_1)
	end
end

function BaseBtn:setRedPointLeftData(arg_14_1)
	if self._redPointLeft then
		self._redPointLeft:setData(arg_14_1)
	end
end

function BaseBtn:clearRedPointCond()
	if self._redPoint then
		self._redPoint:clearCondition()
	end
end

function BaseBtn:clearRedPointLeftCond()
	if self._redPointLeft then
		self._redPointLeft:clearCondition()
	end
end

function BaseBtn:setRedPointTag()
	if self._redPoint then
		self._redPoint:setTag(...)
	end
end

function BaseBtn:bindFuncRouteIds(arg_18_1)
	if self._funcUnlock then
		self._funcUnlock:bindFuncRouteIds(arg_18_1)
	end
end

function BaseBtn:clearFuncRouteIds()
	if self._funcUnlock then
		self._funcUnlock:clearFuncRouteIds()
	end
end

function BaseBtn:refreshFuncUnlock(arg_20_1)
	if self._funcUnlock then
		self._funcUnlock:refresh(arg_20_1)
	end
end

function BaseBtn:setAutoRefreshFuncUnlock(arg_21_1)
	if self._funcUnlock then
		self._funcUnlock:setAutoRefresh(arg_21_1)
	end
end

function BaseBtn:setRedPointId(arg_22_1)
	self._redPointId = arg_22_1
	self.m_redPointComp = self:getChild("redPointComp")

	if self._redPointId and self.m_redPointComp then
		self.m_redPointComp:setId(self._redPointId)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end
end

function BaseBtn:setRedPointStyle(arg_23_1)
	self.m_redPointComp = self:getChild("redPointComp")

	if self.m_redPointComp then
		self.m_redPointComp:setStyleManually(arg_23_1)
	end
end

function BaseBtn:setSound(arg_24_1)
	self._sound = arg_24_1
end

function BaseBtn:setClickRate(arg_25_1)
	self._rate = arg_25_1
end

function BaseBtn:setDelayClickEnable(arg_26_1)
	self._delayClick = arg_26_1
end

return BaseBtn
