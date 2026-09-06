-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessselectteamViewPresentor.lua

module("logic.extensions.autochess.view.AutochessselectteamViewPresentor", package.seeall)

local AutochessselectteamViewPresentor = class("AutochessselectteamViewPresentor", ViewPresentor)

function AutochessselectteamViewPresentor:ctor()
	AutochessselectteamViewPresentor.super.ctor(self)
end

function AutochessselectteamViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AutochessselectteamViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessselectteamview.prefab"
	}
end

function AutochessselectteamViewPresentor:buildViews()
	return {
		AutochessselectteamView.New()
	}
end

return AutochessselectteamViewPresentor
