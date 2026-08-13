class = var_0_10000

local var_0_0 = "TowerClimbingCollectionMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_GET = "TowerClimbingCollectionMediator:ON_GET"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_GET, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.SEND_MINI_GAME_OP
		local var_2_3 = {
			hubid = 9
		}

		MiniGameOPCommand = var_2_10006
		var_2_3.cmd = var_2_10006.CMD_SPECIAL_GAME

		local var_2_4 = {
			nil,
			2
		}

		MiniGameDataCreator = var_2_10007
		var_2_4[1] = var_2_10007.TowerClimbingGameID
		var_2_4[3] = arg_2_1
		var_2_3.args1 = var_2_4

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)

	getProxy = var_1
	MiniGameProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.GetMiniGameData

	MiniGameDataCreator = var_3

	local var_1_3 = var_1_2(var_1_1, var_3.TowerClimbingGameID)
	local var_1_4 = var_1.clone(var_1_3)
	local var_1_5 = arg_1_0.viewComponent

	var_2.SetData(var_1_5, var_1_4)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.SEND_MINI_GAME_OP_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 == var_4_1.SEND_MINI_GAME_OP_DONE and var_4_2.hubid == 9 then
		local var_4_3 = var_4_2.cmd

		MiniGameOPCommand = var_1_10005

		if var_4_3 == var_1_10005.CMD_SPECIAL_GAME then
			local var_4_4 = var_4_2.argList[1]

			MiniGameDataCreator = var_5

			if var_4_4 == var_5.TowerClimbingGameID and var_4_2.argList[2] == 2 then
				getProxy = var_4
				MiniGameProxy = var_5

				local var_4_5 = var_4(var_5)
				local var_4_6 = var_4.GetMiniGameData

				MiniGameDataCreator = var_1_10006

				local var_4_7 = var_4_6(var_4_5, var_1_10006.TowerClimbingGameID)
				local var_4_8 = arg_4_0.viewComponent

				var_5.SetData(var_4_8, var_4_7)

				local var_4_9 = arg_4_0.viewComponent

				var_5.OpenBook(var_4_9, var_4_2.argList[3])

				local var_4_10 = arg_4_0.viewComponent

				var_5.UpdateTip(var_4_10)
			end
		end
	end

	return
end

return var_0_1
