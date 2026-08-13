class = var_0_10000

local var_0_0 = var_0_10000("IslandBaseBuilder")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_1
	assert = var_1_10003

	var_1_10003(arg_1_2)

	arg_1_0.unitListType = arg_1_2
	arg_1_0.loadingIdList = {}
	arg_1_0.insIdList = {}

	return
end

function var_0_0.Build(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetModule(var_2_0, arg_2_0.view, arg_2_1)

	assert = var_2_0

	var_2_0(arg_2_0.unitListType)

	local var_2_2 = var_2_1

	var_2_1.SetUnitType(var_2_2, arg_2_0.unitListType)

	local var_2_3

	seriesAsync = var_2_2

	var_2_2({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.Load(var_3_0, arg_2_1, function(arg_4_0)
				var_2_3 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0

			var_1.LoadTimeline(var_5_0, var_2_3, var_2_1, arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_2_0

			var_1.LoadOtherPart(var_6_0, var_2_3, var_2_1, arg_2_1, arg_6_0)

			return
		end
	}, function()
		local var_7_0 = arg_2_0

		var_0.AddTypeAndID(var_7_0, var_2_3, var_2_1)

		local var_7_1 = arg_2_0

		var_0.AddComponents(var_7_1, var_2_3, arg_2_1)

		local var_7_2 = arg_2_0

		var_0.SetTag(var_7_2, var_2_3)

		local var_7_3 = var_2_1

		var_0.Init(var_7_3, var_2_3, arg_2_0)

		existCall = var_0

		var_0(arg_2_2, var_2_1)

		return
	end)

	return var_2_1
end

function var_0_0.AddTypeAndID(arg_8_0, arg_8_1, arg_8_2)
	GetOrAddComponent = var_1_10003

	local var_8_0 = arg_8_1

	typeof = var_1_10005
	WorldObjectItem = var_1_10006

	local var_8_1 = var_1_10003(var_8_0, var_1_10005(var_1_10006))

	var_8_1.type = arg_8_2:GetUnitType()
	var_8_1.id = arg_8_2.id

	return
end

function var_0_0.GetView(arg_9_0)
	return arg_9_0.view
end

function var_0_0.GetPoolMgr(arg_10_0)
	local var_10_0 = arg_10_0.view

	return var_1.GetPoolMgr(var_10_0)
end

function var_0_0.AddLoadingID(arg_11_0, arg_11_1)
	table = var_1_10002

	var_1_10002.insert(arg_11_0.loadingIdList, arg_11_1)

	return
end

function var_0_0.Dispose(arg_12_0)
	ipairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.insIdList) do
		FrameAsyncInstantiateManager = var_1_10006

		local var_12_0 = var_1_10006.Instance

		var_1_10006.Cancel(var_12_0, iter_12_1)
	end

	arg_12_0.insIdList = nil
	ipairs = var_1

	for iter_12_2, iter_12_3 in var_1(arg_12_0.loadingIdList) do
		IslandAssetLoadDispatcher = var_1_10006

		local var_12_1 = var_1_10006.Instance

		var_1_10006.Cancel(var_12_1, iter_12_3)
	end

	arg_12_0.loadingIdList = nil

	return
end

function var_0_0.Load(arg_13_0, arg_13_1, arg_13_2)
	assert = var_1_10003

	var_1_10003(false, "overwrite !!!")

	return
end

function var_0_0.Recycle(arg_14_0, arg_14_1, arg_14_2)
	assert = var_1_10003

	var_1_10003(false, "overwrite !!!")

	return
end

function var_0_0.GetModule(arg_15_0, arg_15_1, arg_15_2)
	assert = var_1_10003

	var_1_10003(false, "overwrite !!!")

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
