local var_0_0 = class("Dorm3dStockingMgr", import("view.dorm3d.Extra.BaseExtraSystem"))

var_0_0.SET_STOCKING_STATUS = "Dorm3dStockingMgr.SET_STOCKING_STATUS"
var_0_0.EXIT_STOCKING_STATUS = "Dorm3dStockingMgr.EXIT_STOCKING_STATUS"
var_0_0.GET_TIP_SHOW_INFO = "Dorm3dStockingMgr.GET_TIP_SHOW_INFO"
var_0_0.ON_BEGIN_DRAG = "Dorm3dStockingMgr.ON_BEGIN_DRAG"
var_0_0.ON_DRAG = "Dorm3dStockingMgr.ON_DRAG"
var_0_0.ON_END_DRAG = "Dorm3dStockingMgr.ON_END_DRAG"
var_0_0.ON_EXIT_TOUCH_MODE = "Dorm3dStockingMgr.ON_EXIT_TOUCH_MODE"
var_0_0.L_COLLIDERS = {
	"LeftThighCollider",
	"LeftCalfCollider",
	"LeftFootCollider"
}
var_0_0.R_COLLIDERS = {
	"RightThighCollider",
	"RightCalfCollider",
	"RightFootCollider"
}
var_0_0.UNLOCK_CONFIG = {
	[307071] = 1222
}

local var_0_1

function var_0_0.OnInit(arg_1_0)
	local var_1_0 = arg_1_0:GetCurrentLadyEnv()

	if var_1_0 then
		for iter_1_0, iter_1_1 in pairs(var_1_0.skinIdList) do
			arg_1_0:InitDormStocking(arg_1_0:Get("skinDict")[iter_1_1].ladyGameObject.transform, iter_1_1)
		end
	end

	return
end

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_0.SET_STOCKING_STATUS, function(arg_3_0, arg_3_1)
		arg_2_0:SetStockingStatus(arg_3_1)

		return
	end)
	arg_2_0:Bind(var_0_0.EXIT_STOCKING_STATUS, function(arg_4_0)
		arg_2_0:ExitStockingStatus()

		return
	end)
	arg_2_0:Bind(var_0_0.GET_TIP_SHOW_INFO, function(arg_5_0, arg_5_1)
		return arg_2_0:GetTipShowInfo(arg_5_1)
	end)
	arg_2_0:Bind(var_0_0.ON_BEGIN_DRAG, function(arg_6_0, arg_6_1, arg_6_2)
		arg_2_0:OnBeginDrag(arg_6_1, arg_6_2)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_DRAG, function(arg_7_0, arg_7_1, arg_7_2)
		arg_2_0:OnDrag(arg_7_1, arg_7_2)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_END_DRAG, function(arg_8_0, arg_8_1, arg_8_2)
		arg_2_0:OnEndDrag(arg_8_1, arg_8_2)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_EXIT_TOUCH_MODE, function(arg_9_0)
		arg_2_0:OnExitTouchMode()

		return
	end)

	return
end

