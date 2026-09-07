local OtherWorldTempleMediator = class("OtherWorldTempleMediator", import("..base.ContextMediator"))

OtherWorldTempleMediator.OPEN_TERMINAL = "OPEN_TERMINAL"
OtherWorldTempleMediator.SHOW_CHAR_AWARDS = "SHOW_CHAR_AWARDS"

function OtherWorldTempleMediator:register()
	self:bind(OtherWorldTempleMediator.OPEN_TERMINAL, function()
		self:addSubLayers(Context.New({
			mediator = OtherworldTerminalMediator,
			viewComponent = OtherworldTerminalLayer
		}))

		return
	end)
	self:bind(OtherWorldTempleMediator.SHOW_CHAR_AWARDS, function(arg_3_0, arg_3_1, arg_3_2)
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_3_1, arg_3_2)

		return
	end)

	return
end

function OtherWorldTempleMediator:onUIAvalible()
	return
end

function OtherWorldTempleMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_LOTTERY_SHOW_AWARDS,
		GAME.ZERO_HOUR_OP_DONE
	}
end

function OtherWorldTempleMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		if var_6_1 == ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID then
			self.viewComponent:updateActivity()
			self.viewComponent:displayTempleCharAward()
		end
	elseif var_6_0 == ActivityProxy.ACTIVITY_LOTTERY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, function()
			if var_6_1.callback then
				var_6_1.callback()
			end

			return
		end)
	elseif var_6_0 == GAME.ZERO_HOUR_OP_DONE then
		-- block empty
	end

	return
end

return OtherWorldTempleMediator
