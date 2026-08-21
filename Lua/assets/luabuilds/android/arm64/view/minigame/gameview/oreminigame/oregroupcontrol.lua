local var_0_0 = class("OreGroupControl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0.collisionMgr = arg_1_3
	arg_1_0.tpls = findTF(arg_1_0._tf, "tpl")
	arg_1_0.oresTF = findTF(arg_1_0._tf, "ores")
	arg_1_0.oreList = {}
	arg_1_0.poolTF = findTF(arg_1_0._tf, "pool")

	arg_1_0:AddListener()

	return
end

function var_0_0.AddListener(arg_2_0)
	arg_2_0.binder:bind(OreGameConfig.EVENT_ORE_NEW, function(arg_3_0, arg_3_1)
		arg_2_0:NewOre(arg_3_1.index, arg_3_1.pos)

		return
	end)
	arg_2_0.binder:bind(OreGameConfig.EVENT_ORE_DESTROY, function(arg_4_0, arg_4_1)
		arg_2_0.oreList[arg_4_1.index] = nil

		arg_2_0:ReturnOre(findTF(arg_2_0.oresTF, arg_4_1.index), arg_4_1.id)

		return
	end)

	return
end

function var_0_0.NewOre(arg_5_0, arg_5_1, arg_5_2)
	if not findTF(arg_5_0.oresTF, arg_5_1) then
		local var_5_0, var_5_1 = arg_5_0:GetNewOreConfig()
		local var_5_2 = arg_5_0:GetOre(var_5_0)

		var_5_2:SetParent(arg_5_0.oresTF, false)

		var_5_2.name = arg_5_1

		SetActive(var_5_2, true)

		arg_5_0.oreList[arg_5_1] = Ore.New(arg_5_0.binder, var_5_2, arg_5_0.collisionMgr, var_5_0, arg_5_2)

		arg_5_0.binder:emit(OreGameConfig.EVENT_ORE_EF_MINED, {
			index = arg_5_1
		})
	end

	return
end

function var_0_0.Reset(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.oreList) do
		iter_6_1:Dispose()
	end

	arg_6_0.oreList = {}

	removeAllChildren(arg_6_0.oresTF)

	arg_6_0.weightTable = OreGameConfig.ORE_REFRESH_WEIGHT[math.random(#OreGameConfig.ORE_REFRESH_WEIGHT)]
	arg_6_0.count = 0
	arg_6_0.pools = {}

	removeAllChildren(arg_6_0.poolTF)

	return
end

function var_0_0.GetNewOreConfig(arg_7_0)
	if arg_7_0.count == OreGameConfig.DIAMOND_CONFIH.count then
		local var_7_0 = OreGameConfig.DIAMOND_CONFIH.probability[1] > math.random() and 7 or 8

		arg_7_0.count = 0

		return var_7_0, OreGameConfig.ORE_CONFIG[var_7_0]
	end

	local var_7_1 = OreGameHelper.GetOreIDWithWeight(arg_7_0.weightTable)
	local var_7_2 = OreGameConfig.ORE_CONFIG[var_7_1]

	arg_7_0.count = OreGameConfig.ORE_CONFIG[var_7_1].type == 4 and 0 or arg_7_0.count + 1

	return var_7_1, var_7_2
end

function var_0_0.OnTimer(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.oreList) do
		iter_8_1:OnTimer(arg_8_1)
	end

	return
end

function var_0_0.GetOre(arg_9_0, arg_9_1)
	if arg_9_0.pools[arg_9_1] and #arg_9_0.pools[arg_9_1] > 0 then
		return table.remove(arg_9_0.pools[arg_9_1])
	end

	return (tf(Instantiate(findTF(arg_9_0.tpls, "tpl_" .. arg_9_1))))
end

function var_0_0.ReturnOre(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.pools[arg_10_2] = arg_10_0.pools[arg_10_2] or {}

	arg_10_1:SetParent(tf(arg_10_0.poolTF), false)
	setActive(arg_10_1, false)
	table.insert(arg_10_0.pools[arg_10_2], tf(arg_10_1))

	return
end

return var_0_0
