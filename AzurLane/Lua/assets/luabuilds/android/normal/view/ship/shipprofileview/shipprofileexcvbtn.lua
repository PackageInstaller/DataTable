class = var_0_10000

local var_0_0 = "ShipProfileExCvBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ShipProfileCvBtn"))

function var_0_1.Init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0_1.super.Init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	arg_1_0.favor = arg_1_5

	local var_1_0 = arg_1_4.key
	local var_1_1
	local var_1_2

	string = var_9

	local var_1_3 = var_9.find
	local var_1_4 = var_1_0

	ShipWordHelper = var_11

	local var_1_5

	if var_1_3(var_1_4, var_11.WORD_TYPE_MAIN) then
		string = var_1_5
		var_1_5 = var_1_5.gsub

		local var_1_6 = var_1_0

		ShipWordHelper = var_11
		var_1_5 = var_1_5(var_1_6, var_11.WORD_TYPE_MAIN, "")
		tonumber = var_1_6

		local var_1_7 = var_1_6(var_1_5)

		ShipWordHelper = mainIndex

		local var_1_8 = var_10.ExistExCv
		local var_1_9 = arg_1_2.id

		ShipWordHelper = var_12

		local var_1_10 = var_12.WORD_TYPE_MAIN

		mainIndex = var_1_10013
		var_1_1, var_1_2 = var_1_8(var_1_9, var_1_10, var_1_10013, arg_1_5)
	else
		ShipWordHelper = var_1_5
		var_1_1, var_1_2 = var_1_5.ExistExCv(arg_1_2.id, var_1_0, nil, arg_1_5)
	end

	if arg_1_0.wordData.cvPath and var_1_2 then
		arg_1_0.wordData.cvPath = arg_1_0.wordData.cvPath .. "_ex" .. var_1_2
	end

	arg_1_0.wordData.matchFavor = var_1_2
	arg_1_0.wordData.textContent = var_1_1
	arg_1_0.wordData.maxfavor = arg_1_5

	return
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.voice.unlock_condition[1] < 0
	local var_2_1 = arg_2_0.wordData.textContent == nil or arg_2_0.wordData.textContent == "nil" or arg_2_0.wordData.textContent == ""

	var_2_0 = var_2_0 or var_2_1
	setActive = var_1_10004

	var_1_10004(arg_2_0._tf, not var_2_0)

	if not var_2_0 then
		arg_2_0:UpdateCvBtn()
		arg_2_0:UpdateIcon()
	end

	return
end

function var_0_1.UpdateCvBtn(arg_3_0)
	local var_3_0 = arg_3_0.voice
	local var_3_1 = arg_3_0.shipGroup
	local var_3_2, var_3_3 = var_2.VoiceReplayCodition(var_3_1, var_3_0)
	local var_3_4

	if not var_3_2 or not (var_3_0.voice_name .. "Ex") then
		var_3_4 = "???"
	end

	local var_3_5 = arg_3_0.nameTxt

	var_3_5.text = var_3_4
	ShipWordHelper = var_3_5

	local var_3_6 = var_3_5.ExistDifferentExWord(arg_3_0.skin.id, var_3_0.key, arg_3_0.wordData.mainIndex, arg_3_0.favor)

	setActive = var_7

	var_7(arg_3_0.tagDiff, var_3_6)

	if not var_3_2 then
		onButton = var_7

		local var_3_7
		local var_3_8 = arg_3_0._tf

		local function var_3_9()
			pg = var_2_10000

			local var_4_0 = var_2_10000.TipsMgr.GetInstance()

			var_0.ShowTips(var_4_0, var_3_3)

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_3_7, var_3_8, var_3_9, var_1_10011)
	end

	return
end

function var_0_1.isEx(arg_5_0)
	local var_5_0 = arg_5_0.shipGroup

	return var_1.VoiceReplayCodition(var_5_0, arg_5_0.voice)
end

return var_0_1
