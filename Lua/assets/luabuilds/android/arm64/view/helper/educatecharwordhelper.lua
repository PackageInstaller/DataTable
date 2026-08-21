local var_0_0 = class("EducateCharWordHelper")

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

local var_0_1 = pg.secretary_special_ship
local var_0_2 = pg.character_voice_special
local var_0_3 = pg.secretary_special_ship_expression

local function var_0_4(arg_1_0, arg_1_1)
	if not var_0_2[arg_1_0] then
		return nil, nil, nil
	end

	return "event:/educate-cv/" .. arg_1_1 .. "/" .. var_0_2[arg_1_0].resource_key, var_0_2[arg_1_0].resource_key
end

function var_0_0.GetWordAndCV(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3
	local var_2_4 = var_0_1[arg_2_0]
	local var_2_5 = arg_2_1

	if string.find(arg_2_1, ShipWordHelper.WORD_TYPE_MAIN) then
		arg_2_1 = ShipWordHelper.WORD_TYPE_MAIN

		local var_2_6 = string.split(arg_2_1, "_")[2] or "1"
		local var_2_7 = tonumber(var_2_6)
		local var_2_8 = var_2_4[ShipWordHelper.WORD_TYPE_MAIN] or ""

		var_2_2 = string.split(var_2_8 or "", "|")[var_2_7] or ""
		var_2_5 = arg_2_1 .. "" .. var_2_7
	else
		var_2_2 = var_2_4[arg_2_1] or ""
	end

	if var_2_4.voice and var_2_4.voice ~= "" then
		var_2_0 = var_2_4.voice
		var_2_1, var_2_3 = var_0_4(var_2_5, var_2_4.voice)
	end

	if var_2_2 and arg_2_2 then
		var_2_2 = SwitchSpecialChar(var_2_2, true)
	end

	var_2_2 = var_2_2 and HXSet.hxLan(var_2_2)

	return var_2_0, var_2_1, var_2_2, var_2_3
end

function var_0_0.ExistWord(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1[arg_3_0]

	if string.find(arg_3_1, ShipWordHelper.WORD_TYPE_MAIN) then
		return tonumber(string.split(arg_3_1, "_")[2]) <= #string.split(var_3_0.main, "|")
	else
		return var_3_0[arg_3_1] ~= nil and var_3_0[arg_3_1] ~= ""
	end

	return
end

function var_0_0.RawGetCVKey(arg_4_0)
	return var_0_1[arg_4_0].voice
end

function var_0_0.GetMainSceneWordCnt(arg_5_0, arg_5_1)
	local var_5_0 = 0

	if var_0_1[arg_5_0] and var_0_1[arg_5_0][ShipWordHelper.WORD_TYPE_MAIN] and var_0_1[arg_5_0][ShipWordHelper.WORD_TYPE_MAIN] ~= "" then
		var_5_0 = #string.split(var_0_1[arg_5_0][ShipWordHelper.WORD_TYPE_MAIN], "|")
	end

	return var_5_0
end

function var_0_0.GetExpression(arg_6_0, arg_6_1)
	local var_6_0 = ""

	if string.find(arg_6_1, ShipWordHelper.WORD_TYPE_MAIN) then
		local var_6_1 = string.split(arg_6_1, "_")[2] or "1"
		local var_6_2 = var_0_3[arg_6_0][ShipWordHelper.WORD_TYPE_MAIN] or ""

		var_6_0 = string.split(var_6_2, "|")[tonumber(var_6_1)] or ""

		if var_6_0 == "0" or var_6_0 == "nil" then
			var_6_0 = ""
		end
	else
		var_6_0 = var_0_3[arg_6_0][arg_6_1] or ""
	end

	return var_6_0
end

return var_0_0
