-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroSetTeamViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroSetTeamViewPresentor", package.seeall)

local AoqiHeroSetTeamViewPresentor = class("AoqiHeroSetTeamViewPresentor", ViewPresentor)

function AoqiHeroSetTeamViewPresentor:ctor()
	AoqiHeroSetTeamViewPresentor.super.ctor(self)
end

function AoqiHeroSetTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroSetTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiherosetteamview.prefab"
	}
end

function AoqiHeroSetTeamViewPresentor:buildViews()
	return {
		AoqiHeroSetTeamView.New()
	}
end

return AoqiHeroSetTeamViewPresentor
