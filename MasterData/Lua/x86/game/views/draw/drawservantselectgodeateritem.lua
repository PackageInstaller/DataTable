local DrawServantSelectGodEaterItem = class("DrawServantSelectGodEaterItem", (import("game.views.draw.DrawServantSelectItem")))

function DrawServantSelectGodEaterItem:RefreshUI(arg_1_1, arg_1_2, arg_1_3)
	self.id_ = arg_1_2
	self.servantID_ = arg_1_3
	self.nameText_.text = ""
	self.suffixText_.text = ItemTools.getItemName(arg_1_3)
	self.campImg_.sprite = HeroTools.GetRaceIcon(WeaponServantCfg[self.servantID_].race)
	self.groupbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/ServantUpSelect/" .. self.id_)

	local var_1_0 = 0

	if WeaponServantCfg[self.servantID_].effect[1] > 0 then
		var_1_0 = WeaponEffectCfg[WeaponServantCfg[self.servantID_].effect[1]].spec_char[1]
	end

	if var_1_0 ~= nil and var_1_0 > 0 then
		SetActive(self.recommendObj_, true)

		self.heroImg_.sprite = HeroTools.GetSmallHeadSprite(var_1_0)
	else
		SetActive(self.recommendObj_, false)
	end
end

return DrawServantSelectGodEaterItem
