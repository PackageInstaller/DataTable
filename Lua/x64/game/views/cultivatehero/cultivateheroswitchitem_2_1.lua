local var_0_0 = import("game.views.cultivateHero.CultivateHeroSwitchItem")
local var_0_1 = class("CultivateHeroSwitchItem_2_1", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.transform_, "Item")
end

function var_0_1.RefreshImage(arg_2_0)
	local var_2_0 = CultivateHeroTaskCfg.get_id_list_by_group_id[arg_2_0.groupID_]
	local var_2_1 = CultivateHeroTaskCfg[var_2_0[1]].hero

	arg_2_0.icon_.sprite = getSpriteViaConfig("HeroIcon", var_2_1)
end

function var_0_1.RefreshSelect(arg_3_0, arg_3_1)
	arg_3_0.statusController_:SetSelectedIndex(arg_3_0.groupID_ == arg_3_1 and 1 or 0)
end

return var_0_1
