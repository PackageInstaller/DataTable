local var_0_0 = class("IlluIllustrationDetailPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluIllustrationSettingPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.img_.immediate = true
	arg_4_0.typeCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "type")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.addBtn_, nil, function()
		if #IllustratedData:GetAllLoadingSet() >= GameSetting.loading_pic_max.value[1] then
			ShowTips("SET_FAILED")

			return
		end

		IllustratedAction.ChangeLoadingSet(true, arg_5_0.ID_)
		ShowTips("SET_CONFIRMED")
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.removeBtn, nil, function()
		IllustratedAction.ChangeLoadingSet(false, arg_5_0.ID_)
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.ID_ = arg_10_0.params_.ID
	arg_10_0.type_ = arg_10_0.params_.type_
	arg_10_0.cfg_ = CollectPictureCfg[arg_10_0.ID_]

	arg_10_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_11_0)
	if arg_11_0.type_ == 5 then
		arg_11_0.img_.spriteSync = "TextureConfig/Loading/" .. arg_11_0.cfg_.picture
	else
		arg_11_0.img_.spriteSync = "TextureConfig/Background/" .. arg_11_0.cfg_.picture
	end

	arg_11_0.name_.text = GetI18NText(arg_11_0.cfg_.name)
	arg_11_0.desc_.text = GetI18NText(arg_11_0.cfg_.desc)

	if IllustratedData:IsInLoadingSet(arg_11_0.ID_) then
		arg_11_0.typeCon_:SetSelectedState("remove")

		arg_11_0.title_.text = string.format(GetTips("REMOVE_CONFIRMED"), GetI18NText(arg_11_0.cfg_.name), #IllustratedData:GetAllLoadingSet() .. "/" .. GameSetting.loading_pic_max.value[1])
	else
		arg_11_0.typeCon_:SetSelectedState("add")

		arg_11_0.title_.text = string.format(GetTips("SET_CONFIRMED_2"), GetI18NText(arg_11_0.cfg_.name), #IllustratedData:GetAllLoadingSet() .. "/" .. GameSetting.loading_pic_max.value[1])
	end
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
