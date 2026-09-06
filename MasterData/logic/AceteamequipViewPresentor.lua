-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamequipViewPresentor.lua

module("logic.extensions.aceteam.view.petshow.AceteamequipViewPresentor", package.seeall)

local AceteamequipViewPresentor = class("AceteamequipViewPresentor", ViewPresentor)

function AceteamequipViewPresentor:ctor()
	AceteamequipViewPresentor.super.ctor(self)
end

function AceteamequipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamequipViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamequipview.prefab"
	}
end

function AceteamequipViewPresentor:buildViews()
	return {
		AceteamequipView.New()
	}
end

function AceteamequipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteamequipViewPresentor
