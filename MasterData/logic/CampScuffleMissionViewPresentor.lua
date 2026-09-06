-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/scufflemission/CampScuffleMissionViewPresentor.lua

module("logic.extensions.funcamp.view.scufflemission.CampScuffleMissionViewPresentor", package.seeall)

local CampScuffleMissionViewPresentor = class("CampScuffleMissionViewPresentor", MissionViewPresentor)

CampScuffleMissionViewPresentor.FmtPetsPath = "ui/views/funcamp/campscuffle/campscufflefmtpets.prefab"

function CampScuffleMissionViewPresentor:ctor()
	CampScuffleMissionViewPresentor.super.ctor(self)
end

function CampScuffleMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CampScuffleMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		CampScuffleMissionViewPresentor.FmtPetsPath,
		self:_addCommonRes()
	}
end

function CampScuffleMissionViewPresentor:buildViews()
	return {
		CampScuffleMissionView.New(),
		CampScuffleFormationRightView.New(),
		CampScuffleFormationLeftView.New(),
		CampScuffleMissionFmtView.New()
	}
end

function CampScuffleMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CampScuffleMissionViewPresentor
