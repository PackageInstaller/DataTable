local var_0_0 = class("BossRushAlvitMediator", import("view.base.ContextMediator"))

var_0_0.ON_FLEET_SELECT = "BossRushAlvitMediator:ON_FLEET_SELECT"
var_0_0.ON_EXTRA_RANK = "BossRushAlvitMediator:ON_EXTRA_RANK"
var_0_0.ON_TASK_SUBMIT = "BossRushAlvitMediator:ON_TASK_SUBMIT"
var_0_0.ON_PERFORM_COMBAT = "BossRushAlvitMediator:ON_PERFORM_COMBAT"
var_0_0.GO_SUBLAYER = "BossRushAlvitMediator:GO_SUBLAYER"
var_0_0.GO_SCENE = "BossRushAlvitMediator:GO_SCENE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_SUBLAYER, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:addSubLayers(arg_2_1, nil, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.ON_FLEET_SELECT, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = BossRushFleetSelectMediator,
			viewComponent = BossRushAlvitFleetSelectView,
			data = {
				seriesData = arg_4_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_EXTRA_RANK, function(arg_5_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_BOSSRUSH
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_PERFORM_COMBAT, function(arg_6_0, arg_6_1, arg_6_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_6_1,
			exitCallback = arg_6_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_7_1.id)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy)

	assert(arg_1_0.contextData.activityID, "activityID is required by BossRushVerZenkerMediator")

	local var_1_1 = var_1_0:getActivityById(arg_1_0.contextData.activityID)

	arg_1_0.viewComponent:SetActivity(var_1_1)
	arg_1_0.viewComponent:SetActivity(var_1_1)
	arg_1_0.viewComponent:SetPtActivity((var_1_0:getActivityById(ActivityConst.ALVIT_PT_ACT_ID)))
	arg_1_0.viewComponent:addbubbleMsgBox(function(arg_8_0)
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushTotalRewardPanelMediator) then
			return
		end

		arg_8_0()

		return
	end)
	arg_1_0.viewComponent:addbubbleMsgBox(function(arg_9_0)
		pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_9_0)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_10_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.BEGIN_STAGE_DONE,
		BossRushTotalRewardPanelMediator.ON_WILL_EXIT
	}
end

function var_0_0.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()
	local var_11_2 = arg_11_1:getType()

	if var_11_0 == nil then
		-- block empty
	elseif var_11_0 == GAME.BEGIN_STAGE_DONE then
		if not getProxy(ContextProxy):getContextByMediator(BossRushPreCombatMediator) then
			arg_11_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_11_1)
		end
	elseif var_11_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_11_1 then
			if var_11_1.id == arg_11_0.contextData.activityID then
				arg_11_0.viewComponent:SetActivity(var_11_1)
				arg_11_0.viewComponent:UpdateView()
			elseif var_11_1.id == ActivityConst.ALVIT_PT_ACT_ID then
				arg_11_0.viewComponent:SetPtActivity(var_11_1)
				arg_11_0.viewComponent:UpdateView()
			end
		end
	elseif var_11_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ChildishnessSchoolTaskMediator) then
			arg_11_0.viewComponent:UpdateTaskTip()
		else
			arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards, function()
				arg_11_0.viewComponent:UpdateStoryTask()
				arg_11_0.viewComponent:UpdateView()

				return
			end)
		end
	elseif var_11_0 == BossRushTotalRewardPanelMediator.ON_WILL_EXIT then
		arg_11_0.viewComponent:resumeBubble()
		arg_11_0.viewComponent:UpdateView()
	end

	return
end

function var_0_0.remove(arg_13_0)
	return
end

return var_0_0
