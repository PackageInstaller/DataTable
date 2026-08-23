local BaseCommonBtn = class("BaseCommonBtn")

function BaseCommonBtn:ctor(arg_1_1)
	self._param = arg_1_1
	self.m_buttonController = self:getController("button")
	self.m_styleController = self:getController("style")
	self.m_titleColorController = self:getController("titleColor")
	self.m_loader = self:getChild("loader")
	self.m_title = self:getChild("title")
	self._redPoint = self:getRootChild("redPointComp")
	self._redPointLeft = self:getRootChild("redPointLeftComp")
	self._funcUnlock = self:getRootChild("funcUnlockComp")
	self._baseScalex = self:getScaleX()
	self._baseScaley = self:getScaleY()
	self._rate = 1.1
	self._sound = nil

	if self.m_buttonController then
		self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChanged))
	end

	self:addClickListener(handler(self, self._onClick))
end

function BaseCommonBtn:_onChanged()
	local var_2_0 = self.m_buttonController:getSelectedIndex()

	if var_2_0 ~= 1 then
		self:setScale(self._baseScalex, self._baseScaley)

		if self._pushed then
			self._pushed = false
		end
	elseif var_2_0 == 1 then
		self:setScale(self._baseScalex * self._rate, self._baseScaley * self._rate)

		self._pushed = true
	end
end

function BaseCommonBtn:_onClick()
	if self._sound then
		g.core.sound.SoundManager:playSound(self._sound)
	end

	if self._redPoint then
		self._redPoint:response()
	end
end

function BaseCommonBtn:showRedPoint()
	if self._redPoint then
		self._redPoint:setDefaultStyle(self._redPoint.STYLE_RED_POINT)
	end
end

function BaseCommonBtn:showRedPointArrow()
	if self._redPoint then
		self._redPoint:setDefaultStyle(self._redPoint.STYLE_ARROW)
	end
end

function BaseCommonBtn:showRedPointLeftHint(arg_6_1)
	if self._redPointLeft then
		self._redPointLeft:setDefaultStyle(self._redPoint.STYLE_HINT)
		self._redPointLeft:setHintText(arg_6_1)
	end
end

function BaseCommonBtn:bindRedPoint(arg_7_1)
	if self._redPoint then
		self._redPoint:bindCondition(arg_7_1)
	end
end

function BaseCommonBtn:bindRedPointLeft(arg_8_1)
	if self._redPointLeft then
		self._redPointLeft:bindCondition(arg_8_1)
	end
end

function BaseCommonBtn:refreshRedPoint(arg_9_1)
	if self._redPoint then
		self._redPoint:refresh(arg_9_1)
	end
end

function BaseCommonBtn:refreshRedPointLeft(arg_10_1)
	if self._redPointLeft then
		self._redPointLeft:refresh(arg_10_1)
	end
end

function BaseCommonBtn:setRedPointData(arg_11_1)
	if self._redPoint then
		self._redPoint:setData(arg_11_1)
	end
end

function BaseCommonBtn:setRedPointLeftData(arg_12_1)
	if self._redPointLeft then
		self._redPointLeft:setData(arg_12_1)
	end
end

function BaseCommonBtn:clearRedPointCond()
	if self._redPoint then
		self._redPoint:clearCondition()
	end
end

function BaseCommonBtn:clearRedPointLeftCond()
	if self._redPointLeft then
		self._redPointLeft:clearCondition()
	end
end

function BaseCommonBtn:setRedPointTag()
	if self._redPoint then
		self._redPoint:setTag(...)
	end
end

function BaseCommonBtn:bindFuncRouteIds(arg_16_1)
	if self._funcUnlock then
		self._funcUnlock:bindFuncRouteIds(arg_16_1)
	end
end

function BaseCommonBtn:clearFuncRouteIds()
	if self._funcUnlock then
		self._funcUnlock:clearFuncRouteIds()
	end
end

function BaseCommonBtn:refreshFuncUnlock(arg_18_1)
	if self._funcUnlock then
		self._funcUnlock:refresh(arg_18_1)
	end
end

function BaseCommonBtn:setAutoRefreshFuncUnlock(arg_19_1)
	if self._funcUnlock then
		self._funcUnlock:setAutoRefresh(arg_19_1)
	end
end

function BaseCommonBtn:setSound(arg_20_1)
	self._sound = arg_20_1
end

return BaseCommonBtn
