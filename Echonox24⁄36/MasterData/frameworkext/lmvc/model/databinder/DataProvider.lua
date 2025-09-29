module("frameworkext.lmvc.model.databinder.DataProvider", package.seeall)

local var_0_0 = class("DataProvider")

function var_0_0.ctor(arg_1_0)
	arg_1_0._dataBinder = {}
end

function var_0_0.onUpdateData(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0._dataBinder) do
		iter_2_0:onUpdateData()
	end
end

function var_0_0.onSelectDataByItems(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._dataBinder) do
		iter_3_0:setSelectItems(arg_3_1)
	end
end

function var_0_0.onSelectDataByIndexlist(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._dataBinder) do
		iter_4_0:selectCells(arg_4_1, arg_4_2)
	end
end

function var_0_0.onSelectDataByIndex(arg_5_0, ...)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._dataBinder) do
		iter_5_0:selectCell(...)
	end
end

function var_0_0.addDataBinder(arg_6_0, arg_6_1)
	arg_6_0._dataBinder[arg_6_1] = true
end

function var_0_0.removeDataBinder(arg_7_0, arg_7_1)
	arg_7_0._dataBinder[arg_7_1] = nil
end

return var_0_0
