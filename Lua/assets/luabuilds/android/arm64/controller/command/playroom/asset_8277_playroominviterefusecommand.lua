local PlayRoomInviteRefuseCommand = class("PlayRoomInviteRefuseCommand", pm.SimpleCommand)

function PlayRoomInviteRefuseCommand:execute(arg_1_1)
	getProxy(PlayRoomProxy):RefuseInvite((arg_1_1:getBody()))

	return
end

return PlayRoomInviteRefuseCommand
