module("frameworkext.lmvc.model.BaseTreeModel", package.seeall)

local var_0_0 = class("BaseTreeModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._moList = {}
	arg_1_0._treeDataProvider = DataProvider.New()
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

function var_0_0.getTreeDataProvider(arg_5_0)
	return arg_5_0._treeDataProvider
end

function var_0_0.addRoot(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = #arg_6_0._moList

	if not arg_6_3 or arg_6_3 > var_6_0 + 1 then
		arg_6_3 = var_6_0 + 1
	elseif arg_6_3 < 1 then
		arg_6_3 = 1
	end

	table.insert(arg_6_0._moList, arg_6_3, {
		mo = arg_6_1,
		style = arg_6_2,
		children = {}
	})
	arg_6_0:notifyUpdate()
end

function var_0_0.addSub(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0._moList[arg_7_2].children
	local var_7_1 = #var_7_0

	if not arg_7_3 or arg_7_3 > var_7_1 + 1 then
		arg_7_3 = var_7_1 + 1
	elseif arg_7_3 < 1 then
		arg_7_3 = 1
	end

	table.insert(var_7_0, arg_7_3, arg_7_1)
	arg_7_0:notifyUpdate()
end

function var_0_0.setSubList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._moList[arg_8_2].children = arg_8_1

	arg_8_0:notifyUpdate()
end

function var_0_0.removeRoot(arg_9_0, arg_9_1)
	if not arg_9_1 or arg_9_1 < 1 then
		return nil
	end

	if arg_9_1 > #arg_9_0._moList then
		return nil
	end

	local var_9_0 = table.remove(arg_9_0._moList, arg_9_1)

	arg_9_0:notifyUpdate()

	return var_9_0.mo
end

function var_0_0.removeSub(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 or arg_10_1 < 1 then
		return nil
	end

	if arg_10_1 > #arg_10_0._moList then
		return nil
	end

	local var_10_0 = table.remove(arg_10_0._moList[arg_10_1].children, arg_10_2)

	arg_10_0:notifyUpdate()

	return var_10_0
end

function var_0_0.getMoByIndex(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == 0 then
		return arg_11_0._moList[arg_11_1].mo
	else
		return arg_11_0._moList[arg_11_1].children[arg_11_2]
	end
end

function var_0_0.getIndexByMo(arg_12_0, arg_12_1)
	for iter_12_0 = 1, #arg_12_0._moList do
		if arg_12_0._moList[iter_12_0].mo == arg_12_1 then
			return iter_12_0, 0
		else
			local var_12_0 = arg_12_0._moList[iter_12_0].children

			for iter_12_1 = 1, #var_12_0 do
				if var_12_0[iter_12_1] == arg_12_1 then
					return iter_12_0, iter_12_1
				end
			end
		end
	end

	return nil
end

function var_0_0.getStyle(arg_13_0, arg_13_1)
	return arg_13_0._moList[arg_13_1].style
end

function var_0_0.clear(arg_14_0)
	arg_14_0._moList = {}

	arg_14_0:notifyUpdate()
end

function var_0_0.getRootCount(arg_15_0)
	return #arg_15_0._moList
end

function var_0_0.getNodeCount(arg_16_0, arg_16_1)
	return #arg_16_0._moList[arg_16_1].children
end

function var_0_0.notifyUpdate(arg_17_0)
	if not arg_17_0._pauseNotify then
		arg_17_0._treeDataProvider:onUpdateData()
	end
end

function var_0_0.beginBatch(arg_18_0)
	arg_18_0._pauseNotify = true
end

function var_0_0.endBatch(arg_19_0)
	arg_19_0._pauseNotify = false

	arg_19_0._treeDataProvider:onUpdateData()
end

return var_0_0
