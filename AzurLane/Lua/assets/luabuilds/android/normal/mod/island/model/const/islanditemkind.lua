class = var_0_10000

local var_0_0 = var_0_10000("IslandItemKind")

function var_0_0.Type2TagName(arg_1_0)
	if not var_0_0.TagNames then
		local var_1_0 = var_0_0
		local var_1_1 = {}

		i18n = var_1_10003
		var_1_1[1] = var_1_10003("island_item_type_res")
		i18n = var_3
		var_1_1[2] = var_3("island_item_type_consume")
		i18n = var_3
		var_1_1[3] = var_3("island_item_type_spe")
		var_1_0.TagNames = var_1_1
	end

	return var_0_0.TagNames[arg_1_0]
end

return var_0_0
