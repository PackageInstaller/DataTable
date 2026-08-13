class = var_0_10000

local var_0_0 = "BossRushEscapeManorMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_FLEET_SELECT = "BossRushEscapeManorMediator.ON_FLEET_SELECT"
var_0_1.ON_EXTRA_RANK = "BossRushEscapeManorMediator.ON_EXTRA_RANK"
var_0_1.ON_TASK_SUBMIT = "BossRushEscapeManorMediator.ON_TASK_SUBMIT"
var_0_1.ON_PERFORM_COMBAT = "BossRushEscapeManorMediator.ON_PERFORM_COMBAT"
var_0_1.GO_SUBLAYER = "BossRushEscapeManorMediator.GO_SUBLAYER"
var_0_1.GO_SCENE = "BossRushEscapeManorMediator.GO_SCENE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_SUBLAYER, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.addSubLayers(var_2_0, arg_2_1, nil, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.ON_FLEET_SELECT, function(arg_4_0, arg_4_1)
		BossRushEscapeManorPassedLayer = var_2_10002
		var_2_10002.seriesId = arg_4_1.configId

		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		BossRushFleetSelectMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		BossRushEscapeManorFleetSelectView = var_2_10008
		var_4_3.viewComponent = var_2_10008
		var_4_3.data = {
			seriesData = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXTRA_RANK, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_5_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_5_3 = var_2_10005.BILLBOARD
		local var_5_4 = {}

		PowerRank = var_2_10007
		var_5_4.page = var_2_10007.TYPE_BOSSRUSH

		var_5_1(var_5_0, var_5_2, var_5_3, var_5_4)

		return
	end)
	arg_1_0:bind(var_0_1.ON_PERFORM_COMBAT, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_6_2 = var_2_10006.BEGIN_STAGE
		local var_6_3 = {}

		SYSTEM_PERFORM = var_2_10008
		var_6_3.system = var_2_10008
		var_6_3.stageId = arg_6_1
		var_6_3.exitCallback = arg_6_2

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.SUBMIT_TASK, arg_7_1.id)

		return
	end)

	local var_1_0 = arg_1_0.contextData.activityID

	assert = var_1_10002

	var_1_10002(var_1_0, "activityID is required by BossRushVerZenkerMediator")

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_1_1 = var_1_10002(var_4)
	local var_1_2 = var_2.getActivityById(var_1_1, var_1_0)
	local var_1_3 = arg_1_0.viewComponent

	var_3.SetActivity(var_1_3, var_1_2)

	getProxy = var_3
	ActivityProxy = var_1_3

	local var_1_4 = var_3(var_1_3)
	local var_1_5 = var_3.getActivityById

	ActivityConst = var_6

	local var_1_6 = var_1_5(var_1_4, var_6.ESCAPE_BOSS_RUSH_PT_ID)
	local var_1_7 = arg_1_0.viewComponent

	var_4.SetPtActivity(var_1_7, var_1_6)

	local var_1_8 = arg_1_0.viewComponent

	var_4.addbubbleMsgBox(var_1_8, function(arg_8_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10003

		local var_8_0 = var_2_10001(var_2_10003)
		local var_8_1 = var_1.getCurrentContext(var_8_0)
		local var_8_2 = var_1.getContextByMediator

		BossRushTotalRewardPanelMediator = var_2_10004

		if var_8_2(var_8_1, var_2_10004) then
			return
		end

		arg_8_0()

		return
	end)

	local var_1_9 = arg_1_0.viewComponent

	var_4.addbubbleMsgBox(var_1_9, function(arg_9_0)
		pg = var_2_10001

		local var_9_0 = var_2_10001.GuildMsgBoxMgr.GetInstance()

		var_1.NotificationForBattle(var_9_0, arg_9_0)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	ActivityProxy = var_1_10002
	var_10_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_10_0[2] = var_2.SUBMIT_TASK_AWARD_DOWN
	GAME = var_2
	var_10_0[3] = var_2.BEGIN_STAGE_DONE
	BossRushTotalRewardPanelMediator = var_2
	var_10_0[4] = var_2.ON_WILL_EXIT

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1
	local var_11_2 = arg_11_1.getBody(var_11_1)
	local var_11_3 = arg_11_1:getType()

	if var_11_0 == nil then
		-- block empty
	else
		GAME = var_11_1

		local var_11_4

		if var_11_0 == var_11_1.BEGIN_STAGE_DONE then
			getProxy = var_11_4
			ContextProxy = var_1_10007
			var_1_10007 = var_11_4(var_1_10007)
			var_11_4 = var_11_4.getContextByMediator
			BossRushPreCombatMediator = var_1_10008

			if not var_11_4(var_1_10007, var_1_10008) then
				local var_11_5 = arg_11_0
				local var_11_6 = arg_11_0.sendNotification

				GAME = var_1_10009

				local var_11_7 = var_1_10009.GO_SCENE

				SCENE = var_1_10010

				var_11_6(var_11_5, var_11_7, var_1_10010.COMBATLOAD, var_11_2)
			end
		else
			ActivityProxy = var_11_4

			if var_11_0 == var_11_4.ACTIVITY_UPDATED then
				if var_11_2 then
					local var_11_8 = var_5:getConfig("type")

					ActivityConst = var_1_10007

					if var_11_8 == var_1_10007.ACTIVITY_TYPE_BOSSRUSH then
						local var_11_9 = arg_11_0.viewComponent

						var_6.SetActivity(var_11_9, var_5)

						local var_11_10 = arg_11_0.viewComponent

						var_6.UpdateView(var_11_10)
					else
						local var_11_11 = var_5.id

						ActivityConst = var_7

						if var_11_11 == var_7.ESCAPE_BOSS_RUSH_PT_ID then
							local var_11_12 = arg_11_0.viewComponent

							var_6.SetPtActivity(var_11_12, var_5)

							local var_11_13 = arg_11_0.viewComponent

							var_6.UpdateView(var_11_13)
						end
					end
				end
			else
				GAME = var_5

				local var_11_14

				if var_11_0 == var_5.SUBMIT_TASK_AWARD_DOWN then
					var_11_14 = {}

					if #var_11_2.awards > 0 then
						table = var_6

						var_6.insert(var_11_14, function(arg_12_0)
							local var_12_0 = arg_11_0.viewComponent
							local var_12_1 = var_1.emit

							BaseUI = var_2_10004

							var_12_1(var_12_0, var_2_10004.ON_ACHIEVE, var_11_2.awards, arg_12_0)

							return
						end)
					end

					seriesAsync = var_6

					var_6(var_11_14, function()
						local var_13_0 = arg_11_0.viewComponent

						var_0.UpdateView(var_13_0)

						return
					end)
				else
					BossRushTotalRewardPanelMediator = var_11_14

					if var_11_0 == var_11_14.ON_WILL_EXIT then
						local var_11_15 = arg_11_0.viewComponent

						var_5.resumeBubble(var_11_15)

						local var_11_16 = arg_11_0.viewComponent

						var_5.UpdateView(var_11_16)
					end
				end
			end
		end
	end

	return
end

function var_0_1.remove(arg_14_0)
	return
end

return var_0_1
