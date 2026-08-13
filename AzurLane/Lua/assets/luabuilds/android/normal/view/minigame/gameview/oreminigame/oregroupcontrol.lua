class = var_0_10000

local var_0_0 = var_0_10000("OreGroupControl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0.collisionMgr = arg_1_3
	findTF = var_1_10004
	arg_1_0.tpls = var_1_10004(arg_1_0._tf, "tpl")
	findTF = var_4
	arg_1_0.oresTF = var_4(arg_1_0._tf, "ores")
	arg_1_0.oreList = {}
	findTF = var_4
	arg_1_0.poolTF = var_4(arg_1_0._tf, "pool")

	arg_1_0:AddListener()

	return
end

function var_0_0.AddListener(arg_2_0)
	local var_2_0 = arg_2_0.binder
	local var_2_1 = var_1.bind

	OreGameConfig = var_1_10003

	var_2_1(var_2_0, var_1_10003.EVENT_ORE_NEW, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.NewOre(var_3_0, arg_3_1.index, arg_3_1.pos)

		return
	end)

	local var_2_2 = arg_2_0.binder
	local var_2_3 = var_1.bind

	OreGameConfig = var_3

	var_2_3(var_2_2, var_3.EVENT_ORE_DESTROY, function(arg_4_0, arg_4_1)
		arg_2_0.oreList[arg_4_1.index] = nil

		local var_4_0 = arg_2_0
		local var_4_1 = var_2.ReturnOre

		findTF = var_4

		var_4_1(var_4_0, var_4(arg_2_0.oresTF, arg_4_1.index), arg_4_1.id)

		return
	end)

	return
end

function var_0_0.NewOre(arg_5_0, arg_5_1, arg_5_2)
	findTF = var_1_10003

	if not var_1_10003(arg_5_0.oresTF, arg_5_1) then
		local var_5_0, var_5_1 = arg_5_0:GetNewOreConfig()
		local var_5_2 = arg_5_0:GetOre(var_5_0)

		var_5.SetParent(var_5_2, arg_5_0.oresTF, false)

		var_5.name = arg_5_1
		SetActive = var_6

		var_6(var_5, true)

		Ore = var_6

		local var_5_3 = var_6.New(arg_5_0.binder, var_5, arg_5_0.collisionMgr, var_5_0, arg_5_2)

		arg_5_0.oreList[arg_5_1] = var_5_3

		local var_5_4 = arg_5_0.binder
		local var_5_5 = var_7.emit

		OreGameConfig = var_9

		var_5_5(var_5_4, var_9.EVENT_ORE_EF_MINED, {
			index = arg_5_1
		})
	end

	return
end

function var_0_0.Reset(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.oreList) do
		iter_6_1:Dispose()
	end

	arg_6_0.oreList = {}
	removeAllChildren = var_1

	var_1(arg_6_0.oresTF)

	OreGameConfig = var_1

	local var_6_0 = var_1.ORE_REFRESH_WEIGHT

	math = var_2

	local var_6_1 = var_2.random

	OreGameConfig = var_3
	arg_6_0.weightTable = var_6_0[var_6_1(#var_3.ORE_REFRESH_WEIGHT)]
	arg_6_0.count = 0
	arg_6_0.pools = {}
	removeAllChildren = var_1

	var_1(arg_6_0.poolTF)

	return
end

function var_0_0.GetNewOreConfig(arg_7_0)
	local var_7_0 = arg_7_0.count

	OreGameConfig = var_1_10002

	if var_7_0 == var_1_10002.DIAMOND_CONFIH.count then
		OreGameConfig = var_7_0
		var_7_0 = var_7_0.DIAMOND_CONFIH.probability[1]
		math = var_2

		local var_7_1 = var_7_0 > var_2.random() and 7 or 8

		arg_7_0.count = 0

		local var_7_2 = var_7_1

		OreGameConfig = var_1_10004

		return var_7_2, var_1_10004.ORE_CONFIG[var_7_1]
	end

	OreGameHelper = var_7_0

	local var_7_3 = var_7_0.GetOreIDWithWeight(arg_7_0.weightTable)

	OreGameConfig = var_2
	arg_7_0.count = var_2.ORE_CONFIG[var_7_3].type == 4 and 0 or arg_7_0.count + 1

	return var_7_3, var_2
end

function var_0_0.OnTimer(arg_8_0, arg_8_1)
	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.oreList) do
		iter_8_1:OnTimer(arg_8_1)
	end

	return
end

function var_0_0.GetOre(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_0.pools[arg_9_1] then
		var_9_0 = #arg_9_0.pools[arg_9_1]

		if 0 < var_9_0 then
			table = var_9_0

			return var_9_0.remove(arg_9_0.pools[arg_9_1])
		end
	end

	tf = var_9_0
	Instantiate = var_1_10003
	findTF = var_1_10004

	return (var_9_0(var_1_10003(var_1_10004(arg_9_0.tpls, "tpl_" .. arg_9_1))))
end

function var_0_0.ReturnOre(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.pools[arg_10_2] then
		arg_10_0.pools[arg_10_2] = {}
	end

	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.SetParent

	tf = var_1_10005

	var_10_1(var_10_0, var_1_10005(arg_10_0.poolTF), false)

	setActive = var_10_1

	var_10_1(arg_10_1, false)

	table = var_10_1

	local var_10_2 = var_10_1.insert
	local var_10_3 = arg_10_0.pools[arg_10_2]

	tf = var_5

	var_10_2(var_10_3, var_5(arg_10_1))

	return
end

return var_0_0
