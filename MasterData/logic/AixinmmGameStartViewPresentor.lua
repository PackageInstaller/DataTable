-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/view/AixinmmGameStartViewPresentor.lua

module("logic.extensions.aixinmmgame.view.AixinmmGameStartViewPresentor", package.seeall)

local AixinmmGameStartViewPresentor = class("AixinmmGameStartViewPresentor", ViewPresentor)

function AixinmmGameStartViewPresentor:ctor()
	AixinmmGameStartViewPresentor.super.ctor(self)
end

function AixinmmGameStartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AixinmmGameStartViewPresentor:dependWhatResources()
	return {
		"ui/views/aixinmmgame/aixinmmgamestartview.prefab"
	}
end

function AixinmmGameStartViewPresentor:buildViews()
	return {
		AixinmmGameStartView.New()
	}
end

return AixinmmGameStartViewPresentor
