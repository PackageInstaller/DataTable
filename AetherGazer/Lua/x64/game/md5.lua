local var_0_0 = {
	_LICENSE = "\n\n    MIT LICENSE\n\n\n\n\n\n\n    Copyright (c) 2013 Enrique García Cota + Adam Baldwin + hanzao + Equi 4 Software\n\n\n\n\n\n\n    Permission is hereby granted, free of charge, to any person obtaining a\n\n\n    copy of this software and associated documentation files (the\n\n\n    \"Software\"), to deal in the Software without restriction, including\n\n\n    without limitation the rights to use, copy, modify, merge, publish,\n\n\n    distribute, sublicense, and/or sell copies of the Software, and to\n\n\n    permit persons to whom the Software is furnished to do so, subject to\n\n\n    the following conditions:\n\n\n\n\n\n\n    The above copyright notice and this permission notice shall be included\n\n\n    in all copies or substantial portions of the Software.\n\n\n\n\n\n\n    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n\n\n    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n\n\n    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n\n\n    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n\n\n    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n\n\n    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n\n\n    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n\n  "
}
local var_0_1 = string.char
local var_0_2 = string.byte
local var_0_3 = string.format
local var_0_4 = string.rep
local var_0_5 = string.sub
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10
local var_0_11
local var_0_12, var_0_13 = pcall(require, "bit")

if var_0_12 then
	var_0_6, var_0_7, var_0_8, var_0_9, var_0_10, var_0_11 = var_0_13.bor, var_0_13.band, var_0_13.bnot, var_0_13.bxor, var_0_13.rshift, var_0_13.lshift
