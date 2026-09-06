-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManStormViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManStormViewPresentor", package.seeall)

local BeastRichManStormViewPresentor = class("BeastRichManStormViewPresentor", ViewPresentor)

function BeastRichManStormViewPresentor:ctor()
	BeastRichManStormViewPresentor.super.ctor(self)
end

function BeastRichManStormViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManStormViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanstormview.prefab"
	}
end

function BeastRichManStormViewPresentor:buildViews()
	return {
		BeastRichManStormView.New()
	}
end

return BeastRichManStormViewPresentor
