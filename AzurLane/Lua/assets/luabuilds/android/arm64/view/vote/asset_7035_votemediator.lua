class = var_0_10000

local var_0_0 = "VoteMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_VOTE = "VoteMediator:ON_VOTE"
var_0_1.ON_FILTER = "VoteMediator:ON_FILTER"
var_0_1.ON_SCHEDULE = "VoteMediator:ON_SCHEDULE"
var_0_1.OPEN_EXCHANGE = "VoteMediator:OPEN_EXCHANGE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_VOTE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		var_2_1(var_2_0, var_2_10007.ON_NEW_VOTE, {
			voteId = arg_2_1,
			gid = arg_2_2,
			count = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FILTER, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		CustomIndexLayer = var_2_10008
		var_3_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		var_3_3.data = arg_3_1

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_SCHEDULE, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_4_2 = var_2_10003.New
		local var_4_3 = {}

		VoteScheduleMediator = var_2_10006
		var_4_3.mediator = var_2_10006
		VoteScheduleScene = var_2_10006
		var_4_3.viewComponent = var_2_10006

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EXCHANGE, function()
		getProxy = var_2_10000
		VoteProxy = var_2_10002

		local var_5_0 = var_2_10000(var_2_10002)

		if not var_0.GetOpeningNonFunVoteGroup(var_5_0) then
			return
		end

		local var_5_1 = arg_1_0
		local var_5_2 = var_1.addSubLayers

		Context = var_2_10004

		local var_5_3 = var_2_10004.New
		local var_5_4 = {}

		VoteExchangeMediator = var_2_10007
		var_5_4.mediator = var_2_10007
		VoteExchangeScene = var_2_10007
		var_5_4.viewComponent = var_2_10007
		var_5_4.data = {
			voteGroup = var_0
		}

		var_5_2(var_5_1, var_5_3(var_5_4))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.ON_NEW_VOTE_DONE
	GAME = var_2
	var_6_0[2] = var_2.ACT_NEW_PT_DONE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1:getBody()

	GAME = var_7_0

	local var_7_5

	if var_7_1 == var_7_0.ON_NEW_VOTE_DONE then
		local var_7_3 = arg_7_0.viewComponent

		var_7_5.updateMainview(var_7_3, false)

		pg = var_7_5

		local var_7_4 = var_7_5.TipsMgr.GetInstance()

		var_7_5 = var_7_5.ShowTips
		i18n = var_7

		var_7_5(var_7_4, var_7("vote_success"))
		arg_7_0:DisplayAwards(var_7_2.awards)
	else
		GAME = var_7_5

		if var_7_1 == var_7_5.ACT_NEW_PT_DONE then
			arg_7_0:DisplayAwards(var_7_2.awards)
		end
	end

	return
end

function var_0_1.DisplayAwards(arg_8_0, arg_8_1)
	local var_8_0

	local function var_8_1()
		if #arg_8_0.cache <= 0 then
			return
		end

		local var_9_0 = arg_8_0.cache[1]
		local var_9_1 = arg_8_0.viewComponent
		local var_9_2 = var_1.emit

		BaseUI = var_2_10004

		var_9_2(var_9_1, var_2_10004.ON_ACHIEVE, var_9_0, function()
			table = var_3_10000

			var_3_10000.remove(arg_8_0.cache, 1)
			var_8_1()

			return
		end)

		return
	end

	if not arg_8_0.cache then
		arg_8_0.cache = {}
	end

	table = var_3

	var_3.insert(arg_8_0.cache, arg_8_1)

	if #arg_8_0.cache == 1 then
		var_8_1()
	end

	return
end

return var_0_1
