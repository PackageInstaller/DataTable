class = var_0_10000

local var_0_0 = "BillboardMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.FETCH_RANKS = "BillboardMediator:FETCH_RANKS"
var_0_1.OPEN_RIVAL_INFO = "BillboardMediator:OPEN_RIVAL_INFO"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BillboardProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1

	if not arg_1_0.contextData.page then
		PowerRank = var_1_1
		var_1_1 = var_1_1.TYPE_POWER
	end

	local var_1_2

	if not arg_1_0.contextData.act_id then
		checkExist = var_1_2
		PowerRank = var_1_10005
		var_1_2 = var_1_2(var_1_10005:getActivityByRankType(var_1_1), {
			"id"
		})
	end

	local var_1_3 = var_1_0:getRankList(var_1_1, var_1_2)
	local var_1_4 = var_1_0:getPlayerRankData(var_1_1, var_1_2)
	local var_1_5 = arg_1_0.viewComponent

	var_6.updateRankList(var_1_5, var_1_1, var_1_3, var_1_4, var_1_2)
	arg_1_0:bind(var_0_1.FETCH_RANKS, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = var_1_0

		if var_3.canFetch(var_2_0, arg_2_1, arg_2_2) then
			local var_2_1 = arg_1_0
			local var_2_2 = var_3.sendNotification

			GAME = var_6

			var_2_2(var_2_1, var_6.GET_POWERRANK, {
				type = arg_2_1,
				activityId = arg_2_2
			})
		else
			local var_2_3 = var_1_0
			local var_2_4 = var_3.getRankList(var_2_3, arg_2_1, arg_2_2)
			local var_2_5 = var_1_0
			local var_2_6 = var_4.getPlayerRankData(var_2_5, arg_2_1, arg_2_2)
			local var_2_7 = arg_1_0.viewComponent

			var_5.updateRankList(var_2_7, arg_2_1, var_2_4, var_2_6, arg_2_2)

			local var_2_8 = arg_1_0.viewComponent

			var_5.filter(var_2_8, arg_2_1, arg_2_2)
		end

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RIVAL_INFO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.GET_RIVAL_INFO, arg_3_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.GET_POWERRANK_DONE
	GAME = var_2
	var_4_0[2] = var_2.GET_RIVAL_INFO_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	if var_5_1 == var_5_0.GET_POWERRANK_DONE then
		local var_5_3 = arg_5_0.viewComponent

		var_4.updateRankList(var_5_3, var_5_2.type, var_5_2.list, var_5_2.playerRankinfo, var_5_2.activityId)

		local var_5_4 = arg_5_0.viewComponent

		var_4.filter(var_5_4, var_5_2.type, var_5_2.activityId)
	else
		GAME = var_4

		if var_5_1 == var_4.GET_RIVAL_INFO_DONE then
			local var_5_5 = arg_5_0
			local var_5_6 = arg_5_0.addSubLayers

			Context = var_1_10007

			local var_5_7 = var_1_10007.New
			local var_5_8 = {}

			RivalInfoLayer = var_1_10010
			var_5_8.viewComponent = var_1_10010
			RivalInfoMediator = var_1_10010
			var_5_8.mediator = var_1_10010

			local var_5_9 = {
				rival = var_5_2.rival
			}

			RivalInfoLayer = var_11
			var_5_9.type = var_11.TYPE_DISPLAY
			var_5_8.data = var_5_9

			var_5_6(var_5_5, var_5_7(var_5_8))
		end
	end

	return
end

return var_0_1
