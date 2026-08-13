class = var_0_10000

local var_0_0 = "MainWordBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	findTF = var_3

	local var_1_0 = var_3(arg_1_1, "open")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	CanvasGroup = var_1_10008
	arg_1_0.wordOpen = var_1_1(var_1_0, var_6(var_1_10008))
	findTF = var_3

	local var_1_2 = var_3(arg_1_1, "close")
	local var_1_3 = var_3.GetComponent

	typeof = var_6
	CanvasGroup = var_1_10008
	arg_1_0.wordClose = var_1_3(var_1_2, var_6(var_1_10008))
	getProxy = var_3
	SettingsProxy = var_1_2

	local var_1_4 = var_3(var_1_2)

	arg_1_0.wordFlag = var_3.ShouldShipMainSceneWord(var_1_4)

	return
end

function var_0_1.OnClick(arg_2_0)
	arg_2_0.wordFlag = not arg_2_0.wordFlag
	getProxy = var_1
	SettingsProxy = var_1_10003

	local var_2_0 = var_1(var_1_10003)

	var_1.SaveMainSceneWordFlag(var_2_0, arg_2_0.wordFlag)

	if arg_2_0.wordFlag then
		i18n = var_2_1

		local var_2_1

		if not var_2_1("game_openwords") then
			i18n = var_2_1
			var_2_1 = var_2_1("game_stopwords")
		end

		pg = var_1_10002

		local var_2_2 = var_1_10002.TipsMgr.GetInstance()

		var_2.ShowTips(var_2_2, var_2_1)

		local var_2_3 = arg_2_0
		local var_2_4 = arg_2_0.emit

		NewMainScene = var_5

		var_2_4(var_2_3, var_5.CHAT_STATE_CHANGE, arg_2_0.wordFlag)
		arg_2_0:UpdateWordBtn(arg_2_0.wordFlag)

		return
	end
end

function var_0_1.Flush(arg_3_0, arg_3_1)
	arg_3_0:UpdateWordBtn(arg_3_0.wordFlag)

	return
end

function var_0_1.UpdateWordBtn(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 and 1 or 0

	arg_4_0.wordOpen.alpha = 1 - var_4_0
	arg_4_0.wordClose.alpha = var_4_0

	return
end

return var_0_1
