local var_0_0 = class("EquipArchiveView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluEquipDetailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.imageImg_.immediate = true
	arg_4_0.controllers_ = {}

	for iter_4_0 = 1, 6 do
		arg_4_0.controllers_[iter_4_0] = arg_4_0:GetController(arg_4_0["item" .. iter_4_0 .. "Go_"], "conName")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.gainBtn_, nil, function()
		ShowPopItemSource(0, 0, arg_5_0.id_)
	end)
end

function var_0_0.GetController(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetComponent("ControllerExCollection")

	if var_7_0 then
		return var_7_0:GetController(arg_7_2)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:ShowDefaultBar()

	arg_8_0.id_ = arg_8_0.params_.equipID

	local var_8_0 = EquipSuitCfg[arg_8_0.id_]
	local var_8_1 = IllustratedData:GetEquipInfo()[arg_8_0.id_]

	arg_8_0.nameText_.text = GetI18NText(var_8_0.name)
	arg_8_0.descText_.text = GetI18NText(EquipTools.GetEffectDesc(var_8_0.suit_effect[1]))
	arg_8_0.imageImg_.spriteSync = "TextureConfig/Equip/icon_l/" .. EquipSuitCfg[arg_8_0.id_].icon
	arg_8_0.backgroundText_.text = GetI18NText(var_8_0.desc)

	if var_8_1 then
		for iter_8_0 = 1, 6 do
			if var_8_1.pos_list[iter_8_0] == 1 then
				arg_8_0.controllers_[iter_8_0]:SetSelectedState("0")
			else
				arg_8_0.controllers_[iter_8_0]:SetSelectedState("1")
			end
		end
	else
		for iter_8_1 = 1, 6 do
			arg_8_0.controllers_[iter_8_1]:SetSelectedState("1")
		end
	end
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
