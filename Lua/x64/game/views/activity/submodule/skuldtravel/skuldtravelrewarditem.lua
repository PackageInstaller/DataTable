local var_0_0 = class("SkuldTravelRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listgo_, CommonItemView)
	arg_3_0.statucontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "reward")
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		id = arg_4_0.rewardlist_[arg_4_1][1],
		number = arg_4_0.rewardlist_[arg_4_1][2],
		clickFun = function(arg_5_0)
			ShowPopItem(POP_ITEM, {
				arg_5_0.id
			})
		end
	}

	arg_4_2:SetData(var_4_0)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		if arg_6_0.statu_ == 1 then
			SkuldTravelAction:GetTravelReward(arg_6_0.rewardid_)
		end
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.rewardid_ = arg_8_1
	arg_8_0.desctext_.text = GetI18NText(SkuldTravelData:GetTaskTextByTaskId(arg_8_0.rewardid_))
	arg_8_0.statu_ = SkuldTravelData:GetTaskStatuByTaskId(arg_8_0.rewardid_)

	arg_8_0.statucontroller_:SetSelectedState(SkuldTravelData:GetTaskControllerStatu(arg_8_0.statu_))

	arg_8_0.rewardlist_ = TravelSkuldRewardCfg[arg_8_0.rewardid_].reward_item_list

	arg_8_0.list_:StartScroll(#arg_8_0.rewardlist_)
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.list_ then
		arg_9_0.list_:Dispose()

		arg_9_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
