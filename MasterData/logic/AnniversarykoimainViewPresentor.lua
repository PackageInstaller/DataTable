-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversarykoimainViewPresentor.lua

module("logic.extensions.anniversarykoi.view.AnniversarykoimainViewPresentor", package.seeall)

local AnniversarykoimainViewPresentor = class("AnniversarykoimainViewPresentor", ViewPresentor)

function AnniversarykoimainViewPresentor:ctor()
	AnniversarykoimainViewPresentor.super.ctor(self)
end

function AnniversarykoimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversarykoimainViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarykoi/anniversarykoimainview.prefab"
	}
end

function AnniversarykoimainViewPresentor:buildViews()
	return {
		AnniversaryKoimainView.New()
	}
end

return AnniversarykoimainViewPresentor
