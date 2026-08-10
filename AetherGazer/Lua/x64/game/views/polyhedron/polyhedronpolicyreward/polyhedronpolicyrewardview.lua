local var_0_0 = class("PolyhedronPolicyRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronDeviationUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, PolyhedronPolicyRewardItem)
	arg_4_0.stageRewardItem_ = PolyhedronPolicyRewardItem.New(arg_4_0.stageRewardGo_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.allReceiveBtn_, nil, function()
		PolyhedronAction.QueryPolicyReward(1)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_7_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.rewardList_:Dispose()

	arg_9_0.rewardList_ = nil

	arg_9_0.stageRewardItem_:Dispose()

	arg_9_0.stageRewardItem_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.rewardCfg_ = PolyhedronTools.GetPolicyIDList()
	arg_10_0.curLevel_, arg_10_0.curExp_ = PolyhedronTools.PolyhedronPolicyExpToLevel()

	arg_10_0:RefreshLevel()

	local var_10_0 = arg_10_0:RefreshReceiveBtn()

	var_10_0 = var_10_0 <= #arg_10_0.rewardCfg_ and var_10_0 or #arg_10_0.rewardCfg_

	arg_10_0.rewardList_:StartScroll(#arg_10_0.rewardCfg_, var_10_0)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_0.rewardCfg_[arg_11_1], arg_11_0.curLevel_)

	local var_11_0 = arg_11_0.rewardList_:GetItemList()
	local var_11_1 = 1

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		var_11_1 = var_11_1 < iter_11_1.level_ and iter_11_1.level_ or var_11_1
	end

	if var_11_1 > arg_11_0.curStageLevel_ or var_11_1 <= arg_11_0.curStageLevel_ - 10 then
		arg_11_0:RefreshStageReward(var_11_1)
	end
end

function var_0_0.RefreshLevel(arg_12_0)
	arg_12_0.levelText_.text = arg_12_0.curLevel_

	local var_12_0 = PolyhedronTools.GetPolicyIDList()

	arg_12_0.levelList_ = var_12_0

	local var_12_1 = #var_12_0
	local var_12_2 = arg_12_0.curLevel_ + 1

	var_12_2 = var_12_2 <= var_12_1 and var_12_2 or var_12_1

	local var_12_3 = 0

	if arg_12_0.curLevel_ == 0 then
		var_12_3 = PolyhedronPolicyCfg[var_12_0[1]].exp
	elseif arg_12_0.curLevel_ == var_12_1 then
		var_12_3 = PolyhedronPolicyCfg[var_12_0[arg_12_0.curLevel_]].exp - PolyhedronPolicyCfg[var_12_0[arg_12_0.curLevel_ - 1]].exp
	else
		var_12_3 = PolyhedronPolicyCfg[var_12_0[var_12_2]].exp - PolyhedronPolicyCfg[var_12_0[arg_12_0.curLevel_]].exp
	end

	arg_12_0.expText_.text = string.format("%d/%d", math.min(arg_12_0.curExp_, var_12_3), var_12_3)
	arg_12_0.progressSlider_.value = arg_12_0.curExp_ / var_12_3

	arg_12_0:RefreshStageReward(var_12_2)
end

function var_0_0.RefreshStageReward(arg_13_0, arg_13_1)
	local var_13_0 = math.ceil(arg_13_1 / 10) * 10
	local var_13_1 = #arg_13_0.levelList_

	var_13_0 = var_13_1 < var_13_0 and var_13_1 or var_13_0

	arg_13_0.stageRewardItem_:SetData(arg_13_0.rewardCfg_[var_13_0], arg_13_0.curLevel_)

	arg_13_0.curStageLevel_ = var_13_0
end

function var_0_0.RefreshReceiveBtn(arg_14_0)
	local var_14_0 = PolyhedronData:GetPolicyApplyList()

	for iter_14_0 = 1, arg_14_0.curLevel_ do
		if var_14_0[iter_14_0] == nil then
			SetActive(arg_14_0.allReceiveBtn_.gameObject, true)

			return iter_14_0
		end
	end

	SetActive(arg_14_0.allReceiveBtn_.gameObject, false)

	return arg_14_0.curLevel_ + 1
end

function var_0_0.OnReceivedPolicyReward(arg_15_0)
	arg_15_0:RefreshUI()
end

function var_0_0.OnPolyhedronGameUpdate(arg_16_0)
	arg_16_0:RefreshUI()
end

return var_0_0
