module("frameworkext.lmvc.view.databinder.ListBinderView", package.seeall)

local var_0_0 = class("ListBinderView", DataBinderView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9)
	var_0_0.super.ctor(arg_1_0, arg_1_1:getListDataProvider(), arg_1_7, arg_1_8, arg_1_9)

	arg_1_0._listModel = arg_1_1
	arg_1_0._scrollGo = arg_1_2

	if not goutil.isNil(arg_1_0._scrollGo) then
		arg_1_0._scrollGoWidth = goutil.getWidth(arg_1_0._scrollGo.transform)
		arg_1_0._scrollGoHeight = goutil.getHeight(arg_1_0._scrollGo.transform)
	end

	arg_1_0._scrollRect = arg_1_2:GetComponent(UIComponentType.ScrollRect)

	if not goutil.isNil(arg_1_0._scrollRect) then
		arg_1_0._scrollContent = arg_1_0._scrollRect.content
	end

	local var_1_0

	if not goutil.isNil(arg_1_0._scrollContent) then
		arg_1_0._gridLayoutGroup = arg_1_0._scrollContent:GetComponent(UIComponentType.GridLayoutGroup)

		if goutil.isNil(arg_1_0._gridLayoutGroup) then
			var_1_0 = arg_1_0._scrollContent:GetComponent(UIComponentType.CircleLayoutGroup)
		end
	end

	arg_1_0._cellPrefabGo = arg_1_3

	goutil.setActive(arg_1_0._cellPrefabGo, false)

	arg_1_0._scrollParamters = {}

	if not goutil.isNil(arg_1_0._gridLayoutGroup) then
		arg_1_0._gridLayoutGroup.enabled = false

		if arg_1_0._scrollRect.horizontal == true then
			arg_1_0._scrollParamters[1] = kScrollDirH
		end

		if arg_1_0._scrollRect.vertical == true then
			arg_1_0._scrollParamters[1] = kScrollDirV
		end

		arg_1_0._scrollParamters[2] = arg_1_0._gridLayoutGroup.cellSize.x
		arg_1_0._scrollParamters[3] = arg_1_0._gridLayoutGroup.cellSize.y
		arg_1_0._scrollParamters[4] = arg_1_0._gridLayoutGroup.spacing.x
		arg_1_0._scrollParamters[5] = arg_1_0._gridLayoutGroup.spacing.y
		arg_1_0._childAlignment = arg_1_0._gridLayoutGroup.childAlignment

		arg_1_0:_setCellPrefabTransform(arg_1_0._gridLayoutGroup.cellSize.x, arg_1_0._gridLayoutGroup.cellSize.y)

		if arg_1_0._scrollParamters[1] == kScrollDirH then
			arg_1_0._scrollParamters[7] = arg_1_0._gridLayoutGroup.padding.left
			arg_1_0._scrollParamters[8] = arg_1_0._gridLayoutGroup.padding.right

			if arg_1_0._gridLayoutGroup.constraint == UnityEngine.UI.GridLayoutGroup.Constraint.FixedRowCount then
				arg_1_0._scrollParamters[6] = arg_1_0._gridLayoutGroup.constraintCount
			end
		elseif arg_1_0._scrollParamters[1] == kScrollDirV then
			arg_1_0._scrollParamters[7] = arg_1_0._gridLayoutGroup.padding.top
			arg_1_0._scrollParamters[8] = arg_1_0._gridLayoutGroup.padding.bottom

			if arg_1_0._gridLayoutGroup.constraint == UnityEngine.UI.GridLayoutGroup.Constraint.FixedColumnCount then
				arg_1_0._scrollParamters[6] = arg_1_0._gridLayoutGroup.constraintCount
			end
		end
	elseif not goutil.isNil(var_1_0) then
		var_1_0.enabled = false
		arg_1_0._scrollParamters[1] = var_1_0.ScrollDir
		arg_1_0._scrollParamters[2] = var_1_0.RotateDir
		arg_1_0._scrollParamters[3] = var_1_0.circleCellCount
		arg_1_0._scrollParamters[4] = var_1_0.radius
		arg_1_0._scrollParamters[5] = var_1_0.cellRadius
		arg_1_0._scrollParamters[6] = var_1_0.firstDegree
		arg_1_0._scrollParamters[7] = var_1_0.isLoop

		arg_1_0:_setCellPrefabTransform()
	end

	arg_1_0._cellBehaviorClass = arg_1_4
	arg_1_0._isMultiSelect = arg_1_5 or false
	arg_1_0._selectedItems = {}
	arg_1_0._cellSort = arg_1_6 or 0
end

