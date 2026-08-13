class = var_0_10000

local var_0_0 = "VoteEntranceMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_VOTE = "VoteEntranceMediator:ON_VOTE"
var_0_1.ON_FUN_VOTE = "VoteEntranceMediator:ON_FUN_VOTE"
var_0_1.ON_EXCHANGE = "VoteEntranceMediator:ON_EXCHANGE"
var_0_1.ON_SCHEDULE = "VoteEntranceMediator:ON_SCHEDULE"
var_0_1.GO_HALL = "VoteEntranceMediator:GO_HALL"
var_0_1.SUBMIT_TASK = "VoteEntranceMediator:SUBMIT_TASK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SUBMIT_TASK, function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_2_0 = var_2_10000(var_2_10001)
		local var_2_1 = var_0.getActivityById

		ActivityConst = var_2_10002

		if not var_2_1(var_2_0, var_2_10002.VOTE_ENTRANCE_ACT_ID) or var_0:isEnd() then
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n = var_2_10003

			var_2_3(var_2_2, var_2_10003("common_activity_notStartOrEnd"))

			return
		end

		local var_2_4 = var_0:getConfig("config_client")[2]
		local var_2_5 = arg_1_0
		local var_2_6 = var_2.sendNotification

		GAME = var_2_10004

		var_2_6(var_2_5, var_2_10004.SUBMIT_TASK, var_2_4)

		return
	end)
	arg_1_0:bind(var_0_1.ON_VOTE, function()
		getProxy = var_2_10000
		VoteProxy = var_2_10001

		local var_3_0 = var_2_10000(var_2_10001)

		if not var_0.GetOpeningNonFunVoteGroup(var_3_0) then
			pg = var_3_0

			local var_3_1 = var_3_0.TipsMgr.GetInstance()
			local var_3_2 = var_1.ShowTips

			i18n = var_2_10003

			var_3_2(var_3_1, var_2_10003("vote_tip_area_closed"))

			return
		end

		local var_3_3 = arg_1_0
		local var_3_4 = var_1.sendNotification

		GAME = var_2_10003

		local var_3_5 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_3_4(var_3_3, var_3_5, var_2_10004.VOTE, {
			voteGroup = var_0
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FUN_VOTE, function()
		getProxy = var_2_10000
		VoteProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)

		if not var_0.GetOpeningFunVoteGroup(var_4_0) then
			pg = var_4_0

			local var_4_1 = var_4_0.TipsMgr.GetInstance()
			local var_4_2 = var_1.ShowTips

			i18n = var_2_10003

			var_4_2(var_4_1, var_2_10003("vote_tip_area_closed"))

			return
		end

		local var_4_3 = arg_1_0
		local var_4_4 = var_1.sendNotification

		GAME = var_2_10003

		local var_4_5 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_4_4(var_4_3, var_4_5, var_2_10004.VOTE, {
			voteGroup = var_0
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXCHANGE, function()
		getProxy = var_2_10000
		VoteProxy = var_2_10001

		local var_5_0 = var_2_10000(var_2_10001)

		if not var_0.GetOpeningNonFunVoteGroup(var_5_0) then
			pg = var_5_0

			local var_5_1 = var_5_0.TipsMgr.GetInstance()
			local var_5_2 = var_1.ShowTips

			i18n = var_2_10003

			var_5_2(var_5_1, var_2_10003("common_activity_notStartOrEnd"))

			return
		end

		local var_5_3 = arg_1_0
		local var_5_4 = var_1.addSubLayers

		Context = var_2_10003

		local var_5_5 = var_2_10003.New
		local var_5_6 = {}

		VoteExchangeMediator = var_2_10005
		var_5_6.mediator = var_2_10005
		VoteExchangeScene = var_2_10005
		var_5_6.viewComponent = var_2_10005
		var_5_6.data = {
			voteGroup = var_0
		}

		var_5_4(var_5_3, var_5_5(var_5_6))

		return
	end)
	arg_1_0:bind(var_0_1.ON_SCHEDULE, function()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_6_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.VOTESCHEDULE)

		return
	end)
	arg_1_0:bind(var_0_1.GO_HALL, function()
		local var_7_0 = arg_1_0
		local var_7_1 = var_0.addSubLayers

		Context = var_2_10002

		local var_7_2 = var_2_10002.New
		local var_7_3 = {}

		VoteFameHallMediator = var_2_10004
		var_7_3.mediator = var_2_10004
		VoteFameHallLayer = var_2_10004
		var_7_3.viewComponent = var_2_10004

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.SUBMIT_TASK_DONE
	GAME = var_2
	var_8_0[2] = var_2.ON_NEW_VOTE_DONE
	GAME = var_2
	var_8_0[3] = var_2.STORY_END
	GAME = var_2
	var_8_0[4] = var_2.SUBMIT_ACTIVITY_TASK_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	GAME = var_9_1

	local var_9_7

	if var_9_0 == var_9_1.SUBMIT_ACTIVITY_TASK_DONE then
		local var_9_3 = arg_9_0.viewComponent

		var_9_7.UpdateHonorTip(var_9_3)

		local var_9_4 = arg_9_0.viewComponent

		var_9_7.UpdateMainAward(var_9_4)

		local var_9_5 = arg_9_0.viewComponent

		var_9_7.UpdateMainStageTip(var_9_5)

		local var_9_6 = arg_9_0.viewComponent

		var_9_7 = var_9_7.emit
		BaseUI = var_1_10006

		var_9_7(var_9_6, var_1_10006.ON_ACHIEVE, var_9_2.awards, nil)
	else
		GAME = var_9_7

		if var_9_0 == var_9_7.ON_NEW_VOTE_DONE then
			local var_9_8 = arg_9_0.viewComponent

			var_4.UpdateVotes(var_9_8)

			local var_9_9 = arg_9_0.viewComponent

			var_4.UpdateMainStageTip(var_9_9)

			local var_9_10 = arg_9_0.viewComponent

			var_4.UpdateSubStageTip(var_9_10)
		else
			GAME = var_4

			if var_9_0 == var_4.STORY_END then
				local var_9_11 = arg_9_0.viewComponent

				var_4.FlushAll(var_9_11)
			end
		end
	end

	return
end

return var_0_1
