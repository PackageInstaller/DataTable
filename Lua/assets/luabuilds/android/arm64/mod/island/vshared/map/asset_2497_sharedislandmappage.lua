local SharedIslandMapPage = class("SharedIslandMapPage", import("Mod.Island.View.page.map.IslandBaseMapPage"))

function SharedIslandMapPage:GoDesc(arg_1_1)
	self:OpenPage(IslandSharedMapDescPage, arg_1_1)

	return
end

return SharedIslandMapPage
