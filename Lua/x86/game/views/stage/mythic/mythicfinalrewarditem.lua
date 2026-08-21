local var_0_0 = class("MythicFinalRewardItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.rewardPanel_ = {}
	arg_1_0.rewardList_ = {}
	arg_1_0.controller_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("status")
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.index_ = MythicData:GetRealIndex(arg_2_1)
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.rewardList_) do
		iter_3_1:Dispose()
	end

	arg_3_0.rewardList_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if MythicData:GetFinalIsReward() == 0 then
			ShowMessageBox({
				content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
				OkCallback = function()
					MythicAction:GetFinalReward(arg_4_0.index_)
				end
			})
		else
			MythicAction:GetFinalReward(arg_4_0.index_)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0:Init(arg_7_1)
	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()
	arg_7_0:RefreshState()
	arg_7_0:RefreshItem()
end

function var_0_0.RefreshData(arg_8_0)
	arg_8_0.rewradCfg_ = MythicFinalCfg[arg_8_0.index_].reward_list

	for iter_8_0 = 1, 4 do
		if not arg_8_0.rewardList_[iter_8_0] then
			arg_8_0.rewardPanel_[iter_8_0] = Object.Instantiate(arg_8_0.rewardItem, arg_8_0.contentTrs_)
			arg_8_0.rewardList_[iter_8_0] = CommonItemView.New(arg_8_0.rewardPanel_[iter_8_0])
		end
	end

	for iter_8_1 = #arg_8_0.rewradCfg_ + 1, #arg_8_0.rewardList_ do
		arg_8_0.rewardList_[iter_8_1]:SetData()
	end
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.descText_.text = string.format(GetTips("MYTHIC_FINAL_REWARD_TIPS"), arg_9_0.index_)
end

function var_0_0.RefreshState(arg_10_0)
	if MythicData:GetPassHotLevel() < arg_10_0.index_ then
		arg_10_0.controller_:SetSelectedState("state2")
	elseif MythicData:GetFinalRewardStateByHotLevel(arg_10_0.index_) then
		arg_10_0.controller_:SetSelectedState("state3")
	else
		arg_10_0.controller_:SetSelectedState("state1")
	end
end

function var_0_0.RefreshItem(arg_11_0)
	local var_11_0 = arg_11_0.rewradCfg_

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if iter_11_0 > 6 then
			return
		end

		local var_11_1 = rewardToItemTemplate(formatReward(iter_11_1))

		if MythicData:GetFinalRewardStateByHotLevel(arg_11_0.index_) then
			var_11_1.grayFlag = true
		end

		function var_11_1.clickFun(arg_12_0)
			ShowPopItem(POP_ITEM, arg_12_0)
		end

		CommonTools.SetCommonData(arg_11_0.rewardList_[iter_11_0], var_11_1)
	end
end

return var_0_0
