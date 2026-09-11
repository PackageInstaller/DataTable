local CultivateHeroSwitchItem_2_1 = class("CultivateHeroSwitchItem_2_1", (import("game.views.cultivateHero.CultivateHeroSwitchItem")))

function CultivateHeroSwitchItem_2_1:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "Item")
end

function CultivateHeroSwitchItem_2_1:RefreshImage()
	self.icon_.sprite = getSpriteViaConfig("HeroIcon", CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[self.groupID_][1]].hero)
end

function CultivateHeroSwitchItem_2_1:RefreshSelect(arg_3_1)
	self.statusController_:SetSelectedIndex(self.groupID_ == arg_3_1 and 1 or 0)
end

return CultivateHeroSwitchItem_2_1
