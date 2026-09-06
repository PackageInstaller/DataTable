-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessrankViewPresentor.lua

module("logic.extensions.autochess.view.AutochessrankViewPresentor", package.seeall)

local AutochessrankViewPresentor = class("AutochessrankViewPresentor", ViewPresentor)

function AutochessrankViewPresentor:ctor()
	AutochessrankViewPresentor.super.ctor(self)
end

function AutochessrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AutochessrankViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessrankview.prefab"
	}
end

function AutochessrankViewPresentor:buildViews()
	return {
		AutochessrankView.New()
	}
end

return AutochessrankViewPresentor
