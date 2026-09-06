-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushMatchViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushMatchViewPresentor", package.seeall)

local AbyssGoldRushMatchViewPresentor = class("AbyssGoldRushMatchViewPresentor", ViewPresentor)

function AbyssGoldRushMatchViewPresentor:ctor()
	AbyssGoldRushMatchViewPresentor.super.ctor(self)
end

function AbyssGoldRushMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushmatchview.prefab"
	}
end

function AbyssGoldRushMatchViewPresentor:buildViews()
	return {
		AbyssGoldRushMatchView.New()
	}
end

return AbyssGoldRushMatchViewPresentor
