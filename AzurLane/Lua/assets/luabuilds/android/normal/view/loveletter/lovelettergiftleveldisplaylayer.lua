class = var_0_10000

local var_0_0 = "LoveLetterGiftLevelDisplayLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LoveLetterLevelDisplayUI"
end

var_0_1.optionsPath = {}

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.textBg

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("word_click_to_close"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.rtLevelUpPanel
	local var_2_2 = var_2.Find(var_2_1, "adapt/range/content/Text")

	i18n = var_2_1

	var_1_10001(var_2_2, var_2_1("loveactivity_ui_13"))

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.rtBg

	local function var_2_5()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)
	arg_2_0:BlurPanel(arg_2_0._tf)

	return
end

function var_0_1.SetLoveLetter(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	LoveLetterProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	arg_4_0.ll = var_2.GetGroupData(var_4_0, arg_4_1)

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:UpdateDisplay()

	return
end

function var_0_1.UpdateDisplay(arg_6_0)
	arg_6_0:UpdatePainting()
	arg_6_0:UpdateMedalSlider()
	arg_6_0:UpdateLoveLetterMedal()

	local var_6_1

	if arg_6_0.contextData.isLevelUp then
		local var_6_0 = arg_6_0.ll

		var_6_1 = var_6_1.GetDisplayLevel(var_6_0)
		pg = var_6_0

		if var_6_1 <= #var_6_0.lover_letter_content.get_id_list_by_ship_group[arg_6_0.ll.groupId] then
			arg_6_0:UpdateLevelUpPanel()

			setActive = var_6_1

			var_6_1(arg_6_0.rtLevelUpPanel, true)

			goto label_6_0
		end
	end

	setActive = var_6_1

	var_6_1(arg_6_0.rtLevelUpPanel, false)

	::label_6_0::

	arg_6_0.contextData.isLevelUp = nil

	return
end

function var_0_1.UpdatePainting(arg_7_0)
	local var_7_0 = arg_7_0.ll
	local var_7_1 = var_1.GetPainting(var_7_0)

	if arg_7_0.paint == var_7_1 then
		return
	end

	if arg_7_0.paint then
		retPaintingPrefab = var_2

		var_2(arg_7_0.rtPainting, arg_7_0.paint)

		arg_7_0.paint = nil
	end

	arg_7_0.paint = var_7_1
	setPaintingPrefabAsync = var_2

	var_2(arg_7_0.rtPainting, arg_7_0.paint, "biandui")

	return
end

function var_0_1.UpdateLoveLetterMedal(arg_8_0)
	local var_8_0 = arg_8_0.ll
	local var_8_1 = var_1.GetPrefabName(var_8_0)

	if arg_8_0.medalPath == var_8_1 then
		return
	end

	local var_8_2 = arg_8_0.rtNow
	local var_8_3 = var_2.Find(var_8_2, "medal")

	arg_8_0.medalPath = var_8_1
	setLoveLetterMedal = var_8_2

	var_8_2(var_8_3, arg_8_0.ll)

	return
end

function var_0_1.UpdateMedalSlider(arg_9_0)
	local var_9_0 = arg_9_0.ll
	local var_9_1, var_9_2 = var_1.GetDisplayExp(var_9_0)

	if var_9_2 == 0 then
		setSlider = var_1_10003

		local var_9_3 = arg_9_0.rtNow

		var_1_10003(var_4.Find(var_9_3, "Slider"), 0, 1, 1)
	else
		setSlider = var_1_10003

		local var_9_4 = arg_9_0.rtNow

		var_1_10003(var_4.Find(var_9_4, "Slider"), 0, var_9_2, var_9_1)
	end

	setText = var_1_10003

	local var_9_5 = arg_9_0.rtNow
	local var_9_6 = var_4.Find(var_9_5, "Text")

	string = var_9_5

	local var_9_7 = var_9_5.format

	setColorStr = var_6

	var_1_10003(var_9_6, var_9_7(var_6("%d", "#CF90A8") .. "/%d", var_9_1, var_9_2))

	return
end

function var_0_1.UpdateLevelUpPanel(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.lover_nation
	local var_10_1 = arg_10_0.ll
	local var_10_2 = var_10_0[var_2.GetNation(var_10_1)].letter_icon

	updateDrop = var_2

	local var_10_3 = arg_10_0.rtIconTpl

	Drop = var_1_10004

	var_2(var_10_3, var_1_10004.Create(var_10_2))

	onButton = var_2

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.rtIconTpl

	local function var_10_6()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.emit

		LoveLetterGiftLevelDisplayMediator = var_2_10002

		var_11_1(var_11_0, var_2_10002.ON_GO_COLLECTION)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_10_4, var_10_5, var_10_6, var_1_10006)

	return
end

function var_0_1.willExit(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	if arg_12_0.paint then
		retPaintingPrefab = var_1

		var_1(arg_12_0.rtPainting, arg_12_0.paint)

		arg_12_0.paint = nil
	end

	if arg_12_0.medalPath then
		returnLoveLetterMedal = var_1

		local var_12_0 = arg_12_0.rtNow
		local var_12_1 = var_2.Find(var_12_0, "medal")

		var_1(var_2.GetChild(var_12_1, 0))

		arg_12_0.medalPath = nil
	end

	return
end

return var_0_1
