local var_0_0 = class("DynamicEggCellView", DecorateClass(import(".DynamicCellView"), (import(".EggCellView"))))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0)
	var_0.InitEggCellTransform(arg_1_0)

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityEnemy
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	setActive(arg_3_0.go, arg_3_1)

	return
end

function var_0_0.LoadIcon(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.lastPrefab == arg_4_1 then
		existCall(arg_4_3)

		return
	end

	arg_4_0.lastPrefab = arg_4_1

	var_0.StartEggCellView(arg_4_0, arg_4_2, arg_4_3)

	return
end

function var_0_0.UpdateChampionCell(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0.UpdateEggCell(arg_5_0, arg_5_1, arg_5_2, arg_5_2:getConfigTable(), arg_5_3)
	arg_5_0:RefreshLinePosition(arg_5_1, arg_5_2)

	return
end

return var_0_0
