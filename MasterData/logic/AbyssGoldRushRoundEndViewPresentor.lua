-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushRoundEndViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushRoundEndViewPresentor", package.seeall)

local AbyssGoldRushRoundEndViewPresentor = class("AbyssGoldRushRoundEndViewPresentor", ViewPresentor)

function AbyssGoldRushRoundEndViewPresentor:ctor()
	AbyssGoldRushRoundEndViewPresentor.super.ctor(self)
end

function AbyssGoldRushRoundEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushRoundEndViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushroundendview.prefab"
	}
end

function AbyssGoldRushRoundEndViewPresentor:buildViews()
	return {
		AbyssGoldRushRoundEndView.New()
	}
end

return AbyssGoldRushRoundEndViewPresentor
