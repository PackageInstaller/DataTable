-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManClearStarGameViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManClearStarGameViewPresentor", package.seeall)

local BeastRichManClearStarGameViewPresentor = class("BeastRichManClearStarGameViewPresentor", ViewPresentor)

function BeastRichManClearStarGameViewPresentor:ctor()
	BeastRichManClearStarGameViewPresentor.super.ctor(self)
end

function BeastRichManClearStarGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManClearStarGameViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanclearstargameview.prefab"
	}
end

function BeastRichManClearStarGameViewPresentor:buildViews()
	return {
		BeastRichManClearStarGameView.New()
	}
end

return BeastRichManClearStarGameViewPresentor
