module("frameworkext.lmvc.view.databinder.IrregularBinderView", package.seeall)

local var_0_0 = class("IrregularBinderView", DataBinderView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9)
	var_0_0.super.ctor(arg_1_0, arg_1_1:getListDataProvider(), arg_1_7, arg_1_8, arg_1_9)

	arg_1_0._listModel = arg_1_1
	arg_1_0.scrollGo = arg_1_2
	arg_1_0._cellPrefabGo = arg_1_3

	goutil.setActive(arg_1_0._cellPrefabGo, false)

	arg_1_0._cellBehaviorClass = arg_1_4
	arg_1_0._scrollDir = arg_1_5
	arg_1_0._calcCls = arg_1_6
end

function var_0_0.buildUI(arg_2_0)
	var_0_0.super.buildUI(arg_2_0)

	arg_2_0._scroll = Astral.IrregularLoop.Get(arg_2_0.scrollGo)

	arg_2_0._scroll:Init(arg_2_0._scrollDir, arg_2_0._calcCls:getInfoList(arg_2_0._listModel, arg_2_0.scrollGo), arg_2_0._onCellUpdate, arg_2_0)
end

function var_0_0.destroyUI(arg_3_0)
	var_0_0.super.destroyUI(arg_3_0)
	arg_3_0._scroll:Clear()

	arg_3_0._scroll = nil
	arg_3_0._listModel = nil
end

function var_0_0.refreshView(arg_4_0)
	var_0_0.super.refreshView(arg_4_0)
	arg_4_0._scroll:UpdateIrregularInfo(arg_4_0._calcCls:getInfoList(arg_4_0._listModel, arg_4_0.scrollGo), true, false)
	arg_4_0:updateScrBlankView(arg_4_0._listModel:getMoCount())
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

		var_5_1:setListView(arg_5_0)

		if var_5_1.Awake ~= nil then
			var_5_1:Awake()
		end

		if var_5_0.activeInHierarchy and var_5_2.enabled and var_5_1.OnEnable then
			var_5_1:OnEnable()
		end

		var_5_2.CanLuaAwakeInvoked = true
	end

	var_5_1 = var_5_1 or Astral.LuaComponentContainer.Get(var_5_0, arg_5_0._cellBehaviorClass)

	local var_5_3 = arg_5_0._listModel:getMoByIndex(arg_5_2 + 1)

	var_5_1:setCellIndex(arg_5_2 + 1)
	var_5_1:onSetMo(var_5_3)
end

function var_0_0.refreshVisible(arg_6_0)
	arg_6_0._scroll:UpdateVisualCells()
end

return var_0_0
