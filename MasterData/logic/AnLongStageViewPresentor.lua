-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/anlong/AnLongStageViewPresentor.lua

module("logic.extensions.scenariocopy.view.anlong.AnLongStageViewPresentor", package.seeall)

local AnLongStageViewPresentor = class("AnLongStageViewPresentor", ViewPresentor)

function AnLongStageViewPresentor:ctor()
	AnLongStageViewPresentor.super.ctor(self)
end

function AnLongStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnLongStageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/anlong/anlongstageview.prefab"
	}
end

function AnLongStageViewPresentor:buildViews()
	return {
		AnLongStageView.New()
	}
end

return AnLongStageViewPresentor