else
	local var_0_14, var_0_15 = pcall(require, "bit32")
	local var_0_16 = var_0_15

	if var_0_14 then
		var_0_8 = var_0_16.bnot

		local function var_0_17(arg_1_0)
			return arg_1_0 <= 2147483647 and arg_1_0 or -(var_0_8(arg_1_0) + 1)
		end

		local function var_0_18(arg_2_0)
			return function(arg_3_0, arg_3_1)
				return var_0_17(arg_2_0(var_0_17(arg_3_0), var_0_17(arg_3_1)))
			end
		end

		var_0_6, var_0_7, var_0_9 = var_0_18(var_0_16.bor), var_0_18(var_0_16.band), var_0_18(var_0_16.bxor)
		var_0_10, var_0_11 = var_0_18(var_0_16.rshift), var_0_18(var_0_16.lshift)
	else
		local function var_0_19(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			for iter_4_0 = 1, #arg_4_0 do
				var_4_0 = var_4_0 + arg_4_0[iter_4_0] * var_4_1
				var_4_1 = var_4_1 * 2
			end

			return var_4_0
		end

		local function var_0_20(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_0
			local var_5_1 = arg_5_1

			if #var_5_0 < #var_5_1 then
				var_5_0, var_5_1 = var_5_1, var_5_0
			end

			for iter_5_0 = #var_5_1 + 1, #var_5_0 do
				var_5_1[iter_5_0] = 0
			end
		end

		local var_0_21

		function var_0_8(arg_6_0)
			local var_6_0 = var_0_21(arg_6_0)
			local var_6_1 = math.max(#var_6_0, 32)

			for iter_6_0 = 1, var_6_1 do
				if var_6_0[iter_6_0] == 1 then
					var_6_0[iter_6_0] = 0
				else
					var_6_0[iter_6_0] = 1
				end
			end

			return var_0_19(var_6_0)
		end

		function var_0_21(arg_7_0)
			if arg_7_0 < 0 then
				return var_0_21(var_0_8(math.abs(arg_7_0)) + 1)
			end

			local var_7_0 = {}
			local var_7_1 = 1
			local var_7_2

			while arg_7_0 > 0 do
				local var_7_3 = arg_7_0 % 2

				var_7_0[var_7_1] = var_7_3
				arg_7_0 = (arg_7_0 - var_7_3) / 2
				var_7_1 = var_7_1 + 1
			end

			return var_7_0
		end

		function var_0_6(arg_8_0, arg_8_1)
			local var_8_0 = var_0_21(arg_8_0)
			local var_8_1 = var_0_21(arg_8_1)

			var_0_20(var_8_0, var_8_1)

			local var_8_2 = {}

			for iter_8_0 = 1, #var_8_0 do
				if var_8_0[iter_8_0] == 0 and var_8_1[iter_8_0] == 0 then
					var_8_2[iter_8_0] = 0
				else
					var_8_2[iter_8_0] = 1
				end
			end

			return var_0_19(var_8_2)
		end

		function var_0_7(arg_9_0, arg_9_1)
			local var_9_0 = var_0_21(arg_9_0)
			local var_9_1 = var_0_21(arg_9_1)

			var_0_20(var_9_0, var_9_1)

			local var_9_2 = {}

			for iter_9_0 = 1, #var_9_0 do
				if var_9_0[iter_9_0] == 0 or var_9_1[iter_9_0] == 0 then
					var_9_2[iter_9_0] = 0
				else
					var_9_2[iter_9_0] = 1
				end
			end

			return var_0_19(var_9_2)
		end

		function var_0_9(arg_10_0, arg_10_1)
			local var_10_0 = var_0_21(arg_10_0)
			local var_10_1 = var_0_21(arg_10_1)

			var_0_20(var_10_0, var_10_1)

			local var_10_2 = {}

			for iter_10_0 = 1, #var_10_0 do
				if var_10_0[iter_10_0] ~= var_10_1[iter_10_0] then
					var_10_2[iter_10_0] = 1
				else
					var_10_2[iter_10_0] = 0
				end
			end

			return var_0_19(var_10_2)
		end

		function var_0_10(arg_11_0, arg_11_1)
			local var_11_0 = 0

			if arg_11_0 < 0 then
				arg_11_0 = var_0_8(math.abs(arg_11_0)) + 1
				var_11_0 = 2147483648
			end

			local var_11_1 = math.floor

			for iter_11_0 = 1, arg_11_1 do
				arg_11_0 = arg_11_0 / 2
				arg_11_0 = var_0_6(var_11_1(arg_11_0), var_11_0)
			end

			return var_11_1(arg_11_0)
		end

		function var_0_11(arg_12_0, arg_12_1)
			if arg_12_0 < 0 then
				arg_12_0 = var_0_8(math.abs(arg_12_0)) + 1
			end

			for iter_12_0 = 1, arg_12_1 do
				arg_12_0 = arg_12_0 * 2
			end

			return var_0_7(arg_12_0, 4294967295)
		end
	end
end

local function var_0_22(arg_13_0)
	local function var_13_0(arg_14_0)
		return var_0_1(var_0_7(var_0_10(arg_13_0, arg_14_0), 255))
	end

	return var_13_0(0) .. var_13_0(8) .. var_13_0(16) .. var_13_0(24)
end

local function var_0_23(arg_15_0)
	local var_15_0 = 0

	for iter_15_0 = 1, #arg_15_0 do
		var_15_0 = var_15_0 * 256 + var_0_2(arg_15_0, iter_15_0)
	end

	return var_15_0
end

local function var_0_24(arg_16_0)
	local var_16_0 = 0

	for iter_16_0 = #arg_16_0, 1, -1 do
		var_16_0 = var_16_0 * 256 + var_0_2(arg_16_0, iter_16_0)
	end

	return var_16_0
end

local function var_0_25(arg_17_0, ...)
	local var_17_0 = 1
	local var_17_1 = {}
	local var_17_2 = {
		...
	}

	for iter_17_0 = 1, #var_17_2 do
		table.insert(var_17_1, var_0_24(var_0_5(arg_17_0, var_17_0, var_17_0 + var_17_2[iter_17_0] - 1)))

		var_17_0 = var_17_0 + var_17_2[iter_17_0]
	end

	return var_17_1
end

local function var_0_26(arg_18_0)
	return var_0_23(var_0_22(arg_18_0))
end

local var_0_27 = {
	3614090360,
	3905402710,
	606105819,
	3250441966,
	4118548399,
	1200080426,
	2821735955,
	4249261313,
	1770035416,
	2336552879,
	4294925233,
	2304563134,
	1804603682,
	4254626195,
	2792965006,
	1236535329,
	4129170786,
	3225465664,
	643717713,
	3921069994,
	3593408605,
	38016083,
	3634488961,
	3889429448,
	568446438,
	3275163606,
	4107603335,
	1163531501,
	2850285829,
	4243563512,
	1735328473,
	2368359562,
	4294588738,
	2272392833,
	1839030562,
	4259657740,
	2763975236,
	1272893353,
	4139469664,
	3200236656,
	681279174,
	3936430074,
	3572445317,
	76029189,
	3654602809,
	3873151461,
	530742520,
	3299628645,
	4096336452,
	1126891415,
	2878612391,
	4237533241,
	1700485571,
	2399980690,
	4293915773,
	2240044497,
	1873313359,
	4264355552,
	2734768916,
	1309151649,
	4149444226,
	3174756917,
	718787259,
	3951481745,
	1732584193,
	4023233417,
	2562383102,
	271733878
}

local function var_0_28(arg_19_0, arg_19_1, arg_19_2)
	return var_0_6(var_0_7(arg_19_0, arg_19_1), var_0_7(-arg_19_0 - 1, arg_19_2))
end

local function var_0_29(arg_20_0, arg_20_1, arg_20_2)
	return var_0_6(var_0_7(arg_20_0, arg_20_2), var_0_7(arg_20_1, -arg_20_2 - 1))
end

local function var_0_30(arg_21_0, arg_21_1, arg_21_2)
	return var_0_9(arg_21_0, var_0_9(arg_21_1, arg_21_2))
end

local function var_0_31(arg_22_0, arg_22_1, arg_22_2)
	return var_0_9(arg_22_1, var_0_6(arg_22_0, -arg_22_2 - 1))
end

local function var_0_32(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6, arg_23_7)
	arg_23_1 = var_0_7(arg_23_1 + arg_23_0(arg_23_2, arg_23_3, arg_23_4) + arg_23_5 + arg_23_7, 4294967295)

	return var_0_6(var_0_11(var_0_7(arg_23_1, var_0_10(4294967295, arg_23_6)), arg_23_6), var_0_10(arg_23_1, 32 - arg_23_6)) + arg_23_2
end

local function var_0_33(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_1
	local var_24_2 = arg_24_2
	local var_24_3 = arg_24_3
	local var_24_4 = var_0_27
	local var_24_5 = var_0_32(var_0_28, var_24_0, var_24_1, var_24_2, var_24_3, arg_24_4[0], 7, var_24_4[1])
	local var_24_6 = var_0_32(var_0_28, var_24_3, var_24_5, var_24_1, var_24_2, arg_24_4[1], 12, var_24_4[2])
	local var_24_7 = var_0_32(var_0_28, var_24_2, var_24_6, var_24_5, var_24_1, arg_24_4[2], 17, var_24_4[3])
	local var_24_8 = var_0_32(var_0_28, var_24_1, var_24_7, var_24_6, var_24_5, arg_24_4[3], 22, var_24_4[4])
	local var_24_9 = var_0_32(var_0_28, var_24_5, var_24_8, var_24_7, var_24_6, arg_24_4[4], 7, var_24_4[5])
	local var_24_10 = var_0_32(var_0_28, var_24_6, var_24_9, var_24_8, var_24_7, arg_24_4[5], 12, var_24_4[6])
	local var_24_11 = var_0_32(var_0_28, var_24_7, var_24_10, var_24_9, var_24_8, arg_24_4[6], 17, var_24_4[7])
	local var_24_12 = var_0_32(var_0_28, var_24_8, var_24_11, var_24_10, var_24_9, arg_24_4[7], 22, var_24_4[8])
	local var_24_13 = var_0_32(var_0_28, var_24_9, var_24_12, var_24_11, var_24_10, arg_24_4[8], 7, var_24_4[9])
	local var_24_14 = var_0_32(var_0_28, var_24_10, var_24_13, var_24_12, var_24_11, arg_24_4[9], 12, var_24_4[10])
	local var_24_15 = var_0_32(var_0_28, var_24_11, var_24_14, var_24_13, var_24_12, arg_24_4[10], 17, var_24_4[11])
	local var_24_16 = var_0_32(var_0_28, var_24_12, var_24_15, var_24_14, var_24_13, arg_24_4[11], 22, var_24_4[12])
	local var_24_17 = var_0_32(var_0_28, var_24_13, var_24_16, var_24_15, var_24_14, arg_24_4[12], 7, var_24_4[13])
	local var_24_18 = var_0_32(var_0_28, var_24_14, var_24_17, var_24_16, var_24_15, arg_24_4[13], 12, var_24_4[14])
	local var_24_19 = var_0_32(var_0_28, var_24_15, var_24_18, var_24_17, var_24_16, arg_24_4[14], 17, var_24_4[15])
	local var_24_20 = var_0_32(var_0_28, var_24_16, var_24_19, var_24_18, var_24_17, arg_24_4[15], 22, var_24_4[16])
	local var_24_21 = var_0_32(var_0_29, var_24_17, var_24_20, var_24_19, var_24_18, arg_24_4[1], 5, var_24_4[17])
	local var_24_22 = var_0_32(var_0_29, var_24_18, var_24_21, var_24_20, var_24_19, arg_24_4[6], 9, var_24_4[18])
	local var_24_23 = var_0_32(var_0_29, var_24_19, var_24_22, var_24_21, var_24_20, arg_24_4[11], 14, var_24_4[19])
	local var_24_24 = var_0_32(var_0_29, var_24_20, var_24_23, var_24_22, var_24_21, arg_24_4[0], 20, var_24_4[20])
	local var_24_25 = var_0_32(var_0_29, var_24_21, var_24_24, var_24_23, var_24_22, arg_24_4[5], 5, var_24_4[21])
	local var_24_26 = var_0_32(var_0_29, var_24_22, var_24_25, var_24_24, var_24_23, arg_24_4[10], 9, var_24_4[22])
	local var_24_27 = var_0_32(var_0_29, var_24_23, var_24_26, var_24_25, var_24_24, arg_24_4[15], 14, var_24_4[23])
	local var_24_28 = var_0_32(var_0_29, var_24_24, var_24_27, var_24_26, var_24_25, arg_24_4[4], 20, var_24_4[24])
	local var_24_29 = var_0_32(var_0_29, var_24_25, var_24_28, var_24_27, var_24_26, arg_24_4[9], 5, var_24_4[25])
	local var_24_30 = var_0_32(var_0_29, var_24_26, var_24_29, var_24_28, var_24_27, arg_24_4[14], 9, var_24_4[26])
	local var_24_31 = var_0_32(var_0_29, var_24_27, var_24_30, var_24_29, var_24_28, arg_24_4[3], 14, var_24_4[27])
	local var_24_32 = var_0_32(var_0_29, var_24_28, var_24_31, var_24_30, var_24_29, arg_24_4[8], 20, var_24_4[28])
	local var_24_33 = var_0_32(var_0_29, var_24_29, var_24_32, var_24_31, var_24_30, arg_24_4[13], 5, var_24_4[29])
	local var_24_34 = var_0_32(var_0_29, var_24_30, var_24_33, var_24_32, var_24_31, arg_24_4[2], 9, var_24_4[30])
	local var_24_35 = var_0_32(var_0_29, var_24_31, var_24_34, var_24_33, var_24_32, arg_24_4[7], 14, var_24_4[31])
	local var_24_36 = var_0_32(var_0_29, var_24_32, var_24_35, var_24_34, var_24_33, arg_24_4[12], 20, var_24_4[32])
	local var_24_37 = var_0_32(var_0_30, var_24_33, var_24_36, var_24_35, var_24_34, arg_24_4[5], 4, var_24_4[33])
	local var_24_38 = var_0_32(var_0_30, var_24_34, var_24_37, var_24_36, var_24_35, arg_24_4[8], 11, var_24_4[34])
	local var_24_39 = var_0_32(var_0_30, var_24_35, var_24_38, var_24_37, var_24_36, arg_24_4[11], 16, var_24_4[35])
	local var_24_40 = var_0_32(var_0_30, var_24_36, var_24_39, var_24_38, var_24_37, arg_24_4[14], 23, var_24_4[36])
	local var_24_41 = var_0_32(var_0_30, var_24_37, var_24_40, var_24_39, var_24_38, arg_24_4[1], 4, var_24_4[37])
	local var_24_42 = var_0_32(var_0_30, var_24_38, var_24_41, var_24_40, var_24_39, arg_24_4[4], 11, var_24_4[38])
	local var_24_43 = var_0_32(var_0_30, var_24_39, var_24_42, var_24_41, var_24_40, arg_24_4[7], 16, var_24_4[39])
	local var_24_44 = var_0_32(var_0_30, var_24_40, var_24_43, var_24_42, var_24_41, arg_24_4[10], 23, var_24_4[40])
	local var_24_45 = var_0_32(var_0_30, var_24_41, var_24_44, var_24_43, var_24_42, arg_24_4[13], 4, var_24_4[41])
	local var_24_46 = var_0_32(var_0_30, var_24_42, var_24_45, var_24_44, var_24_43, arg_24_4[0], 11, var_24_4[42])
	local var_24_47 = var_0_32(var_0_30, var_24_43, var_24_46, var_24_45, var_24_44, arg_24_4[3], 16, var_24_4[43])
	local var_24_48 = var_0_32(var_0_30, var_24_44, var_24_47, var_24_46, var_24_45, arg_24_4[6], 23, var_24_4[44])
	local var_24_49 = var_0_32(var_0_30, var_24_45, var_24_48, var_24_47, var_24_46, arg_24_4[9], 4, var_24_4[45])
	local var_24_50 = var_0_32(var_0_30, var_24_46, var_24_49, var_24_48, var_24_47, arg_24_4[12], 11, var_24_4[46])
	local var_24_51 = var_0_32(var_0_30, var_24_47, var_24_50, var_24_49, var_24_48, arg_24_4[15], 16, var_24_4[47])
	local var_24_52 = var_0_32(var_0_30, var_24_48, var_24_51, var_24_50, var_24_49, arg_24_4[2], 23, var_24_4[48])
	local var_24_53 = var_0_32(var_0_31, var_24_49, var_24_52, var_24_51, var_24_50, arg_24_4[0], 6, var_24_4[49])
	local var_24_54 = var_0_32(var_0_31, var_24_50, var_24_53, var_24_52, var_24_51, arg_24_4[7], 10, var_24_4[50])
	local var_24_55 = var_0_32(var_0_31, var_24_51, var_24_54, var_24_53, var_24_52, arg_24_4[14], 15, var_24_4[51])
	local var_24_56 = var_0_32(var_0_31, var_24_52, var_24_55, var_24_54, var_24_53, arg_24_4[5], 21, var_24_4[52])
	local var_24_57 = var_0_32(var_0_31, var_24_53, var_24_56, var_24_55, var_24_54, arg_24_4[12], 6, var_24_4[53])
	local var_24_58 = var_0_32(var_0_31, var_24_54, var_24_57, var_24_56, var_24_55, arg_24_4[3], 10, var_24_4[54])
	local var_24_59 = var_0_32(var_0_31, var_24_55, var_24_58, var_24_57, var_24_56, arg_24_4[10], 15, var_24_4[55])
	local var_24_60 = var_0_32(var_0_31, var_24_56, var_24_59, var_24_58, var_24_57, arg_24_4[1], 21, var_24_4[56])
	local var_24_61 = var_0_32(var_0_31, var_24_57, var_24_60, var_24_59, var_24_58, arg_24_4[8], 6, var_24_4[57])
	local var_24_62 = var_0_32(var_0_31, var_24_58, var_24_61, var_24_60, var_24_59, arg_24_4[15], 10, var_24_4[58])
	local var_24_63 = var_0_32(var_0_31, var_24_59, var_24_62, var_24_61, var_24_60, arg_24_4[6], 15, var_24_4[59])
	local var_24_64 = var_0_32(var_0_31, var_24_60, var_24_63, var_24_62, var_24_61, arg_24_4[13], 21, var_24_4[60])
	local var_24_65 = var_0_32(var_0_31, var_24_61, var_24_64, var_24_63, var_24_62, arg_24_4[4], 6, var_24_4[61])
	local var_24_66 = var_0_32(var_0_31, var_24_62, var_24_65, var_24_64, var_24_63, arg_24_4[11], 10, var_24_4[62])
	local var_24_67 = var_0_32(var_0_31, var_24_63, var_24_66, var_24_65, var_24_64, arg_24_4[2], 15, var_24_4[63])
	local var_24_68 = var_0_32(var_0_31, var_24_64, var_24_67, var_24_66, var_24_65, arg_24_4[9], 21, var_24_4[64])

	return var_0_7(arg_24_0 + var_24_65, 4294967295), var_0_7(arg_24_1 + var_24_68, 4294967295), var_0_7(arg_24_2 + var_24_67, 4294967295), var_0_7(arg_24_3 + var_24_66, 4294967295)
end

local function var_0_34(arg_25_0, arg_25_1)
	arg_25_0.pos = arg_25_0.pos + #arg_25_1
	arg_25_1 = arg_25_0.buf .. arg_25_1

	for iter_25_0 = 1, #arg_25_1 - 63, 64 do
		local var_25_0 = var_0_25(var_0_5(arg_25_1, iter_25_0, iter_25_0 + 63), 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4)

		var_25_0[0] = table.remove(var_25_0, 1)
		arg_25_0.a, arg_25_0.b, arg_25_0.c, arg_25_0.d = var_0_33(arg_25_0.a, arg_25_0.b, arg_25_0.c, arg_25_0.d, var_25_0)
	end

	arg_25_0.buf = var_0_5(arg_25_1, math.floor(#arg_25_1 / 64) * 64 + 1, #arg_25_1)

	return arg_25_0
end

local function var_0_35(arg_26_0)
	local var_26_0 = arg_26_0.pos
	local var_26_1 = 56 - var_26_0 % 64

	if var_26_0 % 64 > 56 then
		var_26_1 = var_26_1 + 64
	end

	if var_26_1 == 0 then
		var_26_1 = 64
	end

	local var_26_2 = var_0_1(128) .. var_0_4(var_0_1(0), var_26_1 - 1) .. var_0_22(var_0_7(8 * var_26_0, 4294967295)) .. var_0_22(math.floor(var_26_0 / 536870912))

	var_0_34(arg_26_0, var_26_2)

	return var_0_22(arg_26_0.a) .. var_0_22(arg_26_0.b) .. var_0_22(arg_26_0.c) .. var_0_22(arg_26_0.d)
end

function var_0_0.new()
	return {
		buf = "",
		pos = 0,
		a = var_0_27[65],
		b = var_0_27[66],
		c = var_0_27[67],
		d = var_0_27[68],
		update = var_0_34,
		finish = var_0_35
	}
end

function var_0_0.tohex(arg_28_0)
	return var_0_3("%08x%08x%08x%08x", var_0_23(var_0_5(arg_28_0, 1, 4)), var_0_23(var_0_5(arg_28_0, 5, 8)), var_0_23(var_0_5(arg_28_0, 9, 12)), var_0_23(var_0_5(arg_28_0, 13, 16)))
end

function var_0_0.sum(arg_29_0)
	return var_0_0.new():update(arg_29_0):finish()
end

function var_0_0.sumhexa(arg_30_0)
	return var_0_0.tohex(var_0_0.sum(arg_30_0))
end

return var_0_0
