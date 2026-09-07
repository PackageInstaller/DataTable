local ChangeToIslandCommand = class("ChangeToIslandCommand", pm.SimpleCommand)

function ChangeToIslandCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getType()

	getProxy(ContextProxy):getCurrentContext().skipBack = true

	pg.m02:sendNotification(GAME.ISLAND_ENTER, (arg_1_1:getBody()))

	return
end

return ChangeToIslandCommand
