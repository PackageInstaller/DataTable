-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/CallHeroDrawViewPresentor.lua

module("logic.extensions.lottery.view.CallHeroDrawViewPresentor", package.seeall)

local CallHeroDrawViewPresentor = class("CallHeroDrawViewPresentor", ViewPresentor)

function CallHeroDrawViewPresentor:ctor()
	CallHeroDrawViewPresentor.super.ctor(self)
end

function CallHeroDrawViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CallHeroDrawViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/drawview.prefab"
	}
end

function CallHeroDrawViewPresentor:buildViews()
	return {
		CallHeroDrawView.New()
	}
end

return CallHeroDrawViewPresentor
