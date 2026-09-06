-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupTeamViewPresentor.lua

module("logic.extensions.brothergroup.view.BrotherGroupTeamViewPresentor", package.seeall)

local BrotherGroupTeamViewPresentor = class("BrotherGroupTeamViewPresentor", ViewPresentor)

function BrotherGroupTeamViewPresentor:ctor()
	BrotherGroupTeamViewPresentor.super.ctor(self)
end

function BrotherGroupTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherGroupTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/brothergroup/brothergroupteamview.prefab"
	}
end

function BrotherGroupTeamViewPresentor:buildViews()
	return {
		BrotherGroupTeamView.New()
	}
end

return BrotherGroupTeamViewPresentor
