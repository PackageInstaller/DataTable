local TouchMapComp = class("TouchMapComp")

function TouchMapComp:ctor()
	self._observer = nil

	self:_initRegisterUI()
end

function TouchMapComp:startListen(arg_2_1)
	self._observer = arg_2_1
end

function TouchMapComp:_initRegisterUI()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self:addClickListener(handler(self, self._onTouchClick))
end

function TouchMapComp:_onTouchBegin(arg_4_1)
	if self._observer == nil then
		return
	end

	if self._observer.onCoverTouchBegan ~= nil then
		arg_4_1:captureTouch()
		self._observer:onCoverTouchBegan((arg_4_1:getInput():getTouch()))
	end
end

function TouchMapComp:_onTouchMove(arg_5_1)
	if self._observer == nil then
		return
	end

	if self._observer.onCoverTouchMoved ~= nil then
		self._observer:onCoverTouchMoved((arg_5_1:getInput():getTouch()))
	end
end

function TouchMapComp:_onTouchEnd(arg_6_1)
	if self._observer == nil then
		return
	end

	if self._observer.onCoverTouchEnded ~= nil then
		self._observer:onCoverTouchEnded((arg_6_1:getInput():getTouch()))
	end
end

function TouchMapComp:_onTouchClick(arg_7_1)
	if self._observer == nil then
		return
	end

	if self._observer.onCoverClicked ~= nil then
		arg_7_1:captureTouch()
		self._observer:onCoverClicked((arg_7_1:getInput():getTouch()))
	end
end

return TouchMapComp
