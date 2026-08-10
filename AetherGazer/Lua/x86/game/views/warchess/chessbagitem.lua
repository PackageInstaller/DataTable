local var_0_0 = class("ChessBagItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2.id
	local var_4_1 = WarchessItemCfg[var_4_0].params[1][1]
	local var_4_2 = WarchessItemCfg[var_4_0].params[1][2]
	local var_4_3 = AffixTypeCfg[var_4_1].description[1]
	local var_4_4 = GetCfgDescription(var_4_3, var_4_2)

	arg_4_0.textinfoText_.text = var_4_4
	arg_4_0.textnameText_.text = WarchessItemCfg[var_4_0].name
	arg_4_0.iconitemImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", WarchessItemCfg[var_4_0].icon)

	local var_4_5 = WarchessItemCfg[var_4_0].item_rare

	arg_4_0.itemrareImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "board_warcheese_sq_" .. var_4_5)
	arg_4_0.rarebgImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "bg_bfi_top_" .. var_4_5)
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
