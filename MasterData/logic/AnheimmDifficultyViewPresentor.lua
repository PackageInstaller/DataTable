-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmDifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmDifficultyViewPresentor", package.seeall)

local AnheimmDifficultyViewPresentor = class("AnheimmDifficultyViewPresentor", ViewPresentor)

function AnheimmDifficultyViewPresentor:ctor()
	AnheimmDifficultyViewPresentor.super.ctor(self)
end

function AnheimmDifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnheimmDifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmdifficultyview.prefab"
	}
end

function AnheimmDifficultyViewPresentor:buildViews()
	return {
		AnheimmDifficultyView.New()
	}
end

return AnheimmDifficultyViewPresentor
