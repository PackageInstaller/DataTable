local BillboardMediator = class("BillboardMediator", import("..base.ContextMediator"))

BillboardMediator.FETCH_RANKS = "BillboardMediator:FETCH_RANKS"
BillboardMediator.OPEN_RIVAL_INFO = "BillboardMediator:OPEN_RIVAL_INFO"

function BillboardMediator:register()
	local var_1_0 = getProxy(BillboardProxy)
	local var_1_1 = self.contextData.page or PowerRank.TYPE_POWER
	local var_1_2 = self.contextData.act_id or checkExist(PowerRank:getActivityByRankType(var_1_1), {
		"id"
	})

	self.viewComponent:updateRankList(var_1_1, var_1_0:getRankList(var_1_1, var_1_2), var_1_0:getPlayerRankData(var_1_1, var_1_2), var_1_2)
	self:bind(BillboardMediator.FETCH_RANKS, function(arg_2_0, arg_2_1, arg_2_2)
		if var_1_0:canFetch(arg_2_1, arg_2_2) then
			self:sendNotification(GAME.GET_POWERRANK, {
				type = arg_2_1,
				activityId = arg_2_2
			})
		else
			self.viewComponent:updateRankList(arg_2_1, var_1_0:getRankList(arg_2_1, arg_2_2), var_1_0:getPlayerRankData(arg_2_1, arg_2_2), arg_2_2)
			self.viewComponent:filter(arg_2_1, arg_2_2)
		end

		return
	end)
	self:bind(BillboardMediator.OPEN_RIVAL_INFO, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.GET_RIVAL_INFO, arg_3_1)

		return
	end)

	return
end

function BillboardMediator:listNotificationInterests()
	return {
		GAME.GET_POWERRANK_DONE,
		GAME.GET_RIVAL_INFO_DONE
	}
end

function BillboardMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.GET_POWERRANK_DONE then
		self.viewComponent:updateRankList(var_5_1.type, var_5_1.list, var_5_1.playerRankinfo, var_5_1.activityId)
		self.viewComponent:filter(var_5_1.type, var_5_1.activityId)
	elseif var_5_0 == GAME.GET_RIVAL_INFO_DONE then
		self:addSubLayers(Context.New({
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

return BillboardMediator
