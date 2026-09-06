-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/anmoyanchallenge/AnmoyanchallengemainViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.anmoyanchallenge.AnmoyanchallengemainViewPresentor", package.seeall)

local AnmoyanchallengemainViewPresentor = class("AnmoyanchallengemainViewPresentor", ViewPresentor)

function AnmoyanchallengemainViewPresentor:ctor()
	AnmoyanchallengemainViewPresentor.super.ctor(self)
end

function AnmoyanchallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnmoyanchallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/anmoyanchallenge/anmoyanchallengemainview.prefab"
	}
end

function AnmoyanchallengemainViewPresentor:buildViews()
	return {
		AnmoyanchallengemainView.New()
	}
end

return AnmoyanchallengemainViewPresentor
