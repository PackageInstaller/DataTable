local FloatLayerComponent = class("FloatLayerComponent", function()
	return fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")
end)

function FloatLayerComponent:ctor()
	local var_2_0 = cc.Director:getInstance():getSafeAreaRect()

	self:setSize((cc.size(display.width - var_2_0.x * 2, display.height - var_2_0.y * 2)))
	self:setName("FloatLayerComponent")
	self:setPivot(0, 0, true)
	self:setPosition(cc.p(var_2_0.x, var_2_0.y))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	self._statue = "None"
	self._compList = {}
	self._touchComp = nil
end

function FloatLayerComponent:_onTouchBegin(arg_3_1)
	self._touchComp = nil
	self._touchPos = arg_3_1:getInput():getPosition()
	self._touchLocalPos = self:_getTouchLocalPos(self._touchPos)
	self._touchBeginPos = self._touchLocalPos

	for iter_3_0, iter_3_1 in ipairs(self._compList) do
		if iter_3_1:isVisible() and cc.rectContainsPoint(self:_getCompRect(iter_3_1), self._touchLocalPos) then
			self._touchComp = iter_3_1

			break
		end
	end

	if self._touchComp then
		self._statue = "click"

		self._touchComp:onFocus()
		arg_3_1:captureTouch()
	end
end

function FloatLayerComponent:_onTouchMove(arg_4_1)
	if not self._touchComp then
		return
	end

	local var_4_0 = self._touchPos

	self._touchPos = arg_4_1:getInput():getPosition()
	self._touchLocalPos = self:_getTouchLocalPos(self._touchPos)

	if math.abs(var_4_0.x - self._touchPos.x) > 5 and math.abs(var_4_0.y - self._touchPos.y) > 5 then
		self._statue = "move"
	end

	local var_4_1 = self:getSize()

	self._touchLocalPos.x = math.min(self._touchLocalPos.x, var_4_1.width)
	self._touchLocalPos.x = math.max(self._touchLocalPos.x, 0)
	self._touchLocalPos.y = math.min(self._touchLocalPos.y, var_4_1.height)
	self._touchLocalPos.y = math.max(self._touchLocalPos.y, 0)

	self._touchComp:setPosition((self:_centerPosToCompPos(self._touchLocalPos, self._touchComp)))
end

function FloatLayerComponent:_onTouchEnd(arg_5_1)
	if not self._touchComp then
		return
	end

	local var_5_0 = self:_getTouchLocalPos((arg_5_1:getInput():getPosition()))

	if self._statue == "click" and cc.pDistanceSQ(var_5_0, self._touchBeginPos) < 100 then
		self._touchComp:onClick()
	else
		local var_5_1 = self:getSize()

		var_5_0.x = math.min(var_5_0.x, var_5_1.width)
		var_5_0.x = math.max(var_5_0.x, 0)
		var_5_0.y = math.min(var_5_0.y, var_5_1.height)
		var_5_0.y = math.max(var_5_0.y, 0)

		self._touchComp:setPosition((self:_centerPosToCompPos(var_5_0, self._touchComp)))
		self:_fixCompPos(self._touchComp)
	end

	self:_onCompIdle(self._touchComp)

	self._touchComp = nil
end

