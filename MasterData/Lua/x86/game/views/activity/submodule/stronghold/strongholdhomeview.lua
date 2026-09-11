ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local StrongholdHomeView = class("StrongholdHomeView", ActivityMainBasePanel)

function StrongholdHomeView:GetUIName()
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdHomeUI"
end

function StrongholdHomeView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function StrongholdHomeView:AddUIListener()
	self:AddBtnListener(self.m_statrBtn, nil, function()
		if not self:IsActivityTime() then
			return
		end

		JumpTools.GoToSystem("/cooperationBlank/strongholdMain")
	end)
	self:AddBtnListener(self.m_tipBtn, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_STRONGHOLD_DES"),
			key = self.gameHelpKey
		})
	end)
end

function StrongholdHomeView:OnEnter()
	StrongholdHomeView.super.OnEnter(self)
end

function StrongholdHomeView:OnExit()
	StrongholdHomeView.super.OnExit(self)
end

return StrongholdHomeView
