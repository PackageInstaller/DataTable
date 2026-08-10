local var_0_0 = class("ChipManagerUnlockView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.handler_ = handler(arg_1_0, arg_1_0.RefreshBtn)

	manager.notify:RegistListener(ENABLED_CHIP_MANAGER, arg_1_0.handler_)

	arg_1_0.btnCon_ = arg_1_0.btnControllerexcollection_:GetController("btn")
end

function var_0_0.AddListeners(arg_2_0)
	for iter_2_0 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		arg_2_0:AddBtnListener(arg_2_0[string.format("chipBtn%s_", iter_2_0)], nil, function()
			arg_2_0:OnSelectChipBtn(iter_2_0)
		end)
	end
end

function var_0_0.SetDataTemplate(arg_4_0, arg_4_1)
	arg_4_0.chipDatatemplate_ = arg_4_1
end

function var_0_0.SetChipManagerID(arg_5_0, arg_5_1)
	arg_5_0.chipManagerID_ = arg_5_1

	local var_5_0 = ChipCfg[arg_5_1]
	local var_5_1 = arg_5_0:GetChipData()

	for iter_5_0 = 1, #var_5_1 do
		arg_5_0[string.format("chipIcon%s_", iter_5_0)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[var_5_1[iter_5_0]].picture_id)

		arg_5_0[string.format("use%s_", iter_5_0)]:GetController("useState"):SetSelectedState("use")
	end

	for iter_5_1 = #var_5_1 + 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		if arg_5_0[string.format("use%s_", iter_5_1)] then
			arg_5_0[string.format("use%s_", iter_5_1)]:GetController("useState"):SetSelectedState("nouse")
		end
	end
end

function var_0_0.RefreshBtn(arg_6_0)
	arg_6_0.btnCon_:SetSelectedState("unlock")
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_7_0)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, arg_7_0.handler_)

	arg_7_0.handler_ = nil
end

function var_0_0.GetChipData(arg_8_0)
	return arg_8_0.chipDatatemplate_:GetEquipChipList()
end

function var_0_0.GetEnabledManagerID(arg_9_0)
	return arg_9_0.chipDatatemplate_.useChipmanagerId
end

function var_0_0.BindRedPoint(arg_10_0)
	manager.redPoint:bindUIandKey(arg_10_0.chipBtnTransform_, RedPointConst.CHIP_CHIP)
end

function var_0_0.UnbindRedPoint(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.chipBtnTransform_)
end

function var_0_0.OnSelectChipBtn(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.chipDatatemplate_:GetChipInfoViewPath() or "/chipInfo"

	arg_12_0:Go(var_12_0, {
		chipManagerID = arg_12_0.chipManagerID_,
		selectChipIndex = arg_12_1,
		chipDataTemplate = arg_12_0.chipDatatemplate_
	})
end

function var_0_0.SetActive(arg_13_0, arg_13_1)
	if arg_13_0.gameObject_ then
		SetActive(arg_13_0.gameObject_, arg_13_1)
	end
end

return var_0_0
