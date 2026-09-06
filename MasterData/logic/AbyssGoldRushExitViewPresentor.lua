-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushExitViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushExitViewPresentor", package.seeall)

local AbyssGoldRushExitViewPresentor = class("AbyssGoldRushExitViewPresentor", ViewPresentor)

function AbyssGoldRushExitViewPresentor:ctor()
	AbyssGoldRushExitViewPresentor.super.ctor(self)
end

function AbyssGoldRushExitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushExitViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushexitview.prefab"
	}
end

function AbyssGoldRushExitViewPresentor:buildViews()
	return {
		AbyssGoldRushExitView.New()
	}
end

return AbyssGoldRushExitViewPresentor
