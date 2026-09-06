-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/AssociatePetTipViewPresentor.lua

module("logic.extensions.handbook.view.AssociatePetTipViewPresentor", package.seeall)

local AssociatePetTipViewPresentor = class("AssociatePetTipViewPresentor", ViewPresentor)

function AssociatePetTipViewPresentor:ctor()
	AssociatePetTipViewPresentor.super.ctor(self)
end

function AssociatePetTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssociatePetTipViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/associatepet_tip.prefab"
	}
end

function AssociatePetTipViewPresentor:buildViews()
	return {
		AssociatePetTipView.New()
	}
end

function AssociatePetTipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function AssociatePetTipViewPresentor:playCloseAnimation()
	self:_onCloseAnimationDone()
end

return AssociatePetTipViewPresentor
