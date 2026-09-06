-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/two/AresMomTypeTwoViewPresentor.lua

module("logic.extensions.aresmom.view.two.AresMomTypeTwoViewPresentor", package.seeall)

local AresMomTypeTwoViewPresentor = class("AresMomTypeTwoViewPresentor", AresMomTypeViewPresentor)

function AresMomTypeTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/two/aresmomtypetwoview.prefab"
	}
end

function AresMomTypeTwoViewPresentor:buildViews()
	return {
		AresMomTypeTwoView.New()
	}
end

return AresMomTypeTwoViewPresentor
