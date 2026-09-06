-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/two/AresMomMainTwoViewPresentor.lua

module("logic.extensions.aresmom.view.two.AresMomMainTwoViewPresentor", package.seeall)

local AresMomMainTwoViewPresentor = class("AresMomMainTwoViewPresentor", AresMomMainViewPresentor)

function AresMomMainTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/two/aresmommaintwoview.prefab"
	}
end

function AresMomMainTwoViewPresentor:buildViews()
	return {
		AresMomMainTwoView.New()
	}
end

return AresMomMainTwoViewPresentor
