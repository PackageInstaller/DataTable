-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/ActivityPopupViewPresentor.lua

module("logic.extensions.activitypopup.view.ActivityPopupViewPresentor", package.seeall)

local ActivityPopupViewPresentor = class("ActivityPopupViewPresentor", ViewPresentor)

ActivityPopupViewPresentor.HdCommonView = "ui/views/activitypopup/hdcommonview.prefab"

function ActivityPopupViewPresentor:ctor()
	ActivityPopupViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PopupWindowViewPriority
end

function ActivityPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ActivityPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/activitypopupview.prefab",
		ActivityPopupViewPresentor.HdCommonView
	}
end

function ActivityPopupViewPresentor:getTempResources()
	local paths = {}
	local cfg = ActivityPopupModel.instance:getFirstCommonCfgInTime()

	if cfg then
		if not string.nilorempty(cfg.iconName) then
			table.insert(paths, string.format("ui/bigbg/activitypopup/%s.png", cfg.iconName))
		end

		if not string.nilorempty(cfg.btnIcon) then
			table.insert(paths, string.format("ui/icon/activitypopup/%s.png", cfg.btnIcon))
		end
	end

	return paths
end

function ActivityPopupViewPresentor:buildViews()
	return {
		ActivityPopupView.New()
	}
end

return ActivityPopupViewPresentor
