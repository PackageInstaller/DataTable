local var_0_0 = class("BillboardMediator", import("..base.ContextMediator"))

var_0_0.FETCH_RANKS = "BillboardMediator:FETCH_RANKS"
var_0_0.OPEN_RIVAL_INFO = "BillboardMediator:OPEN_RIVAL_INFO"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(BillboardProxy)
	local var_1_1 = arg_1_0.contextData.page or PowerRank.TYPE_POWER
	local var_1_2 = arg_1_0.contextData.act_id or checkExist(PowerRank:getActivityByRankType(var_1_1), {
		"id"
	})

	arg_1_0.viewComponent:updateRankList(var_1_1, var_1_0:getRankList(var_1_1, var_1_2), var_1_0:getPlayerRankData(var_1_1, var_1_2), var_1_2)
	arg_1_0:bind(var_0_0.FETCH_RANKS, function(arg_2_0, arg_2_1, arg_2_2)
		if var_1_0:canFetch(arg_2_1, arg_2_2) then
			arg_1_0:sendNotification(GAME.GET_POWERRANK, {
				type = arg_2_1,
				activityId = arg_2_2
			})
		else
			arg_1_0.viewComponent:updateRankList(arg_2_1, var_1_0:getRankList(arg_2_1, arg_2_2), var_1_0:getPlayerRankData(arg_2_1, arg_2_2), arg_2_2)
			arg_1_0.viewComponent:filter(arg_2_1, arg_2_2)
		end

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_RIVAL_INFO, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.GET_RIVAL_INFO, arg_3_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.GET_POWERRANK_DONE,
		GAME.GET_RIVAL_INFO_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.GET_POWERRANK_DONE then
		arg_5_0.viewComponent:updateRankList(var_5_1.type, var_5_1.list, var_5_1.playerRankinfo, var_5_1.activityId)
		arg_5_0.viewComponent:filter(var_5_1.type, var_5_1.activityId)
	elseif var_5_0 == GAME.GET_RIVAL_INFO_DONE then
		arg_5_0:addSubLayers(Context.New({
			viewComponent = RivalInfoLayer,
			mediator = RivalInfoMediator,
			data = {
				rival = var_5_1.rival,
				type = RivalInfoLayer.TYPE_DISPLAY
			}
		}))
	end

	return
end

return var_0_0
