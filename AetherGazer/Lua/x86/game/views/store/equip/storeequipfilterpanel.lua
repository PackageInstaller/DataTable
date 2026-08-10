local var_0_0 = class("StoreEquipFilterPanel", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitDropDown()
	arg_1_0:AddListeners()

	arg_1_0.sortController_ = arg_1_0.sortControllerEx_:GetController("sort")
	arg_1_0.colorController_ = arg_1_0.filterControllerEx_:GetController("color")
end

function var_0_0.InitDropDown(arg_2_0)
	arg_2_0.sortDropdown_.options:Clear()
	arg_2_0.sortDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	arg_2_0.sortDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("AUTO_CHESS_2_HISTORY_TIP2"), nil))
	arg_2_0.sortDropdown_:RefreshShownValue()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.decomposeBtn_, nil, function()
		JumpTools.GoToSystem("/equipDecompose", {}, ViewConst.SYSTEM_ID.BAG)
	end)
	arg_4_0:AddBtnListener(arg_4_0.filterBtn_, nil, function()
		arg_4_0:Go("equipFilter", {
			filterParams = arg_4_0.filterParams_,
			equipPosition = arg_4_0.equipPosition_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.sortBtn_, nil, function()
		manager.notify:Invoke(SWITCH_SORT)
	end)
	arg_4_0:AddToggleListener(arg_4_0.sortDropdown_, function(arg_8_0)
		manager.notify:Invoke(SWITCH_SORT_RARE, arg_8_0)
	end)
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.filterParams_ = arg_9_1
	arg_9_0.equipPosition_ = arg_9_2
	arg_9_0.cntText_.text = string.format("%d/%d", EquipTools.GetEquipNum(), GameSetting.max_equip.value[1])

	if arg_9_1.order == ItemConst.SORT_TYPE.DOWN then
		arg_9_0.sortController_:SetSelectedState("down")
	else
		arg_9_0.sortController_:SetSelectedState("up")
	end

	if #arg_9_1.suit > 0 or #arg_9_1.skill > 0 then
		arg_9_0.colorController_:SetSelectedState("orange")
	else
		arg_9_0.colorController_:SetSelectedState("normal")
	end
end

return var_0_0
