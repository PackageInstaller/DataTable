class = var_0_10000

local var_0_0 = "BossRushVerSardiniaSPMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_FLEET_SELECT = "BossRushVerSardiniaSPMediator.ON_FLEET_SELECT"
var_0_1.ON_EXTRA_RANK = "BossRushVerSardiniaSPMediator.ON_EXTRA_RANK"
var_0_1.ON_TASK_SUBMIT = "BossRushVerSardiniaSPMediator.ON_TASK_SUBMIT"
var_0_1.ON_PERFORM_COMBAT = "BossRushVerSardiniaSPMediator.ON_PERFORM_COMBAT"
var_0_1.ON_ACTIVITY_UNLOCKSTOIRY = "BossRushVerSardiniaSPMediator.ON_ACTIVITY_UNLOCKSTOIRY"
var_0_1.GO_SUBLAYER = "BossRushVerSardiniaSPMediator.GO_SUBLAYER"
var_0_1.GO_SCENE = "BossRushVerSardiniaSPMediator.GO_SCENE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_ACTIVITY_UNLOCKSTOIRY, function(arg_2_0, arg_2_1, arg_2_2)
		pg = var_2_10003

		local var_2_0 = var_2_10003.m02
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.ACTIVITY_UNLOCKSTORY, {
			cmd = 1,
			activity_id = arg_2_1,
			arg1 = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0

		var_3.addSubLayers(var_3_0, arg_3_1, nil, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_4_0, arg_4_1, ...)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.GO_SCENE, arg_4_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.ON_FLEET_SELECT, function(arg_5_0, arg_5_1)
		BossRushVerZenkerPassedLayer = var_2_10002
		var_2_10002.seriesId = arg_5_1.configId

		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		BossRushFleetSelectMediator = var_2_10008
		var_5_3.mediator = var_2_10008
		BossRushSardiniaFleetSelectView = var_2_10008
		var_5_3.viewComponent = var_2_10008
		var_5_3.data = {
			seriesData = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXTRA_RANK, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_6_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_6_3 = var_2_10005.BILLBOARD
		local var_6_4 = {}

		PowerRank = var_2_10007
		var_6_4.page = var_2_10007.TYPE_BOSSRUSH

		var_6_1(var_6_0, var_6_2, var_6_3, var_6_4)

		return
	end)
	arg_1_0:bind(var_0_1.ON_PERFORM_COMBAT, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_7_2 = var_2_10006.BEGIN_STAGE
		local var_7_3 = {}

		SYSTEM_PERFORM = var_2_10008
		var_7_3.system = var_2_10008
		var_7_3.stageId = arg_7_1
		var_7_3.exitCallback = arg_7_2

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_TASK_SUBMIT, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.SUBMIT_TASK, arg_8_1.id)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityById(var_1_1, arg_1_0.contextData.activityID)
	local var_1_3 = arg_1_0.viewComponent

	var_3.SetActivity(var_1_3, var_1_2)

	local var_1_4 = var_1_2:GetConfigClientSetting("activity_ids")

	arg_1_0.contextData.activityStoryID = var_1_4.story

	local var_1_5 = var_1:getActivityById(arg_1_0.contextData.activityStoryID)
	local var_1_6 = arg_1_0.viewComponent

	var_5.SetStoryActivity(var_1_6, var_1_5)

	arg_1_0.contextData.activityPTID = var_1_4.pt

	local var_1_7 = var_1:getActivityById(arg_1_0.contextData.activityPTID)
	local var_1_8 = arg_1_0.viewComponent

	var_6.SetPtActivity(var_1_8, var_1_7)

	arg_1_0.contextData.activityTaskID = var_1_4.tasks

	local var_1_9 = var_1:getActivityById(arg_1_0.contextData.activityTaskID)
	local var_1_10 = arg_1_0.viewComponent

	var_7.SetTasksActivity(var_1_10, var_1_9)

	local var_1_11 = arg_1_0.viewComponent

	var_7.addbubbleMsgBox(var_1_11, function(arg_9_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10003

		local var_9_0 = var_2_10001(var_2_10003)
		local var_9_1 = var_1.getCurrentContext(var_9_0)
		local var_9_2 = var_1.getContextByMediator

		BossRushTotalRewardPanelMediator = var_2_10004

		if var_9_2(var_9_1, var_2_10004) then
			return
		end

		arg_9_0()

		return
	end)

	local var_1_12 = arg_1_0.viewComponent

	var_7.addbubbleMsgBox(var_1_12, function(arg_10_0)
		pg = var_2_10001

		local var_10_0 = var_2_10001.GuildMsgBoxMgr.GetInstance()

		var_1.NotificationForBattle(var_10_0, arg_10_0)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_11_0)
	local var_11_0 = {}

	GAME = var_1_10002
	var_11_0[1] = var_1_10002.ACTIVITY_STORYUNLOCKED_DONE
	ActivityProxy = var_2
	var_11_0[2] = var_2.ACTIVITY_UPDATED
	GAME = var_2
	var_11_0[3] = var_2.SUBMIT_TASK_AWARD_DOWN
	GAME = var_2
	var_11_0[4] = var_2.BEGIN_STAGE_DONE
	BossRushTotalRewardPanelMediator = var_2
	var_11_0[5] = var_2.ON_WILL_EXIT

	return var_11_0
end

function var_0_1.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1
	local var_12_2 = arg_12_1.getBody(var_12_1)
	local var_12_3 = arg_12_1
	local var_12_4 = arg_12_1.getType(var_12_3)

	GAME = var_12_1

	if var_12_0 == var_12_1.ACTIVITY_STORYUNLOCKED_DONE then
		var_1_10007 = arg_12_0.viewComponent

		var_5.UpdataStoryState(var_1_10007, var_12_2.storyId)
	else
		GAME = var_5

		local var_12_6

		if var_12_0 == var_5.BEGIN_STAGE_DONE then
			getProxy = var_12_6
			ContextProxy = var_1_10007

			local var_12_5 = var_12_6(var_1_10007)

			var_12_6 = var_12_6.getContextByMediator
			BossRushPreCombatMediator = var_1_10008

			if not var_12_6(var_12_5, var_1_10008) then
				local var_12_7 = arg_12_0

				var_12_3 = arg_12_0.sendNotification
				GAME = var_1_10009

				local var_12_8 = var_1_10009.GO_SCENE

				SCENE = var_1_10010

				var_12_3(var_12_7, var_12_8, var_1_10010.COMBATLOAD, var_12_2)
			end
		else
			ActivityProxy = var_12_6

			local var_12_9

			if var_12_0 == var_12_6.ACTIVITY_UPDATED then
				var_12_9 = var_12_2
				switch = var_12_3

				var_12_3(var_12_9.id, {
					[arg_12_0.contextData.activityID] = function()
						local var_13_0 = arg_12_0.viewComponent

						var_0.SetActivity(var_13_0, var_12_9)

						local var_13_1 = arg_12_0.viewComponent

						var_0.UpdateView(var_13_1)

						return
					end,
					[arg_12_0.contextData.activityPTID] = function()
						local var_14_0 = arg_12_0.viewComponent

						var_0.SetPtActivity(var_14_0, var_12_9)

						local var_14_1 = arg_12_0.viewComponent

						var_0.UpdateView(var_14_1)

						return
					end,
					[arg_12_0.contextData.activityStoryID] = function()
						local var_15_0 = arg_12_0.viewComponent

						var_0.SetStoryActivity(var_15_0, var_12_9)

						return
					end
				})
			else
				GAME = var_12_9

				local var_12_10

				if var_12_0 == var_12_9.SUBMIT_TASK_AWARD_DOWN then
					var_12_10 = {}

					if #var_12_2.awards > 0 then
						table = var_6

						var_6.insert(var_12_10, function(arg_16_0)
							local var_16_0 = arg_12_0.viewComponent
							local var_16_1 = var_1.emit

							BaseUI = var_2_10004

							var_16_1(var_16_0, var_2_10004.ON_ACHIEVE, var_12_2.awards, arg_16_0)

							return
						end)
					end

					seriesAsync = var_6

					var_6(var_12_10, function()
						local var_17_0 = arg_12_0.viewComponent

						var_0.UpdateView(var_17_0)

						return
					end)
				else
					BossRushTotalRewardPanelMediator = var_12_10

					if var_12_0 == var_12_10.ON_WILL_EXIT then
						arg_12_0.contextData.showFlash = true

						local var_12_11 = arg_12_0.viewComponent

						var_5.resumeBubble(var_12_11)

						local var_12_12 = arg_12_0.viewComponent

						var_5.UpdateView(var_12_12)
					end
				end
			end
		end
	end

	return
end

function var_0_1.remove(arg_18_0)
	return
end

return var_0_1
