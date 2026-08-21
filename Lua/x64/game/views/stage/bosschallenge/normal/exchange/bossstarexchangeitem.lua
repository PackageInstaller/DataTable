local var_0_0 = class("BossStarExchangeItem", ReduxView)
local var_0_1 = "notclear"
local var_0_2 = "clear"
local var_0_3 = "received"

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardPanel_ = {}
	arg_3_0.rewardItemList_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.rewardPanel_[iter_3_0] = arg_3_0[string.format("rewardItem%s_", iter_3_0)]
		arg_3_0.rewardItemList_[iter_3_0] = CommonItemView.New(arg_3_0.rewardPanel_[iter_3_0])
	end

	arg_3_0.controller_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("default0")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if arg_4_0.rewardState_ == var_0_2 then
			if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) <= 0 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
					OkCallback = function()
						arg_4_0:ClickItem()
					end
				})
			else
				arg_4_0:ClickItem()
			end
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.rewardIndex_ = arg_7_3
	arg_7_0.rewardCfg_ = getRewardFromDropCfg(arg_7_1[2], true)
	arg_7_0.totalStarCnt_ = arg_7_1[1]
	arg_7_0.curStarCnt_ = arg_7_2 > arg_7_1[1] and arg_7_1[1] or arg_7_2

	arg_7_0:GetRewardState()
	arg_7_0:RefreshUI(arg_7_2)
	arg_7_0:RefreshState()
	arg_7_0:RefreshItem()
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.rewardIndex_

	arg_8_0.progressCntText_.text = string.format(GetTips("COMPLETE_TARGET"), arg_8_0.totalStarCnt_)
	arg_8_0.progressText_.text = string.format("%s/%s", arg_8_1, arg_8_0.totalStarCnt_)
	arg_8_0.progressBar_.value = arg_8_1 / arg_8_0.totalStarCnt_

	if var_8_0 < 10 then
		arg_8_0.textPhase_.text = 0 .. tostring(var_8_0)
	else
		arg_8_0.textPhase_.text = var_8_0
	end
end

function var_0_0.RefreshState(arg_9_0)
	arg_9_0.controller_:SetSelectedState(tostring(arg_9_0.rewardState_))
end

function var_0_0.RefreshItem(arg_10_0)
	local var_10_0 = arg_10_0.rewardCfg_

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_1

		var_10_1.clickFun, var_10_1 = function(arg_11_0)
			ShowPopItem(POP_ITEM, {
				arg_11_0.id
			})
		end, rewardToItemTemplate(iter_10_1)

		CommonTools.SetCommonData(arg_10_0.rewardItemList_[iter_10_0], var_10_1)
		arg_10_0.rewardItemList_[iter_10_0]:RefreshGray(arg_10_0.rewardState_ == var_0_3)
	end

	for iter_10_2 = #var_10_0 + 1, #arg_10_0.rewardItemList_ do
		arg_10_0.rewardItemList_[iter_10_2]:SetData()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.rewardContent_)
end

function var_0_0.ClickItem(arg_12_0)
	local var_12_0 = arg_12_0.rewardState_

	BattleBossChallengeAction.RequireBossExchange(arg_12_0.curStarCnt_, function(arg_13_0)
		if isSuccess(arg_13_0.result) then
			BattleBossChallengeNormalData:SetReceiveStarList(arg_12_0.totalStarCnt_)
			arg_12_0:GetRewardState()
			getReward2(arg_13_0.item_list)

			if var_12_0 == var_0_2 and arg_12_0.rewardState_ == var_0_3 then
				arg_12_0:RefreshState()
				manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
			end
		else
			ShowTips(arg_13_0.result)
		end
	end)
end

function var_0_0.GetRewardState(arg_14_0)
	local var_14_0 = arg_14_0.rewardIndex_
	local var_14_1 = arg_14_0.chapterID_
	local var_14_2

	if arg_14_0.curStarCnt_ < arg_14_0.totalStarCnt_ then
		var_14_2 = var_0_1
	elseif table.keyof(BattleBossChallengeNormalData:GetReceiveStarList(), arg_14_0.totalStarCnt_) then
		var_14_2 = var_0_3
	else
		var_14_2 = var_0_2
	end

	arg_14_0.rewardState_ = var_14_2
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.rewardItemList_) do
		iter_15_1:Dispose()
	end

	arg_15_0.rewardItemList_ = nil
	arg_15_0.rewardPanel_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
