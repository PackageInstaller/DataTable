local var_0_0 = class("MainPaintingView", import("..base.MainBaseView"))

var_0_0.STATE_PAINTING = 1
var_0_0.STATE_L2D = 2
var_0_0.STATE_SPINE_PAINTING = 3
var_0_0.STATE_EDUCATE_CHAR = 4
var_0_0.STATE_EDUCATE_SPINE = 5
var_0_0.STATE_EDUCATE_L2D = 6
var_0_0.MESH_POSITION_X_OFFSET = 145

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_3)

	arg_1_0._bgTf = arg_1_2
	arg_1_0._bgGo = arg_1_2.gameObject
	arg_1_0.l2dContainer = arg_1_1:Find("live2d")
	arg_1_0.spineContainer = arg_1_1:Find("spinePainting")
	arg_1_0.bgOffset = arg_1_0._bgTf.localPosition - arg_1_0._tf.localPosition
	arg_1_0.cg = arg_1_0._tf:GetComponent(typeof(CanvasGroup))
	arg_1_0.paintings = {
		MainMeshImagePainting.New(arg_1_0._tf, arg_1_0.event),
		MainLive2dPainting.New(arg_1_0._tf, arg_1_0.event),
		MainSpinePainting.New(arg_1_0._tf, arg_1_0.event, arg_1_0._bgGo),
		MainEducateCharPainting.New(arg_1_0._tf, arg_1_0.event),
		MainEducateSpinePainting.New(arg_1_0._tf, arg_1_0.event, arg_1_0._bgGo)
	}

	arg_1_0:Register()

	return
end

function var_0_0.Register(arg_2_0)
	arg_2_0:bind(TaskProxy.TASK_ADDED, function(arg_3_0)
		arg_2_0:OnStopVoice()

		return
	end)
	arg_2_0:bind(NewMainScene.CHAT_STATE_CHANGE, function(arg_4_0, arg_4_1)
		arg_2_0:OnChatStateChange(arg_4_1)

		return
	end)
	arg_2_0:bind(NewMainScene.ENABLE_PAITING_MOVE, function(arg_5_0, arg_5_1)
		arg_2_0:EnableOrDisableMove(arg_5_1)

		return
	end)
	arg_2_0:bind(NewMainScene.SAVE_PART_SCALE, function(arg_6_0, arg_6_1)
		arg_2_0.painting:SavePartScaleData()

		return
	end)
	arg_2_0:bind(NewMainScene.ENABLE_PAITING_SCALE, function(arg_7_0, arg_7_1)
		arg_2_0:EnableOrDisableScale(arg_7_1)

		return
	end)
	arg_2_0:bind(NewMainScene.RESET_PAITING_SCALE, function(arg_8_0, arg_8_1)
		arg_2_0.painting:ResetPartScale()

		return
	end)
	arg_2_0:bind(NewMainScene.ON_ENTER_DONE, function(arg_9_0)
		if arg_2_0.painting then
			arg_2_0.painting:TriggerEventAtFirstTime()
		end

		return
	end)
	arg_2_0:bind(NewMainScene.ENTER_SILENT_VIEW, function()
		arg_2_0.cg.blocksRaycasts = false
		arg_2_0.silentFlag = true

		for iter_10_0, iter_10_1 in ipairs(arg_2_0.paintings) do
			iter_10_1:PauseForSilent()
		end

		return
	end)
	arg_2_0:bind(NewMainScene.EXIT_SILENT_VIEW, function()
		arg_2_0.cg.blocksRaycasts = true
		arg_2_0.silentFlag = false

		for iter_11_0, iter_11_1 in ipairs(arg_2_0.paintings) do
			iter_11_1:ResumeForSilent()
		end

		return
	end)
	arg_2_0:bind(NewMainScene.RESET_L2D, function()
		if not arg_2_0.painting then
			return
		end

		if not isa(arg_2_0.painting, MainLive2dPainting) then
			return
		end

		arg_2_0.painting:ResetState()

		return
	end)

	function Live2dConst.UnLoadL2dPating()
		if not arg_2_0.reloadOnResume and arg_2_0.painting and isa(arg_2_0.painting, MainLive2dPainting) then
			arg_2_0.painting:SetContainerVisible(false)

			arg_2_0.reloadOnResume = true
		end

		return
	end

	return
