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

			local var_1_3 = "%." .. arg_1_1 .. "f"

			var_1_2 = string.format(var_1_3, arg_1_0)
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

			local var_2_3 = "%." .. arg_2_1 .. "f"

			var_2_2 = string.format(var_2_3, arg_2_0)
		end

		return var_2_2 .. var_2_0
	end,
	IntToRomam = function(arg_3_0)
		local var_3_0 = {
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
		}
		local var_3_1 = {
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
		}
		local var_3_2 = {
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
		}

		return ({
			"",
			"M",
			"MM",
			"MMM"
		})[math.floor(arg_3_0 / 1000 % 10) + 1] .. var_3_2[math.floor(arg_3_0 / 100 % 10) + 1] .. var_3_1[math.floor(arg_3_0 / 10 % 10) + 1] .. var_3_0[math.floor(arg_3_0 % 10) + 1]
	end,
	FormatNumberWithThousandsSeparator = function(arg_4_0)
		local var_4_0 = math.floor(arg_4_0)
		local var_4_1 = tostring(var_4_0)
		local var_4_2 = ""
		local var_4_3 = #var_4_1

		for iter_4_0 = 1, var_4_3 do
			var_4_2 = var_4_2 .. string.sub(var_4_1, iter_4_0, iter_4_0)

			if var_4_3 - iter_4_0 > 0 and (var_4_3 - iter_4_0) % 3 == 0 then
				var_4_2 = var_4_2 .. ","
			end
		end

		local var_4_4 = var_4_2

		if arg_4_0 % 1 ~= 0 then
			var_4_4 = var_4_4 .. string.sub(tostring(arg_4_0), string.find(tostring(arg_4_0), "%."))
		end

		return var_4_4
	end
}
