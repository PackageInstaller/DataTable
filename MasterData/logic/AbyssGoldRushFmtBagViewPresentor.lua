-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushFmtBagViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushFmtBagViewPresentor", package.seeall)

local AbyssGoldRushFmtBagViewPresentor = class("AbyssGoldRushFmtBagViewPresentor", ViewPresentor)

function AbyssGoldRushFmtBagViewPresentor:ctor()
	AbyssGoldRushFmtBagViewPresentor.super.ctor(self)
end

function AbyssGoldRushFmtBagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushFmtBagViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushfmtbagview.prefab"
	}
end

function AbyssGoldRushFmtBagViewPresentor:buildViews()
	return {
		AbyssGoldRushFmtBagView.New()
	}
end

return AbyssGoldRushFmtBagViewPresentor