function var_0_0._setCellPrefabTransform(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._cellPrefabGo.transform.anchorMin = Vector2(0.5, 0.5)
	arg_2_0._cellPrefabGo.transform.anchorMax = Vector2(0.5, 0.5)

	Astral.TransformUtil.SetAnchoredPos(arg_2_0._cellPrefabGo.transform, 0, 0)

	if arg_2_1 then
		goutil.setWidth(arg_2_0._cellPrefabGo.transform, arg_2_1)
	end

	if arg_2_2 then
		goutil.setHeight(arg_2_0._cellPrefabGo.transform, arg_2_2)
	end
end

function var_0_0.setViewPresentor(arg_3_0, arg_3_1)
	var_0_0.super.setViewPresentor(arg_3_0, arg_3_1)
end

function var_0_0.buildUI(arg_4_0)
	var_0_0.super.buildUI(arg_4_0)

	local var_4_0 = arg_4_0._scrollParamters[1] or kScrollDirH

	if var_4_0 == kScrollDirH or var_4_0 == kScrollDirV then
		local var_4_1 = arg_4_0._scrollParamters[2]
		local var_4_2 = arg_4_0._scrollParamters[3]
		local var_4_3 = arg_4_0._scrollParamters[4]
		local var_4_4 = arg_4_0._scrollParamters[5]
		local var_4_5 = arg_4_0._scrollParamters[6]
		local var_4_6 = arg_4_0._scrollParamters[7] or 0
		local var_4_7 = arg_4_0._scrollParamters[8] or 0

		arg_4_0._scroll = Astral.ScrollRectLoop.Get(arg_4_0._scrollGo)

		if var_4_5 == nil or var_4_5 == 0 then
			arg_4_0._scroll:Init(var_4_0, var_4_1, var_4_2, var_4_3, var_4_4, arg_4_0._onCellUpdate, arg_4_0, arg_4_0._onCellSelect, arg_4_0, arg_4_0._cellSort, var_4_6, var_4_7)
		else
			arg_4_0._scroll:InitFix(var_4_0, var_4_1, var_4_2, var_4_3, var_4_4, var_4_5, arg_4_0._onCellUpdate, arg_4_0, arg_4_0._onCellSelect, arg_4_0, arg_4_0._cellSort, var_4_6, var_4_7)
		end

		arg_4_0._scroll:SetCellsUpdateFinishHandler(arg_4_0._cellUpdateFinishHandler, arg_4_0)
	elseif var_4_0 == kScrollDirCircleH or var_4_0 == kScrollDirCircleV then
		local var_4_8 = arg_4_0._scrollParamters[2]
		local var_4_9 = arg_4_0._scrollParamters[3]
		local var_4_10 = arg_4_0._scrollParamters[4]
		local var_4_11 = arg_4_0._scrollParamters[5] or 0
		local var_4_12 = arg_4_0._scrollParamters[6] or 0
		local var_4_13 = arg_4_0._scrollParamters[7] or false

		arg_4_0._scroll = Astral.CircleLoop.Get(arg_4_0._scrollGo)

		arg_4_0._scroll:Init(var_4_0 - 2, var_4_8, var_4_9, var_4_10, var_4_11, var_4_12, var_4_13, arg_4_0._onCircleCellUpdate, arg_4_0._onCellSelect, arg_4_0)
	end
end

function var_0_0._cellUpdateFinishHandler(arg_5_0)
	arg_5_0:localNotify(EventType.FW_VIEW_ONCELLSUPDATEFINISH_EVENT)
end

function var_0_0.destroyUI(arg_6_0)
	var_0_0.super.destroyUI(arg_6_0)
	arg_6_0._scroll:Clear()

	arg_6_0._scroll = nil
	arg_6_0._listModel = nil
end

function var_0_0.refreshView(arg_7_0)
	var_0_0.super.refreshView(arg_7_0)

	arg_7_0._scroll.TotalCellNum = arg_7_0._listModel:getMoCount()

	arg_7_0:updateScrBlankView(arg_7_0._listModel:getMoCount())

	if arg_7_0._childAlignment and arg_7_0._childAlignment == UnityEngine.TextAnchor.MiddleCenter then
		local var_7_0 = arg_7_0._scrollParamters[2] or 0
		local var_7_1 = arg_7_0._scrollParamters[3] or 0
		local var_7_2 = arg_7_0._scrollParamters[4]
		local var_7_3 = arg_7_0._scrollParamters[5]
		local var_7_4 = arg_7_0._scrollParamters[7] or 0
		local var_7_5 = arg_7_0._scrollParamters[8] or 0
		local var_7_6 = arg_7_0._scroll.TotalCellNum * (var_7_0 + var_7_2) + var_7_4 + var_7_5

		if var_7_6 <= arg_7_0._scrollGoWidth then
			goutil.setWidth(arg_7_0._scrollGo.transform, var_7_6)
			goutil.setHeight(arg_7_0._scrollGo.transform, var_7_1)
		else
			goutil.setWidth(arg_7_0._scrollGo.transform, arg_7_0._scrollGoWidth)
			goutil.setHeight(arg_7_0._scrollGo.transform, arg_7_0._scrollGoHeight)
		end
	end
end

function var_0_0._onCircleCellUpdate(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:_onCellUpdate(arg_8_1, arg_8_2, -1)
end

function var_0_0._onCellUpdate(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = goutil.findChild(arg_9_1.gameObject, "item")
	local var_9_1

	if not var_9_0 then
		var_9_0 = goutil.clone(arg_9_0._cellPrefabGo)

		goutil.setActive(var_9_0, true)
		goutil.addChildToParent(var_9_0, arg_9_1.gameObject)

		var_9_0.name = "item"

		local var_9_2 = Astral.LuaComponentContainer.Get(var_9_0)

		var_9_2.CanLuaAwakeInvoked = false
		var_9_1 = Astral.LuaComponentContainer.Add(var_9_0, arg_9_0._cellBehaviorClass)

		var_9_1:setListView(arg_9_0)

		if var_9_1.Awake ~= nil then
			var_9_1:Awake()
		end

		if var_9_0.activeInHierarchy and var_9_2.enabled and var_9_1.OnEnable then
			var_9_1:OnEnable()
		end

		var_9_2.CanLuaAwakeInvoked = true
	end

	var_9_1 = var_9_1 or Astral.LuaComponentContainer.Get(var_9_0, arg_9_0._cellBehaviorClass)

	local var_9_3 = arg_9_0._listModel:getMoByIndex(arg_9_2 + 1)

	var_9_1:setCellIndex(arg_9_2 + 1)

	if not var_9_3 then
		printWarn("空数据异常，curIndex + 1 = ", arg_9_2 + 1)
	else
		var_9_1:updateData(var_9_3)
	end

	if table.indexof(arg_9_0._selectedItems, var_9_3) then
		var_9_1:showSelect(true)
	else
		var_9_1:showSelect(false)
	end
end

function var_0_0._onCellSelect(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0
	local var_10_1

	if arg_10_1 then
		local var_10_2 = goutil.findChild(arg_10_1.gameObject, "item")
		local var_10_3 = Astral.LuaComponentContainer.Get(var_10_2, arg_10_0._cellBehaviorClass)

		if var_10_3 then
			var_10_3:showSelect(arg_10_2)
		end
	end
end

function var_0_0.selectCells(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 then
		local var_11_0

		for iter_11_0 = 1, #arg_11_1 do
			local var_11_1 = arg_11_1[iter_11_0]

			arg_11_0:selectCell(var_11_1, arg_11_2)
		end
	end
end

function var_0_0.selectCell(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._listModel:getMoByIndex(arg_12_1)

	if var_12_0 then
		if arg_12_0._isMultiSelect then
			local var_12_1 = table.indexof(arg_12_0._selectedItems, var_12_0)

			if var_12_1 and not arg_12_2 then
				table.remove(arg_12_0._selectedItems, var_12_1)
			elseif arg_12_2 and not var_12_1 then
				table.insert(arg_12_0._selectedItems, var_12_0)
			end
		else
			if arg_12_0._selectedItems[1] ~= nil then
				local var_12_2 = arg_12_0._listModel:getMoIndex(arg_12_0._selectedItems[1])

				if var_12_2 then
					arg_12_0._scroll:SelectCell(var_12_2 - 1, false)
				end
			end

			if not arg_12_2 then
				arg_12_0._selectedItems = {}
			else
				arg_12_0._selectedItems = {
					var_12_0
				}
			end
		end

		arg_12_0._scroll:SelectCell(arg_12_1 - 1, arg_12_2)
	end
end

function var_0_0.getSelectItem(arg_13_0)
	return arg_13_0._selectedItems[1]
end

function var_0_0.setSelectItem(arg_14_0, arg_14_1)
	arg_14_0:setSelectItems({
		arg_14_1
	})
end

function var_0_0.getSelectItems(arg_15_0)
	return arg_15_0._selectedItems
end

function var_0_0.setSelectItems(arg_16_0, arg_16_1)
	table.clear(arg_16_0._selectedItems)

	if arg_16_1 then
		for iter_16_0 = 1, #arg_16_1 do
			table.insert(arg_16_0._selectedItems, arg_16_1[iter_16_0])
		end
	end

	arg_16_0._scroll:UpdateVisualCells()
end

function var_0_0.refreshVisible(arg_17_0)
	arg_17_0._scroll:UpdateVisualCells()
end

return var_0_0
