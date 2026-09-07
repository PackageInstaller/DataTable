local VoteFameHallMediator = class("VoteFameHallMediator", import("..base.ContextMediator"))

VoteFameHallMediator.ON_SUBMIT_TASK = "VoteFameHallMediator:ON_SUBMIT_TASK"

function VoteFameHallMediator:register()
	self:bind(VoteFameHallMediator.ON_SUBMIT_TASK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_2_1)

		return
	end)
	self.viewComponent:SetPastVoteData(getProxy(VoteProxy):GetPastVoteData())

	return
end

function VoteFameHallMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_DONE
	}
end

function VoteFameHallMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:UpdateTips(self.viewComponent.year)
		self.viewComponent:UpdateBtnsTip()
	end

	return
end

return VoteFameHallMediator
