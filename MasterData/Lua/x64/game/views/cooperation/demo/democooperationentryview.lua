local DemoCooperationEntryView = class("DemoCooperationEntryView", ReduxView)

function DemoCooperationEntryView:UIBackCount()
	return 2
end

function DemoCooperationEntryView:UIName()
	return "UI/Cooperation/Demo/DemoCooperationUI"
end

function DemoCooperationEntryView:UIParent()
	return manager.ui.uiMain.transform
end

function DemoCooperationEntryView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DemoCooperationEntryView:InitUI()
	self:BindCfgUI()
end

function DemoCooperationEntryView:AddUIListener()
	self:AddBtnListener(nil, self.m_createRoomBtn, function()
		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			local var_7_0 = {}

			var_7_0[1] = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, self.activity_id)

			CooperationAction.CreateRoom(self.activity_id, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, var_7_0)
		end
	end)
	self:AddBtnListener(nil, self.m_quickJoinBtn, function()
		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			local var_8_0 = {}

			var_8_0[1] = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, self.activity_id)

			CooperationAction.StartMatching(self.activity_id, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, var_8_0)
		end
	end)
	self:AddBtnListener(nil, self.m_inviteBtn, function()
		JumpTools.OpenPageByJump("cooperationApply", {
			room_type = BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO
		})
	end)
end

function DemoCooperationEntryView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function DemoCooperationEntryView:OnEnter()
	self.activity_id = ActivityConst.COOPERATION_DEMO
	self.m_stageName.text = GetI18NText(ActivityCooperationDemoCfg[self.activity_id].stage_name)
	self.m_stageDes.text = GetI18NText(ActivityCooperationDemoCfg[self.activity_id].stage_des)

	self:RefreshUI()
end

function DemoCooperationEntryView:RefreshUI()
	self.m_matchingLab.text = CooperationData:GetIsMatching() and GetTips("COOPERATION_MATCHING") or GetTips("COOPERATION_START_MATCH")
end

function DemoCooperationEntryView:OnExit()
	manager.windowBar:HideBar()

	if CooperationData:GetIsMatching() then
		CooperationAction.CancelMatching()
	end
end

function DemoCooperationEntryView:Dispose()
	DemoCooperationEntryView.super.Dispose(self)
end

function DemoCooperationEntryView:OnCooperationIsMatchingChange()
	self:RefreshUI()
end

return DemoCooperationEntryView
