local var_0_0 = class("EquipSeizureRewardItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.rewardItemList_ = {}
	arg_1_0.controller_ = arg_1_0.controlExCo_:GetController("status")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.receiveBtn_, nil, function()
		arg_2_0:ClickItem()
	end)
end

function var_0_0.ClickItem(arg_4_0)
	local var_4_0 = {
		arg_4_0.rewardID_
	}

	EquipSeizureAction.SendReceiveReward(var_4_0, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			manager.notify:Invoke(EQUIP_SEIZURE_REWARD)
		end
	end)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.rewardItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.rewardItemList_ = nil
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	local var_7_0 = EquipSeizurePointRewardCfg[arg_7_1]

	arg_7_0.rewardList_ = var_7_0.reward_item_list
	arg_7_0.descText_.text = string.format(GetTips("EQUIP_SEIZURE_POINT_REWARD_DESC"), var_7_0.need)
	arg_7_0.rewardID_ = arg_7_1

	arg_7_0:RefreshBtn()
	arg_7_0:RefreshRewardItem()
end

function var_0_0.RefreshRewardItem(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.rewardList_) do
		local var_8_0 = clone(ItemTemplateData)

		var_8_0.id = iter_8_1[1]
		var_8_0.number = iter_8_1[2]

		function var_8_0.clickFun(arg_9_0)
			ShowPopItem(POP_ITEM, {
				arg_9_0.id,
				arg_9_0.number
			})
		end

		if arg_8_0.rewardItemList_[iter_8_0] then
			arg_8_0.rewardItemList_[iter_8_0]:SetData(var_8_0)
		else
			arg_8_0.rewardItemList_[iter_8_0] = CommonItemPool.New(arg_8_0.rewardParent_, var_8_0)
		end
	end

	for iter_8_2 = #arg_8_0.rewardList_ + 1, #arg_8_0.rewardItemList_ do
		arg_8_0.rewardItemList_[iter_8_2]:Show(false)
	end
end

function var_0_0.RefreshBtn(arg_10_0)
	if table.keyof(EquipSeizureData:GetReceiveList(), arg_10_0.rewardID_) then
		arg_10_0.controller_:SetSelectedState("haveGet")
	elseif table.keyof(EquipSeizureData:GetCanReceiveList(), arg_10_0.rewardID_) then
		arg_10_0.controller_:SetSelectedState("canGet")
	else
		arg_10_0.controller_:SetSelectedState("cannotGet")
	end
end

return var_0_0
