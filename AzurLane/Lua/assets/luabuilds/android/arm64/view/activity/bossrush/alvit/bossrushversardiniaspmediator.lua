local var_0_0 = class("BossRushVerSardiniaSPMediator", import("view.base.ContextMediator"))

var_0_0.ON_FLEET_SELECT = "BossRushVerSardiniaSPMediator.ON_FLEET_SELECT"
var_0_0.ON_EXTRA_RANK = "BossRushVerSardiniaSPMediator.ON_EXTRA_RANK"
var_0_0.ON_TASK_SUBMIT = "BossRushVerSardiniaSPMediator.ON_TASK_SUBMIT"
var_0_0.ON_PERFORM_COMBAT = "BossRushVerSardiniaSPMediator.ON_PERFORM_COMBAT"
var_0_0.ON_ACTIVITY_UNLOCKSTOIRY = "BossRushVerSardiniaSPMediator.ON_ACTIVITY_UNLOCKSTOIRY"
var_0_0.GO_SUBLAYER = "BossRushVerSardiniaSPMediator.GO_SUBLAYER"
var_0_0.GO_SCENE = "BossRushVerSardiniaSPMediator.GO_SCENE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_ACTIVITY_UNLOCKSTOIRY, function(arg_2_0, arg_2_1, arg_2_2)
		pg.m02:sendNotification(GAME.ACTIVITY_UNLOCKSTORY, {
			cmd = 1,
			activity_id = arg_2_1,
			arg1 = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_4_0, arg_4_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_4_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.ON_FLEET_SELECT, function(arg_5_0, arg_5_1)
		BossRushVerZenkerPassedLayer.seriesId = arg_5_1.configId

		arg_1_0:addSubLayers(Context.New({
			mediator = BossRushFleetSelectMediator,
			viewComponent = BossRushSardiniaFleetSelectView,
			data = {
				seriesData = arg_5_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_EXTRA_RANK, function(arg_6_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_BOSSRUSH
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_PERFORM_COMBAT, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_7_1,
			exitCallback = arg_7_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_8_1.id)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy)
	local var_1_1 = var_1_0:getActivityById(arg_1_0.contextData.activityID)

	arg_1_0.viewComponent:SetActivity(var_1_1)

	local var_1_2 = var_1_1:GetConfigClientSetting("activity_ids")

	arg_1_0.contextData.activityStoryID = var_1_2.story

	arg_1_0.viewComponent:SetStoryActivity((var_1_0:getActivityById(arg_1_0.contextData.activityStoryID)))

	arg_1_0.contextData.activityPTID = var_1_2.pt

	arg_1_0.viewComponent:SetPtActivity((var_1_0:getActivityById(arg_1_0.contextData.activityPTID)))

	arg_1_0.contextData.activityTaskID = var_1_2.tasks

	arg_1_0.viewComponent:SetTasksActivity((var_1_0:getActivityById(arg_1_0.contextData.activityTaskID)))
	arg_1_0.viewComponent:addbubbleMsgBox(function(arg_9_0)
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushTotalRewardPanelMediator) then
			return
		end

		arg_9_0()

		return
	end)
	arg_1_0.viewComponent:addbubbleMsgBox(function(arg_10_0)
		pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_10_0)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_11_0)
	return {
		GAME.ACTIVITY_STORYUNLOCKED_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_AWARD_DOWN,
		GAME.BEGIN_STAGE_DONE,
		BossRushTotalRewardPanelMediator.ON_WILL_EXIT
	}
end

function var_0_0.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()
	local var_12_2 = arg_12_1:getType()

	if var_12_0 == GAME.ACTIVITY_STORYUNLOCKED_DONE then
		arg_12_0.viewComponent:UpdataStoryState(var_12_1.storyId)
	elseif var_12_0 == GAME.BEGIN_STAGE_DONE then
		if not getProxy(ContextProxy):getContextByMediator(BossRushPreCombatMediator) then
			arg_12_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_12_1)
		end
	elseif var_12_0 == ActivityProxy.ACTIVITY_UPDATED then
		switch(var_12_1.id, {
			[arg_12_0.contextData.activityID] = function()
				arg_12_0.viewComponent:SetActivity(var_0)
				arg_12_0.viewComponent:UpdateView()

				return
			end,
			[arg_12_0.contextData.activityPTID] = function()
				arg_12_0.viewComponent:SetPtActivity(var_0)
				arg_12_0.viewComponent:UpdateView()

				return
			end,
			[arg_12_0.contextData.activityStoryID] = function()
				arg_12_0.viewComponent:SetStoryActivity(var_0)

				return
			end
		})
	elseif var_12_0 == GAME.SUBMIT_TASK_AWARD_DOWN then
		if #var_12_1.awards > 0 then
			table.insert({}, function(arg_16_0)
				arg_12_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_12_1.awards, arg_16_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_12_0.viewComponent:UpdateView()

			return
		end)
	elseif var_12_0 == BossRushTotalRewardPanelMediator.ON_WILL_EXIT then
		arg_12_0.contextData.showFlash = true

		arg_12_0.viewComponent:resumeBubble()
		arg_12_0.viewComponent:UpdateView()
	end

	return
end

function var_0_0.remove(arg_18_0)
	return
end

return var_0_0
