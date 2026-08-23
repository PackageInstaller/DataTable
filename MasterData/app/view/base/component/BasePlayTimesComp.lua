local BasePlayTimesComp = class("BasePlayTimesComp", require("app.fairyGUI.base_new.UI_BasePlayTimesComp"))

function BasePlayTimesComp:ctor()
	self.m_touchComp:addClickListener(handler(self, self._onClickAdd))
	self.m_getTimesBtn:addClickListener(handler(self, self._onClickAdd))
	self.m_showDetailController:setSelectedIndex(0)
	self:addClickListener(handler(self, self._onShowDetailClick))

	self._skipChange = false
end

function BasePlayTimesComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_NOTIFY, self._onRecoverOne, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onRecoverOne, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, self._onRecoverOne, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RESOURCE_CHANGE, self._onTimesChange, self)

	if self._params and self._params.refreshEvent then
		for iter_2_0, iter_2_1 in ipairs(self._params.refreshEvent) do
			g.core.event.EventManager:addEventListener(iter_2_1, self.updateView, self)
		end
	end
end

function BasePlayTimesComp:initView(arg_3_1)
	self._params = arg_3_1
	self._type = arg_3_1.type
	self._getTimesFunc = arg_3_1.getTimesFunc
	self._fullTimes = arg_3_1.fullTime
	self._timesName = arg_3_1.name
	self._toTimeRecoverDesc = arg_3_1.toTimeRecoverDesc
	self._clickAddFunc = arg_3_1.onGetTimes

	if arg_3_1.refreshEvent then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.refreshEvent) do
			g.core.event.EventManager:addEventListener(iter_3_1, self.updateView, self)
		end
	end

	if self._timesName then
		self.m_nameTxt:setText(self._timesName)
	end

	if not self._clickAddFunc then
		self.m_getTimesBtn:setVisible(false)
	end

	self.m_bubbleComp:initData(arg_3_1)
	self:updateView()
end

function BasePlayTimesComp:skipTimesChange()
	self._skipChange = true
end

function BasePlayTimesComp:unSkipTimesChange()
	self._skipChange = false

	self:updateView()
end

function BasePlayTimesComp:_onShowDetailClick(arg_6_1)
	if not self._params.closeDetailClick then
		self.m_bubbleComp:setShow(handler(self, self._onShowFinish))
		self.m_showDetailController:setSelectedIndex(1)
		arg_6_1:captureTouch()
	end
end

function BasePlayTimesComp:_onShowFinish()
	self.m_showDetailController:setSelectedIndex(0)
end

function BasePlayTimesComp:_onRecoverOne()
	self:updateView()
end

function BasePlayTimesComp:_onTimesChange()
	self:updateView()
end

function BasePlayTimesComp:createTickUpdate()
	local var_10_0 = g.core.model.User.resourceData:getResourceDataByType(self._type)

	self._nextTime = var_10_0.refresh_time
	self._fullTime = var_10_0.time

	self.m_bubbleComp:initTargetTime()
end

function BasePlayTimesComp:_onClickAdd()
	if self._clickAddFunc then
		self._clickAddFunc()
	end
end

function BasePlayTimesComp:updateView()
	if self._skipChange then
		return
	end

	if self._getTimesFunc then
		self.m_valueTxt:setText((self._getTimesFunc()))
	end
end

function BasePlayTimesComp:onUnload()
	self.m_showDetailController:setSelectedIndex(0)
end

return BasePlayTimesComp
