local BattleSettlementMatrixHeroHeadModule = class("BattleSettlementMatrixHeroHeadModule", (import("game.views.battleResult.newBattleSettlement.module.BattleSettlementHeroHeadModule")))

function BattleSettlementMatrixHeroHeadModule:SetHeroCfgData(arg_1_1, arg_1_2, arg_1_3)
	self.heroCfg_ = HeroCfg[arg_1_1]
	self.campLogo_.sprite = HeroTools.GetHeroRaceIcon(arg_1_1)
	self.rareImg_.sprite = arg_1_3 == 0 and HeroTools.GetRareSprite(math.floor(HeroCfg[arg_1_1].rare or 0)) or HeroTools.GetRareSprite(math.floor(arg_1_3))
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_1_1)

	if arg_1_2 then
		self.headIcon_.sprite = HeroTools.GetHeadSprite(SkinCfg[arg_1_2].picture_id)

		self.headIcon_:SetNativeSize()
	end
end

function BattleSettlementMatrixHeroHeadModule:ShowHp(arg_2_1, arg_2_2)
	self.hpText_.text = math.floor(arg_2_1 * 100 / arg_2_2) .. "%"
	self.hpSlider_.fillAmount = arg_2_1 / arg_2_2
end

return BattleSettlementMatrixHeroHeadModule
