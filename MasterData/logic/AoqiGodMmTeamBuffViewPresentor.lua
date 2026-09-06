-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodMmTeamBuffViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodMmTeamBuffViewPresentor", package.seeall)

local AoqiGodMmTeamBuffViewPresentor = class("AoqiGodMmTeamBuffViewPresentor", ViewPresentor)

function AoqiGodMmTeamBuffViewPresentor:ctor()
	AoqiGodMmTeamBuffViewPresentor.super.ctor(self)
end

function AoqiGodMmTeamBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodMmTeamBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodmmteambuffview.prefab"
	}
end

function AoqiGodMmTeamBuffViewPresentor:buildViews()
	return {
		AoqiGodMmTeamBuffView.New()
	}
end

return AoqiGodMmTeamBuffViewPresentor
