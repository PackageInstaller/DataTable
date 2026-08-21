local var_0_0 = class("MainWordBtn", import(".MainBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.wordOpen = findTF(arg_1_1, "open"):GetComponent(typeof(CanvasGroup))
	arg_1_0.wordClose = findTF(arg_1_1, "close"):GetComponent(typeof(CanvasGroup))
	arg_1_0.wordFlag = getProxy(SettingsProxy):ShouldShipMainSceneWord()

	return
end

function var_0_0.OnClick(arg_2_0)
	arg_2_0.wordFlag = not arg_2_0.wordFlag

	getProxy(SettingsProxy):SaveMainSceneWordFlag(arg_2_0.wordFlag)

	local var_2_0 = arg_2_0.wordFlag and i18n("game_openwords") or i18n("game_stopwords")

	pg.TipsMgr.GetInstance():ShowTips(var_2_0)
	arg_2_0:emit(NewMainScene.CHAT_STATE_CHANGE, arg_2_0.wordFlag)
	arg_2_0:UpdateWordBtn(arg_2_0.wordFlag)

	return
end

function var_0_0.Flush(arg_3_0, arg_3_1)
	arg_3_0:UpdateWordBtn(arg_3_0.wordFlag)

	return
end

function var_0_0.UpdateWordBtn(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 and 1 or 0

	arg_4_0.wordOpen.alpha = 1 - (arg_4_1 and 1 or 0)
	arg_4_0.wordClose.alpha = var_4_0

	return
end

return var_0_0
