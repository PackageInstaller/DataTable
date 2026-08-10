local var_0_0 = import("game.views.cultivateHero.CultivateHeroSwitchItem_2_1")
local var_0_1 = class("CultivateHeroSwitchItem_3_6", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.statusController_ = arg_1_0.controllerEx_:GetController("state")
end

function var_0_1.RefreshImage(arg_2_0)
	local var_2_0 = CultivateHeroTaskCfg.get_id_list_by_group_id[arg_2_0.groupID_]
	local var_2_1 = CultivateHeroTaskCfg[var_2_0[1]].hero

	arg_2_0.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", var_2_1)
end

return var_0_1
