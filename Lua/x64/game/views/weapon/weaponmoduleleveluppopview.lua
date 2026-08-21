local var_0_0 = class("WeaponModuleLevelUpPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModuleUpgradePopUI"
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
		gameContext:Go("/weaponModuleView", {
			heroID = arg_5_0.heroID_
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroID_ = arg_7_0.params_.heroID

	local var_7_0 = WeaponModuleCfg[arg_7_0.heroID_]

	arg_7_0.nameText_.text = GetI18NText(var_7_0.name)
	arg_7_0.levelText_.text = HeroData:GetCurModuleLevel(arg_7_0.heroID_)
	arg_7_0.moduleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. arg_7_0.heroID_)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
