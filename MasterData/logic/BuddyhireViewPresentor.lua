-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyhire/view/BuddyhireViewPresentor.lua

module("logic.extensions.buddyhire.view.BuddyhireViewPresentor", package.seeall)

local BuddyhireViewPresentor = class("BuddyhireViewPresentor", ViewPresentor)

function BuddyhireViewPresentor:ctor()
	BuddyhireViewPresentor.super.ctor(self)
end

function BuddyhireViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BuddyhireViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyhire/buddyhireview.prefab"
	}
end

function BuddyhireViewPresentor:buildViews()
	return {
		BuddyhireView.New()
	}
end

return BuddyhireViewPresentor
