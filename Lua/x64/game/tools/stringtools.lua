local var_0_0 = require("cjson")

function wordSplit(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 in arg_1_0.gmatch(arg_1_0, "[\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		var_1_0[#var_1_0 + 1] = iter_1_0
	end

	return var_1_0
end

local var_0_1 = "-"
local var_0_2 = "."

function encodeUID(arg_2_0)
	local var_2_0 = tonumber(arg_2_0)

	if var_2_0 == nil then
		return ""
	end

	local var_2_1 = ""

	while var_2_0 > 0 do
		local var_2_2 = var_2_0 % 10
		local var_2_3 = ""

		for iter_2_0 = 3, 0, -1 do
			local var_2_4 = math.floor(var_2_2 / 2^iter_2_0)

			if var_2_4 == 0 then
				var_2_3 = var_2_3 .. var_0_2
			elseif var_2_4 == 1 then
				var_2_3 = var_2_3 .. var_0_1
			end

			var_2_2 = var_2_2 % 2^iter_2_0
		end

		var_2_1 = var_2_3 .. var_2_1
		var_2_0 = math.floor(var_2_0 / 10)
	end

	return var_2_1
end

local var_0_3 = 0

function WordVerifyBySDK(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = string.gsub(arg_3_0, " ", "")
	local var_3_1 = 0

	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		var_3_1 = wordVerify(var_3_0)
	end

	local var_3_2 = string.match(arg_3_0, "<.+>.*</.+>") ~= nil

	if var_3_2 then
		arg_3_1(not var_3_2)

		return
	end

	local var_3_3 = var_3_1 <= 0

	if GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV then
		local var_3_4 = var_3_3 and ChatConst.VERIFY_STATUS.PASS or ChatConst.VERIFY_STATUS.LOCAL_NO_PASS

		SendJudgeResult(arg_3_2, arg_3_0, var_3_4, "")
		arg_3_1(var_3_3, var_3_4)

		return
	end

	if not var_3_3 then
		SendJudgeResult(arg_3_2, arg_3_0, ChatConst.VERIFY_STATUS.LOCAL_NO_PASS, "")
		arg_3_1(var_3_3, ChatConst.VERIFY_STATUS.LOCAL_NO_PASS)

		return
	end

	arg_3_1(true, ChatConst.VERIFY_STATUS.PASS)
end

function SendJudgeResult(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0 then
		local var_4_0 = {
			type = arg_4_0,
			content = arg_4_1,
			shield_type = arg_4_2,
			report_json = arg_4_3 or ""
		}

		SDKAction.SendMessageToSDK("shield_log", var_4_0)
	end
end

function wordVerMatch(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	if arg_5_3 > #arg_5_0 then
		return arg_5_5, arg_5_6, arg_5_7
	end

	local var_5_0 = arg_5_0[arg_5_3]
	local var_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if var_5_1 then
			table.deepMerge(var_5_1, iter_5_1[var_5_0] or {})
		else
			var_5_1 = var_5_1 or iter_5_1[var_5_0]
		end
	end

	if var_5_1 then
		if var_5_1.result then
			if arg_5_2.isReplace then
				return wordVerMatch(arg_5_0, {
					var_5_1
				}, arg_5_2, arg_5_3 + 1, arg_5_4 .. arg_5_2.replaceWord, true, arg_5_3 + 1, arg_5_4 .. arg_5_2.replaceWord)
			else
				return wordVerMatch(arg_5_0, {
					var_5_1
				}, arg_5_2, arg_5_3 + 1, arg_5_4, true, arg_5_3 + 1, arg_5_4)
			end
		elseif arg_5_2.isReplace then
			return wordVerMatch(arg_5_0, {
				var_5_1
			}, arg_5_2, arg_5_3 + 1, arg_5_4 .. arg_5_2.replaceWord, arg_5_5, arg_5_6, arg_5_7)
		else
			return wordVerMatch(arg_5_0, {
				var_5_1
			}, arg_5_2, arg_5_3 + 1, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
		end
	else
		return arg_5_5, arg_5_6, arg_5_7
	end
end

function isContainChineseNumEnglish(arg_6_0)
	local var_6_0 = 1

	while var_6_0 <= #arg_6_0 do
		local var_6_1 = string.byte(arg_6_0, var_6_0)

		if var_6_1 >= 48 and var_6_1 <= 57 or var_6_1 >= 65 and var_6_1 <= 90 or var_6_1 >= 97 and var_6_1 <= 122 then
			var_6_0 = var_6_0 + 1
		else
			if #arg_6_0 - var_6_0 <= 1 then
				return false
			end

			local var_6_2 = string.byte(arg_6_0, var_6_0 + 1)
			local var_6_3 = string.byte(arg_6_0, var_6_0 + 2)
			local var_6_4 = 14989440
			local var_6_5 = 15318693
			local var_6_6 = var_6_3 + var_6_2 * 256 + var_6_1 * 65536

			if var_6_6 < var_6_4 or var_6_5 < var_6_6 then
				return false
			else
				var_6_0 = var_6_0 + 3
			end
		end
	end

	return true
end

function textLimit(arg_7_0, arg_7_1)
	local var_7_0 = 1
	local var_7_1 = 0

	while var_7_0 <= #arg_7_0 do
		local var_7_2 = 0
		local var_7_3 = getByteLength(string.byte(arg_7_0, var_7_0))
		local var_7_4 = 0

		for iter_7_0 = 0, var_7_3 - 1 do
			local var_7_5 = string.byte(arg_7_0, var_7_0 + iter_7_0)

			var_7_4 = var_7_4 * 256 + var_7_5
		end

		local var_7_6 = isNumOrEn(var_7_4) and 1 or isChinese(var_7_4) and 2 or isJanpanese(var_7_4) and 2 or isKorean(var_7_4) and 2 or isSymbolForTwoWord(var_7_4) and 2 or isSymbolForOneWord(var_7_4) and 1 or 1

		if arg_7_1 < var_7_1 + var_7_6 then
			return string.sub(arg_7_0, 1, var_7_0 - 1), false
		end

		var_7_0 = var_7_0 + var_7_3
		var_7_1 = var_7_1 + var_7_6
	end

	return arg_7_0, true
end

function getByteLength(arg_8_0)
	if arg_8_0 >= 0 and arg_8_0 <= 127 then
		return 1
	elseif arg_8_0 >= 192 and arg_8_0 <= 223 then
		return 2
	elseif arg_8_0 >= 224 and arg_8_0 <= 239 then
		return 3
	elseif arg_8_0 >= 240 and arg_8_0 <= 247 then
		return 4
	else
		print("不是一个字符开头！")
	end
end

function isNumOrEn(arg_9_0)
	return arg_9_0 >= 48 and arg_9_0 <= 57 or arg_9_0 >= 65 and arg_9_0 <= 90 or arg_9_0 >= 97 and arg_9_0 <= 122
end

function isFullNumOrEn(arg_10_0)
	return isNumOrEn(arg_10_0 - 65248)
end

function isMars()
	return
end

function isChinese(arg_12_0)
	local var_12_0 = 14989440
	local var_12_1 = 15318693

	return var_12_0 <= arg_12_0 and arg_12_0 <= var_12_1
end

function isEnglish(arg_13_0)
	return arg_13_0 >= 65 and arg_13_0 <= 90 or arg_13_0 >= 97 and arg_13_0 <= 122
end

function isJanpanese(arg_14_0)
	local var_14_0 = 14909825
	local var_14_1 = 14910399
	local var_14_2 = 14911408
	local var_14_3 = 14911423

	return var_14_0 <= arg_14_0 and arg_14_0 <= var_14_1 or var_14_2 <= arg_14_0 and arg_14_0 <= var_14_3
end

function isKorean(arg_15_0)
	local var_15_0 = 15380608
	local var_15_1 = 15572655
	local var_15_2 = 14779520
	local var_15_3 = 14780303
	local var_15_4 = 14910640
	local var_15_5 = 14911119

	return var_15_0 <= arg_15_0 and arg_15_0 <= var_15_1 or var_15_2 <= arg_15_0 and arg_15_0 <= var_15_3 or var_15_4 <= arg_15_0 and arg_15_0 <= var_15_5
end

function isSymbol(arg_16_0)
	local var_16_0 = 14909568
	local var_16_1 = 14909631
	local var_16_2 = 15711360
	local var_16_3 = 15712175
	local var_16_4 = 14844032
	local var_16_5 = 14844335
	local var_16_6 = 32
	local var_16_7 = 127
	local var_16_8 = 49824
	local var_16_9 = 50111

	return var_16_0 <= arg_16_0 and arg_16_0 <= var_16_1 or var_16_2 <= arg_16_0 and arg_16_0 <= var_16_3 or var_16_4 <= arg_16_0 and arg_16_0 <= var_16_5 or var_16_6 <= arg_16_0 and arg_16_0 <= var_16_7 or var_16_8 <= arg_16_0 and arg_16_0 <= var_16_9 or arg_16_0 >= 48 and arg_16_0 <= 57 or arg_16_0 >= 65 and arg_16_0 <= 90 or arg_16_0 >= 97 and arg_16_0 <= 122
end

function isSymbolForOneWord(arg_17_0)
	local var_17_0 = 32
	local var_17_1 = 127
	local var_17_2 = 49824
	local var_17_3 = 50111

	return var_17_0 <= arg_17_0 and arg_17_0 <= var_17_1 or var_17_2 <= arg_17_0 and arg_17_0 <= var_17_3 or arg_17_0 >= 48 and arg_17_0 <= 57 or arg_17_0 >= 65 and arg_17_0 <= 90 or arg_17_0 >= 97 and arg_17_0 <= 122
end

function isSymbolForTwoWord(arg_18_0)
	local var_18_0 = 14909568
	local var_18_1 = 14909631
	local var_18_2 = 15711360
	local var_18_3 = 15712175
	local var_18_4 = 14844032
	local var_18_5 = 14844335

	return var_18_0 <= arg_18_0 and arg_18_0 <= var_18_1 or var_18_2 <= arg_18_0 and arg_18_0 <= var_18_3 or var_18_4 <= arg_18_0 and arg_18_0 <= var_18_5 or arg_18_0 >= 48 and arg_18_0 <= 57 or arg_18_0 >= 65 and arg_18_0 <= 90 or arg_18_0 >= 97 and arg_18_0 <= 122
end

function nameRule(arg_19_0, arg_19_1)
	local var_19_0 = GameToSDK.CURRENT_SERVER
	local var_19_1 = AreaDifferenceCfg[var_19_0]

	if var_19_1 then
		local var_19_2 = 1

		while var_19_2 <= #arg_19_0 do
			local var_19_3 = getByteLength(string.byte(arg_19_0, var_19_2))
			local var_19_4 = 0

			for iter_19_0 = 0, var_19_3 - 1 do
				local var_19_5 = string.byte(arg_19_0, var_19_2 + iter_19_0)

				var_19_4 = var_19_4 * 256 + var_19_5
			end

			local var_19_6 = false
			local var_19_7 = var_19_1.language_sent

			if isChinese(var_19_4) then
				var_19_6 = table.indexof(var_19_7, 0) ~= false
			elseif isJanpanese(var_19_4) then
				var_19_6 = table.indexof(var_19_7, 1) ~= false
			elseif isEnglish(var_19_4) then
				var_19_6 = table.indexof(var_19_7, 2) ~= false
			elseif isKorean(var_19_4) then
				var_19_6 = table.indexof(var_19_7, 3) ~= false
			elseif var_19_4 >= 48 and var_19_4 <= 57 then
				var_19_6 = true
			elseif arg_19_1 then
				var_19_6 = isSymbol(var_19_4)
			end

			if not var_19_6 then
				return false
			end

			var_19_2 = var_19_2 + var_19_3
		end

		return true
	else
		print("未定义命名规则 area = ", var_19_0)

		return false
	end
end

function filterEgyUnicode(arg_20_0)
	arg_20_0 = string.gsub(arg_20_0, "\xF0\x93[\x80-\x8F][\x80-\xBF]", "")
	arg_20_0 = string.gsub(arg_20_0, "\xF0\x93\x90[\x80-\xAF]", "")

	return arg_20_0
end

function wordVerify(arg_21_0, arg_21_1)
	arg_21_1 = arg_21_1 or {}

	local var_21_0 = filterEgyUnicode(arg_21_0)

	if #var_21_0 ~= #arg_21_0 then
		if arg_21_1.isReplace then
			arg_21_0 = var_21_0
		else
			return 1
		end
	end

	local var_21_1 = wordSplit(arg_21_0)
	local var_21_2 = {
		WordVerifyCfg,
		WordVerifyCfg2,
		WordVerifyCfg3,
		WordVerifyCfg4,
		WordVerifyCfg5,
		WordVerifyCfg6,
		WordVerifyCfg7,
		WordVerifyCfg8,
		WordVerifyCfg9,
		WordVerifyCfg10
	}

	arg_21_1.isReplace = arg_21_1.isReplace or false
	arg_21_1.replaceWord = arg_21_1.replaceWord or "*"

	local var_21_3 = #var_21_1
	local var_21_4 = 1
	local var_21_5 = ""
	local var_21_6 = 0

	while var_21_4 <= var_21_3 do
		local var_21_7, var_21_8, var_21_9 = wordVerMatch(var_21_1, var_21_2, arg_21_1, var_21_4, "", false, var_21_4, "")

		if var_21_7 then
			var_21_4 = var_21_8
			var_21_6 = var_21_6 + 1

			if arg_21_1.isReplace then
				var_21_5 = var_21_5 .. var_21_9
			end
		else
			if arg_21_1.isReplace then
				var_21_5 = var_21_5 .. var_21_1[var_21_4]
			end

			var_21_4 = var_21_4 + 1
		end
	end

	if arg_21_1.isReplace then
		return var_21_6, var_21_5
	else
		return var_21_6
	end
end

function shortenString(arg_22_0, arg_22_1)
	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = 0
	local var_22_3 = #arg_22_0

	while var_22_0 < var_22_3 do
		local var_22_4 = string.byte(arg_22_0, var_22_0 + 1)
		local var_22_5 = 1

		if var_22_4 < 128 then
			var_22_0 = var_22_0 + 1
		elseif var_22_4 >= 192 and var_22_4 < 224 then
			var_22_0 = var_22_0 + 2
		elseif var_22_4 >= 224 and var_22_4 < 240 then
			var_22_0 = var_22_0 + 3
		elseif var_22_4 >= 240 and var_22_4 < 248 then
			var_22_0 = var_22_0 + 4
		elseif var_22_4 >= 248 and var_22_4 < 252 then
			var_22_0 = var_22_0 + 5
		elseif var_22_4 >= 252 and var_22_4 < 254 then
			var_22_0 = var_22_0 + 6
		else
			error("invalid utf8 string")
		end

		var_22_1 = var_22_1 + var_22_5

		if arg_22_1 <= var_22_1 then
			var_22_2 = var_22_0

			break
		end
	end

	if var_22_2 == 0 or var_22_2 == var_22_3 then
		return arg_22_0
	end

	return string.sub(arg_22_0, 1, var_22_2) .. ".."
end

function fixColor(arg_23_0, arg_23_1)
	return "<color=" .. arg_23_1 .. ">" .. arg_23_0 .. "</color>"
end

function strrchr(arg_24_0, arg_24_1)
	local var_24_0 = string.reverse(arg_24_0)
	local var_24_1 = string.reverse(arg_24_1)
	local var_24_2, var_24_3 = string.find(var_24_0, var_24_1)

	if var_24_2 then
		return #arg_24_0 - var_24_3 + 1, #arg_24_0 - var_24_2 + 1
	else
		return 0, 0
	end
end

function IsAllSpace(arg_25_0)
	local var_25_0, var_25_1 = string.find(arg_25_0, "%s*")

	return var_25_0 == 1 and var_25_1 == string.len(arg_25_0)
end

function StringCount(arg_26_0)
	if not arg_26_0 or type(arg_26_0) ~= "string" or #arg_26_0 <= 0 then
		return nil
	end

	local var_26_0 = 0
	local var_26_1 = 1

	repeat
		local var_26_2 = string.byte(arg_26_0, var_26_1)
		local var_26_3 = 1

		var_26_1 = var_26_1 + (var_26_2 > 239 and 4 or var_26_2 > 223 and 3 or var_26_2 > 128 and 2 or 1)
		var_26_0 = var_26_0 + 1
	until var_26_1 > #arg_26_0

	return var_26_0
end

function ExStringCount(arg_27_0)
	if not arg_27_0 or type(arg_27_0) ~= "string" or #arg_27_0 <= 0 then
		return nil
	end

	local var_27_0 = 0
	local var_27_1 = 1

	repeat
		local var_27_2 = string.byte(arg_27_0, var_27_1)
		local var_27_3 = 1

		if var_27_2 > 239 then
			var_27_3 = 4
			var_27_0 = var_27_0 + 2
		elseif var_27_2 > 223 then
			var_27_3 = 3
			var_27_0 = var_27_0 + 2
		elseif var_27_2 > 128 then
			var_27_3 = 2
			var_27_0 = var_27_0 + 1
		else
			var_27_3 = 1
			var_27_0 = var_27_0 + 1
		end

		var_27_1 = var_27_1 + var_27_3
	until var_27_1 > #arg_27_0

	return var_27_0
end

function replaceSensitiveWordAll(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0
	local var_28_1 = replaceSensitiveWord(arg_28_0, arg_28_1)

	while var_28_0 ~= var_28_1 do
		var_28_0 = var_28_1
		var_28_1 = replaceSensitiveWord(var_28_1, arg_28_1)
	end

	return var_28_1
end

function replaceSensitiveWord(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0
	local var_29_1, var_29_2 = string.find(arg_29_0, arg_29_1, 1, true)

	if var_29_1 and var_29_2 then
		local var_29_3 = string.len(arg_29_0)
		local var_29_4 = getWordCount(arg_29_1)
		local var_29_5 = ""

		for iter_29_0 = 1, var_29_4 do
			var_29_5 = var_29_5 .. "*"
		end

		if var_29_1 == 1 then
			var_29_0 = var_29_5 .. string.sub(arg_29_0, var_29_2 + 1, -1)
		elseif var_29_2 == var_29_3 then
			var_29_0 = string.sub(arg_29_0, 1, var_29_1 - 1) .. var_29_5
		else
			local var_29_6 = string.sub(arg_29_0, 1, var_29_1 - 1)
			local var_29_7 = string.sub(arg_29_0, var_29_2 + 1, -1)

			var_29_0 = var_29_6 .. var_29_5 .. var_29_7
		end
	end

	return var_29_0
end

function getWordCount(arg_30_0)
	local var_30_0, var_30_1 = string.gsub(arg_30_0, "[^\x80-\xC1]", "")

	return var_30_1
end

symbolTable = {
	"！",
	"（",
	"）",
	"，",
	"．",
	"：",
	"；",
	"？"
}

function containSymbol(arg_31_0)
	local var_31_0 = string.find(arg_31_0, "%p") ~= nil

	if not var_31_0 then
		local var_31_1 = wordSplit(arg_31_0)

		for iter_31_0, iter_31_1 in ipairs(var_31_1) do
			if table.keyof(symbolTable, iter_31_1) then
				return true
			end
		end
	end

	return var_31_0
end

function getWordTable(arg_32_0)
	local function var_32_0(arg_33_0)
		local var_33_0 = {
			0,
			192,
			224,
			240
		}

		for iter_33_0 = #var_33_0, 1, -1 do
			if arg_33_0 >= var_33_0[iter_33_0] then
				return iter_33_0
			end
		end

		return 1
	end

	local var_32_1 = {}
	local var_32_2 = 1
	local var_32_3 = 0

	while var_32_2 <= string.len(arg_32_0) do
		local var_32_4 = var_32_0(string.byte(arg_32_0, var_32_2))

		table.insert(var_32_1, string.sub(arg_32_0, var_32_2, var_32_2 + var_32_4 - 1))

		var_32_2 = var_32_2 + var_32_4
	end

	return var_32_1
end

function dealEnter(arg_34_0)
	local var_34_0 = arg_34_0.transform:GetComponent("InputField")

	if not var_34_0 then
		print("缺少组件！！！")
	end

	var_34_0.onValueChanged:AddListener(function(arg_35_0)
		var_34_0.text = string.gsub(arg_35_0, "\n", "")
	end)
end

function chsize(arg_36_0)
	if not arg_36_0 then
		return 0
	elseif arg_36_0 > 240 then
		return 4
	elseif arg_36_0 > 225 then
		return 3
	elseif arg_36_0 > 192 then
		return 2
	else
		return 1
	end
end

function utf8sub(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = 1

	while arg_37_1 > 1 do
		local var_37_1 = string.byte(arg_37_0, var_37_0)

		var_37_0 = var_37_0 + chsize(var_37_1)
		arg_37_1 = arg_37_1 - 1
	end

	local var_37_2 = var_37_0

	while arg_37_2 > 0 and var_37_2 <= #arg_37_0 do
		local var_37_3 = string.byte(arg_37_0, var_37_2)

		var_37_2 = var_37_2 + chsize(var_37_3)
		arg_37_2 = arg_37_2 - 1
	end

	return arg_37_0:sub(var_37_0, var_37_2 - 1), arg_37_2
end

function utf8len(arg_38_0)
	local var_38_0 = 0
	local var_38_1 = 1

	while var_38_1 <= #arg_38_0 do
		local var_38_2 = string.byte(arg_38_0, var_38_1)

		var_38_1 = var_38_1 + chsize(var_38_2)
		var_38_0 = var_38_0 + 1
	end

	return var_38_0
end

function formatNumber(arg_39_0)
	if arg_39_0 == nil or type(arg_39_0) ~= "number" then
		return arg_39_0
	elseif arg_39_0 < 10000 then
		return arg_39_0
	end

	if arg_39_0 < 10000000 then
		return math.floor(arg_39_0 / 1000) .. "K"
	elseif arg_39_0 < 10000000000 then
		return math.floor(arg_39_0 / 1000000) .. "M"
	elseif arg_39_0 < 10000000000000 then
		return math.floor(arg_39_0 / 1000000000) .. "B"
	elseif arg_39_0 < 1e+16 then
		return math.floor(arg_39_0 / 1000000000000) .. "T"
	else
		return arg_39_0
	end
end
