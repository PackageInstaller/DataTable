local NewYearFestivalMediator = class("NewYearFestivalMediator", import("..TemplateMV.BackHillMediatorTemplate"))

NewYearFestivalMediator.MINIGAME_OPERATION = "MINIGAME_OPERATION"
NewYearFestivalMediator.ON_OPEN_PILE_SIGNED = "ON_OPEN_PILE_SIGNED"

function NewYearFestivalMediator:BindEvent()
	NewYearFestivalMediator.super.BindEvent(self)
	self:bind(NewYearFestivalMediator.ON_OPEN_PILE_SIGNED, function()
		self:addSubLayers(Context.New({
			viewComponent = PileGameSignedLayer,
			mediator = PileGameSignedMediator
		}))

		return
	end)
	self:bind(NewYearFestivalMediator.MINIGAME_OPERATION, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_3_1,
			cmd = arg_3_2,
			args1 = arg_3_3
		})

		return
	end)

	return
end

function NewYearFestivalMediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function NewYearFestivalMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_6_0)
				if #var_5_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, arg_6_0)
				else
					arg_6_0()
				end

				return
			end,
			function(arg_7_0)
				self.viewComponent:UpdateView()

				return
			end
		})
		self:OnSendMiniGameOPDone(var_5_1)
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:UpdateView()
	end

	return
end

function NewYearFestivalMediator:OnSendMiniGameOPDone(arg_8_1)
	if arg_8_1.argList[1] == 3 and arg_8_1.argList[2] == 1 then
		self.viewComponent:UpdateView()
	end

	return
end

return NewYearFestivalMediator
