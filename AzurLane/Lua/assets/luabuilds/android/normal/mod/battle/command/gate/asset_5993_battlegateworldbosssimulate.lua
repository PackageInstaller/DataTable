class = var_0_10000

local var_0_0 = var_0_10000("BattleGateWorldBossSimulate")

ys = var_1
var_1.Battle.BattleGateWorldBossSimulate = var_0_0
var_0_0.__name = "BattleGateWorldBossSimulate"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	BeginStageCommand = var_1_10002

	if var_1_10002.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.actId

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_1_1 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_1_2 = var_1_10004(var_1_10005)
	local var_1_3 = {}
	local var_1_4 = 0
	local var_1_5 = 0

	nowWorld = var_1_10008

	local var_1_6 = var_1_10008()
	local var_1_7 = var_8.GetBossProxy(var_1_6)
	local var_1_8 = var_9.GetFleet(var_1_7, arg_1_0.bossId).ships

	ipairs = var_12

	for iter_1_0, iter_1_1 in var_12(var_1_8) do
		var_1_3[#var_1_3 + 1] = iter_1_1
	end

	local var_1_9 = var_1_2:getSortShipsByFleet(var_10)
	local var_1_10 = var_1_1:getData()
	local var_1_11 = arg_1_0.bossId
	local var_1_12 = arg_1_0.hpRate
	local var_1_13 = var_8:GetBossProxy()
	local var_1_14
	local var_1_15

	pg = var_1_10019

	local var_1_16 = var_1_10019.world_joint_boss_template[var_1_11]

	WorldBossConst = var_1_10020

	if var_1_10020.GetCurrBossID() == var_1_11 then
		var_1_15 = var_1_13.currentBossLV
		var_1_14 = var_1_16.boss_level_id + var_1_13.currentBossLV - 1
	else
		var_1_15 = 15
		var_1_14 = var_1_16.boss_level_id + 14
	end

	pg = var_20

	local var_1_17 = var_20.world_boss_level[var_1_14].expedition_id

	arg_1_1.ShipVertify()

	local var_1_18 = {
		isSimulate = true,
		prefabFleet = {},
		bossId = var_1_11,
		actId = var_1_0,
		stageId = var_1_17
	}

	SYSTEM_WORLD_BOSS = var_22
	var_1_18.system = var_22
	var_1_18.bossLevel = var_1_15
	var_1_18.bossConfigId = var_1_11
	var_1_18.hpRate = var_1_12

	local var_1_19 = arg_1_1
	local var_1_20 = arg_1_1.sendNotification

	GAME = var_1_10024

	var_1_20(var_1_19, var_1_10024.BEGIN_STAGE_DONE, var_1_18)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.statistics._battleScore

	arg_2_0.statistics.mvpShipID = -1

	local var_2_1 = {
		result = 0
	}

	SYSTEM_WORLD_BOSS = var_4
	var_2_1.system = var_4
	var_2_1.statistics = arg_2_0.statistics
	var_2_1.score = var_2_0
	var_2_1.drops = {}
	var_2_1.commanderExps = {}
	var_2_1.extraDrops = {}
	var_2_1.bossId = arg_2_0.bossId
	name = var_4
	var_2_1.name = var_4

	local var_2_2 = arg_2_1
	local var_2_3 = arg_2_1.sendNotification

	GAME = var_1_10006

	var_2_3(var_2_2, var_1_10006.FINISH_STAGE_DONE, var_2_1)

	return
end

return var_0_0
