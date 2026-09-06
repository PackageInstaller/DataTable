-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchHistoryBanViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchHistoryBanViewPresentor", package.seeall)

local AnnimatchHistoryBanViewPresentor = class("AnnimatchHistoryBanViewPresentor", ViewPresentor)

function AnnimatchHistoryBanViewPresentor:ctor()
	AnnimatchHistoryBanViewPresentor.super.ctor(self)
end

function AnnimatchHistoryBanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchHistoryBanViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchhistorybanview.prefab"
	}
end

function AnnimatchHistoryBanViewPresentor:buildViews()
	return {
		AnnimatchHistoryBanView.New()
	}
end

return AnnimatchHistoryBanViewPresentor
