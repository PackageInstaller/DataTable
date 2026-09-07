local BattleGateWorldBoss = class("BattleGateWorldBoss")

ys.Battle.BattleGateWorldBoss = BattleGateWorldBoss
BattleGateWorldBoss.__name = "BattleGateWorldBoss"

function BattleGateWorldBoss:Entrance(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = self.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(BayProxy)
	local var_1_3 = pg.battle_cost_template[SYSTEM_WORLD_BOSS]
	local var_1_4 = true
	local var_1_5 = {}
	local var_1_7 = 0
	local var_1_8 = nowWorld()
	local var_1_9 = var_1_8:GetBossProxy():GetFleet(self.bossId)

	for iter_1_0, iter_1_1 in ipairs(var_1_9.ships) do
		var_1_5[#var_1_5 + 1] = iter_1_1
	end

	local var_1_10 = var_1_2:getSortShipsByFleet(var_1_9)
	local var_1_11 = var_1_1:getData()
	local var_1_12 = self.bossId
	local var_1_13 = self.hpRate
	local var_1_14 = var_1_8:GetBossProxy()
	local var_1_15 = var_1_14:GetBossById(self.bossId)
	local var_1_16 = var_1_15:GetStageID()

	if var_1_14:IsSelfBoss(var_1_15) and var_1_15:GetSelfFightCnt() > 0 then
		var_1_7 = var_1_15:GetOilConsume()
	end

	if true and var_1_7 > var_1_11.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_WORLD_BOSS, var_1_5, {
		self.bossId
	}, function(arg_2_0)
		if var_1_4 then
			var_1_11:consume({
				gold = 0,
				oil = var_1_7
			})
		end

		if var_1_3.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_10) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_2:updateShip(iter_2_1)
			end
		end

		if var_1_14:IsSelfBoss(var_1_15) then
			var_1_15:IncreaseFightCnt()
		else
			if WorldBossConst._IsCurrBoss(var_1_15) then
				var_1_14:reducePt()
			end

			var_1_14:LockCacheBoss(var_1_12)
		end

		var_1_1:updatePlayer(var_1_11)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			bossId = var_1_12,
			actId = var_1_0,
			stageId = var_1_16,
			system = SYSTEM_WORLD_BOSS,
			token = arg_2_0.key,
			bossLevel = var_1_15:GetLevel(),
			bossConfigId = var_1_15:GetConfigID(),
			hpRate = var_1_13
		})

		return
	end, function(arg_3_0)
		local function var_3_0()
			var_1_14:UnlockCacheBoss()
			var_1_14:RemoveCacheBoss(var_1_15.id)
			pg.m02:sendNotification(GAME.WORLD_BOSS_START_BATTLE_FIALED)

			return
		end

		if arg_3_0.result == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
			var_3_0()
		elseif arg_3_0.result == 3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
			var_3_0()
		elseif arg_3_0.result == 6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_max_challenge_cnt"))
			var_3_0()
		elseif arg_3_0.result == 20 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
			var_3_0()
		elseif arg_3_0.result == 13 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_maintenance"))
			var_3_0()
		else
			arg_1_1:RequestFailStandardProcess(arg_3_0)
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

function BattleGateWorldBoss:Exit(arg_5_1)
	if arg_5_1.CheaterVertify() then
		return
	end

	local var_5_1 = self.statistics._battleScore
	local var_5_3 = arg_5_1.GeneralPackage(self, (getProxy(BayProxy):getSortShipsByFleet((nowWorld():GetBossProxy():GetFleet(self.bossId)))))
	local var_5_4 = 0
	local var_5_5 = {}

	for iter_5_0, iter_5_1 in ipairs(self.statistics._enemyInfoList) do
		table.insert(var_5_5, {
			enemy_id = iter_5_1.id,
			damage_taken = iter_5_1.damage,
			total_hp = iter_5_1.totalHp
		})

		if var_5_4 < iter_5_1.damage then
			var_5_4 = iter_5_1.damage
		end
	end

	var_5_3.enemy_info = var_5_5

	arg_5_1:SendRequest(var_5_3, function(arg_6_0)
		local var_6_0, var_6_1 = arg_5_1:GeneralLoot(arg_6_0)

		arg_5_1.addShipsExp(arg_6_0.ship_exp_list, self.statistics, accumulate)

		local var_6_2 = nowWorld():GetBossProxy()
		local var_6_3 = var_6_2:GetBossById(self.bossId)

		var_6_2:ClearRank(var_6_3.id)
		var_6_2:UpdateHighestDamage(var_5_4)

		self.statistics.mvpShipID = arg_6_0.mvp

		arg_5_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_WORLD_BOSS,
			statistics = self.statistics,
			score = var_5_1,
			drops = var_6_0,
			commanderExps = {},
			result = arg_6_0.result,
			extraDrops = var_6_1,
			bossId = self.bossId,
			name = var_6_3:GetName()
		})
		var_6_2:UnlockCacheBoss()

		return
	end)

	return
end

function BattleGateWorldBoss:GetPreloadList()
	local var_7_0 = {}
	local var_7_2 = ys.Battle.BattleResourceManager.GetInstance()
	local var_7_3 = nowWorld():GetBossProxy()

	for iter_7_0, iter_7_1 in ipairs((getProxy(BayProxy):getSortShipsByFleet((var_7_3:GetFleet(self.bossId))))) do
		table.insert(var_7_0, iter_7_1)
	end

	local var_7_4, var_7_5 = var_7_2.GetPlayerShipResource(var_7_0, self.system)
	local var_7_6 = var_7_3:GetBossById(self.bossId)

	if var_7_6 and var_7_6:IsSelf() then
		local var_7_7, var_7_8, var_7_9 = var_7_3.GetSupportValue()

		if var_7_7 then
			for iter_7_2, iter_7_3 in ipairs((var_7_2.GetResFromBuffIDList({
				var_7_9
			}))) do
				table.insert(var_7_4, iter_7_3)
			end
		end
	end

	return var_7_4, var_7_5
end

return BattleGateWorldBoss
