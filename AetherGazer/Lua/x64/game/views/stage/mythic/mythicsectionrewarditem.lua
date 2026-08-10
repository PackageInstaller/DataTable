local var_0_0 = class("MythicSectionRewardItem", ReduxView)
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.rewardIndex_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItemList_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.rewardItemList_[iter_3_0] = CommonItemView.New(arg_3_0["rewardItem" .. iter_3_0 .. "_"])
	end
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if arg_4_0.rewardState_ == var_0_2 then
			if MythicData:GetStarRewardCount() == 0 then
				ShowMessageBox({
					content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
					OkCallback = function()
						MythicAction.QueryMythicStar(arg_4_0.rewardIndex_)
					end
				})
			else
				MythicAction.QueryMythicStar(arg_4_0.rewardIndex_)
			end
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0:RefreshData(arg_7_1)
	arg_7_0:RefreshUI()
	arg_7_0:RefreshState()
	arg_7_0:RefreshItem()
end

function var_0_0.RefreshData(arg_8_0, arg_8_1)
	arg_8_0.difficulty_ = arg_8_1

	local var_8_0 = MythicNormalCfg[arg_8_0.difficulty_].star_reward_list[arg_8_0.rewardIndex_]

	arg_8_0.rewradCfg_ = getRewardFromDropCfg(var_8_0 or 0, true)
	arg_8_0.curStarCnt_ = MythicData:GetStarCount()
	arg_8_0.totalStarCnt_ = arg_8_0.rewardIndex_

	arg_8_0:GetRewardState()
end

function var_0_0.GetRewardState(arg_9_0)
	local var_9_0 = arg_9_0.rewardIndex_
	local var_9_1

	if arg_9_0.curStarCnt_ < arg_9_0.totalStarCnt_ then
		var_9_1 = var_0_1
	elseif MythicData:GetStarRewardState(var_9_0) then
		var_9_1 = var_0_3
	else
		var_9_1 = var_0_2
	end

	arg_9_0.rewardState_ = var_9_1
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0.rewardIndex_

	arg_10_0.progressCntText_.text = arg_10_0.totalStarCnt_

	local var_10_1 = arg_10_0.curStarCnt_ > arg_10_0.totalStarCnt_ and arg_10_0.totalStarCnt_ or arg_10_0.curStarCnt_

	arg_10_0.progressText_.text = string.format("%s/%s", var_10_1, arg_10_0.totalStarCnt_)
	arg_10_0.progressBar_.normalizedValue = var_10_1 / arg_10_0.totalStarCnt_
end

function var_0_0.RefreshState(arg_11_0)
	SetActive(arg_11_0.mask_, arg_11_0.rewardState_ == var_0_3)
	SetActive(arg_11_0.unlockGo_, arg_11_0.rewardState_ == var_0_1)
	SetActive(arg_11_0.receiveBtnGo_, arg_11_0.rewardState_ == var_0_2)
end

function var_0_0.RefreshItem(arg_12_0)
	local var_12_0 = arg_12_0.rewradCfg_

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if iter_12_0 > 3 then
			return
		end

		local var_12_1 = rewardToItemTemplate(iter_12_1)

		if arg_12_0.rewardState_ == var_0_3 then
			var_12_1.grayFlag = true
		end

		function var_12_1.clickFun(arg_13_0)
			ShowPopItem(POP_ITEM, arg_13_0)
		end

		arg_12_0.rewardItemList_[iter_12_0]:SetData(var_12_1)
	end

	for iter_12_2 = #var_12_0 + 1, 3 do
		arg_12_0.rewardItemList_[iter_12_2]:SetData(nil)
	end
end

function var_0_0.Dispose(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.rewardItemList_) do
		iter_14_1:Dispose()
	end

	arg_14_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
