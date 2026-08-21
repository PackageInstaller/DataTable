local var_0_0 = class("BattleGateWorldBossSimulate")

ys.Battle.BattleGateWorldBossSimulate = var_0_0
var_0_0.__name = "BattleGateWorldBossSimulate"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.actId
	local var_1_3 = nowWorld()
	local var_1_4 = var_1_3:GetBossProxy():GetFleet(arg_1_0.bossId)

	for iter_1_0, iter_1_1 in ipairs(var_1_4.ships) do
		({})[#{} + 1] = iter_1_1
	end

	local var_1_5 = getProxy(BayProxy):getSortShipsByFleet(var_1_4)
	local var_1_6 = getProxy(PlayerProxy):getData()
	local var_1_7 = arg_1_0.bossId
	local var_1_8 = arg_1_0.hpRate
	local var_1_9 = var_1_3:GetBossProxy()
	local var_1_10
	local var_1_11

	if WorldBossConst.GetCurrBossID() == arg_1_0.bossId then
		var_1_11 = var_1_9.currentBossLV
		var_1_10 = pg.world_joint_boss_template[arg_1_0.bossId].boss_level_id + var_1_9.currentBossLV - 1
	else
		var_1_11 = 15
		var_1_10 = pg.world_joint_boss_template[arg_1_0.bossId].boss_level_id + 14
	end

	local var_1_12 = pg.world_boss_level[var_1_10].expedition_id

	arg_1_1.ShipVertify()
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		isSimulate = true,
		prefabFleet = {},
		bossId = var_1_7,
		actId = var_1_0,
		stageId = var_1_12,
		system = SYSTEM_WORLD_BOSS,
		bossLevel = var_1_11,
		bossConfigId = var_1_7,
		hpRate = var_1_8
	})

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	arg_2_0.statistics.mvpShipID = -1

	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		result = 0,
		system = SYSTEM_WORLD_BOSS,
		statistics = arg_2_0.statistics,
		score = arg_2_0.statistics._battleScore,
		drops = {},
		commanderExps = {},
		extraDrops = {},
		bossId = arg_2_0.bossId,
		name = name
	})

	return
end

return var_0_0
