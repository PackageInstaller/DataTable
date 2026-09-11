local SPHeroChallengeScheduleDailyItem = class("SPHeroChallengeScheduleDailyItem", ReduxView)

function SPHeroChallengeScheduleDailyItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = GameObject.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform
	self.scheduleID = arg_1_3

	self:Init()
end

function SPHeroChallengeScheduleDailyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeScheduleDailyItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
	self.sliderController = self.controller:GetController("infinite")
	self.selectController = self.controller:GetController("Selected")
end

function SPHeroChallengeScheduleDailyItem:RefreshUI()
	self.selectController:SetSelectedState("Unselected")
	self:RefreshBaseInfo(self.scheduleID)

	local var_4_0, var_4_1, var_4_2 = SPHeroChallengeTools:CheckScheduleCanAddInlist(self.scheduleID)

	self.state = var_4_2

	local var_4_3, var_4_4 = SPHeroChallengeTools:GetScheduleProgress(self.scheduleID)

	self.sliderController:SetSelectedState("normal")

	if var_4_3 < 0 then
		self.sliderController:SetSelectedState("infinite")

		self.progressText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_INFINITE")
	else
		self.sliderSlr_.value = math.min(var_4_3 / var_4_4, 1)
		self.progressText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_PROGRESS"), var_4_3, var_4_4)
	end

	if self.state == "finish" then
		self.stateController:SetSelectedState("finish")

		return true
	elseif self.state == "unlock" then
		self.stateController:SetSelectedState("unlock")
	elseif self.state == "lock" then
		self.lockdescText_.text = var_4_1

		self.stateController:SetSelectedState("lock")
	end
end

function SPHeroChallengeScheduleDailyItem:RefreshBaseInfo(arg_5_1)
	self.scheduleID = arg_5_1
	self.iconImg_.sprite = SPHeroChallengeTools:GetScheduleIcon(arg_5_1)
	self.name.text = ActivityHeroChallengeScheduleCfg[arg_5_1].name
	self.desc.text = ActivityHeroChallengeScheduleCfg[arg_5_1].linkgame_des

	local var_5_0 = SPHeroChallengeTools:GetSameScheduleNum(arg_5_1)

	if var_5_0 > 0 then
		self.selectController:SetSelectedState("Selected")

		self.numText_.text = "x" .. var_5_0
	else
		self.numText_.text = ""
	end
end

function SPHeroChallengeScheduleDailyItem:AddUIListener()
	self:AddBtnListener(self.itemBtn, nil, function()
		local var_7_0, var_7_1 = SPHeroChallengeTools:CheckScheduleCanAddInlist(self.scheduleID)

		if var_7_0 then
			local var_7_2 = SPHeroChallengeData:GetCurActivityInfo(self.scheduleID)

			if var_7_2 then
				var_7_2:AddScheduleInDailyList(self.scheduleID)
			end
		elseif var_7_1 then
			ShowTips(var_7_1)
		end
	end)
end

function SPHeroChallengeScheduleDailyItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil
	self.scheduleID = nil

	SPHeroChallengeScheduleDailyItem.super.Dispose(self)
end

return SPHeroChallengeScheduleDailyItem
