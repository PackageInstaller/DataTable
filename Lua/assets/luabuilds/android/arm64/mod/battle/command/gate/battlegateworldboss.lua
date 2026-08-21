local var_0_0 = class("BattleGateWorldBoss")

ys.Battle.BattleGateWorldBoss = var_0_0
var_0_0.__name = "BattleGateWorldBoss"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(BayProxy)
	local var_1_3 = pg.battle_cost_template[SYSTEM_WORLD_BOSS]
	local var_1_4 = true
	local var_1_6 = 0
	local var_1_7 = nowWorld()
	local var_1_8 = var_1_7:GetBossProxy():GetFleet(arg_1_0.bossId)

	for iter_1_0, iter_1_1 in ipairs(var_1_8.ships) do
		({})[#{} + 1] = iter_1_1
	end

	local var_1_9 = getProxy(BayProxy):getSortShipsByFleet(var_1_8)
	local var_1_10 = getProxy(PlayerProxy):getData()
	local var_1_11 = arg_1_0.bossId
	local var_1_12 = arg_1_0.hpRate
	local var_1_13 = var_1_7:GetBossProxy()
	local var_1_14 = var_1_13:GetBossById(arg_1_0.bossId)
	local var_1_15 = var_1_14:GetStageID()

	if var_1_13:IsSelfBoss(var_1_14) and var_1_14:GetSelfFightCnt() > 0 then
		var_1_6 = var_1_14:GetOilConsume()
	end

	if true and var_1_6 > getProxy(PlayerProxy):getData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()
	BeginStageCommand.SendRequest(SYSTEM_WORLD_BOSS, {}, {
		arg_1_0.bossId
	}, function(arg_2_0)
		if var_1_4 then
			var_1_10:consume({
				gold = 0,
				oil = var_1_6
			})
		end

		if var_1_3.enter_energy_cost > 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_9) do
				iter_2_1:cosumeEnergy(pg.gameset.battle_consume_energy.key_value)
				var_1_2:updateShip(iter_2_1)
			end
		end

		if var_1_13:IsSelfBoss(var_1_14) then
			var_1_14:IncreaseFightCnt()
		else
			if WorldBossConst._IsCurrBoss(var_1_14) then
				var_1_13:reducePt()
			end

			var_1_13:LockCacheBoss(var_1_11)
		end

		var_1_1:updatePlayer(var_1_10)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = {},
			bossId = var_1_11,
			actId = var_1_0,
			stageId = var_1_15,
			system = SYSTEM_WORLD_BOSS,
			token = arg_2_0.key,
			bossLevel = var_1_14:GetLevel(),
			bossConfigId = var_1_14:GetConfigID(),
			hpRate = var_1_12
		})

		return
	end, function(arg_3_0)
		if arg_3_0.result == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
			;(function()
				var_1_13:UnlockCacheBoss()
				var_1_13:RemoveCacheBoss(var_1_14.id)
				pg.m02:sendNotification(GAME.WORLD_BOSS_START_BATTLE_FIALED)

				return
			end)()
		elseif arg_3_0.result == 3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
			;(function()
				var_1_13:UnlockCacheBoss()
				var_1_13:RemoveCacheBoss(var_1_14.id)
				pg.m02:sendNotification(GAME.WORLD_BOSS_START_BATTLE_FIALED)

				return
			end)()
		elseif arg_3_0.result == 6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_max_challenge_cnt"))
			;(function()
				var_1_13:UnlockCacheBoss()
				var_1_13:RemoveCacheBoss(var_1_14.id)
				pg.m02:sendNotification(GAME.WORLD_BOSS_START_BATTLE_FIALED)

				return
			end)()
		elseif arg_3_0.result == 20 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
			;(function()
				var_1_13:UnlockCacheBoss()
				var_1_13:RemoveCacheBoss(var_1_14.id)
				pg.m02:sendNotification(GAME.WORLD_BOSS_START_BATTLE_FIALED)

				return
			end)()
		elseif arg_3_0.result == 13 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_maintenance"))
			;(function()
				var_1_13:UnlockCacheBoss()
				var_1_13:RemoveCacheBoss(var_1_14.id)
				pg.m02:sendNotification(GAME.WORLD_BOSS_START_BATTLE_FIALED)

				return
			end)()
		else
			arg_1_1:RequestFailStandardProcess(arg_3_0)
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

function var_0_0.Exit(arg_5_0, arg_5_1)
	if arg_5_1.CheaterVertify() then
		return
	end

	local var_5_1 = arg_5_0.statistics._battleScore
	local var_5_3 = arg_5_1.GeneralPackage(arg_5_0, (getProxy(BayProxy):getSortShipsByFleet((nowWorld():GetBossProxy():GetFleet(arg_5_0.bossId)))))
	local var_5_4 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.statistics._enemyInfoList) do
		table.insert({}, {
			enemy_id = iter_5_1.id,
			damage_taken = iter_5_1.damage,
			total_hp = iter_5_1.totalHp
		})

		if 0 < iter_5_1.damage then
			var_5_4 = iter_5_1.damage
		end
	end

	var_5_3.enemy_info = {}

	arg_5_1:SendRequest(var_5_3, function(arg_6_0)
		local var_6_0, var_6_1 = arg_5_1:GeneralLoot(arg_6_0)

		arg_5_1.addShipsExp(arg_6_0.ship_exp_list, arg_5_0.statistics, accumulate)

		local var_6_2 = nowWorld():GetBossProxy()
		local var_6_3 = var_6_2:GetBossById(arg_5_0.bossId)

		var_6_2:ClearRank(var_6_3.id)
		var_6_2:UpdateHighestDamage(var_5_4)

		arg_5_0.statistics.mvpShipID = arg_6_0.mvp

		arg_5_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_WORLD_BOSS,
			statistics = arg_5_0.statistics,
			score = var_5_1,
			drops = var_6_0,
			commanderExps = {},
			result = arg_6_0.result,
			extraDrops = var_6_1,
			bossId = arg_5_0.bossId,
			name = var_6_3:GetName()
		})
		var_6_2:UnlockCacheBoss()

		return
	end)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_1 = ys.Battle.BattleResourceManager.GetInstance()
	local var_7_2 = nowWorld():GetBossProxy()

	for iter_7_0, iter_7_1 in ipairs((getProxy(BayProxy):getSortShipsByFleet((var_7_2:GetFleet(arg_7_0.bossId))))) do
		table.insert({}, iter_7_1)
	end

	local var_7_3, var_7_4 = var_7_1.GetPlayerShipResource({}, arg_7_0.system)
	local var_7_5 = var_7_2:GetBossById(arg_7_0.bossId)

	if var_7_5 and var_7_5:IsSelf() then
		local var_7_6, var_7_7, var_7_8 = var_7_2.GetSupportValue()

		if var_7_6 then
			for iter_7_2, iter_7_3 in ipairs((var_7_1.GetResFromBuffIDList({
				var_7_8
			}))) do
				table.insert(var_7_3, iter_7_3)
			end
		end
	end

	return var_7_3, var_7_4
end

return var_0_0
