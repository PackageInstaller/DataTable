local var_0_0 = class("SummerRaceEquipInfoPopView", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 == nil or arg_1_0.equipId == nil then
		error("SummerRaceEquipInfoPopView requires params.equipId")
	end

	return arg_1_0.equipId
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_OutGameUI/pop/Activity_SummerRace_EquipInfoPopUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BindViewRuntime()
	arg_4_0:AddUIListener()
end

function var_0_0.BindViewRuntime(arg_5_0)
	arg_5_0.typeController_ = arg_5_0.controllerEx_:GetController("type")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RefreshView()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.RefreshView(arg_11_0)
	local var_11_0 = var_0_1(arg_11_0.params_)
	local var_11_1 = SummerRaceData:GetEquipInfoModel(var_11_0)

	arg_11_0.equipNameText_.text = tostring(var_11_1.equipName or "")
	arg_11_0.typeText_.text = tostring(var_11_1.typeText or "")
	arg_11_0.costText_.text = tostring(var_11_1.cost or "")
	arg_11_0.energyText_.text = tostring(var_11_1.energyCost or "")
	arg_11_0.descText_.text = tostring(var_11_1.desc or "")
	arg_11_0.valueText_.text = tostring(var_11_1.valueText or "")

	arg_11_0.typeController_:SetSelectedState(var_11_1.typeText or "weapon")
end

return var_0_0
