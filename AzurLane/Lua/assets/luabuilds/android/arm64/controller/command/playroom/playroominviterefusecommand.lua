local var_0_0 = class("PlayRoomInviteRefuseCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	getProxy(PlayRoomProxy):RefuseInvite((arg_1_1:getBody()))

	return
end

return var_0_0
