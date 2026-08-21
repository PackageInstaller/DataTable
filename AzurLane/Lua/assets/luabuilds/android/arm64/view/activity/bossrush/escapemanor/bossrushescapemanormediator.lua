local var_0_0 = class("BossRushEscapeManorMediator", import("view.base.ContextMediator"))

var_0_0.ON_FLEET_SELECT = "BossRushEscapeManorMediator.ON_FLEET_SELECT"
var_0_0.ON_EXTRA_RANK = "BossRushEscapeManorMediator.ON_EXTRA_RANK"
var_0_0.ON_TASK_SUBMIT = "BossRushEscapeManorMediator.ON_TASK_SUBMIT"
var_0_0.ON_PERFORM_COMBAT = "BossRushEscapeManorMediator.ON_PERFORM_COMBAT"
var_0_0.GO_SUBLAYER = "BossRushEscapeManorMediator.GO_SUBLAYER"
var_0_0.GO_SCENE = "BossRushEscapeManorMediator.GO_SCENE"

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
		BossRushEscapeManorPassedLayer.seriesId = arg_4_1.configId

		arg_1_0:addSubLayers(Context.New({
			mediator = BossRushFleetSelectMediator,
			viewComponent = BossRushEscapeManorFleetSelectView,
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
	assert(arg_1_0.contextData.activityID, "activityID is required by BossRushVerZenkerMediator")
	arg_1_0.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.activityID)))
	arg_1_0.viewComponent:SetPtActivity((getProxy(ActivityProxy):getActivityById(ActivityConst.ESCAPE_BOSS_RUSH_PT_ID)))
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
		GAME.SUBMIT_TASK_AWARD_DOWN,
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
			if var_11_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSSRUSH then
				arg_11_0.viewComponent:SetActivity(var_11_1)
				arg_11_0.viewComponent:UpdateView()
			elseif var_11_1.id == ActivityConst.ESCAPE_BOSS_RUSH_PT_ID then
				arg_11_0.viewComponent:SetPtActivity(var_11_1)
				arg_11_0.viewComponent:UpdateView()
			end
		end
	elseif var_11_0 == GAME.SUBMIT_TASK_AWARD_DOWN then
		if #var_11_1.awards > 0 then
			table.insert({}, function(arg_12_0)
				arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards, arg_12_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_11_0.viewComponent:UpdateView()

			return
		end)
	elseif var_11_0 == BossRushTotalRewardPanelMediator.ON_WILL_EXIT then
		arg_11_0.viewComponent:resumeBubble()
		arg_11_0.viewComponent:UpdateView()
	end

	return
end

function var_0_0.remove(arg_14_0)
	return
end

return var_0_0
