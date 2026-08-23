local DebugPubg2CtrlComp = class("DebugPubg2CtrlComp", require("app.fairyGUI.debug.UI_DebugPubg2CtrlComp"))

function DebugPubg2CtrlComp:ctor()
	local var_1_0 = self:getSize()

	self._centerPos = cc.p(var_1_0.width * 0.5, var_1_0.height * 0.5)
	self._radius = var_1_0.width * 0.5
	self._checkLen = var_1_0.width * 0.5 * (var_1_0.width * 0.5)
	self._curCtrlPos = cc.p(0, 0)

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function DebugPubg2CtrlComp:onLoad()
	self._inGlobalPos = self:localToGlobal(cc.p(0, 0))
end

function DebugPubg2CtrlComp:isTouching()
	return self._isTouch
end

function DebugPubg2CtrlComp:getAngle()
	if self._curCtrlPos.x * self._curCtrlPos.x + self._curCtrlPos.y * self._curCtrlPos.y <= 10 then
		return 0
	end

	return (math.atan2(-self._curCtrlPos.y, self._curCtrlPos.x))
end

function DebugPubg2CtrlComp:_onTouchBegin(arg_5_1)
	if arg_5_1:getInput():getButton() == 1 then
		return
	end

	local var_5_0 = arg_5_1:getInput():getPosition()
	local var_5_1 = cc.p(var_5_0.x - self._inGlobalPos.x, var_5_0.y - self._inGlobalPos.y)

	if var_5_1.x * var_5_1.x + var_5_1.y * var_5_1.y > self._checkLen then
		self._isTouch = false
	else
		self._isTouch = true

		arg_5_1:captureTouch()

		self._curCtrlPos = var_5_1

		self.m_ctrlImg:setPosition(cc.pAdd(self._curCtrlPos, self._centerPos))
	end
end

function DebugPubg2CtrlComp:_onTouchMove(arg_6_1)
	if arg_6_1:getInput():getButton() == 1 then
		return
	end

	if self._isTouch then
		local var_6_0 = arg_6_1:getInput():getPosition()
		local var_6_1 = cc.p(var_6_0.x - self._inGlobalPos.x, var_6_0.y - self._inGlobalPos.y)

		if var_6_1.x * var_6_1.x + var_6_1.y * var_6_1.y > self._checkLen then
			local var_6_2 = math.sqrt(var_6_1.x * var_6_1.x + var_6_1.y * var_6_1.y)

			self._curCtrlPos = cc.p(var_6_1.x * self._radius / var_6_2, var_6_1.y * self._radius / var_6_2)
		else
			self._curCtrlPos = var_6_1
		end

		self.m_ctrlImg:setPosition(cc.pAdd(self._curCtrlPos, self._centerPos))
	end
end

function DebugPubg2CtrlComp:_onTouchEnd(arg_7_1)
	self._isTouch = false
	self._curCtrlPos = cc.p(0, 0)

	self.m_ctrlImg:setPosition(cc.pAdd(self._curCtrlPos, self._centerPos))
end

return DebugPubg2CtrlComp
