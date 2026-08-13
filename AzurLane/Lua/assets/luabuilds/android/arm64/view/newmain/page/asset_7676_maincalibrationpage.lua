class = var_0_10000

local var_0_0 = "MainCalibrationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function var_0_1.getUIName(arg_1_0)
	return "MainCalibrationUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.moveBtn = var_1.Find(var_2_0, "move")

	local var_2_1 = arg_2_0._tf

	arg_2_0.setBtn = var_1.Find(var_2_1, "set")

	local var_2_2 = arg_2_0._tf

	arg_2_0.scaleSetBtn = var_1.Find(var_2_2, "scale_set")

	local var_2_3 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_3, "back")

	local var_2_4 = arg_2_0._tf

	arg_2_0.scaleContent = var_1.Find(var_2_4, "scale_content")

	local var_2_5 = arg_2_0._tf

	arg_2_0.resetBtn = var_1.Find(var_2_5, "reset")

	local var_2_6 = arg_2_0._tf

	arg_2_0.saveBtn = var_1.Find(var_2_6, "save")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "adapt/bg")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.bgImage = var_2_9(var_2_8, var_4(var_1_10006))

	local var_2_10 = arg_2_0._parentTf

	arg_2_0.paintingTF = var_1.Find(var_2_10, "paint")

	local var_2_11 = arg_2_0._parentTf

	arg_2_0._bgTf = var_1.Find(var_2_11, "paintBg")

	local var_2_12 = arg_2_0.paintingTF

	arg_2_0.l2dContainer = var_1.Find(var_2_12, "live2d")

	local var_2_13 = arg_2_0.paintingTF

	arg_2_0.spineContainer = var_1.Find(var_2_13, "spinePainting")
	arg_2_0.setBtnX = arg_2_0.setBtn.localPosition.x
	arg_2_0.scaleSetBtnX = arg_2_0.scaleSetBtn.localPosition.x
	arg_2_0.btnSelectX = arg_2_0.moveBtn.localPosition.x
	arg_2_0.showing = false
	GetOrAddComponent = var_1

	local var_2_14 = arg_2_0._tf

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_2_0.pageCG = var_1(var_2_14, var_4(var_1_10006))
	arg_2_0.pageCG.ignoreParentGroups = true
	arg_2_0.pageCG.interactable = true
	arg_2_0.pageCG.blocksRaycasts = true

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.stateType = 0
	onButton = var_1

	var_1(arg_3_0, arg_3_0._parentTf, function()
		if arg_3_0.stateType > 0 then
			return
		end

		if arg_3_0.showing then
			local var_4_0 = arg_3_0

			var_0.exitToggle(var_4_0)

			local var_4_1 = arg_3_0
			local var_4_2 = var_0.emit

			NewMainScene = var_2_10003

			var_4_2(var_4_1, var_2_10003.FOLD, false)
		end

		return
	end)

	onToggle = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.moveBtn

	local function var_3_2(arg_5_0)
		local var_5_0 = arg_3_0
		local var_5_1

		if not arg_5_0 or not var_0_3 then
			var_5_1 = var_0_2
		end

		var_5_0.stateType = var_5_1

		local var_5_2 = arg_3_0

		var_1.updateState(var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onToggle = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.setBtn

	local function var_3_5(arg_6_0)
		local var_6_0 = arg_3_0
		local var_6_1

		if not arg_6_0 or not var_0_4 then
			var_6_1 = var_0_2
		end

		var_6_0.stateType = var_6_1

		local var_6_2 = arg_3_0

		var_1.updateState(var_6_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onToggle = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.scaleSetBtn

	local function var_3_8(arg_7_0)
		local var_7_0 = arg_3_0
		local var_7_1

		if not arg_7_0 or not var_0_5 then
			var_7_1 = var_0_2
		end

		var_7_0.stateType = var_7_1

		local var_7_2 = arg_3_0

		var_1.updateState(var_7_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.backBtn

	local function var_3_11()
		local var_8_0 = arg_3_0

		var_0.exitToggle(var_8_0)

		local var_8_1 = arg_3_0
		local var_8_2 = var_0.emit

		NewMainScene = var_2_10003

		var_8_2(var_8_1, var_2_10003.FOLD, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.saveBtn

	local function var_3_14()
		local var_9_0 = arg_3_0

		var_0.SavePostion(var_9_0)

		local var_9_1 = arg_3_0

		var_0.updateState(var_9_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_1

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.resetBtn

	local function var_3_17()
		if arg_3_0.stateType == var_0_4 then
			local var_10_0 = arg_3_0

			var_0.ResetPostion(var_10_0)
		elseif arg_3_0.stateType == var_0_5 then
			local var_10_1 = arg_3_0
			local var_10_2 = var_0.emit

			NewMainScene = var_2_10003

			var_10_2(var_10_1, var_2_10003.RESET_PAITING_SCALE)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_15, var_3_16, var_3_17, var_1_10006)

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.bind

	NewMainScene = var_3_16

	var_3_19(var_3_18, var_3_16.SET_SCALE_PART_CONTENT, function(arg_11_0, arg_11_1)
		setParent = var_2_10002

		var_2_10002(arg_11_1, arg_3_0.scaleContent, true)

		return
	end)

	return
end

function var_0_1.Move(arg_12_0, arg_12_1)
	setToggleEnabled = var_1_10002

	var_1_10002(arg_12_0.setBtn, not arg_12_1)

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.emit

	NewMainScene = var_5

	var_12_1(var_12_0, var_5.ENABLE_PAITING_MOVE, arg_12_1)

	return
end

function var_0_1.exitToggle(arg_13_0)
	if arg_13_0.stateType == var_0_3 then
		triggerToggle = var_1

		var_1(arg_13_0.moveBtn, false)
	elseif arg_13_0.stateType == var_0_4 then
		triggerToggle = var_1

		var_1(arg_13_0.setBtn, false)
	elseif arg_13_0.stateType == var_0_5 then
		triggerToggle = var_1

		var_1(arg_13_0.scaleSetBtn, false)
	end

	arg_13_0.stateType = var_0_2

	return
end

function var_0_1.updateState(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.moveBtn, arg_14_0.stateType == var_0_2)

	setActive = var_1_10001

	var_1_10001(arg_14_0.setBtn, arg_14_0.stateType == var_0_2)

	setActive = var_1_10001

	var_1_10001(arg_14_0.scaleSetBtn, arg_14_0.stateType == var_0_2 and not arg_14_0.hideScaleSet)

	setActive = var_1_10001

	var_1_10001(arg_14_0.scaleContent, false)

	if arg_14_0.stateType == var_0_3 then
		setActive = var_1

		var_1(arg_14_0.moveBtn, true)
	elseif arg_14_0.stateType == var_0_4 then
		setActive = var_1

		var_1(arg_14_0.setBtn, true)
	elseif arg_14_0.stateType == var_0_5 then
		setActive = var_1

		var_1(arg_14_0.scaleContent, true)

		setActive = var_1

		var_1(arg_14_0.scaleSetBtn, true)
	end

	setActive = var_1

	var_1(arg_14_0.backBtn, arg_14_0.stateType == var_0_2)

	setActive = var_1

	var_1(arg_14_0.resetBtn, arg_14_0.stateType > var_0_3)

	setActive = var_1

	var_1(arg_14_0.saveBtn, arg_14_0.stateType > var_0_3)

	arg_14_0.bgImage.enabled = arg_14_0.stateType ~= var_0_2 and arg_14_0.stateType ~= var_0_3

	if arg_14_0.stateType > 0 then
		if arg_14_0.stateType == var_0_3 then
			LeanTween = var_1

			var_1.moveLocalX(arg_14_0.moveBtn.gameObject, arg_14_0.btnSelectX, 0.2)
		elseif arg_14_0.stateType == var_0_4 then
			LeanTween = var_1

			var_1.moveLocalX(arg_14_0.setBtn.gameObject, arg_14_0.btnSelectX, 0.2)
		elseif arg_14_0.stateType == var_0_5 then
			LeanTween = var_1

			var_1.moveLocalX(arg_14_0.scaleSetBtn.gameObject, arg_14_0.btnSelectX, 0.2)
		end
	else
		LeanTween = var_1

		var_1.moveLocalX(arg_14_0.moveBtn.gameObject, arg_14_0.btnSelectX, 0.2)

		LeanTween = var_1

		var_1.moveLocalX(arg_14_0.setBtn.gameObject, arg_14_0.setBtnX, 0.2)

		LeanTween = var_1

		var_1.moveLocalX(arg_14_0.scaleSetBtn.gameObject, arg_14_0.scaleSetBtnX, 0.2)
	end

	if arg_14_0.stateType == var_0_2 then
		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.emit

		NewMainScene = var_4

		var_14_1(var_14_0, var_4.ENABLE_PAITING_MOVE, false)

		local var_14_2 = arg_14_0
		local var_14_3 = arg_14_0.emit

		NewMainScene = var_4

		var_14_3(var_14_2, var_4.ENABLE_PAITING_SCALE, false)
	elseif arg_14_0.stateType == var_0_3 or arg_14_0.stateType == var_0_4 then
		local var_14_4 = arg_14_0
		local var_14_5 = arg_14_0.emit

		NewMainScene = var_4

		var_14_5(var_14_4, var_4.ENABLE_PAITING_MOVE, true)
	elseif arg_14_0.stateType == var_0_5 then
		local var_14_6 = arg_14_0
		local var_14_7 = arg_14_0.emit

		NewMainScene = var_4

		var_14_7(var_14_6, var_4.ENABLE_PAITING_SCALE, true)
	end

	local var_14_8 = arg_14_0.stateType > 1 and -150 or 0
	local var_14_9 = arg_14_0.stateType
	local var_14_10 = 1 < var_14_9 and 0 or -150

	LeanTween = var_3

	local var_14_11 = var_3.value(arg_14_0.backBtn.gameObject, var_14_10, var_14_8, 0.3)
	local var_14_12 = var_3.setOnUpdate

	System = var_6

	local var_14_13 = var_14_12(var_14_11, var_6.Action_float(function(arg_15_0)
		local var_15_0 = arg_14_0.resetBtn

		Vector2 = var_2_10002
		var_15_0.anchoredPosition = var_2_10002(arg_15_0, arg_14_0.resetBtn.anchoredPosition.y)

		local var_15_1 = arg_14_0.saveBtn

		Vector2 = var_2
		var_15_1.anchoredPosition = var_2(arg_15_0, arg_14_0.saveBtn.anchoredPosition.y)

		return
	end))

	return
end

function var_0_1.SetPostion(arg_16_0, arg_16_1)
	local function var_16_0()
		setActive = var_2_10000

		var_2_10000(arg_16_0.moveBtn, not arg_16_1)

		setActive = var_2_10000

		var_2_10000(arg_16_0.backBtn, not arg_16_1)

		setActive = var_2_10000

		var_2_10000(arg_16_0.scaleSetBtn, not arg_16_1)

		return
	end

	arg_16_0.bgImage.enabled = arg_16_1

	local var_16_1

	if not arg_16_1 or not arg_16_0.moveBtn.localPosition.x then
		var_16_1 = arg_16_0.setBtnX
	end

	LeanTween = var_1_10004

	var_1_10004.moveLocalX(arg_16_0.setBtn.gameObject, var_16_1, 0.2)

	local var_16_2 = arg_16_1 and -150 or 0
	local var_16_3 = arg_16_1 and 0 or -150

	LeanTween = var_6

	local var_16_4 = var_6.value(arg_16_0.backBtn.gameObject, var_16_3, var_16_2, 0.3)
	local var_16_5 = var_6.setOnUpdate

	System = var_9

	local var_16_6 = var_16_5(var_16_4, var_9.Action_float(function(arg_18_0)
		local var_18_0 = arg_16_0.resetBtn

		Vector2 = var_2_10002
		var_18_0.anchoredPosition = var_2_10002(arg_18_0, arg_16_0.resetBtn.anchoredPosition.y)

		local var_18_1 = arg_16_0.saveBtn

		Vector2 = var_2
		var_18_1.anchoredPosition = var_2(arg_18_0, arg_16_0.saveBtn.anchoredPosition.y)

		return
	end))

	if arg_16_1 then
		var_16_0()
	else
		local var_16_7 = var_16_6
		local var_16_8 = var_16_6.setOnComplete

		System = var_10

		var_16_8(var_16_7, var_10.Action(var_16_0))
	end

	local var_16_9 = arg_16_0
	local var_16_10 = arg_16_0.emit

	NewMainScene = var_10

	var_16_10(var_16_9, var_10.ENABLE_PAITING_MOVE, arg_16_1)

	return
end

function var_0_1.SavePostion(arg_19_0)
	if arg_19_0.stateType == var_0_4 then
		local var_19_0 = arg_19_0.paintingTF.anchoredPosition
		local var_19_1 = arg_19_0.paintingTF.localScale.x

		var_1_10005 = arg_19_0.flagShip

		local var_19_2 = var_3.getSkinId(var_1_10005)

		pg = var_1_10004

		local var_19_3 = var_1_10004.MsgboxMgr.GetInstance()
		local var_19_4 = var_4.ShowMsgBox
		local var_19_5 = {}

		i18n = var_1_10008
		var_19_5.content = var_1_10008("secretary_pos_save")

		function var_19_5.onYes()
			getProxy = var_2_10000
			SettingsProxy = var_2_10002

			local var_20_0 = var_2_10000(var_2_10002)

			var_0.setSkinPosSetting(var_20_0, arg_19_0.flagShip, var_19_0.x, var_19_0.y, var_19_1)

			pg = var_0

			local var_20_1 = var_0.TipsMgr.GetInstance()
			local var_20_2 = var_0.ShowTips

			i18n = var_3

			var_20_2(var_20_1, var_3("secretary_pos_save_success"))

			local var_20_3 = arg_19_0

			var_0.exitToggle(var_20_3)

			local var_20_4 = arg_19_0
			local var_20_5 = var_0.emit

			NewMainScene = var_3

			var_20_5(var_20_4, var_3.FOLD, false)

			return
		end

		var_19_4(var_19_3, var_19_5)
	elseif arg_19_0.stateType == var_0_5 then
		pg = var_1

		local var_19_6 = var_1.MsgboxMgr.GetInstance()
		local var_19_7 = var_1.ShowMsgBox
		local var_19_8 = {}

		i18n = var_1_10005
		var_19_8.content = var_1_10005("secretary_pos_save")

		function var_19_8.onYes()
			local var_21_0 = arg_19_0
			local var_21_1 = var_0.emit

			NewMainScene = var_2_10003

			var_21_1(var_21_0, var_2_10003.SAVE_PART_SCALE)

			pg = var_21_1

			local var_21_2 = var_21_1.TipsMgr.GetInstance()
			local var_21_3 = var_0.ShowTips

			i18n = var_3

			var_21_3(var_21_2, var_3("secretary_pos_save_success"))

			local var_21_4 = arg_19_0

			var_0.exitToggle(var_21_4)

			local var_21_5 = arg_19_0
			local var_21_6 = var_0.emit

			NewMainScene = var_3

			var_21_6(var_21_5, var_3.FOLD, false)

			return
		end

		var_19_7(var_19_6, var_19_8)
	end

	return
end

function var_0_1.ResetPostion(arg_22_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_22_0 = var_1_10001(var_1_10003)

	var_1.resetSkinPosSetting(var_22_0, arg_22_0.flagShip)

	MainPaintingView = var_1

	local var_22_1 = var_1.GetAssistantStatus(arg_22_0.flagShip)
	local var_22_2 = arg_22_0.shift
	local var_22_3, var_22_4 = var_2.GetMeshImageShift(var_22_2)

	arg_22_0.paintingTF.anchoredPosition = var_22_3
	arg_22_0._bgTf.anchoredPosition = var_22_3

	local var_22_5 = arg_22_0.shift
	local var_22_6, var_22_7 = var_4.GetL2dShift(var_22_5)

	MainPaintingShift = var_22_5

	local var_22_8 = var_22_5.IsLimitYPos
	local var_22_9 = arg_22_0.flagShip

	if var_22_8(var_8.getPainting(var_22_9)) then
		MainPaintingShift = var_6
		var_22_6.y = var_6.GetHalfBodyOffsetY(arg_22_0.paintingTF.parent, arg_22_0.l2dContainer)
	end

	arg_22_0.l2dContainer.anchoredPosition = var_22_6

	local var_22_10 = arg_22_0.shift
	local var_22_11, var_22_12 = var_6.GetSpineShift(var_22_10)
	local var_22_13 = arg_22_0.spineContainer

	var_22_13.anchoredPosition = var_22_11
	MainPaintingView = var_22_13

	local var_22_14

	if var_22_1 == var_22_13.STATE_L2D then
		var_22_14 = arg_22_0._bgTf
		var_22_14.localScale = var_22_7
		var_22_14 = arg_22_0.paintingTF
		var_22_14.localScale = var_22_7
	else
		MainPaintingView = var_22_14

		if var_22_1 == var_22_14.STATE_SPINE_PAINTING then
			arg_22_0._bgTf.localScale = var_22_12
			arg_22_0.paintingTF.localScale = var_22_12
		else
			arg_22_0._bgTf.localScale = var_22_4
			arg_22_0.paintingTF.localScale = var_22_4
		end
	end

	return
end

function var_0_1.ShowOrHide(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0.flagShip = arg_23_2
	arg_23_0.showing = arg_23_1
	MainPaintingView = var_1_10005

	local var_23_0 = var_1_10005.GetAssistantStatus(arg_23_0.flagShip)

	arg_23_0.hideScaleSet = true
	pg = var_6

	local var_23_1 = var_6.ship_skin_template
	local var_23_2 = arg_23_0.flagShip
	local var_23_3 = var_23_1[var_7.getSkinId(var_23_2)].part_scale

	MainPaintingView = var_7

	if var_23_0 == var_7.STATE_PAINTING and var_23_3.paint and #var_23_3.paint > 0 then
		arg_23_0.hideScaleSet = false
	else
		MainPaintingView = var_7

		if var_23_0 == var_7.STATE_SPINE_PAINTING and var_23_3.spine and #var_23_3.spine > 0 then
			arg_23_0.hideScaleSet = false
		end
	end

	if arg_23_1 then
		arg_23_0:Show(arg_23_3)
		arg_23_0:UpdateBg(arg_23_4)
		arg_23_0:updateState()
	else
		arg_23_0:Hide()
	end

	return
end

function var_0_1.UpdateBg(arg_24_0, arg_24_1)
	if arg_24_1 == arg_24_0.bgName then
		return
	end

	LoadSpriteAsync = var_2

	var_2("clutter/" .. arg_24_1, function(arg_25_0)
		if arg_24_0.exited then
			return
		end

		arg_24_0.bgImage.sprite = arg_25_0

		return
	end)

	arg_24_0.bgName = arg_24_1

	return
end

function var_0_1.Show(arg_26_0, arg_26_1)
	var_0_1.super.Show(arg_26_0)

	arg_26_0.shift = arg_26_1

	arg_26_0:DoBottomAnimation(0, 100)
	arg_26_0:DoLeftAnimation(0, -150, function()
		return
	end)

	return
end

function var_0_1.DoLeftAnimation(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	LeanTween = var_1_10004

	local var_28_0 = var_1_10004.value(arg_28_0.backBtn.gameObject, arg_28_1, arg_28_2, 0.3)
	local var_28_1 = var_4.setOnUpdate

	System = var_7

	local var_28_2 = var_28_1(var_28_0, var_7.Action_float(function(arg_29_0)
		local var_29_0 = arg_28_0.backBtn

		Vector2 = var_2_10002
		var_29_0.anchoredPosition = var_2_10002(arg_29_0, arg_28_0.backBtn.anchoredPosition.y)

		return
	end))
	local var_28_3 = var_4.setOnComplete

	System = var_7

	var_28_3(var_28_2, var_7.Action(arg_28_3))

	return
end

function var_0_1.DoBottomAnimation(arg_30_0, arg_30_1, arg_30_2)
	LeanTween = var_1_10003

	local var_30_0 = var_1_10003.value(arg_30_0.moveBtn.gameObject, arg_30_1, arg_30_2, 0.3)
	local var_30_1 = var_3.setOnUpdate

	System = var_6

	var_30_1(var_30_0, var_6.Action_float(function(arg_31_0)
		local var_31_0 = arg_30_0.moveBtn

		Vector2 = var_2_10002
		var_31_0.anchoredPosition = var_2_10002(arg_30_0.moveBtn.anchoredPosition.x, arg_31_0)

		local var_31_1 = arg_30_0.setBtn

		Vector2 = var_2
		var_31_1.anchoredPosition = var_2(arg_30_0.setBtn.anchoredPosition.x, arg_31_0)

		local var_31_2 = arg_30_0.scaleSetBtn

		Vector2 = var_2
		var_31_2.anchoredPosition = var_2(arg_30_0.scaleSetBtn.anchoredPosition.x, arg_31_0)

		return
	end))

	return
end

function var_0_1.Hide(arg_32_0)
	arg_32_0:DoBottomAnimation(100, 0)
	arg_32_0:DoLeftAnimation(-150, 0, function()
		var_0_1.super.Hide(arg_32_0)

		return
	end)

	return
end

function var_0_1.Reset(arg_34_0)
	var_0_1.super.Reset(arg_34_0)

	arg_34_0.exited = false

	return
end

function var_0_1.OnDestroy(arg_35_0)
	arg_35_0.exited = true
	arg_35_0.bgName = nil

	return
end

return var_0_1
