class = var_0_10000

local var_0_0 = "LoveLetterSelectCharConfirmLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LoveLetterGroupSelectUI"
end

var_0_1.optionsPath = {}

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.btnCancel
	local var_2_1 = var_2.Find(var_2_0, "cancel")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("text_cancel"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.btnConfirm
	local var_2_3 = var_2.Find(var_2_2, "confirm")

	i18n = var_2_2

	var_1_10001(var_2_3, var_2_2("text_confirm"))

	onButton = var_1_10001

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.btnCancel

	local function var_2_6()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_2_4, var_2_5, var_2_6, var_1_10005)

	onButton = var_1_10001

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.btnConfirm

	local function var_2_9()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		LoveLetterSelectCharConfirmMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.SELECT_CHAR, arg_2_0.ll.groupId)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_2_7, var_2_8, var_2_9, var_1_10005)
	arg_2_0:BlurPanel(arg_2_0._tf)

	return
end

function var_0_1.SetLoveLetter(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	LoveLetterProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)

	arg_5_0.ll = var_2.GetGroupData(var_5_0, arg_5_1)

	return
end

function var_0_1.SetActivity(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_6_0 = var_1_10002(var_1_10003)

	arg_6_0.activity = var_2.getActivityById(var_6_0, arg_6_1)

	if arg_6_0.contextData.isRepair then
		setText = var_2

		local var_6_1 = arg_6_0.textHelp

		i18n = var_4

		var_2(var_6_1, var_4("loveletter2018_ui_3"))
	else
		local var_6_2 = arg_6_0.activity
		local var_6_3, var_6_4 = var_2.GetChangeCount(var_6_2)

		setText = var_4

		local var_6_5 = arg_6_0.textHelp

		i18n = var_1_10006

		var_4(var_6_5, var_1_10006("loveactivity_ui_12", var_6_4 - var_6_3, var_6_4))
	end

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:UpdateDisplay()

	return
end

function var_0_1.UpdateDisplay(arg_8_0)
	arg_8_0:UpdatePainting()

	if arg_8_0.contextData.isRepair then
		setText = var_1

		local var_8_0 = arg_8_0.textInfo

		i18n = var_1_10003

		local var_8_1 = "loveletter2018_ui_2"
		local var_8_2 = arg_8_0.ll

		var_1(var_8_0, var_1_10003(var_8_1, var_1_10005.GetName(var_8_2)))
	else
		setText = var_1

		local var_8_3 = arg_8_0.textInfo

		i18n = var_1_10003

		local var_8_4 = "loveactivity_ui_11"

		setColorStr = var_1_10005

		local var_8_5 = arg_8_0.ll

		var_1(var_8_3, var_1_10003(var_8_4, var_1_10005(var_6.GetName(var_8_5), "#f3709e")))
	end

	return
end

function var_0_1.UpdatePainting(arg_9_0)
	local var_9_0 = arg_9_0.ll
	local var_9_1 = var_1.GetPainting(var_9_0)

	if arg_9_0.paint == var_9_1 then
		return
	end

	if arg_9_0.paint then
		retPaintingPrefab = var_2

		var_2(arg_9_0.rtPainting, arg_9_0.paint)

		arg_9_0.paint = nil
	end

	arg_9_0.paint = var_9_1
	setPaintingPrefabAsync = var_2

	var_2(arg_9_0.rtPainting, arg_9_0.paint, "biandui")

	return
end

function var_0_1.willExit(arg_10_0)
	arg_10_0:UnOverlayPanel(arg_10_0._tf)

	if arg_10_0.paint then
		retPaintingPrefab = var_1

		var_1(arg_10_0.rtPainting, arg_10_0.paint)

		arg_10_0.paint = nil
	end

	return
end

return var_0_1
