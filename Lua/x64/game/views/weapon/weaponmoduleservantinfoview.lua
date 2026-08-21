local var_0_0 = class("WeaponModuleServantInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModuleKeyPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroID_ = arg_7_0.params_.heroID

	local var_7_0 = HeroTools.GetHeroSpecServant(arg_7_0.heroID_)

	arg_7_0.nameText1_.text = ItemTools.getItemName(var_7_0)
	arg_7_0.nameText2_.text = ItemTools.getItemName(var_7_0)

	local var_7_1
	local var_7_2
	local var_7_3 = WeaponServantCfg[var_7_0].effect[1]
	local var_7_4 = GetCfgDescription(WeaponEffectCfg[var_7_3].description[1], 1, nil, nil, true)
	local var_7_5 = GetCfgDescription(WeaponEffectCfg[var_7_3].strengthen_description[2], 1, nil, nil, true)

	arg_7_0.frontDesText_.text = var_7_4
	arg_7_0.nextDesText_.text = var_7_5

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.frontcontentTrans_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.nextcontentTrans_)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
