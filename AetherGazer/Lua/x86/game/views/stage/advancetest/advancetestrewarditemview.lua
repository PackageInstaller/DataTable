local var_0_0 = class("AdvanceTestRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.rewardListGo_, CommonItemView)
	arg_3_0.itemDataList_ = {}
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.startRank = arg_4_1
	arg_4_0.endRank = ActivityPointRewardCfg[arg_4_2].need
	arg_4_0.rewardCfg = ActivityPointRewardCfg[arg_4_2].reward_item_list

	arg_4_0:RefreshUI()
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.itemDataList_[arg_5_1] then
		arg_5_0.itemDataList_[arg_5_1] = clone(ItemTemplateData)
		arg_5_0.itemDataList_[arg_5_1].clickFun = function(arg_6_0)
			ShowPopItem(POP_ITEM, {
				arg_6_0.id,
				arg_6_0.number
			})
		end
	end

	local var_5_0 = arg_5_0.rewardCfg[arg_5_1]

	arg_5_0.itemDataList_[arg_5_1].id = var_5_0[1]
	arg_5_0.itemDataList_[arg_5_1].number = var_5_0[2]

	arg_5_2:SetData(arg_5_0.itemDataList_[arg_5_1])
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.descText_.text = string.format("排名:%s", arg_7_0.startRank .. "-" .. arg_7_0.endRank)

	arg_7_0.itemList_:StartScroll(#arg_7_0.rewardCfg)
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.itemList_ then
		arg_8_0.itemList_:Dispose()

		arg_8_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
