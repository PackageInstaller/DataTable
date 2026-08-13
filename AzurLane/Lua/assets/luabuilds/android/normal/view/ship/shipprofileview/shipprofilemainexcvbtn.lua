class = var_0_10000

local var_0_0 = "ShipProfileMainExCvBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ShipProfileCvBtn"))

function var_0_1.Init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.shipGroup = arg_1_1
	arg_1_0.isLive2d = arg_1_3
	arg_1_0.skin = arg_1_2

	local var_1_0 = "main" .. arg_1_4

	pg = var_6

	local var_1_1 = var_6.character_voice[var_1_0]

	i18n = var_1_10007

	local var_1_2 = var_1_10007("word_cv_key_main") .. arg_1_4 .. "Ex"

	if var_1_1 then
		Clone = var_8
		arg_1_0.voice = var_8(var_1_1)
		arg_1_0.voice.voice_name = var_1_2
	else
		arg_1_0.voice = {
			spine_action = "normal",
			profile_index = 5,
			l2d_action = "main_3",
			key = var_1_0,
			voice_name = var_1_2,
			resource_key = "main_" .. arg_1_4,
			unlock_condition = {
				0,
				0
			}
		}
	end

	local var_1_3 = arg_1_0.voice

	pg = var_9
	arg_1_0.words = var_9.ship_skin_words[arg_1_0.skin.id]

	local var_1_4
	local var_1_5
	local var_1_6
	local var_1_7
	local var_1_8
	local var_1_9
	local var_1_10 = var_1_3.key
	local var_1_11 = arg_1_0.shipGroup
	local var_1_12 = var_16.GetMaxIntimacy(var_1_11)

	string = var_1_11

	local var_1_13 = var_1_11.find
	local var_1_14 = var_1_10

	ShipWordHelper = var_1_10019

	local var_1_15

	if var_1_13(var_1_14, var_1_10019.WORD_TYPE_MAIN) then
		string = var_1_15
		var_1_15 = var_1_15.gsub

		local var_1_16 = var_1_10

		ShipWordHelper = var_19
		var_1_15 = var_1_15(var_1_16, var_19.WORD_TYPE_MAIN, "")
		tonumber = var_1_16
		var_1_7 = var_1_16(var_1_15)
		ShipWordHelper = var_18

		local var_1_17 = var_18.GetWordAndCV
		local var_1_18 = arg_1_0.skin.id

		ShipWordHelper = var_20

		local var_1_19, var_1_20, var_1_21 = var_1_17(var_1_18, var_20.WORD_TYPE_MAIN, var_1_7, nil, var_1_12)

		var_1_6 = var_1_21
		var_1_5 = var_1_20
		var_1_4 = var_1_19

		if arg_1_0.isLive2d then
			ShipWordHelper = var_18

			local var_1_22 = var_18.GetL2dCvCalibrate
			local var_1_23 = arg_1_0.skin.id

			ShipWordHelper = var_1_21
			var_1_8 = var_1_22(var_1_23, var_1_21.WORD_TYPE_MAIN, var_1_7)
			ShipWordHelper = var_18

			local var_1_24 = var_18.GetL2dSoundEffect
			local var_1_25 = arg_1_0.skin.id

			ShipWordHelper = var_20
			var_1_9 = var_1_24(var_1_25, var_20.WORD_TYPE_MAIN, var_1_7)
		end
	else
		ShipWordHelper = var_1_15
		var_1_4, var_1_5, var_1_6 = var_1_15.GetWordAndCV(arg_1_0.skin.id, var_1_10)

		if arg_1_0.isLive2d then
			ShipWordHelper = var_17
			var_1_8 = var_17.GetL2dCvCalibrate(arg_1_0.skin.id, var_1_10)
			ShipWordHelper = var_17
			var_1_9 = var_17.GetL2dSoundEffect(arg_1_0.skin.id, var_1_10)
		end
	end

	arg_1_0.wordData = {
		cvKey = var_1_4,
		cvPath = var_1_5,
		textContent = var_1_6,
		mainIndex = var_1_7,
		voiceCalibrate = var_1_8,
		se = var_1_9,
		maxfavor = var_1_12
	}

	return
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.voice.unlock_condition[1] < 0
	local var_2_1 = arg_2_0.wordData.textContent == nil or arg_2_0.wordData.textContent == "nil" or arg_2_0.wordData.textContent == ""
	local var_2_3

	if not arg_2_0.isLive2d then
		var_2_0 = var_2_0 or var_2_1
	else
		local var_2_2 = var_1.l2d_action

		var_2_3 = var_2_3.match

		local var_2_4 = "^"

		ShipWordHelper = var_1_10007
		var_2_3 = var_2_3(var_2_2, var_2_4 .. var_1_10007.WORD_TYPE_MAIN .. "_")
		var_2_0 = var_2_0 or var_2_1 and var_2_3
	end

	setActive = var_2_3

	var_2_3(arg_2_0._tf, not var_2_0)

	if not var_2_0 then
		arg_2_0:UpdateCvBtn()
		arg_2_0:UpdateIcon()
	end

	return
end

function var_0_1.UpdateCvBtn(arg_3_0)
	local var_3_0 = arg_3_0.voice
	local var_3_1 = arg_3_0.shipGroup
	local var_3_2 = true
	local var_3_3
	local var_3_4

	if not var_3_2 or not var_3_0.voice_name then
		var_3_4 = "???"
	end

	arg_3_0.nameTxt.text = var_3_4

	local var_3_5 = arg_3_0.shipGroup
	local var_3_6 = var_6.GetMaxIntimacy(var_3_5)

	ShipWordHelper = var_3_5

	local var_3_7 = var_3_5.ExistDifferentMainExWord(arg_3_0.skin.id, var_3_0.key, arg_3_0.wordData.mainIndex, var_3_6)

	setActive = var_8

	var_8(arg_3_0.tagDiff, var_3_7)

	return
end

return var_0_1
