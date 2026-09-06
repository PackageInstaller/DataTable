-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamawakeViewPresentor.lua

module("logic.extensions.aceteam.view.petshow.AceteamawakeViewPresentor", package.seeall)

local AceteamawakeViewPresentor = class("AceteamawakeViewPresentor", ViewPresentor)

function AceteamawakeViewPresentor:ctor()
	AceteamawakeViewPresentor.super.ctor(self)
end

function AceteamawakeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamawakeViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamawakeview.prefab"
	}
end

function AceteamawakeViewPresentor:buildViews()
	return {
		AceteamawakeView.New()
	}
end

function AceteamawakeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteamawakeViewPresentor
