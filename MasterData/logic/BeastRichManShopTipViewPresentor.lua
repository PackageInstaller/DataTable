-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManShopTipViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManShopTipViewPresentor", package.seeall)

local BeastRichManShopTipViewPresentor = class("BeastRichManShopTipViewPresentor", ViewPresentor)

function BeastRichManShopTipViewPresentor:ctor()
	BeastRichManShopTipViewPresentor.super.ctor(self)
end

function BeastRichManShopTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManShopTipViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanshoptipview.prefab"
	}
end

function BeastRichManShopTipViewPresentor:buildViews()
	return {
		BeastRichManShopTipView.New()
	}
end

return BeastRichManShopTipViewPresentor
