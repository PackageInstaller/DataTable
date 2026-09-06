-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushFmtViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushFmtViewPresentor", package.seeall)

local AbyssGoldRushFmtViewPresentor = class("AbyssGoldRushFmtViewPresentor", ViewPresentor)

function AbyssGoldRushFmtViewPresentor:ctor()
	AbyssGoldRushFmtViewPresentor.super.ctor(self)
end

function AbyssGoldRushFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushfmtview.prefab"
	}
end

function AbyssGoldRushFmtViewPresentor:buildViews()
	return {
		AbyssGoldRushFmtView.New()
	}
end

return AbyssGoldRushFmtViewPresentor
