-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchselectViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchselectViewPresentor", package.seeall)

local AnnimatchselectViewPresentor = class("AnnimatchselectViewPresentor", ViewPresentor)

function AnnimatchselectViewPresentor:ctor()
	AnnimatchselectViewPresentor.super.ctor(self)
end

function AnnimatchselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchselectViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchselectview.prefab"
	}
end

function AnnimatchselectViewPresentor:buildViews()
	return {
		AnnimatchselectView.New()
	}
end

return AnnimatchselectViewPresentor
