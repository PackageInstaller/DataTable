local var_0_0 = class("AffixSelectRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitRewardItem()

	arg_3_0.stausController_ = arg_3_0.itemCon_:GetController("status")
end

function var_0_0.InitRewardItem(arg_4_0)
	arg_4_0.rewardItemList_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.rewardItemList_[iter_4_0] = CommonItemView.New(arg_4_0["item_" .. iter_4_0])
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnReceive_, nil, function()
		if arg_5_0.isFirstReward_ then
			ActivityAffixSelectAction.GetAllFirsrtRewards({
				arg_5_0.activityId_
			})
		else
			ActivityAction.ReceivePointReward({
				arg_5_0.rewardId_
			})
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.index_ = arg_7_1
	arg_7_0.rewardId_ = arg_7_2
	arg_7_0.cfg_ = arg_7_4 and ActivityAffixSelectCfg[arg_7_3] or ActivityPointRewardCfg[arg_7_2]
	arg_7_0.activityId_ = arg_7_3
	arg_7_0.isFirstReward_ = arg_7_4

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0

	if arg_8_0.isFirstReward_ then
		arg_8_0.textTask_.text = string.format("[%s]", BattleActivityAffixSelectCfg[arg_8_0.cfg_.stage_id].name)

		local var_8_1 = ActivityAffixSelectData:GetSubActivityData(arg_8_0.activityId_)

		var_8_0 = var_8_1 and var_8_1.clearState or 1
	else
		arg_8_0.textTask_.text = GetTips("CURRENT_TOTAL_SCORE") .. arg_8_0.cfg_.need
		var_8_0 = ActivityAffixSelectData:GetRewardStatus(arg_8_0.activityId_, arg_8_0.rewardId_)
	end

	arg_8_0:UpdateRewardItem()

	if var_8_0 == 3 then
		arg_8_0.stausController_:SetSelectedState("rewarded")
	elseif var_8_0 == 1 then
		arg_8_0.stausController_:SetSelectedState("unfinished")
	else
		arg_8_0.stausController_:SetSelectedState("complete")
	end
end

function var_0_0.UpdateRewardItem(arg_9_0)
	for iter_9_0 = 1, 3 do
		local var_9_0 = arg_9_0.cfg_.reward_item_list[iter_9_0]
		local var_9_1 = arg_9_0.rewardItemList_[iter_9_0]

		if var_9_0 then
			local var_9_2 = clone(ItemTemplateData)

			var_9_2.id = var_9_0[1]
			var_9_2.number = var_9_0[2]

			function var_9_2.clickFun(arg_10_0)
				ShowPopItem(POP_ITEM, {
					arg_10_0.id
				})
			end

			var_9_1:SetData(var_9_2)
		else
			var_9_1:SetData(nil)
		end
	end
end

function var_0_0.OnEnter(arg_11_0)
	return
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.rewardItemList_) do
		iter_13_1:Dispose()
	end

	arg_13_0.rewardItemList_ = nil
end

return var_0_0