end

function var_0_0.OnChatStateChange(arg_14_0, arg_14_1)
	if not arg_14_1 then
		arg_14_0.painting:StopChatAnimtion()
	end

	return
end

function var_0_0.OnStopVoice(arg_15_0)
	if arg_15_0.painting then
		arg_15_0.painting:OnStopVoice()
	end

	return
end

function var_0_0.IsLive2DState(arg_16_0)
	return var_0_0.STATE_L2D == arg_16_0.state
end

function var_0_0.IsLoading(arg_17_0)
	if arg_17_0.painting and arg_17_0.painting:IsLoading() then
		return true
	end

	return false
end

function var_0_0.Init(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0:ShouldReLoad(arg_18_1) then
		arg_18_0:Reload(arg_18_1)
	else
		arg_18_0.painting:Resume()
	end

	arg_18_0.shift = arg_18_2 or arg_18_0.shift

	assert(arg_18_0.shift)

	if arg_18_3 then
		arg_18_0:AdjustPositionWithAnim(arg_18_1)
	else
		arg_18_0:AdjustPosition(arg_18_1)
	end

	arg_18_0.painting:SetShift(arg_18_0.shift)

	return
end

function var_0_0.Reload(arg_19_0, arg_19_1)
	arg_19_0.ship = arg_19_1

	local var_19_0, var_19_1 = var_0_0.GetAssistantStatus(arg_19_1)

	if arg_19_0.painting then
		arg_19_0.painting:Unload()
	end

	arg_19_0.paintings[var_19_0]:Load(arg_19_1)

	arg_19_0.painting = arg_19_0.paintings[var_19_0]
	arg_19_0.state = var_19_0
	arg_19_0.bgToggle = PlayerPrefs.GetInt("paint_hide_other_obj_" .. arg_19_0.painting.paintingName, 0)
	arg_19_0.skinId = arg_19_1:getSkinId()

	return
end

function var_0_0.Refresh(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:Init(arg_20_1, arg_20_2)

	return
end

function var_0_0.ShouldReLoad(arg_21_0, arg_21_1)
	if not arg_21_0.painting or not arg_21_0.ship or not arg_21_0.state or not arg_21_0.bgToggle then
		return true
	end

	local var_21_0 = var_0_0.GetAssistantStatus(arg_21_1)

	if arg_21_0.skinId == arg_21_0.ship:getSkinId() and arg_21_1.id == arg_21_0.ship.id and arg_21_0.state == var_21_0 and arg_21_0.bgToggle == PlayerPrefs.GetInt("paint_hide_other_obj_" .. arg_21_0.painting.paintingName, 0) and arg_21_1:GetRecordPosKey() == arg_21_0.ship:GetRecordPosKey() and not arg_21_0.reloadOnResume then
		return false
	else
		if arg_21_0.reloadOnResume then
			arg_21_0.reloadOnResume = false
		end

		return true
	end

	return
end

function var_0_0.SetOnceLoadedCall(arg_22_0, arg_22_1)
	arg_22_0.painting:SetOnceLoadedCall(arg_22_1)

	return
end

function var_0_0.PlayChangeSkinActionIn(arg_23_0, arg_23_1)
	arg_23_0.painting:PlayChangeSkinActionIn(arg_23_1)

	return
end

function var_0_0.PlayChangeSkinActionOut(arg_24_0, arg_24_1)
	arg_24_0.painting:PlayChangeSkinActionOut(arg_24_1)

	return
end

function var_0_0.Disable(arg_25_0)
	if arg_25_0.painting then
		arg_25_0.painting:Pause()
	end

	return
end

function var_0_0.AdjustPositionWithAnim(arg_26_0, arg_26_1)
	LeanTween.cancel(go(arg_26_0._tf))
	LeanTween.cancel(go(arg_26_0._bgTf))

	local var_26_0 = arg_26_0:GetPositionAndScale(arg_26_1)

	LeanTween.moveLocal(go(arg_26_0._tf), var_26_0, 0.3):setEase(LeanTweenType.easeInOutExpo)
	LeanTween.moveLocal(go(arg_26_0._bgTf), var_26_0, 0.3):setEase(LeanTweenType.easeInOutExpo)

	local var_26_1, var_26_2 = arg_26_0.shift:GetSpineShift()

	LeanTween.moveLocal(go(arg_26_0.spineContainer), var_26_1, 0.3):setEase(LeanTweenType.easeInOutExpo)

	local var_26_3, var_26_4 = arg_26_0.shift:GetL2dShift()

	if arg_26_0.painting:IslimitYPos() then
		var_26_3.y = arg_26_0.painting:GetHalfBodyOffsetY()
	end

	LeanTween.moveLocal(go(arg_26_0.l2dContainer), var_26_3, 0.3):setEase(LeanTweenType.easeInOutExpo):setOnComplete(System.Action(function()
		arg_26_0:AdjustPosition(arg_26_1)

		return
	end))

	return
end

function var_0_0.AdjustPosition(arg_28_0, arg_28_1)
	local var_28_0, var_28_1 = arg_28_0:GetPositionAndScale(arg_28_1)

	arg_28_0._tf.anchoredPosition = var_28_0
	arg_28_0._bgTf.anchoredPosition = var_28_0

	local var_28_2, var_28_3 = arg_28_0.shift:GetL2dShift()

	if arg_28_0.painting:IslimitYPos() then
		var_28_2.y = arg_28_0.painting:GetHalfBodyOffsetY()
	end

	arg_28_0.l2dContainer.anchoredPosition = var_28_2

	local var_28_4, var_28_5 = arg_28_0.shift:GetSpineShift()

	arg_28_0.spineContainer.anchoredPosition = var_28_4

	local var_28_6, var_28_7, var_28_8 = getProxy(SettingsProxy):getSkinPosSetting(arg_28_1)

	if var_28_8 then
		arg_28_0._bgTf.localScale = Vector3(var_28_8, var_28_8, 1)
		arg_28_0._tf.localScale = Vector3(var_28_8, var_28_8, 1)
	elseif arg_28_0.state == var_0_0.STATE_L2D then
		arg_28_0._bgTf.localScale = var_28_3
		arg_28_0._tf.localScale = var_28_3
	elseif arg_28_0.state == var_0_0.STATE_SPINE_PAINTING then
		arg_28_0._bgTf.localScale = var_28_5
		arg_28_0._tf.localScale = var_28_5
	else
		arg_28_0._bgTf.localScale = var_28_1
		arg_28_0._tf.localScale = var_28_1
	end

	return
end

function var_0_0.GetPositionAndScale(arg_29_0, arg_29_1)
	local var_29_0, var_29_1, var_29_2 = getProxy(SettingsProxy):getSkinPosSetting(arg_29_1)
	local var_29_3 = Vector3(0, 0, 0)
	local var_29_4 = Vector3(1, 1, 1)

	if var_29_0 then
		var_29_3 = Vector3(var_29_0, var_29_1, 0)
		var_29_4 = Vector3(var_29_2, var_29_2, 1)
	else
		local var_29_5, var_29_6 = arg_29_0.shift:GetMeshImageShift()

		var_29_3 = var_29_5
		var_29_4 = var_29_6
	end

	return var_29_3, var_29_4
end

function var_0_0.GetAssistantStatus(arg_30_0)
	local var_30_0 = arg_30_0:getPainting()
	local var_30_1 = getProxy(SettingsProxy)
	local var_30_2 = HXSet.autoHxShiftPath("live2d/" .. var_30_0)
	local var_30_3 = var_0_0.Live2dIsDownload(var_30_2) and checkABExist(var_30_2)
	local var_30_4 = var_30_1:getCharacterSetting(arg_30_0.id, SHIP_FLAG_BG)

	if var_30_1:getCharacterSetting(arg_30_0.id, SHIP_FLAG_L2D) and var_30_3 then
		if isa(arg_30_0, VirtualEducateCharShip) then
			local var_30_5 = var_0_0.STATE_EDUCATE_L2D or var_0_0.STATE_L2D

			do return var_30_5, var_30_4 end

			goto label_30_0

			::label_30_0::

			if var_30_1:getCharacterSetting(arg_30_0.id, SHIP_FLAG_SP) and checkABExist((HXSet.autoHxShiftPath("spinepainting/" .. var_30_0))) then
				if isa(arg_30_0, VirtualEducateCharShip) then
					local var_30_6 = var_0_0.STATE_EDUCATE_SPINE or var_0_0.STATE_SPINE_PAINTING

					do return var_30_6, var_30_4 end

					goto label_30_0

					if isa(arg_30_0, VirtualEducateCharShip) then
						do
							local var_30_7 = var_0_0.STATE_EDUCATE_CHAR or var_0_0.STATE_PAINTING

							return var_30_7, var_30_4
						end

						return
					end
				end
			end
		end
	end
end

function var_0_0.OnBoundChange(arg_31_0)
	if arg_31_0.painting then
		arg_31_0.painting:UpdateBound()
	end

	return
end

function var_0_0.Live2dIsDownload(arg_32_0)
	local var_32_0 = GroupHelper.GetGroupMgrByName("L2D"):CheckF(arg_32_0)

	return var_32_0 == DownloadState.None or var_32_0 == DownloadState.UpdateSuccess
end

function var_0_0.Fold(arg_33_0, arg_33_1, arg_33_2)
	LeanTween.cancel(arg_33_0._tf.gameObject)
	LeanTween.cancel(arg_33_0._bgTf.gameObject)

	if arg_33_1 and not arg_33_0.silentFlag then
		local var_33_0 = Vector3(0 - arg_33_0.painting:GetOffset(), arg_33_0.shift:GetMeshImageShift().y, 0)

		LeanTween.moveLocal(arg_33_0._tf.gameObject, var_33_0, arg_33_2):setEase(LeanTweenType.easeInOutExpo)
		LeanTween.moveLocal(arg_33_0._bgTf.gameObject, var_33_0 - (arg_33_0._tf.localPosition - arg_33_0._bgTf.localPosition), arg_33_2):setEase(LeanTweenType.easeInOutExpo):setOnComplete(System.Action(function()
			arg_33_0.painting:Fold(arg_33_1, arg_33_2)

			return
		end))
	elseif arg_33_0.ship then
		local var_33_1 = arg_33_0:GetPositionAndScale(arg_33_0.ship)

		LeanTween.moveLocal(arg_33_0._tf.gameObject, var_33_1, arg_33_2):setEase(LeanTweenType.easeInOutExpo)
		LeanTween.moveLocal(arg_33_0._bgTf.gameObject, var_33_1, arg_33_2):setEase(LeanTweenType.easeInOutExpo):setOnComplete(System.Action(function()
			if arg_33_0.exited then
				return
			end

			arg_33_0.painting:Fold(arg_33_1, arg_33_2)

			return
		end))
	end

	return
end

function var_0_0.EnableOrDisableScale(arg_36_0, arg_36_1)
	arg_36_0.painting:EnableOrDisableMove(arg_36_1)
	arg_36_0.painting:OnEnablePartScale(arg_36_1)

	return
end

function var_0_0.EnableOrDisableMove(arg_37_0, arg_37_1)
	arg_37_0.painting:EnableOrDisableMove(arg_37_1)

	if arg_37_1 then
		arg_37_0:EnableDragAndZoom()
	else
		arg_37_0:DisableDragAndZoom()
	end

	return
end

function var_0_0.OnAsmrTurnning(arg_38_0, arg_38_1)
	arg_38_0.painting:OnAsmrTurnning(arg_38_1)

	return
end

function var_0_0.EnableDragAndZoom(arg_39_0)
	arg_39_0.isEnableDrag = true

	local var_39_0 = GetOrAddComponent(arg_39_0._tf.parent.gameObject, typeof(PinchZoom))
	local var_39_1 = GetOrAddComponent(arg_39_0._tf.parent.gameObject, typeof(EventTriggerListener))
	local var_39_2 = Vector3(0, 0, 0)

	var_39_1:AddBeginDragFunc(function(arg_40_0, arg_40_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if var_39_0.processing then
			return
		end

		setButtonEnabled(var_0, false)

		if Input.touchCount > 1 then
			return
		end

		var_39_2 = arg_39_0._tf.localPosition - var_0_0.Screen2Local(var_0.transform.parent, arg_40_1.position)

		return
	end)
	var_39_1:AddDragFunc(function(arg_41_0, arg_41_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if var_39_0.processing then
			return
		end

		if Input.touchCount > 1 then
			return
		end

		local var_41_0 = var_0_0.Screen2Local(var_0.transform.parent, arg_41_1.position)

		arg_39_0._tf.localPosition = arg_39_0.painting:IslimitYPos() and Vector3(var_41_0.x, arg_39_0._tf.localPosition.y, 0) + Vector3(var_39_2.x, 0, 0) or Vector3(var_41_0.x, var_41_0.y, 0) + var_39_2
		arg_39_0._bgTf.localPosition = arg_39_0.bgOffset + arg_39_0._tf.localPosition

		return
	end)
	var_39_1:AddDragEndFunc(function()
		setButtonEnabled(var_0, true)

		return
	end)

	if not arg_39_0.painting:IslimitYPos() then
		GetOrAddComponent(arg_39_0._tf.parent.gameObject, typeof(PinchZoom)).enabled = true
	end

	var_39_1.enabled = true
	Input.multiTouchEnabled = true
	arg_39_0.cg.blocksRaycasts = false

	arg_39_0:AdjustPosition(arg_39_0.ship)

	return
end

function var_0_0.DisableDragAndZoom(arg_43_0)
	if arg_43_0.isEnableDrag then
		local var_43_0 = arg_43_0._tf.parent:GetComponent(typeof(EventTriggerListener))

		ClearEventTrigger(var_43_0)

		var_43_0.enabled = false
		arg_43_0._tf.parent:GetComponent(typeof(PinchZoom)).enabled = false
		arg_43_0.cg.blocksRaycasts = true
		arg_43_0.isEnableDrag = false
	end

	arg_43_0:AdjustPosition(arg_43_0.ship)

	return
end

function var_0_0.Dispose(arg_44_0)
	var_0_0.super.Dispose(arg_44_0)
	arg_44_0:DisableDragAndZoom()

	if arg_44_0.painting then
		arg_44_0.painting:Unload()
	end

	arg_44_0.painting = nil

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.paintings) do
		iter_44_1:Dispose()
	end

	arg_44_0.paintings = nil

	return
end

function var_0_0.Screen2Local(arg_45_0, arg_45_1)
	local var_45_9000
	local var_45_0 = GameObject.Find("UICamera")

	return Vector3(var_45_0.x, LuaHelper.ScreenToLocal(arg_45_0:GetComponent("RectTransform"), arg_45_1, (var_45_0.GetComponent(var_45_9000, "Camera"))).y, 0)
end

return var_0_0