function FloatLayerComponent:createAndAddFloatComp(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 and self:getFloatComp(arg_6_1.name) then
		return
	end

	local var_6_0 = arg_6_2()

	var_6_0:setName(arg_6_1.name)
	require("app.view.module.float.view.FloatComponent"):bindComp(arg_6_1)
	self:addFloatComp(var_6_0)
end

function FloatLayerComponent:addFloatComp(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self._compList) do
		if iter_7_1 == arg_7_1 then
			return
		end
	end

	self:_fixCompPos(arg_7_1)
	self:addChild(arg_7_1)

	self._compList[#self._compList + 1] = arg_7_1

	self:_onCompIdle(arg_7_1)
end

function FloatLayerComponent:_getTouchLocalPos(arg_8_1)
	local var_8_0 = self:globalToLocal(arg_8_1)

	var_8_0.y = self:getSize().height - var_8_0.y

	return var_8_0
end

function FloatLayerComponent:_getComp2dxAnchorPoint(arg_9_1)
	local var_9_0 = arg_9_1:isPivotAsAnchor() and arg_9_1:getPivot() or cc.p(0, 0)

	var_9_0.y = 1 - var_9_0.y

	return var_9_0
end

function FloatLayerComponent:_getCompRect(arg_10_1)
	local var_10_0 = arg_10_1:getPosition()

	var_10_0.y = self:getSize().height - var_10_0.y

	local var_10_1 = arg_10_1:getSize()
	local var_10_2 = self:_getComp2dxAnchorPoint(arg_10_1)

	var_10_0.x = var_10_0.x - var_10_2.x * var_10_1.width
	var_10_0.y = var_10_0.y - var_10_2.y * var_10_1.height

	return (cc.rect(var_10_0.x, var_10_0.y, var_10_1.width, var_10_1.height))
end

function FloatLayerComponent:_2dxPosToCompPos(arg_11_1, arg_11_2)
	local var_11_0 = self:_getComp2dxAnchorPoint(arg_11_2)
	local var_11_1 = arg_11_2:getSize()
	local var_11_2 = cc.p(arg_11_1.x + var_11_0.x * var_11_1.width, arg_11_1.y + var_11_0.y * var_11_1.height)

	var_11_2.y = self:getSize().height - var_11_2.y

	return var_11_2
end

function FloatLayerComponent:_centerPosToCompPos(arg_12_1, arg_12_2)
	local var_12_0 = self:_getComp2dxAnchorPoint(arg_12_2)
	local var_12_1 = arg_12_2:getSize()
	local var_12_2 = cc.p(arg_12_1.x + (var_12_0.x - 0.5) * var_12_1.width, arg_12_1.y + (var_12_0.y - 0.5) * var_12_1.height)

	var_12_2.y = self:getSize().height - var_12_2.y

	return var_12_2
end

function FloatLayerComponent:_fixCompPos(arg_13_1)
	local var_13_0 = clone((self:_getCompRect(arg_13_1)))

	for iter_13_0, iter_13_1 in ipairs(self._compList) do
		if iter_13_1 ~= arg_13_1 then
			local var_13_1 = self:_getCompRect(arg_13_1)

			if cc.rectIntersectsRect(var_13_0, var_13_1) then
				var_13_0.y = var_13_1.y - var_13_0.height
			else
				break
			end
		end
	end

	local var_13_2 = self:_getComp2dxAnchorPoint(arg_13_1)
	local var_13_3 = arg_13_1:getSize()
	local var_13_4 = cc.p(var_13_0.x + var_13_2.x * var_13_3.width, var_13_0.y + var_13_2.y * var_13_3.height)

	var_13_4.y = self:getSize().height - var_13_4.y

	arg_13_1:setPosition(self:_2dxPosToCompPos(var_13_0, arg_13_1))
end

function FloatLayerComponent:_onCompIdle(arg_14_1)
	local var_14_0 = self:getSize()
	local var_14_1 = arg_14_1:getPosition()
	local var_14_2 = arg_14_1:getSize()
	local var_14_3 = self:_getComp2dxAnchorPoint(arg_14_1)
	local var_14_4 = var_14_1.x + (0.5 - var_14_3.x) * var_14_2.width

	arg_14_1:onIdle(var_14_0.height - (var_14_0.height - var_14_1.y + (0.5 - var_14_3.y) * var_14_2.height) < var_14_0.width - (var_14_1.x + (0.5 - var_14_3.x) * var_14_2.width) and var_14_0.height - (var_14_0.height - var_14_1.y + (0.5 - var_14_3.y) * var_14_2.height) < var_14_4 and "top" or var_14_0.width - (var_14_1.x + (0.5 - var_14_3.x) * var_14_2.width) < var_14_4 and "right" or "left", var_14_0)
end

function FloatLayerComponent:getFloatComp(arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(self._compList) do
		if iter_15_1:getName() == arg_15_1 then
			var_15_0 = iter_15_1

			break
		end
	end

	return var_15_0
end

function FloatLayerComponent:setFloatCompVisible(arg_16_1, arg_16_2)
	local var_16_0 = self:getFloatComp(arg_16_1)

	if var_16_0 then
		var_16_0:setVisible(arg_16_2)
	end
end

function FloatLayerComponent:resetAllFloatComp()
	for iter_17_0, iter_17_1 in ipairs(self._compList) do
		iter_17_1:onReset()
	end
end

return FloatLayerComponent
