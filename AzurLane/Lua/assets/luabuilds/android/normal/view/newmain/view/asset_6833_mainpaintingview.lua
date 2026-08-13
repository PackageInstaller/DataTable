class = var_0_10000

local var_0_0 = "MainPaintingView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.MainBaseView"))

var_0_1.STATE_PAINTING = 1
var_0_1.STATE_L2D = 2
var_0_1.STATE_SPINE_PAINTING = 3
var_0_1.STATE_EDUCATE_CHAR = 4
var_0_1.STATE_EDUCATE_SPINE = 5
var_0_1.STATE_EDUCATE_L2D = 6
var_0_1.MESH_POSITION_X_OFFSET = 145

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_3)

	arg_1_0._bgTf = arg_1_2
	arg_1_0._bgGo = arg_1_2.gameObject
	arg_1_0.l2dContainer = arg_1_1:Find("live2d")
	arg_1_0.spineContainer = arg_1_1:Find("spinePainting")
	arg_1_0.bgOffset = arg_1_0._bgTf.localPosition - arg_1_0._tf.localPosition

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_4.GetComponent

	typeof = var_6
	CanvasGroup = var_7
	arg_1_0.cg = var_1_1(var_1_0, var_6(var_7))

	local var_1_2 = {}

	MainMeshImagePainting = var_1_0
	var_1_2[1] = var_1_0.New(arg_1_0._tf, arg_1_0.event)
	MainLive2dPainting = var_5
	var_1_2[2] = var_5.New(arg_1_0._tf, arg_1_0.event)
	MainSpinePainting = var_5
	var_1_2[3] = var_5.New(arg_1_0._tf, arg_1_0.event, arg_1_0._bgGo)
	MainEducateCharPainting = var_5
	var_1_2[4] = var_5.New(arg_1_0._tf, arg_1_0.event)
	MainEducateSpinePainting = var_5
	var_1_2[5] = var_5.New(arg_1_0._tf, arg_1_0.event, arg_1_0._bgGo)
	arg_1_0.paintings = var_1_2

	arg_1_0:Register()

	return
end

