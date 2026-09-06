-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/view/AnMoYanMainViewPresentor.lua

module("logic.extensions.anmoyangame.view.AnMoYanMainViewPresentor", package.seeall)

local AnMoYanMainViewPresentor = class("AnMoYanMainViewPresentor", ViewPresentor)

function AnMoYanMainViewPresentor:ctor()
	AnMoYanMainViewPresentor.super.ctor(self)
end

function AnMoYanMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnMoYanMainViewPresentor:dependWhatResources()
	return {
		"ui/views/anmoyangame/anmoyanmainview.prefab"
	}
end

function AnMoYanMainViewPresentor:buildViews()
	return {
		AnMoYanMainView.New()
	}
end

return AnMoYanMainViewPresentor
