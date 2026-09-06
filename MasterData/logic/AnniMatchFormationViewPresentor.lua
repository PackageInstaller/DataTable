-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/mission/AnniMatchFormationViewPresentor.lua

module("logic.extensions.annimatch.view.mission.AnniMatchFormationViewPresentor", package.seeall)

local AnniMatchFormationViewPresentor = class("AnniMatchFormationViewPresentor", ViewPresentor)

function AnniMatchFormationViewPresentor:ctor()
	AnniMatchFormationViewPresentor.super.ctor(self)
end

function AnniMatchFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniMatchFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchformationview.prefab"
	}
end

function AnniMatchFormationViewPresentor:buildViews()
	return {
		AnniMatchFormationLeftView.New(),
		AnniMatchRightView.New(),
		AnniMatchFormationView.New(true)
	}
end

return AnniMatchFormationViewPresentor
