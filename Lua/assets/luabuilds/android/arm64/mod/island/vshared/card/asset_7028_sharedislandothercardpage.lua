local SharedIslandOtherCardPage = class("SharedIslandOtherCardPage", import("Mod.Island.View.page.card.IslandOtherCardPage"))

function SharedIslandOtherCardPage:AddSubLayers(arg_1_1)
	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(SharedIslandMediator),
		context = arg_1_1
	})

	return
end

return SharedIslandOtherCardPage
