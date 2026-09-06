-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/BFMissionViewPresentor.lua

module("logic.extensions.mission.view.BFMissionViewPresentor", package.seeall)

local BFMissionViewPresentor = class("BFMissionViewPresentor", MissionViewPresentor)

function BFMissionViewPresentor:ctor()
	BFMissionViewPresentor.super.ctor(self)
end

function BFMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BFMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function BFMissionViewPresentor:buildViews()
	return {
		BFMissionView.New(),
		BFMissionRightView.New(),
		BFMissionLeftView.New(),
		BFMissionFmtView.New()
	}
end

function BFMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return BFMissionViewPresentor
