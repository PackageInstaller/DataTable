local var_0_0 = class("CharChipPowerupView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Administrators/AdministratorsChipPowerupUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.lockController_ = arg_3_0.conEx_:GetController("infoShow")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnBack_, nil, function()
		arg_4_0:Back()

		if arg_4_0.level_ == #ChipTools.GetCharChipExtraIDList(arg_4_0.baseID_) then
			-- block empty
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.baseID_ = arg_6_0.params_.baseID
	arg_6_0.level_ = #ChipTools.GetCharChipExtraIDListUnlock(arg_6_0.baseID_)

	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ChipCfg[arg_8_0.baseID_]

	arg_8_0.iconImg_.sprite = ChipTools.GetCharChipIcon(arg_8_0.baseID_, true)

	if arg_8_0.level_ > 0 then
		arg_8_0.titleText_.text = GetTips("ADMIN_CHIP_PASS_UNLOCK")
		arg_8_0.skillText_.text = ChipCfg[ChipTools.GetCharChipExtraIDList(arg_8_0.baseID_)[arg_8_0.level_]].desc
	else
		arg_8_0.titleText_.text = GetTips("ADMIN_CHIP_ACT_UNLOCK")
		arg_8_0.skillText_.text = ChipCfg[arg_8_0.baseID_].desc
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
