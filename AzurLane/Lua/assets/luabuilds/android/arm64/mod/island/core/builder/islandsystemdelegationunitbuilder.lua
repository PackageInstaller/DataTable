class = var_0_10000

local var_0_0 = "IslandSystemDelegationUnitBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSystemNpcBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandSystemDelegationUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.SetTag(arg_2_0, arg_2_1)
	IslandConst = var_1_10002
	arg_2_1.tag = var_1_10002.TAG_NPC

	return
end

function var_0_1.AddComponents(arg_3_0, arg_3_1, arg_3_2)
	GetOrAddComponent = var_1_10003

	local var_3_0 = arg_3_1

	typeof = var_1_10006
	CharacterController = var_1_10008

	local var_3_1 = var_1_10003(var_3_0, var_1_10006(var_1_10008))

	var_3_1.slopeLimit = 50
	var_3_1.stepOffset = 0.3
	var_3_1.stepOffset = 0.08
	var_3_1.minMoveDistance = 0
	var_3_1.height = 1.76
	var_3_1.stepOffset = 0.4
	Vector3 = var_4
	var_3_1.center = var_4(0, 0.96, 0)
	GetOrAddComponent = var_4

	local var_3_2 = arg_3_1

	typeof = var_7
	CharacterHandleController = var_1_10009

	var_4(var_3_2, var_7(var_1_10009))

	return
end

function var_0_1.LoadOtherPart(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = arg_4_3.type

	IslandConst = var_1_10006

	if var_4_0 == var_1_10006.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION then
		arg_4_4()

		return
	end

	local var_4_1 = arg_4_3.id
	local var_4_2 = arg_4_3.isChicken

	if var_4_1 == 1 or var_4_2 then
		arg_4_4()

		return
	end

	seriesAsync = var_1_10007

	var_1_10007({
		function(arg_5_0)
			local var_5_0 = arg_4_0.view
			local var_5_1 = var_1.GetIsland(var_5_0)

			IslandShipDressHelperNew = var_2_10002

			local var_5_2 = var_2_10002.New(var_5_1)
			local var_5_3 = arg_4_2

			var_3.SetShipDressHelper(var_5_3, var_5_2)
			var_5_2:PreLoadShipDressupItem(arg_4_1, var_4_1, arg_5_0)

			return
		end
	}, function()
		existCall = var_2_10000

		var_2_10000(arg_4_4)

		return
	end)

	return
end

return var_0_1
