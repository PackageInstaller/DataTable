local MedalAlbumMoskvaView = class("MedalAlbumMoskvaView", import(".MedalAlbumTemplateView"))

MedalAlbumMoskvaView.GROUP_ID = 9
MedalAlbumMoskvaView.HELP_TIPS = "help_starLightAlbum"

function MedalAlbumMoskvaView:getUIName()
	return "MedalAlbumMoskvaPage"
end

return MedalAlbumMoskvaView
