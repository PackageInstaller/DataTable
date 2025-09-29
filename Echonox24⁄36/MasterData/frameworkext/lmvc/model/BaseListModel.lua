module("frameworkext.lmvc.model.BaseListModel", package.seeall)

local var_0_0 = class("BaseListModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0._moList = {}
	arg_1_0._moDict = {}
	arg_1_0._idCounter = 0
	arg_1_0._listDataProvider = DataProvider.New()
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onReset(arg_3_0)
	arg_3_0:clear()
end

function var_0_0.setDataBinder(arg_4_0, arg_4_1)
	arg_4_0._binder = arg_4_1
end

function var_0_0.getListDataProvider(arg_5_0)
	return arg_5_0._listDataProvider
end

function var_0_0.getMoDict(arg_6_0)
	return arg_6_0._moDict
end

function var_0_0.getMoById(arg_7_0, arg_7_1)
	return arg_7_0._moDict[arg_7_1]
end

function var_0_0.getMoList(arg_8_0)
	return arg_8_0._moList
end

function var_0_0.getMoCount(arg_9_0)
	return #arg_9_0._moList
end

function var_0_0.getMoIndex(arg_10_0, arg_10_1)
	return table.indexof(arg_10_0._moList, arg_10_1)
end

function var_0_0.getMoByIndex(arg_11_0, arg_11_1)
	local var_11_0
	local var_11_1 = #arg_11_0._moList

	if arg_11_1 >= 1 and arg_11_1 <= var_11_1 then
		var_11_0 = arg_11_0._moList[arg_11_1]
	end

	return var_11_0
end

function var_0_0.sortMoList(arg_12_0, arg_12_1)
	table.sort(arg_12_0._moList, arg_12_1)
	arg_12_0._listDataProvider:onUpdateData()
end

function var_0_0.isEmpty(arg_13_0)
	return #arg_13_0._moList == 0
end

function var_0_0.updateData(arg_14_0)
	arg_14_0._listDataProvider:onUpdateData()
end

function var_0_0.selectDataByMoList(arg_15_0, arg_15_1)
	arg_15_0._listDataProvider:onSelectDataByItems(arg_15_1)
end

function var_0_0.selectDataByIndexlist(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._listDataProvider:onSelectDataByIndexlist(arg_16_1, arg_16_2)
end

function var_0_0.selectDataByIndex(arg_17_0, ...)
	arg_17_0._listDataProvider:onSelectDataByIndex(...)
end

function var_0_0.addMoList(arg_18_0, arg_18_1)
	local var_18_0 = #arg_18_1
	local var_18_1

	for iter_18_0 = 1, var_18_0 do
		local var_18_2 = arg_18_1[iter_18_0]

		table.insert(arg_18_0._moList, var_18_2)

		if not var_18_2.id then
			arg_18_0._idCounter = arg_18_0._idCounter + 1
			var_18_2.id = arg_18_0._idCounter
		end

		arg_18_0._moDict[var_18_2.id] = var_18_2
	end

	arg_18_0._listDataProvider:onUpdateData()
end

function var_0_0.setMoList(arg_19_0, arg_19_1)
	arg_19_0._moList = {}
	arg_19_0._moDict = {}

	arg_19_0:addMoList(arg_19_1)
end

function var_0_0.addMoAt(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = #arg_20_0._moList

	if not arg_20_2 or arg_20_2 > var_20_0 + 1 then
		arg_20_2 = var_20_0 + 1
	elseif arg_20_2 < 1 then
		arg_20_2 = 1
	end

	table.insert(arg_20_0._moList, arg_20_2, arg_20_1)

	if not arg_20_1.id then
		arg_20_0._idCounter = arg_20_0._idCounter + 1
		arg_20_1.id = arg_20_0._idCounter
	end

	arg_20_0._moDict[arg_20_1.id] = arg_20_1

	arg_20_0._listDataProvider:onUpdateData()

	return arg_20_1
end

function var_0_0.addMo(arg_21_0, arg_21_1)
	return arg_21_0:addMoAt(arg_21_1)
end

function var_0_0.clear(arg_22_0)
	arg_22_0._moList = {}
	arg_22_0._moDict = {}
	arg_22_0._idCounter = 0

	arg_22_0._listDataProvider:onUpdateData()
end

function var_0_0.removeAt(arg_23_0, arg_23_1)
	if not arg_23_1 or arg_23_1 < 1 then
		return nil
	end

	if arg_23_1 > #arg_23_0._moList then
		return nil
	end

	local var_23_0 = table.remove(arg_23_0._moList, arg_23_1)

	if var_23_0 then
		arg_23_0._moDict[var_23_0.id] = nil
	end

	arg_23_0._listDataProvider:onUpdateData()

	return var_23_0
end

function var_0_0.removeMo(arg_24_0, arg_24_1)
	local var_24_0 = table.indexof(arg_24_0._moList, arg_24_1)

	if var_24_0 then
		return arg_24_0:removeAt(var_24_0)
	end

	return nil
end

function var_0_0.removeMoById(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._moDict[arg_25_1]

	if var_25_0 then
		arg_25_0:removeMo(var_25_0)
	end

	return var_25_0
end

return var_0_0
