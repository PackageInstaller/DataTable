local var_0_0 = class("XH3rdWaterSelfContributeItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.haveGetController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "haveGet")
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0, var_5_1 = ActivityWaterData:GetCurrentContributeCfg(arg_4_0.activityId_)
		local var_5_2 = ActivityWaterData:GetCurrentSelfProgress(arg_4_0.activityId_)

		if not var_5_1 and var_5_2 >= ActivityPointRewardCfg[var_5_0].need then
			ActivityWaterAction.GetSelfAssistantReward(arg_4_0.activityId_, {
				var_5_0
			}, ActivityPointRewardCfg[var_5_0].reward_item_list)
		else
			JumpTools.OpenPageByJump("xH3rdWaterExchange", {})
		end
	end)
	arg_4_0.commonItem_:RegistCallBack(function(arg_6_0)
		local var_6_0, var_6_1 = ActivityWaterData:GetCurrentContributeCfg(arg_4_0.activityId_)
		local var_6_2 = ActivityWaterData:GetCurrentSelfProgress(arg_4_0.activityId_)

		if not var_6_1 and var_6_2 >= ActivityPointRewardCfg[var_6_0].need then
			ActivityWaterAction.GetSelfAssistantReward(arg_4_0.activityId_, {
				var_6_0
			}, ActivityPointRewardCfg[var_6_0].reward_item_list)
		else
			ShowPopItem(POP_ITEM, {
				arg_6_0.id,
				arg_6_0.number
			})
		end
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, function()
		arg_7_0:UpdateView()
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	arg_9_0.activityId_ = arg_9_1

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0, var_10_1 = ActivityWaterData:GetCurrentContributeCfg(arg_10_0.activityId_)
	local var_10_2 = ActivityWaterData:GetCurrentSelfProgress(arg_10_0.activityId_)

	if var_10_1 then
		arg_10_0.haveGetController_:SetSelectedState("true")
	elseif var_10_2 >= ActivityPointRewardCfg[var_10_0].need then
		arg_10_0.haveGetController_:SetSelectedState("canGet")
	else
		arg_10_0.haveGetController_:SetSelectedState("false")
	end

	arg_10_0.contributeValueText_.text = var_10_2 .. "/" .. ActivityPointRewardCfg[var_10_0].need

	local var_10_3 = ActivityPointRewardCfg[var_10_0].reward_item_list[1]
	local var_10_4 = formatReward(var_10_3)
	local var_10_5 = rewardToItemTemplate(var_10_4)

	arg_10_0.commonItem_:RefreshData(var_10_5)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.gameObject_.transform)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.commonItem_ then
		arg_14_0.commonItem_:Dispose()

		arg_14_0.commonItem_ = nil
	end

	arg_14_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
