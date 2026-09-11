local SlayerMainView_2_4 = class("SlayerMainView_2_4", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function SlayerMainView_2_4:GetUIName()
	return SlayerTools.GetMainUIName(self.activityID_ or 0)
end

function SlayerMainView_2_4:AddListeners()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("slayerRewardView_1_7", {
			slayer_activity_id = self.activityID_
		})
	end)
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		if not ActivityTools.GetActivityIsOpenWithTip(self.activityID_, true) then
			return
		end

		JumpTools.OpenPageByJump("/slayerStageView_2_4", {
			init_tag = true,
			slayer_activity_id = self.activityID_
		})
	end)
	self:AddBtnListener(self.m_descBtn, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SLAYER_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SLAYER_DESCRIBE")
		})
	end)
end

function SlayerMainView_2_4:OnEnter()
	SlayerMainView_2_4.super.OnEnter(self)

	if self.descText_ then
		self.descText_.text = GetTips("ACTIVITY_SLAYER_GENERAL_DESCRIBE")
	end

	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, self.activityID_))
	manager.redPoint:bindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.activityID_))
end

function SlayerMainView_2_4:OnExit()
	SlayerMainView_2_4.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, self.activityID_))
	manager.redPoint:unbindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.activityID_))
end

function SlayerMainView_2_4:RefreshTimeText()
	if self.m_timeLab then
		self.m_timeLab.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

return SlayerMainView_2_4
