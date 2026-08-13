class = var_0_10000

local var_0_0 = var_0_10000("OreEnemiesControl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.binder = arg_1_1
	arg_1_0.collisionMgr = arg_1_3
	arg_1_0._tf = arg_1_2
	findTF = var_1_10004
	arg_1_0.poolTF = var_1_10004(arg_1_0._tf, "pool")

	arg_1_0:Init()

	return
end

function var_0_0.AddListener(arg_2_0)
	local var_2_0 = arg_2_0.binder
	local var_2_1 = var_1.bind

	OreGameConfig = var_1_10003

	var_2_1(var_2_0, var_1_10003.EVENT_ENEMY_DESTROY, function(arg_3_0, arg_3_1)
		arg_2_0.enemyList[arg_3_1.roadID][arg_3_1.index] = nil

		local var_3_0 = arg_2_0
		local var_3_1 = var_2.ReturnEnemy

		findTF = var_4

		var_3_1(var_3_0, var_4(arg_2_0.roadTFs[arg_3_1.roadID], arg_3_1.index), arg_3_1.id)

		return
	end)

	return
end

function var_0_0.Init(arg_4_0)
	local var_4_0 = arg_4_0

	arg_4_0.AddListener(var_4_0)

	local var_4_1 = {}

	findTF = var_4_0
	var_4_1[1] = var_4_0(arg_4_0._tf, "road_1")
	findTF = var_2
	var_4_1[2] = var_2(arg_4_0._tf, "road_2")
	findTF = var_2
	var_4_1[3] = var_2(arg_4_0._tf, "road_3")
	arg_4_0.roadTFs = var_4_1
	findTF = var_4_1
	arg_4_0.tpls = var_4_1(arg_4_0._tf, "tpls")
	arg_4_0.enemyList = {}

	arg_4_0:Reset()

	return
end

function var_0_0.InitCreatList(arg_5_0)
	local function var_5_0(arg_6_0, arg_6_1)
		local var_6_0

		if not arg_5_0.createList[arg_6_0] then
			var_6_0 = {
				arg_6_1
			}
			arg_5_0.createList[arg_6_0] = var_6_0
		else
			table = var_6_0

			var_6_0.insert(arg_5_0.createList[arg_6_0], arg_6_1)
		end

		return
	end

	local function var_5_1(arg_7_0, arg_7_1, arg_7_2)
		OreGameConfig = var_2_10003

		local var_7_0 = var_2_10003.CREATE_CONFIG[arg_7_2].num

		Clone = var_2_10004
		OreGameConfig = var_2_10005

		local var_7_1 = var_2_10004(var_2_10005.CREATE_CONFIG[arg_7_2].enemy)

		assert = var_5

		var_5(var_7_0 <= #var_7_1, "create cfg illegal. ID: " .. arg_7_2)

		local var_7_2 = arg_7_0

		for iter_7_0 = 1, var_7_0 do
			math = var_2_10010

			local var_7_3 = var_7_1[var_2_10010.random(1, #var_7_1)]

			table = var_12

			var_12.remove(var_7_1, var_2_10010)

			local var_7_4 = {
				roadID = arg_7_1,
				enemyID = var_7_3
			}

			var_5_0(var_7_2, var_7_4)

			var_7_2 = var_7_2 + 1
		end

		return
	end

	OreGameConfig = var_1_10003

	local var_5_2 = var_1_10003.ROAD_DIRECTION

	math = var_1_10004

	local var_5_3 = var_1_10004.random

	OreGameConfig = var_1_10005
	arg_5_0.roadDir = var_5_2[var_5_3(#var_1_10005.ROAD_DIRECTION)]
	ipairs = var_3

	for iter_5_0, iter_5_1 in var_3(arg_5_0.roadTFs) do
		OreGameConfig = var_1_10008
		var_1_10008 = var_1_10008["CREATE_ENEMY_ROAD_" .. iter_5_0]
		OreGameConfig = var_9

		if var_9.ROAD_CONFIG_TYPE[iter_5_0] == 1 then
			ipairs = var_10

			for iter_5_2, iter_5_3 in var_10(var_1_10008) do
				var_5_1(iter_5_3.time, iter_5_0, iter_5_3.create)
			end
		elseif var_9 == 2 then
			ipairs = var_10

			for iter_5_4, iter_5_5 in var_10(var_1_10008) do
				local var_5_4 = iter_5_5.time

				while var_5_4 < iter_5_5.stop do
					var_5_1(var_5_4, iter_5_0, iter_5_5.create)

					math = var_16
					var_5_4 = var_5_4 + var_16.random(iter_5_5.step[1], iter_5_5.step[2])
				end
			end
		end
	end

	return
end

function var_0_0.CreateEnemy(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_1) do
		local var_8_0 = arg_8_0.indexTags[iter_8_1.roadID] + 1

		arg_8_0.indexTags[iter_8_1.roadID] = var_8_0

		local var_8_1 = arg_8_0:GetEnemy(iter_8_1.enemyID)
		local var_8_2 = var_8.SetParent

		tf = var_1_10011

		var_8_2(var_8_1, var_1_10011(arg_8_0.roadTFs[iter_8_1.roadID]), false)

		var_8.name = var_8_0
		SetActive = var_8_2

		var_8_2(var_8, true)

		if not arg_8_0.enemyList[iter_8_1.roadID] then
			arg_8_0.enemyList[iter_8_1.roadID] = {}
		end

		local var_8_3 = arg_8_0.enemyList[iter_8_1.roadID]

		OreEnemy = var_10
		var_8_3[var_8_0] = var_10.New(arg_8_0.binder, var_8, arg_8_0.collisionMgr, iter_8_1.enemyID, iter_8_1.roadID, arg_8_0.roadDir[iter_8_1.roadID])
	end

	return
end

function var_0_0.Reset(arg_9_0)
	arg_9_0.time = 0
	arg_9_0.createList = {}
	pairs = var_1

	for iter_9_0, iter_9_1 in var_1(arg_9_0.enemyList) do
		pairs = var_1_10006

		for iter_9_2, iter_9_3 in var_1_10006(iter_9_1) do
			iter_9_3:Dispose()
		end
	end

	arg_9_0.enemyList = {}
	arg_9_0.indexTags = {
		0,
		0,
		0
	}
	pairs = var_1

	for iter_9_4, iter_9_5 in var_1(arg_9_0.roadTFs) do
		removeAllChildren = var_1_10006

		var_1_10006(iter_9_5)
	end

	arg_9_0:InitCreatList()

	arg_9_0.pools = {}
	removeAllChildren = var_1

	var_1(arg_9_0.poolTF)

	return
end

function var_0_0.OnTimer(arg_10_0, arg_10_1)
	arg_10_0.time = arg_10_0.time + arg_10_1
	pairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_0.createList) do
		if iter_10_0 <= arg_10_0.time then
			arg_10_0:CreateEnemy(iter_10_1)

			var_1_10007 = arg_10_0.createList
			var_1_10007[iter_10_0] = nil
		end
	end

	pairs = var_2

	for iter_10_2, iter_10_3 in var_2(arg_10_0.enemyList) do
		pairs = var_1_10007

		for iter_10_4, iter_10_5 in var_1_10007(iter_10_3) do
			iter_10_5:OnTimer(arg_10_1)
		end
	end

	return
end

function var_0_0.GetEnemy(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_0.pools[arg_11_1] then
		var_11_0 = #arg_11_0.pools[arg_11_1]

		if 0 < var_11_0 then
			table = var_11_0

			return var_11_0.remove(arg_11_0.pools[arg_11_1])
		end
	end

	tf = var_11_0
	Instantiate = var_1_10003
	findTF = var_1_10004

	return (var_11_0(var_1_10003(var_1_10004(arg_11_0.tpls, arg_11_1))))
end

function var_0_0.ReturnEnemy(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0.pools[arg_12_2] then
		arg_12_0.pools[arg_12_2] = {}
	end

	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.SetParent

	tf = var_1_10005

	var_12_1(var_12_0, var_1_10005(arg_12_0.poolTF), false)

	setActive = var_12_1

	var_12_1(arg_12_1, false)

	table = var_12_1

	local var_12_2 = var_12_1.insert
	local var_12_3 = arg_12_0.pools[arg_12_2]

	tf = var_5

	var_12_2(var_12_3, var_5(arg_12_1))

	return
end

return var_0_0
