local var_0_0 = class("ShipProfileCvBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0._go = go(arg_1_1)
	arg_1_0.nameTxt = arg_1_0._tf:Find("Text"):GetComponent(typeof(Text))

	setActive(arg_1_0._tf:Find("tag_common"), true)

	arg_1_0.tagDiff = arg_1_0._tf:Find("tag_diff")
	arg_1_0.playIcon = arg_1_0._tf:Find("play_icon")

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.shipGroup = arg_2_1
	arg_2_0.isLive2d = arg_2_3
	arg_2_0.skin = arg_2_2
	arg_2_0.voice = arg_2_4
	arg_2_0.words = pg.ship_skin_words[arg_2_0.skin.id]

	local var_2_0 = arg_2_1:getIntimacyName(arg_2_0.voice.key)

	if var_2_0 then
		arg_2_0.voice = setmetatable({
			voice_name = var_2_0
		}, {
			__index = arg_2_4
		})
	end

	local var_2_1
	local var_2_2
	local var_2_3
	local var_2_4
	local var_2_5
	local var_2_6

	if string.find(arg_2_4.key, ShipWordHelper.WORD_TYPE_MAIN) then
		var_2_4 = tonumber((string.gsub(arg_2_4.key, ShipWordHelper.WORD_TYPE_MAIN, "")))
		var_2_1, var_2_2, var_2_3 = ShipWordHelper.GetWordAndCV(arg_2_0.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_2_4)

		if arg_2_0.isLive2d then
			var_2_5 = ShipWordHelper.GetL2dCvCalibrate(arg_2_0.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_2_4)
			var_2_6 = ShipWordHelper.GetL2dSoundEffect(arg_2_0.skin.id, ShipWordHelper.WORD_TYPE_MAIN, var_2_4)
		end
	else
		var_2_1, var_2_2, var_2_3 = ShipWordHelper.GetWordAndCV(arg_2_0.skin.id, arg_2_4.key)

		if arg_2_0.isLive2d then
			var_2_5 = ShipWordHelper.GetL2dCvCalibrate(arg_2_0.skin.id, arg_2_4.key)
			var_2_6 = ShipWordHelper.GetL2dSoundEffect(arg_2_0.skin.id, arg_2_4.key)
		end
	end

	arg_2_0.l2dEventFlag = var_2_5 == -1
	var_2_5 = arg_2_0.l2dEventFlag and 0 or var_2_5
	arg_2_0.wordData = {
		maxfavor = 0,
		cvKey = var_2_1,
		cvPath = var_2_2,
		textContent = var_2_3,
		mainIndex = var_2_4,
		voiceCalibrate = var_2_5,
		se = var_2_6
	}

	return
end

function var_0_0.Update(arg_3_0)
	local var_3_0 = arg_3_0.voice.unlock_condition[1] < 0
	local var_3_1 = arg_3_0.wordData.textContent == nil or arg_3_0.wordData.textContent == "nil" or arg_3_0.wordData.textContent == ""

	if not arg_3_0.isLive2d then
		var_3_0 = var_3_0 or var_3_1
	else
		local var_3_2 = arg_3_0.voice.l2d_action:match("^" .. ShipWordHelper.WORD_TYPE_MAIN .. "_")

		var_3_0 = var_3_0 or var_3_1 and var_3_2
	end

	setActive(arg_3_0._tf, not var_3_0)

	if not var_3_0 then
		arg_3_0:UpdateCvBtn()
		arg_3_0:UpdateIcon()
	end

	return
end

function var_0_0.UpdateCvBtn(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0.shipGroup:VoiceReplayCodition(arg_4_0.voice)

	if var_4_0 then
		arg_4_0.nameTxt.text = arg_4_0.voice.voice_name or "???"

		setActive(arg_4_0.tagDiff, (ShipWordHelper.ExistDifferentWord(arg_4_0.skin.id, arg_4_0.voice.key, arg_4_0.wordData.mainIndex)))

		if not var_4_0 then
			onButton(nil, arg_4_0._tf, function()
				pg.TipsMgr.GetInstance():ShowTips(var_4_1)

				return
			end, SFX_PANEL)
		end

		return
	end
end

function var_0_0.UpdateIcon(arg_6_0)
	setActive(arg_6_0.playIcon, arg_6_0.voice.key == "unlock" and checkABExist("ui/skinunlockanim/star_level_unlock_anim_" .. arg_6_0.skin.id))

	return
end

function var_0_0.L2dHasEvent(arg_7_0)
	return arg_7_0.l2dEventFlag
end

function var_0_0.isEx(arg_8_0)
	return false
end

function var_0_0.Destroy(arg_9_0)
	Destroy(arg_9_0._go)
	removeOnButton(arg_9_0._tf)

	return
end

return var_0_0
