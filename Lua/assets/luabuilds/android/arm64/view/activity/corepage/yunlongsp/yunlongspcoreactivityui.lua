local var_0_0 = class("YunLongSPCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function var_0_0.getUIName(arg_1_0)
	return "YunLongSPCoreActivityUI"
end

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)
	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text"), i18n("SardiniaSPCoreActivityUI_title"))

	return
end

return var_0_0
