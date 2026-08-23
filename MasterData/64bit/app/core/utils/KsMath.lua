local var_0_0 = {
	TRANS_ERROR_TIP = function()
		return config.DEBUG_VERSION and "未翻译" or ""
	end,
	calculateDistance = function(self, arg_2_1)
		return math.sqrt((arg_2_1.x - self.x) * (arg_2_1.x - self.x) + (arg_2_1.y - self.y) * (arg_2_1.y - self.y))
	end,
	calculateDistance2 = function(self, arg_3_1)
		return (arg_3_1.x - self.x) * (arg_3_1.x - self.x) + (arg_3_1.y - self.y) * (arg_3_1.y - self.y)
	end
}

function var_0_0.calculateDuration(arg_4_0, arg_4_1, arg_4_2)
	return var_0_0.calculateDistance(arg_4_0, arg_4_1) / arg_4_2
end

function var_0_0:normalizeLine()
	local var_5_0 = math.sqrt(self.x * self.x + self.y * self.y)

	if var_5_0 > 0 then
		self.x = self.x / var_5_0
		self.y = self.y / var_5_0
	end

	return self
end

function var_0_0:walkDistance(arg_6_1, arg_6_2)
	local var_6_0 = cc.p(arg_6_1.x - self.x, arg_6_1.y - self.y)

	var_0_0.normalizeLine(var_6_0)

	var_6_0.x = self.x + var_6_0.x * arg_6_2
	var_6_0.y = self.y + var_6_0.y * arg_6_2

	return var_6_0
end

function var_0_0:calculateRotation(arg_7_1)
	return -math.atan2(arg_7_1.y - self.y, arg_7_1.x - self.x) * 180 / math.pi
end

var_0_0.MIN_ZERO = 1e-05

function var_0_0.isZero(arg_8_0)
	return arg_8_0 > -var_0_0.MIN_ZERO and arg_8_0 < var_0_0.MIN_ZERO
end

