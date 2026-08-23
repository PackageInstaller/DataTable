local var_0_0 = {
	getBuyMaxNum = function(arg_1_0, arg_1_1, arg_1_2)
		if arg_1_1 >= arg_1_2 * arg_1_0 then
			return arg_1_0
		else
			return (math.floor(arg_1_1 / arg_1_2))
		end
	end,
	toChineseNumber = function(arg_2_0)
		assert(type(arg_2_0) == "number", "Must be a number")

		if require("app.core.lang.MultilingualMgr"):getUseLang() ~= "cn" then
			return arg_2_0
		end

		if arg_2_0 == 0 then
			return g.core.lang:get(100)
		end

		local var_2_0 = {}

		for iter_2_0 = 0, 9 do
			table.insert(var_2_0, g.core.lang:get(100 + iter_2_0))
		end

		local var_2_1 = {
			"",
			g.core.lang:get(110),
			g.core.lang:get(111),
			g.core.lang:get(112)
		}
		local var_2_2 = {
			"",
			g.core.lang:get(113),
			g.core.lang:get(114)
		}

		local function var_2_3(arg_3_0, arg_3_1)
			local var_3_0 = ""

			for iter_3_0 = #arg_3_1, 1, -1 do
				if arg_3_1[iter_3_0] == "0" and (arg_3_1[iter_3_0 - 1] == "0" or iter_3_0 == 1) then
					-- block empty
				else
					if #arg_3_1 == 2 and iter_3_0 == 2 and arg_3_1[iter_3_0] == "1" and arg_3_0 == 1 then
						-- block empty
					else
						var_3_0 = var_3_0 .. var_2_0[tonumber(arg_3_1[iter_3_0]) + 1]
					end

					if arg_3_1[iter_3_0] ~= "0" then
						var_3_0 = var_3_0 .. var_2_1[iter_3_0]
					end
				end
			end

			return var_3_0 .. var_2_2[arg_3_0]
		end

		arg_2_0 = string.reverse(tostring(arg_2_0))

		local var_2_4 = {}

		for iter_2_1 = 1, string.len(arg_2_0) do
			local var_2_5 = math.ceil(iter_2_1 / 4)

			var_2_4[var_2_5] = var_2_4[var_2_5] or {}

			table.insert(var_2_4[var_2_5], string.sub(arg_2_0, iter_2_1, iter_2_1))
		end

		local var_2_6 = ""

		for iter_2_2, iter_2_3 in ipairs(var_2_4) do
			var_2_6 = var_2_3(iter_2_2, iter_2_3) .. var_2_6
		end

		return var_2_6
	end
}

function var_0_0.toChineseWeek(arg_4_0)
	return var_0_0.toChineseNumber(arg_4_0)
end

function var_0_0.getDiscountStr(arg_5_0)
	return g.core.lang:get(108023, {
		num = tonumber(arg_5_0)
	})
end

