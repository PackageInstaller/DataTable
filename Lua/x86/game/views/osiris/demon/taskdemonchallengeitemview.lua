local var_0_0 = class("TaskDemonChallengeItemView", ReduxView)
local var_0_1 = import("game.tools.JumpTools")
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.popType_ = POP_ITEM

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.itemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.itemListGo_, CommonItem)
	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.transform_, "conName")
	arg_2_0.receiveHandler = handler(arg_2_0, arg_2_0.OnReceiveReward)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.rewardCfg_ = getRewardFromDropCfg(arg_3_1, true)
	arg_3_0.rewardIndex_ = arg_3_2
	arg_3_0.levelIndex_ = arg_3_3

	arg_3_0:GetRewardState()
	arg_3_0:RefreshUI()
	arg_3_0:RefreshState()
	arg_3_0:RefreshItem()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		if arg_5_0.rewardState_ == var_0_2 then
			local var_6_0 = DemonChallengeData:GetStageId(arg_5_0.levelIndex_, arg_5_0.rewardIndex_)

			DemonChallengeAction.RequireReceive(var_6_0, arg_5_0.receiveHandler)
		end
	end)
end

function var_0_0.OnReceiveReward(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.rewardState_

	if isSuccess(arg_7_1.result) then
		DemonChallengeData:SetReceiveList(arg_7_0.rewardIndex_, arg_7_0.levelIndex_)
		arg_7_0:GetRewardState()
		getReward(arg_7_0.rewardCfg_)

		if var_7_0 == var_0_2 and arg_7_0.rewardState_ == var_0_4 then
			arg_7_0:RefreshState()
			manager.notify:Invoke(DEMON_CHALLENGE_RECEIVE_REWARD)
		end
	else
		ShowTips(arg_7_1.result)
	end
end

function var_0_0.GetRewardState(arg_8_0)
	local var_8_0 = DemonChallengeData:GetReceiveList(arg_8_0.levelIndex_)

	arg_8_0.completed_ = DemonChallengeData:IsCompleted(arg_8_0.levelIndex_, arg_8_0.rewardIndex_)

	local var_8_1

	if not arg_8_0.completed_ then
		var_8_1 = var_0_3
	elseif table.keyof(var_8_0, arg_8_0.rewardIndex_) then
		var_8_1 = var_0_4
	else
		var_8_1 = var_0_2
	end

	arg_8_0.rewardState_ = var_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0.rewardIndex_
	local var_9_1 = ""

	if var_9_0 == 1 then
		var_9_1 = GetTips("CLEAR_NORMAL_DIFFICULTY")
	elseif var_9_0 == 2 then
		var_9_1 = GetTips("CLEAR_DIFFICULTY")
	else
		var_9_1 = GetTips("CLEAR_EXTREME_DIFFICULTY")
	end

	arg_9_0.Desctext_.text = var_9_1
end

function var_0_0.RefreshState(arg_10_0)
	arg_10_0.controller_:SetSelectedState(tostring(arg_10_0.rewardState_))
end

function var_0_0.RefreshItem(arg_11_0)
	arg_11_0.itemList_:StartScroll(#arg_11_0.rewardCfg_)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.rewardCfg_[arg_12_1]
	local var_12_1 = rewardToItemTemplate(var_12_0)

	var_12_1:RefreshData(var_12_1)
	var_12_1:RegistCallBack(function(arg_13_0)
		if arg_12_0.clickCallback_ then
			if arg_12_0.clickCallback_() then
				ShowPopItem(arg_12_0.popType_, arg_13_0)
			end
		else
			ShowPopItem(arg_12_0.popType_, arg_13_0)
		end
	end)
	var_12_1:Show(true)
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.itemList_ then
		arg_14_0.itemList_:Dispose()
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
