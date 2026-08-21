local var_0_0 = class("BossRushDALFleetSelectView", import("..BossRushFleetSelectView"))

function var_0_0.getUIName(arg_1_0)
	return "BossRushFleetSelectUIDALCollab"
end

function var_0_0.InitUI(arg_2_0)
	var_0_0.super.InitUI(arg_2_0)
	setText(arg_2_0._tf:Find("Panel/Info/Start/text"), i18n("dal_chapter_goto"))

	return
end

return var_0_0
