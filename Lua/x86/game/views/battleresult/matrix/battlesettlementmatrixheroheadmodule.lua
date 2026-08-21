local var_0_0 = import("game.views.battleResult.newBattleSettlement.module.BattleSettlementHeroHeadModule")
local var_0_1 = class("BattleSettlementMatrixHeroHeadModule", var_0_0)

function var_0_1.SetHeroCfgData(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = HeroCfg[arg_1_1]

	arg_1_0.heroCfg_ = var_1_0
	arg_1_0.campLogo_.sprite = HeroTools.GetHeroRaceIcon(arg_1_1)

	if arg_1_3 == 0 then
		arg_1_0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(var_1_0.rare or 0))
	else
		arg_1_0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(arg_1_3))
	end

	arg_1_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_1_1)

	if arg_1_2 then
		local var_1_1 = SkinCfg[arg_1_2]

		arg_1_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_1_1.picture_id)

		arg_1_0.headIcon_:SetNativeSize()
	end
end

function var_0_1.ShowHp(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = math.floor(arg_2_1 * 100 / arg_2_2)

	arg_2_0.hpText_.text = var_2_0 .. "%"
	arg_2_0.hpSlider_.fillAmount = arg_2_1 / arg_2_2
end

return var_0_1
