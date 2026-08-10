local var_0_0 = class("ChallengeRogueTeamSelectAffixView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikSelectOptionalBuffUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectedItemList_ = {}
	arg_3_0.selectAffixHandler_ = handler(arg_3_0, arg_3_0.OnSelectAffix)
	arg_3_0.onClickAffixHandler_ = handler(arg_3_0, arg_3_0.OnClickAffix)
	arg_3_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_3_0.sureBtnGo_, handler(arg_3_0, arg_3_0.OnClickBtn))
	arg_3_0.affixPoolUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexPoolItem), arg_3_0.affixIPoolListGo_, ChallengeRogueTeamSelectAffixItem)
	arg_3_0.maxMultipleController_ = arg_3_0.transCon_:GetController("max")
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.IndexPoolItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.affixGroupData_[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1, arg_5_0.group2SelectAffix_[var_5_0.group], arg_5_0.selectAffixHandler_, arg_5_0.onClickAffixHandler_)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshData(arg_6_0.selectAffixList_[arg_6_1].affixId)
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_7_0.levelNum_ = arg_7_0.levelNum_ or 0
	arg_7_0.selectAffixList_ = arg_7_0.selectAffixList_ or {}
	arg_7_0.sendAffixList_ = arg_7_0.sendAffixList_ or {}
	arg_7_0.group2SelectAffix_ = arg_7_0.group2SelectAffix_ or {}
	arg_7_0.index2Affix_ = arg_7_0.index2Affix_ or {}
	arg_7_0.baseScore_ = RogueTeamDifficultyCfg[arg_7_0.params_.difficulty].score

	arg_7_0:RefreshAffixData()
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshAffixData(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.params_.affixPool) do
		local var_8_1 = ActivityAffixPoolCfg[iter_8_1].affix[1]

		if var_8_0[var_8_1] == nil then
			var_8_0[var_8_1] = {}
		end

		table.insert(var_8_0[var_8_1], iter_8_1)
	end

	arg_8_0.affixGroupData_ = {}

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		table.insert(arg_8_0.affixGroupData_, {
			group = iter_8_2,
			affixList = iter_8_3
		})
	end

	table.sort(arg_8_0.affixGroupData_, function(arg_9_0, arg_9_1)
		return arg_9_0.group < arg_9_1.group
	end)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.selectGroup_ = 1

	arg_10_0.affixPoolUIList_:StartScroll(#arg_10_0.affixGroupData_)

	arg_10_0.tipsText_.text = GetTips("ROUGE_TEAM_OPTIONAL_HARD_TIPS")

	if arg_10_0.selectAffixList_ and #arg_10_0.selectAffixList_ > 0 then
		for iter_10_0 = 1, #arg_10_0.selectAffixList_ do
			arg_10_0.selectedItemList_[iter_10_0]:SetActive(true)
		end
	end

	arg_10_0:RefreshSelectUI()
end

function var_0_0.OnSelectAffix(arg_11_0, arg_11_1)
	slef.affixPoolUIList_:ScrollToIndex(arg_11_1, true, true)
end

function var_0_0.OnClickAffix(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.selectedAffixId_ = arg_12_2

	arg_12_0:RefreshSelectedList(arg_12_1, arg_12_2)
	arg_12_0:RefreshSelectUI()
end

function var_0_0.RefreshSelectedList(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = false
	local var_13_1 = false
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.selectAffixList_) do
		if iter_13_1.group == arg_13_1 then
			var_13_0 = true

			if arg_13_2 ~= iter_13_1.affixId then
				iter_13_1.affixId = arg_13_2
				arg_13_0.sendAffixList_[iter_13_0] = arg_13_2
				arg_13_0.group2SelectAffix_[arg_13_1] = arg_13_2
				var_13_1 = true

				break
			end

			var_13_2 = iter_13_0
			arg_13_0.group2SelectAffix_[arg_13_1] = nil

			break
		end
	end

	if not var_13_0 then
		table.insert(arg_13_0.selectAffixList_, 1, {
			group = arg_13_1,
			affixId = arg_13_2
		})
		table.insert(arg_13_0.sendAffixList_, 1, arg_13_2)

		arg_13_0.group2SelectAffix_[arg_13_1] = arg_13_2

		for iter_13_2 = 1, #arg_13_0.selectAffixList_ do
			arg_13_0.index2Affix_[iter_13_2] = arg_13_2
		end

		var_13_1 = true
	elseif var_13_2 ~= nil then
		table.remove(arg_13_0.selectAffixList_, var_13_2)
		table.remove(arg_13_0.sendAffixList_, var_13_2)
	end

	arg_13_0:RefreshSelectAffixItem(var_13_1, arg_13_1, arg_13_2)
end

function var_0_0.RefreshSelectAffixItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_1 then
		local var_14_0
		local var_14_1

		for iter_14_0, iter_14_1 in ipairs(arg_14_0.selectedItemList_) do
			if iter_14_1.groupId_ == arg_14_2 then
				var_14_0 = iter_14_1

				break
			elseif not iter_14_1:IsActive() then
				var_14_1 = var_14_1 or iter_14_1
			end
		end

		var_14_0 = var_14_0 or var_14_1

		if not var_14_0 then
			var_14_0 = ChallengeRogueTeamSelectedBigItem.New(Object.Instantiate(arg_14_0.selectedItemGo_, arg_14_0.selectAffixListTrans_, false))

			table.insert(arg_14_0.selectedItemList_, var_14_0)
		end

		var_14_0:RefreshData(arg_14_2, arg_14_3)

		if not var_14_0:IsActive() then
			arg_14_0.selectAffixListTrans_.anchoredPosition = Vector2.zero

			var_14_0.transform_:SetAsFirstSibling()
			var_14_0:SetActive(true)
		end

		var_14_0:PlayAnim()
	else
		for iter_14_2, iter_14_3 in ipairs(arg_14_0.selectedItemList_) do
			if iter_14_3.affixId_ == arg_14_3 then
				iter_14_3:SetActive(false)

				break
			end
		end
	end
end

function var_0_0.RefreshSelectUI(arg_15_0)
	arg_15_0.levelNum_ = 0

	local var_15_0 = (ChallengeRogueTeamConst.OPTIONAL_AFFIX_MAX_MULTIPLE - arg_15_0.baseScore_) / ChallengeRogueTeamConst.OPTIONAL_AFFIX_MULTIPLE
	local var_15_1 = ChallengeRogueTeamConst.OPTIONAL_AFFIX_MAX_MULTIPLE

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.selectAffixList_) do
		local var_15_2 = ActivityAffixPoolCfg[iter_15_1.affixId]

		arg_15_0.levelNum_ = arg_15_0.levelNum_ + var_15_2.point
	end

	arg_15_0.levelText_.text = arg_15_0.levelNum_

	local var_15_3 = arg_15_0.baseScore_ + arg_15_0.levelNum_ * ChallengeRogueTeamConst.OPTIONAL_AFFIX_MULTIPLE

	arg_15_0.multipleText_.text = math.min(var_15_3, var_15_1) .. "%"

	arg_15_0.maxMultipleController_:SetSelectedState(tostring(var_15_1 <= var_15_3))
end

function var_0_0.OnClickBtn(arg_16_0)
	if arg_16_0.levelNum_ < 0 then
		ShowTips("ROUGE_TEAM_OPTIONAL_HARD_ERROR")

		return
	end

	if arg_16_0.params_.clickFunc then
		arg_16_0.enterFormation_ = true

		ChallengeRogueTeamData:SetOptionalAffix(arg_16_0.levelNum_, arg_16_0.sendAffixList_)
		arg_16_0.params_.clickFunc()
	end
end

function var_0_0.OnExit(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.selectedItemList_) do
		iter_17_1:SetActive(false)
	end

	if not arg_17_0.enterFormation_ then
		arg_17_0.levelNum_ = 0
		arg_17_0.selectAffixList_ = {}
		arg_17_0.sendAffixList_ = {}
		arg_17_0.group2SelectAffix_ = {}
		arg_17_0.index2Affix_ = {}
	else
		arg_17_0.enterFormation_ = false
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.selectAffixHandler_ = nil
	arg_18_0.onClickAffixHandler_ = nil

	if arg_18_0.affixPoolUIList_ then
		arg_18_0.affixPoolUIList_:Dispose()

		arg_18_0.affixPoolUIList_ = nil
	end

	if arg_18_0.selectedItemList_ then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.selectedItemList_) do
			iter_18_1:Dispose()
		end

		arg_18_0.selectedItemList_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
