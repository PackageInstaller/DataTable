pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.ViewUtils = var_0_10001("ViewUtils")

function var_1.SetLayer(arg_1_0, arg_1_1)
	IsNil = var_1_10002
	go = var_1_10004

	if var_1_10002(var_1_10004(arg_1_0)) then
		return
	end

	go = var_2
	var_2(arg_1_0).layer = arg_1_1

	local var_1_0 = arg_1_0.childCount

	for iter_1_0 = 0, var_1_0 - 1 do
		var_0.SetLayer(arg_1_0:GetChild(iter_1_0), arg_1_1)
	end

	return
end

function var_1.SetSortingOrder(arg_2_0, arg_2_1)
	tf = var_1_10002

	local var_2_0 = var_1_10002(arg_2_0)
	local var_2_1 = arg_2_0.GetComponents

	typeof = var_1_10005
	Renderer = var_1_10007

	local var_2_2 = var_2_1(var_2_0, var_1_10005(var_1_10007))
	local var_2_3 = var_2.ToTable(var_2_2)

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(var_2_3) do
		iter_2_1.sortingOrder = arg_2_1
	end

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.GetComponent

	typeof = iter_2_0
	Canvas = var_1_10008

	if var_2_5(var_2_4, iter_2_0(var_1_10008)) then
		var_3.sortingOrder = arg_2_1
	end

	for iter_2_2 = 0, arg_2_0.childCount - 1 do
		var_0.SetSortingOrder(arg_2_0:GetChild(iter_2_2), arg_2_1)
	end

	return
end

function var_1.AddSortingOrder(arg_3_0, arg_3_1)
	tf = var_1_10002

	local var_3_0 = var_1_10002(arg_3_0)
	local var_3_1 = arg_3_0.GetComponents

	typeof = var_1_10005
	Renderer = var_1_10007

	local var_3_2 = var_3_1(var_3_0, var_1_10005(var_1_10007))
	local var_3_3 = var_2.ToTable(var_3_2)

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(var_3_3) do
		iter_3_1.sortingOrder = iter_3_1.sortingOrder + arg_3_1
	end

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.GetComponent

	typeof = iter_3_0
	Canvas = var_1_10008

	if var_3_5(var_3_4, iter_3_0(var_1_10008)) then
		var_3.sortingOrder = var_3.sortingOrder + arg_3_1
	end

	for iter_3_2 = 0, arg_3_0.childCount - 1 do
		var_0.AddSortingOrder(arg_3_0:GetChild(iter_3_2), arg_3_1)
	end

	return
end

return
