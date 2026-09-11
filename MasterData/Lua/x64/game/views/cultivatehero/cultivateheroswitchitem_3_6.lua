local CultivateHeroSwitchItem_3_6 = class("CultivateHeroSwitchItem_3_6", (import("game.views.cultivateHero.CultivateHeroSwitchItem_2_1")))

function CultivateHeroSwitchItem_3_6:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.controllerEx_:GetController("state")
end

function CultivateHeroSwitchItem_3_6:RefreshImage()
	self.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[self.groupID_][1]].hero)
end

return CultivateHeroSwitchItem_3_6
