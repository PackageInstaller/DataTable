local var_0_0 = class("ShipProfileMainExCvBtn", import(".ShipProfileCvBtn"))

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.shipGroup = arg_1_1
	arg_1_0.isLive2d = arg_1_3
	arg_1_0.skin = arg_1_2

	local var_1_0 = i18n("word_cv_key_main") .. arg_1_4 .. "Ex"

	if pg.character_voice["main" .. arg_1_4] then
		arg_1_0.voice = Clone(pg.character_voice["main" .. arg_1_4])
		arg_1_0.voice.voice_name = var_1_0
	else
		arg_1_0.voice = {
			spine_action = "normal",
			profile_index = 5,
			l2d_action = "main_3",
			key = "main" .. arg_1_4,
			voice_name = var_1_0,
			resource_key = "main_" .. arg_1_4,
			unlock_condition = {
				0,
				0
			}
		}
	end

	local var_1_1 = arg_1_0.voice

	arg_1_0.words = pg.ship_skin_words[arg_1_0.skin.id]

	local var_1_2
	local var_1_3
	local var_1_4
	local var_1_5
	local var_1_6
	local var_1_7
	local var_1_8 = arg_1_0.shipGroup:GetMaxIntimacy()

	if string.find(var_1_1.key, ShipWordHelper.WORD_TYPE_MAIN) then
		var_1_5 = tonumber((string.gsub(var_1_1.key, ShipWordHelper.WORD_TYPE_MAIN, "")))
		var_1_2, var_1_3, var_1_4 = ShipWordHelper.GetWordAndCV(arg_1_0.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_1_5, nil, var_1_8)

		if arg_1_0.isLive2d then
			var_1_6 = ShipWordHelper.GetL2dCvCalibrate(arg_1_0.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_1_5)
			var_1_7 = ShipWordHelper.GetL2dSoundEffect(arg_1_0.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_1_5)
		end
	else
		var_1_2, var_1_3, var_1_4 = ShipWordHelper.GetWordAndCV(arg_1_0.skin.id, var_1_1.key)

		if arg_1_0.isLive2d then
			var_1_6 = ShipWordHelper.GetL2dCvCalibrate(arg_1_0.skin.id, var_1_1.key)
			var_1_7 = ShipWordHelper.GetL2dSoundEffect(arg_1_0.skin.id, var_1_1.key)
		end
	end

	arg_1_0.wordData = {
		cvKey = var_1_2,
		cvPath = var_1_3,
		textContent = var_1_4,
		mainIndex = var_1_5,
		voiceCalibrate = var_1_6,
		se = var_1_7,
		maxfavor = var_1_8
	}

	return
end

function var_0_0.Update(arg_2_0)
	local var_2_0 = arg_2_0.voice.unlock_condition[1] < 0
	local var_2_1 = arg_2_0.wordData.textContent == nil or arg_2_0.wordData.textContent == "nil" or arg_2_0.wordData.textContent == ""

	if not arg_2_0.isLive2d then
		var_2_0 = var_2_0 or var_2_1
	else
		local var_2_2 = arg_2_0.voice.l2d_action:match("^" .. ShipWordHelper.WORD_TYPE_MAIN .. "_")

		var_2_0 = var_2_0 or var_2_1 and var_2_2
	end

	setActive(arg_2_0._tf, not var_2_0)

	if not var_2_0 then
		arg_2_0:UpdateCvBtn()
		arg_2_0:UpdateIcon()
	end

	return
end

function var_0_0.UpdateCvBtn(arg_3_0)
	if true then
		arg_3_0.nameTxt.text = arg_3_0.voice.voice_name or "???"

		setActive(arg_3_0.tagDiff, (ShipWordHelper.ExistDifferentMainExWord(arg_3_0.skin.id, arg_3_0.voice.key, arg_3_0.wordData.mainIndex, (arg_3_0.shipGroup:GetMaxIntimacy()))))

		return
	end
end

return var_0_0
