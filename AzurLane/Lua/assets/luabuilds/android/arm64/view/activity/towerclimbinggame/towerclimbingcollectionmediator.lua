local var_0_0 = class("TowerClimbingCollectionMediator", import("...base.ContextMediator"))

var_0_0.ON_GET = "TowerClimbingCollectionMediator:ON_GET"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_GET, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = 9,
			cmd = MiniGameOPCommand.CMD_SPECIAL_GAME,
			args1 = {
				MiniGameDataCreator.TowerClimbingGameID,
				2,
				arg_2_1
			}
		})

		return
	end)
	arg_1_0.viewComponent:SetData((getProxy(MiniGameProxy):GetMiniGameData(MiniGameDataCreator.TowerClimbingGameID):clone()))

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.SEND_MINI_GAME_OP_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.SEND_MINI_GAME_OP_DONE and var_4_0.hubid == 9 and var_4_0.cmd == MiniGameOPCommand.CMD_SPECIAL_GAME and var_4_0.argList[1] == MiniGameDataCreator.TowerClimbingGameID and var_4_0.argList[2] == 2 then
		arg_4_0.viewComponent:SetData((getProxy(MiniGameProxy):GetMiniGameData(MiniGameDataCreator.TowerClimbingGameID)))
		arg_4_0.viewComponent:OpenBook(var_4_0.argList[3])
		arg_4_0.viewComponent:UpdateTip()
	end

	return
end

return var_0_0
