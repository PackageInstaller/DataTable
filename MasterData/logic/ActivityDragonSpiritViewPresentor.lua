-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dragonspirit/ActivityDragonSpiritViewPresentor.lua

module("logic.extensions.operationsummary.view.dragonspirit.ActivityDragonSpiritViewPresentor", package.seeall)

local ActivityDragonSpiritViewPresentor = class("ActivityDragonSpiritViewPresentor", ViewPresentor)

function ActivityDragonSpiritViewPresentor:ctor()
	ActivityDragonSpiritViewPresentor.super.ctor(self)
end

function ActivityDragonSpiritViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityDragonSpiritViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activitydragonspiritview.prefab"
	}
end

function ActivityDragonSpiritViewPresentor:buildViews()
	return {
		ActivityDragonSpiritView.New()
	}
end

return ActivityDragonSpiritViewPresentor
