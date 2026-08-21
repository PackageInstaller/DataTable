local var_0_0 = import("game.views.chip.scheme.ChipSchemeItem")
local var_0_1 = class("BattleChipSchemeItem", var_0_0)

function var_0_1.OnEnabledBtn(arg_1_0)
	arg_1_0.dataTemplate.useChipIdList = arg_1_0.schemeData_.chipList

	arg_1_0.dataTemplate.sectionProxy_:SetMimirChipList(arg_1_0.schemeData_.chipList)
	manager.notify:Invoke(ENABLED_SCHEME)
end

return var_0_1
