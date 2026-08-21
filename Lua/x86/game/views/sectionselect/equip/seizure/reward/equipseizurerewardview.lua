local var_0_0 = class("EquipSeizureRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Equip_Seizure/EquipSeizuRerewardPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.controller_ = arg_3_0.controlExCo_:GetController("state")
	arg_3_0.itemList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, EquipSeizureRewardItem)
	arg_3_0.updateHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
	arg_3_0.receiveHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
end

function var_0_0.OnEnter(arg_4_0)
	manager.notify:RegistListener(EQUIP_SEIZURE_UPDATE, arg_4_0.updateHandler_)
	manager.notify:RegistListener(EQUIP_SEIZURE_REWARD, arg_4_0.receiveHandler_)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopTimer()
	manager.notify:RemoveListener(EQUIP_SEIZURE_UPDATE, arg_5_0.updateHandler_)
	manager.notify:RemoveListener(EQUIP_SEIZURE_REWARD, arg_5_0.receiveHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.itemList_:Dispose()

	arg_6_0.itemList_ = nil
	arg_6_0.updateHandler_ = nil
	arg_6_0.receiveHandler_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.receiveAllBtn_, nil, function()
		if #EquipSeizureData:GetCanReceiveList() <= 0 then
			return
		end

		arg_7_0:ClickItem()
	end)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.ClickItem(arg_10_0)
	local var_10_0 = EquipSeizureData:GetCanReceiveList()

	EquipSeizureAction.SendReceiveReward(var_10_0, function(arg_11_0)
		arg_10_0:RefreshUI()
	end)
end

function var_0_0.RefreshUI(arg_12_0)
	if #EquipSeizureData:GetCanReceiveList() > 0 then
		arg_12_0.controller_:SetSelectedState("canget")
	else
		arg_12_0.controller_:SetSelectedState("unfinish")
	end

	arg_12_0.itemList_:StartScroll(#EquipSeizurePointRewardCfg.all)

	arg_12_0.pointText_.text = EquipSeizureData:GetTotalScore()

	arg_12_0:AddTimer()
end

function var_0_0.RefreshItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = EquipSeizureData:GetSortRewardList()

	arg_13_2:SetData(var_13_0[arg_13_1])
end

function var_0_0.AddTimer(arg_14_0)
	arg_14_0:StopTimer()

	arg_14_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	arg_14_0.timer_ = Timer.New(function()
		arg_14_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	end, 1, -1)

	arg_14_0.timer_:Start()
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

return var_0_0
