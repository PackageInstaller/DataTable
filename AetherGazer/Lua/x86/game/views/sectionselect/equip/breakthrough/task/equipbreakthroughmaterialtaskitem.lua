local var_0_0 = class("EquipBreakThroughMaterialTaskItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "status")
	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshRewardItem), arg_1_0.uiList_, CommonItem)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.receiveBtn_, nil, function()
		if table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_BREAK_THROUGH_REWARD_TIPS"),
				OkCallback = function()
					arg_2_0:ClickItem()
				end
			})
		else
			arg_2_0:ClickItem()
		end
	end)
end

function var_0_0.ClickItem(arg_5_0)
	local var_5_0 = {
		arg_5_0.taskID_
	}

	EquipBreakThroughMaterialAction.SendReceiveReward(var_5_0, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			manager.notify:Invoke(EQUIP_BREAK_THROUGH_REWARD)
		end
	end)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	arg_7_0.uiList_:Dispose()

	arg_7_0.uiList_ = nil
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	local var_8_0 = EquipBreakThroughMaterialData:GetSelectModeID()
	local var_8_1 = EquipBreakThroughMaterialDifficultyCfg[var_8_0].reward_list[arg_8_1]

	arg_8_0.rewardList_ = var_8_1

	arg_8_0.uiList_:StartScroll(#var_8_1)

	arg_8_0.descText_.text = GetI18NText(EquipBreakThroughMaterialTaskCfg[arg_8_1].des)
	arg_8_0.taskID_ = arg_8_1

	arg_8_0:RefreshBtn()
end

function var_0_0.RefreshRewardItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshData({
		id = arg_9_0.rewardList_[arg_9_1][1],
		number = arg_9_0.rewardList_[arg_9_1][2]
	})
	arg_9_2:RegistCallBack(function(arg_10_0)
		ShowPopItem(POP_ITEM, {
			arg_10_0.id,
			arg_10_0.number
		})
	end)
end

function var_0_0.RefreshBtn(arg_11_0)
	local var_11_0 = EquipBreakThroughMaterialData:GetTaskList()[arg_11_0.taskID_]

	if table.keyof(EquipBreakThroughMaterialData:GetReceivedList(), arg_11_0.taskID_) then
		arg_11_0.controller_:SetSelectedState("haveGet")
	elseif var_11_0.currentValue >= var_11_0.targetValue then
		arg_11_0.controller_:SetSelectedState("canGet")
	else
		arg_11_0.controller_:SetSelectedState("cannotGet")
	end
end

return var_0_0
