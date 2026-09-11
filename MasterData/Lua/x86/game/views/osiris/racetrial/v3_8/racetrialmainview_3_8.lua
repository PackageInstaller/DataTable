local RaceTrialMainView_3_8 = class("RaceTrialMainView_3_8", ActivityMainBasePanel)

function RaceTrialMainView_3_8:GetUIName()
	return RaceTrialTools.GetMainUIName(self.activityID_)
end

function RaceTrialMainView_3_8:UIParent()
	return manager.ui.uiMain.transform
end

function RaceTrialMainView_3_8:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RaceTrialMainView_3_8:InitUI()
	self:BindCfgUI()
end

function RaceTrialMainView_3_8:AddUIListeners()
	self:AddBtnListener(self.m_descBtn, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")
		})
	end)
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		if not self:IsActivityTime(self.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("/raceTrialEnter", {
			activityID = self.activityID_
		})
	end)
end

function RaceTrialMainView_3_8:OnEnter()
	manager.redPoint:bindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, self.activityID_))
	RaceTrialMainView_3_8.super.OnEnter(self)
end

function RaceTrialMainView_3_8:RefreshTimeText()
	if self.m_timeLab then
		self.m_timeLab.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

function RaceTrialMainView_3_8:OnExit()
	manager.redPoint:unbindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, self.activityID_))
	RaceTrialMainView_3_8.super.OnExit(self)
end

function RaceTrialMainView_3_8:Dispose()
	self:RemoveAllListeners()
	RaceTrialMainView_3_8.super.Dispose(self)
end

return RaceTrialMainView_3_8
