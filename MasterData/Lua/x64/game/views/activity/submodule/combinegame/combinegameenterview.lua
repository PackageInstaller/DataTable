local CombineGameEnterView = class("CombineGameEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function CombineGameEnterView:GetUIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfMainUI"
end

function CombineGameEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameEnterView:InitUI()
	self:BindCfgUI()
end

function CombineGameEnterView:OnEnter()
	CombineGameEnterView.super.OnEnter(self)

	local var_4_0 = ActivityData:GetActivityData(CombineGameData:GetDataByPara("activityId"))

	self.startTime_ = var_4_0.startTime
	self.stopTime_ = var_4_0.stopTime

	self:AddTimer()
end

function CombineGameEnterView:OnExit()
	CombineGameEnterView.super.OnExit(self)
end

function CombineGameEnterView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGameMainView", {})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("COMBINE_GAME_EXPLAIN")
		})
	end)
end

return CombineGameEnterView
