local var_0_0 = import("game.views.AffixSelect.AffixSelectBossInfoView")
local var_0_1 = class("AffixSelectBossInfoJapanRegionView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/Alone_AffixSelect/Alone_AffixSelect_BossInfoUI"
end

function var_0_1.UpdateView(arg_2_0)
	local var_2_0 = MonsterCfg[arg_2_0.bossIDList_[1]]

	arg_2_0.nameText_.text = GetMonsterName(arg_2_0.bossIDList_)
	arg_2_0.raceText_.text = GetTips("RACE_TYPE_" .. var_2_0.race)

	local var_2_1 = ""

	for iter_2_0, iter_2_1 in pairs(arg_2_0.bossIDList_) do
		var_2_1 = var_2_1 .. iter_2_1
	end

	arg_2_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_2_1)
	arg_2_0.riskText_.text = NumberTools.IntToRomam(var_2_0.type + 1)

	arg_2_0:UpdateData()
	arg_2_0:RefreshSkill()
end

return var_0_1
