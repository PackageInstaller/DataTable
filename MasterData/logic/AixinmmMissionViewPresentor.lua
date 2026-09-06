-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmMissionViewPresentor.lua

module("logic.extensions.aixinmm.view.AixinmmMissionViewPresentor", package.seeall)

local AixinmmMissionViewPresentor = class("AixinmmMissionViewPresentor", MissionViewPresentor)

function AixinmmMissionViewPresentor:ctor()
	AixinmmMissionViewPresentor.super.ctor(self)
end

function AixinmmMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AixinmmMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function AixinmmMissionViewPresentor:buildViews()
	return {
		AixinmmMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		AixinmmMissionFmtView.New()
	}
end

function AixinmmMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AixinmmMissionViewPresentor
