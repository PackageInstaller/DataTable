local var_0_0 = class("ShipProfileExCvBtn", import(".ShipProfileCvBtn"))

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0_0.super.Init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	arg_1_0.favor = arg_1_5

	local var_1_0
	local var_1_1

	if string.find(arg_1_4.key, ShipWordHelper.WORD_TYPE_MAIN) then
		mainIndex = tonumber((string.gsub(arg_1_4.key, ShipWordHelper.WORD_TYPE_MAIN, "")))
		var_1_0, var_1_1 = ShipWordHelper.ExistExCv(arg_1_2.id, ShipWordHelper.WORD_TYPE_MAIN, mainIndex, arg_1_5)
	else
		var_1_0, var_1_1 = ShipWordHelper.ExistExCv(arg_1_2.id, arg_1_4.key, nil, arg_1_5)
	end

	if arg_1_0.wordData.cvPath and var_1_1 then
		arg_1_0.wordData.cvPath = arg_1_0.wordData.cvPath .. "_ex" .. var_1_1
	end

	arg_1_0.wordData.matchFavor = var_1_1
	arg_1_0.wordData.textContent = var_1_0
	arg_1_0.wordData.maxfavor = arg_1_5

	return
end

function var_0_0.Update(arg_2_0)
	local var_2_0 = arg_2_0.voice.unlock_condition[1] < 0
	local var_2_1 = arg_2_0.wordData.textContent == nil or arg_2_0.wordData.textContent == "nil" or arg_2_0.wordData.textContent == ""

	if arg_2_0.voice.unlock_condition[1] >= 0 then
		var_2_0 = var_2_1
	end

	setActive(arg_2_0._tf, not var_2_0)

	if not var_2_0 then
		arg_2_0:UpdateCvBtn()
		arg_2_0:UpdateIcon()
	end

	return
end

function var_0_0.UpdateCvBtn(arg_3_0)
	local var_3_0, var_3_1 = arg_3_0.shipGroup:VoiceReplayCodition(arg_3_0.voice)

	if var_3_0 then
		arg_3_0.nameTxt.text = arg_3_0.voice.voice_name .. "Ex" or "???"

		setActive(arg_3_0.tagDiff, (ShipWordHelper.ExistDifferentExWord(arg_3_0.skin.id, arg_3_0.voice.key, arg_3_0.wordData.mainIndex, arg_3_0.favor)))

		if not var_3_0 then
			onButton(nil, arg_3_0._tf, function()
				pg.TipsMgr.GetInstance():ShowTips(var_3_1)

				return
			end, SFX_PANEL)
		end

		return
	end
end

function var_0_0.isEx(arg_5_0)
	return arg_5_0.shipGroup:VoiceReplayCodition(arg_5_0.voice)
end

return var_0_0
