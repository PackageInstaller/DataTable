local var_0_0 = class("BossRushDALCollabMediator", import("view.base.ContextMediator"))

var_0_0.ON_FLEET_SELECT = "BossRushDALCollabMediator:ON_FLEET_SELECT"
var_0_0.ON_PERFORM_COMBAT = "BossRushDALCollabMediator:ON_PERFORM_COMBAT"
var_0_0.ON_UPGRADE = "BossRushDALCollabMediator:ON_UPGRADE"
var_0_0.GO_SHOPS_LAYER = "BossRushDALCollabMediator:GO_SHOPS_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = BossRushFleetSelectMediator,
			viewComponent = BossRushDALFleetSelectView,
			data = {
				seriesData = arg_2_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.GO_SHOPS_LAYER, function(arg_3_0, arg_3_1)
		if not getProxy(ActivityProxy):getActivityById(arg_3_1.actId) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_3_1 or {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	local var_1_0 = getProxy(ActivityProxy)
	local var_1_1 = var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)

	arg_1_0.viewComponent:SetActivity(var_1_1)
	arg_1_0.viewComponent:SetUpgradeActvity((var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)))

	local var_1_2 = var_1_1:getConfig("config_client").PTID

	arg_1_0.viewComponent:SetPTActivity(underscore.detect(var_1_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_4_0)
		return arg_4_0:getConfig("config_id") == var_1_2
	end))
	arg_1_0:sendNotification(GAME.COLLABRATE_BOSS_RUSH_REQUEST_DATA, {
		actId = var_1_1.id
	})
	arg_1_0.viewComponent:addbubbleMsgBox(function(arg_5_0)
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushTotalRewardPanelMediator) then
			return
		end

		arg_5_0()

		return
	end)
	arg_1_0.viewComponent:addbubbleMsgBox(function(arg_6_0)
		pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_6_0)

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPGRADE, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_7_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.BEGIN_STAGE_DONE,
		BossRushTotalRewardPanelMediator.ON_WILL_EXIT,
		GAME.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()
	local var_9_2 = arg_9_1:getType()

	if var_9_0 == nil then
		-- block empty
	elseif var_9_0 == GAME.BEGIN_STAGE_DONE then
		if not getProxy(ContextProxy):getContextByMediator(BossRushPreCombatMediator) then
			arg_9_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_9_1)
		end
	elseif var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_9_1 then
			if var_9_1.id == arg_9_0.viewComponent.activity.id then
				arg_9_0.viewComponent:SetActivity(var_9_1)
				arg_9_0.viewComponent:UpdateView()
			end

			if var_9_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF then
				arg_9_0.viewComponent.upgradeView:SetData(var_9_1)
				arg_9_0.viewComponent.upgradeView:UpdateView()
			end
		end
	elseif var_9_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_9_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards, function()
			arg_9_0.viewComponent:UpdateTasks(var_9_2)

			return
		end)
	elseif var_9_0 == BossRushTotalRewardPanelMediator.ON_WILL_EXIT then
		arg_9_0.viewComponent:resumeBubble()
		arg_9_0.viewComponent:UpdateView()
	elseif var_9_0 == GAME.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE then
		arg_9_0.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)))
		arg_9_0.viewComponent:UpdateView()
	end

	return
end

function var_0_0.remove(arg_11_0)
	return
end

return var_0_0
