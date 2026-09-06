-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManShopViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManShopViewPresentor", package.seeall)

local BeastRichManShopViewPresentor = class("BeastRichManShopViewPresentor", ViewPresentor)

function BeastRichManShopViewPresentor:ctor()
	BeastRichManShopViewPresentor.super.ctor(self)
end

function BeastRichManShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManShopViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanshopview.prefab"
	}
end

function BeastRichManShopViewPresentor:buildViews()
	return {
		BeastRichManShopView.New()
	}
end

return BeastRichManShopViewPresentor
