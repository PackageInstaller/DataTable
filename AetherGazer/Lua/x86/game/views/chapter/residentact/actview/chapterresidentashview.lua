ChapterResidentActBaseView = import("game.views.chapter.residentAct.ChapterResidentActBaseView")

local var_0_0 = class("ChapterResidentAshView", ChapterResidentActBaseView)

function var_0_0.RefreshUI(arg_1_0)
	var_0_0.super.RefreshUI(arg_1_0)

	local var_1_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)
	local var_1_1 = GameSetting.skuld_trust_max.value[1]
	local var_1_2 = "%d/%d"

	arg_1_0.progressValueTxt_.text = string.format(var_1_2, var_1_0, var_1_1)
	arg_1_0.progressImg_.fillAmount = var_1_0 / var_1_1
end

return var_0_0
