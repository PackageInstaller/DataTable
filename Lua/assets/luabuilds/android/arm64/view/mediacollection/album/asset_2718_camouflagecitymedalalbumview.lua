local CamouflageCityMedalAlbumView = class("CamouflageCityMedalAlbumView", import(".MedalAlbumTemplateView"))

CamouflageCityMedalAlbumView.GROUP_ID = 50021
CamouflageCityMedalAlbumView.MEDAL_COUNT = 8
CamouflageCityMedalAlbumView.HELP_TIPS = "help_starLightAlbum"

function CamouflageCityMedalAlbumView:getUIName()
	return "MedalAlbumCamouflageCityPage"
end

return CamouflageCityMedalAlbumView
