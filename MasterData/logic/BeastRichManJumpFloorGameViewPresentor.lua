-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManJumpFloorGameViewPresentor.lua

module("logic.extensions.jumpfloor.view.BeastRichManJumpFloorGameViewPresentor", package.seeall)

local BeastRichManJumpFloorGameViewPresentor = class("BeastRichManJumpFloorGameViewPresentor", ViewPresentor)

function BeastRichManJumpFloorGameViewPresentor:ctor()
	BeastRichManJumpFloorGameViewPresentor.super.ctor(self)
end

function BeastRichManJumpFloorGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManJumpFloorGameViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpfloor/jumpfloorgameview.prefab"
	}
end

function BeastRichManJumpFloorGameViewPresentor:buildViews()
	return {
		BeastRichManJumpFloorGameView.New()
	}
end

return BeastRichManJumpFloorGameViewPresentor
