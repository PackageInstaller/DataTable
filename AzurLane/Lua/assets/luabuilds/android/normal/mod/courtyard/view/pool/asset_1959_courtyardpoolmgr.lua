class = var_0_10000

local var_0_0 = var_0_10000("CourtYardPoolMgr")

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.pools = {}
	arg_1_0.root = arg_1_1
	arg_1_0.goList = {}

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.GenPool(var_1_0, arg_1_1)

	parallelAsync = var_1_0

	var_1_0(var_1_1, arg_1_2)

	return
end

function var_0_0.GenPool(arg_2_0, arg_2_1)
	local var_2_0 = {
		"CourtYardFurniture",
		"CourtYardGrid",
		"CourtYardShip",
		"CourtYardWallGrid"
	}
	local var_2_1 = {
		{
			10,
			15
		},
		{
			4,
			8
		},
		{
			1,
			3
		},
		{
			2,
			8
		}
	}
	local var_2_2 = {
		"Heart"
	}
	local var_2_3 = {}

	ipairs = var_1_10006

	for iter_2_0, iter_2_1 in var_1_10006(var_2_0) do
		table = var_1_10011

		var_1_10011.insert(var_2_3, function(arg_3_0)
			ResourceMgr = var_2_10001

			local var_3_0 = var_2_10001.Inst
			local var_3_1 = var_1.getAssetAsync
			local var_3_2 = "ui/" .. iter_2_1
			local var_3_3 = ""

			typeof = var_2_10005
			Object = var_2_10006

			local var_3_4 = var_2_10005(var_2_10006)

			UnityEngine = var_2_10006

			var_3_1(var_3_0, var_3_2, var_3_3, var_3_4, var_2_10006.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
				if arg_2_0.exited then
					return
				end

				local var_4_0 = var_2_1[iter_2_0]

				Object = var_2

				local var_4_1 = var_2.Instantiate(arg_4_0)
				local var_4_2 = arg_2_0.pools
				local var_4_3 = iter_2_1

				CourtYardPool = var_3_10005

				local var_4_4 = var_3_10005.New
				local var_4_5 = arg_2_1
				local var_4_6 = var_4_1

				unpack = var_3_10008
				var_4_2[var_4_3] = var_4_4(var_4_5, var_4_6, var_3_10008(var_4_0))

				arg_3_0()

				return
			end), true, true)

			return
		end)
	end

	ipairs = var_6

	for iter_2_2, iter_2_3 in var_6(var_2_2) do
		table = var_1_10011

		var_1_10011.insert(var_2_3, function(arg_5_0)
			ResourceMgr = var_2_10001

			local var_5_0 = var_2_10001.Inst
			local var_5_1 = var_1.getAssetAsync
			local var_5_2 = "Effect/" .. iter_2_3
			local var_5_3 = ""

			typeof = var_2_10005
			Object = var_2_10006

			local var_5_4 = var_2_10005(var_2_10006)

			UnityEngine = var_2_10006

			var_5_1(var_5_0, var_5_2, var_5_3, var_5_4, var_2_10006.Events.UnityAction_UnityEngine_Object(function(arg_6_0)
				if arg_2_0.exited then
					return
				end

				Object = var_1

				local var_6_0 = var_1.Instantiate(arg_6_0)
				local var_6_1 = arg_2_0.pools
				local var_6_2 = iter_2_3

				CourtYardEffectPool = var_3_10004
				var_6_1[var_6_2] = var_3_10004.New(arg_2_1, var_6_0, 0, 3)

				arg_5_0()

				return
			end), true, true)

			return
		end)
	end

	return var_2_3
end

function var_0_0.LoadAsset(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.GetFurniturePool(arg_8_0)
	return arg_8_0.pools.CourtYardFurniture
end

function var_0_0.GetShipPool(arg_9_0)
	return arg_9_0.pools.CourtYardShip
end

function var_0_0.GetGridPool(arg_10_0)
	return arg_10_0.pools.CourtYardGrid
end

function var_0_0.GetWallGridPool(arg_11_0)
	return arg_11_0.pools.CourtYardWallGrid
end

function var_0_0.GetHeartPool(arg_12_0)
	return arg_12_0.pools.Heart
end

function var_0_0.GetAiXinPool(arg_13_0)
	return arg_13_0.pools.chengbao_aixin
end

function var_0_0.GetXinXinPool(arg_14_0)
	return arg_14_0.pools.chengbao_xinxin
end

function var_0_0.GetYinFuPool(arg_15_0)
	return arg_15_0.pools.chengbao_yinfu
end

function var_0_0.GetZzzPool(arg_16_0)
	return arg_16_0.pools.chengbao_ZZZ
end

function var_0_0.Dispose(arg_17_0)
	pairs = var_1_10001

	local var_17_0

	if not arg_17_0.pools then
		var_17_0 = {}
	end

	for iter_17_0, iter_17_1 in var_1_10001(var_17_0) do
		iter_17_1:Dispose()
	end

	arg_17_0.pools = nil
	arg_17_0.goList = nil
	arg_17_0.exited = true

	return
end

return var_0_0
