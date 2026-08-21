local var_0_0 = class("LoveLetterGiftLevelDisplayLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "LoveLetterLevelDisplayUI"
end

var_0_0.optionsPath = {}

function var_0_0.init(arg_2_0)
	setText(arg_2_0.textBg, i18n("word_click_to_close"))
	setText(arg_2_0.rtLevelUpPanel:Find("adapt/range/content/Text"), i18n("loveactivity_ui_13"))
	onButton(arg_2_0, arg_2_0.rtBg, function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)
	arg_2_0:BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.SetLoveLetter(arg_4_0, arg_4_1)
	arg_4_0.ll = getProxy(LoveLetterProxy):GetGroupData(arg_4_1)

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:UpdateDisplay()

	return
end

function var_0_0.UpdateDisplay(arg_6_0)
	arg_6_0:UpdatePainting()
	arg_6_0:UpdateMedalSlider()
	arg_6_0:UpdateLoveLetterMedal()

	if arg_6_0.contextData.isLevelUp and arg_6_0.ll:GetDisplayLevel() <= #pg.lover_letter_content.get_id_list_by_ship_group[arg_6_0.ll.groupId] then
		arg_6_0:UpdateLevelUpPanel()
		setActive(arg_6_0.rtLevelUpPanel, true)
	else
		setActive(arg_6_0.rtLevelUpPanel, false)
	end

	arg_6_0.contextData.isLevelUp = nil

	return
end

function var_0_0.UpdatePainting(arg_7_0)
	local var_7_0 = arg_7_0.ll:GetPainting()

	if arg_7_0.paint == var_7_0 then
		return
	end

	if arg_7_0.paint then
		retPaintingPrefab(arg_7_0.rtPainting, arg_7_0.paint)

		arg_7_0.paint = nil
	end

	arg_7_0.paint = var_7_0

	setPaintingPrefabAsync(arg_7_0.rtPainting, arg_7_0.paint, "biandui")

	return
end

function var_0_0.UpdateLoveLetterMedal(arg_8_0)
	local var_8_0 = arg_8_0.ll:GetPrefabName()

	if arg_8_0.medalPath == var_8_0 then
		return
	end

	local var_8_1 = arg_8_0.rtNow:Find("medal")

	arg_8_0.medalPath = var_8_0

	setLoveLetterMedal(var_8_1, arg_8_0.ll)

	return
end

function var_0_0.UpdateMedalSlider(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0.ll:GetDisplayExp()

	if var_9_1 == 0 then
		setSlider(arg_9_0.rtNow:Find("Slider"), 0, 1, 1)
	else
		setSlider(arg_9_0.rtNow:Find("Slider"), 0, var_9_1, var_9_0)
	end

	setText(arg_9_0.rtNow:Find("Text"), string.format(setColorStr("%d", "#CF90A8") .. "/%d", var_9_0, var_9_1))

	return
end

function var_0_0.UpdateLevelUpPanel(arg_10_0)
	updateDrop(arg_10_0.rtIconTpl, Drop.Create(pg.lover_nation[arg_10_0.ll:GetNation()].letter_icon))
	onButton(arg_10_0, arg_10_0.rtIconTpl, function()
		arg_10_0:emit(LoveLetterGiftLevelDisplayMediator.ON_GO_COLLECTION)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.willExit(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	if arg_12_0.paint then
		retPaintingPrefab(arg_12_0.rtPainting, arg_12_0.paint)

		arg_12_0.paint = nil
	end

	if arg_12_0.medalPath then
		returnLoveLetterMedal(arg_12_0.rtNow:Find("medal"):GetChild(0))

		arg_12_0.medalPath = nil
	end

	return
end

return var_0_0
