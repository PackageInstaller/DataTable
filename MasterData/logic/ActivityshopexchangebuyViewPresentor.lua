-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/ActivityshopexchangebuyViewPresentor.lua

module("logic.extensions.activityshop.view.ActivityshopexchangebuyViewPresentor", package.seeall)

local ActivityshopexchangebuyViewPresentor = class("ActivityshopexchangebuyViewPresentor", ViewPresentor)

function ActivityshopexchangebuyViewPresentor:ctor()
	ActivityshopexchangebuyViewPresentor.super.ctor(self)
end

function ActivityshopexchangebuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ActivityshopexchangebuyViewPresentor:dependWhatResources()
	return {
		"ui/views/activityshop/activityshopexchangebuyview.prefab"
	}
end

function ActivityshopexchangebuyViewPresentor:buildViews()
	return {
		ActivityshopexchangebuyView.New()
	}
end

return ActivityshopexchangebuyViewPresentor
