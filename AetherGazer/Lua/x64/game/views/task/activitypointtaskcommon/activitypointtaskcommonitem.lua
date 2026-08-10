local var_0_0 = class("ActivityPointTaskCommonItem", ReduxView)

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

	arg_3_0.descText_ = arg_3_0.descText_ or arg_3_0.titleText_
	arg_3_0.commonItemList_ = {
		CommonItemView.New(arg_3_0.awardItem1Obj_),
		CommonItemView.New(arg_3_0.awardItem2Obj_),
		CommonItemView.New(arg_3_0.awardItem3Obj_)
	}
	arg_3_0.controller_ = arg_3_0.allBtnController_:GetController("all")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		ActivityPointAction.ReceivePointReward({
			arg_4_0.ID_
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.ID_ = arg_6_1
	arg_6_0.titleText_.text = arg_6_2 > 9 and arg_6_2 or "0" .. arg_6_2

	arg_6_0.controller_:SetSelectedState(arg_6_3)

	local var_6_0 = "ACTIVITY_POINT_TASK_COMMON_NAME_" .. arg_6_4

	if TipsCfg.get_id_list_by_define[var_6_0] then
		arg_6_0.descText_.text = GetTipsF(var_6_0, arg_6_2)
	else
		arg_6_0.descText_.text = arg_6_2
	end

	local var_6_1 = ActivityPointRewardCfg[arg_6_1]

	for iter_6_0 = 1, 3 do
		if var_6_1.reward_item_list[iter_6_0] then
			local var_6_2 = cfgToItemTemplate(var_6_1.reward_item_list[iter_6_0])

			var_6_2.grayFlag = arg_6_3 == "complete"

			function var_6_2.clickFun(arg_7_0)
				ShowPopItem(POP_ITEM, arg_7_0)
			end

			arg_6_0.commonItemList_[iter_6_0]:SetData(var_6_2)
		end
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	for iter_8_0 = 1, #arg_8_0.commonItemList_ do
		if arg_8_0.commonItemList_[iter_8_0] then
			arg_8_0.commonItemList_[iter_8_0]:Dispose()

			arg_8_0.commonItemList_[iter_8_0] = nil
		end
	end
end

return var_0_0
