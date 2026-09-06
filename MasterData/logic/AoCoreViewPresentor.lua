-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aocore/AoCoreViewPresentor.lua

module("logic.extensions.aocore.AoCoreViewPresentor", package.seeall)

local AoCoreViewPresentor = class("AoCoreViewPresentor", ViewWithGuidePresentor)

function AoCoreViewPresentor:ctor()
	AoCoreViewPresentor.super.ctor(self)
end

function AoCoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoCoreViewPresentor:dependWhatResources()
	return {
		"ui/views/aocore/aocoreview.prefab"
	}
end

function AoCoreViewPresentor:buildViews()
	return {
		AoCoreView.New()
	}
end

function AoCoreViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AoCoreViewPresentor
