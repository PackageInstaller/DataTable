class = var_0_10000

local var_0_0 = var_0_10000("BackYardInteractionPreview")
local var_0_1 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.container = arg_1_1
	arg_1_0.initPosition = arg_1_2

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_0.furnitureId == arg_2_2 and arg_2_0.shipSkinId == arg_2_1 then
		return
	end

	arg_2_0.scale = arg_2_3 or 1

	if arg_2_4 then
		Vector3 = var_5
		arg_2_0.position = var_5(arg_2_4[1], arg_2_4[2], 0)
	else
		arg_2_0.position = arg_2_0.initPosition
	end

	arg_2_0:StartLoad(arg_2_1, arg_2_2)

	arg_2_0.shipSkinId = arg_2_1
	arg_2_0.furnitureId = arg_2_2

	return
end

function var_0_0.StartLoad(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:UnloadSpines()

	pg = var_3

	local var_3_0 = var_3.UIMgr.GetInstance()

	var_3.LoadingOn(var_3_0)

	seriesAsync = var_3

	var_3({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.LoadFurniture(var_4_0, arg_3_2, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.LoadShip(var_5_0, arg_3_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0

			var_1.StartInteraction(var_6_0, arg_3_2, arg_3_1, arg_6_0)

			return
		end
	}, function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_7_0)

		return
	end)

	return
end

function var_0_0.LoadShip(arg_8_0, arg_8_1, arg_8_2)
	pg = var_1_10003

	local var_8_0 = var_1_10003.ship_skin_template[arg_8_1].prefab

	SpineAnimChar = var_1_10004
	arg_8_0.loadedShip = var_1_10004.New()

	local var_8_1 = arg_8_0.loadedShip

	var_4.SetPaint(var_8_1, var_8_0)

	local var_8_2 = arg_8_0.loadedShip

	var_4.Load(var_8_2, true, function(arg_9_0)
		if arg_8_0.loadedAnimator then
			arg_9_0:SetParent(arg_8_0.loadedAnimator)
		else
			arg_9_0:SetParent(arg_8_0.loadedFurniture)
		end

		arg_9_0:SetName(var_8_0)

		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.SetLocalScale

		Vector3 = var_4

		var_9_1(var_9_0, var_4(var_0_1, var_0_1, 1))

		local var_9_2 = arg_9_0
		local var_9_3 = arg_9_0.SetLocalPosition

		Vector3 = var_4

		var_9_3(var_9_2, var_4())
		arg_8_2()

		return
	end)

	return
end

function var_0_0.LoadFurniture(arg_10_0, arg_10_1, arg_10_2)
	pg = var_1_10003

	local var_10_0 = var_1_10003.furniture_data_template[arg_10_1].spine[1][1]
	local var_10_1

	if var_3[arg_10_1].spine[2] then
		var_10_1 = var_3[arg_10_1].spine[2][1]
	end

	local var_10_2

	if var_3[arg_10_1].animator and var_3[arg_10_1].animator[1] then
		var_10_2 = var_3[arg_10_1].animator[1][1]
	end

	seriesAsync = var_7

	var_7({
		function(arg_11_0)
			local var_11_0 = arg_10_0

			var_1.LoadRes(var_11_0, "sfurniture/" .. var_10_0, function(arg_12_0)
				setParent = var_3_10001

				var_3_10001(arg_12_0, arg_10_0.container)

				arg_10_0.loadedFurniture = arg_12_0

				local var_12_0 = arg_10_0

				var_1.AdjustTranform(var_12_0, arg_12_0)
				arg_11_0()

				return
			end)

			return
		end,
		function(arg_13_0)
			if not var_10_2 then
				arg_13_0()

				return
			end

			local var_13_0 = arg_10_0

			var_1.LoadRes(var_13_0, "sfurniture/" .. var_10_2, function(arg_14_0)
				setActive = var_3_10001

				var_3_10001(arg_14_0, false)

				setParent = var_3_10001

				var_3_10001(arg_14_0, arg_10_0.loadedFurniture)

				arg_10_0.loadedAnimator = arg_14_0

				arg_13_0()

				return
			end)

			return
		end,
		function(arg_15_0)
			if not var_10_1 then
				arg_15_0()

				return
			end

			local var_15_0 = arg_10_0

			var_1.LoadRes(var_15_0, "sfurniture/" .. var_10_1, function(arg_16_0)
				setParent = var_3_10001

				var_3_10001(arg_16_0, arg_10_0.container)

				arg_10_0.loadedFurnitureMask = arg_16_0

				local var_16_0 = arg_10_0

				var_1.AdjustTranform(var_16_0, arg_16_0)
				arg_15_0()

				return
			end)

			return
		end
	}, arg_10_2)

	return
end

function var_0_0.AdjustTranform(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.transform

	Vector3 = var_1_10003
	var_17_0.localScale = var_1_10003(arg_17_0.scale, arg_17_0.scale, 1)
	arg_17_1.transform.localPosition = arg_17_0.position

	return
end

function var_0_0.StartInteraction(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	pg = var_1_10004

	local var_18_0 = var_1_10004.furniture_data_template[arg_18_1].spine[3][2]

	pg = var_1_10005

	local var_18_1 = var_1_10005.furniture_data_template[arg_18_1].spine_action_replace
	local var_18_2 = {}
	local var_18_3 = {}

	ipairs = var_1_10008

	for iter_18_0, iter_18_1 in var_1_10008(var_18_0) do
		local var_18_4
		local var_18_5

		type = var_1_10015

		if var_1_10015(iter_18_1) == "string" then
			var_1_10015 = iter_18_1
			var_18_4 = iter_18_1
			var_18_5 = var_1_10015
		else
			type = var_1_10015

			if var_1_10015(iter_18_1) == "table" then
				var_1_10015 = iter_18_1[1]
				var_18_4 = iter_18_1[3] or iter_18_1[1]
				var_18_5 = var_1_10015
			end
		end

		local var_18_6

		var_1_10015, var_18_6 = arg_18_0:GetReplaceAction(var_18_1, arg_18_2, var_18_5, var_18_4)

		local var_18_7 = var_18_6
		local var_18_8 = var_1_10015

		table = var_1_10015

		var_1_10015.insert(var_18_2, var_18_8)

		table = var_1_10015

		var_1_10015.insert(var_18_3, var_18_7)
	end

	arg_18_0:StartActions(arg_18_1, var_18_2, var_18_3)
	arg_18_3()

	return
end

function var_0_0.GetReplaceAction(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if not arg_19_1 or arg_19_1 == "" or #arg_19_1 == 0 then
		return arg_19_3, arg_19_4
	end

	_ = var_1_10005

	if var_1_10005.detect(arg_19_1, function(arg_20_0)
		_ = var_2_10001

		local var_20_0

		if var_2_10001.any(arg_20_0[2], function(arg_21_0)
			return arg_21_0 == arg_19_2
		end) then
			var_20_0 = arg_19_4 == arg_20_0[1] and arg_20_0[5] == 1
		end

		return var_20_0
	end) then
		local var_19_0

		if not var_5[4] then
			var_19_0 = 0
		end

		if var_19_0 == 0 then
			return var_5[3], var_5[3]
		elseif var_19_0 == 1 then
			return arg_19_3, var_5[3]
		elseif var_19_0 == 2 then
			return var_5[3], arg_19_4
		end
	else
		return arg_19_3, arg_19_4
	end

	return
end

function var_0_0.StartActions(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = 1
	local var_22_1 = 0
	local var_22_2

	local function var_22_3()
		var_22_1 = var_22_1 + 1

		if var_22_1 == 3 then
			var_22_1, var_22_0 = 0, var_22_0 + 1

			var_22_2(var_22_0)
		end

		return
	end

	;(function(arg_24_0)
		if arg_24_0 > #arg_22_2 then
			if arg_22_0.loadedAnimator then
				setActive = var_1

				var_1(arg_22_0.loadedAnimator, false)
			end

			return
		end

		local var_24_0 = arg_22_2[arg_24_0]
		local var_24_1 = arg_22_3[arg_24_0]
		local var_24_2 = arg_22_0
		local var_24_3 = var_3.PlayAction
		local var_24_4 = arg_22_0.loadedFurniture.transform

		var_24_3(var_24_2, var_6.Find(var_24_4, "spine"), var_24_0, var_22_3)

		if arg_22_0.loadedFurnitureMask then
			local var_24_5 = arg_22_0
			local var_24_6 = var_3.PlayAction
			local var_24_7 = arg_22_0.loadedFurniture.transform

			var_24_6(var_24_5, var_6.Find(var_24_7, "spine"), var_24_0, var_22_3)
		else
			var_22_3()
		end

		local var_24_8 = arg_22_0

		var_3.PlayAction(var_24_8, arg_22_0.loadedShip, var_24_1, var_22_3)

		return
	end)(var_22_0)

	if arg_22_0.loadedAnimator then
		setActive = var_8

		var_8(arg_22_0.loadedAnimator, true)
	else
		arg_22_0:StartFollowBone(arg_22_1)
	end

	return
end

function var_0_0.StartFollowBone(arg_25_0, arg_25_1)
	pg = var_1_10002

	if not var_1_10002.furniture_data_template[arg_25_1].followBone then
		return
	end

	local var_25_0 = var_2[1]
	local var_25_1 = var_2[2]
	local var_25_2 = arg_25_0.loadedFurniture.transform
	local var_25_3 = arg_25_0.loadedShip
	local var_25_4 = var_6.SetLocalScale

	Vector3 = var_1_10009

	var_25_4(var_25_3, var_1_10009(var_25_1 * var_0_1, var_0_1, 1))

	SpineAnimUI = var_25_4

	local var_25_5 = var_25_4.AddFollower
	local var_25_6 = var_25_0
	local var_25_7 = var_25_2
	local var_25_8 = var_25_5(var_25_6, var_25_2.Find(var_25_7, "spine"), arg_25_0.loadedShip.transform)

	var_6.GetComponent(var_25_8, "Spine.Unity.BoneFollowerGraphic").followLocalScale = true

	local var_25_9 = arg_25_0.loadedShip
	local var_25_10 = var_8.SetLocalPosition

	Vector3 = var_25_7

	var_25_10(var_25_9, var_25_7(0, 0, 0))

	return
end

function var_0_0.PlayAction(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_1:SetActionCallBack(function(arg_27_0)
		if arg_27_0 == "finish" then
			local var_27_0 = arg_26_1

			var_1.SetActionCallBack(var_27_0, nil)
			arg_26_3()
		end

		return
	end)
	arg_26_1:SetAction(arg_26_2, 0)

	return
end

function var_0_0.UnloadSpines(arg_28_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_28_0.loadedShip) then
		local var_28_0 = arg_28_0.loadedShip

		var_1.Dispose(var_28_0)
	end

	IsNil = var_1

	if not var_1(arg_28_0.loadedAnimator) then
		Object = var_1

		var_1.Destroy(arg_28_0.loadedAnimator)
	end

	IsNil = var_1

	if not var_1(arg_28_0.loadedFurniture) then
		Object = var_1

		var_1.Destroy(arg_28_0.loadedFurniture)
	end

	IsNil = var_1

	if not var_1(arg_28_0.loadedFurnitureMask) then
		Object = var_1

		var_1.Destroy(arg_28_0.loadedFurnitureMask)
	end

	arg_28_0.shipSkinId = nil
	arg_28_0.furnitureId = nil

	return
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:UnloadSpines()

	return
end

function var_0_0.LoadRes(arg_30_0, arg_30_1, arg_30_2)
	ResourceMgr = var_1_10003

	local var_30_0 = var_1_10003.Inst
	local var_30_1 = var_3.getAssetAsync
	local var_30_2 = arg_30_1
	local var_30_3 = ""

	UnityEngine = var_1_10008

	var_30_1(var_30_0, var_30_2, var_30_3, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_31_0)
		local var_31_0 = arg_30_2

		Instantiate = var_2_10003

		var_31_0(var_2_10003(arg_31_0))

		return
	end), true, true)

	return
end

return var_0_0
