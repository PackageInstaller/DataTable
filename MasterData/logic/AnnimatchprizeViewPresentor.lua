-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchprizeViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchprizeViewPresentor", package.seeall)

local AnnimatchprizeViewPresentor = class("AnnimatchprizeViewPresentor", ViewPresentor)

function AnnimatchprizeViewPresentor:ctor()
	AnnimatchprizeViewPresentor.super.ctor(self)
end

function AnnimatchprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchprizeview.prefab"
	}
end

function AnnimatchprizeViewPresentor:buildViews()
	return {
		AnnimatchprizeView.New()
	}
end

return AnnimatchprizeViewPresentor
