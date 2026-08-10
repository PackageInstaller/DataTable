local var_0_0 = class("ChipManagerUnlockEquipBreakThroughView", import("..ChipManagerUnlockView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	SetActive(arg_1_0.goScheme_, false)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.useBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)
	arg_2_0:AddBtnListener(arg_2_0.unloadBtn_, nil, function()
		ShowTips("CANNOT_CHANGE")
	end)

	for iter_2_0 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		arg_2_0:AddBtnListener(arg_2_0[string.format("chipBtn%s_", iter_2_0)], nil, function()
			arg_2_0:Go("/chipEquipBreakThroughInfo", {
				chipManagerID = arg_2_0.chipManagerID_,
				selectChipIndex = iter_2_0
			})
		end)
	end
end

function var_0_0.RefreshBtn(arg_6_0)
	SetActive(arg_6_0.unloadBtnGo_, false)
	SetActive(arg_6_0.useBtnGo_, false)
end

function var_0_0.GetChipData(arg_7_0)
	return EquipBreakThroughMaterialData:GetChipList()
end

function var_0_0.GetEnabledManagerID(arg_8_0)
	return EquipBreakThroughMaterialData:GetChipManagerID()
end

function var_0_0.BindRedPoint(arg_9_0)
	return
end

function var_0_0.UnbindRedPoint(arg_10_0)
	return
end

return var_0_0
