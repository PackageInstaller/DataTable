local ActivityInviteEnterView = class("ActivityInviteEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivityInviteEnterView:GetUIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionConMainUI"
end

function ActivityInviteEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityInviteEnterView:InitUI()
	self:BindCfgUI()
end

function ActivityInviteEnterView:OnEnter()
	local var_4_0 = ActivityData:GetActivityData(InviteData:GetDataByPara("activityId"))

	self.startTime_ = var_4_0.startTime
	self.stopTime_ = var_4_0.stopTime

	self:AddTimer()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.INVITE_MAIN, {
		x = 150,
		y = 35
	})

	self.descTxt_.text = GetTips("ACTIVITY_INVITE_DECORATE")
end

function ActivityInviteEnterView:OnExit()
	ActivityInviteEnterView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.INVITE_MAIN)
end

function ActivityInviteEnterView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_7_0 = InviteData:GetDataByPara("selectHeroIndex")

		if InviteData:GetDataByPara("allComplete") then
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = 1
			})
		elseif var_7_0 then
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = var_7_0
			})
		else
			JumpTools.GoToSystem("/ActivityInviteMain", {})
		end
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_INVITE_DESCRIPTION")
		})
	end)
end

return ActivityInviteEnterView
