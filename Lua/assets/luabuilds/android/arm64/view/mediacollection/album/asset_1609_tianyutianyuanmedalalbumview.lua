local TianYuTianYuanMedalAlbumView = class("TianYuTianYuanMedalAlbumView", import(".MedalAlbumTemplateView"))

TianYuTianYuanMedalAlbumView.GROUP_ID = 50136
TianYuTianYuanMedalAlbumView.MEDAL_COUNT = 8
TianYuTianYuanMedalAlbumView.ICON_SCALE = 1
TianYuTianYuanMedalAlbumView.HELP_TIPS = "help_starLightAlbum"

function TianYuTianYuanMedalAlbumView:getUIName()
	return "MedalAlbumTianYuTianYuanPage"
end

function TianYuTianYuanMedalAlbumView:didEnter()
	TianYuTianYuanMedalAlbumView.super.didEnter(self)

	return
end

return TianYuTianYuanMedalAlbumView
