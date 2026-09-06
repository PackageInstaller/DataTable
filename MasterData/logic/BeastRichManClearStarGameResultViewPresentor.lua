-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManClearStarGameResultViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManClearStarGameResultViewPresentor", package.seeall)

local BeastRichManClearStarGameResultViewPresentor = class("BeastRichManClearStarGameResultViewPresentor", ViewPresentor)

function BeastRichManClearStarGameResultViewPresentor:ctor()
	BeastRichManClearStarGameResultViewPresentor.super.ctor(self)
end

function BeastRichManClearStarGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManClearStarGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanclearstargameresultview.prefab"
	}
end

function BeastRichManClearStarGameResultViewPresentor:buildViews()
	return {
		BeastRichManClearStarGameResultView.New()
	}
end

return BeastRichManClearStarGameResultViewPresentor
