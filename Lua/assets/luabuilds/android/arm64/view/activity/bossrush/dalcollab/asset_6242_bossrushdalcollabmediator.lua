local BossRushDALCollabMediator = class("BossRushDALCollabMediator", import("view.base.ContextMediator"))

BossRushDALCollabMediator.ON_FLEET_SELECT = "BossRushDALCollabMediator:ON_FLEET_SELECT"
BossRushDALCollabMediator.ON_PERFORM_COMBAT = "BossRushDALCollabMediator:ON_PERFORM_COMBAT"
BossRushDALCollabMediator.ON_UPGRADE = "BossRushDALCollabMediator:ON_UPGRADE"
BossRushDALCollabMediator.GO_SHOPS_LAYER = "BossRushDALCollabMediator:GO_SHOPS_LAYER"

function BossRushDALCollabMediator:register()
	self:bind(BossRushDALCollabMediator.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = BossRushFleetSelectMediator,
			viewComponent = BossRushDALFleetSelectView,
			data = {
				seriesData = arg_2_1
			}
		}))

		return
	end)
	self:bind(BossRushDALCollabMediator.GO_SHOPS_LAYER, function(arg_3_0, arg_3_1)
		if not getProxy(ActivityProxy):getActivityById(arg_3_1.actId) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_3_1 or {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	local var_1_0 = getProxy(ActivityProxy)
	local var_1_1 = var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)

	self.viewComponent:SetActivity(var_1_1)
	self.viewComponent:SetUpgradeActvity((var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)))

	local var_1_2 = var_1_1:getConfig("config_client").PTID

	self.viewComponent:SetPTActivity(underscore.detect(var_1_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_4_0)
		return arg_4_0:getConfig("config_id") == var_1_2
	end))
	self:sendNotification(GAME.COLLABRATE_BOSS_RUSH_REQUEST_DATA, {
		actId = var_1_1.id
	})
	self.viewComponent:addbubbleMsgBox(function(arg_5_0)
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushTotalRewardPanelMediator) then
			return
		end

		arg_5_0()

		return
	end)
	self.viewComponent:addbubbleMsgBox(function(arg_6_0)
		pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_6_0)

		return
	end)
	self:bind(BossRushDALCollabMediator.ON_UPGRADE, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_7_1)

		return
	end)

	return
end

function BossRushDALCollabMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.BEGIN_STAGE_DONE,
		BossRushTotalRewardPanelMediator.ON_WILL_EXIT,
		GAME.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE
	}
end

function BossRushDALCollabMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()
	local var_9_2 = arg_9_1:getType()

	if var_9_0 == nil then
		-- block empty
	elseif var_9_0 == GAME.BEGIN_STAGE_DONE then
		if not getProxy(ContextProxy):getContextByMediator(BossRushPreCombatMediator) then
			self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_9_1)
		end
	elseif var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_9_1 then
			if var_9_1.id == self.viewComponent.activity.id then
				self.viewComponent:SetActivity(var_9_1)
				self.viewComponent:UpdateView()
			end

			if var_9_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF then
				self.viewComponent.upgradeView:SetData(var_9_1)
				self.viewComponent.upgradeView:UpdateView()
			end
		end
	elseif var_9_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards, function()
			self.viewComponent:UpdateTasks(var_9_2)

			return
		end)
	elseif var_9_0 == BossRushTotalRewardPanelMediator.ON_WILL_EXIT then
		self.viewComponent:resumeBubble()
		self.viewComponent:UpdateView()
	elseif var_9_0 == GAME.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE then
		self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)))
		self.viewComponent:UpdateView()
	end

	return
end

function BossRushDALCollabMediator:remove()
	return
end

return BossRushDALCollabMediator
