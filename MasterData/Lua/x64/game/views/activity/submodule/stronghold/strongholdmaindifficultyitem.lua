local StrongholdMainDifficultyItem = class("StrongholdMainDifficultyItem", ReduxView)

function StrongholdMainDifficultyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdMainDifficultyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdMainDifficultyItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
end

function StrongholdMainDifficultyItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		if self.clickFunc then
			if CooperationData:GetIsMatching() then
				ShowTips("ERROR_COORDINATOR_ALREADY_IN_MATCH")

				return
			end

			local var_5_0, var_5_1 = self:CheckCondition()

			if not var_5_0 then
				ShowTips(var_5_1)

				return
			end

			self.clickFunc(self.id)
		end
	end)
end

function StrongholdMainDifficultyItem:SetData(arg_6_1, arg_6_2)
	self.main_id = arg_6_1
	self.id = arg_6_2
	self.all_increase_lv = StrongholdData:GetAllIncreaseLevel(self.main_id)
	self.m_lab.text = ActivityStrongholdCfg[arg_6_2].difficulty_des

	self:RefreshTime()
end

function StrongholdMainDifficultyItem:SetSelect(arg_7_1)
	self.selectController:SetSelectedIndex(arg_7_1 == self.id and 1 or 0)
end

function StrongholdMainDifficultyItem:RefreshTime()
	local var_8_0, var_8_1 = self:CheckCondition()

	if var_8_0 then
		self.lockController:SetSelectedIndex(0)
	elseif self.id == 182203 then
		self.m_timeLab.text = var_8_1

		self.lockController:SetSelectedIndex(1)
	else
		self.m_lab.text = ActivityStrongholdCfg[self.id].difficulty_des .. "-" .. var_8_1

		self.lockController:SetSelectedIndex(0)
	end
end

function StrongholdMainDifficultyItem:CheckCondition()
	if ActivityData:GetActivityIsOpen(self.id) then
		if ActivityStrongholdCfg[self.id].limit_increase_all_lv > self.all_increase_lv then
			return false, GetTips(string.format(GetTips("ACTIVITY_STRONGHOLD_DIFFICULTY_LOCK_INCREASE"), ActivityStrongholdCfg[self.id].limit_increase_all_lv))
		end
	else
		local var_9_0 = ActivityData:GetActivityData(self.id)

		if var_9_0 and manager.time:GetServerTime() < var_9_0.startTime then
			return false, GetTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_9_0.startTime)))
		else
			return false, GetTips("TIME_OUT")
		end
	end

	return true, ""
end

function StrongholdMainDifficultyItem:RegistCallBack(arg_10_1)
	self.clickFunc = arg_10_1
end

return StrongholdMainDifficultyItem
