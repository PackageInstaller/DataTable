local var_0_0 = class("SummerPubStageSectionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_StageBaseUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.foodList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshRewardItem), arg_4_0.rewardUIListGo_, SummerCookMenuFoodItem)
	arg_4_0.hideDropPanelCtr_ = arg_4_0.controllerEx_:GetController("hideDropPanel")
	arg_4_0.hideStafeDescCtr_ = arg_4_0.controllerEx_:GetController("hideStageDesc")
	arg_4_0.stageBgCtr_ = arg_4_0.controllerEx_:GetController("stageBg")
	arg_4_0.startBtnLockCtr_ = arg_4_0.controllerEx_:GetController("startBtnLock")
	arg_4_0.hideAreaBtnCtr_ = arg_4_0.controllerEx_:GetController("hideAreaBtn")
	arg_4_0.tipsController_ = arg_4_0.controllerEx_:GetController("tips")
	arg_4_0.StageIndex_ = 1
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.battleBtn_, nil, function()
		arg_5_0.Back()
		SummerPubAction.OpenBattle(arg_5_0.levelID_, arg_5_0.StageIndex_, arg_5_0.stageType_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.hardBattleBtn_, nil, function()
		arg_5_0.Back()
		SummerPubAction.OpenBattle(arg_5_0.levelID_, arg_5_0.StageIndex_, arg_5_0.stageType_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.areaBtn1_, nil, function()
		arg_5_0:setDefaultStage()
		arg_5_0:unlockDifficultBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.areaBtn2_, nil, function()
		if SummerPubData:GetClearNumByStageID(arg_5_0.levelID_, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
			arg_5_0.StageIndex_ = 2

			arg_5_0.stageBgCtr_:SetSelectedState("hard")
			arg_5_0.areaBtnCtr2_:GetController("default"):SetSelectedState("select")
			arg_5_0.areaBtnCtr1_:GetController("default"):SetSelectedState("default")
			arg_5_0.startBtnLockCtr_:SetSelectedState("hard")
			arg_5_0.hideDropPanelCtr_:SetSelectedState("true")
		else
			ShowTips(string.format(GetTips("NYA_SUMMER_CHALLENGE_LOCKED")))
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMask_, nil, function()
		arg_5_0:OnMaskClick()
	end)
end

function var_0_0.setDefaultStage(arg_11_0)
	arg_11_0.StageIndex_ = 1

	arg_11_0.stageBgCtr_:SetSelectedState("default")
	arg_11_0.areaBtnCtr1_:GetController("default"):SetSelectedState("select")

	if not SummerPubData:GetLevelIDIsOpen(arg_11_0.levelID_) then
		arg_11_0.startBtnLockCtr_:SetSelectedState("true")
	elseif arg_11_0.StageIndex_ == SummerPubConst.PIN_BALL_STAGE_TYPE.HARD then
		arg_11_0.startBtnLockCtr_:SetSelectedState("hard")
	else
		arg_11_0.startBtnLockCtr_:SetSelectedState("false")
	end

	if arg_11_0.systemCfg_.drop_lib_id == 0 then
		arg_11_0.hideDropPanelCtr_:SetSelectedState("true")
	else
		arg_11_0.hideDropPanelCtr_:SetSelectedState("false")
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.levelID_ = arg_12_0.params_.levelID
	arg_12_0.systemCfg_ = SummerPubLevelCfg[arg_12_0.levelID_]
	arg_12_0.stageType_ = arg_12_0.params_.battleType

	arg_12_0:RefreshData()
	arg_12_0:RefreshUI()
end

function var_0_0.OnEnterOver(arg_13_0)
	arg_13_0:unlockDifficultBtn()
end

function var_0_0.unlockDifficultBtn(arg_14_0)
	if SummerPubData:GetClearNumByStageID(arg_14_0.levelID_, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
		arg_14_0.areaBtnCtr2_:GetController("default"):SetSelectedState("default")

		if (getData("summer_pub_main", "stage_anim_" .. arg_14_0.levelID_) or 0) == 0 then
			arg_14_0.areaUnlockAnim_:Play("UI_areaBtn02_cx", 0, 0)
			arg_14_0.areaUnlockAnim_:Update(0)
			saveData("summer_pub_main", "stage_anim_" .. arg_14_0.levelID_, 1)
		end
	else
		arg_14_0.areaBtnCtr2_:GetController("default"):SetSelectedState("lock")
	end
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0.tipsController_:SetSelectedState(tostring(false))
end

function var_0_0.OnUpdate(arg_16_0)
	if arg_16_0.levelID_ == arg_16_0.params_.levelID then
		return
	end

	arg_16_0.levelID_ = arg_16_0.params_.levelID
	arg_16_0.systemCfg_ = SummerPubLevelCfg[arg_16_0.levelID_]

	arg_16_0:RefreshData()
	arg_16_0:RefreshUI()
	arg_16_0:unlockDifficultBtn()
end

function var_0_0.RefreshData(arg_17_0)
	arg_17_0.sectionName_.text = GetI18NText(arg_17_0.systemCfg_.name)
	arg_17_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, arg_17_0.systemCfg_.background_1))
	arg_17_0.textStory_.text = GetI18NText(arg_17_0.systemCfg_.tips)

	arg_17_0:setDefaultStage()

	if arg_17_0.systemCfg_.type ~= SummerPubConst.STAGE_TYPE.BALL then
		arg_17_0.hideAreaBtnCtr_:SetSelectedState("true")
	else
		arg_17_0.hideAreaBtnCtr_:SetSelectedState("false")
	end

	arg_17_0.isFirstClear_ = true
end

function var_0_0.RefreshReward(arg_18_0)
	local var_18_0 = arg_18_0.systemCfg_.drop_lib_id

	arg_18_0.rewardList_ = getRewardFromDropCfg(var_18_0, arg_18_0.isFirstClear_)

	local var_18_1 = arg_18_0.rewardList_

	arg_18_0.foodList_:StartScroll(#var_18_1)
end

function var_0_0.HaveCostCntFlag(arg_19_0)
	return false
end

function var_0_0.RefreshUI(arg_20_0)
	arg_20_0:RefreshReward()
end

function var_0_0.RefreshRewardItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2:RegisterClick(handler(arg_21_0, arg_21_0.OnFoodClick))
	arg_21_2:SetData(arg_21_0.rewardList_[arg_21_1].id)
	arg_21_2:RefreshUnlockContronl(true)

	if SummerPubData:GetClearNumByStageID(arg_21_0.levelID_, arg_21_0.StageIndex_) > 0 then
		arg_21_2:RefreshDoneContronl(true)
	else
		arg_21_2:RefreshDoneContronl(false)
	end
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.foodList_:Dispose()

	arg_23_0.foodList_ = nil

	var_0_0.super.Dispose(arg_23_0)
end

function var_0_0.OnFoodClick(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.selectedItemId_ = arg_24_1

	local var_24_0 = ItemCfg[arg_24_1]

	arg_24_0.tipsController_:SetSelectedState(tostring(arg_24_2))

	if arg_24_2 then
		arg_24_0.foodName_.text = var_24_0.name
		arg_24_0.foodDesc_.text = var_24_0.desc
	end
end

function var_0_0.OnMaskClick(arg_25_0)
	local var_25_0 = arg_25_0.foodList_:GetItemList()

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		iter_25_1:RefreshSelect(false)
	end

	arg_25_0.tipsController_:SetSelectedState(tostring(false))

	arg_25_0.selectedItemId_ = nil
end

return var_0_0
