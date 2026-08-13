class = var_0_10000

local var_0_0 = "MiniHubMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameMediator"))

function var_0_1.register(arg_1_0)
	var_0_1.super.register(arg_1_0)

	local var_1_0 = {}
	local var_1_1 = arg_1_0.viewComponent

	var_2.SetExtraData(var_1_1, var_1_0)

	return
end

function var_0_1.OnMiniGameOPeration(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.miniGameProxy
	local var_2_1 = var_3.GetHubByGameId(var_2_0, arg_2_0.miniGameId)
	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.sendNotification

	GAME = var_1_10007

	var_2_3(var_2_2, var_1_10007.SEND_MINI_GAME_OP, {
		hubid = var_2_1.id,
		cmd = arg_2_1,
		args1 = arg_2_2
	})

	return
end

function var_0_1.OnMiniGameSuccess(arg_3_0, arg_3_1)
	if arg_3_0.gameRoomData then
		if arg_3_0.gameRoonCoinCount and arg_3_0.gameRoonCoinCount == 0 then
			return
		end

		local var_3_0 = arg_3_1
		local var_3_1

		if not arg_3_0.gameRoonCoinCount then
			var_3_1 = 1
		end

		local var_3_2 = arg_3_0.gameRoomData.id

		var_1_10007 = arg_3_0

		local var_3_3 = arg_3_0.sendNotification

		GAME = var_1_10008

		var_3_3(var_1_10007, var_1_10008.GAME_ROOM_SUCCESS, {
			roomId = var_3_2,
			times = var_3_1,
			score = var_3_0
		})
	else
		local var_3_4 = arg_3_0.miniGameProxy

		if var_2.GetHubByGameId(var_3_4, arg_3_0.miniGameId).count <= 0 then
			return
		end

		local var_3_5

		if arg_3_1 then
			type = var_4

			if var_4(arg_3_1) == "table" then
				var_3_5 = arg_3_1

				goto label_3_0
			end
		end

		var_3_5 = {
			arg_3_1
		}

		::label_3_0::

		local var_3_6 = arg_3_0
		local var_3_7 = arg_3_0.sendNotification

		GAME = var_1_10007

		local var_3_8 = var_1_10007.SEND_MINI_GAME_OP
		local var_3_9 = {
			hubid = var_2.id
		}

		MiniGameOPCommand = var_9
		var_3_9.cmd = var_9.CMD_COMPLETE
		var_3_9.args1 = var_3_5
		var_3_9.id = arg_3_0.miniGameId

		var_3_7(var_3_6, var_3_8, var_3_9)
	end

	return
end

function var_0_1.OnMiniGameFailure(arg_4_0, arg_4_1)
	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE
	table = var_2

	var_2.insertto(var_5_0, var_0_1.super.listNotificationInterests(arg_5_0))

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	var_0_1.super.handleNotification(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	local var_6_4

	if var_6_1 == var_6_0.SUBMIT_ACTIVITY_TASK_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_6_4 = var_6_4.emit
		BaseUI = var_1_10007

		var_6_4(var_6_3, var_1_10007.ON_ACHIEVE, var_6_2.awards)

		if arg_6_0.viewComponent.ShowTask then
			local var_6_5 = arg_6_0.viewComponent

			var_6_4.ShowTask(var_6_5)
		end
	else
		GAME = var_6_4

		if var_6_1 == var_6_4.SEND_MINI_GAME_OP_DONE and arg_6_0.viewComponent.OnSendMiniGameOPDoneShrine then
			local var_6_6 = arg_6_0.viewComponent

			var_4.OnSendMiniGameOPDoneShrine(var_6_6)
		end
	end

	return
end

return var_0_1
