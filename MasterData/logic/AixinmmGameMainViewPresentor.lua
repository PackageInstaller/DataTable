-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/view/AixinmmGameMainViewPresentor.lua

module("logic.extensions.aixinmmgame.view.AixinmmGameMainViewPresentor", package.seeall)

local AixinmmGameMainViewPresentor = class("AixinmmGameMainViewPresentor", ViewPresentor)

AixinmmGameMainViewPresentor.FBBCharacterPath = "character/10140_xiaonuo_gensui/10140_xiaonuo_gensui-ui_p.prefab"

function AixinmmGameMainViewPresentor:ctor()
	AixinmmGameMainViewPresentor.super.ctor(self)
end

function AixinmmGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AixinmmGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/aixinmmgame/aixinmmgamemainview.prefab",
		AixinmmGameMainViewPresentor.FBBCharacterPath
	}
end

function AixinmmGameMainViewPresentor:buildViews()
	return {
		AixinmmGameMainView.New()
	}
end

return AixinmmGameMainViewPresentor
