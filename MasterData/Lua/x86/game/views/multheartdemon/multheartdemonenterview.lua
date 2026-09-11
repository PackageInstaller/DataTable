local MultHeartDemonEnterView = class("MultHeartDemonEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function MultHeartDemonEnterView:GetUIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_MultMain"
end

function MultHeartDemonEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonEnterView:InitUI()
	self:BindCfgUI()

	self.Controller = ControllerUtil.GetController(self.gameObject_.transform, "lock")
end

function MultHeartDemonEnterView:OnEnter()
	MultHeartDemonEnterView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.MULT_HEART_DEMON)
	self:UpdateView()
	self:HideRedPoint()
	self:AddTimer()
end

function MultHeartDemonEnterView:HideRedPoint()
	MultHeartDemonAction.UpdateEnterRedPoint(self.activityId)
end

function MultHeartDemonEnterView:RefreshTimeText()
	local var_6_0, var_6_1 = self:CheckAdvanceOpenTime()

	self.remainTxt_.text = var_6_1
end

function MultHeartDemonEnterView:UpdateView()
	self.titleTxt_.text = GetTips("MULTI_HEART_DEMON_NAME")
	self.describeTxt_.text = GetTips("MULTI_HEART_DEMON_DESC")

	self.Controller:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) and "lock" or "unlock")
end

function MultHeartDemonEnterView:OnExit()
	MultHeartDemonEnterView.super.OnExit(self)
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.MULT_HEART_DEMON)
end

function MultHeartDemonEnterView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON) then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON)[2]))
		else
			JumpTools.GoToSystem("/multHeartDemonMain", {
				activityId = self.activityId
			})
			MultHeartDemonAction.UpdateViewRedPoint()
		end
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("MULTI_HEART_DEMON_GAMEPLAY_DESC")
		})
	end)
end

return MultHeartDemonEnterView
