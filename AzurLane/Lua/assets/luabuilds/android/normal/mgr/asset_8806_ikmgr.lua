pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
singletonClass = pg

local var_0_1 = var_0("IKMgr")

pg = var_1
var_1.IKMgr = var_0_1

function var_0_1.Ctor(arg_1_0)
	arg_1_0.activeIKLayers = {}
	arg_1_0.holdingStatus = {}
	arg_1_0.cacheIKInfos = {}

	return
end

function var_0_1.RegisterEnv(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.ladyIKRoot = arg_2_1
	arg_2_0.ladyBoneMaps = arg_2_2

	arg_2_0:CreateUpdate()

	return
end

function var_0_1.RegisterOnIKLayerActive(arg_3_0, arg_3_1)
	arg_3_0.onIKLayerActive = arg_3_1

	return
end

function var_0_1.RegisterOnIKLayerDeactive(arg_4_0, arg_4_1)
	arg_4_0.onIKLayerDeactive = arg_4_1

	return
end

function var_0_1.RegisterOnIKLayerDrag(arg_5_0, arg_5_1)
	arg_5_0.onIKLayerDrag = arg_5_1

	return
end

function var_0_1.RegisterOnIKLayerAction(arg_6_0, arg_6_1)
	arg_6_0.onIKLayerAction = arg_6_1

	return
end

function var_0_1.UnregisterEnv(arg_7_0)
	arg_7_0.onIKLayerActive = nil
	arg_7_0.onIKLayerDeactive = nil
	arg_7_0.onIKLayerDrag = nil
	arg_7_0.onIKLayerAction = nil

	arg_7_0:ExitIKStatus()

	arg_7_0.ladyIKRoot = nil
	arg_7_0.ladyBoneMaps = nil

	arg_7_0:DisposeUpdate()

	return
end

function var_0_1.CreateUpdate(arg_8_0)
	if arg_8_0.updateHandler then
		return
	end

	UpdateBeat = var_1
	arg_8_0.updateHandler = var_1:CreateListener(function()
		xpcall = var_2_10000

		var_2_10000(function()
			local var_10_0 = arg_8_0

			var_0.Update(var_10_0)

			return
		end, function(...)
			errorMsg = var_3_10000
			debug = var_3_10001

			var_3_10000(var_3_10001.traceback(...))

			return
		end)

		return
	end)
	UpdateBeat = var_1

	var_1:AddListener(arg_8_0.updateHandler)

	return
end

function var_0_1.DisposeUpdate(arg_12_0)
	if not arg_12_0.updateHandler then
		return
	end

	UpdateBeat = var_1

	var_1:RemoveListener(arg_12_0.updateHandler)

	arg_12_0.updateHandler = nil

	return
end

function var_0_1.SetIKStatus(arg_13_0, arg_13_1)
	arg_13_0.readyIKLayers = arg_13_1
	table = var_1_10002

	var_1_10002.Foreach(arg_13_1, function(arg_14_0, arg_14_1)
		arg_13_0.cacheIKInfos[arg_14_1] = {}

		local var_14_0 = arg_14_1:GetControllerPath()
		local var_14_1 = arg_13_0.ladyIKRoot
		local var_14_2 = var_3.Find(var_14_1, var_14_0)
		local var_14_3 = var_3.GetComponent

		typeof = var_5
		RootMotion = var_2_10006

		local var_14_4 = var_14_3(var_14_2, var_5(var_2_10006.FinalIK.IKExecutionOrder))
		local var_14_5 = {}

		table = var_5

		var_5.IpairsCArray(var_14_4.IKComponents, function(arg_15_0, arg_15_1)
			var_14_5[arg_15_0 + 1] = arg_15_1:GetIKSolver()

			return
		end)

		local var_14_6 = arg_13_0.cacheIKInfos[arg_14_1]

		var_14_6.solvers = var_14_5
		_ = var_14_6

		local var_14_7

		var_14_7.weights, var_14_7 = var_14_6.map(var_14_5, function(arg_16_0)
			return arg_16_0.IKPositionWeight
		end), arg_13_0.cacheIKInfos[arg_14_1]
		tf = var_14_7

		local var_14_8 = var_14_7(var_14_4)
		local var_14_9 = var_6.Find(var_14_8, "Container/SubTargets")
		local var_14_10 = arg_14_1
		local var_14_11 = arg_14_1.GetSubTargets(var_14_10)

		table = var_14_10

		var_14_10.Foreach(var_14_11, function(arg_17_0, arg_17_1)
			local var_17_0 = var_14_9
			local var_17_1 = var_2.Find(var_17_0, arg_17_1.name .. "/Plane")

			var_17_1.localRotation = arg_17_1.planeRot
			var_17_1.localScale = arg_17_1.planeScale

			return
		end)

		return
	end)

	return
end

function var_0_1.ExitIKStatus(arg_18_0)
	arg_18_0:ResetAllIKLayers()

	arg_18_0.readyIKLayers = nil
	arg_18_0.ikHandler = nil
	arg_18_0.ikRevertHandler = nil
	table = var_1

	var_1.clear(arg_18_0.activeIKLayers)

	table = var_1

	var_1.clear(arg_18_0.cacheIKInfos)

	table = var_1

	var_1.clear(arg_18_0.holdingStatus)

	return
end

function var_0_1.Update(arg_19_0)
	(function()
		if not arg_19_0.ikHandler then
			return
		end

		if not arg_19_0.ikHandler.targetScreenOffset then
			return
		end

		local var_20_0 = arg_19_0.ikHandler.rect
		local var_20_1 = var_0.PointToNormalized

		Vector2 = var_2_10003

		local var_20_2 = var_20_1(var_20_0, var_2_10003.zero)
		local var_20_3 = var_0
		local var_20_4 = var_0.PointToNormalized(var_20_3, arg_19_0.ikHandler.targetScreenOffset) - var_20_2

		_ = var_20_3

		var_20_3.each(arg_19_0.ikHandler.subPlanes, function(arg_21_0)
			local var_21_0 = arg_21_0.target
			local var_21_1 = arg_21_0.planeData

			var_21_0.position = var_0_1.GetPostionByRatio(var_21_1, var_20_4)

			return
		end)

		return
	end)()

	if arg_19_0.ikRevertHandler then
		arg_19_0.ikRevertHandler()
	end

	return
end

function var_0_1.OnDragBegin(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	_ = var_1_10004

	if not var_1_10004.detect(arg_22_0.readyIKLayers, function(arg_23_0)
		return arg_23_0:GetTriggerName() == arg_22_1
	end) then
		return
	end

	if not arg_22_3 and var_4:IsIgnoreDrag() then
		return
	end

	warning = var_5

	var_5("ENABLEIK", var_4:GetControllerPath())

	local var_22_0 = var_4:GetControllerPath()
	local var_22_1 = arg_22_0.ladyIKRoot
	local var_22_2 = var_6.Find(var_22_1, var_22_0)
	local var_22_3 = var_6.GetComponent

	typeof = var_8
	RootMotion = var_1_10009

	local var_22_4 = var_22_3(var_22_2, var_8(var_1_10009.FinalIK.IKExecutionOrder))

	pg = var_22_2

	local var_22_5 = var_22_2.UIMgr.GetInstance().uiCamera
	local var_22_6 = var_7.Find(var_22_5, "Canvas").rect

	Vector2 = var_9

	local var_22_7 = var_9.New
	local var_22_8 = arg_22_2.x

	Screen = var_1_10011

	local var_22_9 = var_22_8 / var_1_10011.width * var_22_6.width
	local var_22_10 = arg_22_2.y

	Screen = var_1_10012
	arg_22_2 = var_22_7(var_22_9, var_22_10 / var_1_10012.height * var_22_6.height)

	local var_22_11 = {
		ikData = var_4,
		list = var_22_4
	}

	if not arg_22_0.holdingStatus[var_4] then
		var_22_11.rect = var_4:GetControlRect()

		local var_22_12 = var_4
		local var_22_13 = var_4.GetActionType(var_22_12)

		Dorm3dIK = var_22_12

		if var_22_13 ~= var_22_12.ACTION_TRIGGER.RELEASE_ON_TARGET then
			Dorm3dIK = var_11

			if var_22_13 == var_11.ACTION_TRIGGER.TOUCH_TARGET then
				var_22_11.triggerRect = var_4:GetActionRect()
			end

			var_22_11.originScreenPosition = arg_22_2
			tf = var_11

			local var_22_14 = var_11(var_22_4)
			local var_22_15 = var_11.Find(var_22_14, "Container/SubTargets")
			local var_22_16 = {}

			assert = var_13

			var_13(var_22_15)

			local var_22_17 = var_4
			local var_22_18 = var_4.GetSubTargets(var_22_17)

			_ = var_22_17

			var_22_17.each(var_22_18, function(arg_24_0)
				local var_24_0 = var_22_15
				local var_24_1 = var_1.Find(var_24_0, arg_24_0.name)
				local var_24_2 = var_1.Find(var_24_1, "Plane")
				local var_24_3 = var_1:Find("Target")
				local var_24_4 = var_0_1.TransformMesh
				local var_24_5 = var_24_2
				local var_24_6 = var_24_2.GetComponent

				typeof = var_2_10007
				UnityEngine = var_2_10008

				local var_24_7 = var_24_4(var_24_6(var_24_5, var_2_10007(var_2_10008.MeshCollider)))

				var_24_7.origin = arg_22_0.ladyBoneMaps[arg_24_0.name].position

				local var_24_8 = var_22_11.rect

				Vector2 = var_7

				local var_24_9 = var_7.New(var_24_8.center.x / var_24_8.width, var_24_8.center.y / var_24_8.height)

				var_24_2.position = var_0_1.GetPostionByRatio(var_24_7, var_24_9)
				var_24_3.position = var_5.position

				local var_24_10 = {
					planeData = var_24_7,
					target = var_24_3
				}

				table = var_10

				var_10.insert(var_22_16, var_24_10)

				return
			end)

			var_22_11.subPlanes = var_22_16
			setActive = var_14

			var_14(var_22_4, true)

			if false then
				var_22_13 = arg_22_2 - arg_22_0.holdingStatus[var_4].ikHandler.screenPosition
				var_22_11.originScreenPosition = var_22_11.originScreenPosition + var_22_13
				arg_22_0.holdingStatus[var_4] = nil
			end

			arg_22_0.ikHandler = var_22_11
			existCall = var_22_13

			var_22_13(arg_22_0.onIKLayerActive, var_22_11)

			return
		end
	end
end

function var_0_1.HandleBodyDrag(arg_25_0, arg_25_1)
	if not arg_25_0.ikHandler then
		return
	end

	local var_25_0 = arg_25_0.ikHandler

	pg = var_1_10003

	local var_25_1 = var_1_10003.UIMgr.GetInstance().uiCamera
	local var_25_2 = var_3.Find(var_25_1, "Canvas").rect

	Vector2 = var_5

	local var_25_3 = var_5.New
	local var_25_4 = arg_25_1.x

	Screen = var_1_10007

	local var_25_5 = var_25_4 / var_1_10007.width * var_25_2.width
	local var_25_6 = arg_25_1.y

	Screen = var_1_10008
	var_25_0.screenPosition = var_25_3(var_25_5, var_25_6 / var_1_10008.height * var_25_2.height)

	local var_25_7 = arg_25_1 - var_25_0.originScreenPosition
	local var_25_8 = var_25_0.ikData
	local var_25_9 = var_25_0.rect
	local var_25_10 = var_7.Contains(var_25_9, var_25_7)
	local var_25_12

	if var_25_0.triggerRect then
		local var_25_11 = var_25_0.triggerRect

		var_25_12 = var_9.Contains(var_25_11, var_25_7)
	end

	if not var_25_10 then
		local var_25_13 = var_25_8
		local var_25_14 = var_25_8.GetActionType(var_25_13)

		Dorm3dIK = var_25_13

		if var_25_14 == var_25_13.ACTION_TRIGGER.TOUCH_TARGET and var_25_12 then
			arg_25_0.ikHandler = nil
			existCall = var_10

			var_10(arg_25_0.onIKLayerDeactive, var_25_0, true)

			table = var_10

			var_10.insert(arg_25_0.activeIKLayers, var_25_8)
			arg_25_0:PlayIKAction(var_25_0)

			return
		end
	end

	local function var_25_15()
		if var_25_10 then
			return var_25_7
		end

		local var_26_0 = var_25_7
		local var_26_1 = var_0.center
		local var_26_2 = {}
		local var_26_3 = {}

		Vector2 = var_2_10004
		var_26_3[1] = var_2_10004.New(var_0.xMin, var_0.yMin)
		Vector2 = var_4
		var_26_3[2] = var_4.New(var_0.xMin, var_0.yMax)
		var_26_2[1] = var_26_3

		local var_26_4 = {}

		Vector2 = var_4
		var_26_4[1] = var_4.New(var_0.xMin, var_0.yMax)
		Vector2 = var_4
		var_26_4[2] = var_4.New(var_0.xMax, var_0.yMax)
		var_26_2[2] = var_26_4

		local var_26_5 = {}

		Vector2 = var_4
		var_26_5[1] = var_4.New(var_0.xMax, var_0.yMax)
		Vector2 = var_4
		var_26_5[2] = var_4.New(var_0.xMax, var_0.yMin)
		var_26_2[3] = var_26_5

		local var_26_6 = {}

		Vector2 = var_4
		var_26_6[1] = var_4.New(var_0.xMax, var_0.yMin)
		Vector2 = var_4
		var_26_6[2] = var_4.New(var_0.xMin, var_0.yMin)
		var_26_2[4] = var_26_6

		for iter_26_0 = 1, 4 do
			SegmentUtil = var_2_10007
			var_2_10007 = var_2_10007.GetCrossPoint

			local var_26_7 = var_26_1
			local var_26_8 = var_26_0

			unpack = var_2_10010

			local var_26_9

			var_2_10007, var_26_9 = var_2_10007(var_26_7, var_26_8, var_2_10010(var_26_2[iter_26_0]))

			if var_2_10007 then
				return var_26_9
			end
		end

		assert = var_3

		var_3(false)

		return var_26_0
	end

	local var_25_16 = arg_25_0.ikHandler

	var_25_16.targetScreenOffset = var_25_15()
	existCall = var_25_16

	var_25_16(arg_25_0.onIKLayerDrag, arg_25_0.ikHandler)

	return
end

function var_0_1.ReleaseDrag(arg_27_0)
	if not arg_27_0.ikHandler then
		return
	end

	local var_27_0 = arg_27_0.ikHandler.ikData
	local var_27_1
	local var_27_2 = var_27_0
	local var_27_3 = var_27_0.GetActionType(var_27_2)

	Dorm3dIK = var_27_2

	if var_27_3 == var_27_2.ACTION_TRIGGER.RELEASE then
		var_27_1 = true
	else
		Dorm3dIK = var_5

		if var_27_3 == var_5.ACTION_TRIGGER.RELEASE_ON_TARGET then
			local var_27_4 = var_1.screenPosition - var_1.originScreenPosition

			if var_1.triggerRect then
				local var_27_5 = var_1.triggerRect

				if var_7.Contains(var_27_5, var_27_4) then
					var_27_1 = true
				end
			end
		end
	end

	arg_27_0.ikHandler = nil
	existCall = var_5

	var_5(arg_27_0.onIKLayerDeactive, var_1, var_27_1)

	if var_27_1 then
		table = var_5

		var_5.insert(arg_27_0.activeIKLayers, var_27_0)
		arg_27_0:PlayIKAction(var_1)

		return
	end

	if var_27_0:GetBackTime() < 999 then
		table = var_6

		var_6.insert(arg_27_0.activeIKLayers, var_27_0)
		arg_27_0:PlayIKRevert(var_5)
	else
		arg_27_0.holdingStatus[var_27_0] = {
			ikHandler = var_1
		}
	end

	return
end

function var_0_1.PlayIKRevert(arg_28_0, arg_28_1, arg_28_2)
	Time = var_1_10003

	local var_28_0 = var_1_10003.time

	function arg_28_0.ikRevertHandler()
		Time = var_2_10000

		local var_29_0 = var_2_10000.time - var_28_0

		_ = var_1

		var_1.each(arg_28_0.activeIKLayers, function(arg_30_0)
			local var_30_0 = 1

			if arg_28_1 > 0 then
				var_30_0 = var_29_0 / arg_28_1
			end

			local var_30_1 = arg_28_0.cacheIKInfos[arg_30_0].solvers
			local var_30_2 = arg_28_0.cacheIKInfos[arg_30_0].weights

			table = var_3_10004

			var_3_10004.Foreach(var_30_1, function(arg_31_0, arg_31_1)
				math = var_4_10002
				arg_31_1.IKPositionWeight = var_4_10002.lerp(var_30_2[arg_31_0], 0, var_30_0)

				return
			end)

			return
		end)

		if var_29_0 >= arg_28_1 then
			local var_29_1 = arg_28_0

			var_1.ResetActiveIKs(var_29_1)

			local var_29_2 = arg_28_0

			var_29_2.ikRevertHandler = nil
			existCall = var_29_2

			var_29_2(arg_28_2)
		end

		return
	end

	arg_28_0.ikRevertHandler()

	return
end

function var_0_1.ResetIK(arg_32_0, arg_32_1)
	_ = var_1_10002

	if not var_1_10002.detect(arg_32_0.readyIKLayers, function(arg_33_0)
		return arg_33_0:GetTriggerName() == arg_32_1
	end) then
		return
	end

	local var_32_0 = var_2:GetControllerPath()
	local var_32_1 = arg_32_0.ladyIKRoot
	local var_32_2 = var_4.Find(var_32_1, var_32_0)
	local var_32_3 = var_4.GetComponent

	typeof = var_6
	RootMotion = var_1_10007

	local var_32_4 = var_32_3(var_32_2, var_6(var_1_10007.FinalIK.IKExecutionOrder))

	setActive = var_32_2

	var_32_2(var_32_4, false)

	local var_32_5 = arg_32_0.cacheIKInfos[var_2].solvers
	local var_32_6 = arg_32_0.cacheIKInfos[var_2].weights

	table = var_7

	var_7.Foreach(var_32_5, function(arg_34_0, arg_34_1)
		arg_34_1.IKPositionWeight = var_32_6[arg_34_0]

		arg_34_1:FixTransforms()

		return
	end)

	arg_32_0.holdingStatus[var_2] = nil

	if arg_32_0.moveTimer then
		local var_32_7 = arg_32_0.moveTimer

		var_7.Stop(var_32_7)

		arg_32_0.moveTimer = nil
	end

	return
end

function var_0_1.ResetIKLayers(arg_35_0, arg_35_1)
	local var_35_0 = {}

	_ = var_1_10003

	var_1_10003.each(arg_35_1 or {}, function(arg_36_0)
		if not arg_36_0 or var_35_0[arg_36_0] then
			return
		end

		var_35_0[arg_36_0] = true

		local var_36_0 = arg_36_0:GetControllerPath()
		local var_36_1

		if arg_35_0.ladyIKRoot then
			var_2_10003 = arg_35_0.ladyIKRoot
			var_36_1 = var_2.Find(var_2_10003, var_36_0)
		end

		if var_36_1 then
			IsNil = var_2_10003

			if not var_2_10003(var_36_1) then
				setActive = var_3

				var_3(var_36_1, false)
			end
		end

		if arg_35_0.cacheIKInfos[arg_36_0] then
			local var_36_2 = var_3.solvers
			local var_36_3 = var_3.weights

			table = var_2_10006

			var_2_10006.Foreach(var_36_2, function(arg_37_0, arg_37_1)
				arg_37_1.IKPositionWeight = var_36_3[arg_37_0]

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.ResetAllIKLayers(arg_38_0)
	local var_38_0 = {}

	local function var_38_1(arg_39_0)
		if not arg_39_0 then
			return
		end

		table = var_2_10001

		var_2_10001.insert(var_38_0, arg_39_0)

		return
	end

	_ = var_1_10003

	local var_38_2 = var_1_10003.each
	local var_38_3

	if not arg_38_0.readyIKLayers then
		var_38_3 = {}
	end

	var_38_2(var_38_3, var_38_1)

	_ = var_38_2

	local var_38_4 = var_38_2.each
	local var_38_5

	if not arg_38_0.activeIKLayers then
		var_38_5 = {}
	end

	var_38_4(var_38_5, var_38_1)

	_ = var_38_4

	local var_38_6 = var_38_4.each

	_ = var_38_5

	var_38_6(var_38_5.keys(arg_38_0.holdingStatus), var_38_1)

	if arg_38_0.ikHandler then
		var_38_1(arg_38_0.ikHandler.ikData)
	end

	arg_38_0:ResetIKLayers(var_38_0)

	table = var_3

	var_3.clear(arg_38_0.activeIKLayers)

	table = var_3

	var_3.clear(arg_38_0.holdingStatus)

	arg_38_0.ikHandler = nil
	arg_38_0.ikRevertHandler = nil

	if arg_38_0.moveTimer then
		local var_38_7 = arg_38_0.moveTimer

		var_3.Stop(var_38_7)

		arg_38_0.moveTimer = nil
	end

	return
end

function var_0_1.ResetActiveIKs(arg_40_0)
	table = var_1_10001

	local var_40_0 = var_1_10001.insertto
	local var_40_1 = arg_40_0.activeIKLayers

	_ = var_1_10003

	var_40_0(var_40_1, var_1_10003.keys(arg_40_0.holdingStatus))

	table = var_40_0

	var_40_0.clear(arg_40_0.holdingStatus)
	arg_40_0:ResetIKLayers(arg_40_0.activeIKLayers)

	table = var_1

	var_1.clear(arg_40_0.activeIKLayers)

	if arg_40_0.moveTimer then
		local var_40_2 = arg_40_0.moveTimer

		var_1.Stop(var_40_2)

		arg_40_0.moveTimer = nil
	end

	return
end

function var_0_1.PlayIKAction(arg_41_0, arg_41_1)
	warning = var_1_10002

	local var_41_0 = "Trigger IK"
	local var_41_1 = arg_41_1.ikData

	var_1_10002(var_41_0, var_4.GetControllerPath(var_41_1))

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_42_0)
			table = var_2_10001

			local var_42_0 = var_2_10001.insertto
			local var_42_1 = arg_41_0.activeIKLayers

			_ = var_2_10003

			var_42_0(var_42_1, var_2_10003.keys(arg_41_0.holdingStatus))

			table = var_42_0

			var_42_0.clear(arg_41_0.holdingStatus)

			local var_42_2 = arg_41_0
			local var_42_3 = var_1.PlayIKRevert
			local var_42_4 = arg_41_1.ikData

			var_42_3(var_42_2, var_3.GetActionRevertTime(var_42_4), arg_42_0)

			return
		end,
		function(arg_43_0)
			existCall = var_2_10001

			var_2_10001(arg_41_0.onIKLayerAction, arg_41_1)

			return
		end
	})

	return
end

function var_0_1.PlayIKMove(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6)
	if arg_44_0.moveTimer then
		local var_44_0 = arg_44_0.moveTimer

		var_7.Stop(var_44_0)

		arg_44_0.moveTimer = nil
	end

	arg_44_0.ikRevertHandler = nil
	_ = var_7

	if not var_7.detect(arg_44_0.readyIKLayers, function(arg_45_0)
		return arg_45_0:GetTriggerName() == arg_44_2
	end) then
		existCall = var_8

		var_8(arg_44_6)

		return
	end

	warning = var_8

	var_8("PLAY IKMOVE", var_7:GetControllerPath())
	arg_44_0:OnDragBegin(arg_44_2, arg_44_1, true)

	if not arg_44_0.ikHandler then
		existCall = var_8

		var_8(arg_44_6)

		return
	end

	Time = var_8

	local var_44_1 = var_8.time + arg_44_5
	local var_44_2 = arg_44_1
	local var_44_3 = arg_44_0.ikHandler.originScreenPosition
	local var_44_4 = arg_44_0.ikHandler.rect
	local var_44_5 = var_44_3 + var_11.NormalizedToPoint(var_44_4, arg_44_3) * arg_44_4

	local function var_44_6()
		if arg_44_0.ikHandler then
			Time = var_46_2

			local var_46_2

			if var_46_2.time > var_44_1 then
				local var_46_0 = arg_44_0

				var_46_2.ReleaseDrag(var_46_0)

				if arg_44_0.moveTimer then
					local var_46_1 = arg_44_0.moveTimer

					var_46_2.Stop(var_46_1)

					var_46_2 = arg_44_0
					var_46_2.moveTimer = nil
				end

				existCall = var_46_2

				var_46_2(arg_44_6)

				return
			end

			math = var_46_2

			local var_46_3 = var_46_2.max
			local var_46_4 = 0
			local var_46_5 = var_44_1

			Time = var_2_10003

			local var_46_6 = var_46_3(var_46_4, var_46_5 - var_2_10003.time) / arg_44_5

			Vector2 = var_1

			local var_46_7 = var_1.Lerp(var_44_5, var_44_2, var_46_6)

			pg = var_2

			local var_46_8 = var_2.UIMgr.GetInstance().uiCamera
			local var_46_9 = var_2.Find(var_46_8, "Canvas").rect

			Vector2 = var_4

			local var_46_10 = var_4.New
			local var_46_11 = var_46_7.x / var_46_9.width

			Screen = var_6

			local var_46_12 = var_46_11 * var_6.width
			local var_46_13 = var_46_7.y / var_46_9.height

			Screen = var_7

			local var_46_14 = var_46_10(var_46_12, var_46_13 * var_7.height)
			local var_46_15 = arg_44_0

			var_4.HandleBodyDrag(var_46_15, var_46_14)

			return
		end
	end

	FrameTimer = var_44_4
	arg_44_0.moveTimer = var_44_4.New(var_44_6, 1, -1)

	local var_44_7 = arg_44_0.moveTimer

	var_12.Start(var_44_7)
	var_44_6()

	return
end

function var_0_1.TransformMesh(arg_47_0)
	local var_47_0 = arg_47_0.sharedMesh
	local var_47_1 = {}
	local var_47_2 = arg_47_0.transform
	local var_47_3 = var_3.TransformPoint(var_47_2, var_47_0.vertices[0])
	local var_47_4 = arg_47_0.transform
	local var_47_5 = var_4.TransformPoint(var_47_4, var_47_0.vertices[1])
	local var_47_6 = arg_47_0.transform
	local var_47_7 = var_5.TransformPoint(var_47_6, var_47_0.vertices[2])

	var_47_1.horizontal = var_47_5 - var_47_3
	var_47_1.verticle = var_47_7 - var_47_3
	var_47_1.origin = var_47_3

	return var_47_1
end

function var_0_1.GetPostionByRatio(arg_48_0, arg_48_1)
	return arg_48_0.horizontal * arg_48_1.x + arg_48_0.verticle * arg_48_1.y + arg_48_0.origin
end

return
