-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManGameViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManGameViewPresentor", package.seeall)

local BeastRichManGameViewPresentor = class("BeastRichManGameViewPresentor", ViewPresentor)

function BeastRichManGameViewPresentor:ctor()
	BeastRichManGameViewPresentor.super.ctor(self)
end

function BeastRichManGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManGameViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmangameview.prefab"
	}
end

function BeastRichManGameViewPresentor:buildViews()
	return {
		BeastRichManGameView.New()
	}
end

return BeastRichManGameViewPresentor
