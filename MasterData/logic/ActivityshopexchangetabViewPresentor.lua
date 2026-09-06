-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/ActivityshopexchangetabViewPresentor.lua

module("logic.extensions.activityshop.view.ActivityshopexchangetabViewPresentor", package.seeall)

local ActivityshopexchangetabViewPresentor = class("ActivityshopexchangetabViewPresentor", ViewPresentor)

function ActivityshopexchangetabViewPresentor:ctor()
	ActivityshopexchangetabViewPresentor.super.ctor(self)
end

function ActivityshopexchangetabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityshopexchangetabViewPresentor:dependWhatResources()
	return {
		"ui/views/activityshop/activityshopexchangetabview.prefab"
	}
end

function ActivityshopexchangetabViewPresentor:buildViews()
	return {
		ActivityshopexchangetabView.New()
	}
end

function ActivityshopexchangetabViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ActivityshopexchangetabViewPresentor
