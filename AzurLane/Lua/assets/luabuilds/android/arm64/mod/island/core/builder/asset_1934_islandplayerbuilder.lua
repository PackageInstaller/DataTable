class = var_0_10000

local var_0_0 = "IslandPlayerBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandGenericBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandPlayerUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.SetTag(arg_2_0, arg_2_1)
	IslandConst = var_1_10002
	arg_2_1.tag = var_1_10002.TAG_PLAYER

	return
end

function var_0_1.AddComponents(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.GetComponent

	typeof = var_1_10006
	WorldObjectItem = var_1_10008
	var_3_1(var_3_0, var_1_10006(var_1_10008)).isPlayer = true
	GetOrAddComponent = var_4

	local var_3_2 = arg_3_1

	typeof = var_1_10007
	CharacterController = var_1_10009

	local var_3_3 = var_4(var_3_2, var_1_10007(var_1_10009))

	var_3_3.slopeLimit = 50
	var_3_3.stepOffset = 0.3
	var_3_3.stepOffset = 0.08
	var_3_3.minMoveDistance = 0
	var_3_3.height = 1.76
	var_3_3.stepOffset = 0.4
	Vector3 = var_5
	var_3_3.center = var_5(0, 0.96, 0)
	GetOrAddComponent = var_5

	local var_3_4 = arg_3_1

	typeof = var_8
	CharacterHandleController = var_1_10010

	var_5(var_3_4, var_8(var_1_10010))

	GetOrAddComponent = var_5

	local var_3_5 = arg_3_1

	typeof = var_8
	CharacterFootprintMgr = var_1_10010

	var_5(var_3_5, var_8(var_1_10010))

	return
end

function var_0_1.LoadAsset(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.modelId
	local var_4_1 = arg_4_0:GetPoolMgr()

	var_4.GetCommanderModel(var_4_1, {
		model = arg_4_1:GetAssetPath(),
		animator = arg_4_1:GetAnimator()
	}, arg_4_2)

	return
end

function var_0_1.LoadOtherPart(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_6_0)
			IslandAssetLoadDispatcher = var_2_10001

			local var_6_0 = var_2_10001.Instance
			local var_6_1 = var_1.Enqueue
			local var_6_2 = "island/jumpcurve/jumpcurve"
			local var_6_3 = ""

			typeof = var_2_10006
			JumpCurve = var_2_10008

			local var_6_4 = var_2_10006(var_2_10008)

			UnityEngine = var_2_10007

			local var_6_5 = var_6_1(var_6_0, var_6_2, var_6_3, var_6_4, var_2_10007.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
				local var_7_0 = arg_5_2

				var_1.InitJump(var_7_0, arg_7_0.curve)
				arg_6_0()

				return
			end), true, true)
			local var_6_6 = arg_5_0

			var_2.AddLoadingID(var_6_6, var_6_5)

			return
		end,
		function(arg_8_0)
			IslandShipDressHelperNew = var_2_10001

			local var_8_0 = var_2_10001.New()
			local var_8_1 = arg_5_2

			var_2.SetShipDressHelper(var_8_1, var_8_0)
			var_8_0:PreLoadShipDressupItem(arg_5_1, 0, arg_8_0)

			return
		end
	}, function()
		existCall = var_2_10000

		var_2_10000(arg_5_4)

		return
	end)

	return
end

function var_0_1.Recycle(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:GetPoolMgr()

	var_3.ReturnCommanderModel(var_10_0, arg_10_2)

	return
end

return var_0_1
