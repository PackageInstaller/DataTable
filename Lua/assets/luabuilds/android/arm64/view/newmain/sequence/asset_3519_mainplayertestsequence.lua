local MainPlayerTestSequence = class("MainPlayerTestSequence")

function MainPlayerTestSequence:Execute(arg_1_1)
	if ISLAND_PLAYER_TESTING then
		pg.m02:sendNotification(GAME.ISLAND_ENTER, {
			id = getProxy(PlayerProxy):getRawData().id
		})
	else
		arg_1_1()
	end

	return
end

return MainPlayerTestSequence
