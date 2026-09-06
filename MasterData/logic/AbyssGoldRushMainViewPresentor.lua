-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushMainViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushMainViewPresentor", package.seeall)

local AbyssGoldRushMainViewPresentor = class("AbyssGoldRushMainViewPresentor", ViewPresentor)

function AbyssGoldRushMainViewPresentor:ctor()
	AbyssGoldRushMainViewPresentor.super.ctor(self)
end

function AbyssGoldRushMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushMainViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushmainview.prefab"
	}
end

function AbyssGoldRushMainViewPresentor:buildViews()
	return {
		AbyssGoldRushMainView.New()
	}
end

return AbyssGoldRushMainViewPresentor
