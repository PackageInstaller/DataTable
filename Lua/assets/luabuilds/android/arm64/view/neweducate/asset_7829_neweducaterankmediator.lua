local NewEducateRankMediator = class("NewEducateRankMediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateRankMediator.ON_GET_RANK = "NewEducateRankMediator.ON_GET_RANK"

function NewEducateRankMediator:register()
	self:bind(NewEducateRankMediator.ON_GET_RANK, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.NEW_EDUCATE_GET_RANK, {
			type = arg_2_1,
			tbId = arg_2_2
		})

		return
	end)

	return
end

function NewEducateRankMediator:listNotificationInterests()
	return {
		GAME.NEW_EDUCATE_GET_RANK_DONE
	}
end

function NewEducateRankMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.NEW_EDUCATE_GET_RANK_DONE then
		self.viewComponent:OnGetRankDone(var_4_0.type, var_4_0.tbId, var_4_0.list, var_4_0.playerInfo)
	end

	return
end

return NewEducateRankMediator
