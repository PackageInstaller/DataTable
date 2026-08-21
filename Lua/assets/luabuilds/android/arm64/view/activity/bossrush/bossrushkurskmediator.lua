local var_0_0 = class("BossRushKurskMediator", import("view.base.ContextMediator"))

var_0_0.ON_FLEET_SELECT = "BossRushKurskMediator:ON_FLEET_SELECT"
var_0_0.ON_EXTRA_RANK = "BossRushKurskMediator:ON_EXTRA_RANK"
var_0_0.GO_ACT_SHOP = "BossRushKurskMediator:GO_ACT_SHOP"
var_0_0.ON_TASK_SUBMIT = "BossRushKurskMediator:ON_TASK_SUBMIT"
var_0_0.ON_PERFORM_COMBAT = "BossRushKurskMediator:ON_PERFORM_COMBAT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = BossRushFleetSelectMediator,
			viewComponent = BossRushFleetSelectView,
			data = {
				seriesData = arg_2_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_EXTRA_RANK, function(arg_3_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_BOSSRUSH
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_PERFORM_COMBAT, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_4_1,
			exitCallback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_ACT_SHOP, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = PtAwardMediator,
			viewComponent = PtAwardLayer,
			data = {
				ptData = arg_5_1,
				ptId = arg_5_1.resId
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_6_1.id)

		return
	end)
	assert(arg_1_0.contextData.activityID, "activityID is required by BossRushVerZenkerMediator")

	local var_1_0 = getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.activityID)

	arg_1_0.viewComponent:SetActivity(var_1_0)

	local var_1_1 = var_1_0:GetConfigClientSetting("PTID")

	for iter_1_0, iter_1_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF))) do
		if iter_1_1:getDataConfig("pt") == var_1_1 then
			arg_1_0.viewComponent:SetPtActivity(iter_1_1)

			break
		end
	end

	arg_1_0.viewComponent:addbubbleMsgBox(function(arg_7_0)
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushTotalRewardPanelMediator) then
			return
		end

		arg_7_0()

		return
	end)
	arg_1_0.viewComponent:addbubbleMsgBox(function(arg_8_0)
		pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_8_0)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_9_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.BEGIN_STAGE_DONE,
		BossRushTotalRewardPanelMediator.ON_WILL_EXIT
	}
end

function var_0_0.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()
	local var_10_2 = arg_10_1:getType()

	if var_10_0 == nil then
		-- block empty
	elseif var_10_0 == GAME.BEGIN_STAGE_DONE then
		if not getProxy(ContextProxy):getContextByMediator(BossRushPreCombatMediator) then
			arg_10_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_10_1)
		end
	elseif var_10_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_10_1 then
			if var_10_1.id == arg_10_0.viewComponent.activity.id then
				arg_10_0.viewComponent:SetActivity(var_10_1)
				arg_10_0.viewComponent:UpdateView()
			elseif var_10_1.id == arg_10_0.viewComponent.ptActivity.id then
				arg_10_0.viewComponent:SetPtActivity(var_10_1)
				arg_10_0.viewComponent:UpdateView()
			end
		end
	elseif var_10_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_10_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_10_1.awards, function()
			arg_10_0.viewComponent:UpdateTasks(var_10_2)

			return
		end)
	elseif var_10_0 == BossRushTotalRewardPanelMediator.ON_WILL_EXIT then
		arg_10_0.viewComponent:resumeBubble()
		arg_10_0.viewComponent:UpdateView()
	end

	return
end

function var_0_0.remove(arg_12_0)
	return
end

return var_0_0
