local HeroTrialView_1_7 = class("HeroTrialView_1_7", (import("game.views.heroTrialActivity.HeroTrialActivityView")))

function HeroTrialView_1_7:UIName()
	return "UI/VersionUI/DarkFlameUI/DFHeroTrialUI/DFHeroTrialUI"
end

function HeroTrialView_1_7:AddListeners()
	self:AddBtnListener(self.btnReceive_, nil, function()
		HeroTrialAction.GetTrialReward(self.selectActivityHeroID_, function(arg_4_0)
			if isSuccess(arg_4_0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list))
				self:RefreshReward(self.selectActivityHeroID_)
			else
				ShowTips(arg_4_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.btnTrial_, nil, function()
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs(self.activityHeroIDList_) do
			table.insert(var_5_0, HeroTrialTools.GetHeroStandardID(iter_5_1))
		end

		self:Go("/newHero", {
			isEnter = true,
			isTemp = true,
			hid = HeroTrialTools.GetHeroStandardID(self.selectActivityHeroID_),
			tempHeroList = var_5_0
		})
	end)
	self:AddBtnListener(self.btnBattle_, nil, function()
		HeroTrialData:SaveStageID(self.selectActivityHeroID_)
		self:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[self.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = self.activityID_
		})
	end)
end

function HeroTrialView_1_7:RefreshTextName(arg_7_1)
	local var_7_0 = string.split(arg_7_1, "·")

	self.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", GetI18NText(var_7_0[1]), GetI18NText(var_7_0[2]))
end

function HeroTrialView_1_7:GetRewardItem(arg_8_1)
	return HeroTrialRewardItem_1_7.New(self.goRewardPanel_, self.rewardItemGo_, arg_8_1, true)
end

function HeroTrialView_1_7:RefreshReward(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(ActivityHeroTrialCfg[arg_9_1].reward_list) do
		if self.rewardItemList_[iter_9_0] then
			self.rewardItemList_[iter_9_0]:SetData(iter_9_1, false)
		else
			self.rewardItemList_[iter_9_0] = self:GetRewardItem(iter_9_1)
		end
	end

	for iter_9_2 = #ActivityHeroTrialCfg[arg_9_1].reward_list + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_9_2]:Show(false)
	end

	local var_9_0 = HeroTrialData:GetHeroTrialStateList()[arg_9_1]

	if var_9_0 then
		if var_9_0 == 1 then
			self.controller_:SetSelectedState("receive")
		elseif var_9_0 == 2 then
			self.controller_:SetSelectedState("complete")
		else
			self.controller_:SetSelectedState("not")
		end
	else
		self.controller_:SetSelectedState("not")
	end

	for iter_9_3 = 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_9_3]:RefreshReceive(var_9_0 == 2 and true or false)
	end
end

return HeroTrialView_1_7
