local var_0_0 = import("game.views.IllustratedHandleBook.IlluEnemyFiles.IlluEnemyFileDetailItem")
local var_0_1 = class("BossInfoItemView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()
end

function var_0_1.RefreshUI(arg_2_0, arg_2_1)
	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.titleText_.text = GetI18NText(arg_2_1.name)
	arg_2_0.descText_.text = GetI18NText(arg_2_1.info)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.transform_)
end

return var_0_1
