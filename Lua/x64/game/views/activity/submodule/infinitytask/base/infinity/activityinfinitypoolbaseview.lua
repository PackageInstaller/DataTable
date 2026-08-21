local var_0_0 = class("ActivityInfinityPoolCfg", ReduxView)

function var_0_0.GetAssetName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisUIInfinitypoolUI"
end

function var_0_0.GetInfinityPoolItem(arg_2_0)
	return ActivityInfinityPoolBaseItem
end

function var_0_0.ClickRewardPreview(arg_3_0)
	JumpTools.OpenPageByJump("osirisRewardPreview", {
		poolID = arg_3_0.poolID_
	})
end

function var_0_0.Ctor(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Asset.Load(arg_4_0:GetAssetName())

	arg_4_0.gameObject_ = Object.Instantiate(var_4_0, arg_4_1.transform)
	arg_4_0.transform_ = arg_4_0.gameObject_.transform

	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()

	arg_4_0.activityID_ = arg_4_2
	arg_4_0.lotteryItemList_ = {}
	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.transform_, "name")
	arg_4_0.rewardController_ = ControllerUtil.GetController(arg_4_0.goMainReward_.transform, "name")
	arg_4_0.openCoreItemHandler_ = handler(arg_4_0, arg_4_0.OpenCoreItem)

	arg_4_0:OnEnter()
end

function var_0_0.OnEnter(arg_5_0)
	manager.notify:RegistListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, arg_5_0.openCoreItemHandler_)

	arg_5_0.stopTime_ = ActivityData:GetActivityData(arg_5_0.activityID_).stopTime

	arg_5_0:AddTimer()

	arg_5_0.leftTime_.text = GetTips("REMAINING_TIME")
end

function var_0_0.OnExit(arg_6_0)
	manager.notify:RemoveListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, arg_6_0.openCoreItemHandler_)
	arg_6_0:StopTimer()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	arg_7_0.openCoreItemHandler_ = nil

	for iter_7_0, iter_7_1 in pairs(arg_7_0.lotteryItemList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.lotteryItemList_ = nil

	if arg_7_0.mainRewardItem_ then
		arg_7_0.mainRewardItem_:Dispose()

		arg_7_0.mainRewardItem_ = nil
	end

	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btnRewardView_, nil, function()
		arg_8_0:ClickRewardPreview()
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnReset_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("RESET_INFINITY"),
			OkCallback = function()
				OsirisAction.ResetPool(arg_8_0.poolID_, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						arg_8_0:RefreshUI()
					else
						ShowTips(arg_12_0.result)
					end
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.unresetBtn_, nil, function()
		ShowTips("UNLOCK_INFINITY_RESET_TIPS")
	end)
end

function var_0_0.SetPhase(arg_15_0, arg_15_1)
	if arg_15_0.phase_ == arg_15_1 then
		return
	end

	arg_15_0.phase_ = arg_15_1

	arg_15_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_16_0)
	local var_16_0 = arg_16_0.phase_
	local var_16_1 = ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_16_0.activityID_][var_16_0]

	arg_16_0.poolID_ = var_16_1

	local var_16_2 = OsirisInfinityPoolData:GetPoolData(var_16_1)
	local var_16_3 = #var_16_2.itemList

	if var_16_2.coreItem then
		var_16_3 = var_16_3 + 1
	end

	for iter_16_0 = 1, var_16_3 do
		if arg_16_0.lotteryItemList_[iter_16_0] == nil then
			arg_16_0.lotteryItemList_[iter_16_0] = arg_16_0:GetInfinityPoolItem().New(arg_16_0.goItem_, arg_16_0.goItemParent_)
		end

		arg_16_0.lotteryItemList_[iter_16_0]:SetData(var_16_1, iter_16_0)
	end

	for iter_16_1 = #arg_16_0.lotteryItemList_, var_16_3 + 1, -1 do
		arg_16_0.lotteryItemList_[iter_16_1]:Show(false)
	end

	arg_16_0.phase_ = var_16_0

	arg_16_0:RefreshCoreItem()
end

function var_0_0.RefreshCoreItem(arg_17_0)
	local var_17_0 = arg_17_0.phase_
	local var_17_1 = ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_17_0.activityID_][var_17_0]
	local var_17_2 = OsirisInfinityPoolData:GetPoolData(var_17_1)

	if var_17_0 == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_17_0.activityID_] == false then
		arg_17_0.controller_:SetSelectedState("false")

		arg_17_0.canReset_ = false
	elseif table.length(var_17_2.openBoxList) < #var_17_2.itemList then
		arg_17_0.controller_:SetSelectedState("noreset")

		arg_17_0.canReset_ = false
	else
		arg_17_0.controller_:SetSelectedState("true")

		arg_17_0.canReset_ = true
	end

	if var_17_2.isOpenCoreItem then
		arg_17_0.rewardController_:SetSelectedState("get")
	else
		arg_17_0.rewardController_:SetSelectedState("normal")
	end

	arg_17_0:RefreshMainReward(var_17_2.coreItem)
end

function var_0_0.RefreshMainReward(arg_18_0, arg_18_1)
	if arg_18_1 == nil then
		return
	end

	if arg_18_1[1] == 0 then
		return
	end

	if arg_18_0.mainRewardItem_ == nil then
		arg_18_0.mainRewardItem_ = arg_18_0:GetRewardItem(arg_18_1)
	else
		arg_18_0.mainRewardItem_:SetData(arg_18_1)
	end
end

function var_0_0.GetRewardItem(arg_19_0, arg_19_1)
	return RewardPoolItem.New(arg_19_0.goMainReward_, arg_19_1)
end

function var_0_0.Show(arg_20_0, arg_20_1)
	if arg_20_1 == false then
		arg_20_0.phase_ = nil
	end

	if arg_20_0.gameObject_.activeSelf == arg_20_1 then
		return
	end

	SetActive(arg_20_0.gameObject_, arg_20_1)
end

function var_0_0.OpenCoreItem(arg_21_0)
	arg_21_0:RefreshCoreItem()
end

function var_0_0.AddTimer(arg_22_0)
	if manager.time:GetServerTime() >= arg_22_0.stopTime_ then
		arg_22_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_22_0.textTime_.text = manager.time:GetLostTimeStr(arg_22_0.stopTime_)
	arg_22_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_22_0.stopTime_ then
			arg_22_0:StopTimer()

			arg_22_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_22_0.textTime_.text = manager.time:GetLostTimeStr(arg_22_0.stopTime_)
	end, 1, -1)

	arg_22_0.timer_:Start()
end

function var_0_0.StopTimer(arg_24_0)
	if arg_24_0.timer_ then
		arg_24_0.timer_:Stop()

		arg_24_0.timer_ = nil
	end
end

return var_0_0
