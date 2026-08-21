local var_0_0 = class("MainCalibrationPage", import("view.base.BaseSubView"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.getUIName(arg_1_0)
	return "MainCalibrationUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.moveBtn = arg_2_0._tf:Find("move")
	arg_2_0.setBtn = arg_2_0._tf:Find("set")
	arg_2_0.scaleSetBtn = arg_2_0._tf:Find("scale_set")
	arg_2_0.backBtn = arg_2_0._tf:Find("back")
	arg_2_0.scaleContent = arg_2_0._tf:Find("scale_content")
	arg_2_0.resetBtn = arg_2_0._tf:Find("reset")
	arg_2_0.saveBtn = arg_2_0._tf:Find("save")
	arg_2_0.bgImage = arg_2_0._tf:Find("adapt/bg"):GetComponent(typeof(Image))
	arg_2_0.paintingTF = arg_2_0._parentTf:Find("paint")
	arg_2_0._bgTf = arg_2_0._parentTf:Find("paintBg")
	arg_2_0.l2dContainer = arg_2_0.paintingTF:Find("live2d")
	arg_2_0.spineContainer = arg_2_0.paintingTF:Find("spinePainting")
	arg_2_0.setBtnX = arg_2_0.setBtn.localPosition.x
	arg_2_0.scaleSetBtnX = arg_2_0.scaleSetBtn.localPosition.x
	arg_2_0.btnSelectX = arg_2_0.moveBtn.localPosition.x
	arg_2_0.showing = false
	arg_2_0.pageCG = GetOrAddComponent(arg_2_0._tf, typeof(CanvasGroup))
	arg_2_0.pageCG.ignoreParentGroups = true
	arg_2_0.pageCG.interactable = true
	arg_2_0.pageCG.blocksRaycasts = true

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.stateType = 0

	onButton(arg_3_0, arg_3_0._parentTf, function()
		if arg_3_0.stateType > 0 then
			return
		end

		if arg_3_0.showing then
			arg_3_0:exitToggle()
			arg_3_0:emit(NewMainScene.FOLD, false)
		end

		return
	end)
	onToggle(arg_3_0, arg_3_0.moveBtn, function(arg_5_0)
		if arg_5_0 then
			arg_3_0.stateType = var_0_2 or var_0_1

			arg_3_0:updateState()

			return
		end
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.setBtn, function(arg_6_0)
		if arg_6_0 then
			arg_3_0.stateType = var_0_3 or var_0_1

			arg_3_0:updateState()

			return
		end
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.scaleSetBtn, function(arg_7_0)
		if arg_7_0 then
			arg_3_0.stateType = var_0_4 or var_0_1

			arg_3_0:updateState()

			return
		end
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:exitToggle()
		arg_3_0:emit(NewMainScene.FOLD, false)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.saveBtn, function()
		arg_3_0:SavePostion()
		arg_3_0:updateState()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.resetBtn, function()
		if arg_3_0.stateType == var_0_3 then
			arg_3_0:ResetPostion()
		elseif arg_3_0.stateType == var_0_4 then
			arg_3_0:emit(NewMainScene.RESET_PAITING_SCALE)
		end

		return
	end, SFX_PANEL)
	arg_3_0:bind(NewMainScene.SET_SCALE_PART_CONTENT, function(arg_11_0, arg_11_1)
		setParent(arg_11_1, arg_3_0.scaleContent, true)

		return
	end)

	return
end

function var_0_0.Move(arg_12_0, arg_12_1)
	setToggleEnabled(arg_12_0.setBtn, not arg_12_1)
	arg_12_0:emit(NewMainScene.ENABLE_PAITING_MOVE, arg_12_1)

	return
end

function var_0_0.exitToggle(arg_13_0)
	if arg_13_0.stateType == var_0_2 then
		triggerToggle(arg_13_0.moveBtn, false)
	elseif arg_13_0.stateType == var_0_3 then
		triggerToggle(arg_13_0.setBtn, false)
	elseif arg_13_0.stateType == var_0_4 then
		triggerToggle(arg_13_0.scaleSetBtn, false)
	end

	arg_13_0.stateType = var_0_1

	return
end

function var_0_0.updateState(arg_14_0)
	setActive(arg_14_0.moveBtn, arg_14_0.stateType == var_0_1)
	setActive(arg_14_0.setBtn, arg_14_0.stateType == var_0_1)
	setActive(arg_14_0.scaleSetBtn, arg_14_0.stateType == var_0_1 and not arg_14_0.hideScaleSet)
	setActive(arg_14_0.scaleContent, false)

	if arg_14_0.stateType == var_0_2 then
		setActive(arg_14_0.moveBtn, true)
	elseif arg_14_0.stateType == var_0_3 then
		setActive(arg_14_0.setBtn, true)
	elseif arg_14_0.stateType == var_0_4 then
		setActive(arg_14_0.scaleContent, true)
		setActive(arg_14_0.scaleSetBtn, true)
	end

	setActive(arg_14_0.backBtn, arg_14_0.stateType == var_0_1)
	setActive(arg_14_0.resetBtn, arg_14_0.stateType > var_0_2)
	setActive(arg_14_0.saveBtn, arg_14_0.stateType > var_0_2)

	arg_14_0.bgImage.enabled = arg_14_0.stateType ~= var_0_1 and arg_14_0.stateType ~= var_0_2

	if arg_14_0.stateType > 0 then
		if arg_14_0.stateType == var_0_2 then
			LeanTween.moveLocalX(arg_14_0.moveBtn.gameObject, arg_14_0.btnSelectX, 0.2)
		elseif arg_14_0.stateType == var_0_3 then
			LeanTween.moveLocalX(arg_14_0.setBtn.gameObject, arg_14_0.btnSelectX, 0.2)
		elseif arg_14_0.stateType == var_0_4 then
			LeanTween.moveLocalX(arg_14_0.scaleSetBtn.gameObject, arg_14_0.btnSelectX, 0.2)
		end
	else
		LeanTween.moveLocalX(arg_14_0.moveBtn.gameObject, arg_14_0.btnSelectX, 0.2)
		LeanTween.moveLocalX(arg_14_0.setBtn.gameObject, arg_14_0.setBtnX, 0.2)
		LeanTween.moveLocalX(arg_14_0.scaleSetBtn.gameObject, arg_14_0.scaleSetBtnX, 0.2)
	end

	local var_14_0, var_14_1

	if arg_14_0.stateType == var_0_1 then
		arg_14_0:emit(NewMainScene.ENABLE_PAITING_MOVE, false)
		arg_14_0:emit(NewMainScene.ENABLE_PAITING_SCALE, false)
	elseif arg_14_0.stateType == var_0_2 or arg_14_0.stateType == var_0_3 then
		arg_14_0:emit(NewMainScene.ENABLE_PAITING_MOVE, true)
	elseif arg_14_0.stateType == var_0_4 then
		arg_14_0:emit(NewMainScene.ENABLE_PAITING_SCALE, true)

		var_14_0 = LeanTween.value
		var_14_1 = arg_14_0.stateType > 1 and 0 or -150
	end

	local var_14_2 = var_14_0(arg_14_0.backBtn.gameObject, var_14_1, arg_14_0.stateType > 1 and -150 or 0, 0.3):setOnUpdate(System.Action_float(function(arg_15_0)
		arg_14_0.resetBtn.anchoredPosition = Vector2(arg_15_0, arg_14_0.resetBtn.anchoredPosition.y)
		arg_14_0.saveBtn.anchoredPosition = Vector2(arg_15_0, arg_14_0.saveBtn.anchoredPosition.y)

		return
	end))

	return
end

function var_0_0.SetPostion(arg_16_0, arg_16_1)
	arg_16_0.bgImage.enabled = arg_16_1

	if arg_16_1 then
		local var_16_0 = arg_16_0.moveBtn.localPosition.x or arg_16_0.setBtnX

		LeanTween.moveLocalX(arg_16_0.setBtn.gameObject, var_16_0, 0.2)

		if arg_16_1 then
			(function()
				setActive(arg_16_0.moveBtn, not arg_16_1)
				setActive(arg_16_0.backBtn, not arg_16_1)
				setActive(arg_16_0.scaleSetBtn, not arg_16_1)

				return
			end)()
		else
			LeanTween.value(arg_16_0.backBtn.gameObject, arg_16_1 and 0 or -150, arg_16_1 and -150 or 0, 0.3):setOnUpdate(System.Action_float(function(arg_18_0)
				arg_16_0.resetBtn.anchoredPosition = Vector2(arg_18_0, arg_16_0.resetBtn.anchoredPosition.y)
				arg_16_0.saveBtn.anchoredPosition = Vector2(arg_18_0, arg_16_0.saveBtn.anchoredPosition.y)

				return
			end)):setOnComplete(System.Action(function()
				setActive(arg_16_0.moveBtn, not arg_16_1)
				setActive(arg_16_0.backBtn, not arg_16_1)
				setActive(arg_16_0.scaleSetBtn, not arg_16_1)

				return
			end))
		end

		arg_16_0:emit(NewMainScene.ENABLE_PAITING_MOVE, arg_16_1)

		return
	end
end

function var_0_0.SavePostion(arg_19_0)
	if arg_19_0.stateType == var_0_3 then
		local var_19_0 = arg_19_0.paintingTF.anchoredPosition
		local var_19_1 = arg_19_0.paintingTF.localScale.x
		local var_19_2 = arg_19_0.flagShip:getSkinId()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("secretary_pos_save"),
			onYes = function()
				getProxy(SettingsProxy):setSkinPosSetting(arg_19_0.flagShip, var_19_0.x, var_19_0.y, var_19_1)
				pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_pos_save_success"))
				arg_19_0:exitToggle()
				arg_19_0:emit(NewMainScene.FOLD, false)

				return
			end
		})
	elseif arg_19_0.stateType == var_0_4 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("secretary_pos_save"),
			onYes = function()
				arg_19_0:emit(NewMainScene.SAVE_PART_SCALE)
				pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_pos_save_success"))
				arg_19_0:exitToggle()
				arg_19_0:emit(NewMainScene.FOLD, false)

				return
			end
		})
	end

	return
