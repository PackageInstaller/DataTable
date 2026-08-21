local var_0_0 = import("game.views.activity.Submodule.slayer.slayer_2_4.SlayerMainView_2_4")
local var_0_1 = class("SlayerMainView_3_6", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.rewardList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.rewardListGo_, CommonItemView)
	arg_1_0.itemDataList_ = {}
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)
	arg_2_0:RefreshReward()
end

function var_0_1.RefreshReward(arg_3_0)
	arg_3_0.itemIDList_ = {}

	local var_3_0 = {}
	local var_3_1 = ActivityCfg[arg_3_0.activityID_]

	arg_3_0.regionList = var_3_1 and var_3_1.sub_activity_list or {}

	for iter_3_0 = #arg_3_0.regionList, 1, -1 do
		local var_3_2 = arg_3_0.regionList[iter_3_0]
		local var_3_3 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[var_3_2] or {}

		for iter_3_1, iter_3_2 in ipairs(var_3_3) do
			for iter_3_3, iter_3_4 in ipairs(ActivitySlayerPointRewardCfg[iter_3_2].reward_item_list) do
				local var_3_4 = iter_3_4[1]

				if not var_3_0[var_3_4] and ItemCfg[var_3_4].rare >= 5 then
					arg_3_0.itemIDList_[#arg_3_0.itemIDList_ + 1] = var_3_4
					var_3_0[var_3_4] = true
				end
			end
		end
	end

	arg_3_0.rewardList_:StartScroll(#arg_3_0.itemIDList_)
end

function var_0_1.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.itemDataList_[arg_4_1] then
		arg_4_0.itemDataList_[arg_4_1] = clone(ItemTemplateData)
		arg_4_0.itemDataList_[arg_4_1].clickFun = function(arg_5_0)
			ShowPopItem(POP_ITEM, {
				arg_5_0.id
			})
		end
	end

	arg_4_0.itemDataList_[arg_4_1].id = arg_4_0.itemIDList_[arg_4_1]
	arg_4_0.itemDataList_[arg_4_1].number = nil

	arg_4_2:SetData(arg_4_0.itemDataList_[arg_4_1])
end

function var_0_1.Dispose(arg_6_0)
	var_0_1.super.Dispose(arg_6_0)
	arg_6_0.rewardList_:Dispose()
end

return var_0_1
