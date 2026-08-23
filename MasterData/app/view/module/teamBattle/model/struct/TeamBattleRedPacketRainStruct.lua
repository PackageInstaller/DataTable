local TeamBattleRedPacketRainStruct = class("TeamBattleRedPacketRainStruct")
local var_0_1 = require("app.view.module.teamBattle.const.TeamBattleConst").GAME

function TeamBattleRedPacketRainStruct:ctor(arg_1_1)
	self._award = arg_1_1.award
	self._index = 0
	self._parameterIndex = arg_1_1.parameterIndex or var_0_1.BIG_AWARD_POSITION
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

function TeamBattleRedPacketRainStruct:_setEndPos()
	local var_2_0 = cc.p(self._startPos.x, display.height + 300)

	return (self._isBigAward or nil) and cc.p(-300, display.height + 300)
end

function TeamBattleRedPacketRainStruct:_setRotation()
	return 90 - math.deg(math.atan(display.height / display.width))
end

function TeamBattleRedPacketRainStruct:getRotation()
	if self._isBigAward then
		return 90 - math.deg(math.atan(display.height / display.width))
	end

	return 0
end

function TeamBattleRedPacketRainStruct:getIndex()
	return self._index
end

function TeamBattleRedPacketRainStruct:getAward()
	return self._award
end

function TeamBattleRedPacketRainStruct:getAwardSize()
	return self._award.size
end

function TeamBattleRedPacketRainStruct:getStartPosition()
	return self._startPos
end

function TeamBattleRedPacketRainStruct:getEndPosition()
	return self._endPos
end

function TeamBattleRedPacketRainStruct:getParameterIndex()
	return self._parameterIndex
end

function TeamBattleRedPacketRainStruct:isBigAward()
	return self._isBigAward
end

function TeamBattleRedPacketRainStruct:setIndex(arg_12_1)
	self._index = arg_12_1
end

function TeamBattleRedPacketRainStruct:addClickProcess()
	if self._isBigAward then
		self._clickProcess = self._clickProcess + 1
	end
end

function TeamBattleRedPacketRainStruct:getClickProcess()
	return self._clickProcess
end

function TeamBattleRedPacketRainStruct:isClickNumReachTarget()
	return not self._isBigAward or self._clickProcess >= self._needClickNum
end

function TeamBattleRedPacketRainStruct:getIconKey()
	return self._award.type .. "_" .. self._award.value
end

return TeamBattleRedPacketRainStruct