end

function var_0_0.ResetPostion(arg_22_0)
	getProxy(SettingsProxy):resetSkinPosSetting(arg_22_0.flagShip)

	local var_22_0 = MainPaintingView.GetAssistantStatus(arg_22_0.flagShip)
	local var_22_1, var_22_2 = arg_22_0.shift:GetMeshImageShift()

	arg_22_0.paintingTF.anchoredPosition = var_22_1
	arg_22_0._bgTf.anchoredPosition = var_22_1

	local var_22_3, var_22_4 = arg_22_0.shift:GetL2dShift()

	if MainPaintingShift.IsLimitYPos(arg_22_0.flagShip:getPainting()) then
		var_22_3.y = MainPaintingShift.GetHalfBodyOffsetY(arg_22_0.paintingTF.parent, arg_22_0.l2dContainer)
	end

	arg_22_0.l2dContainer.anchoredPosition = var_22_3

	local var_22_5, var_22_6 = arg_22_0.shift:GetSpineShift()

	arg_22_0.spineContainer.anchoredPosition = var_22_5

	if var_22_0 == MainPaintingView.STATE_L2D then
		arg_22_0._bgTf.localScale = var_22_4
		arg_22_0.paintingTF.localScale = var_22_4
	elseif var_22_0 == MainPaintingView.STATE_SPINE_PAINTING then
		arg_22_0._bgTf.localScale = var_22_6
		arg_22_0.paintingTF.localScale = var_22_6
	else
		arg_22_0._bgTf.localScale = var_22_2
		arg_22_0.paintingTF.localScale = var_22_2
	end

	return
