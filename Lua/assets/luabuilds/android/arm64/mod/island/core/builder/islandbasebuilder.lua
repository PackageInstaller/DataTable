local var_0_0 = class("IslandBaseBuilder")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_1

	assert(arg_1_2)

	arg_1_0.unitListType = arg_1_2
	arg_1_0.loadingIdList = {}
	arg_1_0.insIdList = {}

	return
end

function var_0_0.Build(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:GetModule(arg_2_0.view, arg_2_1)

	assert(arg_2_0.unitListType)
	var_2_0:SetUnitType(arg_2_0.unitListType)

	local var_2_1

	seriesAsync({
		function(arg_3_0)
			arg_2_0:Load(arg_2_1, function(arg_4_0)
				var_2_1 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			arg_2_0:LoadTimeline(var_2_1, var_2_0, arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_2_0:LoadOtherPart(var_2_1, var_2_0, arg_2_1, arg_6_0)

			return
		end
	}, function()
		arg_2_0:AddTypeAndID(var_2_1, var_2_0)
		arg_2_0:AddComponents(var_2_1, arg_2_1)
		arg_2_0:SetTag(var_2_1)
		var_2_0:Init(var_2_1, arg_2_0)
		existCall(arg_2_2, var_2_0)

		return
	end)

	return var_2_0
end

function var_0_0.AddTypeAndID(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = GetOrAddComponent(arg_8_1, typeof(WorldObjectItem))

	var_8_0.type = arg_8_2:GetUnitType()
	var_8_0.id = arg_8_2.id

	return
end

function var_0_0.GetView(arg_9_0)
	return arg_9_0.view
end

function var_0_0.GetPoolMgr(arg_10_0)
	return arg_10_0.view:GetPoolMgr()
end

function var_0_0.AddLoadingID(arg_11_0, arg_11_1)
	table.insert(arg_11_0.loadingIdList, arg_11_1)

	return
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.insIdList) do
		FrameAsyncInstantiateManager.Instance:Cancel(iter_12_1)
	end

	arg_12_0.insIdList = nil

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.loadingIdList) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_12_3)
	end

	arg_12_0.loadingIdList = nil

	return
end

function var_0_0.Load(arg_13_0, arg_13_1, arg_13_2)
	assert(false, "overwrite !!!")

	return
end

function var_0_0.Recycle(arg_14_0, arg_14_1, arg_14_2)
	assert(false, "overwrite !!!")

	return
end

function var_0_0.GetModule(arg_15_0, arg_15_1, arg_15_2)
	assert(false, "overwrite !!!")

	return
end

function var_0_0.SetTag(arg_16_0, arg_16_1)
	return
end

function var_0_0.AddComponents(arg_17_0, arg_17_1)
	return
end

function var_0_0.LoadTimeline(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_4()

	return
end

function var_0_0.LoadOtherPart(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_4()

	return
end

function var_0_0.OnDispose(arg_20_0)
	return
end

return var_0_0
