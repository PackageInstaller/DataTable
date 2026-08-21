local var_0_0 = class("QWorldRewardSideView", ReduxView)

function var_0_0.UIParent(arg_1_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_0.gameObject_.transform
	arg_2_0.mainHomePage_ = arg_2_2

	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.items_ = {}
	arg_3_0.showData_ = {}
	arg_3_0.nextGenTime_ = 0

	SetActive(arg_3_0.rewardItemGo_, false)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshUI()
end

function var_0_0.OnTop(arg_6_0)
	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.InsertRewards(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0 = 1, math.min(#arg_8_1, 8) do
		local var_8_1 = arg_8_1[1]

		table.remove(arg_8_1, 1)
		table.insert(var_8_0, var_8_1)
	end

	local var_8_2 = ItemTools.SortRewardItemList(var_8_0)

	for iter_8_1, iter_8_2 in ipairs(var_8_2) do
		local var_8_3 = {
			reward = iter_8_2
		}

		table.insert(arg_8_0.showData_, var_8_3)
	end

	if not arg_8_0.timer_ then
		arg_8_0.rewardBlankTrans_.sizeDelta = Vector2(10, 0)
		arg_8_0.timer_ = Timer.New(function()
			if #arg_8_0.showData_ > 0 then
				arg_8_0:UpdateShowData()
			else
				arg_8_0:StopTimer()
			end
		end, 0.033, -1)

		arg_8_0.timer_:Start()
	end
end

function var_0_0.UpdateShowData(arg_10_0)
	local var_10_0 = SandplaySettingCfg.pop_reward_interval.value[1] / 1000
	local var_10_1 = arg_10_0:GetCurSpaceItemCount()
	local var_10_2 = Time.time
	local var_10_3 = false

	if not arg_10_0.rewardPanelGo_.activeSelf then
		SetActive(arg_10_0.rewardPanelGo_, true)

		arg_10_0.nextGenTime_ = var_10_2 + 0.01
		var_10_3 = true
	end

	local var_10_4 = 1

	while var_10_4 <= #arg_10_0.showData_ do
		local var_10_5 = arg_10_0.showData_[var_10_4]
		local var_10_6 = false

		if var_10_5.item then
			local var_10_7 = var_10_5.item

			if var_10_2 > var_10_5.endTime then
				table.remove(arg_10_0.items_, var_10_4)
				table.insert(arg_10_0.items_, var_10_7)
				SetActive(var_10_7.gameObject_, false)
				table.remove(arg_10_0.showData_, var_10_4)

				var_10_6 = true
				arg_10_0.rewardBlankTrans_.sizeDelta = Vector2(10, -var_10_7.transform_.anchoredPosition.y + var_10_7.transform_.sizeDelta.y)
				var_10_3 = true
			else
				var_10_7:RefreshAnim()
			end
		elseif var_10_4 <= var_10_1 and var_10_2 >= arg_10_0.nextGenTime_ then
			local var_10_8 = arg_10_0.items_[var_10_4]

			if not var_10_8 then
				local var_10_9 = Object.Instantiate(arg_10_0.rewardItemGo_, arg_10_0.rewardListGo_.transform)

				var_10_8 = QWorldRewardSideItem.New(var_10_9)
				arg_10_0.items_[var_10_4] = var_10_8
			end

			SetActive(var_10_8.gameObject_, true)
			var_10_8.gameObject_.transform:SetAsLastSibling()
			var_10_8:SetData(var_10_5.reward)

			var_10_5.item = var_10_8
			var_10_5.endTime = var_10_2 + SandplaySettingCfg.pop_reward.value[1] / 1000
			arg_10_0.nextGenTime_ = var_10_2 + var_10_0
			var_10_3 = true
		end

		if not var_10_6 then
			var_10_4 = var_10_4 + 1
		end
	end

	local var_10_10 = 25

	if arg_10_0.rewardBlankTrans_.sizeDelta.y > 0 then
		arg_10_0.rewardBlankTrans_.sizeDelta = Vector2(10, math.max(arg_10_0.rewardBlankTrans_.sizeDelta.y - var_10_10, 0))

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.rewardListGo_.transform)
	end

	if var_10_3 then
		arg_10_0:RefreshUI()
		arg_10_0.mainHomePage_:UpdateLeftPanelLayout()
	end
end

function var_0_0.GetCurSpaceItemCount(arg_11_0)
	local var_11_0 = arg_11_0.leftPanelTrans_.rect.height + arg_11_0.rewardPanelGo_.transform.offsetMax.y + arg_11_0.rewardListGo_.transform.offsetMax.y
	local var_11_1 = arg_11_0.rewardItemGo_.transform.sizeDelta.y

	return math.max(math.floor(var_11_0 / var_11_1), 1)
end

function var_0_0.IsShowing(arg_12_0)
	return #arg_12_0.showData_ > 0 and (Time.time <= arg_12_0.nextGenTime_ or arg_12_0.rewardBlankTrans_.sizeDelta.y > 0)
end

function var_0_0.RefreshUI(arg_13_0)
	if arg_13_0:IsShowing() then
		SetActive(arg_13_0.rewardPanelGo_, true)
	else
		SetActive(arg_13_0.rewardPanelGo_, false)
		arg_13_0:StopTimer()
	end
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.items_) do
		iter_15_1:Dispose()
	end

	arg_15_0.showData_ = nil

	arg_15_0:StopTimer()

	arg_15_0.gameObject_ = nil
	arg_15_0.transform_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
