-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchFmtBuffViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchFmtBuffViewPresentor", package.seeall)

local AnnimatchFmtBuffViewPresentor = class("AnnimatchFmtBuffViewPresentor", ViewPresentor)

function AnnimatchFmtBuffViewPresentor:ctor()
	AnnimatchFmtBuffViewPresentor.super.ctor(self)
end

function AnnimatchFmtBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchFmtBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchfmtbuffview.prefab"
	}
end

function AnnimatchFmtBuffViewPresentor:buildViews()
	return {
		AnnimatchFmtBuffView.New()
	}
end

return AnnimatchFmtBuffViewPresentor
