class = var_0_10000

local var_0_0 = "AgoraMouldBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.Builder.IslandGenericBuilder"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.root = arg_1_1.furnitureRoot

	return
end

function var_0_1.Build(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:GetPoolMgr()
	local var_2_1 = var_3.GetAgoraRoot(var_2_0)

	setParent = var_2_0

	var_2_0(var_2_1, arg_2_0.root)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.GetModule(var_2_2, var_2_1, arg_2_1)

	assert = var_2_2

	var_2_2(arg_2_0.unitListType)

	local var_2_4 = var_2_3

	var_2_3.SetUnitType(var_2_4, arg_2_0.unitListType)

	local var_2_5

	seriesAsync = var_2_4

	var_2_4({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.Load(var_3_0, arg_2_1, function(arg_4_0)
				var_2_5 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0
			local var_5_1 = var_1.SetupBT
			local var_5_2 = var_2_1
			local var_5_3 = arg_2_1

			var_5_1(var_5_0, var_5_2, var_4.GetBt(var_5_3), arg_5_0)

			return
		end
	}, function()
		local var_6_0 = arg_2_0

		var_0.AddTypeAndID(var_6_0, var_2_1, var_2_3)

		local var_6_1 = arg_2_0

		var_0.AddComponents(var_6_1, var_2_1, arg_2_1)

		local var_6_2 = arg_2_0

		var_0.SetTag(var_6_2, var_2_1)

		local var_6_3 = var_2_3

		var_0.Init(var_6_3, var_2_5, arg_2_0)

		existCall = var_0

		var_0(arg_2_2, var_2_3)

		return
	end)

	return var_2_3
end

function var_0_1.GetModule(arg_7_0, arg_7_1, arg_7_2)
	AgoraFurnitrueMould = var_1_10003

	return var_1_10003.New(arg_7_0.view, arg_7_1, arg_7_2)
end

function var_0_1.Load(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:GetPoolMgr()

	var_3.GetAgoraObj(var_8_0, arg_8_1:GetResPath(), arg_8_2)

	return
end

function var_0_1.Recycle(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		local var_9_0 = arg_9_0:GetPoolMgr()

		var_3.ReturnAgoraObj(var_9_0, arg_9_1:GetResPath(), arg_9_2)
	end

	return
end

function var_0_1.RecycleRoot(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetPoolMgr()

	var_2.ReturnAgoraRoot(var_10_0, arg_10_1)

	return
end

return var_0_1
