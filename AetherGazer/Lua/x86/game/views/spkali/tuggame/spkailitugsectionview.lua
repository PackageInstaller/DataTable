SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local var_0_0 = class("SPKailiTugSectionView", SectionBaseView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	arg_1_0.hideStageDescController_:SetSelectedState("true")

	arg_1_0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(arg_1_0.threeStarGo_)

	arg_1_0.hideFatigueController_:SetSelectedState("close")
end

function var_0_0.RefreshRewardItem(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.rewardList_[arg_2_1]
	local var_2_1

	if var_2_0 then
		var_2_1 = rewardToItemTemplate(var_2_0)
		var_2_1.number = var_2_0.number or 0

		function var_2_1.clickFun(arg_3_0)
			ShowPopItem(POP_ITEM, {
				arg_3_0.id
			})
		end
	end

	var_2_1.completedFlag = arg_2_0.isStageCleared

	arg_2_2:SetData(var_2_1)
end

function var_0_0.UIName(arg_4_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/KaliChapterSectionInfoUI"
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.battleBtn_, nil, function()
		arg_5_0:Back()
		arg_5_0:OnClickBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	var_0_0.super.OnEnter(arg_8_0)
end

function var_0_0.RefreshTitleDesc(arg_9_0)
	return
end

function var_0_0.UpdateBar(arg_10_0)
	return
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.hideThreeStarController_:SetSelectedState("false")
	arg_11_0:RefreshReward()

	if arg_11_0.lock_ then
		arg_11_0.btnLockText_.text = arg_11_0.lockTips_

		arg_11_0.btnController_:SetSelectedState("true")
	else
		arg_11_0.btnController_:SetSelectedState("false")
	end
end

function var_0_0.HaveCostCntFlag(arg_12_0)
	return false
end

function var_0_0.RefreshData(arg_13_0)
	local var_13_0 = arg_13_0.params_.stageID or 0
	local var_13_1 = ActivityKaliGameStageCfg[var_13_0]

	arg_13_0.sectionName_.text = var_13_1 and var_13_1.name

	local var_13_2 = TugGameData:GetStageData(arg_13_0.params_.activityID, arg_13_0.params_.stageID)

	arg_13_0.isStageCleared = var_13_2
	arg_13_0.cost_ = 0
	arg_13_0.lock_ = not arg_13_0.params_.lock

	if not ActivityData:GetActivityIsOpen(var_13_1.activity_id) then
		local var_13_3 = ActivityData:GetActivityData(var_13_1.activity_id)

		if var_13_3 and var_13_3.startTime and arg_13_0.params_.prePass then
			arg_13_0.lockTips_ = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_13_3.startTime))
		else
			arg_13_0.lockTips_ = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
		end
	else
		arg_13_0.lockTips_ = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
	end

	arg_13_0.threeStarDataList_ = {
		{
			var_13_2,
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

	arg_13_0.sectionInfoThreeStarBar_:SetData(arg_13_0.threeStarDataList_)
end

function var_0_0.OnClickBtn(arg_14_0)
	DormMinigame.Launch("HZ07_jiali2", TugGameBridge, {
		activityID = arg_14_0.params_.activityID,
		stageID = arg_14_0.params_.stageID
	})
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
	arg_15_0.sectionInfoThreeStarBar_:Dispose()

	arg_15_0.sectionInfoThreeStarBar_ = nil
end

function var_0_0.RefreshReward(arg_16_0)
	local var_16_0 = arg_16_0.params_.stageID or 0
	local var_16_1 = ActivityKaliGameStageCfg[var_16_0] and ActivityKaliGameStageCfg[var_16_0].reward or {}

	arg_16_0.rewardList_ = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		local var_16_2 = rewardToItemTemplate(formatReward(iter_16_1))

		table.insert(arg_16_0.rewardList_, var_16_2)
	end

	local var_16_3 = arg_16_0.rewardList_

	arg_16_0.rewardTitleText_.text = GetTips("FIRST_DROP")

	if #var_16_3 > 0 and not arg_16_0.isStageCleared then
		arg_16_0.hideDropPanelController_:SetSelectedState("tru")
	else
		arg_16_0.hideDropPanelController_:SetSelectedState("true")
	end

	arg_16_0.uiList_:StartScroll(#var_16_3)
end

return var_0_0
