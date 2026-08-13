class = var_0_10000

local var_0_0 = "WorldBossStartBattleCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().bossId
	local var_1_1 = var_2.isOther
	local var_1_2 = var_2.hpRate
	local var_1_3 = var_2.isSimulate

	nowWorld = var_1_10007

	local var_1_4 = var_1_10007()
	local var_1_5 = var_7.GetBossProxy(var_1_4)
	local var_1_6 = var_8.GetBossById(var_1_5, var_1_0)
	local var_1_7
	local var_1_8

	if var_1_3 then
		var_1_8 = nil
		pg = var_1_10012

		local var_1_9 = var_1_10012.world_joint_boss_template[var_1_0]

		WorldBossConst = var_1_10013

		if var_1_10013.GetCurrBossID() == var_1_0 then
			var_1_8 = var_1_9.boss_level_id + var_8.currentBossLV - 1
		else
			var_1_8 = var_1_9.boss_level_id + 14
		end

		pg = var_1_10013
		var_1_7 = var_1_10013.world_boss_level[var_1_8].expedition_id
	else
		if not var_1_6 then
			pg = var_1_8

			local var_1_10 = var_1_8.TipsMgr.GetInstance()
			local var_1_11 = var_11.ShowTips

			i18n = var_1_10013

			var_1_11(var_1_10, var_1_10013("world_joint_boss_not_found"))

			return
		end

		if var_1_1 and var_8:GetPt() <= 0 then
			WorldBossConst = var_11

			if var_11._IsCurrBoss(var_1_6) then
				pg = var_11

				local var_1_12 = var_11.TipsMgr.GetInstance()
				local var_1_13 = var_11.ShowTips

				i18n = var_1_10013

				var_1_13(var_1_12, var_1_10013("world_joint_count_no_enough"))

				return
			end
		end

		var_1_7 = var_1_6:GetStageID()
	end

	local function var_1_14()
		getProxy = var_2_10000
		ContextProxy = var_2_10001

		local var_2_0 = var_2_10000(var_2_10001)
		local var_2_1 = var_0.getCurrentContext(var_2_0)

		pg = var_2_0

		local var_2_2 = var_2_0.m02
		local var_2_3 = var_2.retrieveMediator(var_2_2, var_2_1.mediator.__cname)
		local var_2_4 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_5 = var_2_10005.New
		local var_2_6 = {}

		WorldBossFormationMediator = var_2_10007
		var_2_6.mediator = var_2_10007
		WorldBossFormationLayer = var_2_10007
		var_2_6.viewComponent = var_2_10007

		local var_2_7 = {
			actID = 0,
			stageId = var_1_7,
			bossId = var_1_0
		}

		SYSTEM_WORLD_BOSS = var_8
		var_2_7.system = var_8
		var_2_7.isOther = var_1_1
		var_2_7.hpRate = var_1_2
		var_2_7.isSimulate = var_1_3
		var_2_6.data = var_2_7

		var_2_4(var_2_3, var_2_5(var_2_6))

		return
	end

	local function var_1_15()
		local var_3_0 = var_0

		var_0.RemoveCacheBoss(var_3_0, var_1_6.id)

		return
	end

	if var_1_3 then
		var_1_14()
	else
		local var_1_16 = arg_1_0
		local var_1_17 = arg_1_0.sendNotification

		GAME = var_1_10015

		var_1_17(var_1_16, var_1_10015.CHECK_WORLD_BOSS_STATE, {
			bossId = var_1_0,
			time = var_1_6.lastTime,
			callback = var_1_14,
			failedCallback = var_1_15
		})
	end

	return
end

return var_0_1
