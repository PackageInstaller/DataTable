-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushBagViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushBagViewPresentor", package.seeall)

local AbyssGoldRushBagViewPresentor = class("AbyssGoldRushBagViewPresentor", ViewPresentor)

function AbyssGoldRushBagViewPresentor:ctor()
	AbyssGoldRushBagViewPresentor.super.ctor(self)
end

function AbyssGoldRushBagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushBagViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushbagview.prefab"
	}
end

function AbyssGoldRushBagViewPresentor:buildViews()
	return {
		AbyssGoldRushBagView.New()
	}
end

return AbyssGoldRushBagViewPresentor
