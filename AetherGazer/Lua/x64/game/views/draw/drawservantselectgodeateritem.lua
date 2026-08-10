local var_0_0 = import("game.views.draw.DrawServantSelectItem")
local var_0_1 = class("DrawServantSelectGodEaterItem", var_0_0)

function var_0_1.RefreshUI(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id_ = arg_1_2
	arg_1_0.servantID_ = arg_1_3
	arg_1_0.nameText_.text = ""
	arg_1_0.suffixText_.text = ItemTools.getItemName(arg_1_3)
	arg_1_0.campImg_.sprite = HeroTools.GetRaceIcon(WeaponServantCfg[arg_1_0.servantID_].race)
	arg_1_0.groupbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/ServantUpSelect/" .. arg_1_0.id_)

	local var_1_0 = WeaponServantCfg[arg_1_0.servantID_].effect[1]
	local var_1_1 = 0

	if var_1_0 > 0 then
		var_1_1 = WeaponEffectCfg[var_1_0].spec_char[1]
	end

	if var_1_1 ~= nil and var_1_1 > 0 then
		SetActive(arg_1_0.recommendObj_, true)

		arg_1_0.heroImg_.sprite = HeroTools.GetSmallHeadSprite(var_1_1)
	else
		SetActive(arg_1_0.recommendObj_, false)
	end
end

return var_0_1
