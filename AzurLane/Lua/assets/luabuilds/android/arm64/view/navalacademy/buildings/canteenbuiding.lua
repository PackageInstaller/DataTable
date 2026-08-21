local var_0_0 = class("CanteenBuiding", import(".NavalAcademyUpgradableBuilding"))

function var_0_0.GetGameObjectName(arg_1_0)
	return "canteen"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("school_title_shitang")
end

function var_0_0.OnClick(arg_3_0)
	arg_3_0:emit(NavalAcademyMediator.ON_OPEN_OILRESFIELD)

	return
end

function var_0_0.GetResField(arg_4_0)
	return arg_4_0.parent.oilResField
end

return var_0_0
