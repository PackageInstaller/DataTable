-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchFailSelectViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchFailSelectViewPresentor", package.seeall)

local AnnimatchFailSelectViewPresentor = class("AnnimatchFailSelectViewPresentor", ViewPresentor)

function AnnimatchFailSelectViewPresentor:ctor()
	AnnimatchFailSelectViewPresentor.super.ctor(self)
end

function AnnimatchFailSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchFailSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchfailselectview.prefab"
	}
end

function AnnimatchFailSelectViewPresentor:buildViews()
	return {
		AnnimatchFailSelectView.New()
	}
end

return AnnimatchFailSelectViewPresentor
