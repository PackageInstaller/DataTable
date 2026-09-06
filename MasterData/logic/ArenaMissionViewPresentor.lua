-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaMissionViewPresentor.lua

module("logic.extensions.arena.view.ArenaMissionViewPresentor", package.seeall)

local ArenaMissionViewPresentor = class("ArenaMissionViewPresentor", MissionViewPresentor)

function ArenaMissionViewPresentor:ctor()
	ArenaMissionViewPresentor.super.ctor(self)
end

function ArenaMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function ArenaMissionViewPresentor:buildViews()
	return {
		ArenaMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		ArenaMissionFmtView.New()
	}
end

function ArenaMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ArenaMissionViewPresentor
