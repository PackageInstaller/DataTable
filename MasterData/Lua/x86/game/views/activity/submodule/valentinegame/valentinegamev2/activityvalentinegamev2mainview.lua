ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityValentineGameV2MainView = class("ActivityValentineGameV2MainView", ActivityMainBasePanel)
local var_0_1 = "ACTIVITY_VALENTINE_DESCRIBE"

function ActivityValentineGameV2MainView:GetUIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineActivityMainUI"
end

function ActivityValentineGameV2MainView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/valentineGameV2SelectHeroView", {
			activityID = ActivityConst.INDIA_VALENTINE_GAME_V2
		})
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(var_0_1),
			key = var_0_1
		})
	end)
end

function ActivityValentineGameV2MainView:OnEnter()
	ActivityValentineGameV2MainView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.btn_.transform, RedPointConst.VALENTINE_GAME .. "_" .. self.activityID_)
end

function ActivityValentineGameV2MainView:OnExit()
	ActivityValentineGameV2MainView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btn_.transform, RedPointConst.VALENTINE_GAME .. "_" .. self.activityID_)
end

return ActivityValentineGameV2MainView
