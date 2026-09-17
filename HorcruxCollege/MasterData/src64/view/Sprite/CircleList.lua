local CircleList = class("CircleList", function()
	return ccui.Layout:create()
end)
local var_0_1 = 7
local var_0_2 = 640
local var_0_3 = 210
local var_0_4 = 3.1415926

function CircleList:create(arg_2_1)
	local var_2_0 = CircleList.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function CircleList:ctor()
	self._r = 0
	self._perimeter = 0
	self._perAngle = 0
	self._totalChildren = 0
	self._gap = 0
	self._initx = 0
	self._visibleNum = 0
	self._visualDomain = nil
	self._isHasFakeNode = false
	self._controlPoint = 0
end

function CircleList:init(arg_4_1)
	self:initPara(arg_4_1)
end

function CircleList:initPara(arg_5_1)
	self:setTotalNum(arg_5_1)
	self:setPerimeter()
	self:setVisualDomain()

	self._r = self._perimeter / (2 * var_0_4)
end

function CircleList:setTotalNum(arg_6_1)
	local var_6_0 = arg_6_1

	if arg_6_1 % 2 == 0 and arg_6_1 > math.floor(var_0_2 / var_0_3) then
		if arg_6_1 < var_0_1 then
			self._isHasFakeNode = true
			var_6_0 = arg_6_1 + 1
		else
			self._isHasFakeNode = false
		end
	else
		self._isHasFakeNode = false
	end

	if arg_6_1 == 2 then
		var_6_0 = 3
		self._isHasFakeNode = true
	end

	self._totalChildren = var_6_0
	self._perAngle = 2 * var_0_4 / var_6_0
end

function CircleList:setPerimeter()
	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = 0
	local var_7_4 = math.floor(var_0_2 / var_0_3)

	if self._totalChildren >= var_0_1 + 2 then
		var_7_1 = (var_0_2 - var_0_3) / (var_0_1 - 1)
		var_7_0 = (var_0_2 - var_0_3) / (var_0_1 - 1) * (self._totalChildren - 1) + var_0_3
		var_7_2 = var_0_1
	elseif self._totalChildren <= var_7_4 then
		var_7_0 = var_0_2
		var_7_1 = 180
		var_7_2 = self._totalChildren
	else
		var_7_1 = var_0_2 / (self._totalChildren - 1)
		var_7_0 = var_0_2 / (self._totalChildren - 1) * (self._totalChildren - 1) + var_0_3
		var_7_2 = self._totalChildren
	end

	self._gap = var_7_1
	self._visibleNum = var_7_2
	self._initx = var_0_2 / 2 - var_0_3 / 2 - (math.floor(self._totalChildren / 2 + 0.5) - 1) * var_7_1
	self._perimeter = self._totalChildren <= var_7_4 and var_7_0 - self._initx * 2 or var_7_0

	print("self.initx ====== ", self._initx)
end

function CircleList:setVisualDomain()
	self._visualDomain = self:createDefineDomain(0, var_0_2)
end

function CircleList:getEnablePara()
	return {
		initX = self._initx,
		perimeter = self._perimeter,
		visibleNum = self._visibleNum,
		visualDomain = self._visualDomain
	}
end

function CircleList:getInitX()
	return self._initx
end

function CircleList:getPerimeter()
	return self._perimeter
end

function CircleList:getGap()
	return self._gap
end

function CircleList:getControlPoint()
	return self._controlPoint
end

function CircleList:checkIsHasFakeNode()
	return self._isHasFakeNode
end

function CircleList:moveControlPoint(arg_15_1)
	self._controlPoint = self._controlPoint + arg_15_1

	if self._controlPoint == 0 then
		return 0
	else
		local var_15_0 = math.abs(self._controlPoint) / self._controlPoint

		return self._controlPoint - var_15_0 * math.floor(math.abs(self._controlPoint + var_15_0 * self._gap / 2) / self._gap) * self._gap
	end
end

function CircleList:getControlPointNeedDis(arg_16_1, arg_16_2)
	return math.floor(math.abs(self._controlPoint + arg_16_2) / self._gap + 0.5) * self._gap * arg_16_1 - self._controlPoint
end

function CircleList:resetControlPoint()
	self._controlPoint = 0
end

function CircleList:createDefineDomain(arg_18_1, arg_18_2)
	return {
		min = arg_18_1,
		max = arg_18_2
	}
end

function CircleList:reset(arg_19_1)
	self:initPara(arg_19_1)
end

function CircleList:getCellWidth()
	return var_0_3
end

return CircleList
