local var_0_0 = {
	_VERSION = "bump v3.1.7",
	_DESCRIPTION = "A collision detection library for Lua",
	_URL = "https://github.com/kikito/bump.lua",
	_LICENSE = "    MIT LICENSE\n\n    Copyright (c) 2014 Enrique García Cota\n\n    Permission is hereby granted, free of charge, to any person obtaining a\n    copy of this software and associated documentation files (the\n    \"Software\"), to deal in the Software without restriction, including\n    without limitation the rights to use, copy, modify, merge, publish,\n    distribute, sublicense, and/or sell copies of the Software, and to\n    permit persons to whom the Software is furnished to do so, subject to\n    the following conditions:\n\n    The above copyright notice and this permission notice shall be included\n    in all copies or substantial portions of the Software.\n\n    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n  "
}
local var_0_1 = 1e-10
local var_0_2 = math.abs
local var_0_3 = math.floor
local var_0_4 = math.ceil
local var_0_5 = math.min
local var_0_6 = math.max

local function var_0_7(arg_1_0)
	if arg_1_0 > 0 then
		return 1
	end

	if arg_1_0 == 0 then
		return 0
	end

	return -1
end

local function var_0_8(arg_2_0, arg_2_1, arg_2_2)
	if var_0_2(arg_2_1 - arg_2_0) < var_0_2(arg_2_2 - arg_2_0) then
		return arg_2_1
	else
		return arg_2_2
	end
end

local function var_0_9(arg_3_0, arg_3_1, arg_3_2)
	if type(arg_3_1) ~= arg_3_0 then
		error(arg_3_2 .. " must be a " .. arg_3_0 .. ", but was " .. tostring(arg_3_1) .. "(a " .. type(arg_3_1) .. ")")
	end
end

local function var_0_10(arg_4_0, arg_4_1)
	if type(arg_4_0) ~= "number" or arg_4_0 <= 0 then
		error(arg_4_1 .. " must be a positive integer, but was " .. tostring(arg_4_0) .. "(" .. type(arg_4_0) .. ")")
	end
end

