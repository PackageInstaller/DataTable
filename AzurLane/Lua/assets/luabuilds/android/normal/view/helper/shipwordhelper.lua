class = var_0_10000

local var_0_0 = var_0_10000("ShipWordHelper")

pg = var_1

local var_0_1 = var_1.ship_skin_template

pg = var_0_10002

local var_0_2 = var_0_10002.ship_skin_words

pg = var_0_10003

local var_0_3 = var_0_10003.ship_skin_words_extra

pg = var_0_10004

local var_0_4 = var_0_10004.character_voice

pg = var_0_10005

local var_0_5 = var_0_10005.voice_actor_CN

var_0_0.WORD_TYPE_MAIN = "main"
var_0_0.WORD_TYPE_SKILL = "skill"
var_0_0.WORD_TYPE_UNLOCK = "unlock"
var_0_0.WORD_TYPE_PROFILE = "profile"
var_0_0.WORD_TYPE_DROP = "drop_descrip"
var_0_0.WORD_TYPE_MVP = "win_mvp"
var_0_0.WORD_TYPE_LOSE = "lose"
var_0_0.WORD_TYPE_UPGRADE = "upgrade"
var_0_0.CV_KEY_REPALCE = 0
var_0_0.CV_KEY_BAN = -1
var_0_0.CV_KEY_BAN_NEW = -2
var_0_0.CVBattleKey = {
	hp = "hp",
	link2 = "link2",
	link4 = "link4",
	link5 = "link5",
	link7 = "link7",
	link3 = "link3",
	link6 = "link6",
	skill = "skill",
	link1 = "link1",
	lose = "lose",
	warcry = "warcry",
	mvp = "mvp"
}
var_0_0.CVGiftKey = {
	gift_prefer = "gift_prefer",
	present_like = "present_like"
}

local var_0_6 = false

local function var_0_7(...)
	if var_0_6 then
		IsUnityEditor = var_0

		if var_0 then
			print = var_0

			var_0(...)
		end
	end

	return
end

local function var_0_8(arg_2_0)
	if not arg_2_0 or arg_2_0 == "" or arg_2_0 == "nil" then
		return true
	end

	return
end

local function var_0_9(arg_3_0)
	return var_0_3[arg_3_0] ~= nil
end

local function var_0_10(arg_4_0)
	return var_0_2[arg_4_0] ~= nil
end

local function var_0_11(arg_5_0)
	local var_5_0 = var_0_1[arg_5_0].ship_group

	ShipGroup = var_1_10002

	return var_1_10002.getDefaultSkin(var_5_0).id
end

