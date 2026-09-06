-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversarykoirankViewPresentor.lua

module("logic.extensions.anniversarykoi.view.AnniversarykoirankViewPresentor", package.seeall)

local AnniversarykoirankViewPresentor = class("AnniversarykoirankViewPresentor", ViewPresentor)

function AnniversarykoirankViewPresentor:ctor()
	AnniversarykoirankViewPresentor.super.ctor(self)
end

function AnniversarykoirankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversarykoirankViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarykoi/anniversarykoirankview.prefab"
	}
end

function AnniversarykoirankViewPresentor:buildViews()
	return {
		AnniversaryKoirankView.New()
	}
end

return AnniversarykoirankViewPresentor