local function var_0_11(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_9("number", arg_5_0, "x")
	var_0_9("number", arg_5_1, "y")
	var_0_10(arg_5_2, "w")
	var_0_10(arg_5_3, "h")
end

local function var_0_12()
	return "slide"
end

local function var_0_13(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	return var_0_8(arg_7_4, arg_7_0, arg_7_0 + arg_7_2), var_0_8(arg_7_5, arg_7_1, arg_7_1 + arg_7_3)
end

local function var_0_14(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8, arg_8_9)
	arg_8_8, arg_8_9 = arg_8_8 or 0, arg_8_9 or 1

	local var_8_0
	local var_8_1
	local var_8_2 = 0
	local var_8_3 = 0
	local var_8_4 = 0
	local var_8_5 = 0
	local var_8_6
	local var_8_7

	for iter_8_0 = 1, 4 do
		if iter_8_0 == 1 then
			var_8_7 = arg_8_4 - arg_8_0
			var_8_6 = -(arg_8_6 - arg_8_4)
			var_8_1 = 0
			var_8_0 = -1
		elseif iter_8_0 == 2 then
			var_8_7 = arg_8_0 + arg_8_2 - arg_8_4
			var_8_6 = arg_8_6 - arg_8_4
			var_8_1 = 0
			var_8_0 = 1
		elseif iter_8_0 == 3 then
			var_8_7 = arg_8_5 - arg_8_1
			var_8_6 = -(arg_8_7 - arg_8_5)
			var_8_1 = -1
			var_8_0 = 0
		else
			var_8_7 = arg_8_1 + arg_8_3 - arg_8_5
			var_8_6 = arg_8_7 - arg_8_5
			var_8_1 = 1
			var_8_0 = 0
		end

		if var_8_6 == 0 then
			if var_8_7 <= 0 then
				return nil
			end
		else
			local var_8_9 = var_8_7 / var_8_6

			if var_8_6 < 0 then
				if arg_8_9 < var_8_9 then
					return nil
				elseif arg_8_8 < var_8_9 then
					var_8_3 = var_8_1
					var_8_2 = var_8_0
					arg_8_8 = var_8_9
				end
			elseif var_8_9 < arg_8_8 then
				return nil
			elseif var_8_9 < arg_8_9 then
				var_8_5 = var_8_1
				var_8_4 = var_8_0
				arg_8_9 = var_8_9
			end
		end
	end

	return arg_8_8, arg_8_9, var_8_2, var_8_3, var_8_4, var_8_5
end

local function var_0_15(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
	return arg_9_4 - arg_9_0 - arg_9_2, arg_9_5 - arg_9_1 - arg_9_3, arg_9_2 + arg_9_6, arg_9_3 + arg_9_7
end

local function var_0_16(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	return arg_10_4 - arg_10_0 > var_0_1 and arg_10_5 - arg_10_1 > var_0_1 and arg_10_0 + arg_10_2 - arg_10_4 > var_0_1 and arg_10_1 + arg_10_3 - arg_10_5 > var_0_1
end

local function var_0_17(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	return arg_11_0 < arg_11_4 + arg_11_6 and arg_11_4 < arg_11_0 + arg_11_2 and arg_11_1 < arg_11_5 + arg_11_7 and arg_11_5 < arg_11_1 + arg_11_3
end

local function var_0_18(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7)
	return (arg_12_0 - arg_12_4 + (arg_12_2 - arg_12_6) / 2) * (arg_12_0 - arg_12_4 + (arg_12_2 - arg_12_6) / 2) + (arg_12_1 - arg_12_5 + (arg_12_3 - arg_12_7) / 2) * (arg_12_1 - arg_12_5 + (arg_12_3 - arg_12_7) / 2)
end

local function var_0_19(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7, arg_13_8, arg_13_9)
	arg_13_8 = arg_13_8 or arg_13_0
	arg_13_9 = arg_13_9 or arg_13_1

	local var_13_0 = arg_13_8 - arg_13_0
	local var_13_1 = arg_13_9 - arg_13_1
	local var_13_2, var_13_3, var_13_4, var_13_5 = var_0_15(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7)
	local var_13_6
	local var_13_7
	local var_13_8
	local var_13_9
	local var_13_12, var_13_13, var_13_14, var_13_15 = var_0_14(var_13_2, var_13_3, var_13_4, var_13_5, 0, 0, var_13_0, var_13_1, -math.huge, math.huge)

	if var_0_16(var_13_2, var_13_3, var_13_4, var_13_5, 0, 0) then
		local var_13_10, var_13_11 = var_0_13(var_13_2, var_13_3, var_13_4, var_13_5, 0, 0)

		var_13_7 = -var_0_5(arg_13_2, var_0_2(var_13_10)) * var_0_5(arg_13_3, var_0_2(var_13_11))
		var_13_6 = true
	end

	if var_13_12 and var_13_12 < 1 and var_0_2(var_13_12 - var_13_13) >= var_0_1 then
		if var_13_12 + var_0_1 <= 0 then
			if var_13_12 == 0 and var_13_13 > 0 then
				var_13_9 = var_13_15
				var_13_8 = var_13_14
				var_13_7 = var_13_12
				var_13_6 = false
			end

			if not var_13_7 then
				return
			end
		end
	end

	local var_13_16
	local var_13_17

	if var_13_6 then
		if var_13_0 == 0 and var_13_1 == 0 then
			local var_13_18, var_13_19 = var_0_13(var_13_2, var_13_3, var_13_4, var_13_5, 0, 0)

			if var_0_2(var_13_18) < var_0_2(var_13_19) then
				var_13_19 = 0
			else
				var_13_18 = 0
				var_13_9 = var_0_7(var_13_19)
			end

			var_13_8 = var_0_7(var_13_18)
			var_13_17 = arg_13_1 + var_13_19
			var_13_16 = arg_13_0 + var_13_18
		else
			local var_13_22, var_13_23

			var_13_22, var_13_23, var_13_8, var_13_9 = var_0_14(var_13_2, var_13_3, var_13_4, var_13_5, 0, 0, var_13_0, var_13_1, -math.huge, 1)

			if not var_13_22 then
				do return end

				var_13_17 = arg_13_1 + var_13_1 * var_13_22
			end

			var_13_16 = arg_13_0 + var_13_0 * var_13_22
		end
	else
		var_13_17 = arg_13_1 + var_13_1 * var_13_7
		var_13_16 = arg_13_0 + var_13_0 * var_13_7
	end

	return {
		overlaps = var_13_6,
		ti = var_13_7,
		move = {
			x = var_13_0,
			y = var_13_1
		},
		normal = {
			x = var_13_8,
			y = var_13_9
		},
		touch = {
			x = var_13_16,
			y = var_13_17
		},
		itemRect = {
			x = arg_13_0,
			y = arg_13_1,
			w = arg_13_2,
			h = arg_13_3
		},
		otherRect = {
			x = arg_13_4,
			y = arg_13_5,
			w = arg_13_6,
			h = arg_13_7
		}
	}
end

local function var_0_20(arg_14_0, arg_14_1, arg_14_2)
	return (arg_14_1 - 1) * arg_14_0, (arg_14_2 - 1) * arg_14_0
end

local function var_0_21(arg_15_0, arg_15_1, arg_15_2)
	return var_0_3(arg_15_1 / arg_15_0) + 1, var_0_3(arg_15_2 / arg_15_0) + 1
end

local function var_0_22(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_3 - arg_16_2 > 0 then
		return 1, arg_16_0 / (arg_16_3 - arg_16_2), ((arg_16_1 + (arg_16_3 - arg_16_2)) * arg_16_0 - arg_16_2) / (arg_16_3 - arg_16_2)
	elseif arg_16_3 - arg_16_2 < 0 then
		return -1, -arg_16_0 / (arg_16_3 - arg_16_2), ((arg_16_1 + (arg_16_3 - arg_16_2) - 1) * arg_16_0 - arg_16_2) / (arg_16_3 - arg_16_2)
	else
		return 0, math.huge, math.huge
	end
end

local function var_0_23(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0, var_17_1 = var_0_21(arg_17_0, arg_17_1, arg_17_2)
	local var_17_2, var_17_3 = var_0_21(arg_17_0, arg_17_3, arg_17_4)
	local var_17_4, var_17_5, var_17_6 = var_0_22(arg_17_0, var_17_0, arg_17_1, arg_17_3)
	local var_17_7, var_17_8, var_17_9 = var_0_22(arg_17_0, var_17_1, arg_17_2, arg_17_4)
	local var_17_10 = var_17_0
	local var_17_11 = var_17_1

	arg_17_5(var_17_0, var_17_1)

	while var_0_2(var_17_10 - var_17_2) + var_0_2(var_17_11 - var_17_3) > 1 do
		if var_17_6 < var_17_9 then
			var_17_10 = var_17_10 + var_17_4
			var_17_6 = var_17_6 + var_17_5

			arg_17_5(var_17_10, var_17_11)
		else
			if var_17_6 == var_17_9 then
				arg_17_5(var_17_10 + var_17_4, var_17_11)

				var_17_11 = var_17_11 + var_17_7
			end

			var_17_9 = var_17_9 + var_17_8

			arg_17_5(var_17_10, var_17_11)
		end
	end

	if var_17_10 ~= var_17_2 or var_17_11 ~= var_17_3 then
		arg_17_5(var_17_2, var_17_3)
	end
end

local function var_0_24(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0, var_18_1 = var_0_21(arg_18_0, arg_18_1, arg_18_2)

	return var_18_0, var_18_1, var_0_4((arg_18_1 + arg_18_3) / arg_18_0) - var_18_0 + 1, var_0_4((arg_18_2 + arg_18_4) / arg_18_0) - var_18_1 + 1
end

local function var_0_25(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7, arg_19_8)
	return arg_19_1.touch.x, arg_19_1.touch.y, {}, 0
end

local function var_0_26(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7, arg_20_8)
	local var_20_0, var_20_1 = arg_20_0:project(arg_20_1.item, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7, arg_20_8)

	return arg_20_6, arg_20_7, var_20_0, var_20_1
end

local function var_0_27(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8)
	arg_21_6 = arg_21_6 or arg_21_2
	arg_21_7 = arg_21_7 or arg_21_3

	local var_21_0 = arg_21_1.touch

	if arg_21_1.move.x ~= 0 or arg_21_1.move.y ~= 0 then
		if arg_21_1.normal.x ~= 0 then
			arg_21_6 = var_21_0.x
		else
			arg_21_7 = var_21_0.y
		end
	end

	arg_21_1.slide = {
		x = arg_21_6,
		y = arg_21_7
	}
	arg_21_3 = var_21_0.y
	arg_21_2 = var_21_0.x

	local var_21_1, var_21_2 = arg_21_0:project(arg_21_1.item, var_21_0.x, var_21_0.y, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8)

	return arg_21_6, arg_21_7, var_21_1, var_21_2
end

local function var_0_28(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8)
	arg_22_6 = arg_22_6 or arg_22_2
	arg_22_7 = arg_22_7 or arg_22_3

	local var_22_0 = arg_22_1.touch
	local var_22_1 = arg_22_1.touch.x
	local var_22_2 = arg_22_1.touch.y
	local var_22_3 = arg_22_1.touch.x
	local var_22_4 = arg_22_1.touch.y

	if arg_22_1.move.x ~= 0 or arg_22_1.move.y ~= 0 then
		local var_22_5 = arg_22_6 - var_22_1
		local var_22_6 = arg_22_7 - var_22_2

		if arg_22_1.normal.x == 0 then
			var_22_6 = -var_22_6
		else
			var_22_5 = -var_22_5
			var_22_4 = var_22_2 + var_22_6
		end

		var_22_3 = var_22_1 + var_22_5
	end

	arg_22_1.bounce = {
		x = var_22_3,
		y = var_22_4
	}
	arg_22_3 = var_22_0.y
	arg_22_2 = var_22_0.x
	arg_22_7 = var_22_4
	arg_22_6 = var_22_3

	local var_22_7, var_22_8 = arg_22_0:project(arg_22_1.item, var_22_0.x, var_22_0.y, arg_22_4, arg_22_5, var_22_3, var_22_4, arg_22_8)

	return arg_22_6, arg_22_7, var_22_7, var_22_8
end

local var_0_29 = {}
local var_0_30 = {
	__index = var_0_29
}

local function var_0_31(arg_23_0, arg_23_1)
	return arg_23_0.weight < arg_23_1.weight
end

local function var_0_32(arg_24_0, arg_24_1)
	if arg_24_0.ti == arg_24_1.ti then
		return var_0_18(arg_24_0.itemRect.x, arg_24_0.itemRect.y, arg_24_0.itemRect.w, arg_24_0.itemRect.h, arg_24_0.otherRect.x, arg_24_0.otherRect.y, arg_24_0.otherRect.w, arg_24_0.otherRect.h) < var_0_18(arg_24_0.itemRect.x, arg_24_0.itemRect.y, arg_24_0.itemRect.w, arg_24_0.itemRect.h, arg_24_1.otherRect.x, arg_24_1.otherRect.y, arg_24_1.otherRect.w, arg_24_1.otherRect.h)
	end

	return arg_24_0.ti < arg_24_1.ti
end

local function var_0_33(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0.rows[arg_25_3] = arg_25_0.rows[arg_25_3] or setmetatable({}, {
		__mode = "v"
	})
	arg_25_0.rows[arg_25_3][arg_25_2] = arg_25_0.rows[arg_25_3][arg_25_2] or {
		itemCount = 0,
		x = arg_25_2,
		y = arg_25_3,
		items = setmetatable({}, {
			__mode = "k"
		})
	}
	arg_25_0.nonEmptyCells[arg_25_0.rows[arg_25_3][arg_25_2]] = true

	if not arg_25_0.rows[arg_25_3][arg_25_2].items[arg_25_1] then
		arg_25_0.rows[arg_25_3][arg_25_2].items[arg_25_1] = true
		arg_25_0.rows[arg_25_3][arg_25_2].itemCount = arg_25_0.rows[arg_25_3][arg_25_2].itemCount + 1
	end
end

local function var_0_34(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if not arg_26_0.rows[arg_26_3] or not arg_26_0.rows[arg_26_3][arg_26_2] or not arg_26_0.rows[arg_26_3][arg_26_2].items[arg_26_1] then
		return false
	end

	local var_26_0 = arg_26_0.rows[arg_26_3][arg_26_2]

	arg_26_0.rows[arg_26_3][arg_26_2].items[arg_26_1] = nil
	var_26_0.itemCount = var_26_0.itemCount - 1

	if var_26_0.itemCount == 0 then
		arg_26_0.nonEmptyCells[var_26_0] = nil
	end

	return true
end

local function var_0_35(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = {}

	for iter_27_0 = arg_27_2, arg_27_2 + arg_27_4 - 1 do
		if arg_27_0.rows[iter_27_0] then
			for iter_27_1 = arg_27_1, arg_27_1 + arg_27_3 - 1 do
				if arg_27_0.rows[iter_27_0][iter_27_1] and arg_27_0.rows[iter_27_0][iter_27_1].itemCount > 0 then
					for iter_27_2, iter_27_3 in pairs(arg_27_0.rows[iter_27_0][iter_27_1].items) do
						var_27_0[iter_27_2] = true
					end
				end
			end
		end
	end

	return var_27_0
end

local function var_0_36(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = {}
	local var_28_1 = 0
	local var_28_2 = {}

	var_0_23(arg_28_0.cellSize, arg_28_1, arg_28_2, arg_28_3, arg_28_4, function(arg_29_0, arg_29_1)
		if not arg_28_0.rows[arg_29_1] then
			return
		end

		local var_29_0 = arg_28_0.rows[arg_29_1][arg_29_0]

		if not arg_28_0.rows[arg_29_1][arg_29_0] or var_28_2[var_29_0] then
			return
		end

		var_28_2[var_29_0] = true
		var_28_1 = var_28_1 + 1
		var_28_0[var_28_1] = var_29_0
	end)

	return var_28_0, 0
end

local function var_0_37(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
	local var_30_0, var_30_1 = var_0_36(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	local var_30_12 = {}
	local var_30_13 = {}
	local var_30_14 = 0

	for iter_30_0 = 1, var_30_1 do
		for iter_30_1 in pairs(var_30_0[iter_30_0].items) do
			if not var_30_12[iter_30_1] then
				var_30_12[iter_30_1] = true

				if arg_30_5 then
					if arg_30_5(iter_30_1) then
						local var_30_15 = arg_30_0.rects[iter_30_1].h
						local var_30_16 = arg_30_0.rects[iter_30_1].w
						local var_30_17 = arg_30_0.rects[iter_30_1].y
						local var_30_18 = arg_30_0.rects[iter_30_1].x
						local var_30_19, var_30_20 = var_0_14(arg_30_0.rects[iter_30_1].x, arg_30_0.rects[iter_30_1].y, arg_30_0.rects[iter_30_1].w, arg_30_0.rects[iter_30_1].h, arg_30_1, arg_30_2, arg_30_3, arg_30_4, 0, 1)

						if var_30_19 and (var_30_19 > 0 and var_30_19 < 1 or var_30_20 > 0 and var_30_20 < 1) then
							local var_30_21, var_30_22 = var_0_14(var_30_18, var_30_17, var_30_16, var_30_15, arg_30_1, arg_30_2, arg_30_3, arg_30_4, -math.huge, math.huge)

							var_30_14 = var_30_14 + 1

							local var_30_23 = {
								item = iter_30_1,
								ti1 = var_30_19,
								ti2 = var_30_20
							}

							var_30_23.weight = var_0_5(var_30_21, var_30_22)
							var_30_13[var_30_14] = var_30_23
						end
					end
				end
			end
		end
	end

	table.sort(var_30_13, var_0_31)

	return var_30_13, var_30_14
end

local function var_0_38(arg_31_0, arg_31_1)
	if not arg_31_0.responses[arg_31_1] then
		error(("Unknown collision type: %s (%s)"):format(arg_31_1, type(arg_31_1)))
	end

	return arg_31_0.responses[arg_31_1]
end

function var_0_29:addResponse(arg_32_1, arg_32_2)
	self.responses[arg_32_1] = arg_32_2
end

function var_0_29:project(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6, arg_33_7, arg_33_8)
	var_0_11(arg_33_2, arg_33_3, arg_33_4, arg_33_5)

	arg_33_6 = arg_33_6 or arg_33_2
	arg_33_7 = arg_33_7 or arg_33_3
	arg_33_8 = arg_33_8 or var_0_12

	local var_33_0 = {}
	local var_33_1 = 0
	local var_33_2 = {}

	if arg_33_1 ~= nil then
		var_33_2[arg_33_1] = true
	end

	local var_33_3 = var_0_5(arg_33_6, arg_33_2)
	local var_33_4 = var_0_5(arg_33_7, arg_33_3)
	local var_33_5, var_33_6, var_33_7, var_33_8 = var_0_24(self.cellSize, var_33_3, var_33_4, var_0_6(arg_33_6 + arg_33_4, arg_33_2 + arg_33_4) - var_33_3, var_0_6(arg_33_7 + arg_33_5, arg_33_3 + arg_33_5) - var_33_4)

	for iter_33_0, iter_33_1 in pairs((var_0_35(self, var_33_5, var_33_6, var_33_7, var_33_8))) do
		if not var_33_2[iter_33_0] then
			var_33_2[iter_33_0] = true

			local var_33_9 = arg_33_8(arg_33_1, iter_33_0)

			if var_33_9 then
				local var_33_10, var_33_11, var_33_12, var_33_13 = self:getRect(iter_33_0)
				local var_33_14 = var_0_19(arg_33_2, arg_33_3, arg_33_4, arg_33_5, var_33_10, var_33_11, var_33_12, var_33_13, arg_33_6, arg_33_7)

				if var_33_14 then
					var_33_14.other = iter_33_0
					var_33_14.item = arg_33_1
					var_33_14.type = var_33_9
					var_33_1 = var_33_1 + 1
					var_33_0[var_33_1] = var_33_14
				end
			end
		end
	end

	table.sort(var_33_0, var_0_32)

	return var_33_0, var_33_1
end

function var_0_29:countCells()
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in pairs(self.rows) do
		for iter_34_2, iter_34_3 in pairs(iter_34_1) do
			var_34_0 = var_34_0 + 1
		end
	end

	return var_34_0
end

function var_0_29:hasItem(arg_35_1)
	return not not self.rects[arg_35_1]
end

function var_0_29:getItems()
	local var_36_0 = {}
	local var_36_1 = 0

	for iter_36_0, iter_36_1 in pairs(self.rects) do
		var_36_1 = var_36_1 + 1
		var_36_0[var_36_1] = iter_36_0
	end

	return var_36_0, var_36_1
end

function var_0_29:countItems()
	local var_37_0 = 0

	for iter_37_0 in pairs(self.rects) do
		var_37_0 = var_37_0 + 1
	end

	return var_37_0
end

function var_0_29:getRect(arg_38_1)
	if not self.rects[arg_38_1] then
		error("Item " .. tostring(arg_38_1) .. " must be added to the world before getting its rect. Use world:add(item, x,y,w,h) to add it first.")
	end

	return self.rects[arg_38_1].x, self.rects[arg_38_1].y, self.rects[arg_38_1].w, self.rects[arg_38_1].h
end

function var_0_29:toWorld(arg_39_1, arg_39_2)
	return var_0_20(self.cellSize, arg_39_1, arg_39_2)
end

function var_0_29:toCell(arg_40_1, arg_40_2)
	return var_0_21(self.cellSize, arg_40_1, arg_40_2)
end

function var_0_29:queryRect(arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	var_0_11(arg_41_1, arg_41_2, arg_41_3, arg_41_4)

	local var_41_0, var_41_1, var_41_2, var_41_3 = var_0_24(self.cellSize, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_4 = {}
	local var_41_5 = 0

	for iter_41_0, iter_41_1 in pairs((var_0_35(self, var_41_0, var_41_1, var_41_2, var_41_3))) do
		if (not arg_41_5 or arg_41_5(iter_41_0)) and var_0_17(arg_41_1, arg_41_2, arg_41_3, arg_41_4, self.rects[iter_41_0].x, self.rects[iter_41_0].y, self.rects[iter_41_0].w, self.rects[iter_41_0].h) then
			var_41_5 = var_41_5 + 1
			var_41_4[var_41_5] = iter_41_0
		end
	end

	return var_41_4, var_41_5
end

function var_0_29:queryPoint(arg_42_1, arg_42_2, arg_42_3)
	local var_42_0, var_42_1 = self:toCell(arg_42_1, arg_42_2)
	local var_42_2 = {}
	local var_42_3 = 0

	for iter_42_0, iter_42_1 in pairs((var_0_35(self, var_42_0, var_42_1, 1, 1))) do
		if (not arg_42_3 or arg_42_3(iter_42_0)) and var_0_16(self.rects[iter_42_0].x, self.rects[iter_42_0].y, self.rects[iter_42_0].w, self.rects[iter_42_0].h, arg_42_1, arg_42_2) then
			var_42_3 = var_42_3 + 1
			var_42_2[var_42_3] = iter_42_0
		end
	end

	return var_42_2, var_42_3
end

function var_0_29.querySegment(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	local var_43_0, var_43_1 = var_0_37(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	local var_43_2 = {}

	for iter_43_0 = 1, var_43_1 do
		var_43_2[iter_43_0] = var_43_0[iter_43_0].item
	end

	return var_43_2, var_43_1
end

function var_0_29.querySegmentWithCoords(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	local var_44_0, var_44_1 = var_0_37(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)

	for iter_44_0 = 1, var_44_1 do
		var_44_0[iter_44_0].weight = nil
		var_44_0[iter_44_0].x1 = arg_44_1 + (arg_44_3 - arg_44_1) * var_44_0[iter_44_0].ti1
		var_44_0[iter_44_0].y1 = arg_44_2 + (arg_44_4 - arg_44_2) * var_44_0[iter_44_0].ti1
		var_44_0[iter_44_0].x2 = arg_44_1 + (arg_44_3 - arg_44_1) * var_44_0[iter_44_0].ti2
		var_44_0[iter_44_0].y2 = arg_44_2 + (arg_44_4 - arg_44_2) * var_44_0[iter_44_0].ti2
	end

	return var_44_0, var_44_1
end

function var_0_29:add(arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	if self.rects[arg_45_1] then
		error("Item " .. tostring(arg_45_1) .. " added to the world twice.")
	end

	var_0_11(arg_45_2, arg_45_3, arg_45_4, arg_45_5)

	self.rects[arg_45_1] = {
		x = arg_45_2,
		y = arg_45_3,
		w = arg_45_4,
		h = arg_45_5
	}

	local var_45_0, var_45_1, var_45_2, var_45_3 = var_0_24(self.cellSize, arg_45_2, arg_45_3, arg_45_4, arg_45_5)

	for iter_45_0 = var_45_1, var_45_1 + var_45_3 - 1 do
		for iter_45_1 = var_45_0, var_45_0 + var_45_2 - 1 do
			var_0_33(self, arg_45_1, iter_45_1, iter_45_0)
		end
	end

	return arg_45_1
end

function var_0_29:remove(arg_46_1)
	local var_46_0, var_46_1, var_46_2, var_46_3 = self:getRect(arg_46_1)

	self.rects[arg_46_1] = nil

	local var_46_4, var_46_5, var_46_6, var_46_7 = var_0_24(self.cellSize, var_46_0, var_46_1, var_46_2, var_46_3)

	for iter_46_0 = var_46_5, var_46_5 + var_46_7 - 1 do
		for iter_46_1 = var_46_4, var_46_4 + var_46_6 - 1 do
			var_0_34(self, arg_46_1, iter_46_1, iter_46_0)
		end
	end
end

function var_0_29:update(arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5)
	local var_47_9000
	local var_47_0, var_47_1, var_47_2, var_47_3 = self:getRect(arg_47_1)

	arg_47_4, arg_47_5 = arg_47_4 or var_47_2, arg_47_5 or var_47_3

	var_0_11(arg_47_2, arg_47_3, var_47_9000, arg_47_5)

	if var_47_0 ~= arg_47_2 or var_47_1 ~= arg_47_3 or var_47_2 ~= arg_47_4 or var_47_3 ~= arg_47_5 then
		local var_47_4 = self.cellSize
		local var_47_5, var_47_6, var_47_7, var_47_8 = var_0_24(self.cellSize, var_47_0, var_47_1, var_47_2, var_47_3)
		local var_47_9, var_47_10, var_47_11, var_47_12 = var_0_24(var_47_4, arg_47_2, arg_47_3, arg_47_4, arg_47_5)

		if var_47_5 ~= var_47_9 or var_47_6 ~= var_47_10 or var_47_7 ~= var_47_11 or var_47_8 ~= var_47_12 then
			local var_47_13 = var_47_5 + var_47_7 - 1
			local var_47_14 = var_47_9 + var_47_11 - 1

			for iter_47_0 = var_47_6, var_47_6 + var_47_8 - 1 do
				local var_47_16 = iter_47_0 < var_47_10 or var_47_10 + var_47_12 - 1 < iter_47_0

				for iter_47_1 = var_47_5, var_47_13 do
					if var_47_16 or iter_47_1 < var_47_9 or var_47_14 < iter_47_1 then
						var_0_34(self, arg_47_1, iter_47_1, iter_47_0)
					end
				end
			end

			for iter_47_2 = var_47_10, var_47_10 + var_47_12 - 1 do
				local var_47_17 = iter_47_2 < var_47_6 or var_47_6 + var_47_8 - 1 < iter_47_2

				for iter_47_3 = var_47_9, var_47_14 do
					if var_47_17 or iter_47_3 < var_47_5 or var_47_13 < iter_47_3 then
						var_0_33(self, arg_47_1, iter_47_3, iter_47_2)
					end
				end
			end
		end

		local var_47_18 = self.rects[arg_47_1]

		var_47_18.x, var_47_18.y, var_47_18.w, var_47_18.h = arg_47_2, arg_47_3, arg_47_4, arg_47_5
	end
end

function var_0_29:move(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0, var_48_1, var_48_2, var_48_3 = self:check(arg_48_1, arg_48_2, arg_48_3, arg_48_4)

	self:update(arg_48_1, var_48_0, var_48_1)

	return var_48_0, var_48_1, var_48_2, var_48_3
end

function var_0_29:check(arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	arg_49_4 = arg_49_4 or var_0_12

	local var_49_0 = {
		[arg_49_1] = true
	}

	local function var_49_1(arg_50_0, arg_50_1)
		if var_49_0[arg_50_1] then
			return false
		end

		return arg_49_4(arg_50_0, arg_50_1)
	end

	local var_49_2 = {}
	local var_49_3 = 0
	local var_49_4, var_49_5, var_49_6, var_49_7 = self:getRect(arg_49_1)
	local var_49_8, var_49_9 = self:project(arg_49_1, var_49_4, var_49_5, var_49_6, var_49_7, arg_49_2, arg_49_3, var_49_1)

	while var_49_9 > 0 do
		var_49_3 = var_49_3 + 1
		var_49_2[var_49_3] = var_49_8[1]
		var_49_0[var_49_8[1].other] = true
		arg_49_2, arg_49_3, var_49_8, var_49_9 = var_0_38(self, var_49_8[1].type)(self, var_49_8[1], var_49_4, var_49_5, var_49_6, var_49_7, arg_49_2, arg_49_3, var_49_1)
	end

	return arg_49_2, arg_49_3, var_49_2, var_49_3
end

function var_0_0.newWorld(arg_51_0)
	arg_51_0 = arg_51_0 or 64

	var_0_10(arg_51_0, "cellSize")

	local var_51_0 = setmetatable({
		cellSize = arg_51_0,
		rects = {},
		rows = {},
		nonEmptyCells = {},
		responses = {}
	}, var_0_30)

	var_51_0:addResponse("touch", var_0_25)
	var_51_0:addResponse("cross", var_0_26)
	var_51_0:addResponse("slide", var_0_27)
	var_51_0:addResponse("bounce", var_0_28)

	return var_51_0
end

var_0_0.rect = {
	getNearestCorner = var_0_13,
	getSegmentIntersectionIndices = var_0_14,
	getDiff = var_0_15,
	containsPoint = var_0_16,
	isIntersecting = var_0_17,
	getSquareDistance = var_0_18,
	detectCollision = var_0_19
}
var_0_0.responses = {
	touch = var_0_25,
	cross = var_0_26,
	slide = var_0_27,
	bounce = var_0_28
}

return var_0_0
