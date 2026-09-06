-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/two/AresMomGameTwoViewPresentor.lua

module("logic.extensions.aresmom.view.two.AresMomGameTwoViewPresentor", package.seeall)

local AresMomGameTwoViewPresentor = class("AresMomGameTwoViewPresentor", AresMomGameViewPresentor)

function AresMomGameTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/two/aresmomgametwoview.prefab"
	}
end

function AresMomGameTwoViewPresentor:buildViews()
	return {
		AresMomGameTwoView.New()
	}
end

return AresMomGameTwoViewPresentor
