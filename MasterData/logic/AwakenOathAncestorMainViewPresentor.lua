-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/view/AwakenOathAncestorMainViewPresentor.lua

module("logic.extensions.awakenoathancestor.view.AwakenOathAncestorMainViewPresentor", package.seeall)

local AwakenOathAncestorMainViewPresentor = class("AwakenOathAncestorMainViewPresentor", ViewPresentor)

function AwakenOathAncestorMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AwakenOathAncestorMainViewPresentor:dependWhatResources()
	return {
		"ui/views/awakenoathancestor/awakenoathancestormainview.prefab"
	}
end

function AwakenOathAncestorMainViewPresentor:buildViews()
	return {
		AwakenOathAncestorMainView.New()
	}
end

return AwakenOathAncestorMainViewPresentor
