-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamHolyStripeViewPresentor.lua

module("logic.extensions.aceteam.view.petshow.AceteamHolyStripeViewPresentor", package.seeall)

local AceteamHolyStripeViewPresentor = class("AceteamHolyStripeViewPresentor", ViewPresentor)

function AceteamHolyStripeViewPresentor:ctor()
	AceteamHolyStripeViewPresentor.super.ctor(self)
end

function AceteamHolyStripeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamHolyStripeViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamholystripeview.prefab"
	}
end

function AceteamHolyStripeViewPresentor:buildViews()
	return {
		AceteamHolyStripeMainView.New(),
		AceteamHolyStripeSuitView.New()
	}
end

function AceteamHolyStripeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteamHolyStripeViewPresentor
