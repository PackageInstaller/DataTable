-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodFinishPopViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodFinishPopViewPresentor", package.seeall)

local AoqiGodFinishPopViewPresentor = class("AoqiGodFinishPopViewPresentor", ViewPresentor)

function AoqiGodFinishPopViewPresentor:ctor()
	AoqiGodFinishPopViewPresentor.super.ctor(self)
end

function AoqiGodFinishPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodFinishPopViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodfinishpopview.prefab"
	}
end

function AoqiGodFinishPopViewPresentor:buildViews()
	return {
		AoqiGodFinishPopView.New()
	}
end

return AoqiGodFinishPopViewPresentor