function var_0_1.Register(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.bind

	TaskProxy = var_1_10003

	var_2_1(var_2_0, var_1_10003.TASK_ADDED, function(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnStopVoice(var_3_0)

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.bind

	NewMainScene = var_3

	var_2_3(var_2_2, var_3.CHAT_STATE_CHANGE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnChatStateChange(var_4_0, arg_4_1)

		return
	end)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.bind

	NewMainScene = var_3

	var_2_5(var_2_4, var_3.ENABLE_PAITING_MOVE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.EnableOrDisableMove(var_5_0, arg_5_1)

		return
	end)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.bind

	NewMainScene = var_3

	var_2_7(var_2_6, var_3.SAVE_PART_SCALE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0.painting

		var_2.SavePartScaleData(var_6_0)

		return
	end)

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.bind

	NewMainScene = var_3

	var_2_9(var_2_8, var_3.ENABLE_PAITING_SCALE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_2_0

		var_2.EnableOrDisableScale(var_7_0, arg_7_1)

		return
	end)

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.bind

	NewMainScene = var_3

	var_2_11(var_2_10, var_3.RESET_PAITING_SCALE, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_2_0.painting

		var_2.ResetPartScale(var_8_0)

		return
	end)

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.bind

	NewMainScene = var_3

	var_2_13(var_2_12, var_3.ON_ENTER_DONE, function(arg_9_0)
		if arg_2_0.painting then
			local var_9_0 = arg_2_0.painting

			var_1.TriggerEventAtFirstTime(var_9_0)
		end

		return
	end)

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.bind

	NewMainScene = var_3

	var_2_15(var_2_14, var_3.ENTER_SILENT_VIEW, function()
		arg_2_0.cg.blocksRaycasts = false

		local var_10_0 = arg_2_0

		var_10_0.silentFlag = true
		ipairs = var_10_0

		for iter_10_0, iter_10_1 in var_10_0(arg_2_0.paintings) do
			iter_10_1:PauseForSilent()
		end

		return
	end)

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.bind

	NewMainScene = var_3

	var_2_17(var_2_16, var_3.EXIT_SILENT_VIEW, function()
		arg_2_0.cg.blocksRaycasts = true

		local var_11_0 = arg_2_0

		var_11_0.silentFlag = false
		ipairs = var_11_0

		for iter_11_0, iter_11_1 in var_11_0(arg_2_0.paintings) do
			iter_11_1:ResumeForSilent()
		end

		return
	end)

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.bind

	NewMainScene = var_3

	var_2_19(var_2_18, var_3.RESET_L2D, function()
		if not arg_2_0.painting then
			return
		end

		isa = var_0

		local var_12_0 = arg_2_0.painting

		MainLive2dPainting = var_2_10002

		if not var_0(var_12_0, var_2_10002) then
			return
		end

		local var_12_1 = arg_2_0.painting

		var_0.ResetState(var_12_1)

		return
	end)

	Live2dConst = var_2_19

	function var_2_19.UnLoadL2dPating()
		if not arg_2_0.reloadOnResume and arg_2_0.painting then
			isa = var_0

			local var_13_0 = arg_2_0.painting

			MainLive2dPainting = var_2_10002

			if var_0(var_13_0, var_2_10002) then
				local var_13_1 = arg_2_0.painting

				var_0.SetContainerVisible(var_13_1, false)

				arg_2_0.reloadOnResume = true
			end
		end

		return
	end

	return
end

function var_0_1.OnChatStateChange(arg_14_0, arg_14_1)
	if not arg_14_1 then
		local var_14_0 = arg_14_0.painting

		var_2.StopChatAnimtion(var_14_0)
	end

	return
end

function var_0_1.OnStopVoice(arg_15_0)
	if arg_15_0.painting then
		local var_15_0 = arg_15_0.painting

		var_1.OnStopVoice(var_15_0)
	end

	return
end

function var_0_1.IsLive2DState(arg_16_0)
	return var_0_1.STATE_L2D == arg_16_0.state
end

function var_0_1.IsLoading(arg_17_0)
	if arg_17_0.painting then
		local var_17_0 = arg_17_0.painting

		if var_1.IsLoading(var_17_0) then
			return true
		end
	end

	return false
end

function var_0_1.Init(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0:ShouldReLoad(arg_18_1) then
		arg_18_0:Reload(arg_18_1)
	else
		local var_18_0 = arg_18_0.painting

		var_4.Resume(var_18_0)
	end

	arg_18_0.shift = arg_18_2 or arg_18_0.shift
	assert = var_4

	var_4(arg_18_0.shift)

	if arg_18_3 then
		arg_18_0:AdjustPositionWithAnim(arg_18_1)
	else
		arg_18_0:AdjustPosition(arg_18_1)
	end

	local var_18_1 = arg_18_0.painting

	var_4.SetShift(var_18_1, arg_18_0.shift)

	return
end

function var_0_1.Reload(arg_19_0, arg_19_1)
	arg_19_0.ship = arg_19_1

	local var_19_0, var_19_1 = var_0_1.GetAssistantStatus(arg_19_1)
	local var_19_2 = arg_19_0.paintings[var_19_0]

	if arg_19_0.painting then
		local var_19_3 = arg_19_0.painting

		var_5.Unload(var_19_3)
	end

	var_19_2:Load(arg_19_1)

	arg_19_0.painting = var_19_2
	arg_19_0.state = var_19_0
	PlayerPrefs = var_5
	arg_19_0.bgToggle = var_5.GetInt("paint_hide_other_obj_" .. arg_19_0.painting.paintingName, 0)
	arg_19_0.skinId = arg_19_1:getSkinId()

	return
end

function var_0_1.Refresh(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:Init(arg_20_1, arg_20_2)

	return
end

function var_0_1.ShouldReLoad(arg_21_0, arg_21_1)
	if not arg_21_0.painting or not arg_21_0.ship or not arg_21_0.state or not arg_21_0.bgToggle then
		return true
	end

	local var_21_0 = var_0_1.GetAssistantStatus(arg_21_1)

	PlayerPrefs = var_3

	local var_21_1 = var_3.GetInt("paint_hide_other_obj_" .. arg_21_0.painting.paintingName, 0)
	local var_21_2 = arg_21_0.skinId
	local var_21_3 = arg_21_0.ship

	if var_21_2 == var_5.getSkinId(var_21_3) and arg_21_1.id == arg_21_0.ship.id and arg_21_0.state == var_21_0 and arg_21_0.bgToggle == var_21_1 then
		local var_21_4 = arg_21_1:GetRecordPosKey()
		local var_21_5 = arg_21_0.ship

		if var_21_4 == var_5.GetRecordPosKey(var_21_5) and not arg_21_0.reloadOnResume then
			do return false end

			goto label_21_0
		end
	end

	if arg_21_0.reloadOnResume then
		arg_21_0.reloadOnResume = false
	end

	do return true end

	::label_21_0::

	return
end

function var_0_1.SetOnceLoadedCall(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.painting

	var_2.SetOnceLoadedCall(var_22_0, arg_22_1)

	return
end

function var_0_1.PlayChangeSkinActionIn(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.painting

	var_2.PlayChangeSkinActionIn(var_23_0, arg_23_1)

	return
end

function var_0_1.PlayChangeSkinActionOut(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.painting

	var_2.PlayChangeSkinActionOut(var_24_0, arg_24_1)

	return
end

function var_0_1.Disable(arg_25_0)
	if arg_25_0.painting then
		local var_25_0 = arg_25_0.painting

		var_1.Pause(var_25_0)
	end

	return
end

function var_0_1.AdjustPositionWithAnim(arg_26_0, arg_26_1)
	LeanTween = var_1_10002

	local var_26_0 = var_1_10002.cancel

	go = var_1_10003

	var_26_0(var_1_10003(arg_26_0._tf))

	LeanTween = var_26_0

	local var_26_1 = var_26_0.cancel

	go = var_3

	var_26_1(var_3(arg_26_0._bgTf))

	local var_26_2 = arg_26_0
	local var_26_3 = arg_26_0.GetPositionAndScale(var_26_2, arg_26_1)

	LeanTween = var_26_2

	local var_26_4 = var_26_2.moveLocal

	go = var_4

	local var_26_5 = var_26_4(var_4(arg_26_0._tf), var_26_3, 0.3)
	local var_26_6 = var_3.setEase

	LeanTweenType = var_5

	var_26_6(var_26_5, var_5.easeInOutExpo)

	LeanTween = var_26_6

	local var_26_7 = var_26_6.moveLocal

	go = var_26_5

	local var_26_8 = var_26_7(var_26_5(arg_26_0._bgTf), var_26_3, 0.3)
	local var_26_9 = var_3.setEase

	LeanTweenType = var_5

	var_26_9(var_26_8, var_5.easeInOutExpo)

	local var_26_10 = arg_26_0.shift
	local var_26_11, var_26_12 = var_3.GetSpineShift(var_26_10)

	LeanTween = var_5

	local var_26_13 = var_5.moveLocal

	go = var_6

	local var_26_14 = var_26_13(var_6(arg_26_0.spineContainer), var_26_11, 0.3)
	local var_26_15 = var_5.setEase

	LeanTweenType = var_7

	var_26_15(var_26_14, var_7.easeInOutExpo)

	local var_26_16 = arg_26_0.shift
	local var_26_17, var_26_18 = var_5.GetL2dShift(var_26_16)
	local var_26_19 = arg_26_0.painting

	if var_7.IslimitYPos(var_26_19) then
		var_26_19 = arg_26_0.painting
		var_26_17.y = var_7.GetHalfBodyOffsetY(var_26_19)
	end

	LeanTween = var_7

	local var_26_20 = var_7.moveLocal

	go = var_26_19

	local var_26_21 = var_26_20(var_26_19(arg_26_0.l2dContainer), var_26_17, 0.3)
	local var_26_22 = var_7.setEase

	LeanTweenType = var_9

	local var_26_23 = var_26_22(var_26_21, var_9.easeInOutExpo)
	local var_26_24 = var_7.setOnComplete

	System = var_9

	var_26_24(var_26_23, var_9.Action(function()
		local var_27_0 = arg_26_0

		var_0.AdjustPosition(var_27_0, arg_26_1)

		return
	end))

	return
end

function var_0_1.AdjustPosition(arg_28_0, arg_28_1)
	local var_28_0, var_28_1 = arg_28_0:GetPositionAndScale(arg_28_1)

	arg_28_0._tf.anchoredPosition = var_28_0
	arg_28_0._bgTf.anchoredPosition = var_28_0

	local var_28_2 = arg_28_0.shift
	local var_28_3, var_28_4 = var_4.GetL2dShift(var_28_2)
	local var_28_5 = arg_28_0.painting

	if var_6.IslimitYPos(var_28_5) then
		local var_28_6 = arg_28_0.painting

		var_28_3.y = var_6.GetHalfBodyOffsetY(var_28_6)
	end

	arg_28_0.l2dContainer.anchoredPosition = var_28_3

	local var_28_7 = arg_28_0.shift
	local var_28_8, var_28_9 = var_6.GetSpineShift(var_28_7)
	local var_28_10 = arg_28_0.spineContainer

	var_28_10.anchoredPosition = var_28_8
	getProxy = var_28_10
	SettingsProxy = var_1_10009

	local var_28_11 = var_28_10(var_1_10009)
	local var_28_12, var_28_13, var_28_14 = var_8.getSkinPosSetting(var_28_11, arg_28_1)

	if var_28_14 then
		local var_28_15 = arg_28_0._bgTf

		Vector3 = var_1_10012
		var_28_15.localScale = var_1_10012(var_28_14, var_28_14, 1)

		local var_28_16 = arg_28_0._tf

		Vector3 = var_12
		var_28_16.localScale = var_12(var_28_14, var_28_14, 1)
	elseif arg_28_0.state == var_0_1.STATE_L2D then
		arg_28_0._bgTf.localScale = var_28_4
		arg_28_0._tf.localScale = var_28_4
	elseif arg_28_0.state == var_0_1.STATE_SPINE_PAINTING then
		arg_28_0._bgTf.localScale = var_28_9
		arg_28_0._tf.localScale = var_28_9
	else
		arg_28_0._bgTf.localScale = var_28_1
		arg_28_0._tf.localScale = var_28_1
	end

	return
end

function var_0_1.GetPositionAndScale(arg_29_0, arg_29_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10003

	local var_29_0 = var_1_10002(var_1_10003)
	local var_29_1, var_29_2, var_29_3 = var_2.getSkinPosSetting(var_29_0, arg_29_1)

	Vector3 = var_1_10005

	local var_29_4 = var_1_10005(0, 0, 0)

	Vector3 = var_6

	local var_29_5 = var_6(1, 1, 1)

	if var_29_1 then
		Vector3 = var_7
		var_29_4 = var_7(var_29_1, var_29_2, 0)
		Vector3 = var_7
		var_29_5 = var_7(var_29_3, var_29_3, 1)
	else
		local var_29_6 = arg_29_0.shift
		local var_29_7, var_29_8 = var_7.GetMeshImageShift(var_29_6)

		var_29_4 = var_29_7
		var_29_5 = var_29_8
	end

	return var_29_4, var_29_5
end

function var_0_1.GetAssistantStatus(arg_30_0)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.getPainting(var_30_0)

	getProxy = var_30_0
	SettingsProxy = var_1_10003

	local var_30_2 = var_30_0(var_1_10003)

	HXSet = var_1_10003

	local var_30_3 = var_1_10003.autoHxShiftPath("spinepainting/" .. var_30_1)

	checkABExist = var_4

	local var_30_4 = var_4(var_30_3)

	HXSet = var_5

	local var_30_5 = var_5.autoHxShiftPath("live2d/" .. var_30_1)
	local var_30_6

	if var_0_1.Live2dIsDownload(var_30_5) then
		checkABExist = var_30_6
		var_30_6 = var_30_6(var_30_5)
	end

	local var_30_7 = var_30_2
	local var_30_8 = var_30_2.getCharacterSetting
	local var_30_9 = arg_30_0.id

	SHIP_FLAG_BG = var_1_10010

	local var_30_10 = var_30_8(var_30_7, var_30_9, var_1_10010)
	local var_30_11 = var_30_2
	local var_30_12 = var_30_2.getCharacterSetting
	local var_30_13 = arg_30_0.id

	SHIP_FLAG_L2D = var_1_10011

	if var_30_12(var_30_11, var_30_13, var_1_10011) and var_30_6 then
		isa = var_8

		local var_30_14 = arg_30_0

		VirtualEducateCharShip = var_30_13

		local var_30_15

		if not var_8(var_30_14, var_30_13) or not var_0_1.STATE_EDUCATE_L2D then
			var_30_15 = var_0_1.STATE_L2D
		end

		return var_30_15, var_30_10
	else
		local var_30_16 = var_30_2
		local var_30_17 = var_30_2.getCharacterSetting
		local var_30_18 = arg_30_0.id

		SHIP_FLAG_SP = var_1_10011

		local var_30_20

		if var_30_17(var_30_16, var_30_18, var_1_10011) and var_30_4 then
			isa = var_30_20

			local var_30_19 = arg_30_0

			VirtualEducateCharShip = var_30_18

			if not var_30_20(var_30_19, var_30_18) or not var_0_1.STATE_EDUCATE_SPINE then
				var_30_20 = var_0_1.STATE_SPINE_PAINTING
			end

			return var_30_20, var_30_10
		else
			isa = var_30_20

			local var_30_21 = arg_30_0

			VirtualEducateCharShip = var_30_18

			local var_30_22

			if not var_30_20(var_30_21, var_30_18) or not var_0_1.STATE_EDUCATE_CHAR then
				var_30_22 = var_0_1.STATE_PAINTING
			end

			return var_30_22, var_30_10
		end
	end

	return
end

function var_0_1.OnBoundChange(arg_31_0)
	if arg_31_0.painting then
		local var_31_0 = arg_31_0.painting

		var_1.UpdateBound(var_31_0)
	end

	return
end

function var_0_1.Live2dIsDownload(arg_32_0)
	GroupHelper = var_1_10001

	local var_32_0 = var_1_10001.GetGroupMgrByName("L2D")
	local var_32_1 = var_1.CheckF(var_32_0, arg_32_0)

	DownloadState = var_32_0

	local var_32_2

	if var_32_1 ~= var_32_0.None then
		DownloadState = var_3

		if var_32_1 ~= var_3.UpdateSuccess then
			var_32_2 = false

			goto label_32_0
		end
	end

	var_32_2 = true

	::label_32_0::

	return var_32_2
end

function var_0_1.Fold(arg_33_0, arg_33_1, arg_33_2)
	LeanTween = var_1_10003

	var_1_10003.cancel(arg_33_0._tf.gameObject)

	LeanTween = var_3

	var_3.cancel(arg_33_0._bgTf.gameObject)

	if arg_33_1 and not arg_33_0.silentFlag then
		local var_33_0 = arg_33_0._tf.localPosition - arg_33_0._bgTf.localPosition
		local var_33_1 = arg_33_0.shift
		local var_33_2 = var_4.GetMeshImageShift(var_33_1)

		Vector3 = var_33_1

		local var_33_3 = arg_33_0.painting
		local var_33_4 = var_33_1(0 - var_6.GetOffset(var_33_3), var_33_2.y, 0)

		LeanTween = var_6

		local var_33_5 = var_6.moveLocal(arg_33_0._tf.gameObject, var_33_4, arg_33_2)
		local var_33_6 = var_6.setEase

		LeanTweenType = var_8

		var_33_6(var_33_5, var_8.easeInOutExpo)

		local var_33_7 = var_33_4 - var_33_0

		LeanTween = var_33_5

		local var_33_8 = var_33_5.moveLocal(arg_33_0._bgTf.gameObject, var_33_7, arg_33_2)
		local var_33_9 = var_7.setEase

		LeanTweenType = var_9

		local var_33_10 = var_33_9(var_33_8, var_9.easeInOutExpo)
		local var_33_11 = var_7.setOnComplete

		System = var_9

		var_33_11(var_33_10, var_9.Action(function()
			local var_34_0 = arg_33_0.painting

			var_0.Fold(var_34_0, arg_33_1, arg_33_2)

			return
		end))
	elseif arg_33_0.ship then
		local var_33_12 = arg_33_0
		local var_33_13 = arg_33_0.GetPositionAndScale(var_33_12, arg_33_0.ship)

		LeanTween = var_33_12

		local var_33_14 = var_33_12.moveLocal(arg_33_0._tf.gameObject, var_33_13, arg_33_2)
		local var_33_15 = var_4.setEase

		LeanTweenType = var_6

		var_33_15(var_33_14, var_6.easeInOutExpo)

		LeanTween = var_33_15

		local var_33_16 = var_33_15.moveLocal(arg_33_0._bgTf.gameObject, var_33_13, arg_33_2)
		local var_33_17 = var_4.setEase

		LeanTweenType = var_6

		local var_33_18 = var_33_17(var_33_16, var_6.easeInOutExpo)
		local var_33_19 = var_4.setOnComplete

		System = var_6

		var_33_19(var_33_18, var_6.Action(function()
			if arg_33_0.exited then
				return
			end

			local var_35_0 = arg_33_0.painting

			var_0.Fold(var_35_0, arg_33_1, arg_33_2)

			return
		end))
	end

	return
end

function var_0_1.EnableOrDisableScale(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.painting

	var_2.EnableOrDisableMove(var_36_0, arg_36_1)

	local var_36_1 = arg_36_0.painting

	var_2.OnEnablePartScale(var_36_1, arg_36_1)

	return
end

function var_0_1.EnableOrDisableMove(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.painting

	var_2.EnableOrDisableMove(var_37_0, arg_37_1)

	if arg_37_1 then
		arg_37_0:EnableDragAndZoom()
	else
		arg_37_0:DisableDragAndZoom()
	end

	return
end

function var_0_1.OnAsmrTurnning(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.painting

	var_2.OnAsmrTurnning(var_38_0, arg_38_1)

	return
end

function var_0_1.EnableDragAndZoom(arg_39_0)
	arg_39_0.isEnableDrag = true

	local var_39_0 = arg_39_0._tf.parent.gameObject

	GetOrAddComponent = var_1_10002

	local var_39_1 = var_39_0

	typeof = var_1_10004
	PinchZoom = var_1_10005

	local var_39_2 = var_1_10002(var_39_1, var_1_10004(var_1_10005))

	GetOrAddComponent = var_39_1

	local var_39_3 = var_39_0

	typeof = var_1_10005
	EventTriggerListener = var_1_10006

	local var_39_4 = var_39_1(var_39_3, var_1_10005(var_1_10006))

	Vector3 = var_39_3

	local var_39_5 = var_39_3(0, 0, 0)

	var_39_4:AddBeginDragFunc(function(arg_40_0, arg_40_1)
		Application = var_2_10002

		if var_2_10002.isEditor then
			Input = var_2

			if var_2.GetMouseButton(2) then
				return
			end
		end

		if var_39_2.processing then
			return
		end

		setButtonEnabled = var_2

		var_2(var_39_0, false)

		Input = var_2

		if var_2.touchCount > 1 then
			return
		end

		local var_40_0 = var_0_1.Screen2Local(var_39_0.transform.parent, arg_40_1.position)

		var_39_5 = arg_39_0._tf.localPosition - var_40_0

		return
	end)
	var_39_4:AddDragFunc(function(arg_41_0, arg_41_1)
		Application = var_2_10002

		if var_2_10002.isEditor then
			Input = var_2

			if var_2.GetMouseButton(2) then
				return
			end
		end

		if var_39_2.processing then
			return
		end

		Input = var_2

		if var_2.touchCount > 1 then
			return
		end

		local var_41_0 = var_0_1.Screen2Local(var_39_0.transform.parent, arg_41_1.position)
		local var_41_1
		local var_41_2 = arg_39_0.painting
		local var_41_3

		if var_4.IslimitYPos(var_41_2) then
			Vector3 = var_41_3
			var_41_3 = var_41_3(var_41_0.x, arg_39_0._tf.localPosition.y, 0)
			Vector3 = var_5
			var_41_1 = var_41_3 + var_5(var_39_5.x, 0, 0)
		else
			Vector3 = var_41_3
			var_41_1 = var_41_3(var_41_0.x, var_41_0.y, 0) + var_39_5
		end

		arg_39_0._tf.localPosition = var_41_1
		arg_39_0._bgTf.localPosition = arg_39_0.bgOffset + arg_39_0._tf.localPosition

		return
	end)
	var_39_4:AddDragEndFunc(function()
		setButtonEnabled = var_2_10000

		var_2_10000(var_39_0, true)

		return
	end)

	local var_39_6 = arg_39_0.painting

	if not var_5.IslimitYPos(var_39_6) then
		var_39_2.enabled = true
	end

	var_39_4.enabled = true
	Input = var_5
	var_5.multiTouchEnabled = true
	arg_39_0.cg.blocksRaycasts = false

	arg_39_0:AdjustPosition(arg_39_0.ship)

	return
end

function var_0_1.DisableDragAndZoom(arg_43_0)
	if arg_43_0.isEnableDrag then
		local var_43_0 = arg_43_0._tf.parent
		local var_43_1 = var_1.GetComponent

		typeof = var_1_10003
		EventTriggerListener = var_1_10004

		local var_43_2 = var_43_1(var_43_0, var_1_10003(var_1_10004))

		ClearEventTrigger = var_43_0

		var_43_0(var_43_2)

		var_43_2.enabled = false

		local var_43_3 = arg_43_0._tf.parent
		local var_43_4 = var_2.GetComponent

		typeof = var_1_10004
		PinchZoom = var_1_10005
		var_43_4(var_43_3, var_1_10004(var_1_10005)).enabled = false
		arg_43_0.cg.blocksRaycasts = true
		arg_43_0.isEnableDrag = false
	end

	arg_43_0:AdjustPosition(arg_43_0.ship)

	return
end

function var_0_1.Dispose(arg_44_0)
	var_0_1.super.Dispose(arg_44_0)
	arg_44_0:DisableDragAndZoom()

	if arg_44_0.painting then
		local var_44_0 = arg_44_0.painting

		var_1.Unload(var_44_0)
	end

	arg_44_0.painting = nil
	ipairs = var_1

	for iter_44_0, iter_44_1 in var_1(arg_44_0.paintings) do
		iter_44_1:Dispose()
	end

	arg_44_0.paintings = nil

	return
end

function var_0_1.Screen2Local(arg_45_0, arg_45_1)
	GameObject = var_1_10002

	local var_45_0 = var_1_10002.Find("UICamera")
	local var_45_1 = var_2.GetComponent(var_45_0, "Camera")
	local var_45_2 = arg_45_0
	local var_45_3 = arg_45_0.GetComponent(var_45_2, "RectTransform")

	LuaHelper = var_45_2

	local var_45_4 = var_45_2.ScreenToLocal(var_45_3, arg_45_1, var_45_1)

	Vector3 = var_5

	return var_5(var_45_4.x, var_45_4.y, 0)
end

return var_0_1
