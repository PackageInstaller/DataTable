local SailingShip3MedalAlbumView = class("SailingShip3MedalAlbumView", import(".MedalAlbumTemplateView"))

SailingShip3MedalAlbumView.GROUP_ID = 50209
SailingShip3MedalAlbumView.MEDAL_COUNT = 8
SailingShip3MedalAlbumView.HELP_TIPS = "help_starLightAlbum"
SailingShip3MedalAlbumView.ICON_SCALE = 1

function SailingShip3MedalAlbumView:getUIName()
	return "MedalAlbumSailingShip3Page"
end

return SailingShip3MedalAlbumView
