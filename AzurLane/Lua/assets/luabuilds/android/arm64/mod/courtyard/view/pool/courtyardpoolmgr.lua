local var_0_0 = class("CourtYardPoolMgr")

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.pools = {}
	arg_1_0.root = arg_1_1
	arg_1_0.goList = {}

	parallelAsync(arg_1_0:GenPool(arg_1_1), arg_1_2)

	return
end

function var_0_0.GenPool(arg_2_0, arg_2_1)
	local var_2_0 = {
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

	for iter_2_0, iter_2_1 in ipairs({
		"CourtYardFurniture",
		"CourtYardGrid",
		"CourtYardShip",
		"CourtYardWallGrid"
	}) do
		table.insert({}, function(arg_3_0)
			ResourceMgr.Inst:getAssetAsync("ui/" .. iter_2_1, "", typeof(Object), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
				if arg_2_0.exited then
					return
				end

				arg_2_0.pools[iter_2_1] = CourtYardPool.New(arg_2_1, Object.Instantiate(arg_4_0), unpack(var_2_0[iter_2_0]))

				arg_3_0()

				return
			end), true, true)

			return
		end)
	end

	for iter_2_2, iter_2_3 in ipairs({
		"Heart"
	}) do
		table.insert({}, function(arg_5_0)
			ResourceMgr.Inst:getAssetAsync("Effect/" .. iter_2_3, "", typeof(Object), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_6_0)
				if arg_2_0.exited then
					return
				end

				arg_2_0.pools[iter_2_3] = CourtYardEffectPool.New(arg_2_1, Object.Instantiate(arg_6_0), 0, 3)

				arg_5_0()

				return
			end), true, true)

			return
		end)
	end

	return {}
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
	local var_17_0 = arg_17_0.pools or {}

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		iter_17_1:Dispose()
	end

	arg_17_0.pools = nil
	arg_17_0.goList = nil
	arg_17_0.exited = true

	return
end

return var_0_0
