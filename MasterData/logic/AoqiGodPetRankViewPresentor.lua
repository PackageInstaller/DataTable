-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/rank/AoqiGodPetRankViewPresentor.lua

module("logic.extensions.aoqigod.view.rank.AoqiGodPetRankViewPresentor", package.seeall)

local AoqiGodPetRankViewPresentor = class("AoqiGodPetRankViewPresentor", ViewPresentor)

function AoqiGodPetRankViewPresentor:ctor()
	AoqiGodPetRankViewPresentor.super.ctor(self)
end

function AoqiGodPetRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiGodPetRankViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodpetrankview.prefab"
	}
end

function AoqiGodPetRankViewPresentor:buildViews()
	return {
		AoqiGodPetRankView.New()
	}
end

function AoqiGodPetRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AoqiGodPetRankViewPresentor
