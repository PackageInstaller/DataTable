local var_0_0 = class("MiniHubMediator", import("..BaseMiniGameMediator"))

function var_0_0.register(arg_1_0)
	var_0_0.super.register(arg_1_0)
	arg_1_0.viewComponent:SetExtraData({})

	return
end

function var_0_0.OnMiniGameOPeration(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
		hubid = arg_2_0.miniGameProxy:GetHubByGameId(arg_2_0.miniGameId).id,
		cmd = arg_2_1,
		args1 = arg_2_2
	})

	return
end

function var_0_0.OnMiniGameSuccess(arg_3_0, arg_3_1)
	if arg_3_0.gameRoomData then
		if arg_3_0.gameRoonCoinCount and arg_3_0.gameRoonCoinCount == 0 then
			return
		end

		local var_3_0 = arg_3_1
		local var_3_1 = arg_3_0.gameRoonCoinCount or 1

		;({}).roomId = arg_3_0.gameRoomData.id
		;({}).times = var_3_1
		;({}).score = var_3_0

		arg_3_0:sendNotification(GAME.GAME_ROOM_SUCCESS, {})
	else
		local var_3_2 = arg_3_0.miniGameProxy:GetHubByGameId(arg_3_0.miniGameId)

		if var_3_2.count <= 0 then
			return
		end

		local var_3_3 = arg_3_1 and type(arg_3_1) == "table" and arg_3_1 or {
			arg_3_1
		}

		arg_3_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_3_2.id,
			cmd = MiniGameOPCommand.CMD_COMPLETE,
			args1 = var_3_3,
			id = arg_3_0.miniGameId
		})
	end

	return
end

function var_0_0.OnMiniGameFailure(arg_4_0, arg_4_1)
	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	table.insertto({
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}, var_0_0.super.listNotificationInterests(arg_5_0))

	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	var_0_0.super.handleNotification(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody().awards)

		if arg_6_0.viewComponent.ShowTask then
			arg_6_0.viewComponent:ShowTask()
		end
	elseif var_6_0 == GAME.SEND_MINI_GAME_OP_DONE and arg_6_0.viewComponent.OnSendMiniGameOPDoneShrine then
		arg_6_0.viewComponent:OnSendMiniGameOPDoneShrine()
	end

	return
end

return var_0_0
