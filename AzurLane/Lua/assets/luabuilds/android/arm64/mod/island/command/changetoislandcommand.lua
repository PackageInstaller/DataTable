local var_0_0 = class("ChangeToIslandCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getType()

	getProxy(ContextProxy):getCurrentContext().skipBack = true

	pg.m02:sendNotification(GAME.ISLAND_ENTER, (arg_1_1:getBody()))

	return
end

return var_0_0
