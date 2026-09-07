local WorldBossMediator = class("WorldBossMediator", import("...base.ContextMediator"))

WorldBossMediator.ON_BATTLE = "WorldBossMediator:ON_BATTLE"
WorldBossMediator.ON_RANK_LIST = "WorldBossMediator:ON_RANK_LIST"
WorldBossMediator.ON_FETCH_BOSS = "WorldBossMediator:ON_FETCH_BOSS"
WorldBossMediator.ON_SURPPORT = "WorldBossMediator:ON_SURPPORT"
WorldBossMediator.ON_SUBMIT_AWARD = "WorldBossMediator:ON_SUBMIT_AWARD"
WorldBossMediator.ON_SELF_BOSS_OVERTIME = "WorldBossMediator:ON_SELF_BOSS_OVERTIME"
WorldBossMediator.ON_ACTIVE_BOSS = "WorldBossMediator:ON_ACTIVE_BOSS"
WorldBossMediator.GET_RANK_CNT = "WorldBossMediator:GET_RANK_CNT"
WorldBossMediator.UPDATE_CACHE_BOSS_HP = "WorldBossMediator:UPDATE_CACHE_BOSS_HP"
WorldBossMediator.GO_META = "WorldBossMediator:GO_META"
WorldBossMediator.FETCH_RANK_FORMATION = "WorldBossMediator:FETCH_RANK_FORMATION"
WorldBossMediator.ON_SWITCH_ARCHIVES = "WorldBossMediator:ON_SWITCH_ARCHIVES"
WorldBossMediator.ON_ACTIVE_ARCHIVES_BOSS = "WorldBossMediator:ON_ACTIVE_ARCHIVES_BOSS"
WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE = "WorldBossMediator:ON_ARCHIVES_BOSS_AUTO_BATTLE"
WorldBossMediator.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE = "WorldBossMediator:ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE"
WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER = "WorldBossMediator:ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER"
WorldBossMediator.ON_UPDATE_BOSS_INFO = "WorldBossMediator:UPDATE_BOSS_INFO"

