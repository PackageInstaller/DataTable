class = var_0_10000

local var_0_0 = "WorldBossMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_BATTLE = "WorldBossMediator:ON_BATTLE"
var_0_1.ON_RANK_LIST = "WorldBossMediator:ON_RANK_LIST"
var_0_1.ON_FETCH_BOSS = "WorldBossMediator:ON_FETCH_BOSS"
var_0_1.ON_SURPPORT = "WorldBossMediator:ON_SURPPORT"
var_0_1.ON_SUBMIT_AWARD = "WorldBossMediator:ON_SUBMIT_AWARD"
var_0_1.ON_SELF_BOSS_OVERTIME = "WorldBossMediator:ON_SELF_BOSS_OVERTIME"
var_0_1.ON_ACTIVE_BOSS = "WorldBossMediator:ON_ACTIVE_BOSS"
var_0_1.GET_RANK_CNT = "WorldBossMediator:GET_RANK_CNT"
var_0_1.UPDATE_CACHE_BOSS_HP = "WorldBossMediator:UPDATE_CACHE_BOSS_HP"
var_0_1.GO_META = "WorldBossMediator:GO_META"
var_0_1.FETCH_RANK_FORMATION = "WorldBossMediator:FETCH_RANK_FORMATION"
var_0_1.ON_SWITCH_ARCHIVES = "WorldBossMediator:ON_SWITCH_ARCHIVES"
var_0_1.ON_ACTIVE_ARCHIVES_BOSS = "WorldBossMediator:ON_ACTIVE_ARCHIVES_BOSS"
var_0_1.ON_ARCHIVES_BOSS_AUTO_BATTLE = "WorldBossMediator:ON_ARCHIVES_BOSS_AUTO_BATTLE"
var_0_1.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE = "WorldBossMediator:ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE"
var_0_1.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER = "WorldBossMediator:ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER"
var_0_1.ON_UPDATE_BOSS_INFO = "WorldBossMediator:UPDATE_BOSS_INFO"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE
		local var_2_3 = {
			id = arg_2_1
		}

		WorldBossConst = var_2_10006
		var_2_3.type = var_2_10006.STOP_AUTO_BATTLE_MANUAL

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE
		local var_3_3 = {
			id = arg_3_1
		}

		WorldBossConst = var_2_10006
		var_3_3.type = var_2_10006.STOP_AUTO_BATTLE_TIMEOVER

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ARCHIVES_BOSS_AUTO_BATTLE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.WORLD_ARCHIVES_BOSS_AUTO_BATTLE, {
			id = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVE_ARCHIVES_BOSS, function(arg_5_0)
		nowWorld = var_2_10001

		local var_5_0 = var_2_10001()
		local var_5_1 = var_1.GetBossProxy(var_5_0)
		local var_5_2 = var_1.GetArchivesId(var_5_1)
		local var_5_3 = arg_1_0
		local var_5_4 = var_2.sendNotification

		GAME = var_2_10004

		local var_5_5 = var_2_10004.WORLD_ACTIVE_WORLD_BOSS
		local var_5_6 = {
			id = var_5_2
		}

		WorldBossConst = var_2_10006
		var_5_6.type = var_2_10006.BOSS_TYPE_ARCHIVES

		var_5_4(var_5_3, var_5_5, var_5_6)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVE_BOSS, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_6_2 = var_2_10004.WORLD_ACTIVE_WORLD_BOSS
		local var_6_3 = {
			id = arg_6_1
		}

		WorldBossConst = var_2_10006
		var_6_3.type = var_2_10006.BOSS_TYPE_CURR

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SWITCH_ARCHIVES, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		var_7_1(var_7_0, var_2_10004.SWITCH_WORLD_BOSS_ARCHIVES, {
			id = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.FETCH_RANK_FORMATION, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_1_0
		local var_8_1 = var_3.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.WORLD_BOSS_GET_FORMATION, {
			bossId = arg_8_2,
			userId = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_META, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_9_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_9_1(var_9_0, var_9_2, var_2_10005.METACHARACTER, {
			autoOpenSyn = true,
			autoOpenShipConfigID = arg_9_1 * 10 + 1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELF_BOSS_OVERTIME, function(arg_10_0)
		local var_10_0 = arg_1_0
		local var_10_1 = var_1.sendNotification

		GAME = var_2_10003

		var_10_1(var_10_0, var_2_10003.WORLD_SELF_BOSS_OVERTIME)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT_AWARD, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.sendNotification

		GAME = var_2_10004

		var_11_1(var_11_0, var_2_10004.WORLD_BOSS_SUBMIT_AWARD, {
			bossId = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SURPPORT, function(arg_12_0, arg_12_1)
		if arg_12_1[3] == true then
			local var_12_0 = arg_1_0
			local var_12_1 = var_2.sendNotification

			GAME = var_2_10004
			var_2_10004 = var_2_10004.WORLD_BOSS_SUPPORT

			local var_12_2 = {}

			WorldBoss = var_2_10006
			var_12_2.type = var_2_10006.SUPPORT_TYPE_WORLD

			var_12_1(var_12_0, var_2_10004, var_12_2)
		end

		if arg_12_1[1] == true then
			local var_12_3 = arg_1_0
			local var_12_4 = var_2.sendNotification

			GAME = var_2_10004
			var_2_10004 = var_2_10004.WORLD_BOSS_SUPPORT

			local var_12_5 = {}

			WorldBoss = var_2_10006
			var_12_5.type = var_2_10006.SUPPORT_TYPE_FRIEND

			var_12_4(var_12_3, var_2_10004, var_12_5)
		end

		if arg_12_1[2] == true then
			local var_12_6 = arg_1_0
			local var_12_7 = var_2.sendNotification

			GAME = var_2_10004

			local var_12_8 = var_2_10004.WORLD_BOSS_SUPPORT
			local var_12_9 = {}

			WorldBoss = var_2_10006
			var_12_9.type = var_2_10006.SUPPORT_TYPE_GUILD

			var_12_7(var_12_6, var_12_8, var_12_9)
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_FETCH_BOSS, function(arg_13_0)
		local var_13_0 = arg_1_0

		var_1.updateBossProxy(var_13_0)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BATTLE, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		local var_14_0 = arg_1_0
		local var_14_1 = var_5.sendNotification

		GAME = var_2_10007

		var_14_1(var_14_0, var_2_10007.WORLD_BOSS_START_BATTLE, {
			bossId = arg_14_1,
			isOther = arg_14_2,
			hpRate = arg_14_3 or 1,
			isSimulate = arg_14_4
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_RANK_LIST, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.sendNotification

		GAME = var_2_10004

		var_15_1(var_15_0, var_2_10004.WORLD_GET_BOSS_RANK, {
			bossId = arg_15_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GET_RANK_CNT, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_1_0.viewComponent.bossProxy

		if not var_3.GetRank(var_16_0, arg_16_1) then
			local var_16_1 = arg_1_0
			local var_16_2 = var_4.sendNotification

			GAME = var_2_10006

			var_16_2(var_16_1, var_2_10006.WORLD_GET_BOSS_RANK, {
				bossId = arg_16_1,
				callback = arg_16_2
			})
		else
			arg_16_2(#var_3)
		end

		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_CACHE_BOSS_HP, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_1_0
		local var_17_1 = var_2.sendNotification

		GAME = var_2_10004

		var_17_1(var_17_0, var_2_10004.GET_CACHE_BOSS_HP, {
			callback = arg_17_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPDATE_BOSS_INFO, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_1_0
		local var_18_1 = var_2.sendNotification

		GAME = var_2_10004

		var_18_1(var_18_0, var_2_10004.WORLD_GET_BOSS, {
			callback = arg_18_1
		})

		return
	end)

	return
end

function var_0_1.updateBossProxy(arg_19_0)
	nowWorld = var_1_10001

	local var_19_0 = var_1_10001()
	local var_19_1 = var_1.GetBossProxy(var_19_0)

	getProxy = var_19_0
	MetaCharacterProxy = var_1_10004

	local var_19_2 = var_19_0(var_1_10004)
	local var_19_3 = arg_19_0.viewComponent

	var_4.SetBossProxy(var_19_3, var_19_1, var_19_2)

	WorldBossScene = var_4

	if not var_4.inOtherBossBattle and not arg_19_0.contextData.worldBossId and not var_19_1:ExistSelfBossAward() and var_19_1:GetCanGetAwardBoss() then
		arg_19_0.contextData.worldBossId = var_4.id
	end

	WorldBossScene = var_4

	local var_19_5

	if var_4.inOtherBossBattle or arg_19_0.contextData.worldBossId then
		local var_19_4 = var_19_1

		if var_19_1.GetCacheBoss(var_19_4, arg_19_0.contextData.worldBossId) then
			WorldBossConst = var_19_4

			if not var_19_4._IsCurrBoss(var_4) then
				var_19_5 = arg_19_0.viewComponent

				local var_19_6 = var_5.SwitchPage

				WorldBossScene = var_7

				var_19_6(var_19_5, var_7.PAGE_ARCHIVES_CHALLENGE)

				goto label_19_0
			end
		end

		var_19_5 = arg_19_0.viewComponent

		local var_19_7 = var_5.SwitchPage

		WorldBossScene = var_7

		var_19_7(var_19_5, var_7.PAGE_CHALLENGE)
	else
		local var_19_8 = arg_19_0.viewComponent
		local var_19_9 = var_4.SwitchPage

		WorldBossScene = var_19_5

		var_19_9(var_19_8, var_19_5.PAGE_ENTRANCE)
	end

	::label_19_0::

	return
end

function var_0_1.listNotificationInterests(arg_20_0)
	local var_20_0 = {}

	GAME = var_1_10002
	var_20_0[1] = var_1_10002.WORLD_GET_BOSS_DONE
	GAME = var_2
	var_20_0[2] = var_2.WORLD_BOSS_SUPPORT_DONE
	GAME = var_2
	var_20_0[3] = var_2.WORLD_BOSS_SUBMIT_AWARD_DONE
	GAME = var_2
	var_20_0[4] = var_2.REMOVE_LAYERS
	GAME = var_2
	var_20_0[5] = var_2.WORLD_BOSS_GET_FORMATION_DONE
	GAME = var_2
	var_20_0[6] = var_2.SWITCH_WORLD_BOSS_ARCHIVES_DONE
	GAME = var_2
	var_20_0[7] = var_2.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE_DONE
	GAME = var_2
	var_20_0[8] = var_2.WORLD_ARCHIVES_BOSS_AUTO_BATTLE_DONE
	GAME = var_2
	var_20_0[9] = var_2.GET_META_PT_AWARD_DONE

	return var_20_0
end

function var_0_1.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1
	local var_21_2 = arg_21_1.getBody(var_21_1)

	GAME = var_21_1

	if var_21_0 == var_21_1.WORLD_GET_BOSS_DONE then
		var_1_10005 = arg_21_0

		arg_21_0.updateBossProxy(var_1_10005)
	else
		GAME = var_4

		local var_21_3

		if var_21_0 == var_4.WORLD_BOSS_SUPPORT_DONE then
			pg = var_21_3
			var_1_10005 = var_21_3.TipsMgr.GetInstance()
			var_21_3 = var_21_3.ShowTips
			i18n = var_1_10006

			var_21_3(var_1_10005, var_1_10006("world_joint_call_support_success"))
		else
			GAME = var_21_3

			local var_21_4

			if var_21_0 == var_21_3.WORLD_BOSS_SUBMIT_AWARD_DONE then
				var_1_10005 = arg_21_0.viewComponent
				var_21_4 = var_21_4.emit
				BaseUI = var_1_10006

				var_21_4(var_1_10005, var_1_10006.ON_ACHIEVE, var_21_2.items)

				var_1_10005 = arg_21_0.viewComponent

				var_21_4.getAwardDone(var_1_10005)
			else
				GAME = var_21_4

				local var_21_5

				if var_21_0 == var_21_4.REMOVE_LAYERS then
					if not var_21_2.onHome then
						var_21_5 = var_21_2.context.mediator
						WorldBossFormationMediator = var_1_10005

						if var_21_5 == var_1_10005 then
							local var_21_6 = arg_21_0.viewComponent

							var_21_5.OnRemoveLayers(var_21_6)
						end
					end
				else
					GAME = var_21_5

					if var_21_0 == var_21_5.WORLD_BOSS_GET_FORMATION_DONE then
						local var_21_7 = arg_21_0.viewComponent

						var_4.OnShowFormationPreview(var_21_7, var_21_2.ships)
					else
						GAME = var_4

						local var_21_10

						if var_21_0 == var_4.SWITCH_WORLD_BOSS_ARCHIVES_DONE then
							local var_21_8 = arg_21_0.viewComponent

							var_21_10.OnSwitchArchives(var_21_8)

							pg = var_21_10

							local var_21_9 = var_21_10.TipsMgr.GetInstance()

							var_21_10 = var_21_10.ShowTips
							i18n = var_1_10006

							var_21_10(var_21_9, var_1_10006("world_boss_switch_archives_success"))
						else
							GAME = var_21_10

							if var_21_0 == var_21_10.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE_DONE then
								local var_21_11 = arg_21_0.viewComponent

								var_4.OnAutoBattleResult(var_21_11, var_21_2)
							else
								GAME = var_4

								if var_21_0 == var_4.WORLD_ARCHIVES_BOSS_AUTO_BATTLE_DONE then
									local var_21_12 = arg_21_0.viewComponent

									var_4.OnAutoBattleStart(var_21_12, var_21_2)
								else
									GAME = var_4

									if var_21_0 == var_4.GET_META_PT_AWARD_DONE then
										local var_21_13 = arg_21_0.viewComponent

										var_4.OnGetMetaAwards(var_21_13)

										local var_21_14 = arg_21_0.viewComponent
										local var_21_15 = var_4.emit

										BaseUI = var_1_10006

										var_21_15(var_21_14, var_1_10006.ON_ACHIEVE, var_21_2.awards)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
