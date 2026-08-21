local var_0_0 = class("ActivityGodEaterGiftPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Main/V4_2_GodEaterUI_GiftPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("isGet")
	arg_4_0.rewardItems = {}

	for iter_4_0 = 0, arg_4_0.displayRewards_.childCount - 1 do
		local var_4_0 = arg_4_0.displayRewards_:GetChild(iter_4_0).gameObject

		table.insert(arg_4_0.rewardItems, CommonItemView.New(var_4_0, true))
	end
end

local function var_0_1(arg_5_0)
	ShowPopItem(POP_ITEM, arg_5_0)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityID_ = ActivityConst.ACTIVITY_GODEATER_HERO_GIFT
	arg_6_0.giftID_ = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_0.activityID_][1]
	arg_6_0.desText_.text = GetTips("ACTIVITY_GODEATER_HERO_GIFT_DES")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.contentTrans_)
	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = GodEaterData:GetHeroGiftIsGet(arg_7_0.giftID_)

	if var_7_0 then
		arg_7_0.controller_:SetSelectedState("received")
	else
		arg_7_0.controller_:SetSelectedState("receive")
	end

	local var_7_1 = ActivityPointRewardCfg[arg_7_0.giftID_].reward_item_list

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rewardItems) do
		local var_7_2 = var_7_1[iter_7_0]
		local var_7_3 = formatReward(var_7_2)
		local var_7_4 = rewardToItemTemplate(var_7_3)

		var_7_4.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL
		var_7_4.grayFlag = var_7_0
		var_7_4.clickFun = var_0_1

		iter_7_1:SetData(var_7_4)
	end
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btn_, nil, function()
		if ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			if GodEaterData:GetHeroGiftIsGet(arg_8_0.giftID_) then
				ShowTips("ACTIVITY_GODEATER_HERO_GIFT_IS_GET")
			else
				ActivityAction.ReceivePointRewardWithCallBack({
					arg_8_0.giftID_
				}, function()
					manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_HERO_GIFT, 0)
					GodEaterData:SetHeroGiftIsGet(arg_8_0.giftID_)
					arg_8_0:RefreshUI()
				end)
			end
		else
			ShowTips("TIME_OVER")
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn2_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.rewardItems) do
		iter_13_1:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
