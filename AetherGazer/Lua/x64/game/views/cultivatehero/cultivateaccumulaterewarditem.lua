local var_0_0 = class("CultivateAccumulateRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.rewardItemList_ = {}
	arg_2_0.itemDataList_ = {}
	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.index_ = arg_4_1
	arg_4_0.taskID_ = arg_4_2
	arg_4_0.activityID_ = arg_4_3
	arg_4_0.maxRewardNum_ = arg_4_4

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.titleText_.text = string.format(GetTips("CULTIVATE_HERO_REWARD"), arg_5_0.index_)

	local var_5_0

	if arg_5_0.index_ < 10 then
		var_5_0 = "0" .. arg_5_0.index_
	else
		var_5_0 = arg_5_0.index_
	end

	arg_5_0.indexText_.text = var_5_0
	arg_5_0.needText_.text = ActivityPointRewardCfg[arg_5_0.taskID_].need
	arg_5_0.icon_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[arg_5_0.activityID_].coin_id)

	arg_5_0:RefreshReward()
end

function var_0_0.RefreshReward(arg_6_0)
	local var_6_0 = CultivateHeroData:GetAccumulateTaskInfoList(arg_6_0.activityID_)
	local var_6_1 = var_6_0[arg_6_0.taskID_] and var_6_0[arg_6_0.taskID_].isReceived

	if var_6_1 == true then
		arg_6_0.rewardState_:SetSelectedState("received")
	else
		arg_6_0.rewardState_:SetSelectedState("none")
	end

	local var_6_2 = ActivityPointRewardCfg[arg_6_0.taskID_].reward_item_list

	for iter_6_0 = 1, arg_6_0.maxRewardNum_ do
		local var_6_3 = var_6_2[iter_6_0]

		if not arg_6_0.itemDataList_[iter_6_0] then
			arg_6_0.itemDataList_[iter_6_0] = clone(ItemTemplateData)
			arg_6_0.itemDataList_[iter_6_0].clickFun = function(arg_7_0)
				ShowPopItem(POP_ITEM, {
					arg_7_0.id,
					arg_7_0.number
				})
			end
		end

		local var_6_4 = true

		if var_6_3 then
			arg_6_0.itemDataList_[iter_6_0].id = var_6_3[1]
			arg_6_0.itemDataList_[iter_6_0].number = var_6_3[2]
			var_6_4 = false

			if var_6_1 then
				arg_6_0.itemDataList_[iter_6_0].grayFlag = true
			else
				arg_6_0.itemDataList_[iter_6_0].grayFlag = false
			end
		end

		if arg_6_0.rewardItemList_[iter_6_0] == nil then
			arg_6_0.rewardItemList_[iter_6_0] = CommonItemPool.New(arg_6_0.goRewardPanel_, nil, true)
		end

		arg_6_0.rewardItemList_[iter_6_0]:Show(true)

		if not var_6_4 then
			arg_6_0.rewardItemList_[iter_6_0]:SetData(arg_6_0.itemDataList_[iter_6_0])
		else
			arg_6_0.rewardItemList_[iter_6_0]:SetData(nil)
		end
	end
end

function var_0_0.RefreshItem(arg_8_0)
	arg_8_0.rewardCfg_ = ActivityPointRewardCfg[arg_8_0.taskID_].reward_item_list

	arg_8_0.itemList_:StartScroll(#arg_8_0.rewardCfg_)
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.rewardItemList_ then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.rewardItemList_) do
			iter_9_1:Dispose()
		end

		arg_9_0.rewardItemList_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
