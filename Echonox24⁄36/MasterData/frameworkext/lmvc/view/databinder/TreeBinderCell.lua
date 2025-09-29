module("frameworkext.lmvc.view.databinder.TreeBinderCell", package.seeall)

local var_0_0 = class("TreeBinderCell")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._compContainer = arg_1_1
	arg_1_0._go = arg_1_0._compContainer.gameObject
	arg_1_0.rootIndex = 0
	arg_1_0.subIndex = 0
	arg_1_0.treeView = nil
end

function var_0_0.setIndex(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.rootIndex = arg_2_1
	arg_2_0.subIndex = arg_2_2
end

function var_0_0.setTreeView(arg_3_0, arg_3_1)
	arg_3_0._treeView = arg_3_1
end

function var_0_0.showSelect(arg_4_0, arg_4_1)
	arg_4_0.isSelected = arg_4_1

	arg_4_0:onSelect(arg_4_0.isSelected)
end

function var_0_0.setSelect(arg_5_0, arg_5_1)
	arg_5_0._treeView:selectCell(arg_5_0._cellIndex, arg_5_1)
end

function var_0_0.registerNotify(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	GlobalDispatcher:addEventListener(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.unregisterNotify(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	GlobalDispatcher:removeEventListener(arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.notify(arg_8_0, arg_8_1, arg_8_2)
	GlobalDispatcher:dispatchEvent(arg_8_1, arg_8_2)
end

function var_0_0.registerLocalNotify(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0._treeView:registerLocalNotify(arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.unregisterLocalNotify(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._treeView:unregisterLocalNotify(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.localNotify(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._treeView:localNotify(arg_11_1, arg_11_2)
end

function var_0_0.Awake(arg_12_0)
	return
end

function var_0_0.onSetMo(arg_13_0, arg_13_1)
	return
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	return
end

function var_0_0.OnDestroy(arg_15_0)
	return
end

return var_0_0
