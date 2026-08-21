local var_0_0 = class("DormLinkGameActivityItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.count = 0
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListenerScale(arg_4_0.rewardBtn_, nil, function()
		arg_4_0.getAward(arg_4_0.ID)
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.ID = arg_6_1

	local var_6_0 = ActivityLinkGameRewardCfg[arg_6_1].condition

	if not ConditionCfg[var_6_0] then
		return
	end

	arg_6_0.text_.text = DormLinkGameTools:GetAwardDesc(arg_6_1)

	local var_6_1 = DormLinkGameData:CheckLevelRewardState(arg_6_1)

	if var_6_1 == DormLinkGameConst.RewardItemState.unComplete then
		arg_6_0.stateController:SetSelectedState("uncomplete")
	elseif var_6_1 == DormLinkGameConst.RewardItemState.complete then
		arg_6_0.stateController:SetSelectedState("complete")
	elseif var_6_1 == DormLinkGameConst.RewardItemState.received then
		arg_6_0.stateController:SetSelectedState("received")
	end

	arg_6_0:UpdataReward()
end

local function var_0_1(arg_7_0)
	ShowPopItem(POP_ITEM, arg_7_0)
end

function var_0_0.UpdataReward(arg_8_0)
	if not arg_8_0.rewardList then
		arg_8_0.rewardList = {}
	end

	local var_8_0 = ActivityLinkGameRewardCfg[arg_8_0.ID].item_list

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = formatReward(iter_8_1)
		local var_8_2 = rewardToItemTemplate(var_8_1)

		var_8_2.clickFun = var_0_1

		if arg_8_0.rewardList[iter_8_0] then
			arg_8_0.rewardList[iter_8_0]:SetData(var_8_2)
		else
			arg_8_0.rewardList[iter_8_0] = CommonItemPool.New(arg_8_0.rewardParent_, var_8_2)
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0.rewardList) do
		arg_8_0.rewardList[iter_8_2]:Show(true)
	end
end

function var_0_0.GetLevelAward(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.getAward = arg_9_1
	end
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.rewardList then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.rewardList) do
			arg_10_0.rewardList[iter_10_0]:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
