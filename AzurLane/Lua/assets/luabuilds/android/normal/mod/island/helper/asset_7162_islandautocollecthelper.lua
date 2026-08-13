class = var_0_10000

local var_0_0 = var_0_10000("IslandAutoCollectHelper")

var_0_0.SelectType = {
	Gather = 3,
	HandCollection = 2,
	Both = 4,
	None = 1
}

local var_0_1 = {}

i18n = var_0_10002
var_0_1[1] = var_0_10002("island_chara_gather_power")
i18n = var_2
var_0_1[2] = var_2("island_chara_gather_money")
var_0_0.CostTipList = var_0_1

function var_0_0.GetAttributeReducePercent(arg_1_0)
	IslandProductTimeHelper = var_1_10001

	local var_1_0 = var_1_10001.GetAttributeGradeId
	local var_1_1 = arg_1_0

	IslandShipAttr = var_1_10003

	local var_1_2 = var_1_0(var_1_1, var_1_10003.COLLECT_KEY)

	pg = var_1_1

	return var_1_1.island_chara_att[var_1_2].gather_effect
end

return var_0_0
