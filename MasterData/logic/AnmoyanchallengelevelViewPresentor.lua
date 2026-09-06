-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/anmoyanchallenge/AnmoyanchallengelevelViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.anmoyanchallenge.AnmoyanchallengelevelViewPresentor", package.seeall)

local AnmoyanchallengelevelViewPresentor = class("AnmoyanchallengelevelViewPresentor", ViewPresentor)

function AnmoyanchallengelevelViewPresentor:ctor()
	AnmoyanchallengelevelViewPresentor.super.ctor(self)
end

function AnmoyanchallengelevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnmoyanchallengelevelViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/anmoyanchallenge/anmoyanchallengelevelview.prefab"
	}
end

function AnmoyanchallengelevelViewPresentor:buildViews()
	return {
		AnmoyanchallengelevelView.New()
	}
end

return AnmoyanchallengelevelViewPresentor