end

function var_0_0.ShowOrHide(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0.flagShip = arg_23_2
	arg_23_0.showing = arg_23_1

	local var_23_0 = MainPaintingView.GetAssistantStatus(arg_23_0.flagShip)

	arg_23_0.hideScaleSet = true

	local var_23_1 = pg.ship_skin_template[arg_23_0.flagShip:getSkinId()].part_scale

	if var_23_0 == MainPaintingView.STATE_PAINTING and var_23_1.paint and #var_23_1.paint > 0 then
		arg_23_0.hideScaleSet = false
	elseif var_23_0 == MainPaintingView.STATE_SPINE_PAINTING and var_23_1.spine and #var_23_1.spine > 0 then
		arg_23_0.hideScaleSet = false
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

function var_0_0.UpdateBg(arg_24_0, arg_24_1)
	if arg_24_1 == arg_24_0.bgName then
		return
	end

	LoadSpriteAsync("clutter/" .. arg_24_1, function(arg_25_0)
		if arg_24_0.exited then
			return
		end

		arg_24_0.bgImage.sprite = arg_25_0

		return
	end)

	arg_24_0.bgName = arg_24_1

	return
end

function var_0_0.Show(arg_26_0, arg_26_1)
	var_0_0.super.Show(arg_26_0)

	arg_26_0.shift = arg_26_1

	arg_26_0:DoBottomAnimation(0, 100)
	arg_26_0:DoLeftAnimation(0, -150, function()
		return
	end)

	return
end

function var_0_0.DoLeftAnimation(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	LeanTween.value(arg_28_0.backBtn.gameObject, arg_28_1, arg_28_2, 0.3):setOnUpdate(System.Action_float(function(arg_29_0)
		arg_28_0.backBtn.anchoredPosition = Vector2(arg_29_0, arg_28_0.backBtn.anchoredPosition.y)

		return
	end)):setOnComplete(System.Action(arg_28_3))

	return
end

function var_0_0.DoBottomAnimation(arg_30_0, arg_30_1, arg_30_2)
	LeanTween.value(arg_30_0.moveBtn.gameObject, arg_30_1, arg_30_2, 0.3):setOnUpdate(System.Action_float(function(arg_31_0)
		arg_30_0.moveBtn.anchoredPosition = Vector2(arg_30_0.moveBtn.anchoredPosition.x, arg_31_0)
		arg_30_0.setBtn.anchoredPosition = Vector2(arg_30_0.setBtn.anchoredPosition.x, arg_31_0)
		arg_30_0.scaleSetBtn.anchoredPosition = Vector2(arg_30_0.scaleSetBtn.anchoredPosition.x, arg_31_0)

		return
	end))

	return
end

function var_0_0.Hide(arg_32_0)
	arg_32_0:DoBottomAnimation(100, 0)
	arg_32_0:DoLeftAnimation(-150, 0, function()
		var_0_0.super.Hide(arg_32_0)

		return
	end)

	return
end

function var_0_0.Reset(arg_34_0)
	var_0_0.super.Reset(arg_34_0)

	arg_34_0.exited = false

	return
end

function var_0_0.OnDestroy(arg_35_0)
	arg_35_0.exited = true
	arg_35_0.bgName = nil

	return
end

return var_0_0
