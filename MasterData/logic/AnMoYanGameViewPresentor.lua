-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/view/AnMoYanGameViewPresentor.lua

module("logic.extensions.anmoyangame.view.AnMoYanGameViewPresentor", package.seeall)

local AnMoYanGameViewPresentor = class("AnMoYanGameViewPresentor", ViewPresentor)

function AnMoYanGameViewPresentor:ctor()
	AnMoYanGameViewPresentor.super.ctor(self)
end

function AnMoYanGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnMoYanGameViewPresentor:dependWhatResources()
	return {
		"ui/views/anmoyangame/anmoyangameview.prefab"
	}
end

function AnMoYanGameViewPresentor:buildViews()
	return {
		AnMoYanGameView.New()
	}
end

return AnMoYanGameViewPresentor
