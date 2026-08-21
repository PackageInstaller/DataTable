local var_0_0 = class("NewYearFestivalMediator", import("..TemplateMV.BackHillMediatorTemplate"))

var_0_0.MINIGAME_OPERATION = "MINIGAME_OPERATION"
var_0_0.ON_OPEN_PILE_SIGNED = "ON_OPEN_PILE_SIGNED"

function var_0_0.BindEvent(arg_1_0)
	var_0_0.super.BindEvent(arg_1_0)
	arg_1_0:bind(var_0_0.ON_OPEN_PILE_SIGNED, function()
		arg_1_0:addSubLayers(Context.New({
			viewComponent = PileGameSignedLayer,
			mediator = PileGameSignedMediator
		}))

		return
	end)
	arg_1_0:bind(var_0_0.MINIGAME_OPERATION, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_1_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_3_1,
			cmd = arg_3_2,
			args1 = arg_3_3
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_6_0)
				if #var_5_1.awards > 0 then
					arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, arg_6_0)
				else
					arg_6_0()
				end

				return
			end,
			function(arg_7_0)
				arg_5_0.viewComponent:UpdateView()

				return
			end
		})
		arg_5_0:OnSendMiniGameOPDone((arg_5_1:getBody()))
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		arg_5_0.viewComponent:UpdateView()
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_8_0, arg_8_1)
	if arg_8_1.argList[1] == 3 and arg_8_1.argList[2] == 1 then
		arg_8_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
