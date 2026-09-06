-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessrankresultViewPresentor.lua

module("logic.extensions.autochess.view.AutochessrankresultViewPresentor", package.seeall)

local AutochessrankresultViewPresentor = class("AutochessrankresultViewPresentor", ViewPresentor)

function AutochessrankresultViewPresentor:ctor()
	AutochessrankresultViewPresentor.super.ctor(self)
end

function AutochessrankresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AutochessrankresultViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessrankresultview.prefab"
	}
end

function AutochessrankresultViewPresentor:buildViews()
	return {
		AutochessrankresultView.New()
	}
end

return AutochessrankresultViewPresentor
