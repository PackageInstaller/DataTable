class = var_0_10000

local var_0_0 = var_0_10000("ShipProfileCvBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	go = var_1_10002
	arg_1_0._go = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "Text")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_2(var_1_1, var_4(var_1_10005))
	setActive = var_2

	local var_1_3 = arg_1_0._tf

	var_2(var_3.Find(var_1_3, "tag_common"), true)

	local var_1_4 = arg_1_0._tf

	arg_1_0.tagDiff = var_2.Find(var_1_4, "tag_diff")

	local var_1_5 = arg_1_0._tf

	arg_1_0.playIcon = var_2.Find(var_1_5, "play_icon")

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.shipGroup = arg_2_1
	arg_2_0.isLive2d = arg_2_3
	arg_2_0.skin = arg_2_2
	arg_2_0.voice = arg_2_4
	pg = var_1_10005
	arg_2_0.words = var_1_10005.ship_skin_words[arg_2_0.skin.id]

	local var_2_0 = arg_2_0.voice.key
	local var_2_1 = arg_2_1

	if arg_2_1.getIntimacyName(var_2_1, var_2_0) then
		setmetatable = var_2_1
		arg_2_0.voice = var_2_1({
			voice_name = var_6
		}, {
			__index = arg_2_4
		})
	end

	local var_2_2
	local var_2_3
	local var_2_4
	local var_2_5
	local var_2_6
	local var_2_7
	local var_2_8 = arg_2_4.key

	string = var_1_10014

	local var_2_9 = var_1_10014.find
	local var_2_10 = var_2_8

	ShipWordHelper = var_1_10016

	local var_2_11

	if var_2_9(var_2_10, var_1_10016.WORD_TYPE_MAIN) then
		string = var_2_11
		var_2_11 = var_2_11.gsub

		local var_2_12 = var_2_8

		ShipWordHelper = var_16
		var_2_11 = var_2_11(var_2_12, var_16.WORD_TYPE_MAIN, "")
		tonumber = var_2_12
		var_2_5 = var_2_12(var_2_11)
		ShipWordHelper = var_15

		local var_2_13 = var_15.GetWordAndCV
		local var_2_14 = arg_2_0.skin.id

		ShipWordHelper = var_17

		local var_2_15, var_2_16, var_2_17 = var_2_13(var_2_14, var_17.WORD_TYPE_MAIN, var_2_5)

		var_2_4 = var_2_17
		var_2_3 = var_2_16
		var_2_2 = var_2_15

		if arg_2_0.isLive2d then
			ShipWordHelper = var_15

			local var_2_18 = var_15.GetL2dCvCalibrate
			local var_2_19 = arg_2_0.skin.id

			ShipWordHelper = var_2_17
			var_2_6 = var_2_18(var_2_19, var_2_17.WORD_TYPE_MAIN, var_2_5)
			ShipWordHelper = var_15

			local var_2_20 = var_15.GetL2dSoundEffect
			local var_2_21 = arg_2_0.skin.id

			ShipWordHelper = var_17
			var_2_7 = var_2_20(var_2_21, var_17.WORD_TYPE_MAIN, var_2_5)
		end
	else
		ShipWordHelper = var_2_11
		var_2_2, var_2_3, var_2_4 = var_2_11.GetWordAndCV(arg_2_0.skin.id, var_2_8)

		if arg_2_0.isLive2d then
			ShipWordHelper = var_14
			var_2_6 = var_14.GetL2dCvCalibrate(arg_2_0.skin.id, var_2_8)
			ShipWordHelper = var_14
			var_2_7 = var_14.GetL2dSoundEffect(arg_2_0.skin.id, var_2_8)
		end
	end

	arg_2_0.l2dEventFlag = var_2_6 == -1
	var_2_6 = arg_2_0.l2dEventFlag and 0 or var_2_6
	arg_2_0.wordData = {
		maxfavor = 0,
		cvKey = var_2_2,
		cvPath = var_2_3,
		textContent = var_2_4,
		mainIndex = var_2_5,
		voiceCalibrate = var_2_6,
		se = var_2_7
	}

	return
end

function var_0_0.Update(arg_3_0)
	local var_3_0 = arg_3_0.voice.unlock_condition[1] < 0
	local var_3_1 = arg_3_0.wordData.textContent == nil or arg_3_0.wordData.textContent == "nil" or arg_3_0.wordData.textContent == ""
	local var_3_3

	if not arg_3_0.isLive2d then
		var_3_0 = var_3_0 or var_3_1
	else
		local var_3_2 = var_1.l2d_action

		var_3_3 = var_3_3.match

		local var_3_4 = "^"

		ShipWordHelper = var_1_10007
		var_3_3 = var_3_3(var_3_2, var_3_4 .. var_1_10007.WORD_TYPE_MAIN .. "_")
		var_3_0 = var_3_0 or var_3_1 and var_3_3
	end

	setActive = var_3_3

	var_3_3(arg_3_0._tf, not var_3_0)

	if not var_3_0 then
		arg_3_0:UpdateCvBtn()
		arg_3_0:UpdateIcon()
	end

	return
end

function var_0_0.UpdateCvBtn(arg_4_0)
	local var_4_0 = arg_4_0.voice
	local var_4_1 = arg_4_0.shipGroup
	local var_4_2, var_4_3 = var_2.VoiceReplayCodition(var_4_1, var_4_0)
	local var_4_4

	if not var_4_2 or not var_4_0.voice_name then
		var_4_4 = "???"
	end

	local var_4_5 = arg_4_0.nameTxt

	var_4_5.text = var_4_4
	ShipWordHelper = var_4_5

	local var_4_6 = var_4_5.ExistDifferentWord(arg_4_0.skin.id, var_4_0.key, arg_4_0.wordData.mainIndex)

	setActive = var_7

	var_7(arg_4_0.tagDiff, var_4_6)

	if not var_4_2 then
		onButton = var_7

		local var_4_7
		local var_4_8 = arg_4_0._tf

		local function var_4_9()
			pg = var_2_10000

			local var_5_0 = var_2_10000.TipsMgr.GetInstance()

			var_0.ShowTips(var_5_0, var_4_3)

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_4_7, var_4_8, var_4_9, var_1_10011)
	end

	return
end

function var_0_0.UpdateIcon(arg_6_0)
	local var_6_0

	if arg_6_0.voice.key == "unlock" then
		checkABExist = var_1
		var_6_0 = var_1("ui/skinunlockanim/star_level_unlock_anim_" .. arg_6_0.skin.id)
	else
		var_6_0 = false
	end

	if false then
		var_6_0 = true
	end

	setActive = var_1_10002

	var_1_10002(arg_6_0.playIcon, var_6_0)

	return
end

function var_0_0.L2dHasEvent(arg_7_0)
	return arg_7_0.l2dEventFlag
end

function var_0_0.isEx(arg_8_0)
	return false
end

function var_0_0.Destroy(arg_9_0)
	Destroy = var_1_10001

	var_1_10001(arg_9_0._go)

	removeOnButton = var_1_10001

	var_1_10001(arg_9_0._tf)

	return
end

return var_0_0
