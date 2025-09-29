module("frameworkext.lmvc.view.databinder.ListBinderCell", package.seeall)

local var_0_0 = class("ListBinderCell")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._compContainer = arg_1_1
	arg_1_0._go = arg_1_0._compContainer.gameObject
	arg_1_0._cellIndex = 0
	arg_1_0._listView = nil
	arg_1_0._data = nil
	arg_1_0._viewElementsRegistry = ViewElementsRegistry.New(arg_1_0._go)
	arg_1_0._compMap = {}
	arg_1_0._specifiedRegistryLevel = ""
end

function var_0_0.setCellIndex(arg_2_0, arg_2_1)
	arg_2_0._cellIndex = arg_2_1
end

function var_0_0.setListView(arg_3_0, arg_3_1)
	arg_3_0._listView = arg_3_1
end

function var_0_0.showSelect(arg_4_0, arg_4_1)
	if arg_4_0.isSelected == arg_4_1 then
		return
	end

	arg_4_0.isSelected = arg_4_1

	arg_4_0:onSelect(arg_4_0.isSelected)
end

function var_0_0.setSpecifiedRegistryLevel(arg_5_0, arg_5_1)
	arg_5_0._specifiedRegistryLevel = arg_5_1
end

function var_0_0.specifiedLevelKey(arg_6_0, arg_6_1)
	return arg_6_0._specifiedRegistryLevel .. arg_6_1
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	if arg_7_0._listView then
		arg_7_0._listView:selectCell(arg_7_0._cellIndex, arg_7_1)
	end
end

function var_0_0.getCompContainer(arg_8_0)
	return arg_8_0._compContainer
end

function var_0_0.getViewElementsRegistry(arg_9_0)
	return arg_9_0._viewElementsRegistry
end

function var_0_0.findUIElement(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0._viewElementsRegistry:findUIElement(arg_10_1, arg_10_2)
end

function var_0_0.Awake(arg_11_0)
	arg_11_0:_initComponents()

	for iter_11_0, iter_11_1 in pairs(arg_11_0._compMap) do
		iter_11_1:onInit()
	end
end

function var_0_0.updateData(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._compMap) do
		iter_12_1:updateData(arg_12_1)
	end

	arg_12_0._data = arg_12_1
end

function var_0_0.getData(arg_13_0)
	return arg_13_0._data
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	return
end

function var_0_0.OnDestroy(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._compMap) do
		iter_15_1:onDestroy()
	end

	arg_15_0._viewElementsRegistry:cleanRegistry()

	arg_15_0._viewElementsRegistry = nil
end

function var_0_0._initComponents(arg_16_0)
	return
end

function var_0_0._addComponent(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2.New(arg_17_0)

	arg_17_0._compMap[arg_17_1] = var_17_0
end

function var_0_0.getComponent(arg_18_0, arg_18_1)
	return arg_18_1 and arg_18_0._compMap[arg_18_1]
end

return var_0_0
