class = var_0_10000

local var_0_0 = "IslandVisitorBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCharUnitBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandVisitorUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.SetTag(arg_2_0, arg_2_1)
	return
end

function var_0_1.SetupBT(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_3()

	return
end

function var_0_1.AddComponents(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.AddComponents(arg_4_0, arg_4_1, arg_4_2)

	GetOrAddComponent = var_3

	local var_4_0 = arg_4_1

	typeof = var_5
	CharacterController = var_6

	local var_4_1 = var_3(var_4_0, var_5(var_6))

	var_4_1.slopeLimit = 50
	var_4_1.stepOffset = 0.3
	var_4_1.stepOffset = 0.08
	var_4_1.minMoveDistance = 0
	var_4_1.height = 1.76
	var_4_1.stepOffset = 0.4
	Vector3 = var_4
	var_4_1.center = var_4(0, 0.96, 0)
	GetOrAddComponent = var_4

	local var_4_2 = arg_4_1

	typeof = var_6
	CharacterHandleController = var_7

	var_4(var_4_2, var_6(var_7))

	arg_4_1.name = "Visitor_" .. arg_4_2.id

	return
end

function var_0_1.LoadOtherPart(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_6_0)
			IslandShipDressHelperNew = var_2_10001

			local var_6_0 = var_2_10001.New()
			local var_6_1 = arg_5_2

			var_2.SetShipDressHelper(var_6_1, var_6_0)

			local var_6_2 = arg_5_3.id

			getProxy = var_6_1
			PlayerProxy = var_4

			local var_6_3 = var_6_1(var_4)
			local var_6_4 = var_3.getRawData(var_6_3).id == arg_5_3.islandId

			var_6_0:PreLoadVisterDressupItem(arg_5_1, var_6_2, var_6_4, arg_6_0)

			return
		end
	}, function()
		existCall = var_2_10000

		var_2_10000(arg_5_4)

		return
	end)

	return
end

function var_0_1.Load(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:GetBehaviourTree()
	local var_8_1 = arg_8_1.id

	getProxy = var_1_10005
	PlayerProxy = var_1_10006

	local var_8_2 = var_1_10005(var_1_10006)
	local var_8_3 = var_5.getRawData(var_8_2).id == arg_8_1.islandId
	local var_8_4 = arg_8_0:GetPoolMgr()

	var_6.GetCommanderModel(var_8_4, {
		model = arg_8_1:GetAssetPath(),
		animator = arg_8_1:GetAnimator()
	}, arg_8_2, var_8_1, var_8_3, var_8_0)

	return
end

function var_0_1.Recycle(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:GetBehaviourTree()
	local var_9_1 = arg_9_0:GetPoolMgr()

	var_4.ReturnCommanderModel(var_9_1, arg_9_2, var_9_0)

	return
end

return var_0_1
