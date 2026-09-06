-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/ActivitySetViewPresentor.lua

module("logic.extensions.bonus.view.ActivitySetViewPresentor", package.seeall)

local ActivitySetViewPresentor = class("ActivitySetViewPresentor", ViewPresentor)

function ActivitySetViewPresentor:ctor()
	ActivitySetViewPresentor.super.ctor(self)
end

function ActivitySetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitySetViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/activitysetview.prefab"
	}
end

function ActivitySetViewPresentor:buildViews()
	return {
		ActivitySetView.New()
	}
end

function ActivitySetViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ActivitySetViewPresentor
