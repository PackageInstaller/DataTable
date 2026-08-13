class = var_0_10000

local var_0_0 = var_0_10000("BattleGateWorldBoss")

ys = var_0_10001
var_0_10001.Battle.BattleGateWorldBoss = var_0_0
var_0_0.__name = "BattleGateWorldBoss"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	BeginStageCommand = var_1_10002

	if var_1_10002.DockOverload() then
		return
	end

	local var_1_0 = arg_1_0.actId

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_1_2 = var_1_10004(var_1_10006)

	pg = var_1_10005

	local var_1_3 = var_1_10005.battle_cost_template

	SYSTEM_WORLD_BOSS = var_1_10006

	local var_1_4 = var_1_3[var_1_10006]
	local var_1_5 = true
	local var_1_6 = {}
	local var_1_7 = 0
	local var_1_8 = 0

	nowWorld = var_1_10010

	local var_1_9 = var_1_10010()
	local var_1_10 = var_10.GetBossProxy(var_1_9)
	local var_1_11 = var_11.GetFleet(var_1_10, arg_1_0.bossId).ships

	ipairs = var_1_10

	for iter_1_0, iter_1_1 in var_1_10(var_1_11) do
		var_1_6[#var_1_6 + 1] = iter_1_1
	end

	local var_1_12 = var_1_2:getSortShipsByFleet(var_12)
	local var_1_13 = var_1_1:getData()
	local var_1_14 = arg_1_0.bossId
	local var_1_15 = arg_1_0.hpRate
	local var_1_16 = var_10:GetBossProxy()
	local var_1_17 = var_18.GetBossById(var_1_16, var_1_14)
	local var_1_18 = var_19.GetStageID(var_1_17)
	local var_1_19 = var_18

	if var_18.IsSelfBoss(var_1_19, var_19) then
		var_1_19 = var_19

		if var_19.GetSelfFightCnt(var_1_19) > 0 then
			var_1_19 = var_19
			var_1_8 = var_19.GetOilConsume(var_1_19)
		end
	end

	if var_1_5 and var_1_13.oil < var_1_8 then
		pg = var_21
		var_1_19 = var_21.TipsMgr.GetInstance()

		local var_1_20 = var_21.ShowTips

		i18n = var_24

		var_1_20(var_1_19, var_24("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local function var_1_21(arg_2_0)
		if var_1_5 then
			local var_2_0 = var_1_13

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_8
			})
		end

		local var_2_1 = var_1_4.enter_energy_cost

		if 0 < var_2_1 then
			pg = var_2_1

			local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_12) do
				iter_2_1:cosumeEnergy(var_2_2)

				local var_2_3 = var_1_2

				var_7.updateShip(var_2_3, iter_2_1)
			end
		end

		local var_2_4 = var_0

		if var_1.IsSelfBoss(var_2_4, var_0) then
			local var_2_5 = var_0

			var_1.IncreaseFightCnt(var_2_5)
		else
			WorldBossConst = var_1

			if var_1._IsCurrBoss(var_0) then
				local var_2_6 = var_0

				var_1.reducePt(var_2_6)
			end

			local var_2_7 = var_0

			var_1.LockCacheBoss(var_2_7, var_1_14)
		end

		local var_2_8 = var_1_1

		var_1.updatePlayer(var_2_8, var_1_13)

		local var_2_9 = {
			prefabFleet = {},
			bossId = var_1_14,
			actId = var_1_0,
			stageId = var_1_18
		}

		SYSTEM_WORLD_BOSS = var_2
		var_2_9.system = var_2
		var_2_9.token = arg_2_0.key

		local var_2_10 = var_0

		var_2_9.bossLevel = var_2.GetLevel(var_2_10)

		local var_2_11 = var_0

		var_2_9.bossConfigId = var_2.GetConfigID(var_2_11)
		var_2_9.hpRate = var_1_15

		local var_2_12 = arg_1_1
		local var_2_13 = var_2.sendNotification

		GAME = iter_2_0

		var_2_13(var_2_12, iter_2_0.BEGIN_STAGE_DONE, var_2_9)

		return
	end

	local function var_1_22(arg_3_0)
		local function var_3_0()
			local var_4_0 = var_0

			var_0.UnlockCacheBoss(var_4_0)

			local var_4_1 = var_0

			var_0.RemoveCacheBoss(var_4_1, var_0.id)

			pg = var_0

			local var_4_2 = var_0.m02
			local var_4_3 = var_0.sendNotification

			GAME = var_3

			var_4_3(var_4_2, var_3.WORLD_BOSS_START_BATTLE_FIALED)

			return
		end

		if arg_3_0.result == 1 then
			pg = var_2

			local var_3_1 = var_2.TipsMgr.GetInstance()
			local var_3_2 = var_2.ShowTips

			i18n = var_2_10005

			var_3_2(var_3_1, var_2_10005("world_boss_none"))
			var_3_0()
		elseif arg_3_0.result == 3 then
			pg = var_2

			local var_3_3 = var_2.TipsMgr.GetInstance()
			local var_3_4 = var_2.ShowTips

			i18n = var_2_10005

			var_3_4(var_3_3, var_2_10005("world_boss_none"))
			var_3_0()
		elseif arg_3_0.result == 6 then
			pg = var_2

			local var_3_5 = var_2.TipsMgr.GetInstance()
			local var_3_6 = var_2.ShowTips

			i18n = var_2_10005

			var_3_6(var_3_5, var_2_10005("world_max_challenge_cnt"))
			var_3_0()
		elseif arg_3_0.result == 20 then
			pg = var_2

			local var_3_7 = var_2.TipsMgr.GetInstance()
			local var_3_8 = var_2.ShowTips

			i18n = var_2_10005

			var_3_8(var_3_7, var_2_10005("world_boss_none"))
			var_3_0()
		elseif arg_3_0.result == 13 then
			pg = var_2

			local var_3_9 = var_2.TipsMgr.GetInstance()
			local var_3_10 = var_2.ShowTips

			i18n = var_2_10005

			var_3_10(var_3_9, var_2_10005("world_boss_maintenance"))
			var_3_0()
		else
			local var_3_11 = arg_1_1

			var_2.RequestFailStandardProcess(var_3_11, arg_3_0)

			pg = var_2

			local var_3_12 = var_2.TipsMgr.GetInstance()
			local var_3_13 = var_2.ShowTips

			ERROR_MESSAGE = var_5

			var_3_13(var_3_12, var_5[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end

	BeginStageCommand = var_1_19

	local var_1_23 = var_1_19.SendRequest

	SYSTEM_WORLD_BOSS = var_1_10025

	var_1_23(var_1_10025, var_1_6, {
		var_1_14
	}, var_1_21, var_1_22)

	return
end

function var_0_0.Exit(arg_5_0, arg_5_1)
	if arg_5_1.CheaterVertify() then
		return
	end

	pg = var_2

	local var_5_0 = var_2.battle_cost_template

	SYSTEM_WORLD_BOSS = var_1_10003

	local var_5_1 = var_5_0[var_1_10003]
	local var_5_2 = arg_5_0.statistics._battleScore
	local var_5_3 = {}

	nowWorld = var_1_10005

	local var_5_4 = var_1_10005()
	local var_5_5 = var_5.GetBossProxy(var_5_4)
	local var_5_6 = var_6.GetFleet(var_5_5, arg_5_0.bossId)

	getProxy = var_5_4
	BayProxy = var_10

	local var_5_7 = var_5_4(var_10)
	local var_5_8 = var_8.getSortShipsByFleet(var_5_7, var_5_6)
	local var_5_9 = arg_5_1.GeneralPackage(arg_5_0, var_5_8)
	local var_5_10 = 0
	local var_5_11 = {}

	ipairs = var_11

	for iter_5_0, iter_5_1 in var_11(arg_5_0.statistics._enemyInfoList) do
		table = var_1_10016

		var_1_10016.insert(var_5_11, {
			enemy_id = iter_5_1.id,
			damage_taken = iter_5_1.damage,
			total_hp = iter_5_1.totalHp
		})

		if var_5_10 < iter_5_1.damage then
			var_5_10 = iter_5_1.damage
		end
	end

	var_5_9.enemy_info = var_5_11

	local function var_5_12(arg_6_0)
		local var_6_0 = arg_5_1
		local var_6_1, var_6_2 = var_1.GeneralLoot(var_6_0, arg_6_0)
		local var_6_3 = arg_5_1.addShipsExp
		local var_6_4 = arg_6_0.ship_exp_list
		local var_6_5 = arg_5_0.statistics

		accumulate = var_2_10007

		var_6_3(var_6_4, var_6_5, var_2_10007)

		nowWorld = var_6_3

		local var_6_6 = var_6_3()
		local var_6_7 = var_3.GetBossProxy(var_6_6)
		local var_6_8 = var_4.GetBossById(var_6_7, arg_5_0.bossId)
		local var_6_9 = var_5.GetName(var_6_8)

		var_4:ClearRank(var_5.id)
		var_4:UpdateHighestDamage(var_5_10)

		arg_5_0.statistics.mvpShipID = arg_6_0.mvp

		local var_6_10 = {}

		SYSTEM_WORLD_BOSS = var_8
		var_6_10.system = var_8
		var_6_10.statistics = arg_5_0.statistics
		var_6_10.score = var_5_2
		var_6_10.drops = var_6_1
		var_6_10.commanderExps = {}
		var_6_10.result = arg_6_0.result
		var_6_10.extraDrops = var_6_2
		var_6_10.bossId = arg_5_0.bossId
		var_6_10.name = var_6_9

		local var_6_11 = arg_5_1
		local var_6_12 = var_8.sendNotification

		GAME = var_2_10011

		var_6_12(var_6_11, var_2_10011.FINISH_STAGE_DONE, var_6_10)
		var_4:UnlockCacheBoss()

		return
	end

	arg_5_1:SendRequest(var_5_9, var_5_12)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_0 = {}
	local var_7_1

	ys = var_1_10003

	local var_7_2 = var_1_10003.Battle.BattleResourceManager.GetInstance()

	nowWorld = var_1_10004

	local var_7_3 = var_1_10004()
	local var_7_4 = var_4.GetBossProxy(var_7_3)
	local var_7_5 = var_5.GetFleet(var_7_4, arg_7_0.bossId)

	getProxy = var_7_3
	BayProxy = var_9

	local var_7_6 = var_7_3(var_9)
	local var_7_7 = var_7.getSortShipsByFleet(var_7_6, var_7_5)

	ipairs = var_7_4

	for iter_7_0, iter_7_1 in var_7_4(var_7_7) do
		table = var_1_10013

		var_1_10013.insert(var_7_0, iter_7_1)
	end

	local var_7_8, var_7_9 = var_7_2.GetPlayerShipResource(var_7_0, arg_7_0.system)

	if var_5:GetBossById(arg_7_0.bossId) and var_10:IsSelf() then
		local var_7_10, var_7_11, var_7_12 = var_5.GetSupportValue()

		if var_7_10 then
			local var_7_13 = var_7_2.GetResFromBuffIDList({
				var_7_12
			})

			ipairs = var_1_10015

			for iter_7_2, iter_7_3 in var_1_10015(var_7_13) do
				table = var_1_10020

				var_1_10020.insert(var_7_8, iter_7_3)
			end
		end
	end

	return var_7_8, var_7_9
end

return var_0_0
