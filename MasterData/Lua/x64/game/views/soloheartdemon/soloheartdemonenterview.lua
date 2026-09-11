local SoloHeartDemonEnterView = class("SoloHeartDemonEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function SoloHeartDemonEnterView:GetUIName()
	return "Widget/System/Challenge_SoloHeartDemonUI/JapanRegionSoloMain"
end

function SoloHeartDemonEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SoloHeartDemonEnterView:InitUI()
	self:BindCfgUI()

	self.Controller = ControllerUtil.GetController(self.gameObject_.transform, "lock")
end

function SoloHeartDemonEnterView:OnEnter()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.SOLO_HEART_DEMON)
	self:UpdateView()
	self:HideRedPoint()
end

function SoloHeartDemonEnterView:UpdateView()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self.remainTime = 0

	for iter_5_0, iter_5_1 in pairs(ActivityCfg.get_id_list_by_activity_template[270]) do
		if ActivityData:GetActivityIsOpen(iter_5_1) then
			self.activityId = iter_5_1

			break
		end
	end

	self.remainTime = ActivityData:GetActivityData(self.activityID_).stopTime
	self.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.remainTime, true)
	self.updateTimer_ = Timer.New(function()
		self.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.remainTime, true)
	end, 1, self.remainTime - manager.time:GetServerTime() + 1, 1)

	self.updateTimer_:Start()

	self.describeTxt_.text = GetTips("SOLO_HEART_DEMON_ENTER_DESCRIBE")

	self.Controller:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) and "lock" or "unlock")
end

function SoloHeartDemonEnterView:HideRedPoint()
	SoloHeartDemonAction.UpdateEnterRedPoint(self.activityId)
end

function SoloHeartDemonEnterView:OnExit()
	SoloHeartDemonEnterView.super.OnExit(self)

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.SOLO_HEART_DEMON)
end

function SoloHeartDemonEnterView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON)[2]))
		elseif ActivityData:GetActivityIsOpen(ActivityConst.SOLO_HEART_DEMON) == false then
			ShowTips("SOLO_HEART_DEMON_CLOSED")
		else
			JumpTools.GoToSystem("/soloHeartDemonMain", {
				activityId = self.activityId
			})
			SoloHeartDemonAction.UpdateViewRedPoint()
		end
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "SOLO_HEART_DEMON_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("SOLO_HEART_DEMON_EXPLAIN")
		})
	end)
end

return SoloHeartDemonEnterView
