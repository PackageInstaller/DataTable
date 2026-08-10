local var_0_0 = class("ActivityInfinityPoolBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.poolID_ = arg_2_1
	arg_2_0.index_ = arg_2_2

	arg_2_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_3_0)
	local var_3_0 = arg_3_0.poolID_
	local var_3_1 = arg_3_0.index_
	local var_3_2 = OsirisInfinityPoolData:GetPoolData(var_3_0)

	if var_3_2.openBoxList[var_3_1] then
		local var_3_3 = var_3_2.openBoxList[var_3_1]

		if arg_3_0.rewardItem_ then
			arg_3_0.rewardItem_:SetData(var_3_3)
		else
			arg_3_0.rewardItem_ = arg_3_0:GetRewardItem(var_3_3)
		end
	elseif arg_3_0.rewardItem_ then
		arg_3_0.rewardItem_:Show(false)
	end

	arg_3_0:Show(true)
end

function var_0_0.GetRewardItem(arg_4_0, arg_4_1)
	return RewardPoolItem.New(arg_4_0.goItemParent_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	if arg_5_0.rewardItem_ then
		arg_5_0.rewardItem_:Dispose()

		arg_5_0.rewardItem_ = nil
	end

	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.button_, nil, function()
		local var_7_0 = OsirisInfinityPoolData:GetPoolData(arg_6_0.poolID_)

		if var_7_0.openBoxList[arg_6_0.index_] then
			return
		end

		local var_7_1 = ActivityInfinityPoolCfg[arg_6_0.poolID_].cost_item

		if ItemTools.getItemNum(var_7_1[1]) < var_7_1[2] then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_7_1[1])))

			return
		end

		local var_7_2 = var_7_0.isOpenCoreItem

		OsirisAction.OpenPoolBox(arg_6_0.poolID_, {
			arg_6_0.index_
		}, function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				arg_6_0:RefreshUI()
				getReward({
					{
						id = arg_8_0.box_list[1].item.id,
						num = arg_8_0.box_list[2].item.num
					}
				})

				if var_7_2 == false and var_7_0.isOpenCoreItem == true then
					local var_8_0 = ActivityInfinityPoolCfg[arg_6_0.poolID_].activity_id

					ShowTips(string.format(GetTips("UNLOCK_INFINITY"), GetI18NText(OsirisInfinityPoolData:GetOpenPhase(var_8_0)), GetI18NText(ActivityCfg[var_8_0].remark)))
				end
			else
				ShowTips(arg_8_0.result)
			end
		end)
	end)
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

return var_0_0