function WorldBossMediator:register()
	self:bind(WorldBossMediator.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE, {
			id = arg_2_1,
			type = WorldBossConst.STOP_AUTO_BATTLE_MANUAL
		})

		return
	end)
	self:bind(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE, {
			id = arg_3_1,
			type = WorldBossConst.STOP_AUTO_BATTLE_TIMEOVER
		})

		return
	end)
	self:bind(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.WORLD_ARCHIVES_BOSS_AUTO_BATTLE, {
			id = arg_4_1
		})

		return
	end)
	self:bind(WorldBossMediator.ON_ACTIVE_ARCHIVES_BOSS, function(arg_5_0)
		self:sendNotification(GAME.WORLD_ACTIVE_WORLD_BOSS, {
			id = nowWorld():GetBossProxy():GetArchivesId(),
			type = WorldBossConst.BOSS_TYPE_ARCHIVES
		})

		return
	end)
	self:bind(WorldBossMediator.ON_ACTIVE_BOSS, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.WORLD_ACTIVE_WORLD_BOSS, {
			id = arg_6_1,
			type = WorldBossConst.BOSS_TYPE_CURR
		})

		return
	end)
	self:bind(WorldBossMediator.ON_SWITCH_ARCHIVES, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.SWITCH_WORLD_BOSS_ARCHIVES, {
			id = arg_7_1
		})

		return
	end)
	self:bind(WorldBossMediator.FETCH_RANK_FORMATION, function(arg_8_0, arg_8_1, arg_8_2)
		self:sendNotification(GAME.WORLD_BOSS_GET_FORMATION, {
			bossId = arg_8_2,
			userId = arg_8_1
		})

		return
	end)
	self:bind(WorldBossMediator.GO_META, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
			autoOpenSyn = true,
			autoOpenShipConfigID = arg_9_1 * 10 + 1
		})

		return
	end)
	self:bind(WorldBossMediator.ON_SELF_BOSS_OVERTIME, function(arg_10_0)
		self:sendNotification(GAME.WORLD_SELF_BOSS_OVERTIME)

		return
	end)
	self:bind(WorldBossMediator.ON_SUBMIT_AWARD, function(arg_11_0, arg_11_1)
		self:sendNotification(GAME.WORLD_BOSS_SUBMIT_AWARD, {
			bossId = arg_11_1
		})

		return
	end)
	self:bind(WorldBossMediator.ON_SURPPORT, function(arg_12_0, arg_12_1)
		if arg_12_1[3] == true then
			self:sendNotification(GAME.WORLD_BOSS_SUPPORT, {
				type = WorldBoss.SUPPORT_TYPE_WORLD
			})
		end

		if arg_12_1[1] == true then
			self:sendNotification(GAME.WORLD_BOSS_SUPPORT, {
				type = WorldBoss.SUPPORT_TYPE_FRIEND
			})
		end

		if arg_12_1[2] == true then
			self:sendNotification(GAME.WORLD_BOSS_SUPPORT, {
				type = WorldBoss.SUPPORT_TYPE_GUILD
			})
		end

		return
	end)
	self:bind(WorldBossMediator.ON_FETCH_BOSS, function(arg_13_0)
		self:updateBossProxy()

		return
	end)
	self:bind(WorldBossMediator.ON_BATTLE, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		self:sendNotification(GAME.WORLD_BOSS_START_BATTLE, {
			bossId = arg_14_1,
			isOther = arg_14_2,
			hpRate = arg_14_3 or 1,
			isSimulate = arg_14_4
		})

		return
	end)
	self:bind(WorldBossMediator.ON_RANK_LIST, function(arg_15_0, arg_15_1)
		self:sendNotification(GAME.WORLD_GET_BOSS_RANK, {
			bossId = arg_15_1
		})

		return
	end)
	self:bind(WorldBossMediator.GET_RANK_CNT, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = self.viewComponent.bossProxy:GetRank(arg_16_1)

		if not var_16_0 then
			self:sendNotification(GAME.WORLD_GET_BOSS_RANK, {
				bossId = arg_16_1,
				callback = arg_16_2
			})
		else
			arg_16_2(#var_16_0)
		end

		return
	end)
	self:bind(WorldBossMediator.UPDATE_CACHE_BOSS_HP, function(arg_17_0, arg_17_1)
		self:sendNotification(GAME.GET_CACHE_BOSS_HP, {
			callback = arg_17_1
		})

		return
	end)
	self:bind(WorldBossMediator.ON_UPDATE_BOSS_INFO, function(arg_18_0, arg_18_1)
		self:sendNotification(GAME.WORLD_GET_BOSS, {
			callback = arg_18_1
		})

		return
	end)

	return
end

function WorldBossMediator:updateBossProxy()
	local var_19_0 = nowWorld():GetBossProxy()

	self.viewComponent:SetBossProxy(var_19_0, (getProxy(MetaCharacterProxy)))

	if not WorldBossScene.inOtherBossBattle and not self.contextData.worldBossId and not var_19_0:ExistSelfBossAward() then
		local var_19_1 = var_19_0:GetCanGetAwardBoss()

		if var_19_1 then
			self.contextData.worldBossId = var_19_1.id
		end
	end

	if WorldBossScene.inOtherBossBattle or self.contextData.worldBossId then
		local var_19_2 = var_19_0:GetCacheBoss(self.contextData.worldBossId)

		if var_19_2 and not WorldBossConst._IsCurrBoss(var_19_2) then
			self.viewComponent:SwitchPage(WorldBossScene.PAGE_ARCHIVES_CHALLENGE)
		else
			self.viewComponent:SwitchPage(WorldBossScene.PAGE_CHALLENGE)
		end
	else
		self.viewComponent:SwitchPage(WorldBossScene.PAGE_ENTRANCE)
	end

	return
end

function WorldBossMediator:listNotificationInterests()
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

function WorldBossMediator:handleNotification(arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == GAME.WORLD_GET_BOSS_DONE then
		self:updateBossProxy()
	elseif var_21_0 == GAME.WORLD_BOSS_SUPPORT_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_call_support_success"))
	elseif var_21_0 == GAME.WORLD_BOSS_SUBMIT_AWARD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_21_1.items)
		self.viewComponent:getAwardDone()
	elseif var_21_0 == GAME.REMOVE_LAYERS then
		if not var_21_1.onHome and var_21_1.context.mediator == WorldBossFormationMediator then
			self.viewComponent:OnRemoveLayers()
		end
	elseif var_21_0 == GAME.WORLD_BOSS_GET_FORMATION_DONE then
		self.viewComponent:OnShowFormationPreview(var_21_1.ships)
	elseif var_21_0 == GAME.SWITCH_WORLD_BOSS_ARCHIVES_DONE then
		self.viewComponent:OnSwitchArchives()
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_switch_archives_success"))
	elseif var_21_0 == GAME.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE_DONE then
		self.viewComponent:OnAutoBattleResult(var_21_1)
	elseif var_21_0 == GAME.WORLD_ARCHIVES_BOSS_AUTO_BATTLE_DONE then
		self.viewComponent:OnAutoBattleStart(var_21_1)
	elseif var_21_0 == GAME.GET_META_PT_AWARD_DONE then
		self.viewComponent:OnGetMetaAwards()
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_21_1.awards)
	end

	return
end

return WorldBossMediator
