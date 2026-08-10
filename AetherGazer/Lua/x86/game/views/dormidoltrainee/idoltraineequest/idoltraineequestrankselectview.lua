local var_0_0 = class("IdolTraineeQuestRankSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeQuestRankSelect"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.okBtnController_ = arg_4_0.controllerEx_:GetController("btn")
	arg_4_0.noneController_ = arg_4_0.controllerEx_:GetController("none")
	arg_4_0.ItemUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshItem), arg_4_0.uiList_, CommonItemView)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(arg_5_0.selectDic_) do
			if iter_6_1 ~= 0 then
				table.insert(var_6_0, {
					id = iter_6_0,
					num = iter_6_1
				})
			end
		end

		IdolTraineeAction.GetQuestRankReward(arg_5_0.rank_, var_6_0, function()
			arg_5_0:Back()
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.retBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.rank_ = arg_9_0.params_.rank

	local var_9_0 = IdolTraineeRewardRankCfg[arg_9_0.rank_]

	arg_9_0.dataList_ = var_9_0.reward

	table.sort(arg_9_0.dataList_, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_9_0:GetHeroLock(arg_10_0)
		local var_10_1 = arg_9_0:GetHeroLock(arg_10_1)

		if var_10_0 == var_10_1 then
			return arg_10_0 < arg_10_1
		else
			return var_10_1
		end
	end)

	arg_9_0.maxNum_ = var_9_0.num
	arg_9_0.selectDic_ = {}
	arg_9_0.selectNum_ = 0

	arg_9_0.ItemUIList_:StartScroll(#arg_9_0.dataList_)
	arg_9_0.noneController_:SetSelectedState("true")
	arg_9_0.okBtnController_:SetSelectedState("state1")

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.dataList_) do
		if not arg_9_0:GetHeroLock(iter_9_1) then
			arg_9_0.noneController_:SetSelectedState("false")
			arg_9_0.okBtnController_:SetSelectedState("state0")

			break
		end
	end

	arg_9_0:UpdatePreview()
end

function var_0_0.RefreshItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.dataList_[arg_11_1]
	local var_11_1 = arg_11_0:GetHeroLock(var_11_0)
	local var_11_2 = clone(ItemTemplateData)

	var_11_2.id = var_11_0
	var_11_2.locked = var_11_1
	var_11_2.topAmountValue = arg_11_0.selectDic_[var_11_0] or 0

	function var_11_2.clickFun(arg_12_0)
		if var_11_1 then
			return false
		end

		arg_11_0:AddSelect(var_11_0)
		arg_11_2:RefreshTopAmount(arg_11_0.selectDic_[var_11_0])
		arg_11_0:UpdatePreview()

		return true
	end

	function var_11_2.clickAmountFun(arg_13_0)
		if var_11_1 then
			return false
		end

		arg_11_0:DeleteSelect(var_11_0)
		arg_11_2:RefreshTopAmount(arg_11_0.selectDic_[var_11_0])
		arg_11_0:UpdatePreview()

		return true
	end

	arg_11_2:SetData(var_11_2)
end

function var_0_0.AddSelect(arg_14_0, arg_14_1)
	if arg_14_0.selectNum_ >= arg_14_0.maxNum_ then
		return
	end

	if not arg_14_0.selectDic_[arg_14_1] then
		arg_14_0.selectDic_[arg_14_1] = 0
	end

	arg_14_0.selectDic_[arg_14_1] = arg_14_0.selectDic_[arg_14_1] + 1
	arg_14_0.selectNum_ = arg_14_0.selectNum_ + 1
end

function var_0_0.DeleteSelect(arg_15_0, arg_15_1)
	if arg_15_0.selectNum_ <= 0 or not arg_15_0.selectDic_[arg_15_1] or arg_15_0.selectDic_[arg_15_1] <= 0 then
		return
	end

	arg_15_0.selectDic_[arg_15_1] = arg_15_0.selectDic_[arg_15_1] - 1
	arg_15_0.selectNum_ = arg_15_0.selectNum_ - 1
end

function var_0_0.UpdatePreview(arg_16_0)
	arg_16_0.numText_.text = arg_16_0.selectNum_ .. "/" .. arg_16_0.maxNum_

	arg_16_0.okBtnController_:SetSelectedState(arg_16_0.selectNum_ == arg_16_0.maxNum_ and "state1" or "state0")
end

function var_0_0.GetHeroLock(arg_17_0, arg_17_1)
	return not HeroTools.GetHeroIsUnlock(arg_17_1 - 10000)
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0.selectInex_ = 0
	arg_18_0.selectNum_ = 0
	arg_18_0.lastSelectItem_ = nil
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.ItemUIList_:Dispose()
	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
