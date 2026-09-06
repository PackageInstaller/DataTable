-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushRankViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushRankViewPresentor", package.seeall)

local AbyssGoldRushRankViewPresentor = class("AbyssGoldRushRankViewPresentor", ViewPresentor)

function AbyssGoldRushRankViewPresentor:ctor()
	AbyssGoldRushRankViewPresentor.super.ctor(self)
end

function AbyssGoldRushRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushRankViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushrankview.prefab"
	}
end

function AbyssGoldRushRankViewPresentor:buildViews()
	return {
		AbyssGoldRushRankView.New()
	}
end

return AbyssGoldRushRankViewPresentor
