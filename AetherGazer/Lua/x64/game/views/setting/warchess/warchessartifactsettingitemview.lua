local var_0_0 = class("WarChessArtifactSettingItemView", MatrixArtifactSettingItemView)

function var_0_0.SetData(arg_1_0, arg_1_1)
	local var_1_0 = WarchessItemCfg[arg_1_1]
	local var_1_1 = arg_1_1
	local var_1_2 = WarchessItemCfg[var_1_1].params[1][1]
	local var_1_3 = WarchessItemCfg[var_1_1].params[1][2]
	local var_1_4 = AffixTypeCfg[var_1_2].description[1]
	local var_1_5 = GetCfgDescription(var_1_4, var_1_3)

	arg_1_0.name_.text = GetI18NText(var_1_0.name)
	arg_1_0.desc_.text = GetI18NText(var_1_5)
	arg_1_0.icon_.sprite = ChessTools.GetWarChessItemSprite(arg_1_1)
end

return var_0_0
