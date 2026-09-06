-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/view/AwakenOathAncestorStageViewPresentor.lua

module("logic.extensions.awakenoathancestor.view.AwakenOathAncestorStageViewPresentor", package.seeall)

local AwakenOathAncestorStageViewPresentor = class("AwakenOathAncestorStageViewPresentor", ViewPresentor)

function AwakenOathAncestorStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AwakenOathAncestorStageViewPresentor:dependWhatResources()
	return {
		"ui/views/awakenoathancestor/awakenoathancestorstageview.prefab"
	}
end

function AwakenOathAncestorStageViewPresentor:buildViews()
	return {
		AwakenOathAncestorStageView.New()
	}
end

return AwakenOathAncestorStageViewPresentor
