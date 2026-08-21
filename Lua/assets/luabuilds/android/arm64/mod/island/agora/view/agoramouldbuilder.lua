local var_0_0 = class("AgoraMouldBuilder", import("Mod.Island.Core.Builder.IslandGenericBuilder"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.root = arg_1_1.furnitureRoot

	return
end

function var_0_0.Build(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:GetPoolMgr():GetAgoraRoot()

	setParent(var_2_0, arg_2_0.root)

	local var_2_1 = arg_2_0:GetModule(var_2_0, arg_2_1)

	assert(arg_2_0.unitListType)
	var_2_1:SetUnitType(arg_2_0.unitListType)

	local var_2_2

	seriesAsync({
		function(arg_3_0)
			arg_2_0:Load(arg_2_1, function(arg_4_0)
				var_2_2 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			arg_2_0:SetupBT(var_2_0, arg_2_1:GetBt(), arg_5_0)

			return
		end
	}, function()
		arg_2_0:AddTypeAndID(var_2_0, var_2_1)
		arg_2_0:AddComponents(var_2_0, arg_2_1)
		arg_2_0:SetTag(var_2_0)
		var_2_1:Init(var_2_2, arg_2_0)
		existCall(arg_2_2, var_2_1)

		return
	end)

	return var_2_1
end

function var_0_0.GetModule(arg_7_0, arg_7_1, arg_7_2)
	return AgoraFurnitrueMould.New(arg_7_0.view, arg_7_1, arg_7_2)
end

function var_0_0.Load(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:GetPoolMgr():GetAgoraObj(arg_8_1:GetResPath(), arg_8_2)

	return
end

function var_0_0.Recycle(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		arg_9_0:GetPoolMgr():ReturnAgoraObj(arg_9_1:GetResPath(), arg_9_2)
	end

	return
end

function var_0_0.RecycleRoot(arg_10_0, arg_10_1)
	arg_10_0:GetPoolMgr():ReturnAgoraRoot(arg_10_1)

	return
end

return var_0_0
