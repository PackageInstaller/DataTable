SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local var_0_0 = class("SPKailiChallengeSectionView", SectionBaseView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(arg_1_0.threeStarGo_)
end

function var_0_0.UIName(arg_2_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/KaliChapterSectionInfoUI"
end

function var_0_0.RefreshRewardItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.rewardList_[arg_3_1]
	local var_3_1

	if var_3_0 then
		var_3_1 = rewardToItemTemplate(var_3_0)
		var_3_1.number = var_3_0.num or 0

		function var_3_1.clickFun(arg_4_0)
			ShowPopItem(POP_ITEM, arg_4_0)
		end
	end

	arg_3_2:SetData(var_3_1)
end

function var_0_0.RefreshData(arg_5_0)
	local var_5_0 = arg_5_0.params_.stageID or 0
	local var_5_1 = BattleCoreKaliCfg[var_5_0]

	arg_5_0.sectionName_.text = var_5_1 and var_5_1.name

	local var_5_2 = ActivityCfg.get_id_list_by_sub_activity_list[arg_5_0.params_.activityID][1]
	local var_5_3 = SPKaliChallengeData:GetStageData(var_5_2, arg_5_0.params_.stageID)

	arg_5_0.threeStarDataList_ = {
		{
			var_5_3,
			{
				8
			}
		},
		{
			false
		},
		{
			false
		}
	}

	arg_5_0.sectionInfoThreeStarBar_:SetData(arg_5_0.threeStarDataList_)

	arg_5_0.isFirstClear_ = not var_5_3
	arg_5_0.dropLibID_ = BattleCoreKaliCfg[var_5_0].drop_lib_id
	arg_5_0.cost_ = var_5_1.cost or 0
	arg_5_0.multiple_ = 1
	arg_5_0.lock_ = not arg_5_0.params_.lock

	if not ActivityData:GetActivityIsOpen(arg_5_0.params_.activityID) then
		local var_5_4 = ActivityData:GetActivityData(arg_5_0.params_.activityID)

		if var_5_4 and var_5_4.startTime and arg_5_0.params_.prePass then
			arg_5_0.lockTips_ = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_5_4.startTime))
		else
			arg_5_0.lockTips_ = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
		end
	else
		arg_5_0.lockTips_ = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
	end

	arg_5_0.storyText_.text = var_5_1.tips
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.battleBtn_, nil, function()
		arg_6_0:Back()
		arg_6_0:OnClickBtn()
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	var_0_0.super.OnEnter(arg_9_0)
end

function var_0_0.RefreshTitleDesc(arg_10_0)
	return
end

function var_0_0.UpdateBar(arg_11_0)
	return
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.hideThreeStarController_:SetSelectedState("false")
	arg_12_0.hideStageDescController_:SetSelectedState("false")
	arg_12_0.hideFatigueController_:SetSelectedState("close")
	arg_12_0:RefreshReward()
	arg_12_0:RefreshCost()

	if arg_12_0.lock_ then
		arg_12_0.btnLockText_.text = arg_12_0.lockTips_

		arg_12_0.btnController_:SetSelectedState("true")
	else
		arg_12_0.btnController_:SetSelectedState("false")
	end

	if arg_12_0.isFirstClear_ then
		arg_12_0.rewardTitleText_.text = GetTips("FIRST_DROP")
	else
		arg_12_0.rewardTitleText_.text = GetTips("ACTIVITY_KALI_REWARD_DES")
	end
end

function var_0_0.HaveCostCntFlag(arg_13_0)
	return false
end

function var_0_0.OnClickBtn(arg_14_0)
	arg_14_0:GoToSelectHero()
end

function var_0_0.GoToSelectHero(arg_15_0)
	arg_15_0:Go("/sectionSelectHero", {
		section = arg_15_0.params_.stageID,
		sectionType = arg_15_0.params_.sectionType,
		activityID = arg_15_0.params_.activityID
	})
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.sectionInfoThreeStarBar_:Dispose()

	arg_16_0.sectionInfoThreeStarBar_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
