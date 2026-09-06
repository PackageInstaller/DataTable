-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/BackTaskViewPresentor.lua

module("logic.extensions.playerreturn.view.BackTaskViewPresentor", package.seeall)

local BackTaskViewPresentor = class("BackTaskViewPresentor", ViewWithGuidePresentor)

function BackTaskViewPresentor:ctor()
	BackTaskViewPresentor.super.ctor(self)
end

function BackTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BackTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/backtaskview.prefab"
	}
end

function BackTaskViewPresentor:buildViews()
	return {
		BackTaskView.New()
	}
end

return BackTaskViewPresentor
