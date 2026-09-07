local VoteEntranceMediator = class("VoteEntranceMediator", import("view.base.ContextMediator"))

VoteEntranceMediator.ON_VOTE = "VoteEntranceMediator:ON_VOTE"
VoteEntranceMediator.ON_FUN_VOTE = "VoteEntranceMediator:ON_FUN_VOTE"
VoteEntranceMediator.ON_EXCHANGE = "VoteEntranceMediator:ON_EXCHANGE"
VoteEntranceMediator.ON_SCHEDULE = "VoteEntranceMediator:ON_SCHEDULE"
VoteEntranceMediator.GO_HALL = "VoteEntranceMediator:GO_HALL"
VoteEntranceMediator.SUBMIT_TASK = "VoteEntranceMediator:SUBMIT_TASK"

function VoteEntranceMediator:register()
	self:bind(VoteEntranceMediator.SUBMIT_TASK, function()
		local var_2_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

		if not var_2_0 or var_2_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))

			return
		end

		self:sendNotification(GAME.SUBMIT_TASK, var_2_0:getConfig("config_client")[2])

		return
	end)
	self:bind(VoteEntranceMediator.ON_VOTE, function()
		local var_3_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

		if not var_3_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("vote_tip_area_closed"))

			return
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.VOTE, {
			voteGroup = var_3_0
		})

		return
	end)
	self:bind(VoteEntranceMediator.ON_FUN_VOTE, function()
		local var_4_0 = getProxy(VoteProxy):GetOpeningFunVoteGroup()

		if not var_4_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("vote_tip_area_closed"))

			return
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.VOTE, {
			voteGroup = var_4_0
		})

		return
	end)
	self:bind(VoteEntranceMediator.ON_EXCHANGE, function()
		local var_5_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

		if not var_5_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))

			return
		end

		self:addSubLayers(Context.New({
			mediator = VoteExchangeMediator,
			viewComponent = VoteExchangeScene,
			data = {
				voteGroup = var_5_0
			}
		}))

		return
	end)
	self:bind(VoteEntranceMediator.ON_SCHEDULE, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.VOTESCHEDULE)

		return
	end)
	self:bind(VoteEntranceMediator.GO_HALL, function()
		self:addSubLayers(Context.New({
			mediator = VoteFameHallMediator,
			viewComponent = VoteFameHallLayer
		}))

		return
	end)

	return
end

function VoteEntranceMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_DONE,
		GAME.ON_NEW_VOTE_DONE,
		GAME.STORY_END,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function VoteEntranceMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()

	if var_9_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:UpdateHonorTip()
		self.viewComponent:UpdateMainAward()
		self.viewComponent:UpdateMainStageTip()
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_9_1:getBody().awards, nil)
	elseif var_9_0 == GAME.ON_NEW_VOTE_DONE then
		self.viewComponent:UpdateVotes()
		self.viewComponent:UpdateMainStageTip()
		self.viewComponent:UpdateSubStageTip()
	elseif var_9_0 == GAME.STORY_END then
		self.viewComponent:FlushAll()
	end

	return
end

return VoteEntranceMediator
