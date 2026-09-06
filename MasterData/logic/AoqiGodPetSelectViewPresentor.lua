-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodPetSelectViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodPetSelectViewPresentor", package.seeall)

local AoqiGodPetSelectViewPresentor = class("AoqiGodPetSelectViewPresentor", ViewPresentor)

function AoqiGodPetSelectViewPresentor:ctor()
	AoqiGodPetSelectViewPresentor.super.ctor(self)
end

function AoqiGodPetSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiGodPetSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodpetselectview.prefab"
	}
end

function AoqiGodPetSelectViewPresentor:buildViews()
	return {
		AoqiGodPetSelectView.New()
	}
end

return AoqiGodPetSelectViewPresentor
