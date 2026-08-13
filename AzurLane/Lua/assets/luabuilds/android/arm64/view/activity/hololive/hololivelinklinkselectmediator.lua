class = var_0_10000

local var_0_0 = "HoloLiveLinkLinkSelectMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.HUB_ID = 3

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()
	arg_1_0:requestDataFromServer()

	return
end

function var_0_1.requestDataFromServer(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.ConnectionMgr.GetInstance()
	local var_2_1 = var_1.Send
	local var_2_2 = 26101
	local var_2_3 = {}

	MiniGameRequestCommand = var_1_10006
	var_2_3.type = var_1_10006.REQUEST_HUB_DATA

	var_2_1(var_2_0, var_2_2, var_2_3, 26102, function(arg_3_0)
		getProxy = var_2_10001
		MiniGameProxy = var_2_10003

		local var_3_0 = var_2_10001(var_2_10003)

		ipairs = var_2_10002

		for iter_3_0, iter_3_1 in var_2_10002(arg_3_0.hubs) do
			if iter_3_1.id == var_0_1.HUB_ID then
				var_3_0:UpdataHubData(iter_3_1)
			end
		end

		return
	end)

	return
end

function var_0_1.BindEvent(arg_4_0)
	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	MiniGameProxy = var_1_10002
	var_5_0[1] = var_1_10002.ON_HUB_DATA_UPDATE
	GAME = var_2
	var_5_0[2] = var_2.SEND_MINI_GAME_OP_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.getBody(var_6_2)

	MiniGameProxy = var_6_0

	local var_6_4

	if var_6_1 == var_6_0.ON_HUB_DATA_UPDATE then
		var_6_4 = var_6_3.id
		HoloLiveLinkLinkSelectScene = var_6_2

		if var_6_4 == var_6_2.HOLOLIVE_LINKGAME_HUB_ID then
			local var_6_5 = arg_6_0.viewComponent

			var_6_4.updateData(var_6_5)

			local var_6_6 = arg_6_0.viewComponent

			var_6_4.updateUI(var_6_6)
		end
	else
		GAME = var_6_4

		if var_6_1 == var_6_4.SEND_MINI_GAME_OP_DONE then
			local var_6_7 = var_6_3.cmd

			MiniGameOPCommand = var_6_2

			if var_6_7 == var_6_2.CMD_ULTIMATE then
				local var_6_8 = {
					function(arg_7_0)
						if #var_6_3.awards > 0 then
							local var_7_0 = arg_6_0.viewComponent
							local var_7_1 = var_2.emit

							BaseUI = var_2_10005

							var_7_1(var_7_0, var_2_10005.ON_ACHIEVE, var_1, arg_7_0)
						else
							arg_7_0()
						end

						return
					end,
					function(arg_8_0)
						local var_8_0 = arg_6_0.viewComponent

						var_1.updateData(var_8_0)

						local var_8_1 = arg_6_0.viewComponent

						var_1.updateUI(var_8_1)

						return
					end
				}

				seriesAsync = var_5

				var_5(var_6_8)
			end
		end
	end

	return
end

return var_0_1
