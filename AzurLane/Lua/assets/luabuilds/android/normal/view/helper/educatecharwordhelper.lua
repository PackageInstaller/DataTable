class = var_0_10000

local var_0_0 = var_0_10000("EducateCharWordHelper")

var_0_0.WORD_KEY_CHRISTMAS = "shengdan"
var_0_0.WORD_KEY_NEWYEAR = "xinnian"
var_0_0.WORD_KEY_LUNARNEWYEAR = "chuxi"
var_0_0.WORD_KEY_VALENTINE = "qingrenjie"
var_0_0.WORD_KEY_MIDAUTUMNFESTIVAL = "zhongqiu"
var_0_0.WORD_KEY_ALLHALLOWSDAY = "wansheng"
var_0_0.WORD_KEY_TELL_TIME = "chime_"
var_0_0.WORD_KEY_ACT = "huodong"
var_0_0.WORD_KEY_CHANGE_TB = "genghuan"
var_0_0.WORD_KEY_LOGIN = "login"
pg = var_1

local var_0_1 = var_1.secretary_special_ship

pg = var_0_10002

local var_0_2 = var_0_10002.character_voice_special

pg = var_0_10003

local var_0_3 = var_0_10003.secretary_special_ship_expression

local function var_0_4(arg_1_0, arg_1_1)
	if not var_0_2[arg_1_0] then
		return nil, nil, nil
	end

	return "event:/educate-cv/" .. arg_1_1 .. "/" .. var_2.resource_key, var_2.resource_key
end

function var_0_0.GetWordAndCV(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3
	local var_2_4 = var_0_1[arg_2_0]
	local var_2_5 = arg_2_1

	string = var_1_10009

	local var_2_6 = var_1_10009.find
	local var_2_7 = arg_2_1

	ShipWordHelper = var_1_10011

	if var_2_6(var_2_7, var_1_10011.WORD_TYPE_MAIN) then
		string = var_9

		local var_2_8 = var_9.split(arg_2_1, "_")

		ShipWordHelper = var_10
		arg_2_1 = var_10.WORD_TYPE_MAIN
		tonumber = var_10

		local var_2_9

		if not var_2_8[2] then
			var_2_9 = "1"
		end

		local var_2_10 = var_10(var_2_9)
		local var_2_11

		if not var_2_4[arg_2_1] then
			var_2_11 = ""
		end

		string = var_1_10012
		var_2_2 = var_1_10012.split(var_2_11 or "", "|")[var_2_10] or ""
		var_2_5 = arg_2_1 .. "" .. var_2_10
	else
		var_2_2 = var_2_4[arg_2_1] or ""
	end

	local var_2_12

	if var_2_4.voice and var_2_4.voice ~= "" then
		var_2_0 = var_2_4.voice

		local var_2_13

		var_2_12, var_2_13 = var_0_4(var_2_5, var_2_0)
		var_2_3 = var_2_13
		var_2_1 = var_2_12
	end

	if var_2_2 and arg_2_2 then
		SwitchSpecialChar = var_2_12
		var_2_2 = var_2_12(var_2_2, true)
	end

	if var_2_2 then
		HXSet = var_2_12
		var_2_2 = var_2_12.hxLan(var_2_2)
	end

	return var_2_0, var_2_1, var_2_2, var_2_3
end

function var_0_0.ExistWord(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1[arg_3_0]

	string = var_1_10003

	local var_3_1 = var_1_10003.find
	local var_3_2 = arg_3_1

	ShipWordHelper = var_1_10005

	if var_3_1(var_3_2, var_1_10005.WORD_TYPE_MAIN) then
		string = var_3

		local var_3_3 = var_3.split(var_3_0.main, "|")

		string = var_4

		local var_3_4 = var_4.split(arg_3_1, "_")

		tonumber = var_5

		return var_5(var_3_4[2]) <= #var_3_3
	else
		return var_3_0[arg_3_1] ~= nil and var_3_0[arg_3_1] ~= ""
	end

	return
end

function var_0_0.RawGetCVKey(arg_4_0)
	return var_0_1[arg_4_0].voice
end

function var_0_0.GetMainSceneWordCnt(arg_5_0, arg_5_1)
	local var_5_0 = var_0_1[arg_5_0]
	local var_5_1 = 0

	if var_5_0 then
		ShipWordHelper = var_1_10004

		if var_5_0[var_1_10004.WORD_TYPE_MAIN] then
			ShipWordHelper = var_4

			if var_5_0[var_4.WORD_TYPE_MAIN] ~= "" then
				string = var_4

				local var_5_2 = var_4.split

				ShipWordHelper = var_1_10005
				var_5_1 = #var_5_2(var_5_0[var_1_10005.WORD_TYPE_MAIN], "|")
			end
		end
	end

	return var_5_1
end

function var_0_0.GetExpression(arg_6_0, arg_6_1)
	local var_6_0 = var_0_3[arg_6_0]
	local var_6_1 = ""

	string = var_1_10004

	local var_6_2 = var_1_10004.find
	local var_6_3 = arg_6_1

	ShipWordHelper = var_1_10006

	if var_6_2(var_6_3, var_1_10006.WORD_TYPE_MAIN) then
		string = var_4

		local var_6_4 = var_4.split(arg_6_1, "_")

		tonumber = var_5

		local var_6_5

		if not var_6_4[2] then
			var_6_5 = "1"
		end

		local var_6_6 = var_5(var_6_5)

		ShipWordHelper = var_6_5

		local var_6_7

		if not var_6_0[var_6_5.WORD_TYPE_MAIN] then
			var_6_7 = ""
		end

		string = var_1_10007
		var_6_1 = var_1_10007.split(var_6_7, "|")[var_6_6] or ""

		if var_6_1 == "0" or var_6_1 == "nil" then
			var_6_1 = ""
		end
	else
		var_6_1 = var_6_0[arg_6_1] or ""
	end

	return var_6_1
end

return var_0_0
