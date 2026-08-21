local var_0_0 = class("ChapterSectionRewardItemPanel", ReduxView)
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

	arg_2_0.btnController_ = arg_2_0.controllerEx_:GetController("default0")
	arg_2_0.rewardItemList_ = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.rewardItemList_[iter_2_0] = CommonItemView.New(arg_2_0[string.format("rewardItem%s_", iter_2_0)])
	end
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.chapterID_ = arg_3_1

	arg_3_0:RefreshData()
	arg_3_0:RefreshUI()
	arg_3_0:RefreshState()
	arg_3_0:RefreshItem()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveListeners()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.rewardItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.rewardItemList_ = nil
	arg_4_0.rewardPanel_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.rewardPanel_ = {}

	for iter_5_0 = 1, 3 do
		arg_5_0.rewardPanel_[iter_5_0] = arg_5_0[string.format("rewardItem%s_", iter_5_0)]
	end
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		if arg_6_0.rewardState_ == var_0_2 then
			OperationRecorder.Record(arg_6_0.class.__cname, "collect_get_reward")

			local var_7_0 = arg_6_0.chapterID_
			local var_7_1 = arg_6_0.rewardIndex_
			local var_7_2 = arg_6_0.rewardState_

			BattleStageAction.GetChapterStarReward(var_7_0, var_7_1, function(arg_8_0)
				if isSuccess(arg_8_0.result) then
					getReward(arg_8_0.reward_list)
					BattleStageData:SetChapterStarReward(var_7_0, var_7_1)
					arg_6_0:GetRewardState()

					if var_7_2 == var_0_2 and arg_6_0.rewardState_ == var_0_3 then
						arg_6_0:RefreshState()
						arg_6_0:RefreshItem()
					end
				else
					ShowTips(arg_8_0.result)
				end
			end)
		end
	end)
end

function var_0_0.RemoveListeners(arg_9_0)
	return
end

function var_0_0.RefreshData(arg_10_0)
	local var_10_0 = arg_10_0.rewardIndex_
	local var_10_1 = arg_10_0.chapterID_

	if var_10_0 == 1 then
		arg_10_0.rewradCfg_ = ChapterCfg[var_10_1].first_reward
	elseif var_10_0 == 2 then
		arg_10_0.rewradCfg_ = ChapterCfg[var_10_1].second_reward
	else
		arg_10_0.rewradCfg_ = ChapterCfg[var_10_1].third_reward
	end

	local var_10_2 = 0
	local var_10_3 = ChapterCfg[var_10_1].section_id_list
	local var_10_4 = BattleStageData:GetStageData()

	for iter_10_0, iter_10_1 in ipairs(var_10_3) do
		local var_10_5 = var_10_4[iter_10_1]

		if var_10_5 then
			for iter_10_2, iter_10_3 in ipairs(var_10_5.stars) do
				if iter_10_3 == 1 then
					var_10_2 = var_10_2 + 1
				end
			end
		end
	end

	arg_10_0.curStarCnt_ = var_10_2
	arg_10_0.totalStarCnt_ = ChapterCfg[var_10_1].star_need[var_10_0]

	arg_10_0:GetRewardState()
end

function var_0_0.GetRewardState(arg_11_0)
	local var_11_0 = arg_11_0.rewardIndex_
	local var_11_1 = arg_11_0.chapterID_
	local var_11_2

	if arg_11_0.curStarCnt_ < arg_11_0.totalStarCnt_ then
		var_11_2 = var_0_1
	else
		local var_11_3 = BattleStageData:GetChapterStarRewardState()

		if var_11_3[var_11_1] and var_11_3[var_11_1][var_11_0] and var_11_3[var_11_1][var_11_0] >= 1 then
			var_11_2 = var_0_3
		else
			var_11_2 = var_0_2
		end
	end

	arg_11_0.rewardState_ = var_11_2
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = arg_12_0.rewardIndex_

	arg_12_0.progressCntText_.text = string.format(GetTips("COMPLETE_TARGET"), arg_12_0.totalStarCnt_)

	local var_12_1 = arg_12_0.curStarCnt_ > arg_12_0.totalStarCnt_ and arg_12_0.totalStarCnt_ or arg_12_0.curStarCnt_

	arg_12_0.progressText_.text = string.format("%s/%s", var_12_1, arg_12_0.totalStarCnt_)
	arg_12_0.progressBar_.value = var_12_1 / arg_12_0.totalStarCnt_
end

function var_0_0.RefreshState(arg_13_0)
	if arg_13_0.rewardState_ == var_0_2 then
		arg_13_0.btnController_:SetSelectedState("clear")
	elseif arg_13_0.rewardState_ == var_0_1 then
		arg_13_0.btnController_:SetSelectedState("notclear")
	else
		arg_13_0.btnController_:SetSelectedState("received")
	end
end

function var_0_0.RefreshItem(arg_14_0)
	local var_14_0 = arg_14_0.rewradCfg_

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		local var_14_1 = clone(ItemTemplateData)

		var_14_1.id = iter_14_1[1]
		var_14_1.number = iter_14_1[2]

		if arg_14_0.rewardState_ == var_0_3 then
			var_14_1.grayFlag = true
		else
			var_14_1.grayFlag = false
		end

		function var_14_1.clickFun(arg_15_0)
			ShowPopItem(POP_ITEM, {
				arg_15_0.id,
				arg_15_0.number
			})
		end

		arg_14_0.rewardItemList_[iter_14_0]:SetData(var_14_1)
	end

	for iter_14_2 = #var_14_0 + 1, #arg_14_0.rewardItemList_ do
		arg_14_0.rewardItemList_[iter_14_2]:SetData(nil)
	end
end

return var_0_0
