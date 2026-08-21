local var_0_0 = class("ShipWordHelper")
local var_0_1 = pg.ship_skin_template
local var_0_2 = pg.ship_skin_words
local var_0_3 = pg.ship_skin_words_extra
local var_0_4 = pg.character_voice
local var_0_5 = pg.voice_actor_CN

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
	if var_0_6 and IsUnityEditor then
		print(...)
	end

	return
end

local function var_0_8(arg_2_0)
	if not arg_2_0 or arg_2_0 == "" or arg_2_0 == "nil" then
		return true
	end

	return
end

local function var_0_10(arg_4_0)
	return var_0_2[arg_4_0] ~= nil
end

local function var_0_11(arg_5_0)
	return ShipGroup.getDefaultSkin(var_0_1[arg_5_0].ship_group).id
end

local function var_0_12(arg_6_0, arg_6_1)
	arg_6_0 = arg_6_0 or ""

	if type(arg_6_0) == "table" then
		return arg_6_0
	else
		local var_6_0 = string.split(arg_6_0, "|")

		arg_6_1[1] = arg_6_1[1] or math.random(#var_6_0)

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

	local var_7_3 = var_7_1 == var_7_0

	if var_7_1 == var_7_0 and arg_7_0 ~= var_7_0 and arg_7_3 then
		arg_7_3[1] = true
	end

	local var_7_4 = var_0_12(var_7_2[arg_7_1], arg_7_2)

	if not var_7_3 and (type(var_7_4) == "table" and #var_7_4 == 0 or var_0_8(var_7_4)) then
		if arg_7_3 then
			arg_7_3[1] = true
		end

		var_7_2 = var_0_2[var_7_0]
	end

	return var_7_2
end

local function var_0_14(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1 = arg_8_1 or 0

	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		if iter_8_1[1] <= arg_8_1 then
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
	local var_9_2 = var_0_3[var_9_1]

	if not var_0_3[var_9_1] then
		return nil
	end

	local var_9_3 = var_9_2[arg_9_1]

	if var_9_1 == var_9_0 and arg_9_0 ~= var_9_0 and arg_9_4 then
		arg_9_4[1] = true
	end

	if var_0_8(var_9_3) then
		return nil
	end

	return var_0_14(var_9_3, arg_9_3, arg_9_2)
end

local function var_0_16(arg_10_0)
	local var_10_1 = PlayerPrefs.GetInt(CV_LANGUAGE_KEY .. var_0_1[arg_10_0].ship_group)

	if var_10_1 == 2 and underscore.any(getGameset("profile_cvchange_button_block")[2], function(arg_11_0)
		return arg_10_0 == arg_11_0
	end) then
		PlayerPrefs.SetInt(CV_LANGUAGE_KEY .. var_0_1[arg_10_0].ship_group, 1)
		PlayerPrefs.Save()

		var_10_1 = 1
	end

	return var_10_1
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

	local var_14_1 = (function(arg_15_0)
		if arg_14_0 == 2 and arg_15_0.voice_key_2 >= 0 then
			return arg_15_0.voice_key_2 or arg_15_0.voice_key
		end
	end)(var_0_2[arg_14_1])

	if var_14_1 ~= 0 then
		if var_14_1 == -2 then
			var_14_1 = var_14_0(var_0_2[var_0_11(arg_14_1)])
		end

		return var_14_1
	end
end

local function var_0_19(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_0 then
		local var_16_0
		local var_16_1
		local var_16_2 = var_0_16(arg_16_1)

		if var_16_2 == 2 then
			local var_16_3 = arg_16_0.voice_key_2 or arg_16_0.voice_key
			local var_16_4 = arg_16_2 == var_0_0.WORD_TYPE_MAIN

			if arg_16_2 == var_0_0.WORD_TYPE_MAIN then
				local var_16_5 = arg_16_2 .. arg_16_3[1] or arg_16_2
				local var_16_6 = var_0_4[var_16_5]
				local var_16_7 = var_0_4[var_16_5] and var_16_6.resource_key

				if not (var_0_4[var_16_5] and var_16_6.resource_key) and var_16_4 then
					var_16_7 = arg_16_2 .. "_" .. arg_16_3[1]
				end

				if var_16_3 ~= var_0_0.CV_KEY_BAN and var_16_7 then
					var_16_0 = var_0_18(var_16_2, arg_16_1)

					local var_16_8

					if arg_16_4 and var_16_3 == var_0_0.CV_KEY_REPALCE then
						if var_0_1[arg_16_1].group_index ~= 0 then
							var_16_8 = var_0_1[arg_16_1].group_index
						end
					end

					var_16_1 = var_0_17(var_16_7, var_16_0, var_16_8)
				end

				do return var_16_0, var_16_1 end
				return
			end
		end
	end
end

local function var_0_20(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = var_0_2[arg_17_0].voice_key == var_0_0.CV_KEY_BAN_NEW

	return var_0_0.ExistDifferentWord(arg_17_0, arg_17_1, arg_17_2) and var_17_0
end

local function var_0_21(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 or -1

	local var_18_0 = var_0_3[arg_18_0]

	if not var_0_3[arg_18_0] or not var_18_0.main_extra or var_18_0.main_extra == "" or type(var_18_0.main_extra) == "table" and #var_18_0.main_extra == 0 then
		return nil
	end

	local var_18_1
	local var_18_2 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0.main_extra) do
		local var_18_3 = iter_18_1[1]
		local var_18_4 = iter_18_1[2]

		if iter_18_1[1] <= arg_18_1 then
			if not var_18_1 or not (var_18_1 .. "|" .. var_18_4) then
				::label_18_0::

				var_18_1 = var_18_4
			end

			for iter_18_2, iter_18_3 in ipairs((string.split(var_18_4, "|"))) do
				var_18_2[iter_18_3] = var_18_3
			end
		end
	end

	return var_18_1, var_18_2
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
	local var_19_5, var_19_6 = var_0_15(arg_19_0, arg_19_1, {
		arg_19_2
	}, arg_19_4, {
		false
	})

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
		var_19_1 = var_0_13(arg_19_0, arg_19_1, {
			arg_19_2
		}, {
			false
		})

		if var_0_0.WORD_TYPE_MAIN == arg_19_1 then
			local var_19_9, var_19_10 = var_0_21(arg_19_0, arg_19_4)

			if var_19_9 then
				var_19_4 = {
					arg_19_2
				}
			end

			local var_19_11

			if var_19_9 and var_19_1 and var_19_1[arg_19_1] then
				var_19_11 = var_19_1[arg_19_1] .. "|" .. var_19_9
			elseif var_19_9 and (not var_19_1 or not var_19_1[arg_19_1]) then
				var_19_11 = var_19_9
			elseif not var_19_9 and var_19_1 and var_19_1[arg_19_1] then
				var_19_11 = var_19_1[arg_19_1]
			end

			var_19_0 = var_0_12(var_19_11, var_19_4)
			var_19_2 = var_19_10 and var_19_10[var_19_0]
		elseif var_19_1 then
			var_19_0 = var_0_12(var_19_1[arg_19_1], var_19_4)
		end
	end

	local var_19_12
	local var_19_13

	if not var_0_20(arg_19_0, arg_19_1, arg_19_2) then
		var_19_12, var_19_13 = var_0_19(var_19_1, arg_19_0, arg_19_1, var_19_4, not var_19_3[1])

		if var_19_13 and not var_0_8(var_19_5) and var_19_6 then
			var_19_13 = var_19_13 .. "_ex" .. var_19_6
		elseif var_19_13 and var_19_2 then
			var_19_13 = var_19_13 .. "_ex" .. var_19_2
		end
	end

	if type(var_19_0) ~= "table" then
		if var_19_0 and arg_19_3 then
			var_19_0 = SwitchSpecialChar(var_19_0, true)
		end

		var_19_0 = var_19_0 and HXSet.hxLan(var_19_0)
	end

	var_0_7("cv:", var_19_13, "cvkey:", var_19_12, "word:", var_19_0)

	return var_19_12, var_19_13, var_19_0
end

function var_0_0.RawGetWord(arg_20_0, arg_20_1)
	return var_0_2[arg_20_0][arg_20_1]
end

function var_0_0.RawGetCVKey(arg_21_0)
	return var_0_18(var_0_16(arg_21_0), arg_21_0)
end

function var_0_0.GetDefaultSkin(arg_22_0)
	return var_0_11(arg_22_0)
end

function var_0_0.GetMainSceneWordCnt(arg_23_0, arg_23_1)
	local var_23_0 = var_0_2[arg_23_0]

	if not var_0_2[arg_23_0] or not var_23_0[var_0_0.WORD_TYPE_MAIN] or var_23_0[var_0_0.WORD_TYPE_MAIN] == "" then
		var_23_0 = var_0_2[var_0_11(arg_23_0)]
	end

	local var_23_1 = 0

	if var_23_0 and var_23_0[var_0_0.WORD_TYPE_MAIN] and var_23_0[var_0_0.WORD_TYPE_MAIN] ~= "" then
		var_23_1 = #string.split(var_23_0[var_0_0.WORD_TYPE_MAIN], "|")
	end

	local var_23_2, var_23_3 = var_0_21(arg_23_0, arg_23_1)

	if var_23_2 then
		var_23_1 = var_23_1 + table.getCount(var_23_3)
	end

	return var_23_1
end

function var_0_0.GetL2dCvCalibrate(arg_24_0, arg_24_1, arg_24_2)
	if not var_0_1[arg_24_0] then
		return 0
	end

	if type(var_0_1[arg_24_0].l2d_voice_calibrate) == "table" and var_0_1[arg_24_0].l2d_voice_calibrate.use_event then
		return -1
	end

	if arg_24_1 == var_0_0.WORD_TYPE_MAIN then
		arg_24_1 = arg_24_1 .. "_" .. arg_24_2
	end

	return var_0_1[arg_24_0].l2d_voice_calibrate[arg_24_1]
end

function var_0_0.GetL2dSoundEffect(arg_25_0, arg_25_1, arg_25_2)
	if not var_0_1[arg_25_0] then
		return 0
	end

	if arg_25_1 == var_0_0.WORD_TYPE_MAIN then
		arg_25_1 = arg_25_1 .. "_" .. arg_25_2
	end

	return var_0_1[arg_25_0].l2d_se[arg_25_1]
end

function var_0_0.ExistVoiceKey(arg_26_0)
	return var_0_2[arg_26_0] and var_0_2[arg_26_0].voice_key ~= var_0_0.CV_KEY_BAN
end

function var_0_0.GetCVAuthor(arg_27_0)
	if var_0_16(arg_27_0) == 2 then
		local var_27_0 = var_0_1[arg_27_0].voice_actor_2 or var_0_1[arg_27_0].voice_actor

		return var_27_0 == var_0_0.CV_KEY_BAN and "-" or var_0_5[var_27_0].actor_name
	end
end

function var_0_0.GetCVList()
	for iter_28_0, iter_28_1 in ipairs(pg.character_voice.all) do
		if not pg.AssistantInfo.isDisableSpecialClick(pg.character_voice[iter_28_1].key) and pg.character_voice[iter_28_1].unlock_condition[1] >= 0 then
			({})[#{} + 1] = setmetatable({}, {
				__index = pg.character_voice[iter_28_1]
			})
		end
	end

	return {}
end

function var_0_0.ExistDifferentWord(arg_29_0, arg_29_1, arg_29_2)
	if var_0_11(arg_29_0) == arg_29_0 then
		return false
	end

	local var_29_0 = var_0_2[arg_29_0]
	local var_29_1 = string.find(arg_29_1, "main") and string.split(var_29_0[var_0_0.WORD_TYPE_MAIN], "|")[arg_29_2] or var_29_0[arg_29_1]

	return not not var_29_1 and var_29_1 ~= "" and var_29_1 ~= "nil"
end

function var_0_0.ExistDifferentExWord(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = var_0_11(arg_30_0)

	if arg_30_0 == var_30_0 then
		return false
	end

	local var_30_1 = arg_30_1

	if string.find(arg_30_1, "main") then
		var_30_1 = var_0_0.WORD_TYPE_MAIN
	end

	local var_30_2 = var_0_15(arg_30_0, var_30_1, {
		arg_30_2
	}, arg_30_3)
	local var_30_3 = var_0_15(var_30_0, var_30_1, {
		arg_30_2
	}, arg_30_3)

	return not var_0_8(var_30_2) and var_30_2 ~= var_30_3
end

function var_0_0.ExistDifferentMainExWord(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = var_0_11(arg_31_0)

	if arg_31_0 == var_31_0 then
		return false
	end

	local var_31_1, var_31_2, var_31_3 = var_0_0.GetWordAndCV(arg_31_0, arg_31_1, arg_31_2, nil, arg_31_3)
	local var_31_4, var_31_5, var_31_6 = var_0_0.GetWordAndCV(var_31_0, arg_31_1, arg_31_2, nil, arg_31_3)

	return not var_0_8(var_31_3) and var_31_3 ~= var_31_6
end

function var_0_0.ExistExCv(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0, var_32_1 = var_0_15(arg_32_0, arg_32_1, {
		arg_32_2
	}, arg_32_3)

	if var_32_0 then
		return HXSet.hxLan(var_32_0), var_32_1
	end

	return
end

function var_0_0.GetCvDataForShip(arg_33_0, arg_33_1)
	if arg_33_1 == "" then
		return nil
	end

	local var_33_0 = arg_33_0:getSkinId()
	local var_33_1 = arg_33_0:getCVIntimacy()
	local var_33_2 = string.split(arg_33_1, "_")
	local var_33_3
	local var_33_4
	local var_33_5
	local var_33_6
	local var_33_7
	local var_33_9

	if var_33_2[1] == "main" then
		var_33_3, var_33_5, var_33_4 = ShipWordHelper.GetWordAndCV(var_33_0, var_33_2[1], tonumber(var_33_2[2]), nil, var_33_1)
		var_33_6 = ShipWordHelper.GetL2dCvCalibrate(var_33_0, var_33_2[1], tonumber(var_33_2[2]))
		var_33_7 = ShipWordHelper.GetL2dSoundEffect(var_33_0, var_33_2[1], tonumber(var_33_2[2]))
	else
		var_33_3, var_33_5, var_33_4 = ShipWordHelper.GetWordAndCV(var_33_0, arg_33_1, nil, nil, var_33_1)
		var_33_6 = ShipWordHelper.GetL2dCvCalibrate(var_33_0, arg_33_1)
		var_33_7 = ShipWordHelper.GetL2dSoundEffect(var_33_0, arg_33_1)
		var_33_9 = var_33_3
	end

	return var_33_9, var_33_5, var_33_4, var_33_6, var_33_7, var_33_6 == -1
end

return var_0_0
