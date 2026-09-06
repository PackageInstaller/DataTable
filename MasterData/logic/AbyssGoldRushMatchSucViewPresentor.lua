-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushMatchSucViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushMatchSucViewPresentor", package.seeall)

local AbyssGoldRushMatchSucViewPresentor = class("AbyssGoldRushMatchSucViewPresentor", ViewPresentor)

function AbyssGoldRushMatchSucViewPresentor:ctor()
	AbyssGoldRushMatchSucViewPresentor.super.ctor(self)
end

function AbyssGoldRushMatchSucViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushMatchSucViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushmatchsucview.prefab"
	}
end

function AbyssGoldRushMatchSucViewPresentor:buildViews()
	return {
		AbyssGoldRushMatchSucView.New()
	}
end

return AbyssGoldRushMatchSucViewPresentor
