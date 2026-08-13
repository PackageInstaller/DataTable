import = var_0_10000

local var_0_0 = var_0_10000(".DynamicCellView")

import = var_0_10001

local var_0_1 = var_0_10001(".EggCellView")

class = var_2

local var_0_2 = "DynamicEggCellView"

DecorateClass = var_0_10005

local var_0_3 = var_2(var_0_2, var_0_10005(var_0_0, var_0_1))

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_1.Ctor(arg_1_0)
	var_0_1.InitEggCellTransform(arg_1_0)

	return
end

function var_0_3.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityEnemy
end

function var_0_3.SetActive(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.go, arg_3_1)

	return
end

function var_0_3.LoadIcon(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.lastPrefab == arg_4_1 then
		existCall = var_4

		var_4(arg_4_3)

		return
	end

	arg_4_0.lastPrefab = arg_4_1

	var_0_1.StartEggCellView(arg_4_0, arg_4_2, arg_4_3)

	return
end

function var_0_3.UpdateChampionCell(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_1.UpdateEggCell(arg_5_0, arg_5_1, arg_5_2, arg_5_2:getConfigTable(), arg_5_3)
	arg_5_0:RefreshLinePosition(arg_5_1, arg_5_2)

	return
end

return var_0_3
