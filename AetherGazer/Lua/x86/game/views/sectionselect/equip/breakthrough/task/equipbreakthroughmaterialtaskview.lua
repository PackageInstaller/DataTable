local var_0_0 = class("EquipBreakThroughMaterialTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapScoreExchangeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.receiveAllBtn_.transform, "name")
	arg_3_0.taskList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, EquipBreakThroughMaterialTaskItem)
	arg_3_0.updateHandler_ = handler(arg_3_0, arg_3_0.UpdateBreakThroughData)
	arg_3_0.receiveHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
end

function var_0_0.OnEnter(arg_4_0)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, arg_4_0.updateHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_REWARD, arg_4_0.receiveHandler_)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopTimer()
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, arg_5_0.updateHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_REWARD, arg_5_0.receiveHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.taskList_:Dispose()

	arg_6_0.taskList_ = nil
	arg_6_0.updateHandler_ = nil
	arg_6_0.receiveHandler_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.receiveAllBtn_, nil, function()
		if #EquipBreakThroughMaterialData:GetCanReceiveList() <= 0 then
			return
		end

		if table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_BREAK_THROUGH_REWARD_TIPS"),
				OkCallback = function()
					arg_7_0:ClickItem()
				end
			})
		else
			arg_7_0:ClickItem()
		end
	end)
end

function var_0_0.ClickItem(arg_10_0)
	local var_10_0 = EquipBreakThroughMaterialData:GetCanReceiveList()

	EquipBreakThroughMaterialAction.SendReceiveReward(var_10_0, function(arg_11_0)
		arg_10_0:RefreshUI()
	end)
end

function var_0_0.RefreshUI(arg_12_0)
	if #EquipBreakThroughMaterialData:GetCanReceiveList() > 0 then
		arg_12_0.controller_:SetSelectedState("true")
	else
		arg_12_0.controller_:SetSelectedState("false")
	end

	arg_12_0.taskList_:StartScroll(#EquipBreakThroughMaterialTaskCfg.all)

	arg_12_0.pointText_.text = EquipBreakThroughMaterialData:GetTotalPoint()

	arg_12_0:AddTimer()
end

function var_0_0.RefreshItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = EquipBreakThroughMaterialData:GetSortRewardList()

	arg_13_2:SetData(var_13_0[arg_13_1])
end

function var_0_0.UpdateBreakThroughData(arg_14_0)
	EquipBreakThroughMaterialAction.EquipBTMaterialBackEntrace()
end

function var_0_0.AddTimer(arg_15_0)
	arg_15_0:StopTimer()

	local var_15_0 = EquipBreakThroughMaterialData:GetRefreshTimestamp()

	arg_15_0.timeText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_15_0))
	arg_15_0.timer_ = Timer.New(function()
		arg_15_0.timeText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_15_0))
	end, 1, -1)

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

return var_0_0
