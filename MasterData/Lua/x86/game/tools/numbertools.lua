return {
	RetractNumber = function(arg_1_0, arg_1_1)
		if arg_1_1 == nil then
			arg_1_1 = 1
		end

		local var_1_0 = ""
		local var_1_1 = math.pow(10, arg_1_1)

		if arg_1_0 > 999999 then
			arg_1_0 = math.floor(arg_1_0 / 1000000 * var_1_1) / var_1_1
			var_1_0 = "M"
		elseif arg_1_0 > 999 then
			arg_1_0 = math.floor(arg_1_0 / 1000 * var_1_1) / var_1_1
			var_1_0 = "K"
		end

		local var_1_2 = ""

		if arg_1_0 % 1 == 0 then
			var_1_2 = tostring(arg_1_0)
		else
			arg_1_1 = math.floor(arg_1_1)
			var_1_2 = string.format("%." .. arg_1_1 .. "f", arg_1_0)
		end

		return var_1_2 .. var_1_0
	end,
	RetractNumberForWindBar = function(arg_2_0, arg_2_1)
		if arg_2_1 == nil then
			arg_2_1 = 1
		end

		local var_2_0 = ""
		local var_2_1 = math.pow(10, arg_2_1)

		if arg_2_0 > 99999999 then
			arg_2_0 = math.floor(arg_2_0 / 1000000 * var_2_1) / var_2_1
			var_2_0 = "M"
		elseif arg_2_0 > 99999 then
			arg_2_0 = math.floor(arg_2_0 / 1000 * var_2_1) / var_2_1
			var_2_0 = "K"
		end

		local var_2_2 = ""

		if arg_2_0 % 1 == 0 then
			var_2_2 = tostring(arg_2_0)
		else
			arg_2_1 = math.floor(arg_2_1)
			var_2_2 = string.format("%." .. arg_2_1 .. "f", arg_2_0)
		end

		return var_2_2 .. var_2_0
	end,
	IntToRomam = function(arg_3_0)
		return ({
			"",
			"M",
			"MM",
			"MMM"
		})[math.floor(arg_3_0 / 1000 % 10) + 1] .. ({
			"",
			"C",
			"CC",
			"CCC",
			"CD",
			"D",
			"DC",
			"DCC",
			"DCCC",
			"CM"
		})[math.floor(arg_3_0 / 100 % 10) + 1] .. ({
			"",
			"X",
			"XX",
			"XXX",
			"XL",
			"L",
			"LX",
			"LXX",
			"LXXX",
			"XC"
		})[math.floor(arg_3_0 / 10 % 10) + 1] .. ({
			"",
			"I",
			"II",
			"III",
			"IV",
			"V",
			"VI",
			"VII",
			"VIII",
			"IX"
		})[math.floor(arg_3_0 % 10) + 1]
	end,
	FormatNumberWithThousandsSeparator = function(arg_4_0)
		local var_4_0 = tostring((math.floor(arg_4_0)))
		local var_4_1 = ""

		for iter_4_0 = 1, #var_4_0 do
			var_4_1 = var_4_1 .. string.sub(var_4_0, iter_4_0, iter_4_0)

			if #var_4_0 - iter_4_0 > 0 and (#var_4_0 - iter_4_0) % 3 == 0 then
				var_4_1 = var_4_1 .. ","
			end
		end

		local var_4_2 = var_4_1

		if arg_4_0 % 1 ~= 0 then
			var_4_2 = var_4_2 .. string.sub(tostring(arg_4_0), string.find(tostring(arg_4_0), "%."))
		end

		return var_4_2
	end
}
