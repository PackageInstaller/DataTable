ActivityRewardItemBase = import("game.views.activity.Submodule.destroyBoxGame.rewardBase.ActivityRewardItemBase")

local var_0_0 = class("SequentialBattleRewardItem", ActivityRewardItemBase)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.buttonController = arg_1_0.controllerEx_:GetController("status")
	arg_1_0.rewardItemList_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.rewardItemList_[iter_1_0] = CommonItemView.New(arg_1_0[string.format("rewardItem%s_", iter_1_0)])
	end
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.index_ = arg_2_2

	arg_2_0:Show(true)

	arg_2_0.rewardID_ = arg_2_1

	local var_2_0 = SequentialBattleRewardCfg[arg_2_1]
	local var_2_1 = table.keyof(SequentialBattleRewardCfg.get_id_list_by_activity_id[var_2_0.activity_id], arg_2_1)

	arg_2_0.indexText_.text = string.format("%02d", var_2_1)
	arg_2_0.descText_.text = string.format(var_2_0.desc, var_2_0.complete_num)

	local var_2_2 = math.min(table.length(SequentialBattleData:GetFinishStageList(var_2_0.activity_id)), var_2_0.complete_num)

	arg_2_0.progressText_.text = string.format("%s/%s", var_2_2, var_2_0.complete_num)
	arg_2_0.slider_.value = var_2_2 / var_2_0.complete_num

	local var_2_3 = var_2_0 and var_2_0.item_list or {}
	local var_2_4 = false

	if table.keyof(SequentialBattleData:GetReceiveRewardList(var_2_0.main_activity_id), arg_2_1) then
		arg_2_0.buttonController:SetSelectedState("haveGet")

		var_2_4 = true
	elseif SequentialBattleTools.IsUnlockReward(arg_2_1) then
		arg_2_0.buttonController:SetSelectedState("canGet")
	else
		arg_2_0.buttonController:SetSelectedState("unFinish")
	end

	for iter_2_0, iter_2_1 in pairs(var_2_3) do
		local var_2_5 = clone(ItemTemplateData)

		var_2_5.id = iter_2_1[1]
		var_2_5.number = iter_2_1[2]

		if var_2_4 then
			var_2_5.grayFlag = true
		else
			var_2_5.grayFlag = false
		end

		function var_2_5.clickFun(arg_3_0)
			ShowPopItem(POP_ITEM, {
				arg_3_0.id,
				arg_3_0.number
			})
		end

		arg_2_0.rewardItemList_[iter_2_0]:SetData(var_2_5)
	end

	for iter_2_2 = #var_2_3 + 1, #arg_2_0.rewardItemList_ do
		arg_2_0.rewardItemList_[iter_2_2]:SetData(nil)
	end
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.rewardItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		local var_6_0 = SequentialBattleRewardCfg[arg_5_0.rewardID_]

		SequentialBattleAction.ReceiveReward(var_6_0.main_activity_id, {
			arg_5_0.rewardID_
		}, function()
			manager.notify:Invoke(ACTIVITY_REWARD_REFRESH)
		end)
	end)
end

function var_0_0.Update(arg_8_0)
	arg_8_0:SetData(arg_8_0.rewardID_, arg_8_0.index_)
end

return var_0_0
