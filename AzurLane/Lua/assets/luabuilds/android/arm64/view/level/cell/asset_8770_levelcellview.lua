class = var_0_10000

local var_0_0 = var_0_10000("LevelCellView")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.go = nil
	arg_1_0.tf = nil
	arg_1_0.orderTable = {}

	return
end

function var_0_0.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0.go, arg_2_1)

	return
end

function var_0_0.GetOrder(arg_3_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityNone
end

function var_0_0.SetLoader(arg_4_0, arg_4_1)
	assert = var_1_10002

	var_1_10002(not arg_4_0.loader, "repeatly Set loader")

	arg_4_0.loader = arg_4_1

	return
end

function var_0_0.GetLoader(arg_5_0)
	local var_5_0

	if not arg_5_0.loader then
		AutoLoader = var_5_0
		var_5_0 = var_5_0.New()
	end

	arg_5_0.loader = var_5_0

	return arg_5_0.loader
end

function var_0_0.ClearLoader(arg_6_0)
	if arg_6_0.loader then
		local var_6_0 = arg_6_0.loader

		var_1.Clear(var_6_0)
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
	pg = var_1_10001

	local var_9_0 = var_1_10001.ViewUtils.SetLayer

	tf = var_1_10003

	local var_9_1 = var_1_10003(arg_9_0.go)

	Layer = var_1_10004

	var_9_0(var_9_1, var_1_10004.UI)

	GetOrAddComponent = var_9_0

	local var_9_2 = arg_9_0.go

	typeof = var_4
	Canvas = var_1_10006
	arg_9_0.canvas = var_9_0(var_9_2, var_4(var_1_10006))
	arg_9_0.canvas.overrideSorting = true

	return
end

function var_0_0.ResetCanvasOrder(arg_10_0)
	if not arg_10_0.canvas then
		return
	end

	local var_10_0 = arg_10_0.line.row

	ChapterConst = var_1_10002

	local var_10_1 = var_10_0 * var_1_10002.PriorityPerRow + arg_10_0:GetOrder()

	pg = var_2

	var_2.ViewUtils.SetSortingOrder(arg_10_0.tf, var_10_1)
	arg_10_0:OnCanvasUpDate()

	return
end

function var_0_0.OnCanvasUpDate(arg_11_0)
	return
end

function var_0_0.GetCurrentOrder(arg_12_0)
	local var_12_0 = arg_12_0.line.row

	ChapterConst = var_1_10002

	return var_12_0 * var_1_10002.PriorityPerRow + arg_12_0:GetOrder()
end

function var_0_0.AddCanvasOrder(arg_13_0, arg_13_1, arg_13_2)
	tf = var_1_10003

	local var_13_0 = var_1_10003(arg_13_1)
	local var_13_1 = arg_13_1.GetComponents

	typeof = var_1_10006
	Renderer = var_1_10008

	local var_13_2 = var_13_1(var_13_0, var_1_10006(var_1_10008))
	local var_13_3 = var_3.ToTable(var_13_2)

	ipairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(var_13_3) do
		if not arg_13_0.orderTable[iter_13_1] then
			var_1_10009 = 0
		end

		iter_13_1.sortingOrder = var_1_10009 + arg_13_2
	end

	local var_13_4 = arg_13_1
	local var_13_5 = arg_13_1.GetComponent

	typeof = iter_13_0
	Canvas = var_1_10009

	if var_13_5(var_13_4, iter_13_0(var_1_10009)) then
		local var_13_6

		if not arg_13_0.orderTable[var_4] then
			var_13_6 = 0
		end

		var_4.sortingOrder = var_13_6 + arg_13_2
	end

	for iter_13_2 = 0, arg_13_1.childCount - 1 do
		arg_13_0:AddCanvasOrder(arg_13_1:GetChild(iter_13_2), arg_13_2)
	end

	return
end

function var_0_0.RecordCanvasOrder(arg_14_0, arg_14_1)
	tf = var_1_10002

	local var_14_0 = var_1_10002(arg_14_1)
	local var_14_1 = arg_14_1.GetComponents

	typeof = var_1_10005
	Renderer = var_1_10007

	local var_14_2 = var_14_1(var_14_0, var_1_10005(var_1_10007))
	local var_14_3 = var_2.ToTable(var_14_2)

	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(var_14_3) do
		var_1_10008 = arg_14_0.orderTable
		var_1_10008[iter_14_1] = iter_14_1.sortingOrder
	end

	local var_14_4 = arg_14_1
	local var_14_5 = arg_14_1.GetComponent

	typeof = iter_14_0
	Canvas = var_1_10008

	if var_14_5(var_14_4, iter_14_0(var_1_10008)) then
		arg_14_0.orderTable[var_3] = var_3.sortingOrder
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

	local var_15_0 = arg_15_0.tf
	local var_15_1 = arg_15_1.theme

	var_15_0.anchoredPosition = var_4.GetLinePosition(var_15_1, arg_15_0.line.row, arg_15_0.line.column)

	return
end

function var_0_0.Clear(arg_16_0)
	pairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.orderTable) do
		IsNil = var_1_10006

		if not var_1_10006(iter_16_0) then
			iter_16_0.sortingOrder = iter_16_1
		end
	end

	table = var_1

	var_1.clear(arg_16_0.orderTable)
	arg_16_0:ClearLoader()

	return
end

return var_0_0
