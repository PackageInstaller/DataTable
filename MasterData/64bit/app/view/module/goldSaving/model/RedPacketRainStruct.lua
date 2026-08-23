local RedPacketRainStruct = class("RedPacketRainStruct")
local RedPacketRainConst = require("app.view.module.goldSaving.const.RedPacketRainConst")

function RedPacketRainStruct:ctor(arg_1_1)
	self._award = arg_1_1.award
	self._index = 0
	self._parameterIndex = arg_1_1.parameterIndex or RedPacketRainConst.BIG_AWARD_POSITION
	self._startPos = arg_1_1.startPos
	self._isBigAward = checkbool(arg_1_1.isBigAward)
	self._endPos = self:_setEndPos()
	self._clickProcess = 0
	self._needClickNum = arg_1_1.clickNum or 1
	self._rotation = self:_setRotation()
end

function RedPacketRainStruct:_setEndPos()
	local var_2_0 = cc.p(self._startPos.x, display.height + 300)

	return (self._isBigAward or nil) and cc.p(-300, display.height + 300)
end

function RedPacketRainStruct:_setRotation()
	if self._isBigAward then
		return 90 - math.deg(math.atan(display.height / display.width))
	end

	return 0
end

function RedPacketRainStruct:getRotation()
	return self._rotation
end

function RedPacketRainStruct:getIndex()
	return self._index
end

function RedPacketRainStruct:getAward()
	return self._award
end

function RedPacketRainStruct:getAwardSize()
	return self._award.size
end

function RedPacketRainStruct:getStartPosition()
	return self._startPos
end

function RedPacketRainStruct:getEndPosition()
	return self._endPos
end

function RedPacketRainStruct:getParameterIndex()
	return self._parameterIndex
end

function RedPacketRainStruct:isBigAward()
	return self._isBigAward
end

function RedPacketRainStruct:setIndex(arg_12_1)
	self._index = arg_12_1
end

function RedPacketRainStruct:addClickProcess()
	if self._isBigAward then
		self._clickProcess = self._clickProcess + 1
	end
end

function RedPacketRainStruct:getClickProcess()
	return self._clickProcess
end

function RedPacketRainStruct:isClickNumReachTarget()
	return not self._isBigAward or self._clickProcess >= self._needClickNum
end

function RedPacketRainStruct:getIconKey()
	return self._award.type .. "_" .. self._award.value
end

return RedPacketRainStruct
