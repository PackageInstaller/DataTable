local HandleOverDueAttireCommand = class("HandleOverDueAttireCommand", pm.SimpleCommand)

function HandleOverDueAttireCommand:execute(arg_1_1)
	local var_1_0 = getProxy(AttireProxy):getExpiredChaces()

	if #var_1_0 > 0 then
		self:sendNotification(GAME.HANDLE_OVERDUE_ATTIRE_DONE, var_1_0)
	end

	return
end

return HandleOverDueAttireCommand
