class = var_0_10000

local var_0_0 = "BossRushKurskMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_FLEET_SELECT = "BossRushKurskMediator:ON_FLEET_SELECT"
var_0_1.ON_EXTRA_RANK = "BossRushKurskMediator:ON_EXTRA_RANK"
var_0_1.GO_ACT_SHOP = "BossRushKurskMediator:GO_ACT_SHOP"
var_0_1.ON_TASK_SUBMIT = "BossRushKurskMediator:ON_TASK_SUBMIT"
var_0_1.ON_PERFORM_COMBAT = "BossRushKurskMediator:ON_PERFORM_COMBAT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		BossRushFleetSelectMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		BossRushFleetSelectView = var_2_10006
		var_2_3.viewComponent = var_2_10006
		var_2_3.data = {
			seriesData = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXTRA_RANK, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_3_3 = var_2_10004.BILLBOARD
		local var_3_4 = {}

		PowerRank = var_2_10006
		var_3_4.page = var_2_10006.TYPE_BOSSRUSH

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end)
	arg_1_0:bind(var_0_1.ON_PERFORM_COMBAT, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.BEGIN_STAGE
		local var_4_3 = {}

		SYSTEM_PERFORM = var_2_10007
		var_4_3.system = var_2_10007
		var_4_3.stageId = arg_4_1
		var_4_3.exitCallback = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.GO_ACT_SHOP, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		PtAwardMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		PtAwardLayer = var_2_10006
		var_5_3.viewComponent = var_2_10006
		var_5_3.data = {
			ptData = arg_5_1,
			ptId = arg_5_1.resId
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_TASK_SUBMIT, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.SUBMIT_TASK, arg_6_1.id)

		return
	end)

	local var_1_1 = arg_1_0.contextData.activityID

	assert = var_1_0

	var_1_0(var_1_1, "activityID is required by BossRushVerZenkerMediator")

	getProxy = var_1_0
	ActivityProxy = var_3

	local var_1_2 = var_1_0(var_3)
	local var_1_3 = var_2.getActivityById(var_1_2, var_1_1)
	local var_1_4 = arg_1_0.viewComponent

	var_3.SetActivity(var_1_4, var_1_3)

	local var_1_5 = var_1_3
	local var_1_6 = var_1_3.GetConfigClientSetting(var_1_5, "PTID")

	getProxy = var_1_5
	ActivityProxy = var_5

	local var_1_7 = var_1_5(var_5)
	local var_1_8 = var_4.getActivitiesByType

	ActivityConst = var_1_10006

	local var_1_9 = var_1_8(var_1_7, var_1_10006.ACTIVITY_TYPE_PT_BUFF)

	ipairs = var_1_7

	for iter_1_0, iter_1_1 in var_1_7(var_1_9) do
		if iter_1_1:getDataConfig("pt") == var_1_6 then
			local var_1_10 = arg_1_0.viewComponent

			var_10.SetPtActivity(var_1_10, iter_1_1)

			break
		end
	end

	local var_1_11 = arg_1_0.viewComponent

	var_5.addbubbleMsgBox(var_1_11, function(arg_7_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10002

		local var_7_0 = var_2_10001(var_2_10002)
		local var_7_1 = var_1.getCurrentContext(var_7_0)
		local var_7_2 = var_1.getContextByMediator

		BossRushTotalRewardPanelMediator = var_2_10003

		if var_7_2(var_7_1, var_2_10003) then
			return
		end

		arg_7_0()

		return
	end)

	local var_1_12 = arg_1_0.viewComponent

	var_5.addbubbleMsgBox(var_1_12, function(arg_8_0)
		pg = var_2_10001

		local var_8_0 = var_2_10001.GuildMsgBoxMgr.GetInstance()

		var_1.NotificationForBattle(var_8_0, arg_8_0)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	ActivityProxy = var_1_10002
	var_9_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_9_0[2] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_9_0[3] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	GAME = var_2
	var_9_0[4] = var_2.BEGIN_STAGE_DONE
	BossRushTotalRewardPanelMediator = var_2
	var_9_0[5] = var_2.ON_WILL_EXIT

	return var_9_0
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()
	local var_10_2 = arg_10_1
	local var_10_3 = arg_10_1.getType(var_10_2)

	if var_10_0 == nil then
		-- block empty
	else
		GAME = var_10_2

		local var_10_5

		if var_10_0 == var_10_2.BEGIN_STAGE_DONE then
			getProxy = var_10_5
			ContextProxy = var_1_10006

			local var_10_4 = var_10_5(var_1_10006)

			var_10_5 = var_10_5.getContextByMediator
			BossRushPreCombatMediator = var_1_10007

			if not var_10_5(var_10_4, var_1_10007) then
				var_1_10007 = arg_10_0

				local var_10_6 = arg_10_0.sendNotification

				GAME = var_1_10008

				local var_10_7 = var_1_10008.GO_SCENE

				SCENE = var_1_10009

				var_10_6(var_1_10007, var_10_7, var_1_10009.COMBATLOAD, var_10_1)
			end
		else
			ActivityProxy = var_10_5

			if var_10_0 == var_10_5.ACTIVITY_UPDATED then
				if var_10_1 then
					if var_5.id == arg_10_0.viewComponent.activity.id then
						var_1_10007 = arg_10_0.viewComponent

						var_6.SetActivity(var_1_10007, var_5)

						var_1_10007 = arg_10_0.viewComponent

						var_6.UpdateView(var_1_10007)
					elseif var_5.id == arg_10_0.viewComponent.ptActivity.id then
						var_1_10007 = arg_10_0.viewComponent

						var_6.SetPtActivity(var_1_10007, var_5)

						var_1_10007 = arg_10_0.viewComponent

						var_6.UpdateView(var_1_10007)
					end
				end
			else
				GAME = var_5

				local var_10_9

				if var_10_0 == var_5.SUBMIT_ACTIVITY_TASK_DONE then
					local var_10_8 = arg_10_0.viewComponent

					var_10_9 = var_10_9.emit
					BaseUI = var_1_10007

					var_10_9(var_10_8, var_1_10007.ON_ACHIEVE, var_10_1.awards, function()
						local var_11_0 = arg_10_0.viewComponent

						var_0.UpdateTasks(var_11_0, var_10_3)

						return
					end)
				else
					BossRushTotalRewardPanelMediator = var_10_9

					if var_10_0 == var_10_9.ON_WILL_EXIT then
						local var_10_10 = arg_10_0.viewComponent

						var_5.resumeBubble(var_10_10)

						local var_10_11 = arg_10_0.viewComponent

						var_5.UpdateView(var_10_11)
					end
				end
			end
		end
	end

	return
end

function var_0_1.remove(arg_12_0)
	return
end

return var_0_1
