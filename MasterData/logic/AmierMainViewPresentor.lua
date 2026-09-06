-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/amier/AmierMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.amier.AmierMainViewPresentor", package.seeall)

local AmierMainViewPresentor = class("AmierMainViewPresentor", ViewPresentor)

function AmierMainViewPresentor:ctor()
	AmierMainViewPresentor.super.ctor(self)
end

function AmierMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AmierMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/amier/amiermainview.prefab"
	}
end

function AmierMainViewPresentor:buildViews()
	return {
		AmierMainView.New()
	}
end

return AmierMainViewPresentor
