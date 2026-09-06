-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleRankViewPresentor.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleRankViewPresentor", package.seeall)

local CampScuffleRankViewPresentor = class("CampScuffleRankViewPresentor", ViewPresentor)

function CampScuffleRankViewPresentor:ctor()
	CampScuffleRankViewPresentor.super.ctor(self)
end

function CampScuffleRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CampScuffleRankViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/campscuffle/campscufflerankview.prefab"
	}
end

function CampScuffleRankViewPresentor:buildViews()
	return {
		CampScuffleRankView.New()
	}
end

return CampScuffleRankViewPresentor
