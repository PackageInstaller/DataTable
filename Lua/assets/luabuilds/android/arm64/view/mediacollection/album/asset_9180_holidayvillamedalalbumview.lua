local HolidayVillaMedalAlbumView = class("HolidayVillaMedalAlbumView", import(".MedalAlbumTemplateView"))

HolidayVillaMedalAlbumView.GROUP_ID = 5971
HolidayVillaMedalAlbumView.MEDAL_COUNT = 7
HolidayVillaMedalAlbumView.HELP_TIPS = "help_starLightAlbum"

function HolidayVillaMedalAlbumView:getUIName()
	return "MedalAlbumHolidayVillaPage"
end

return HolidayVillaMedalAlbumView
