-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/AutopopViewPresentor.lua

module("logic.extensions.bonus.view.AutopopViewPresentor", package.seeall)

local AutopopViewPresentor = class("AutopopViewPresentor", ViewPresentor)

function AutopopViewPresentor:ctor()
	AutopopViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.BonusViewPriority
end

function AutopopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AutopopViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/autopopview.prefab"
	}
end

function AutopopViewPresentor:buildViews()
	return {
		AutopopView.New()
	}
end

return AutopopViewPresentor
