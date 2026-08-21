local var_0_0 = class("SoloChallengeAffixView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerSoloChallengeAffixViewnewUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.selectHandler_ = handler(arg_3_0, arg_3_0.OnSelectAffix)

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.buttonController_ = ControllerUtil.GetController(arg_3_0.transform_, "buttonState")
	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.scrollView_, SoloChallengeAffixItem)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:HideBar()

	arg_5_0.activityID_ = arg_5_0.params_.activityID
	arg_5_0.affixList_ = ActivitySoloChallengeCfg[arg_5_0.activityID_].affix_pool
	arg_5_0.ownAffixID_ = arg_5_0.params_.affixID
	arg_5_0.ownPos_ = arg_5_0.params_.pos
	arg_5_0.stageID_ = arg_5_0.params_.stageID
	arg_5_0.maxAffixCount_ = SoloChallengeData:GetMaxAffixCount(arg_5_0.activityID_)
	arg_5_0.selectedAffixID_ = 0
	arg_5_0.selected_ = false

	arg_5_0.list_:StartScroll(#arg_5_0.affixList_)
	arg_5_0:RefreshUI()
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.affixList_[arg_6_1]

	arg_6_2:SetData(arg_6_0.activityID_, var_6_0, arg_6_0.toggleGroup_)
	arg_6_2:SetState(SoloChallengeData:GetAffixState(arg_6_0.activityID_, var_6_0))
	arg_6_2:RegistSelectCallBack(arg_6_0.selectHandler_)

	local var_6_1 = false

	if (arg_6_0.ownAffixID_ == var_6_0 or arg_6_0.ownAffixID_ == 0 and arg_6_2.stageID_ == -1) and not arg_6_0.selected_ then
		var_6_1 = true
		arg_6_0.selected_ = true
		arg_6_0.selectedAffixID_ = var_6_0

		arg_6_0:RefreshAffixDesc()
	end

	arg_6_2:SetSelect(var_6_1)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.equipBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_7_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_7_0.ownAffixID_ == 0 then
			arg_7_0:EquipAffix(arg_7_0.activityID_, arg_7_0.stageID_, arg_7_0.ownPos_, arg_7_0.selectedAffixID_, arg_7_0.newPos_)

			arg_7_0.ownAffixID_ = arg_7_0.selectedAffixID_
		else
			local var_8_0 = SoloChallengeData:GetNextEquipPos(arg_7_0.activityID_, arg_7_0.stageID_)

			if var_8_0 ~= -1 then
				arg_7_0:EquipAffix(arg_7_0.activityID_, arg_7_0.stageID_, var_8_0, arg_7_0.selectedAffixID_, arg_7_0.newPos_)
			end
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.dischargeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_7_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_7_0.ownAffixID_ == arg_7_0.selectedAffixID_ then
			arg_7_0.ownAffixID_ = 0
		end

		SoloChallengeTools.DischargeAffix(arg_7_0.activityID_, arg_7_0.selectedAffixID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshAffixCountText()
	arg_11_0:RefreshIcon()
	arg_11_0:RefreshAffixDesc()
	arg_11_0:RefreshBtnState()
end

function var_0_0.RefreshIcon(arg_12_0)
	if arg_12_0.selectedAffixID_ ~= 0 then
		arg_12_0.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_12_0.selectedAffixID_].affix)
	end
end

function var_0_0.EquipAffix(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	if arg_13_5 ~= -1 then
		SoloChallengeTools.DischargeAffix(arg_13_1, arg_13_4)
		SoloChallengeTools.EquipAffix(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	else
		SoloChallengeTools.EquipAffix(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	end
end

function var_0_0.OnSoloChallengeAffixRefresh(arg_14_0, arg_14_1)
	arg_14_0:RefreshAffixCountText()
	arg_14_0:RefreshAffixState(arg_14_1)
	arg_14_0:RefreshBtnState()
	arg_14_0:SelectAffix(arg_14_1)
end

function var_0_0.SelectAffix(arg_15_0, arg_15_1)
	local var_15_0 = table.keyof(arg_15_0.affixList_, arg_15_1)

	arg_15_0.list_:GetItemByIndex(var_15_0):SetSelect(true)
end

function var_0_0.OnSelectAffix(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.selectedAffixID_ = arg_16_1
	arg_16_0.newPos_ = arg_16_2

	arg_16_0:RefreshUI()
end

function var_0_0.RefreshBtnState(arg_17_0)
	local var_17_0 = SoloChallengeData:CanEquipAffix(arg_17_0.activityID_, arg_17_0.stageID_)
	local var_17_1 = SoloChallengeData:GetAffixState(arg_17_0.activityID_, arg_17_0.selectedAffixID_).stageID

	if arg_17_0.selectedAffixID_ ~= 0 and (arg_17_0.ownAffixID_ == arg_17_0.selectedAffixID_ or var_17_1 == arg_17_0.stageID_) then
		arg_17_0.buttonController_:SetSelectedState("discharge")
	elseif arg_17_0.ownAffixID_ == 0 or var_17_0 then
		arg_17_0.buttonController_:SetSelectedState("equip")

		arg_17_0.equipBtn_.interactable = true
	elseif not var_17_0 then
		arg_17_0.buttonController_:SetSelectedState("equip")

		arg_17_0.equipBtn_.interactable = false
	end
end

function var_0_0.RefreshAffixCountText(arg_18_0)
	local var_18_0 = SoloChallengeData:GetAffixCount(arg_18_0.activityID_, arg_18_0.stageID_)

	arg_18_0.affixCountText_.text = string.format("%d/%d", var_18_0, arg_18_0.maxAffixCount_)
end

function var_0_0.RefreshAffixDesc(arg_19_0)
	if arg_19_0.selectedAffixID_ ~= 0 then
		arg_19_0.affixDescText_.text = getAffixDesc(ActivityAffixPoolCfg[arg_19_0.selectedAffixID_].affix)
		arg_19_0.affixNameText_.text = getAffixName(ActivityAffixPoolCfg[arg_19_0.selectedAffixID_].affix)
	end
end

function var_0_0.RefreshAffixState(arg_20_0, arg_20_1)
	local var_20_0 = table.keyof(arg_20_0.affixList_, arg_20_1)

	if var_20_0 then
		arg_20_0.list_:GetItemByIndex(var_20_0):SetState(SoloChallengeData:GetAffixState(arg_20_0.activityID_, arg_20_1))
	end
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.list_ then
		arg_21_0.list_:Dispose()

		arg_21_0.list_ = nil
	end

	arg_21_0.selectHandler_ = nil
	arg_21_0.buttonController_ = nil

	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.OnReverTeamData(arg_22_0)
	arg_22_0.list_:StartScroll(#arg_22_0.affixList_)
	arg_22_0:RefreshUI()
end

return var_0_0
