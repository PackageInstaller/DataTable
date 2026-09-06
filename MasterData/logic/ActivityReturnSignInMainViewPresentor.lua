-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityreturnsignin/view/ActivityReturnSignInMainViewPresentor.lua

module("logic.extensions.activityreturnsignin.view.ActivityReturnSignInMainViewPresentor", package.seeall)

local ActivityReturnSignInMainViewPresentor = class("ActivityReturnSignInMainViewPresentor", ViewPresentor)

function ActivityReturnSignInMainViewPresentor:ctor()
	ActivityReturnSignInMainViewPresentor.super.ctor(self)
end

function ActivityReturnSignInMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityReturnSignInMainViewPresentor:dependWhatResources()
	return {
		"ui/views/activityreturnsignin/activityreturnsigninmainview.prefab"
	}
end

function ActivityReturnSignInMainViewPresentor:buildViews()
	return {
		ActivityReturnSignInMainView.New()
	}
end

return ActivityReturnSignInMainViewPresentor
