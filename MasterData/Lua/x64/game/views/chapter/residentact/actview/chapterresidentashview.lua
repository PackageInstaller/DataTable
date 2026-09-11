ChapterResidentActBaseView = import("game.views.chapter.residentAct.ChapterResidentActBaseView")

local ChapterResidentAshView = class("ChapterResidentAshView", ChapterResidentActBaseView)

function ChapterResidentAshView:RefreshUI()
	ChapterResidentAshView.super.RefreshUI(self)

	local var_1_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)

	self.progressValueTxt_.text = string.format("%d/%d", var_1_0, GameSetting.skuld_trust_max.value[1])
	self.progressImg_.fillAmount = var_1_0 / GameSetting.skuld_trust_max.value[1]
end

return ChapterResidentAshView
