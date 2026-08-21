local var_0_0 = class("LevelCellView")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.go = nil
	arg_1_0.tf = nil
	arg_1_0.orderTable = {}

	return
end

function var_0_0.SetActive(arg_2_0, arg_2_1)
	setActive(arg_2_0.go, arg_2_1)

	return
end

function var_0_0.GetOrder(arg_3_0)
	return ChapterConst.CellPriorityNone
end

function var_0_0.SetLoader(arg_4_0, arg_4_1)
	assert(not arg_4_0.loader, "repeatly Set loader")

	arg_4_0.loader = arg_4_1

	return
end

function var_0_0.GetLoader(arg_5_0)
	arg_5_0.loader = arg_5_0.loader or AutoLoader.New()

	return arg_5_0.loader
end

function var_0_0.ClearLoader(arg_6_0)
	if arg_6_0.loader then
		arg_6_0.loader:Clear()
	end

	return
end

function var_0_0.GetLine(arg_7_0)
	return arg_7_0.line
end

function var_0_0.SetLine(arg_8_0, arg_8_1)
	arg_8_0.line = {
		row = arg_8_1.row,
		column = arg_8_1.column
	}

	return
end

function var_0_0.OverrideCanvas(arg_9_0)
	pg.ViewUtils.SetLayer(tf(arg_9_0.go), Layer.UI)

	arg_9_0.canvas = GetOrAddComponent(arg_9_0.go, typeof(Canvas))
	arg_9_0.canvas.overrideSorting = true

	return
end

function var_0_0.ResetCanvasOrder(arg_10_0)
	if not arg_10_0.canvas then
		return
	end

	pg.ViewUtils.SetSortingOrder(arg_10_0.tf, arg_10_0.line.row * ChapterConst.PriorityPerRow + arg_10_0:GetOrder())
	arg_10_0:OnCanvasUpDate()

	return
end

function var_0_0.OnCanvasUpDate(arg_11_0)
	return
end

function var_0_0.GetCurrentOrder(arg_12_0)
	return arg_12_0.line.row * ChapterConst.PriorityPerRow + arg_12_0:GetOrder()
end

function var_0_0.AddCanvasOrder(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1 = tf(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs((arg_13_1:GetComponents(typeof(Renderer)):ToTable())) do
		local var_13_0 = arg_13_0.orderTable[iter_13_1] or 0

		iter_13_1.sortingOrder = var_13_0 + arg_13_2
	end

	local var_13_1 = arg_13_1:GetComponent(typeof(Canvas))

	if var_13_1 then
		local var_13_2 = arg_13_0.orderTable[var_13_1] or 0

		var_13_1.sortingOrder = var_13_2 + arg_13_2
	end

	for iter_13_2 = 0, arg_13_1.childCount - 1 do
		arg_13_0:AddCanvasOrder(arg_13_1:GetChild(iter_13_2), arg_13_2)
	end

	return
end

function var_0_0.RecordCanvasOrder(arg_14_0, arg_14_1)
	arg_14_1 = tf(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs((arg_14_1:GetComponents(typeof(Renderer)):ToTable())) do
		arg_14_0.orderTable[iter_14_1] = iter_14_1.sortingOrder
	end

	local var_14_0 = arg_14_1:GetComponent(typeof(Canvas))

	if var_14_0 then
		arg_14_0.orderTable[var_14_0] = var_14_0.sortingOrder
	end

	for iter_14_2 = 0, arg_14_1.childCount - 1 do
		arg_14_0:RecordCanvasOrder(arg_14_1:GetChild(iter_14_2))
	end

	return
end

function var_0_0.RefreshLinePosition(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 then
		arg_15_0:SetLine(arg_15_2)
		arg_15_0:ResetCanvasOrder()
	end

	arg_15_0.tf.anchoredPosition = arg_15_1.theme:GetLinePosition(arg_15_0.line.row, arg_15_0.line.column)

	return
end

function var_0_0.Clear(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.orderTable) do
		if not IsNil(iter_16_0) then
			iter_16_0.sortingOrder = iter_16_1
		end
	end

	table.clear(arg_16_0.orderTable)
	arg_16_0:ClearLoader()

	return
end

return var_0_0
