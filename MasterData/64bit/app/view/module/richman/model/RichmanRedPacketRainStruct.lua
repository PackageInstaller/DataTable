local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local RichmanRedPacketRainStruct = class("RichmanRedPacketRainStruct")
local RedPacketRainConst = require("app.view.module.goldSaving.const.RedPacketRainConst")

function RichmanRedPacketRainStruct:ctor(arg_1_1)
	self._award = arg_1_1.award
	self._index = 0
	self._parameterIndex = arg_1_1.parameterIndex or RichmanConst.BIG_AWARD_POSITION
	self._startPos = arg_1_1.startPos
	self._isBigAward = checkbool(arg_1_1.isBigAward)

	if self._isBigAward then
		self._startPos = cc.p(display.width + 300, -300)
	end

	self._endPos = self:_setEndPos()
	self._clickProcess = 0
	self._needClickNum = arg_1_1.clickNum or 1
	self._rotation = self:_setRotation()
end

function RichmanRedPacketRainStruct:_setEndPos()
	local var_2_0 = cc.p(-display.width, display.height)
	local var_2_1 = cc.p(self._startPos.x + var_2_0.x, display.height + var_2_0.y)

	return (self._isBigAward or nil) and cc.p(-300, display.height + 300)
end

function RichmanRedPacketRainStruct:_setRotation()
	return 90 - math.deg(math.atan(display.height / display.width))
end

function RichmanRedPacketRainStruct:getRotation()
	return self._rotation
end

function RichmanRedPacketRainStruct:getIndex()
	return self._index
end

function RichmanRedPacketRainStruct:getAward()
	return self._award
end

function RichmanRedPacketRainStruct:getAwardSize()
	return self._award.size
end

function RichmanRedPacketRainStruct:getStartPosition()
	return self._startPos
end

function RichmanRedPacketRainStruct:getEndPosition()
	return self._endPos
end

function RichmanRedPacketRainStruct:getParameterIndex()
	return self._parameterIndex
end

function RichmanRedPacketRainStruct:isBigAward()
	return self._isBigAward
end

function RichmanRedPacketRainStruct:setIndex(arg_12_1)
	self._index = arg_12_1
end

function RichmanRedPacketRainStruct:addClickProcess()
	if self._isBigAward then
		self._clickProcess = self._clickProcess + 1
	end
end

function RichmanRedPacketRainStruct:getClickProcess()
	return self._clickProcess
end

function RichmanRedPacketRainStruct:isClickNumReachTarget()
	return not self._isBigAward or self._clickProcess >= self._needClickNum
end

function RichmanRedPacketRainStruct:getIconKey()
	return self._award.type .. "_" .. self._award.value
end

return RichmanRedPacketRainStruct
