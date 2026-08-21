local var_0_0 = class("WorldBossMediator", import("...base.ContextMediator"))

var_0_0.ON_BATTLE = "WorldBossMediator:ON_BATTLE"
var_0_0.ON_RANK_LIST = "WorldBossMediator:ON_RANK_LIST"
var_0_0.ON_FETCH_BOSS = "WorldBossMediator:ON_FETCH_BOSS"
var_0_0.ON_SURPPORT = "WorldBossMediator:ON_SURPPORT"
var_0_0.ON_SUBMIT_AWARD = "WorldBossMediator:ON_SUBMIT_AWARD"
var_0_0.ON_SELF_BOSS_OVERTIME = "WorldBossMediator:ON_SELF_BOSS_OVERTIME"
var_0_0.ON_ACTIVE_BOSS = "WorldBossMediator:ON_ACTIVE_BOSS"
var_0_0.GET_RANK_CNT = "WorldBossMediator:GET_RANK_CNT"
var_0_0.UPDATE_CACHE_BOSS_HP = "WorldBossMediator:UPDATE_CACHE_BOSS_HP"
var_0_0.GO_META = "WorldBossMediator:GO_META"
var_0_0.FETCH_RANK_FORMATION = "WorldBossMediator:FETCH_RANK_FORMATION"
var_0_0.ON_SWITCH_ARCHIVES = "WorldBossMediator:ON_SWITCH_ARCHIVES"
var_0_0.ON_ACTIVE_ARCHIVES_BOSS = "WorldBossMediator:ON_ACTIVE_ARCHIVES_BOSS"
var_0_0.ON_ARCHIVES_BOSS_AUTO_BATTLE = "WorldBossMediator:ON_ARCHIVES_BOSS_AUTO_BATTLE"
var_0_0.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE = "WorldBossMediator:ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE"
var_0_0.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER = "WorldBossMediator:ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER"
var_0_0.ON_UPDATE_BOSS_INFO = "WorldBossMediator:UPDATE_BOSS_INFO"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE, {
			id = arg_2_1,
			type = WorldBossConst.STOP_AUTO_BATTLE_MANUAL
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE, {
			id = arg_3_1,
			type = WorldBossConst.STOP_AUTO_BATTLE_TIMEOVER
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ARCHIVES_BOSS_AUTO_BATTLE, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.WORLD_ARCHIVES_BOSS_AUTO_BATTLE, {
			id = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVE_ARCHIVES_BOSS, function(arg_5_0)
		arg_1_0:sendNotification(GAME.WORLD_ACTIVE_WORLD_BOSS, {
			id = nowWorld():GetBossProxy():GetArchivesId(),
			type = WorldBossConst.BOSS_TYPE_ARCHIVES
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVE_BOSS, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.WORLD_ACTIVE_WORLD_BOSS, {
			id = arg_6_1,
			type = WorldBossConst.BOSS_TYPE_CURR
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SWITCH_ARCHIVES, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.SWITCH_WORLD_BOSS_ARCHIVES, {
			id = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.FETCH_RANK_FORMATION, function(arg_8_0, arg_8_1, arg_8_2)
		arg_1_0:sendNotification(GAME.WORLD_BOSS_GET_FORMATION, {
			bossId = arg_8_2,
			userId = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_META, function(arg_9_0, arg_9_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
			autoOpenSyn = true,
			autoOpenShipConfigID = arg_9_1 * 10 + 1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELF_BOSS_OVERTIME, function(arg_10_0)
		arg_1_0:sendNotification(GAME.WORLD_SELF_BOSS_OVERTIME)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SUBMIT_AWARD, function(arg_11_0, arg_11_1)
		arg_1_0:sendNotification(GAME.WORLD_BOSS_SUBMIT_AWARD, {
			bossId = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SURPPORT, function(arg_12_0, arg_12_1)
		if arg_12_1[3] == true then
			arg_1_0:sendNotification(GAME.WORLD_BOSS_SUPPORT, {
				type = WorldBoss.SUPPORT_TYPE_WORLD
			})
		end

		if arg_12_1[1] == true then
			arg_1_0:sendNotification(GAME.WORLD_BOSS_SUPPORT, {
				type = WorldBoss.SUPPORT_TYPE_FRIEND
			})
		end

		if arg_12_1[2] == true then
			arg_1_0:sendNotification(GAME.WORLD_BOSS_SUPPORT, {
				type = WorldBoss.SUPPORT_TYPE_GUILD
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_FETCH_BOSS, function(arg_13_0)
		arg_1_0:updateBossProxy()

		return
	end)
	arg_1_0:bind(var_0_0.ON_BATTLE, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		arg_1_0:sendNotification(GAME.WORLD_BOSS_START_BATTLE, {
			bossId = arg_14_1,
			isOther = arg_14_2,
			hpRate = arg_14_3 or 1,
			isSimulate = arg_14_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_RANK_LIST, function(arg_15_0, arg_15_1)
		arg_1_0:sendNotification(GAME.WORLD_GET_BOSS_RANK, {
			bossId = arg_15_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_RANK_CNT, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_1_0.viewComponent.bossProxy:GetRank(arg_16_1)

		if not var_16_0 then
			arg_1_0:sendNotification(GAME.WORLD_GET_BOSS_RANK, {
				bossId = arg_16_1,
				callback = arg_16_2
			})
		else
			arg_16_2(#var_16_0)
		end

		return
	end)
	arg_1_0:bind(var_0_0.UPDATE_CACHE_BOSS_HP, function(arg_17_0, arg_17_1)
		arg_1_0:sendNotification(GAME.GET_CACHE_BOSS_HP, {
			callback = arg_17_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPDATE_BOSS_INFO, function(arg_18_0, arg_18_1)
		arg_1_0:sendNotification(GAME.WORLD_GET_BOSS, {
			callback = arg_18_1
		})

		return
	end)

	return
end

function var_0_0.updateBossProxy(arg_19_0)
	local var_19_0 = nowWorld():GetBossProxy()

	arg_19_0.viewComponent:SetBossProxy(var_19_0, (getProxy(MetaCharacterProxy)))

	if not WorldBossScene.inOtherBossBattle and not arg_19_0.contextData.worldBossId and not var_19_0:ExistSelfBossAward() then
		local var_19_1 = var_19_0:GetCanGetAwardBoss()

		if var_19_1 then
			arg_19_0.contextData.worldBossId = var_19_1.id
		end
	end

	if WorldBossScene.inOtherBossBattle or arg_19_0.contextData.worldBossId then
		local var_19_2 = var_19_0:GetCacheBoss(arg_19_0.contextData.worldBossId)

		if var_19_2 and not WorldBossConst._IsCurrBoss(var_19_2) then
			arg_19_0.viewComponent:SwitchPage(WorldBossScene.PAGE_ARCHIVES_CHALLENGE)
		else
			arg_19_0.viewComponent:SwitchPage(WorldBossScene.PAGE_CHALLENGE)
		end
	else
		arg_19_0.viewComponent:SwitchPage(WorldBossScene.PAGE_ENTRANCE)
	end

	return
end

function var_0_0.listNotificationInterests(arg_20_0)
	return {
		GAME.WORLD_GET_BOSS_DONE,
		GAME.WORLD_BOSS_SUPPORT_DONE,
		GAME.WORLD_BOSS_SUBMIT_AWARD_DONE,
		GAME.REMOVE_LAYERS,
		GAME.WORLD_BOSS_GET_FORMATION_DONE,
		GAME.SWITCH_WORLD_BOSS_ARCHIVES_DONE,
		GAME.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE_DONE,
		GAME.WORLD_ARCHIVES_BOSS_AUTO_BATTLE_DONE,
		GAME.GET_META_PT_AWARD_DONE
	}
end

function var_0_0.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == GAME.WORLD_GET_BOSS_DONE then
		arg_21_0:updateBossProxy()
	elseif var_21_0 == GAME.WORLD_BOSS_SUPPORT_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_call_support_success"))
	elseif var_21_0 == GAME.WORLD_BOSS_SUBMIT_AWARD_DONE then
		arg_21_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_21_1.items)
		arg_21_0.viewComponent:getAwardDone()
	elseif var_21_0 == GAME.REMOVE_LAYERS then
		if not var_21_1.onHome and var_21_1.context.mediator == WorldBossFormationMediator then
			arg_21_0.viewComponent:OnRemoveLayers()
		end
	elseif var_21_0 == GAME.WORLD_BOSS_GET_FORMATION_DONE then
		arg_21_0.viewComponent:OnShowFormationPreview(var_21_1.ships)
	elseif var_21_0 == GAME.SWITCH_WORLD_BOSS_ARCHIVES_DONE then
		arg_21_0.viewComponent:OnSwitchArchives()
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_switch_archives_success"))
	elseif var_21_0 == GAME.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE_DONE then
		arg_21_0.viewComponent:OnAutoBattleResult(var_21_1)
	elseif var_21_0 == GAME.WORLD_ARCHIVES_BOSS_AUTO_BATTLE_DONE then
		arg_21_0.viewComponent:OnAutoBattleStart(var_21_1)
	elseif var_21_0 == GAME.GET_META_PT_AWARD_DONE then
		arg_21_0.viewComponent:OnGetMetaAwards()
		arg_21_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_21_1.awards)
	end

	return
end

return var_0_0
