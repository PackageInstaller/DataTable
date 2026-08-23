local OutpostRecoverProduceComp = class("OutpostRecoverProduceComp", require("app.fairyGUI.outpost.UI_OutpostRecoverProduceComp"))

function OutpostRecoverProduceComp:ctor()
	self.m_pro:setMax(100)
end

function OutpostRecoverProduceComp:playShow(arg_2_1)
	self:newScheduleOnce(handler(self, self._onPlayEnd), 1.5)

	self._callback = arg_2_1

	self.m_pro:tweenValue(100, 1.5)
end

function OutpostRecoverProduceComp:_onPlayEnd()
	if self._callback then
		self._callback()
	end

	self._callback = nil
end

return OutpostRecoverProduceComp
