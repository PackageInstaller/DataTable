local ValleyMessageAlbumView = class("ValleyMessageAlbumView", import(".MedalAlbumTemplateView"))

ValleyMessageAlbumView.GROUP_ID = 5875
ValleyMessageAlbumView.HELP_TIPS = "help_starLightAlbum"
ValleyMessageAlbumView.ICON_SCALE = 1.2

function ValleyMessageAlbumView:getUIName()
	return "MedalAlbumValleyMessagePage"
end

return ValleyMessageAlbumView