function var_0_0.rangeIn(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 < arg_9_0 then
		return arg_9_2, true
	end

	if arg_9_0 < arg_9_1 then
		return arg_9_1, true
	end

	return arg_9_0, false
end

function var_0_0:rectIn(arg_10_1, arg_10_2, arg_10_3)
	return arg_10_2 >= math.abs(self.x - arg_10_1.x) and arg_10_3 >= math.abs(self.y - arg_10_1.y)
end

function var_0_0.arrayDelete(arg_11_0, arg_11_1)
	local var_11_0 = table.indexof(arg_11_0, arg_11_1)

	if var_11_0 then
		table.remove(arg_11_0, var_11_0)
	end
end

function var_0_0.randomNum(arg_12_0, arg_12_1)
	return math.random(arg_12_0, arg_12_1)
end

function var_0_0:shuffleArray()
	for iter_13_0 = #self, 1, -1 do
		local var_13_1 = var_0_0.randomNum(1, iter_13_0)

		if var_13_1 ~= iter_13_0 then
			self[var_13_1], self[iter_13_0] = self[iter_13_0], self[var_13_1]
		end
	end
end

function var_0_0.transitionNeedPlayOnce(arg_14_0)
	var_0_0._transOnce = var_0_0._transOnce or g.core.common.Storage:load(g.core.const.ConstMgr.UI_CONST.TRANS_PLAY_ONCE) or {}

	return not var_0_0._transOnce[arg_14_0]
end

function var_0_0.transitionPlayOnceSet(arg_15_0)
	var_0_0._transOnce = var_0_0._transOnce or g.core.common.Storage:load(g.core.const.ConstMgr.UI_CONST.TRANS_PLAY_ONCE) or {}
	var_0_0._transOnce[arg_15_0] = true

	g.core.common.Storage:save(g.core.const.ConstMgr.UI_CONST.TRANS_PLAY_ONCE, var_0_0._transOnce)
end

function var_0_0.debugTime(arg_16_0)
	return (os.date("%Y-%m-%d-%H:%M:%S", arg_16_0))
end

local var_0_1 = 10000

function var_0_0.coord2Unified(arg_17_0, arg_17_1)
	return tostring(arg_17_1 * var_0_1 + arg_17_0)
end

function var_0_0.unified2Coord(arg_18_0)
	return cc.p(arg_18_0 % var_0_1, (arg_18_0 - arg_18_0 % var_0_1) / var_0_1)
end

function var_0_0:IsSameCoord(arg_19_1)
	return self.x == arg_19_1.x and self.y == arg_19_1.y
end

local var_0_2 = 2

function var_0_0:countZOrder()
	return self.y * var_0_1 + self.x * var_0_2
end

function var_0_0:countPixZOrder()
	return math.floor((100 - self.y) * 10)
end

function var_0_0:mathCalculateDirection(arg_22_1)
	local var_22_0 = 0

	if arg_22_1.x - self.x > 0 then
		var_22_0 = 1
	elseif arg_22_1.x - self.x < 0 then
		var_22_0 = -1
	end

	return var_22_0
end

function var_0_0:mathCalculateDistance2(arg_23_1)
	if arg_23_1 == nil then
		arg_23_1 = cc.p(0, 0)
	end

	local var_23_0 = arg_23_1.x - self.x

	return var_23_0 * var_23_0 + (arg_23_1.y - self.y) * (arg_23_1.y - self.y)
end

function var_0_0.mathCalculateDistance(arg_24_0, arg_24_1)
	return math.sqrt(var_0_0.mathCalculateDistance2(arg_24_0, arg_24_1))
end

function var_0_0.mathCalculateDuration(arg_25_0, arg_25_1, arg_25_2)
	return var_0_0.mathCalculateDistance(arg_25_0, arg_25_1) / arg_25_2
end

function var_0_0:mathCalculateNormalize()
	local var_26_0 = math.sqrt(self.x * self.x + self.y * self.y)

	if var_26_0 > 0 then
		self.x = self.x / var_26_0
		self.y = self.y / var_26_0
	end

	return self
end

function var_0_0:mathCalculateRotation(arg_27_1)
	return -math.atan2(arg_27_1.y - self.y, arg_27_1.x - self.x) * 180 / math.pi
end

var_0_0.MATH_ZERO = 0.0005

function var_0_0.mathIsZero(arg_28_0)
	return math.abs(arg_28_0) < var_0_0.MATH_ZERO
end

function var_0_0:mathPointInRange(arg_29_1, arg_29_2, arg_29_3)
	if arg_29_2 == nil then
		arg_29_2 = var_0_0.MATH_ZERO
		arg_29_3 = var_0_0.MATH_ZERO
	elseif arg_29_3 == nil then
		arg_29_3 = arg_29_2
	end

	return arg_29_2 >= math.abs(self.x - arg_29_1.x) and arg_29_3 >= math.abs(self.y - arg_29_1.y)
end

function var_0_0.mathClampRange(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_2 < arg_30_0 then
		return arg_30_2
	end

	if arg_30_0 < arg_30_1 then
		return arg_30_1
	end

	return arg_30_0
end

function var_0_0.mathRepeat(arg_31_0, arg_31_1, arg_31_2)
	return arg_31_1 + (arg_31_0 - arg_31_1) % arg_31_2
end

function var_0_0:mathDot(arg_32_1)
	return self.x * arg_32_1.x + self.y * arg_32_1.y
end

function var_0_0:mathCross(arg_33_1)
	return self.x * arg_33_1.y - self.y * arg_33_1.x
end

function var_0_0.pointSub(arg_34_0, arg_34_1)
	return
end

function var_0_0:mathSegmentIntersect(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = cc.p(arg_35_1.x - self.x, arg_35_1.y - self.y)
	local var_35_1 = cc.p(arg_35_3.x - arg_35_2.x, arg_35_3.y - arg_35_2.y)
	local var_35_2 = var_0_0.mathCross(cc.p(arg_35_2.x - self.x, arg_35_2.y - self.y), var_35_1) / var_0_0.mathCross(var_35_0, var_35_1)
	local var_35_3 = var_0_0.mathCross(cc.p(self.x - arg_35_2.x, self.y - arg_35_2.y), var_35_0) / var_0_0.mathCross(var_35_1, var_35_0)

	if var_35_2 >= 0 and var_35_2 <= 1 and var_35_3 >= 0 and var_35_3 <= 1 then
		return cc.p(self.x + var_35_2 * var_35_0.x, self.y + var_35_2 * var_35_0.y)
	else
		return nil
	end
end

function var_0_0:mathSegmentInterCircle(arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = cc.p(arg_36_1.x - self.x, arg_36_1.y - self.y)
	local var_36_1 = math.sqrt(var_36_0.x * var_36_0.x + var_36_0.y * var_36_0.y)

	if var_0_0.mathIsZero(var_36_1) then
		return nil
	end

	var_36_0.x = var_36_0.x / var_36_1
	var_36_0.y = var_36_0.y / var_36_1

	local var_36_2 = cc.p(arg_36_2.x - self.x, arg_36_2.y - self.y)

	if arg_36_3 * arg_36_3 - (var_36_2.x * var_36_2.x + var_36_2.y * var_36_2.y) + (var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y) * (var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y) <= var_0_0.MATH_ZERO then
		return nil
	end

	local var_36_3
	local var_36_4 = math.sqrt(arg_36_3 * arg_36_3 - (var_36_2.x * var_36_2.x + var_36_2.y * var_36_2.y) + (var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y) * (var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y))

	if var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y - var_36_4 >= 0 and var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y - var_36_4 <= var_36_1 then
		var_36_3 = {}

		table.insert(var_36_3, cc.p(self.x + (var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y - var_36_4) * var_36_0.x, self.y + (var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y - var_36_4) * var_36_0.y))
	end

	local var_36_5 = var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y + var_36_4

	if var_36_2.x * var_36_0.x + var_36_2.y * var_36_0.y + var_36_4 >= 0 and var_36_5 <= var_36_1 then
		if var_36_3 == nil then
			var_36_3 = {}
		end

		table.insert(var_36_3, cc.p(self.x + var_36_5 * var_36_0.x, self.y + var_36_5 * var_36_0.y))
	end

	return var_36_3
end

function var_0_0.mathSphericalToCartesianCoord(arg_37_0, arg_37_1, arg_37_2)
	return cc.math.vec3(arg_37_2 * math.sin(arg_37_0 * 0.01745329252) * math.cos(arg_37_1 * 0.01745329252), arg_37_2 * math.sin(arg_37_0 * 0.01745329252) * math.sin(arg_37_1 * 0.01745329252), arg_37_2 * math.cos(arg_37_0 * 0.01745329252))
end

function var_0_0:mathCircleRoundPosition(arg_38_1, arg_38_2)
	return cc.p(self.x + arg_38_1 * math.cos(arg_38_2 * 0.01745329252), self.y + arg_38_1 * math.sin(arg_38_2 * 0.01745329252))
end

function var_0_0:mathBezierTrackTo(arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
	if arg_39_3 == nil then
		arg_39_3 = 0.3
	end

	if arg_39_5 == nil then
		arg_39_5 = 0.7
	end

	local var_39_0, var_39_1

	if arg_39_4 == nil then
		arg_39_4 = arg_39_2
		var_39_0 = var_0_0.mathCalculateNormalize((cc.p(-(arg_39_1.y - self.y), arg_39_1.x - self.x)))
		var_39_1 = {
			(cc.p((arg_39_1.x - self.x) * arg_39_3 + var_39_0.x * arg_39_2 + self.x, (arg_39_1.y - self.y) * arg_39_3 + var_39_0.y * arg_39_2 + self.y))
		}
	end

	var_39_1[2] = cc.p((arg_39_1.x - self.x) * arg_39_5 + var_39_0.x * arg_39_4 + self.x, (arg_39_1.y - self.y) * arg_39_5 + var_39_0.y * arg_39_4 + self.y)
	var_39_1[3] = arg_39_1

	return var_39_1
end

function var_0_0:isRectIntersect(arg_40_1)
	return math.abs(self.x - arg_40_1.x) < self.width + arg_40_1.width and math.abs(self.y - arg_40_1.y) < self.height + arg_40_1.height
end

function var_0_0.mathArrayDelete(arg_41_0, arg_41_1)
	local var_41_0 = table.indexof(arg_41_0, arg_41_1)

	if var_41_0 then
		table.remove(arg_41_0, var_41_0)
	end
end

function var_0_0.mathUnifiedCoordinate(arg_42_0, arg_42_1)
	return bit.bor(bit.lshift(arg_42_0, 16), bit.band(arg_42_1, 65535))
end

function var_0_0.mathCoordinateIndex(arg_43_0)
	return cc.p(bit.rshift(arg_43_0, 16), bit.rshift(bit.lshift(arg_43_0, 16), 16))
end

function var_0_0:mathCheckIsSameCoord(arg_44_1)
	return self.x == arg_44_1.x and self.y == arg_44_1.y
end

function var_0_0.mathBitSignCheck(arg_45_0, arg_45_1)
	return bit.band(arg_45_0, bit.lshift(1, arg_45_1)) ~= 0
end

function var_0_0.mathBitSignSet(arg_46_0, arg_46_1)
	return bit.bor(arg_46_0, bit.lshift(1, arg_46_1))
end

function var_0_0.mathBitSignDel(arg_47_0, arg_47_1)
	return bit.band(arg_47_0, bit.bnot(bit.lshift(1, arg_47_1)))
end

return var_0_0
