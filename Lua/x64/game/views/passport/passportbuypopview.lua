local var_0_0 = class("PassportBuyPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Passport/PassportBuyPopUI"
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

	arg_4_0.freelist_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.freeListGo_, CommonItemView)
	arg_4_0.paylist_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem2), arg_4_0.payListGo_, CommonItemView)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)
	local var_5_1 = arg_5_0.curfreeList_[arg_5_1]
	local var_5_2 = {
		id = var_5_1.id,
		number = var_5_1.num,
		clickFun = function(arg_6_0)
			arg_5_0:OnItemClick(arg_6_0.id, arg_6_0.number, 1)
		end
	}

	arg_5_2:SetData(var_5_2)
end

function var_0_0.indexItem2(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = clone(ItemTemplateData)
	local var_7_1 = arg_7_0.curList_[arg_7_1]
	local var_7_2 = {
		id = var_7_1.id,
		number = var_7_1.num,
		clickFun = function(arg_8_0)
			arg_7_0:OnItemClick(arg_8_0.id, arg_8_0.number, 1)
		end
	}

	arg_7_2:SetData(var_7_2)
end

function var_0_0.OnItemClick(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	ShowPopItem(POP_ITEM, {
		arg_9_1,
		arg_9_2
	})
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.cancelBtn_, nil, function()
		PassportAction.OneKeyGet()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.okBtn_, nil, function()
		JumpTools.OpenPageByJump("/passportBuy")
	end)
	arg_10_0:AddBtnListener(arg_10_0.bgBtn_, nil, function()
		arg_10_0:Back()
	end)
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.level = PassportData:GetLevel()
	arg_15_0.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
	arg_15_0.curList_ = {}
	arg_15_0.curfreeList_ = {}

	for iter_15_0 = 1, arg_15_0.level do
		local var_15_0 = arg_15_0.rewardIdList_[iter_15_0]
		local var_15_1 = BattlePassCfg[var_15_0]
		local var_15_2 = {
			id = var_15_1.reward_pay[1][1],
			num = var_15_1.reward_pay[1][2]
		}

		arg_15_0.curList_[#arg_15_0.curList_ + 1] = var_15_2

		if not PassportData:GetReceiveInfo(arg_15_0.rewardIdList_[iter_15_0]) then
			local var_15_3 = {
				id = var_15_1.reward_free[1][1],
				num = var_15_1.reward_free[1][2]
			}

			arg_15_0.curfreeList_[#arg_15_0.curfreeList_ + 1] = var_15_3
		end
	end

	arg_15_0.curfreeList_ = mergeReward(arg_15_0.curfreeList_)
	arg_15_0.curfreeList_ = sortReward(arg_15_0.curfreeList_, true)

	arg_15_0.freelist_:StartScroll(#arg_15_0.curfreeList_)

	arg_15_0.curList_ = mergeReward(arg_15_0.curList_)
	arg_15_0.curList_ = sortReward(arg_15_0.curList_, true)

	arg_15_0.paylist_:StartScroll(#arg_15_0.curList_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_0.transform_)
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:UpdateBar()
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.freelist_ then
		arg_17_0.freelist_:Dispose()

		arg_17_0.freelist_ = nil
	end

	if arg_17_0.paylist_ then
		arg_17_0.paylist_:Dispose()

		arg_17_0.paylist_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
