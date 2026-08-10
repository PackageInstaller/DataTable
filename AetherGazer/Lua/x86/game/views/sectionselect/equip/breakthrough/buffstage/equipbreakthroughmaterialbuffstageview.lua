local var_0_0 = class("EquipBreakThroughMaterialBullStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapProcessUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.buffList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.buffUIList_, EquipBreakThroughMaterialBuffStageItem)
	arg_3_0.okBtnController_ = ControllerUtil.GetController(arg_3_0.okBtnTf_, "name")
	arg_3_0.selectHandler_ = handler(arg_3_0, arg_3_0.SelectItem)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.okBtnController_:SetSelectedState("false")

	arg_4_0.selectIndex_ = nil
	arg_4_0.mapStageID_ = arg_4_0.params_.mapStageID

	local var_4_0 = GetTips("EQUIP_BREAK_THROUGH_BUFF_HEAL")

	arg_4_0.cancelText_.text = string.format(var_4_0, GameSetting.equip_crossroads_buff_healing.value[1])

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, arg_4_0.selectHandler_)

	local var_4_1 = EquipBreakThroughMaterialData:GetStageData()[arg_4_0.mapStageID_].buffList

	arg_4_0.buffList_:StartScroll(#var_4_1)
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, arg_5_0.selectHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.selectHandler_ = nil

	arg_6_0.buffList_:Dispose()

	arg_6_0.buffList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		if arg_7_0.selectIndex_ == nil then
			return
		end

		local var_8_0 = EquipBreakThroughMaterialData:GetStageData()[arg_7_0.mapStageID_].buffList[arg_7_0.selectIndex_]

		EquipBreakThroughMaterialAction.ChooseBuff(arg_7_0.mapStageID_, var_8_0, function(arg_9_0)
			if isSuccess(arg_9_0.result) then
				arg_7_0:Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
			end
		end)
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		EquipBreakThroughMaterialAction.ChooseBuff(arg_7_0.mapStageID_, 0, function(arg_11_0)
			if isSuccess(arg_11_0.result) then
				arg_7_0:Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
				ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_TEAM_HEAL"), GameSetting.equip_crossroads_buff_healing.value[1]))
			end
		end)
	end)
end

function var_0_0.RefreshItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, arg_12_0.mapStageID_, arg_12_0.selectIndex_)
end

function var_0_0.SelectItem(arg_13_0, arg_13_1)
	arg_13_0.okBtnController_:SetSelectedState("true")

	arg_13_0.selectIndex_ = arg_13_1
end

return var_0_0