function var_0_0.OnHandleNotification(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == GAME.APARTMENT_REPLACE_FURNITURE_DONE then
		local var_10_0 = arg_10_0:GetCurrentLadyEnv()

		if not var_10_0 then
			return
		end

		for iter_10_0, iter_10_1 in pairs(var_10_0.skinIdList) do
			arg_10_0:InitDormStocking(arg_10_0:Get("skinDict")[iter_10_1].ladyGameObject.transform, iter_10_1)
		end
	end

	return
end

function var_0_0.GetInterests()
	return {
		GAME.APARTMENT_REPLACE_FURNITURE_DONE
	}
end

function var_0_0.OnBeginDrag(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.blockingDrag then
		return
	end

	local var_12_0 = CameraMgr.instance:Raycast(arg_12_0:Get("sceneRaycaster"), arg_12_2.position):ToTable()

	if #var_12_0 > 0 then
		local var_12_1 = var_12_0[1].gameObject.transform
		local var_12_2, var_12_3 = table.Find(var_0_0.L_COLLIDERS, function(arg_13_0, arg_13_1)
			return var_12_1.name == arg_13_1
		end)
		local var_12_4, var_12_5 = table.Find(var_0_0.R_COLLIDERS, function(arg_14_0, arg_14_1)
			return var_12_1.name == arg_14_1
		end)
		local var_12_6 = var_12_3 and 1 or var_12_5 and 2 or nil

		warning(var_12_1, var_12_3 and 1 or var_12_5 and 2 or nil)

		if not var_12_6 or var_0_1.enable_drag[var_12_6] == 0 or not arg_12_0.isShow[var_12_6] then
			return
		end

		arg_12_0.inDragStocking = var_12_6

		if arg_12_0.inDragStocking then
			arg_12_0.startStockingPos = GraphicsInterface.Instance:GetStockingPos(arg_12_0.stockingTFs[arg_12_0.inDragStocking].gameObject)
			arg_12_0.preMin, arg_12_0.preMax = arg_12_0.startStockingPos, arg_12_0.startStockingPos

			GraphicsInterface.Instance:StockingMouseDown(arg_12_0.stockingTFs[arg_12_0.inDragStocking].gameObject, arg_12_2.position, arg_12_0.mainCamera)
		end
	end

	return
end

function var_0_0.OnDrag(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.blockingDrag then
		return
	end

	if arg_15_0.inDragStocking then
		GraphicsInterface.Instance:StockingMouseDrag(arg_15_0.stockingTFs[arg_15_0.inDragStocking].gameObject, arg_15_2.position, arg_15_0.mainCamera)

		local var_15_0 = GraphicsInterface.Instance:GetStockingPos(arg_15_0.stockingTFs[arg_15_0.inDragStocking].gameObject)

		arg_15_0.preMin = math.min(arg_15_0.preMin, var_15_0)
		arg_15_0.preMax = math.max(arg_15_0.preMax, var_15_0)

		return
	end

	arg_15_0:Emit(Dorm3dRoomTemplateScene.ON_STICK_MOVE, arg_15_2.delta)

	return
end

function var_0_0.OnEndDrag(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.blockingDrag then
		return
	end

	if arg_16_0.inDragStocking then
		GraphicsInterface.Instance:StockingMouseUp(arg_16_0.stockingTFs[arg_16_0.inDragStocking].gameObject)

		arg_16_0.endStockingPos = GraphicsInterface.Instance:GetStockingPos(arg_16_0.stockingTFs[arg_16_0.inDragStocking].gameObject)

		arg_16_0:TryTriggerEvent()
		arg_16_0:CheckStockingShow()
	end

	arg_16_0.inDragStocking = nil

	return
end

function var_0_0.TryTriggerEvent(arg_17_0)
	warning("TryTriggerEvent", arg_17_0.inDragStocking, arg_17_0.startStockingPos, arg_17_0.endStockingPos, arg_17_0.preMin, arg_17_0.preMax)

	local var_17_0 = arg_17_0.inDragStocking

	var_17_0 = arg_17_0.endStockingPos > arg_17_0.startStockingPos and var_17_0 * 2 - 1 or var_17_0 * 2

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.triggerDic[var_17_0]) do
		if iter_17_1:Check(arg_17_0.endStockingPos, arg_17_0.preMax, arg_17_0.preMin) then
			local var_17_1, var_17_2, var_17_3 = iter_17_1:Trigger()

			arg_17_0:TriggerEvent(var_17_1, var_17_2, var_17_3)

			break
		end
	end

	return
end

function var_0_0.TriggerEvent(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	warning("TriggerEvent", arg_18_1, arg_18_2, arg_18_3)

	arg_18_0.blockingDrag = true

	local function var_18_0()
		arg_18_0.blockingDrag = false

		if arg_18_3 then
			arg_18_0:ExitStockingStatus()
		else
			arg_18_0:ResetLady()
		end

		return
	end

	switch(arg_18_1, {
		function()
			arg_18_0:Func("DoTalk", arg_18_2[1], var_18_0)

			return
		end
	})

	return
end

function var_0_0.CheckStockingShow(arg_21_0)
	if not arg_21_0.useHideMode then
		return
	end

	if arg_21_0.endStockingPos <= 0.01 then
		arg_21_0.isShow[arg_21_0.inDragStocking] = false

		setActive(arg_21_0.stockingTFs[arg_21_0.inDragStocking], false)
		setActive(arg_21_0.sceneStockingTFs[arg_21_0.inDragStocking], true)
	end

	return
end

function var_0_0.InitStatus(arg_22_0, arg_22_1)
	arg_22_0.ladyEnv = arg_22_0:GetCurrentLadyEnv()
	var_0_1 = pg.dorm3d_stocking[arg_22_1]
	arg_22_0.cacheIkStatus = arg_22_0.ladyEnv.currentIkStatus
	arg_22_0.inDragStocking = false
	arg_22_0.stockingL, arg_22_0.stockingR = var_0_0.GetStockingGeo(arg_22_0.ladyEnv.lady, var_0_1.skin_id)
	arg_22_0.stockingTFs = {
		arg_22_0.stockingL,
		arg_22_0.stockingR
	}
	arg_22_0.mainCamera = arg_22_0:Get("mainCameraTF"):GetComponent(typeof(Camera))
	arg_22_0.tiptransforms = {
		arg_22_0.ladyEnv.lady:Find(var_0_1.tip_show_path[1]),
		arg_22_0.ladyEnv.lady:Find(var_0_1.tip_show_path[2])
	}
	arg_22_0.tipDirections = {
		{
			arg_22_0.ladyEnv.lady:Find(var_0_1.l_tip_bone_path[1]),
			arg_22_0.ladyEnv.lady:Find(var_0_1.l_tip_bone_path[2])
		},
		{
			arg_22_0.ladyEnv.lady:Find(var_0_1.r_tip_bone_path[1]),
			arg_22_0.ladyEnv.lady:Find(var_0_1.r_tip_bone_path[2])
		}
	}
	arg_22_0.triggerDic = {
		{},
		{},
		{},
		{}
	}

	for iter_22_0, iter_22_1 in ipairs({
		var_0_1.l_trigger,
		var_0_1.r_trigger
	}) do
		(function(arg_23_0, arg_23_1)
			for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
				local var_23_0 = StockingTrigger.New(iter_23_1)

				if var_23_0:GetCompareType() == 0 then
					table.insert({}, var_23_0)
				else
					table.insert({}, var_23_0)
				end
			end

			StockingTrigger.Sort({})
			StockingTrigger.Sort({})

			arg_22_0.triggerDic[arg_23_0 * 2 - 1] = {}
			arg_22_0.triggerDic[arg_23_0 * 2] = {}

			return
		end)(iter_22_0, iter_22_1)
	end

	arg_22_0.inited = true

	return
end

function var_0_0.InitHideMode(arg_24_0)
	arg_24_0.useHideMode = var_0_1.scene_stocking_path ~= "" and #var_0_1.scene_stocking_path == 2
	arg_24_0.isShow = {
		isActive(arg_24_0.stockingL),
		isActive(arg_24_0.stockingR)
	}

	if arg_24_0.useHideMode then
		arg_24_0.sceneStockingTFs = {
			arg_24_0:GetSceneItem(var_0_1.scene_stocking_path[1]),
			arg_24_0:GetSceneItem(var_0_1.scene_stocking_path[2])
		}

		for iter_24_0, iter_24_1 in ipairs(arg_24_0.sceneStockingTFs) do
			(function(arg_25_0, arg_25_1)
				GetOrAddComponent(arg_25_1, typeof(EventTriggerListener)):AddPointClickFunc(function(arg_26_0, arg_26_1)
					arg_24_0.isShow[arg_25_0] = true

					setActive(arg_24_0.stockingTFs[arg_25_0], true)
					setActive(arg_24_0.sceneStockingTFs[arg_25_0], false)
					GraphicsInterface.Instance:SetStockingPos(arg_24_0.stockingTFs[arg_25_0].gameObject, var_0_1.wear_initial_pos[arg_25_0])

					return
				end)

				return
			end)(iter_24_0, iter_24_1)
			setActive(iter_24_1, not arg_24_0.isShow[iter_24_0])
		end
	end

	return
end

function var_0_0.ResetLady(arg_27_0)
	local var_27_0 = arg_27_0:Get("furnitures"):Find(var_0_1.character_position)

	assert(var_27_0, "找不到角色位置点 " .. var_0_1.character_position)

	local var_27_1 = var_27_0:Find("StayPoint")

	arg_27_0.ladyEnv:SetPosition(var_27_1.position)
	arg_27_0.ladyEnv:SetRotation(var_27_1.rotation)
	arg_27_0.ladyEnv:PlaySingleAction(var_0_1.character_action)

	return
end

function var_0_0.SetStockingStatus(arg_28_0, arg_28_1)
	arg_28_0:InitStatus(arg_28_1)
	arg_28_0:InitHideMode()
	warning(">>>>>>>>>>> enter stocking mode <<<<<<<<<<", arg_28_1)
	seriesAsync({
		function(arg_29_0)
			arg_28_0:Emit(RoomIKSystem.SET_IK_STATE, false, arg_29_0, {
				ignoreResetExtraItem = true
			})

			return
		end,
		function(arg_30_0)
			arg_28_0:Func("SetUI", arg_30_0, "stocking")

			return
		end,
		function(arg_31_0)
			arg_28_0:ResetLady()
			arg_28_0:Func("ActiveCameraByName", var_0_1.camera)

			local var_31_0 = arg_28_0:Get("cameraRoot"):Find(var_0_1.camera):GetComponent(typeof(Cinemachine.CinemachineFreeLook))

			if var_31_0 then
				arg_28_0:Func("RegisterOrbits", var_31_0)
			end

			arg_28_0:Func("PlayEnterSceneAnim", var_0_1.enter_scene_anim)
			arg_28_0:Func("PlayEnterExtraItem", arg_28_0.ladyEnv, var_0_1.enter_extra_item)
			arg_28_0:Func("HideSceneItem", arg_28_0.ladyEnv, var_0_1.hide_scene_item)
			setActive(arg_28_0.ladyEnv.ladyCollider, false)
			_.each(arg_28_0.ladyEnv.ladyTouchColliders, function(arg_32_0)
				setActive(arg_32_0, true)

				return
			end)
			arg_31_0()

			return
		end
	})

	return
end

function var_0_0.ExitStockingStatus(arg_33_0)
	seriesAsync({
		function(arg_34_0)
			arg_33_0:Func("SetUI", arg_34_0, "back")

			return
		end,
		function(arg_35_0)
			warning(">>>>>>>>>>> exit stocking mode <<<<<<<<<<")

			if arg_33_0.useHideMode then
				for iter_35_0, iter_35_1 in ipairs(arg_33_0.sceneStockingTFs) do
					GetOrAddComponent(iter_35_1, typeof(EventTriggerListener)):RemovePointClickFunc()
				end
			end

			setActive(arg_33_0.ladyEnv.ladyCollider, true)
			_.each(arg_33_0.ladyEnv.ladyTouchColliders, function(arg_36_0)
				setActive(arg_36_0, false)

				return
			end)
			arg_33_0:Func("ResetSceneItemAnimators")
			arg_33_0:Func("ResetTempHideSceneItems", arg_33_0.ladyEnv)
			arg_33_0:Func("RevertCameraOrbit")
			arg_33_0:Emit(RoomIKSystem.SET_IK_CONFIG, arg_33_0.ladyEnv, arg_33_0.cacheIkStatus)
			arg_33_0:Emit(RoomIKSystem.SET_IK_STATE, true)
			arg_35_0()

			return
		end
	})

	return
end

function var_0_0.OnExitTouchMode(arg_37_0)
	if arg_37_0.inited then
		arg_37_0.inited = false
	end

	return
end

function var_0_0.GetTipShowInfo(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(var_0_1.enable_drag) do
		if iter_38_1 == 1 then
			table.insert({}, {
				pos = arg_38_0:Func("GetScreenPosition", arg_38_0.tiptransforms[iter_38_0].position, arg_38_0.mainCamera),
				dir = arg_38_0:Func("GetScreenPosition", arg_38_0.tipDirections[iter_38_0][2].position, arg_38_0.mainCamera) - arg_38_0:Func("GetScreenPosition", arg_38_0.tipDirections[iter_38_0][1].position, arg_38_0.mainCamera)
			})
		end
	end

	if arg_38_0.useHideMode then
		for iter_38_2, iter_38_3 in ipairs(arg_38_0.sceneStockingTFs) do
			if not arg_38_0.isShow[iter_38_2] then
				table.insert({}, {
					pos = arg_38_0:Func("GetScreenPosition", iter_38_3.position, arg_38_0.mainCamera)
				})
			end
		end
	end

	if arg_38_1 then
		table.insert(arg_38_1, {})
		table.insert(arg_38_1, {})
	end

	return {}, {}
end

function var_0_0.GetStockingGeo(arg_39_0, arg_39_1)
	if pg.dorm3d_resource[arg_39_1].stocking_geo_path == "" then
		return nil, nil
	end

	return arg_39_0:Find(pg.dorm3d_resource[arg_39_1].stocking_geo_path[1]), (arg_39_0:Find(pg.dorm3d_resource[arg_39_1].stocking_geo_path[2]))
end

function var_0_0.InitDormStocking(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0, var_40_1 = arg_40_0:IsUnlockStocking(arg_40_2)

	if not var_40_0 then
		return
	end

	local var_40_2 = pg.dorm3d_resource[arg_40_2].stocking_pos
	local var_40_3, var_40_4 = var_0_0.GetStockingGeo(arg_40_1, arg_40_2)

	if var_40_1 then
		setActive(var_40_3, true)
		setActive(var_40_4, true)
		GraphicsInterface.Instance:SetStockingPos(var_40_3.gameObject, var_40_2[1])
		GraphicsInterface.Instance:SetStockingPos(var_40_4.gameObject, var_40_2[2])
	else
		setActive(var_40_3, false)
		setActive(var_40_4, false)

		local var_40_5 = arg_40_1:Find("all/body_geo"):GetComponent(typeof(SkinnedMeshRenderer))

		var_40_5:SetBlendShapeWeight(0, 0)
		var_40_5:SetBlendShapeWeight(1, 0)
	end

	return
end

function var_0_0.IsUnlockStocking(arg_41_0, arg_41_1)
	if not var_0_0.UNLOCK_CONFIG[arg_41_1] then
		return false, false
	end

	local var_41_1 = arg_41_0:GetRoom():IsFurnitureSetIn(var_0_0.UNLOCK_CONFIG[arg_41_1])
end

return var_0_0
