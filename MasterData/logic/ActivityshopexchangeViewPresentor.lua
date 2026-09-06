-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/ActivityshopexchangeViewPresentor.lua

module("logic.extensions.activityshop.view.ActivityshopexchangeViewPresentor", package.seeall)

local ActivityshopexchangeViewPresentor = class("ActivityshopexchangeViewPresentor", ViewPresentor)

function ActivityshopexchangeViewPresentor:ctor()
	ActivityshopexchangeViewPresentor.super.ctor(self)
end

function ActivityshopexchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityshopexchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/activityshop/activityshopexchangeview.prefab"
	}
end

function ActivityshopexchangeViewPresentor:buildViews()
	return {
		ActivityshopexchangeView.New()
	}
end

return ActivityshopexchangeViewPresentor
