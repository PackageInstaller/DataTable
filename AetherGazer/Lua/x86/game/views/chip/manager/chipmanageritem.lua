local var_0_0 = class("ChipManagerItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.adminCatImg_.immediate = true

	arg_1_0:AddListeners()

	arg_1_0.handler_ = handler(arg_1_0, arg_1_0.RefreshEnabledUI)

	manager.notify:RegistListener(ENABLED_CHIP_MANAGER, arg_1_0.handler_)

	arg_1_0.stateControl = arg_1_0.mimirControllerexcollection_:GetController("state")
	arg_1_0.selectControl = arg_1_0.mimirControllerexcollection_:GetController("select")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.selectBtn_, nil, function()
		arg_2_0:Go("/chipManager", {
			chipManagerID = arg_2_0.chipManagerID_
		})
	end)
end

function var_0_0.SetChipManagerID(arg_4_0, arg_4_1)
	arg_4_0.chipManagerID_ = arg_4_1
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	arg_5_0.gameObject_.name = arg_5_0.chipManagerID_
	arg_5_0.adminCatImg_.spriteSync = ChipTools.GetChipManagerIconPath(arg_5_0.chipManagerID_)

	local var_5_0 = arg_5_0:GetUnlockChipManagerList()
	local var_5_1 = table.keyof(var_5_0, arg_5_0.chipManagerID_) == nil

	if arg_5_1 then
		arg_5_0.selectControl:SetSelectedState("selected")
	else
		arg_5_0.selectControl:SetSelectedState("unselected")
	end

	if var_5_1 then
		arg_5_0.stateControl:SetSelectedState("locked")
	elseif arg_5_0.chipManagerDataTemplate_:GetISUseChipmanager(arg_5_0.chipManagerID_) then
		arg_5_0.stateControl:SetSelectedState("equiped")
	else
		arg_5_0.stateControl:SetSelectedState("unequiped")
	end

	if arg_5_0.chipManagerDataTemplate_ and not arg_5_0.chipManagerDataTemplate_.isNoRed then
		arg_5_0:BindRedPoint()
	end
end

function var_0_0.SetTemplateData(arg_6_0, arg_6_1)
	arg_6_0.chipManagerDataTemplate_ = arg_6_1
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_7_0)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, arg_7_0.handler_)

	arg_7_0.handler_ = nil
end

function var_0_0.GetUnlockChipManagerList(arg_8_0)
	return arg_8_0.chipManagerDataTemplate_.unlockChipManagerIDList_
end

function var_0_0.GetEnabledChipManagerID(arg_9_0)
	return ChipData:GetEnabledChipManagerID()
end

function var_0_0.BindRedPoint(arg_10_0)
	manager.redPoint:bindUIandKey(arg_10_0.notice_, string.format("%s_%s", RedPointConst.CHIP_MANAGER, arg_10_0.chipManagerID_), {
		x = 0,
		y = 0
	})
end

function var_0_0.UnbindRedPoint(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.notice_)
end

return var_0_0
