local var_0_0 = class("CowboyRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeIntegralPopnew"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = {}
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, CowboyRewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.activityID_, arg_5_0.list_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshText()
	arg_9_0:RefreshList()
end

function var_0_0.RefreshText(arg_10_0)
	local var_10_0, var_10_1 = CowboyData:GetRewardCount(arg_10_0.activityID_)

	arg_10_0.text_.text = var_10_0 .. "/" .. var_10_1
end

function var_0_0.RefreshList(arg_11_0)
	arg_11_0.list_ = CowboyData:GetList(arg_11_0.activityID_)

	local var_11_0
	local var_11_1
	local var_11_2
	local var_11_3
	local var_11_4 = 1

	for iter_11_0 = #arg_11_0.list_, 1, -1 do
		local var_11_5 = arg_11_0.list_[iter_11_0]
		local var_11_6 = CowboyData:GetData(var_11_5)
		local var_11_7 = CowboyData:GetHistoryScore(var_11_5)

		for iter_11_1, iter_11_2 in ipairs(var_11_6.reward) do
			local var_11_8 = ActivityPointRewardCfg[iter_11_2.point_id]

			if var_11_7 >= ActivityPointRewardCfg[iter_11_2.point_id].need and iter_11_2.point_reward_state == 1 then
				var_11_4 = iter_11_0

				break
			end
		end
	end

	arg_11_0.scrollHelper_:StartScroll(#arg_11_0.list_, var_11_4)
end

function var_0_0.OnCowboyReward(arg_12_0)
	arg_12_0:RefreshUI()
end

function var_0_0.OnExit(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.scrollHelper_:GetItemList()) do
		iter_13_1:OnExit()
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	arg_14_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
