-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManBuildingViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManBuildingViewPresentor", package.seeall)

local BeastRichManBuildingViewPresentor = class("BeastRichManBuildingViewPresentor", ViewPresentor)

function BeastRichManBuildingViewPresentor:ctor()
	BeastRichManBuildingViewPresentor.super.ctor(self)
end

function BeastRichManBuildingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManBuildingViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanbuildingview.prefab"
	}
end

function BeastRichManBuildingViewPresentor:buildViews()
	return {
		BeastRichManBuildingView.New()
	}
end

return BeastRichManBuildingViewPresentor
