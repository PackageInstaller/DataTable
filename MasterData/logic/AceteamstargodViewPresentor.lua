-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamstargodViewPresentor.lua

module("logic.extensions.aceteam.view.petshow.AceteamstargodViewPresentor", package.seeall)

local AceteamstargodViewPresentor = class("AceteamstargodViewPresentor", ViewPresentor)

function AceteamstargodViewPresentor:ctor()
	AceteamstargodViewPresentor.super.ctor(self)
end

function AceteamstargodViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamstargodViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamstargodview.prefab"
	}
end

function AceteamstargodViewPresentor:buildViews()
	return {
		AceteamstargodView.New()
	}
end

function AceteamstargodViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteamstargodViewPresentor
