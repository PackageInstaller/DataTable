class = var_0_10000

local var_0_0 = "Dorm3dStockingMgr"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Extra.BaseExtraSystem"))

var_0_1.SET_STOCKING_STATUS = "Dorm3dStockingMgr.SET_STOCKING_STATUS"
var_0_1.EXIT_STOCKING_STATUS = "Dorm3dStockingMgr.EXIT_STOCKING_STATUS"
var_0_1.GET_TIP_SHOW_INFO = "Dorm3dStockingMgr.GET_TIP_SHOW_INFO"
var_0_1.ON_BEGIN_DRAG = "Dorm3dStockingMgr.ON_BEGIN_DRAG"
var_0_1.ON_DRAG = "Dorm3dStockingMgr.ON_DRAG"
var_0_1.ON_END_DRAG = "Dorm3dStockingMgr.ON_END_DRAG"
var_0_1.ON_EXIT_TOUCH_MODE = "Dorm3dStockingMgr.ON_EXIT_TOUCH_MODE"
var_0_1.L_COLLIDERS = {
	"LeftThighCollider",
	"LeftCalfCollider",
	"LeftFootCollider"
}
var_0_1.R_COLLIDERS = {
	"RightThighCollider",
	"RightCalfCollider",
	"RightFootCollider"
}
var_0_1.UNLOCK_CONFIG = {
	[307071] = 1222
}

local var_0_2

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0

	if arg_1_0.GetCurrentLadyEnv(var_1_0) then
		pairs = var_1_0

		for iter_1_0, iter_1_1 in var_1_0(var_1.skinIdList) do
			local var_1_1 = arg_1_0:Get("skinDict")[iter_1_1].ladyGameObject

			arg_1_0:InitDormStocking(var_1_1.transform, iter_1_1)
		end
	end

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_1.SET_STOCKING_STATUS, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.SetStockingStatus(var_3_0, arg_3_1)

		return
	end)
	arg_2_0:Bind(var_0_1.EXIT_STOCKING_STATUS, function(arg_4_0)
		local var_4_0 = arg_2_0

		var_1.ExitStockingStatus(var_4_0)

		return
	end)
	arg_2_0:Bind(var_0_1.GET_TIP_SHOW_INFO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		return var_2.GetTipShowInfo(var_5_0, arg_5_1)
	end)
	arg_2_0:Bind(var_0_1.ON_BEGIN_DRAG, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_2_0

		var_3.OnBeginDrag(var_6_0, arg_6_1, arg_6_2)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_DRAG, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_2_0

		var_3.OnDrag(var_7_0, arg_7_1, arg_7_2)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_END_DRAG, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_2_0

		var_3.OnEndDrag(var_8_0, arg_8_1, arg_8_2)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_EXIT_TOUCH_MODE, function(arg_9_0)
		local var_9_0 = arg_2_0

		var_1.OnExitTouchMode(var_9_0)

		return
	end)

	return
end

function var_0_1.OnHandleNotification(arg_10_0, arg_10_1, arg_10_2)
	GAME = var_1_10003

	if arg_10_1 == var_1_10003.APARTMENT_REPLACE_FURNITURE_DONE then
		local var_10_0 = arg_10_0

		if not arg_10_0.GetCurrentLadyEnv(var_10_0) then
			return
		end

		pairs = var_10_0

		for iter_10_0, iter_10_1 in var_10_0(var_3.skinIdList) do
			local var_10_1 = arg_10_0:Get("skinDict")[iter_10_1].ladyGameObject

			arg_10_0:InitDormStocking(var_10_1.transform, iter_10_1)
		end
	end

	return
end

function var_0_1.GetInterests()
	local var_11_0 = {}

	GAME = var_1_10001
	var_11_0[1] = var_1_10001.APARTMENT_REPLACE_FURNITURE_DONE

	return var_11_0
end

function var_0_1.OnBeginDrag(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.blockingDrag then
		return
	end

	local var_12_0 = arg_12_2.position

	CameraMgr = var_1_10004

	local var_12_1 = var_1_10004.instance
	local var_12_2 = var_4.Raycast(var_12_1, arg_12_0:Get("sceneRaycaster"), var_12_0)
	local var_12_3 = #var_4.ToTable(var_12_2)

	if 0 < var_12_3 then
		local var_12_4 = var_4[1].gameObject.transform

		table = var_6

		local var_12_5, var_12_6 = var_6.Find(var_0_1.L_COLLIDERS, function(arg_13_0, arg_13_1)
			return var_12_4.name == arg_13_1
		end)

		table = var_8

		local var_12_7, var_12_8 = var_8.Find(var_0_1.R_COLLIDERS, function(arg_14_0, arg_14_1)
			return var_12_4.name == arg_14_1
		end)
		local var_12_9 = var_12_6 and 1 or var_12_8 and 2 or nil

		warning = var_1_10011

		var_1_10011(var_12_4, var_12_9)

		if not var_12_9 or var_0_2.enable_drag[var_12_9] == 0 or not arg_12_0.isShow[var_12_9] then
			return
		end

		arg_12_0.inDragStocking = var_12_9

		if arg_12_0.inDragStocking then
			GraphicsInterface = var_11

			local var_12_10 = var_11.Instance

			arg_12_0.startStockingPos = var_11.GetStockingPos(var_12_10, arg_12_0.stockingTFs[arg_12_0.inDragStocking].gameObject)

			local var_12_11 = arg_12_0.startStockingPos

			arg_12_0.preMax = arg_12_0.startStockingPos
			arg_12_0.preMin = var_12_11
			GraphicsInterface = var_12_11

			local var_12_12 = var_12_11.Instance

			var_11.StockingMouseDown(var_12_12, arg_12_0.stockingTFs[arg_12_0.inDragStocking].gameObject, arg_12_2.position, arg_12_0.mainCamera)
		end
	end

	return
end

function var_0_1.OnDrag(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.blockingDrag then
		return
	end

	if arg_15_0.inDragStocking then
		GraphicsInterface = var_3

		local var_15_0 = var_3.Instance

		var_3.StockingMouseDrag(var_15_0, arg_15_0.stockingTFs[arg_15_0.inDragStocking].gameObject, arg_15_2.position, arg_15_0.mainCamera)

		GraphicsInterface = var_3

		local var_15_1 = var_3.Instance
		local var_15_2 = var_3.GetStockingPos(var_15_1, arg_15_0.stockingTFs[arg_15_0.inDragStocking].gameObject)

		math = var_15_1
		arg_15_0.preMin = var_15_1.min(arg_15_0.preMin, var_15_2)
		math = var_4
		arg_15_0.preMax = var_4.max(arg_15_0.preMax, var_15_2)

		return
	end

	local var_15_3 = arg_15_2.delta
	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.Emit

	Dorm3dRoomTemplateScene = var_1_10006

	var_15_5(var_15_4, var_1_10006.ON_STICK_MOVE, var_15_3)

	return
end

function var_0_1.OnEndDrag(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.blockingDrag then
		return
	end

	if arg_16_0.inDragStocking then
		GraphicsInterface = var_3

		local var_16_0 = var_3.Instance

		var_3.StockingMouseUp(var_16_0, arg_16_0.stockingTFs[arg_16_0.inDragStocking].gameObject)

		GraphicsInterface = var_3

		local var_16_1 = var_3.Instance

		arg_16_0.endStockingPos = var_3.GetStockingPos(var_16_1, arg_16_0.stockingTFs[arg_16_0.inDragStocking].gameObject)

		arg_16_0:TryTriggerEvent()
		arg_16_0:CheckStockingShow()
	end

	arg_16_0.inDragStocking = nil

	return
end

function var_0_1.TryTriggerEvent(arg_17_0)
	warning = var_1_10001

	var_1_10001("TryTriggerEvent", arg_17_0.inDragStocking, arg_17_0.startStockingPos, arg_17_0.endStockingPos, arg_17_0.preMin, arg_17_0.preMax)

	local var_17_0 = arg_17_0.inDragStocking

	if arg_17_0.endStockingPos > arg_17_0.startStockingPos then
		var_17_0 = var_17_0 * 2 - 1
	else
		var_17_0 = var_17_0 * 2
	end

	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_0.triggerDic[var_17_0]) do
		if iter_17_1:Check(arg_17_0.endStockingPos, arg_17_0.preMax, arg_17_0.preMin) then
			local var_17_1, var_17_2, var_17_3 = iter_17_1:Trigger()

			arg_17_0:TriggerEvent(var_17_1, var_17_2, var_17_3)

			break
		end
	end

	return
end

function var_0_1.TriggerEvent(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	warning = var_1_10004

	var_1_10004("TriggerEvent", arg_18_1, arg_18_2, arg_18_3)

	arg_18_0.blockingDrag = true

	local function var_18_0()
		arg_18_0.blockingDrag = false

		if arg_18_3 then
			local var_19_0 = arg_18_0

			var_0.ExitStockingStatus(var_19_0)
		else
			local var_19_1 = arg_18_0

			var_0.ResetLady(var_19_1)
		end

		return
	end

	switch = var_5

	var_5(arg_18_1, {
		function()
			local var_20_0 = arg_18_0

			var_0.Func(var_20_0, "DoTalk", arg_18_2[1], var_18_0)

			return
		end
	})

	return
end

function var_0_1.CheckStockingShow(arg_21_0)
	if not arg_21_0.useHideMode then
		return
	end

	if arg_21_0.endStockingPos <= 0.01 then
		local var_21_0 = arg_21_0.isShow

		var_21_0[arg_21_0.inDragStocking] = false
		setActive = var_21_0

		var_21_0(arg_21_0.stockingTFs[arg_21_0.inDragStocking], false)

		setActive = var_21_0

		var_21_0(arg_21_0.sceneStockingTFs[arg_21_0.inDragStocking], true)
	end

	return
end

function var_0_1.InitStatus(arg_22_0, arg_22_1)
	arg_22_0.ladyEnv = arg_22_0:GetCurrentLadyEnv()
	pg = var_2
	var_0_2 = var_2.dorm3d_stocking[arg_22_1]
	arg_22_0.cacheIkStatus = arg_22_0.ladyEnv.currentIkStatus
	arg_22_0.inDragStocking = false
	arg_22_0.stockingL, arg_22_0.stockingR = var_0_1.GetStockingGeo(arg_22_0.ladyEnv.lady, var_0_2.skin_id)
	arg_22_0.stockingTFs = {
		arg_22_0.stockingL,
		arg_22_0.stockingR
	}

	local var_22_0 = arg_22_0:Get("mainCameraTF")
	local var_22_1 = var_2.GetComponent

	typeof = var_4
	Camera = var_1_10005
	arg_22_0.mainCamera = var_22_1(var_22_0, var_4(var_1_10005))

	local var_22_2 = {}
	local var_22_3 = arg_22_0.ladyEnv.lady

	var_22_2[1] = var_3.Find(var_22_3, var_0_2.tip_show_path[1])

	local var_22_4 = arg_22_0.ladyEnv.lady

	var_22_2[2] = var_3.Find(var_22_4, var_0_2.tip_show_path[2])
	arg_22_0.tiptransforms = var_22_2

	local var_22_5 = {}
	local var_22_6 = {}
	local var_22_7 = arg_22_0.ladyEnv.lady

	var_22_6[1] = var_4.Find(var_22_7, var_0_2.l_tip_bone_path[1])

	local var_22_8 = arg_22_0.ladyEnv.lady

	var_22_6[2] = var_4.Find(var_22_8, var_0_2.l_tip_bone_path[2])
	var_22_5[1] = var_22_6

	local var_22_9 = {}
	local var_22_10 = arg_22_0.ladyEnv.lady

	var_22_9[1] = var_4.Find(var_22_10, var_0_2.r_tip_bone_path[1])

	local var_22_11 = arg_22_0.ladyEnv.lady

	var_22_9[2] = var_4.Find(var_22_11, var_0_2.r_tip_bone_path[2])
	var_22_5[2] = var_22_9
	arg_22_0.tipDirections = var_22_5
	arg_22_0.triggerDic = {
		{},
		{},
		{},
		{}
	}

	local function var_22_12(arg_23_0, arg_23_1)
		local var_23_0 = {}
		local var_23_1 = {}

		ipairs = var_2_10004

		for iter_23_0, iter_23_1 in var_2_10004(arg_23_1) do
			StockingTrigger = var_2_10009

			local var_23_2 = var_2_10009.New(iter_23_1)

			if var_2_10009.GetCompareType(var_23_2) == 0 then
				table = var_10

				var_10.insert(var_23_0, var_2_10009)
			else
				table = var_10

				var_10.insert(var_23_1, var_2_10009)
			end
		end

		StockingTrigger = var_4

		var_4.Sort(var_23_0)

		StockingTrigger = var_4

		var_4.Sort(var_23_1)

		arg_22_0.triggerDic[arg_23_0 * 2 - 1] = var_23_0
		arg_22_0.triggerDic[arg_23_0 * 2] = var_23_1

		return
	end

	ipairs = var_3

	for iter_22_0, iter_22_1 in var_3({
		var_0_2.l_trigger,
		var_0_2.r_trigger
	}) do
		var_22_12(iter_22_0, iter_22_1)
	end

	arg_22_0.inited = true

	return
end

function var_0_1.InitHideMode(arg_24_0)
	arg_24_0.useHideMode = var_0_2.scene_stocking_path ~= "" and #var_0_2.scene_stocking_path == 2

	local var_24_0 = {}

	isActive = var_1_10002
	var_24_0[1] = var_1_10002(arg_24_0.stockingL)
	isActive = var_2
	var_24_0[2] = var_2(arg_24_0.stockingR)
	arg_24_0.isShow = var_24_0

	if arg_24_0.useHideMode then
		arg_24_0.sceneStockingTFs = {
			arg_24_0:GetSceneItem(var_0_2.scene_stocking_path[1]),
			arg_24_0:GetSceneItem(var_0_2.scene_stocking_path[2])
		}

		local function var_24_1(arg_25_0, arg_25_1)
			GetOrAddComponent = var_2_10002

			local var_25_0 = arg_25_1

			typeof = var_2_10004
			EventTriggerListener = var_2_10005

			local var_25_1 = var_2_10002(var_25_0, var_2_10004(var_2_10005))

			var_2.AddPointClickFunc(var_25_1, function(arg_26_0, arg_26_1)
				local var_26_0 = arg_24_0.isShow

				var_26_0[arg_25_0] = true
				setActive = var_26_0

				var_26_0(arg_24_0.stockingTFs[arg_25_0], true)

				setActive = var_26_0

				var_26_0(arg_24_0.sceneStockingTFs[arg_25_0], false)

				GraphicsInterface = var_26_0

				local var_26_1 = var_26_0.Instance

				var_2.SetStockingPos(var_26_1, arg_24_0.stockingTFs[arg_25_0].gameObject, var_0_2.wear_initial_pos[arg_25_0])

				return
			end)

			return
		end

		ipairs = var_2

		for iter_24_0, iter_24_1 in var_2(arg_24_0.sceneStockingTFs) do
			var_24_1(iter_24_0, iter_24_1)

			setActive = var_7

			var_7(iter_24_1, not arg_24_0.isShow[iter_24_0])
		end
	end

	return
end

function var_0_1.ResetLady(arg_27_0)
	local var_27_0 = arg_27_0:Get("furnitures")
	local var_27_1 = var_1.Find(var_27_0, var_0_2.character_position)

	assert = var_27_0

	var_27_0(var_27_1, "找不到角色位置点 " .. var_0_2.character_position)

	local var_27_2 = var_27_1:Find("StayPoint")
	local var_27_3 = arg_27_0.ladyEnv

	var_3.SetPosition(var_27_3, var_27_2.position)

	local var_27_4 = arg_27_0.ladyEnv

	var_3.SetRotation(var_27_4, var_27_2.rotation)

	local var_27_5 = arg_27_0.ladyEnv

	var_3.PlaySingleAction(var_27_5, var_0_2.character_action)

	return
end

function var_0_1.SetStockingStatus(arg_28_0, arg_28_1)
	arg_28_0:InitStatus(arg_28_1)
	arg_28_0:InitHideMode()

	warning = var_2

	var_2(">>>>>>>>>>> enter stocking mode <<<<<<<<<<", arg_28_1)

	seriesAsync = var_2

	var_2({
		function(arg_29_0)
			local var_29_0 = arg_28_0
			local var_29_1 = var_1.Emit

			RoomIKSystem = var_2_10003

			var_29_1(var_29_0, var_2_10003.SET_IK_STATE, false, arg_29_0, {
				ignoreResetExtraItem = true
			})

			return
		end,
		function(arg_30_0)
			local var_30_0 = arg_28_0

			var_1.Func(var_30_0, "SetUI", arg_30_0, "stocking")

			return
		end,
		function(arg_31_0)
			local var_31_0 = arg_28_0

			var_1.ResetLady(var_31_0)

			local var_31_1 = arg_28_0

			var_1.Func(var_31_1, "ActiveCameraByName", var_0_2.camera)

			local var_31_2 = arg_28_0
			local var_31_3 = var_1.Get(var_31_2, "cameraRoot")
			local var_31_4 = var_1.Find(var_31_3, var_0_2.camera)
			local var_31_5 = var_1.GetComponent

			typeof = var_4
			Cinemachine = var_2_10005

			if var_31_5(var_31_4, var_4(var_2_10005.CinemachineFreeLook)) then
				local var_31_6 = arg_28_0

				var_3.Func(var_31_6, "RegisterOrbits", var_2)
			end

			local var_31_7 = arg_28_0

			var_3.Func(var_31_7, "PlayEnterSceneAnim", var_0_2.enter_scene_anim)

			local var_31_8 = arg_28_0

			var_3.Func(var_31_8, "PlayEnterExtraItem", arg_28_0.ladyEnv, var_0_2.enter_extra_item)

			local var_31_9 = arg_28_0

			var_3.Func(var_31_9, "HideSceneItem", arg_28_0.ladyEnv, var_0_2.hide_scene_item)

			setActive = var_3

			var_3(arg_28_0.ladyEnv.ladyCollider, false)

			_ = var_3

			var_3.each(arg_28_0.ladyEnv.ladyTouchColliders, function(arg_32_0)
				setActive = var_3_10001

				var_3_10001(arg_32_0, true)

				return
			end)
			arg_31_0()

			return
		end
	})

	return
end

function var_0_1.ExitStockingStatus(arg_33_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_34_0)
			local var_34_0 = arg_33_0

			var_1.Func(var_34_0, "SetUI", arg_34_0, "back")

			return
		end,
		function(arg_35_0)
			warning = var_2_10001

			var_2_10001(">>>>>>>>>>> exit stocking mode <<<<<<<<<<")

			if arg_33_0.useHideMode then
				ipairs = var_1

				for iter_35_0, iter_35_1 in var_1(arg_33_0.sceneStockingTFs) do
					GetOrAddComponent = var_2_10006

					local var_35_0 = iter_35_1

					typeof = var_2_10008
					EventTriggerListener = var_2_10009
					var_2_10008 = var_2_10006(var_35_0, var_2_10008(var_2_10009))

					var_2_10006.RemovePointClickFunc(var_2_10008)
				end
			end

			setActive = var_1

			var_1(arg_33_0.ladyEnv.ladyCollider, true)

			_ = var_1

			var_1.each(arg_33_0.ladyEnv.ladyTouchColliders, function(arg_36_0)
				setActive = var_3_10001

				var_3_10001(arg_36_0, false)

				return
			end)

			local var_35_1 = arg_33_0

			var_1.Func(var_35_1, "ResetSceneItemAnimators")

			local var_35_2 = arg_33_0

			var_1.Func(var_35_2, "ResetTempHideSceneItems", arg_33_0.ladyEnv)

			local var_35_3 = arg_33_0

			var_1.Func(var_35_3, "RevertCameraOrbit")

			local var_35_4 = arg_33_0
			local var_35_5 = var_1.Emit

			RoomIKSystem = var_3

			var_35_5(var_35_4, var_3.SET_IK_CONFIG, arg_33_0.ladyEnv, arg_33_0.cacheIkStatus)

			local var_35_6 = arg_33_0
			local var_35_7 = var_1.Emit

			RoomIKSystem = var_3

			var_35_7(var_35_6, var_3.SET_IK_STATE, true)
			arg_35_0()

			return
		end
	})

	return
end

function var_0_1.OnExitTouchMode(arg_37_0)
	if arg_37_0.inited then
		arg_37_0.inited = false
	end

	return
end

function var_0_1.GetTipShowInfo(arg_38_0, arg_38_1)
	local var_38_0 = {}

	ipairs = var_1_10003

	for iter_38_0, iter_38_1 in var_1_10003(var_0_2.enable_drag) do
		if iter_38_1 == 1 then
			local var_38_1 = arg_38_0:Func("GetScreenPosition", arg_38_0.tipDirections[iter_38_0][1].position, arg_38_0.mainCamera)
			local var_38_2 = arg_38_0
			local var_38_3 = arg_38_0.Func(var_38_2, "GetScreenPosition", arg_38_0.tipDirections[iter_38_0][2].position, arg_38_0.mainCamera)

			table = var_38_2

			var_38_2.insert(var_38_0, {
				pos = arg_38_0:Func("GetScreenPosition", arg_38_0.tiptransforms[iter_38_0].position, arg_38_0.mainCamera),
				dir = var_38_3 - var_38_1
			})
		end
	end

	local var_38_4 = {}

	if arg_38_0.useHideMode then
		ipairs = var_4

		for iter_38_2, iter_38_3 in var_4(arg_38_0.sceneStockingTFs) do
			if not arg_38_0.isShow[iter_38_2] then
				table = var_9

				var_9.insert(var_38_4, {
					pos = arg_38_0:Func("GetScreenPosition", iter_38_3.position, arg_38_0.mainCamera)
				})
			end
		end
	end

	if arg_38_1 then
		table = var_4

		var_4.insert(arg_38_1, var_38_0)

		table = var_4

		var_4.insert(arg_38_1, var_38_4)
	end

	return var_38_0, var_38_4
end

function var_0_1.GetStockingGeo(arg_39_0, arg_39_1)
	pg = var_1_10002

	if var_1_10002.dorm3d_resource[arg_39_1].stocking_geo_path == "" then
		return nil, nil
	end

	local var_39_0 = arg_39_0:Find(var_2[1])
	local var_39_1 = arg_39_0:Find(var_2[2])

	return var_39_0, var_39_1
end

function var_0_1.InitDormStocking(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0, var_40_1 = arg_40_0:IsUnlockStocking(arg_40_2)

	if not var_40_0 then
		return
	end

	pg = var_5

	local var_40_2 = var_5.dorm3d_resource[arg_40_2].stocking_pos
	local var_40_3, var_40_4 = var_0_1.GetStockingGeo(arg_40_1, arg_40_2)

	if var_40_1 then
		setActive = var_8

		var_8(var_40_3, true)

		setActive = var_8

		var_8(var_40_4, true)

		GraphicsInterface = var_8

		local var_40_5 = var_8.Instance

		var_8.SetStockingPos(var_40_5, var_40_3.gameObject, var_40_2[1])

		GraphicsInterface = var_8

		local var_40_6 = var_8.Instance

		var_8.SetStockingPos(var_40_6, var_40_4.gameObject, var_40_2[2])
	else
		setActive = var_8

		var_8(var_40_3, false)

		setActive = var_8

		var_8(var_40_4, false)

		local var_40_7 = arg_40_1:Find("all/body_geo")
		local var_40_8 = var_8.GetComponent

		typeof = var_10
		SkinnedMeshRenderer = var_1_10011

		local var_40_9 = var_40_8(var_40_7, var_10(var_1_10011))

		var_8.SetBlendShapeWeight(var_40_9, 0, 0)
		var_8:SetBlendShapeWeight(1, 0)
	end

	return
end

function var_0_1.IsUnlockStocking(arg_41_0, arg_41_1)
	if not var_0_1.UNLOCK_CONFIG[arg_41_1] then
		return false, false
	end

	local var_41_0 = true
	local var_41_1 = arg_41_0:GetRoom()
	local var_41_2 = var_3.IsFurnitureSetIn(var_41_1, var_0_1.UNLOCK_CONFIG[arg_41_1])
end

return var_0_1
