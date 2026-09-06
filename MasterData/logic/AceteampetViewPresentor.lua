-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteampetViewPresentor.lua

module("logic.extensions.aceteam.view.AceteampetViewPresentor", package.seeall)

local AceteampetViewPresentor = class("AceteampetViewPresentor", ViewPresentor)

function AceteampetViewPresentor:ctor()
	AceteampetViewPresentor.super.ctor(self)
end

function AceteampetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteampetViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteampetview.prefab"
	}
end

function AceteampetViewPresentor:buildViews()
	return {
		AceteampetView.New()
	}
end

function AceteampetViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteampetViewPresentor
