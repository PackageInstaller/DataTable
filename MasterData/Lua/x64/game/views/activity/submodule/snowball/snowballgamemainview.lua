local SnowballGameMainView = class("SnowballGameMainView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function SnowballGameMainView:GetUIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballMainUI"
end

function SnowballGameMainView:Ctor(arg_2_1, arg_2_2)
	SnowballGameMainView.super.Ctor(self, arg_2_1, self:GetActivityID())
end

local function var_0_1(arg_3_0)
	return AssignmentCfg[arg_3_0.id].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY or AssignmentCfg[arg_3_0.id].type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE
end

function SnowballGameMainView:Init()
	self:BindCfgUI()

	self.questSubView = ActivityQuestSubView.New(self.gameObject_, SnowballGameData.activityID, var_0_1, SnowballQuestItem, true)
	self.stateControler = ControllerUtil.GetController(self.transform_, "state")

	self:AddBtnListener(self.startBtn_, nil, function()
		if self:IsActivityTime() then
			DormMinigame.Launch("HZ07_xueqiu1")
		end
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		local var_6_0 = {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SNOWBALL_DESC")
		}

		var_6_0.key = "ACTIVITY_SNOWBALL_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_6_0)
	end)
end

function SnowballGameMainView:Dispose()
	self.questSubView:Dispose()
	SnowballGameMainView.super.Dispose(self)
end

function SnowballGameMainView:OnEnter()
	SnowballGameMainView.super.OnEnter(self)
	self.questSubView:OnEnter()
	manager.redPoint:bindUIandKey(self.startBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME)
end

function SnowballGameMainView:OnExit()
	SnowballGameMainView.super.OnExit(self)
	self.questSubView:OnExit()
	manager.redPoint:unbindUIandKey(self.startBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME)
end

function SnowballGameMainView:GetActivityID()
	return SnowballGameData.activityID
end

function SnowballGameMainView:RefreshUI()
	self:RefreshTimeText()

	if ActivityTools.GetActivityStatus(self:GetActivityID()) == 1 then
		self.stateController:SetSelectedState("unlock")
	else
		self.stateController:SetSelectedState("close")
	end
end

function SnowballGameMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN,
		MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN
	})
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN, true)
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN, true)
end

return SnowballGameMainView
