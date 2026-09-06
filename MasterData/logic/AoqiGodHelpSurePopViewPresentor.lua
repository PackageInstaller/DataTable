-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodHelpSurePopViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodHelpSurePopViewPresentor", package.seeall)

local AoqiGodHelpSurePopViewPresentor = class("AoqiGodHelpSurePopViewPresentor", ViewPresentor)

function AoqiGodHelpSurePopViewPresentor:ctor()
	AoqiGodHelpSurePopViewPresentor.super.ctor(self)
end

function AoqiGodHelpSurePopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodHelpSurePopViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodhelpsurepopview.prefab"
	}
end

function AoqiGodHelpSurePopViewPresentor:buildViews()
	return {
		AoqiGodHelpSurePopView.New()
	}
end

return AoqiGodHelpSurePopViewPresentor
