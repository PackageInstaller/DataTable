local var_0_0 = class("SharedIslandOtherCardPage", import("Mod.Island.View.page.card.IslandOtherCardPage"))

function var_0_0.AddSubLayers(arg_1_0, arg_1_1)
	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(SharedIslandMediator),
		context = arg_1_1
	})

	return
end

return var_0_0
