local BattleGateWorldBossSimulate = class("BattleGateWorldBossSimulate")

ys.Battle.BattleGateWorldBossSimulate = BattleGateWorldBossSimulate
BattleGateWorldBossSimulate.__name = "BattleGateWorldBossSimulate"

function BattleGateWorldBossSimulate:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = self.actId
	local var_1_1 = {}
	local var_1_4 = nowWorld()
	local var_1_5 = var_1_4:GetBossProxy():GetFleet(self.bossId)

	for iter_1_0, iter_1_1 in ipairs(var_1_5.ships) do
		var_1_1[#var_1_1 + 1] = iter_1_1
	end

	local var_1_6 = getProxy(BayProxy):getSortShipsByFleet(var_1_5)
	local var_1_7 = getProxy(PlayerProxy):getData()
	local var_1_8 = self.bossId
	local var_1_9 = self.hpRate
	local var_1_10 = var_1_4:GetBossProxy()
	local var_1_11
	local var_1_12

	if WorldBossConst.GetCurrBossID() == self.bossId then
		var_1_12 = var_1_10.currentBossLV
		var_1_11 = pg.world_joint_boss_template[self.bossId].boss_level_id + var_1_10.currentBossLV - 1
	else
		var_1_12 = 15
		var_1_11 = pg.world_joint_boss_template[self.bossId].boss_level_id + 14
	end

	local var_1_13 = pg.world_boss_level[var_1_11].expedition_id

	arg_1_1.ShipVertify()
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		isSimulate = true,
		prefabFleet = {},
		bossId = var_1_8,
		actId = var_1_0,
		stageId = var_1_13,
		system = SYSTEM_WORLD_BOSS,
		bossLevel = var_1_12,
		bossConfigId = var_1_8,
		hpRate = var_1_9
	})

	return
end

function BattleGateWorldBossSimulate:Exit(arg_2_1)
	self.statistics.mvpShipID = -1

	arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		result = 0,
		system = SYSTEM_WORLD_BOSS,
		statistics = self.statistics,
		score = self.statistics._battleScore,
		drops = {},
		commanderExps = {},
		extraDrops = {},
		bossId = self.bossId,
		name = name
	})

	return
end

return BattleGateWorldBossSimulate
