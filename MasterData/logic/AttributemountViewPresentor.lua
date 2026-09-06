-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/AttributemountViewPresentor.lua

module("logic.extensions.bonus.view.christmasandnewyear.AttributemountViewPresentor", package.seeall)

local AttributemountViewPresentor = class("AttributemountViewPresentor", ViewPresentor)

function AttributemountViewPresentor:ctor()
	AttributemountViewPresentor.super.ctor(self)
end

function AttributemountViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AttributemountViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/rarepropsview.prefab"
	}
end

function AttributemountViewPresentor:buildViews()
	return {
		AttributemountView.New()
	}
end

return AttributemountViewPresentor
