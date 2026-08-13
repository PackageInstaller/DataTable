class = var_0_10000

local var_0_0 = "NewYearFestivalMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillMediatorTemplate"))

var_0_1.MINIGAME_OPERATION = "MINIGAME_OPERATION"
var_0_1.ON_OPEN_PILE_SIGNED = "ON_OPEN_PILE_SIGNED"

function var_0_1.BindEvent(arg_1_0)
	var_0_1.super.BindEvent(arg_1_0)
	arg_1_0:bind(var_0_1.ON_OPEN_PILE_SIGNED, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		PileGameSignedLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		PileGameSignedMediator = var_2_10006
		var_2_3.mediator = var_2_10006

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.MINIGAME_OPERATION, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.sendNotification

		GAME = var_2_10007

		var_3_1(var_3_0, var_2_10007.SEND_MINI_GAME_OP, {
			hubid = arg_3_1,
			cmd = arg_3_2,
			args1 = arg_3_3
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.SEND_MINI_GAME_OP_DONE
	ActivityProxy = var_2
	var_4_0[2] = var_2.ACTIVITY_UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	local var_5_3

	if var_5_1 == var_5_0.SEND_MINI_GAME_OP_DONE then
		var_5_3 = {
			function(arg_6_0)
				if #var_5_2.awards > 0 then
					local var_6_0 = arg_5_0.viewComponent
					local var_6_1 = var_2.emit

					BaseUI = var_2_10005

					var_6_1(var_6_0, var_2_10005.ON_ACHIEVE, var_1, arg_6_0)
				else
					arg_6_0()
				end

				return
			end,
			function(arg_7_0)
				local var_7_0 = arg_5_0.viewComponent

				var_1.UpdateView(var_7_0)

				return
			end
		}
		seriesAsync = var_5

		var_5(var_5_3)
		arg_5_0:OnSendMiniGameOPDone(var_5_2)
	else
		ActivityProxy = var_5_3

		if var_5_1 == var_5_3.ACTIVITY_UPDATED then
			local var_5_4 = arg_5_0.viewComponent

			var_4.UpdateView(var_5_4)
		end
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.argList[1]
	local var_8_1 = var_2[2]

	if var_8_0 == 3 and var_8_1 == 1 then
		local var_8_2 = arg_8_0.viewComponent

		var_5.UpdateView(var_8_2)
	end

	return
end

return var_0_1
