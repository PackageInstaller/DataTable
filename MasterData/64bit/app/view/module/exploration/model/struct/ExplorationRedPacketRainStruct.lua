local ExplorationRedPacketRainStruct = class("ExplorationRedPacketRainStruct")
local RedPacketRainConst = require("app.view.module.goldSaving.const.RedPacketRainConst")

function ExplorationRedPacketRainStruct:ctor(arg_1_1)
	self._award = arg_1_1.award
	self._index = 0
	self._parameterIndex = arg_1_1.parameterIndex or RedPacketRainConst.BIG_AWARD_POSITION
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

function ExplorationRedPacketRainStruct:_setEndPos()
	local var_2_0 = cc.p(-display.width, display.height)
	local var_2_1 = cc.p(self._startPos.x + var_2_0.x, display.height + var_2_0.y)

	return (self._isBigAward or nil) and cc.p(-300, display.height + 300)
end

function ExplorationRedPacketRainStruct:_setRotation()
	return 90 - math.deg(math.atan(display.height / display.width))
end

function ExplorationRedPacketRainStruct:getRotation()
	return self._rotation
end

function ExplorationRedPacketRainStruct:getIndex()
	return self._index
end

function ExplorationRedPacketRainStruct:getAward()
	return self._award
end

function ExplorationRedPacketRainStruct:getAwardSize()
	return self._award.size
end

function ExplorationRedPacketRainStruct:getStartPosition()
	return self._startPos
end

function ExplorationRedPacketRainStruct:getEndPosition()
	return self._endPos
end

function ExplorationRedPacketRainStruct:getParameterIndex()
	return self._parameterIndex
end

function ExplorationRedPacketRainStruct:isBigAward()
	return self._isBigAward
end

function ExplorationRedPacketRainStruct:setIndex(arg_12_1)
	self._index = arg_12_1
end

function ExplorationRedPacketRainStruct:addClickProcess()
	if self._isBigAward then
		self._clickProcess = self._clickProcess + 1
	end
end

function ExplorationRedPacketRainStruct:getClickProcess()
	return self._clickProcess
end

function ExplorationRedPacketRainStruct:isClickNumReachTarget()
	return not self._isBigAward or self._clickProcess >= self._needClickNum
end

function ExplorationRedPacketRainStruct:getIconKey()
	return self._award.type .. "_" .. self._award.value
end

return ExplorationRedPacketRainStruct
