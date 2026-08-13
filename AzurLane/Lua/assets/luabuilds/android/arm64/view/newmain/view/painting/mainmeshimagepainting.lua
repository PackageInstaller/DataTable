class = var_0_10000

local var_0_0 = "MainMeshImagePainting"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBasePainting"))

var_0_1.DEFAULT_HEIGHT = 0
var_0_1.TOUCH_HEIGHT = 20
var_0_1.TOUCH_LOOP = 1
var_0_1.TOUCH_DURATION = 0.1
var_0_1.CHAT_HEIGHT = 15
var_0_1.CHAT_DURATION = 0.3
var_0_1.BREATH_HEIGHT = -10
var_0_1.BREATH_DURATION = 2.3
var_0_1.PAINTING_VARIANT_NORMAL = 0
var_0_1.PAINTING_VARIANT_EX = 1

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	GameObject = var_3

	local var_1_0 = var_3.Find("UICamera")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	Camera = var_1_10008
	arg_1_0.uiCamera = var_1_1(var_1_0, var_6(var_1_10008))

	return
end

function var_0_1.StaticGetPaintingName(arg_2_0)
	local var_2_0 = arg_2_0

	checkABExist = var_1_10002

	if var_1_10002("painting/" .. var_2_0 .. "_n") then
		PlayerPrefs = var_2

		if var_2.GetInt("paint_hide_other_obj_" .. var_2_0, 0) ~= 0 then
			var_2_0 = var_2_0 .. "_n"
		end
	end

	HXSet = var_2

	if var_2.isHx() then
		return var_2_0
	end

	getProxy = var_2
	SettingsProxy = var_4

	local var_2_1 = var_2(var_4)

	if var_2.GetMainPaintingVariantFlag(var_2_1, arg_2_0) == var_0_1.PAINTING_VARIANT_EX then
		checkABExist = var_2_1

		if not var_2_1("painting/" .. var_2_0 .. "_ex") then
			return var_2_0
		end
	end

	local var_2_2

	if not var_3 or not (var_2_0 .. "_ex") then
		var_2_2 = var_2_0
	end

	return var_2_2
end

function var_0_1.GetPaintingName(arg_3_0)
	return var_0_1.StaticGetPaintingName(arg_3_0.paintingName)
end