local function var_0_12(arg_6_0, arg_6_1)
	arg_6_0 = arg_6_0 or ""
	type = var_1_10002

	if var_1_10002(arg_6_0) == "table" then
		return arg_6_0
	else
		string = var_2

		local var_6_0 = var_2.split(arg_6_0, "|")
		local var_6_1

		if not arg_6_1[1] then
			math = var_6_1
			var_6_1 = var_6_1.random(#var_6_0)
		end

		arg_6_1[1] = var_6_1

		return var_6_0[arg_6_1[1]]
	end

	return
end

local function var_0_13(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = var_0_11(arg_7_0)
	local var_7_1 = var_0_10(arg_7_0) and arg_7_0 or var_7_0
	local var_7_2 = var_0_2[var_7_1]

	if not var_0_2[var_7_1] then
		return nil
	end

	if var_7_1 == var_7_0 and arg_7_0 ~= var_7_0 and arg_7_3 then
		arg_7_3[1] = true
	end

	local var_7_3 = var_0_12(var_7_2[arg_7_1], arg_7_2)

	if not var_7 then
		type = var_9

		if var_9(var_7_3) == "table" and #var_7_3 == 0 or var_0_8(var_7_3) then
			if arg_7_3 then
				arg_7_3[1] = true
			end

			var_7_2 = var_0_2[var_7_0]
		end
	end

	return var_7_2
end

local function var_0_14(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1 = arg_8_1 or 0

	local var_8_0

	ipairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(arg_8_0) do
		local var_8_1 = iter_8_1[1]
		local var_8_2 = iter_8_1[2]

		if var_8_1 <= arg_8_1 then
			var_8_0 = iter_8_1

			break
		end
	end

	if var_8_0 then
		return var_0_12(var_8_0[2], arg_8_2), var_8_0[1]
	end

	return
end

local function var_0_15(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0_11(arg_9_0)
	local var_9_1 = var_0_10(arg_9_0) and arg_9_0 or var_9_0

	if not var_0_3[var_9_1] then
		return nil
	end

	local var_9_2 = var_7[arg_9_1]

	if var_9_1 == var_9_0 and arg_9_0 ~= var_9_0 and arg_9_4 then
		arg_9_4[1] = true
	end

	if var_0_8(var_9_2) then
		return nil
	end

	return var_0_14(var_9_2, arg_9_3, arg_9_2)
end

local function var_0_16(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.ship_skin_words[arg_10_0]
	local var_10_1 = var_0_1[arg_10_0].ship_group

	PlayerPrefs = var_1_10003

	local var_10_2 = var_1_10003.GetInt

	CV_LANGUAGE_KEY = var_1_10004

	local var_10_5

	if var_10_2(var_1_10004 .. var_10_1) == 2 then
		underscore = var_4

		local var_10_3 = var_4.any

		getGameset = var_5

		if var_10_3(var_5("profile_cvchange_button_block")[2], function(arg_11_0)
			return arg_10_0 == arg_11_0
		end) then
			PlayerPrefs = var_4

			local var_10_4 = var_4.SetInt

			CV_LANGUAGE_KEY = var_5

			var_10_4(var_5 .. var_10_1, 1)

			PlayerPrefs = var_10_4

			var_10_4.Save()

			var_10_5 = 1
		end
	end

	return var_10_5
end

function var_0_0.GetLanguageSetting(arg_12_0)
	return var_0_16(arg_12_0)
end

local function var_0_17(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = "event:/cv/" .. arg_13_1 .. "/" .. arg_13_0

	if arg_13_2 then
		var_13_0 = var_13_0 .. "_" .. arg_13_2
	end

	return var_13_0
end

local function var_0_18(arg_14_0, arg_14_1)
	if not var_0_2[arg_14_1] then
		return -1
	end

	local var_14_2

	if (function(arg_15_0)
		local var_15_0

		if arg_14_0 ~= 2 or not (arg_15_0.voice_key_2 >= 0) or not arg_15_0.voice_key_2 then
			var_15_0 = arg_15_0.voice_key
		end

		return var_15_0
	end)(var_2) == 0 or var_14_2 == -2 then
		local var_14_0 = var_0_11(arg_14_1)
		local var_14_1 = var_0_2[var_14_0]

		var_14_2 = var_3(var_14_1)
	end

	return var_14_2
end

local function var_0_19(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_0 then
		local var_16_0
		local var_16_1
		local var_16_2

		if var_0_16(arg_16_1) ~= 2 or not arg_16_0.voice_key_2 then
			var_16_2 = arg_16_0.voice_key
		end

		local var_16_3

		if not (arg_16_2 == var_0_0.WORD_TYPE_MAIN) or not (arg_16_2 .. arg_16_3[1]) then
			var_16_3 = arg_16_2
		end

		local var_16_4

		if not (var_0_4[var_16_3] and var_11.resource_key) and var_9 then
			var_16_4 = arg_16_2 .. "_" .. arg_16_3[1]
		end

		if var_16_2 ~= var_0_0.CV_KEY_BAN and var_16_4 then
			var_16_0 = var_0_18(var_7, arg_16_1)

			local var_16_5

			if arg_16_4 and var_16_2 == var_0_0.CV_KEY_REPALCE and var_0_1[arg_16_1].group_index ~= 0 then
				var_16_5 = var_14
			end

			var_16_1 = var_0_17(var_16_4, var_16_0, var_16_5)
		end

		return var_16_0, var_16_1
	end

	return
end

local function var_0_20(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = var_0_0.ExistDifferentWord(arg_17_0, arg_17_1, arg_17_2)
	local var_17_1 = var_0_2[arg_17_0].voice_key == var_0_0.CV_KEY_BAN_NEW

	return var_17_0 and var_17_1
end

local function var_0_21(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 or -1

	if var_0_3[arg_18_0] and var_2.main_extra and var_2.main_extra ~= "" then
		type = var_3

		if var_3(var_2.main_extra) == "table" and #var_2.main_extra == 0 then
			return nil
		end

		local var_18_0
		local var_18_1 = {}

		ipairs = var_1_10005

		for iter_18_0, iter_18_1 in var_1_10005(var_2.main_extra) do
			local var_18_2 = iter_18_1[1]
			local var_18_3 = iter_18_1[2]

			if var_18_2 <= arg_18_1 then
				var_18_0 = var_18_0 and var_18_0 .. "|" .. var_18_3 or var_18_3
				string = var_1_10012
				var_1_10012 = var_1_10012.split(var_18_3, "|")
				ipairs = var_13

				for iter_18_2, iter_18_3 in var_13(var_1_10012) do
					var_18_1[iter_18_3] = var_18_2
				end
			end
		end

		return var_18_0, var_18_1
	end
end

function var_0_0.GetWordAndCV(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0
	local var_19_1
	local var_19_2
	local var_19_3 = {
		false
	}
	local var_19_4 = {
		arg_19_2
	}
	local var_19_5, var_19_6 = var_0_15(arg_19_0, arg_19_1, var_19_4, arg_19_4, var_19_3)

	if not var_0_8(var_19_5) then
		var_19_0 = var_19_5
		var_19_1 = var_0_13(arg_19_0, arg_19_1, var_19_4)
	else
		var_19_4 = {
			arg_19_2
		}
		var_19_3 = {
			false
		}
		var_19_1 = var_0_13(arg_19_0, arg_19_1, var_19_4, var_19_3)

		if var_0_0.WORD_TYPE_MAIN == arg_19_1 then
			local var_19_7
			local var_19_8 = {}
			local var_19_9, var_19_10 = var_0_21(arg_19_0, arg_19_4)
			local var_19_11 = var_19_10

			if var_19_9 then
				var_19_4 = {
					arg_19_2
				}
			end

			local var_19_12

			if var_12 and var_19_1 and var_19_1[arg_19_1] then
				var_19_12 = var_19_1[arg_19_1] .. "|" .. var_12
			elseif var_12 and (not var_19_1 or not var_19_1[arg_19_1]) then
				var_19_12 = var_12
			elseif not var_12 and var_19_1 and var_19_1[arg_19_1] then
				var_19_12 = var_19_1[arg_19_1]
			end

			var_19_0 = var_0_12(var_19_12, var_19_4)
			var_19_2 = var_19_11 and var_19_11[var_19_0]
		elseif var_19_1 then
			var_19_0 = var_0_12(var_19_1[arg_19_1], var_19_4)
		end
	end

	local var_19_13
	local var_19_14
	local var_19_15

	if not var_0_20(arg_19_0, arg_19_1, arg_19_2) then
		local var_19_16

		var_19_15, var_19_16 = var_0_19(var_19_1, arg_19_0, arg_19_1, var_19_4, not var_19_3[1])
		var_19_14 = var_19_16
		var_19_13 = var_19_15

		if var_19_14 and not var_0_8(var_19_5) and var_19_6 then
			var_19_14 = var_19_14 .. "_ex" .. var_19_6
		elseif var_19_14 and var_19_2 then
			var_19_14 = var_19_14 .. "_ex" .. var_19_2
		end
	end

	type = var_19_15

	if var_19_15(var_19_0) ~= "table" then
		if var_19_0 and arg_19_3 then
			SwitchSpecialChar = var_14
			var_19_0 = var_14(var_19_0, true)
		end

		if var_19_0 then
			HXSet = var_14
			var_19_0 = var_14.hxLan(var_19_0)
		end
	end

	var_0_7("cv:", var_19_14, "cvkey:", var_19_13, "word:", var_19_0)

	return var_19_13, var_19_14, var_19_0
end

function var_0_0.RawGetWord(arg_20_0, arg_20_1)
	return var_0_2[arg_20_0][arg_20_1]
end

function var_0_0.RawGetCVKey(arg_21_0)
	local var_21_0 = var_0_16(arg_21_0)

	return var_0_18(var_21_0, arg_21_0)
end

function var_0_0.GetDefaultSkin(arg_22_0)
	return var_0_11(arg_22_0)
end

function var_0_0.GetMainSceneWordCnt(arg_23_0, arg_23_1)
	local var_23_1

	if not var_0_2[arg_23_0] or not var_23_1[var_0_0.WORD_TYPE_MAIN] or var_23_1[var_0_0.WORD_TYPE_MAIN] == "" then
		local var_23_0 = var_0_11(arg_23_0)

		var_23_1 = var_0_2[var_23_0]
	end

	local var_23_2 = 0

	if var_23_1 and var_23_1[var_0_0.WORD_TYPE_MAIN] and var_23_1[var_0_0.WORD_TYPE_MAIN] ~= "" then
		string = var_4
		var_23_2 = #var_4.split(var_23_1[var_0_0.WORD_TYPE_MAIN], "|")
	end

	local var_23_3, var_23_4 = var_0_21(arg_23_0, arg_23_1)

	if var_23_3 then
		table = var_6
		var_23_2 = var_23_2 + var_6.getCount(var_23_4)
	end

	return var_23_2
end

function var_0_0.GetL2dCvCalibrate(arg_24_0, arg_24_1, arg_24_2)
	if not var_0_1[arg_24_0] then
		return 0
	end

	type = var_1_10004

	if var_1_10004(var_3.l2d_voice_calibrate) == "table" and var_3.l2d_voice_calibrate.use_event then
		return -1
	end

	if arg_24_1 == var_0_0.WORD_TYPE_MAIN then
		arg_24_1 = arg_24_1 .. "_" .. arg_24_2
	end

	return var_3.l2d_voice_calibrate[arg_24_1]
end

function var_0_0.GetL2dSoundEffect(arg_25_0, arg_25_1, arg_25_2)
	if not var_0_1[arg_25_0] then
		return 0
	end

	if arg_25_1 == var_0_0.WORD_TYPE_MAIN then
		arg_25_1 = arg_25_1 .. "_" .. arg_25_2
	end

	return var_3.l2d_se[arg_25_1]
end

function var_0_0.ExistVoiceKey(arg_26_0)
	return var_0_2[arg_26_0] and var_1.voice_key ~= var_0_0.CV_KEY_BAN
end

function var_0_0.GetCVAuthor(arg_27_0)
	local var_27_0 = var_0_1[arg_27_0]
	local var_27_1

	if var_0_16(arg_27_0) ~= 2 or not var_27_0.voice_actor_2 then
		var_27_1 = var_27_0.voice_actor
	end

	local var_27_2 = ""

	return var_27_1 == var_0_0.CV_KEY_BAN and "-" or var_0_5[var_27_1].actor_name
end

function var_0_0.GetCVList()
	local var_28_0 = {}

	ipairs = var_1_10001
	pg = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10001(var_1_10002.character_voice.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.character_voice[iter_28_1]
		pg = var_1_10007

		if not var_1_10007.AssistantInfo.isDisableSpecialClick(var_1_10006.key) then
			var_1_10007 = var_1_10006.unlock_condition[1]

			if 0 <= var_1_10007 then
				var_1_10007 = #var_28_0 + 1
				setmetatable = var_8
				var_28_0[var_1_10007] = var_8({}, {
					__index = var_1_10006
				})
			end
		end
	end

	return var_28_0
end

function var_0_0.ExistDifferentWord(arg_29_0, arg_29_1, arg_29_2)
	if var_0_11(arg_29_0) == arg_29_0 then
		return false
	end

	local var_29_0 = var_0_2[arg_29_0]
	local var_29_1

	string = var_1_10006

	if var_1_10006.find(arg_29_1, "main") then
		local var_29_2 = var_29_0[var_0_0.WORD_TYPE_MAIN]

		string = var_7
		var_29_1 = var_7.split(var_29_2, "|")[arg_29_2]
	else
		var_29_1 = var_29_0[arg_29_1]
	end

	return not not var_29_1 and var_29_1 ~= "" and var_29_1 ~= "nil"
end

function var_0_0.ExistDifferentExWord(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_0 == var_0_11(arg_30_0) then
		return false
	end

	local var_30_0 = arg_30_1

	string = var_1_10006

	if var_1_10006.find(arg_30_1, "main") then
		var_30_0 = var_0_0.WORD_TYPE_MAIN
	end

	local var_30_1 = var_0_15(arg_30_0, var_30_0, {
		arg_30_2
	}, arg_30_3)
	local var_30_2 = var_0_15(var_4, var_30_0, {
		arg_30_2
	}, arg_30_3)

	return not var_0_8(var_30_1) and var_30_1 ~= var_30_2
end

function var_0_0.ExistDifferentMainExWord(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_0 == var_0_11(arg_31_0) then
		return false
	end

	local var_31_0, var_31_1, var_31_2 = var_0_0.GetWordAndCV(arg_31_0, arg_31_1, arg_31_2, nil, arg_31_3)
	local var_31_3, var_31_4, var_31_5 = var_0_0.GetWordAndCV(var_4, arg_31_1, arg_31_2, nil, arg_31_3)

	return not var_0_8(var_31_2) and var_31_2 ~= var_31_5
end

function var_0_0.ExistExCv(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0, var_32_1 = var_0_15(arg_32_0, arg_32_1, {
		arg_32_2
	}, arg_32_3)

	if var_32_0 then
		HXSet = var_6

		return var_6.hxLan(var_32_0), var_32_1
	end

	return
end

function var_0_0.GetCvDataForShip(arg_33_0, arg_33_1)
	if arg_33_1 == "" then
		return nil
	end

	local var_33_0 = arg_33_0:getSkinId()
	local var_33_1 = arg_33_0
	local var_33_2 = arg_33_0.getCVIntimacy(var_33_1)

	string = var_33_1

	local var_33_3 = var_33_1.split(arg_33_1, "_")
	local var_33_4
	local var_33_5
	local var_33_6
	local var_33_7
	local var_33_8
	local var_33_9
	local var_33_10

	if var_33_3[1] == "main" then
		ShipWordHelper = var_33_10
		var_33_10 = var_33_10.GetWordAndCV

		local var_33_11 = var_33_0
		local var_33_12 = var_33_3[1]

		tonumber = var_1_10014

		local var_33_13, var_33_14

		var_33_10, var_33_13, var_33_14 = var_33_10(var_33_11, var_33_12, var_1_10014(var_33_3[2]), nil, var_33_2)
		var_33_5 = var_33_14
		var_33_6 = var_33_13
		var_33_4 = var_33_10
		ShipWordHelper = var_33_10
		var_33_10 = var_33_10.GetL2dCvCalibrate

		local var_33_15 = var_33_0
		local var_33_16 = var_33_3[1]

		tonumber = var_14
		var_33_7 = var_33_10(var_33_15, var_33_16, var_14(var_33_3[2]))
		ShipWordHelper = var_33_10
		var_33_10 = var_33_10.GetL2dSoundEffect

		local var_33_17 = var_33_0
		local var_33_18 = var_33_3[1]

		tonumber = var_14
		var_33_8 = var_33_10(var_33_17, var_33_18, var_14(var_33_3[2]))
	else
		ShipWordHelper = var_33_10

		local var_33_19, var_33_20, var_33_21 = var_33_10.GetWordAndCV(var_33_0, arg_33_1, nil, nil, var_33_2)

		var_33_5 = var_33_21
		var_33_6 = var_33_20
		var_33_4 = var_33_19
		ShipWordHelper = var_33_19
		var_33_7 = var_33_19.GetL2dCvCalibrate(var_33_0, arg_33_1)
		ShipWordHelper = var_11
		var_33_8 = var_11.GetL2dSoundEffect(var_33_0, arg_33_1)
	end

	local var_33_22 = var_33_7 == -1

	return var_33_4, var_33_6, var_33_5, var_33_7, var_33_8, var_33_22
end

return var_0_0
