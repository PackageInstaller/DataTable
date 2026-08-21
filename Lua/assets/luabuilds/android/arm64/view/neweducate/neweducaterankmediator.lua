local var_0_0 = class("NewEducateRankMediator", import("view.newEducate.base.NewEducateContextMediator"))

var_0_0.ON_GET_RANK = "NewEducateRankMediator.ON_GET_RANK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_GET_RANK, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_RANK, {
			type = arg_2_1,
			tbId = arg_2_2
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.NEW_EDUCATE_GET_RANK_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.NEW_EDUCATE_GET_RANK_DONE then
		arg_4_0.viewComponent:OnGetRankDone(var_4_0.type, var_4_0.tbId, var_4_0.list, var_4_0.playerInfo)
	end

	return
end

return var_0_0