function var_0_0.tenToTwoByteList(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0 or 0
	local var_6_1 = {}

	for iter_6_0 = arg_6_1 or 32, 1, -1 do
		var_6_1[#var_6_1 + 1] = math.floor(var_6_0 / 2^iter_6_0)
		var_6_0 = var_6_0 % 2^iter_6_0
	end

	return var_6_1
end

function var_0_0.getPreciseDecimal(arg_7_0, arg_7_1)
	if type(arg_7_0) ~= "number" then
		return arg_7_0
	end

	arg_7_1 = arg_7_1 or 0

	if arg_7_1 < 0 then
		arg_7_1 = 0
	end

	arg_7_1 = math.floor(arg_7_1)

	return math.modf(arg_7_0 * 10^arg_7_1) / 10^arg_7_1
end

function var_0_0.convertNumToRoman(arg_8_0)
	if arg_8_0 == 0 then
		return ""
	elseif arg_8_0 == 1 then
		return "I"
	elseif arg_8_0 == 2 then
		return "II"
	elseif arg_8_0 == 3 then
		return "III"
	elseif arg_8_0 == 4 then
		return "IV"
	elseif arg_8_0 == 5 then
		return "V"
	elseif arg_8_0 == 6 then
		return "VI"
	elseif arg_8_0 == 7 then
		return "VII"
	elseif arg_8_0 == 8 then
		return "VIII"
	elseif arg_8_0 == 9 then
		return "IX"
	elseif arg_8_0 == 10 then
		return "X"
	end
end

function var_0_0:getIntFromUserObject()
	if self ~= nil then
		self = (device.platform == "wp8" or device.platform == "winrt") and tolua.cast(self, "cc.__Integer") or tolua.cast(self, "CCInteger")

		if self ~= nil then
			return self:getValue()
		end
	end
end

function var_0_0.formatNumberByLimit(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0 = math.max(arg_10_0, arg_10_1)
	arg_10_0 = math.min(arg_10_0, arg_10_2)

	return arg_10_0
end

function var_0_0.convertNumOverTenBillion(arg_11_0)
	if arg_11_0 >= math.pow(10, 10) then
		arg_11_0 = arg_11_0 / math.pow(10, 8)

		if arg_11_0 - math.floor(arg_11_0) > 0 then
			return true, string.format("%.2f", arg_11_0) .. g.core.lang:get(114)
		else
			return true, string.format("%d", arg_11_0) .. g.core.lang:get(114)
		end
	end

	return false, ""
end

function var_0_0.convertNumOverOneThousandBillion(arg_12_0)
	if arg_12_0 >= math.pow(10, 12) then
		arg_12_0 = arg_12_0 / math.pow(10, 8)

		return true, string.format("%.1f", arg_12_0) .. g.core.lang:get(114)
	end

	return false, ""
end

function var_0_0.convertNumOverTenThousandBillion(arg_13_0)
	if arg_13_0 >= math.pow(10, 13) then
		arg_13_0 = arg_13_0 / math.pow(10, 8)

		return true, string.format("%d", arg_13_0) .. g.core.lang:get(114)
	end

	return false, ""
end

function var_0_0.convertNumOverHundredThousandBillion(arg_14_0)
	if arg_14_0 >= math.pow(10, 14) then
		arg_14_0 = arg_14_0 / math.pow(10, 12)

		return true, string.format("%.2f", arg_14_0) .. g.core.lang:get(113) .. g.core.lang:get(114)
	end

	return false, ""
end

function var_0_0._uniteConvertNum(arg_15_0)
	local var_15_0, var_15_1 = var_0_0.convertNumOverHundredThousandBillion(arg_15_0)

	if var_15_0 then
		return true, var_15_1
	end

	local var_15_2, var_15_3 = var_0_0.convertNumOverTenThousandBillion(arg_15_0)

	if var_15_2 then
		return true, var_15_3
	end

	local var_15_4, var_15_5 = var_0_0.convertNumOverOneThousandBillion(arg_15_0)

	if var_15_4 then
		return true, var_15_5
	end

	local var_15_6, var_15_7 = var_0_0.convertNumOverTenBillion(arg_15_0)

	if var_15_6 then
		return true, var_15_7
	end

	return false, ""
end

function var_0_0.convertNumToCharacter(arg_16_0)
	local var_16_0, var_16_1 = var_0_0._uniteConvertNum(arg_16_0)

	if var_16_0 then
		return var_16_1
	end

	if arg_16_0 >= math.pow(10, 8) then
		return (arg_16_0 - arg_16_0 % math.pow(10, 4)) / math.pow(10, 4) .. g.core.lang:get(113)
	end

	if arg_16_0 >= math.pow(10, 6) then
		return (arg_16_0 - arg_16_0 % math.pow(10, 4)) / math.pow(10, 4) .. g.core.lang:get(113)
	end

	return arg_16_0
end

function var_0_0.convertIconNum(arg_17_0)
	if type(arg_17_0) ~= "number" then
		return arg_17_0
	end

	return var_0_0.transTextNumFormation(arg_17_0)
end

function var_0_0.convertFightValueNum(arg_18_0)
	return var_0_0.transTextNumFormation(arg_18_0)
end

function var_0_0.toMemoryShortSize(arg_19_0)
	local var_19_0 = "M"

	if arg_19_0 >= 1048576 then
		arg_19_0 = arg_19_0 / 1048576
	elseif arg_19_0 >= 1024 then
		var_19_0 = "K"
		arg_19_0 = arg_19_0 / 1024
	else
		var_19_0 = "B"
	end

	arg_19_0 = arg_19_0 - arg_19_0 % 0.1

	return arg_19_0 .. var_19_0
end

function var_0_0.getFormatNum(arg_20_0, arg_20_1)
	local var_20_0 = tostring(arg_20_1)

	if #var_20_0 < arg_20_0 then
		return string.sub("000000000000000000000000", 1, arg_20_0 - #var_20_0) .. var_20_0
	end

	return var_20_0
end

function var_0_0.transFightValue(arg_21_0)
	return var_0_0.transTextNumFormation(arg_21_0)
end

function var_0_0.transTextNumFormation(arg_22_0)
	local function var_22_0(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		arg_23_3 = arg_23_3 or 0

		if arg_23_0 >= math.pow(10, arg_23_1) then
			local var_23_0

			if arg_23_3 > 0 and arg_23_3 < arg_23_2 then
				var_23_0 = (arg_23_0 - arg_23_0 % math.pow(10, arg_23_2 - arg_23_3)) / math.pow(10, arg_23_2 - arg_23_3)
				var_23_0 = var_23_0 / math.pow(10, arg_23_3)
			end

			var_23_0 = var_23_0 or (arg_23_0 - arg_23_0 % math.pow(10, arg_23_2)) / math.pow(10, arg_23_2)

			return true, var_23_0
		end

		return false
	end

	if type(arg_22_0) == "number" and arg_22_0 >= math.pow(10, 14) then
		local var_22_1 = g.core.model.User.translateData:getTranslateLangNum((require("app.core.lang.MultilingualMgr"):getUseLang()))

		if var_22_1.calcElem then
			for iter_22_0, iter_22_1 in ipairs(var_22_1.calcElem) do
				if arg_22_0 >= math.pow(10, iter_22_1.up) then
					arg_22_0 = string.format("%." .. iter_22_1.pointEx .. "f", arg_22_0 / math.pow(10, iter_22_1.calc))
					arg_22_0 = arg_22_0 .. iter_22_1.tail

					break
				end
			end
		elseif arg_22_0 >= math.pow(10, 20) then
			arg_22_0 = string.format("%.0f", arg_22_0 / math.pow(10, 18))
			arg_22_0 = arg_22_0 .. g.core.lang:get(143)
		elseif arg_22_0 >= math.pow(10, 17) then
			arg_22_0 = string.format("%.0f", arg_22_0 / math.pow(10, 15))
			arg_22_0 = arg_22_0 .. g.core.lang:get(142)
		end

		return arg_22_0
	else
		arg_22_0 = tostring(arg_22_0)
	end

	return (string.gsub(arg_22_0, "%d+%.?%d*", function(arg_24_0)
		local var_24_0 = tonumber(arg_24_0)

		if var_24_0 then
			local var_24_1 = g.core.model.User.translateData:getTranslateLangNum((require("app.core.lang.MultilingualMgr"):getUseLang()))

			if var_24_1.calcElem then
				for iter_24_0, iter_24_1 in ipairs(var_24_1.calcElem) do
					local var_24_2, var_24_3 = var_22_0(var_24_0, iter_24_1.up, iter_24_1.calc, iter_24_1.pointEx)

					if var_24_2 then
						arg_24_0 = var_24_3 .. iter_24_1.tail

						break
					end
				end
			elseif var_24_0 >= math.pow(10, 14) then
				var_24_0 = (var_24_0 - var_24_0 % math.pow(10, 12)) / math.pow(10, 12)
				arg_24_0 = var_24_0 .. g.core.lang:get(141)
			elseif var_24_0 >= math.pow(10, 11) then
				var_24_0 = (var_24_0 - var_24_0 % math.pow(10, 9)) / math.pow(10, 9)
				arg_24_0 = var_24_0 .. g.core.lang:get(140)
			elseif var_24_0 >= math.pow(10, 8) then
				var_24_0 = (var_24_0 - var_24_0 % math.pow(10, 6)) / math.pow(10, 6)
				arg_24_0 = var_24_0 .. g.core.lang:get(139)
			elseif var_24_0 >= math.pow(10, 6) then
				arg_24_0 = (var_24_0 - var_24_0 % math.pow(10, 3)) / math.pow(10, 3) .. g.core.lang:get(138)
			end

			return arg_24_0
		end
	end))
end

function var_0_0.transTextNumFormationKBM(arg_25_0)
	arg_25_0 = tostring(arg_25_0)

	return (string.gsub(arg_25_0, "%d+", function(arg_26_0)
		local var_26_0 = tonumber(arg_26_0)

		if var_26_0 then
			if var_26_0 >= math.pow(10, 14) then
				var_26_0 = (var_26_0 - var_26_0 % math.pow(10, 12)) / math.pow(10, 12)
				arg_26_0 = var_26_0 .. g.core.lang:get(141)
			elseif var_26_0 >= math.pow(10, 11) then
				var_26_0 = (var_26_0 - var_26_0 % math.pow(10, 9)) / math.pow(10, 9)
				arg_26_0 = var_26_0 .. g.core.lang:get(140)
			elseif var_26_0 >= math.pow(10, 8) then
				var_26_0 = (var_26_0 - var_26_0 % math.pow(10, 6)) / math.pow(10, 6)
				arg_26_0 = var_26_0 .. g.core.lang:get(139)
			elseif var_26_0 >= math.pow(10, 6) then
				arg_26_0 = (var_26_0 - var_26_0 % math.pow(10, 3)) / math.pow(10, 3) .. g.core.lang:get(138)
			end

			return arg_26_0
		end
	end))
end

return var_0_0
