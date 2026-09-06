-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/view/AnMoYanGameResultViewPresentor.lua

module("logic.extensions.anmoyangame.view.AnMoYanGameResultViewPresentor", package.seeall)

local AnMoYanGameResultViewPresentor = class("AnMoYanGameResultViewPresentor", ViewPresentor)

function AnMoYanGameResultViewPresentor:ctor()
	AnMoYanGameResultViewPresentor.super.ctor(self)
end

function AnMoYanGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnMoYanGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/anmoyangame/anmoyangameresultview.prefab"
	}
end

function AnMoYanGameResultViewPresentor:buildViews()
	return {
		AnMoYanGameResultView.New()
	}
end

return AnMoYanGameResultViewPresentor
