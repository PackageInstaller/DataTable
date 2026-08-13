class = var_0_10000

local var_0_0 = "OtherworldMapMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.BossSingle.BossSingleMediatorTemplate"))

var_0_1.ON_EVENT_TRIGGER = "OtherworldMapMediator.ON_EVENT_TRIGGER"

function var_0_1.register(arg_1_0)
	arg_1_0:BindBattleEvents()

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_EVENT_TRIGGER, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.SINGLE_EVENT_TRIGGER, {
			actId = arg_2_1.actId,
			eventId = arg_2_1.eventId
		})

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4

	if var_1_2(var_1_1, var_4.ACTIVITY_TYPE_EVENT_SINGLE) and not var_2:isEnd() then
		local var_1_3 = arg_1_0.viewComponent

		var_3.SetEventAct(var_1_3, var_2)
	else
		local var_1_4 = arg_1_0.viewComponent

		var_3.SetEventAct(var_1_4, nil)
	end

	local var_1_5 = var_1
	local var_1_6 = var_1.getActivityByType

	ActivityConst = var_1_10005

	if not var_1_6(var_1_5, var_1_10005.ACTIVITY_TYPE_LOTTERY) then
		assert = var_1_5

		var_1_5(nil, "not exist lottery act")

		return
	end

	local var_1_7 = var_3:getConfig("config_data")[1]
	local var_1_8 = arg_1_0.contextData

	pg = var_6
	var_1_8.resId = var_6.activity_random_award_template[var_1_7].resource_type

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.BEGIN_STAGE_DONE] = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1:getBody()
		local var_4_1 = arg_4_0.contextData

		var_4_1.editFleet = nil
		getProxy = var_4_1
		ContextProxy = var_4

		local var_4_2 = var_4_1(var_4)
		local var_4_3 = var_3.getContextByMediator

		PreCombatMediator = var_2_10006

		if not var_4_3(var_4_2, var_2_10006) then
			local var_4_4 = arg_4_0
			local var_4_5 = arg_4_0.sendNotification

			GAME = var_2_10006

			local var_4_6 = var_2_10006.GO_SCENE

			SCENE = var_2_10007

			var_4_5(var_4_4, var_4_6, var_2_10007.COMBATLOAD, var_4_0)
		end

		return
	end
	GAME = var_2
	var_3_0[var_2.COMMANDER_ACTIVITY_FORMATION_OP_DONE] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1
		local var_5_1 = arg_5_1.getBody(var_5_0)

		getProxy = var_5_0
		FleetProxy = var_2_10004

		local var_5_2 = var_5_0(var_2_10004)
		local var_5_3 = var_3.getActivityFleets(var_5_2)[var_5_1.actId]

		arg_5_0.contextData.actFleets = var_5_3

		local var_5_4 = arg_5_0.viewComponent

		var_4.updateEditPanel(var_5_4)

		local var_5_5 = arg_5_0.viewComponent

		var_4.updateCommanderFleet(var_5_5, var_5_3[var_5_1.fleetId])

		return
	end
	CommanderProxy = var_2
	var_3_0[var_2.PREFAB_FLEET_UPDATE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1
		local var_6_1 = arg_6_1.getBody(var_6_0)

		getProxy = var_6_0
		CommanderProxy = var_2_10004

		local var_6_2 = var_6_0(var_2_10004)
		local var_6_3 = var_3.getPrefabFleet(var_6_2)
		local var_6_4 = arg_6_0.viewComponent

		var_4.setCommanderPrefabs(var_6_4, var_6_3)

		local var_6_5 = arg_6_0.viewComponent

		var_4.updateCommanderPrefab(var_6_5)

		return
	end
	PlayerProxy = var_2
	var_3_0[var_2.UPDATED] = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.viewComponent

		var_2.UpdateRes(var_7_0)

		local var_7_1 = arg_7_0.viewComponent

		var_2.UpdateWangduBtn(var_7_1)

		return
	end
	ActivityProxy = var_2
	var_3_0[var_2.ACTIVITY_UPDATED] = function(arg_8_0, arg_8_1)
		if arg_8_1:getBody() then
			var_2_10004 = var_2

			if var_2.isEnd(var_2_10004) then
				return
			end

			local var_8_0 = var_2.id

			ActivityConst = var_2_10004

			if var_8_0 == var_2_10004.OTHER_WORLD_TERMINAL_PT_ID then
				local var_8_1 = arg_8_0.viewComponent

				var_3.UpdateTerminalTip(var_8_1)
			end

			return
		end
	end
	GAME = var_2
	var_3_0[var_2.SINGLE_EVENT_TRIGGER_DONE] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1:getBody()
		local var_9_1 = {}

		if #var_9_0.awards > 0 then
			table = var_4

			var_4.insert(var_9_1, function(arg_10_0)
				local var_10_0 = arg_9_0.viewComponent
				local var_10_1 = var_1.emit

				BaseUI = var_3_10003

				var_10_1(var_10_0, var_3_10003.ON_ACHIEVE, var_9_0.awards, arg_10_0)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_9_1, function()
			local var_11_0 = arg_9_0.viewComponent

			var_0.SetEventAct(var_11_0, var_9_0.activity)

			local var_11_1 = arg_9_0.viewComponent

			var_0.UpdateEvents(var_11_1, var_9_0.eventId)

			return
		end)

		return
	end
	GAME = var_2
	var_3_0[var_2.SINGLE_EVENT_REFRESH_DONE] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1:getBody()
		local var_12_1 = arg_12_0.viewComponent

		var_3.SetEventAct(var_12_1, var_12_0.activity)

		local var_12_2 = arg_12_0.viewComponent

		var_3.UpdateEvents(var_12_2)

		return
	end
	GAME = var_2
	var_3_0[var_2.ACT_NEW_PT_DONE] = function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1:getBody()
		local var_13_1 = arg_13_0.viewComponent

		var_3.UpdateTerminalTip(var_13_1)

		return
	end
	AvatarFrameProxy = var_2
	var_3_0[var_2.FRAME_TASK_UPDATED] = function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.viewComponent

		var_2.UpdateWangduBtn(var_14_0)

		return
	end
	AvatarFrameProxy = var_2
	var_3_0[var_2.FRAME_TASK_TIME_OUT] = function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0.viewComponent

		var_2.UpdateWangduBtn(var_15_0)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

function var_0_1.remove(arg_16_0)
	return
end

return var_0_1
