local var_0_0 = import("game.views.heroTrialActivity.HeroTrialActivityView")
local var_0_1 = class("HeroTrialView_1_7", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFHeroTrialUI/DFHeroTrialUI"
end

function var_0_1.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btnReceive_, nil, function()
		HeroTrialAction.GetTrialReward(arg_2_0.selectActivityHeroID_, function(arg_4_0)
			if isSuccess(arg_4_0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[arg_2_0.selectActivityHeroID_].reward_list))
				arg_2_0:RefreshReward(arg_2_0.selectActivityHeroID_)
			else
				ShowTips(arg_4_0.result)
			end
		end)
	end)
	arg_2_0:AddBtnListener(arg_2_0.btnTrial_, nil, function()
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs(arg_2_0.activityHeroIDList_) do
			table.insert(var_5_0, HeroTrialTools.GetHeroStandardID(iter_5_1))
		end

		arg_2_0:Go("/newHero", {
			isEnter = true,
			isTemp = true,
			hid = HeroTrialTools.GetHeroStandardID(arg_2_0.selectActivityHeroID_),
			tempHeroList = var_5_0
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.btnBattle_, nil, function()
		HeroTrialData:SaveStageID(arg_2_0.selectActivityHeroID_)
		arg_2_0:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[arg_2_0.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = arg_2_0.activityID_
		})
	end)
end

function var_0_1.RefreshTextName(arg_7_0, arg_7_1)
	local var_7_0 = string.split(arg_7_1, "·")

	arg_7_0.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", GetI18NText(var_7_0[1]), GetI18NText(var_7_0[2]))
end

function var_0_1.GetRewardItem(arg_8_0, arg_8_1)
	return HeroTrialRewardItem_1_7.New(arg_8_0.goRewardPanel_, arg_8_0.rewardItemGo_, arg_8_1, true)
end

function var_0_1.RefreshReward(arg_9_0, arg_9_1)
	local var_9_0 = ActivityHeroTrialCfg[arg_9_1].reward_list

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if arg_9_0.rewardItemList_[iter_9_0] then
			arg_9_0.rewardItemList_[iter_9_0]:SetData(iter_9_1, false)
		else
			arg_9_0.rewardItemList_[iter_9_0] = arg_9_0:GetRewardItem(iter_9_1)
		end
	end

	for iter_9_2 = #var_9_0 + 1, #arg_9_0.rewardItemList_ do
		arg_9_0.rewardItemList_[iter_9_2]:Show(false)
	end

	local var_9_1 = HeroTrialData:GetHeroTrialStateList()[arg_9_1]

	if var_9_1 then
		if var_9_1 == 1 then
			arg_9_0.controller_:SetSelectedState("receive")
		elseif var_9_1 == 2 then
			arg_9_0.controller_:SetSelectedState("complete")
		else
			arg_9_0.controller_:SetSelectedState("not")
		end
	else
		arg_9_0.controller_:SetSelectedState("not")
	end

	for iter_9_3 = 1, #arg_9_0.rewardItemList_ do
		arg_9_0.rewardItemList_[iter_9_3]:RefreshReceive(var_9_1 == 2 and true or false)
	end
end

return var_0_1
