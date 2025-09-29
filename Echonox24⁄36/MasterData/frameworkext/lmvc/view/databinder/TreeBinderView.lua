module("frameworkext.lmvc.view.databinder.TreeBinderView", package.seeall)

local var_0_0 = class("TreeBinderView", DataBinderView)

DefaultTransitionSeconds = 0.3

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	var_0_0.super.ctor(arg_1_0, arg_1_1:getTreeDataProvider(), arg_1_6, arg_1_7, arg_1_8)

	arg_1_0._treeModel = arg_1_1
	arg_1_0._treeGo = arg_1_2
	arg_1_0._cellPrefabGo = arg_1_3

	goutil.setActive(arg_1_0._cellPrefabGo, false)

	arg_1_0._cellBehaviorClass = arg_1_4
	arg_1_0._scrollDir = arg_1_5
	arg_1_0._selectedItems = {}
end

function var_0_0.buildUI(arg_2_0)
	var_0_0.super.buildUI(arg_2_0)

	arg_2_0._tree = Astral.TreeLoop.Get(arg_2_0._treeGo)

	arg_2_0._tree:Init(arg_2_0._scrollDir, arg_2_0._onCellUpdate, arg_2_0, arg_2_0._onCellSelect, arg_2_0)
end

function var_0_0.destroyUI(arg_3_0)
	var_0_0.super.destroyUI(arg_3_0)
	arg_3_0._tree:Clear()

	arg_3_0._tree = nil
	arg_3_0._treeModel = nil
end

function var_0_0.refreshView(arg_4_0)
	var_0_0.super.refreshView(arg_4_0)

	local var_4_0 = {}
	local var_4_1 = arg_4_0._treeModel:getRootCount()

	for iter_4_0 = 1, var_4_1 do
		local var_4_2 = {}
		local var_4_3 = arg_4_0._treeModel:getStyle(iter_4_0)

		var_4_2.rootType = var_4_3.rootType or 0
		var_4_2.rootIndex = iter_4_0 - 1
		var_4_2.rootLength = var_4_3.rootLength or 0
		var_4_2.childNodeType = var_4_3.childNodeType or 0
		var_4_2.childNodeLength = var_4_3.childNodeLength or 0
		var_4_2.childNodeCountEachLine = var_4_3.childNodeCountEachLine or 0
		var_4_2.isExpanded = var_4_3.isExpanded or false
		var_4_2.childNodeCount = arg_4_0._treeModel:getNodeCount(iter_4_0)

		if var_4_2.childNodeCountEachLine <= 0 then
			var_4_2.childNodeCountEachLine = 1
		end

		var_4_0[iter_4_0] = var_4_2
	end

	arg_4_0._tree:UpdateTreeInfoList(var_4_0)
	arg_4_0:updateScrBlankView(var_4_1)
end

function var_0_0._onCellUpdate(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = goutil.findChild(arg_5_1.gameObject, "item")
	local var_5_1

	if not var_5_0 then
		var_5_0 = goutil.clone(arg_5_0._cellPrefabGo)

		goutil.setActive(var_5_0, true)
		goutil.addChildToParent(var_5_0, arg_5_1.gameObject)

		var_5_0.name = "item"

		local var_5_2 = Astral.LuaComponentContainer.Get(var_5_0)

		var_5_2.CanLuaAwakeInvoked = false
		var_5_1 = Astral.LuaComponentContainer.Add(var_5_0, arg_5_0._cellBehaviorClass)

		var_5_1:setTreeView(arg_5_0)

		if var_5_1.Awake ~= nil then
			var_5_1:Awake()
		end

		if var_5_0.activeInHierarchy and var_5_2.enabled and var_5_1.OnEnable then
			var_5_1:OnEnable()
		end

		var_5_2.CanLuaAwakeInvoked = true
	end

	var_5_1 = var_5_1 or Astral.LuaComponentContainer.Get(var_5_0, arg_5_0._cellBehaviorClass)

	local var_5_3 = arg_5_0._treeModel:getMoByIndex(arg_5_3 + 1, arg_5_4 + 1)

	var_5_1:setIndex(arg_5_3 + 1, arg_5_4 + 1)
	var_5_1:onSetMo(var_5_3, arg_5_2)

	if table.indexof(arg_5_0._selectedItems, var_5_3) then
		var_5_1:showSelect(true)
	else
		var_5_1:showSelect(false)
	end
end

function var_0_0._onCellSelect(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1

	if arg_6_1 then
		local var_6_2 = goutil.findChild(arg_6_1.gameObject, "item")
		local var_6_3 = Astral.LuaComponentContainer.Get(var_6_2, arg_6_0._cellBehaviorClass)

		if var_6_3 then
			var_6_3:showSelect(arg_6_2)
		end
	end
end

function var_0_0.selectCell(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0._treeModel:getMoByIndex(arg_7_1, arg_7_2)

	if var_7_0 then
		local var_7_1 = table.indexof(arg_7_0._selectedItems, var_7_0)

		if var_7_1 and not arg_7_3 then
			table.remove(arg_7_0._selectedItems, var_7_1)
		elseif arg_7_3 and not var_7_1 then
			table.insert(arg_7_0._selectedItems, var_7_0)
		end

		arg_7_0._tree:SelectCell(arg_7_1 - 1, arg_7_2 - 1, arg_7_3)
	end
end

function var_0_0.getSelectItems(arg_8_0)
	return arg_8_0._selectedItems
end

function var_0_0.setSelectItems(arg_9_0, arg_9_1)
	arg_9_0._selectedItems = arg_9_1

	arg_9_0._tree:UpdateCells(true, false)
end

function var_0_0.expand(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_2 == nil then
		arg_10_2 = true
	end

	arg_10_0._tree:Expand(arg_10_1 - 1, arg_10_2, arg_10_3 or DefaultTransitionSeconds, arg_10_4)
end

function var_0_0.shrink(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_2 == nil then
		arg_11_2 = true
	end

	arg_11_0._tree:Shrink(arg_11_1 - 1, arg_11_2, arg_11_3 or DefaultTransitionSeconds, arg_11_4)
end

return var_0_0