function var_0_1.OnLoad(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetPaintingName()

	arg_4_0:ClearScalePart()

	LoadPaintingPrefabAsync = var_3

	var_3(arg_4_0.container, arg_4_0.paintingName, var_4_0, "mainNormal", function()
		local var_5_0 = arg_4_0

		if var_0.IsExited(var_5_0) then
			local var_5_1 = arg_4_0

			var_0.Unload(var_5_1)

			return
		end

		arg_4_0.loadPaintingName = var_4_0

		local var_5_2 = arg_4_0
		local var_5_3 = var_0.InitSpecialTouch(var_5_2)
		local var_5_4 = arg_4_0

		var_1.InitSpecialDrag(var_5_4, var_5_3)

		if arg_4_0.expression then
			ShipExpressionHelper = var_1

			local var_5_5 = var_1.UpdateExpression

			findTF = var_5_4

			local var_5_6 = var_5_4(arg_4_0.container, "fitter")

			var_5_5(var_3.GetChild(var_5_6, 0), arg_4_0.paintingName, arg_4_0.expression)
		end

		local var_5_7 = arg_4_0

		var_1.Breath(var_5_7)

		local var_5_8 = arg_4_0

		var_1.InitScalePart(var_5_8)
		arg_4_1()

		return
	end)

	return
end

function var_0_1.GetCenterPos(arg_6_0)
	if arg_6_0:IsLoaded() then
		local var_6_0 = arg_6_0.container
		local var_6_1 = var_1.Find(var_6_0, "fitter")
		local var_6_2 = (0.5 - var_1.GetChild(var_6_1, 0).pivot.x) * var_1.sizeDelta.x
		local var_6_3 = var_1.localPosition

		Vector3 = var_4

		local var_6_4 = var_6_3 + var_4(var_6_2, 0, 0)

		return (var_1:TransformPoint(var_6_4))
	else
		return var_0_1.super.GetCenterPos(arg_6_0)
	end

	return
end

function var_0_1.PlayChangeSkinActionIn(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_1.callback then
		arg_7_1.callback({
			flag = true
		})
	end

	return
end

function var_0_1.PlayChangeSkinActionOut(arg_8_0, arg_8_1)
	if arg_8_1 and arg_8_1.callback then
		arg_8_1.callback({
			flag = true
		})
	end

	return
end

function var_0_1.InitSpecialTouch(arg_9_0)
	findTF = var_1_10001
	findTF = var_1_10003

	local var_9_0 = var_1_10003(arg_9_0.container, "fitter")

	if not var_1_10001(var_3.GetChild(var_9_0, 0), "Touch") then
		return
	end

	setActive = var_1_10002

	var_1_10002(var_1, true)

	local var_9_1 = {}

	eachChild = var_3

	var_3(var_1, function(arg_10_0)
		onButton = var_2_10001

		var_2_10001(arg_9_0, arg_10_0, function()
			local var_11_0 = arg_9_0
			local var_11_1 = var_0.GetSpecialTouchEvent(var_11_0, arg_10_0.name)
			local var_11_2 = arg_9_0

			var_1.TriggerEvent(var_11_2, var_11_1)

			local var_11_3 = arg_9_0

			var_1.TriggerPersonalTask(var_11_3, arg_9_0.ship.groupId)

			return
		end)

		var_9_1[arg_10_0] = arg_10_0.rect

		return
	end)

	return var_9_1
end

function var_0_1.InitSpecialDrag(arg_12_0, arg_12_1)
	findTF = var_1_10002
	findTF = var_1_10004

	local var_12_0 = var_1_10004(arg_12_0.container, "fitter")

	if not var_1_10002(var_4.GetChild(var_12_0, 0), "Drag") then
		return
	end

	PLATFORM_CODE = var_1_10003
	PLATFORM_CH = var_4

	if var_1_10003 == var_4 then
		HXSet = var_1_10003

		if var_1_10003.isHx() then
			setActive = var_1_10003

			var_1_10003(var_2, false)

			return
		end
	end

	setActive = var_1_10003

	var_1_10003(var_2, true)

	GetOrAddComponent = var_1_10003

	local var_12_1 = var_2

	typeof = var_6
	EventTriggerListener = var_1_10008

	local var_12_2 = var_1_10003(var_12_1, var_6(var_1_10008))

	Vector2 = var_4

	local var_12_3 = var_4(0, 0)

	arg_12_0.isDrag = false

	var_12_2:AddBeginDragFunc(function(arg_13_0, arg_13_1)
		arg_12_0.isDrag = true
		var_12_3 = arg_13_1.position

		return
	end)
	var_12_2:AddDragEndFunc(function(arg_14_0, arg_14_1)
		arg_12_0.isDrag = false

		local var_14_0 = arg_14_1.position - var_12_3

		math = var_2_10004

		if not (var_2_10004.abs(var_14_0.x) > 50) then
			math = var_4

			if var_4.abs(var_14_0.y) > 50 then
				local var_14_1 = arg_12_0

				var_4.SwitchToVariant(var_14_1, var_0)
			end

			return
		end
	end)

	if arg_12_1 then
		table = var_5

		if var_5.getCount(arg_12_1) > 0 then
			var_12_2:AddPointUpFunc(function(arg_15_0, arg_15_1)
				if arg_12_0.isDrag then
					return
				end

				local var_15_0

				pairs = var_2_10003

				for iter_15_0, iter_15_1 in var_2_10003(arg_12_1) do
					LuaHelper = var_2_10008
					var_2_10008 = var_2_10008.ScreenToLocal(iter_15_0, arg_15_1.position, arg_12_0.uiCamera)

					if iter_15_1:Contains(var_2_10008) then
						var_15_0 = iter_15_0

						break
					end
				end

				if var_15_0 then
					triggerButton = var_3

					var_3(var_15_0)
				else
					triggerButton = var_3

					var_3(arg_12_0.container)
				end

				return
			end)
		end
	end

	GetOrAddComponent = var_5

	local var_12_4 = var_5(var_2, "UILongPressTrigger").onLongPressed

	var_5.RemoveAllListeners(var_12_4)
	var_5:AddListener(function()
		local var_16_0 = arg_12_0

		var_0.OnLongPress(var_16_0)

		return
	end)

	return
end

function var_0_1.SwitchToVariant(arg_17_0, arg_17_1)
	pg = var_1_10002

	local var_17_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOn(var_17_0, false)

	getProxy = var_2
	SettingsProxy = var_17_0

	local var_17_1 = var_2(var_17_0)

	var_2.SwitchMainPaintingVariantFlag(var_17_1, arg_17_0.paintingName)

	seriesAsync = var_2

	var_2({
		function(arg_18_0)
			local var_18_0 = arg_17_0
			local var_18_1 = var_1.GetPaintingName(var_18_0)

			PoolMgr = var_2_10002

			local var_18_2 = var_2_10002.GetInstance()

			var_2.PreloadPainting(var_18_2, var_18_1, arg_18_0)

			return
		end,
		function(arg_19_0)
			local var_19_0 = arg_17_0

			var_1.PlayVariantEffect(var_19_0, arg_17_1, arg_19_0)

			return
		end,
		function(arg_20_0)
			onDelayTick = var_2_10001

			var_2_10001(arg_20_0, 0.5)

			return
		end,
		function(arg_21_0)
			local var_21_0 = arg_17_0

			var_1.UnloadOnlyPainting(var_21_0)

			local var_21_1 = arg_17_0

			var_1.Load(var_21_1, arg_17_0.ship, true)

			onDelayTick = var_1

			var_1(arg_21_0, 1)

			return
		end
	}, function()
		local var_22_0 = arg_17_0

		var_0.ClearEffect(var_22_0)

		pg = var_0

		local var_22_1 = var_0.UIMgr.GetInstance()

		var_0.LoadingOff(var_22_1)

		return
	end)

	return
end

function var_0_1.PlayVariantEffect(arg_23_0, arg_23_1, arg_23_2)
	getProxy = var_1_10003
	SettingsProxy = var_1_10005

	local var_23_0 = var_1_10003(var_1_10005)
	local var_23_1 = var_3.GetMainPaintingVariantFlag(var_23_0, arg_23_0.paintingName) == var_0_1.PAINTING_VARIANT_EX and "lihui_qiehuan01" or "lihui_qiehuan02"

	pg = var_6

	local var_23_2 = var_6.PoolMgr.GetInstance()

	var_6.GetPrefab(var_23_2, "ui/" .. var_23_1, "", true, function(arg_24_0)
		pg = var_2_10001

		local var_24_0 = var_2_10001.ViewUtils.SetLayer
		local var_24_1 = arg_24_0.transform

		Layer = var_2_10004

		var_24_0(var_24_1, var_2_10004.UI)

		arg_23_0.effectGo = arg_24_0
		arg_23_0.effectGo.name = var_23_1

		local var_24_2 = arg_23_0

		if var_1.IsExited(var_24_2) then
			local var_24_3 = arg_23_0

			var_1.ClearEffect(var_24_3)

			return
		end

		setParent = var_1

		var_1(arg_24_0, arg_23_0.container)

		arg_23_0.effectGo.transform.position = arg_23_1.position

		local var_24_5

		if var_0 then
			pg = var_24_5

			local var_24_4 = var_24_5.CriMgr.GetInstance()

			var_24_5 = var_24_5.PlaySoundEffect_V3
			SFX_EXPLOSIVE_SKIN = var_4

			var_24_5(var_24_4, var_4)
		else
			pg = var_24_5

			local var_24_6 = var_24_5.CriMgr.GetInstance()
			local var_24_7 = var_1.PlaySoundEffect_V3

			SFX_ANTI_EXPLOSIVE_SKIN = var_4

			var_24_7(var_24_6, var_4)
		end

		arg_23_2()

		return
	end)

	return
end

function var_0_1.ClearEffect(arg_25_0)
	if arg_25_0.effectTimer then
		local var_25_0 = arg_25_0.effectTimer

		var_1.Stop(var_25_0)

		arg_25_0.effectTimer = nil
	end

	if arg_25_0.effectGo then
		pg = var_1

		local var_25_1 = var_1.PoolMgr.GetInstance()

		var_1.ReturnPrefab(var_25_1, "ui/" .. arg_25_0.effectGo.name, "", arg_25_0.effectGo)

		arg_25_0.effectGo = nil
	end

	return
end

function var_0_1.ClearSpecialDrag(arg_26_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 == var_1_10002 then
		HXSet = var_1_10001

		if var_1_10001.isHx() then
			return
		end
	end

	findTF = var_1_10001
	findTF = var_1_10003

	local var_26_0 = var_1_10003(arg_26_0.container, "fitter")

	if not var_1_10001(var_3.GetChild(var_26_0, 0), "Drag") then
		return
	end

	GetOrAddComponent = var_1_10002

	local var_26_1 = var_1

	typeof = var_26_0
	EventTriggerListener = var_1_10007

	local var_26_2 = var_1_10002(var_26_1, var_26_0(var_1_10007))

	var_2.AddBeginDragFunc(var_26_2, nil)
	var_2:AddDragEndFunc(nil)
	var_2:AddPointUpFunc(nil)

	GetOrAddComponent = var_3

	local var_26_3 = var_3(var_1, "UILongPressTrigger").onLongPressed

	var_3.RemoveAllListeners(var_26_3)

	return
end

function var_0_1.OnClick(arg_27_0)
	local var_27_0 = arg_27_0:CollectTouchEvents()

	math = var_1_10002

	local var_27_1 = var_1_10002.ceil

	math = var_1_10004

	local var_27_2 = var_27_0[var_27_1(var_1_10004.random(#var_27_0))]

	arg_27_0:TriggerEvent(var_27_2)

	return
end

function var_0_1.OnLongPress(arg_28_0)
	if arg_28_0.isFoldState then
		return
	end

	pg = var_1

	local var_28_0 = var_1.m02
	local var_28_1 = var_1.sendNotification

	GAME = var_1_10004

	local var_28_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_28_1(var_28_0, var_28_2, var_1_10005.SHIPINFO, {
		shipId = arg_28_0.ship.id
	})

	return
end

function var_0_1.OnDisplayWorld(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.ship
	local var_29_1 = var_2.getCVIntimacy(var_29_0)

	ShipExpressionHelper = var_1_10003

	local var_29_2 = var_1_10003.SetExpression

	findTF = var_1_10005

	local var_29_3 = var_1_10005(arg_29_0.container, "fitter")
	local var_29_4 = var_5.GetChild(var_29_3, 0)
	local var_29_5 = arg_29_0.paintingName
	local var_29_6 = arg_29_1
	local var_29_7 = var_29_1
	local var_29_8 = arg_29_0.ship
	local var_29_9, var_29_10 = var_29_2(var_29_4, var_29_5, var_29_6, var_29_7, var_9.getSkinId(var_29_8))

	arg_29_0.expression = var_29_10

	return
end

function var_0_1.OnTriggerEvent(arg_30_0)
	arg_30_0:Shake(var_0_1.TOUCH_HEIGHT, var_0_1.TOUCH_DURATION, var_0_1.TOUCH_LOOP)

	return
end

function var_0_1.OnTriggerEventAuto(arg_31_0)
	arg_31_0:Shake(var_0_1.CHAT_HEIGHT, var_0_1.CHAT_DURATION)

	return
end

function var_0_1.GetMeshPainting(arg_32_0)
	findTF = var_1_10001

	if var_1_10001(arg_32_0.container, "fitter").childCount <= 0 then
		return nil
	end

	return (var_1:GetChild(0))
end

function var_0_1.Shake(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0
	local var_33_1 = arg_33_1

	if var_33_0 then
		var_33_1 = arg_33_1 - var_0_1.DEFAULT_HEIGHT + var_33_0
	end

	if not arg_33_3 then
		math = var_1_10006
		arg_33_3 = var_1_10006.random(3) - 1
	end

	if arg_33_3 == 0 then
		return
	end

	if not arg_33_0:GetMeshPainting() then
		return
	end

	LeanTween = var_1_10007

	local var_33_2 = var_1_10007.cancel

	go = var_1_10009

	var_33_2(var_1_10009(var_6))

	LeanTween = var_33_2

	local var_33_3 = var_33_2.moveY

	rtf = var_9

	local var_33_4 = var_33_3(var_9(var_6), var_33_1, 0.1)
	local var_33_5 = var_7.setLoopPingPong(var_33_4, arg_33_3)
	local var_33_6 = var_7.setOnComplete

	System = var_10

	var_33_6(var_33_5, var_10.Action(function()
		local var_34_0 = arg_33_0

		var_0.Breath(var_34_0)

		return
	end))

	return
end

function var_0_1.Breath(arg_35_0)
	if not arg_35_0:GetMeshPainting() then
		return
	end

	local var_35_0
	local var_35_1 = var_35_0 or var_0_1.BREATH_HEIGHT
	local var_35_2

	if not var_35_0 or not (var_35_0 - 10) then
		var_35_2 = var_0_1.DEFAULT_HEIGHT
	end

	LeanTween = var_1_10005

	local var_35_3 = var_1_10005.cancel

	go = var_1_10007

	var_35_3(var_1_10007(var_1))

	LeanTween = var_35_3

	local var_35_4 = var_35_3.moveY

	rtf = var_7

	local var_35_5 = var_35_4(var_7(var_1), var_35_2, var_0_1.BREATH_DURATION)
	local var_35_6 = var_5.setLoopPingPong(var_35_5)
	local var_35_7 = var_5.setEase

	LeanTweenType = var_8

	local var_35_8 = var_35_7(var_35_6, var_8.easeInOutCubic)

	var_5.setFrom(var_35_8, var_35_1)

	return
end

function var_0_1.StopBreath(arg_36_0)
	if not arg_36_0:GetMeshPainting() then
		return
	end

	LeanTween = var_1_10002

	local var_36_0 = var_1_10002.cancel

	go = var_1_10004

	var_36_0(var_1_10004(var_1))

	return
end

function var_0_1.OnEnableOrDisableDragAndZoom(arg_37_0, arg_37_1)
	if arg_37_1 then
		arg_37_0:StopBreath()
	else
		arg_37_0:Breath()
	end

	return
end

function var_0_1.GetPaintingTransform(arg_38_0)
	return arg_38_0:GetMeshPainting()
end

function var_0_1.GetPartScaleData(arg_39_0)
	pg = var_1_10001

	local var_39_0 = var_1_10001.ship_skin_template
	local var_39_1 = arg_39_0.ship

	return var_39_0[var_2.getSkinId(var_39_1)].part_scale.paint
end

function var_0_1.GetPartStateType(arg_40_0)
	MainPaintingView = var_1_10001

	return var_1_10001.STATE_PAINTING
end

function var_0_1.OnFold(arg_41_0, arg_41_1)
	if not arg_41_1 then
		arg_41_0:Breath()
	end

	return
end

function var_0_1.GetOffset(arg_42_0)
	MainPaintingView = var_1_10001

	return var_1_10001.MESH_POSITION_X_OFFSET
end

function var_0_1.OnResume(arg_43_0)
	checkCullResume = var_1_10001

	local var_43_0 = arg_43_0.container
	local var_43_1 = var_3.Find(var_43_0, "fitter")

	var_1_10001(var_3.GetChild(var_43_1, 0))
	arg_43_0:Breath()

	return
end

function var_0_1.Unload(arg_44_0)
	var_0_1.super.Unload(arg_44_0)

	arg_44_0.expression = nil

	return
end

function var_0_1.OnUnload(arg_45_0)
	arg_45_0:StopBreath()
	arg_45_0:ClearSpecialDrag()

	if arg_45_0.loadPaintingName then
		retPaintingPrefab = var_1

		var_1(arg_45_0.container, arg_45_0.loadPaintingName)

		arg_45_0.loadPaintingName = nil
	end

	return
end

function var_0_1.OnPause(arg_46_0)
	arg_46_0:StopBreath()
	arg_46_0:ClearEffect()

	return
end

function var_0_1.Dispose(arg_47_0)
	var_0_1.super.Dispose(arg_47_0)
	arg_47_0:ClearEffect()

	return
end

return var_0_1
