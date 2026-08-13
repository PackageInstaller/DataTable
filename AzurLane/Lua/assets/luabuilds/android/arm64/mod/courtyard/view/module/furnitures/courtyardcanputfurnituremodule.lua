class = var_0_10000

local var_0_0 = "CourtYardCanPutFurnitureModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardFurnitureModule"))
local var_0_2 = false

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.childModules = {}

	return
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	if var_0_2 then
		CourtYardMapDebug = var_1

		local var_2_0 = var_1.New
		local var_2_1 = arg_2_0.data.placeableArea

		Color = var_1_10004
		arg_2_0.mapDebug = var_2_0(var_2_1, var_1_10004.New(1, 0, 0))
		GetOrAddComponent = var_1

		local var_2_2 = arg_2_0:GetParentTF()

		typeof = var_4
		CanvasGroup = var_6
		var_1(var_2_2, var_4(var_6)).alpha = 0.3
	end

	arg_2_0:RefreshDepth()

	return
end

function var_0_1.AddChild(arg_3_0, arg_3_1)
	arg_3_0:CancelPuddingAnim()
	arg_3_1:CancelPuddingAnim()

	local var_3_0 = arg_3_1.data
	local var_3_1 = var_2.GetDeathType(var_3_0) .. arg_3_1.data.id

	arg_3_0.childModules[var_3_1] = arg_3_1

	local var_3_2 = arg_3_1._tf

	var_3.SetParent(var_3_2, arg_3_0.childsTF)

	return
end

function var_0_1.RemoveChild(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.data
	local var_4_1 = var_2.GetDeathType(var_4_0) .. arg_4_1.data.id

	arg_4_0.childModules[var_4_1] = nil

	local var_4_2 = arg_4_1._tf

	var_3.SetParent(var_4_2, arg_4_0:GetParentTF())

	return
end

function var_0_1.AddListeners(arg_5_0)
	var_0_1.super.AddListeners(arg_5_0)

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.AddAreaListener

	CourtYardEvent = var_1_10004

	var_5_1(var_5_0, var_1_10004.REMOVE_ITEM, arg_5_0.OnRemoveItem)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.AddAreaListener

	CourtYardEvent = var_4

	var_5_3(var_5_2, var_4.ADD_ITEM, arg_5_0.OnAddItem)

	return
end

function var_0_1.RemoveListeners(arg_6_0)
	var_0_1.super.RemoveListeners(arg_6_0)

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.RemoveAreaListener

	CourtYardEvent = var_1_10004

	var_6_1(var_6_0, var_1_10004.REMOVE_ITEM, arg_6_0.OnRemoveItem)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.RemoveAreaListener

	CourtYardEvent = var_4

	var_6_3(var_6_2, var_4.ADD_ITEM, arg_6_0.OnAddItem)

	return
end

function var_0_1.AddAreaListener(arg_7_0, arg_7_1, arg_7_2)
	local function var_7_0(arg_8_0, arg_8_1, ...)
		arg_7_2(arg_7_0, ...)

		return
	end

	arg_7_0.callbacks[arg_7_2] = var_7_0

	local var_7_1 = arg_7_0.data.placeableArea

	var_4.AddListener(var_7_1, arg_7_1, var_7_0)

	return
end

function var_0_1.RemoveAreaListener(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.callbacks[arg_9_2] then
		local var_9_0 = arg_9_0.data.placeableArea

		var_4.RemoveListener(var_9_0, arg_9_1, var_3)

		arg_9_0.callbacks[var_3] = nil
	end

	return
end

function var_0_1.OnRemoveItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetDeathType() .. arg_10_1.id
	local var_10_1 = arg_10_0.childModules[var_10_0]._tf

	var_4.SetParent(var_10_1, arg_10_0:GetParentTF())

	if var_0_2 then
		local var_10_2 = arg_10_0.mapDebug

		var_4.Flush(var_10_2)
	end

	return
end

function var_0_1.OnAddItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:GetDeathType() .. arg_11_1.id
	local var_11_1 = arg_11_0.childModules[var_11_0]._tf

	var_4.SetParent(var_11_1, arg_11_0.childsTF)

	local var_11_2 = arg_11_1:GetOffset()

	var_3._tf.localPosition = var_3._tf.localPosition + var_11_2

	arg_11_0:RefreshDepth()

	if var_0_2 then
		local var_11_3 = arg_11_0.mapDebug

		var_5.Flush(var_11_3)
	end

	return
end

function var_0_1.RefreshDepth(arg_12_0)
	ipairs = var_1_10001

	local var_12_0 = arg_12_0.data.placeableArea

	for iter_12_0, iter_12_1 in var_1_10001(var_3.GetItems(var_12_0)) do
		local var_12_1 = iter_12_1:GetDeathType() .. iter_12_1.id
		local var_12_2 = arg_12_0.childModules[var_12_1]

		var_7.SetSiblingIndex(var_12_2, iter_12_0 - 1)
	end

	return
end

function var_0_1.BlocksRaycasts(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.data
	local var_13_1 = var_2.CanClickWhenExitEditMode(var_13_0)
	local var_13_2 = arg_13_0.data
	local var_13_3

	if not (#var_3.GetUsingSlots(var_13_2) > 0) then
		table = var_3

		if not (var_3.getCount(arg_13_0.childModules) > 0) then
			var_13_3 = false

			goto label_13_0
		end
	end

	var_13_3 = true

	::label_13_0::

	if (var_13_1 or var_13_3) and arg_13_1 == false then
		return
	end

	arg_13_0.cg.blocksRaycasts = arg_13_1

	return
end

function var_0_1.Dispose(arg_14_0)
	var_0_1.super.Dispose(arg_14_0)

	if var_0_2 then
		local var_14_0 = arg_14_0.mapDebug

		var_1.Dispose(var_14_0)

		GetOrAddComponent = var_1

		local var_14_1 = arg_14_0:GetParentTF()

		typeof = var_1_10004
		CanvasGroup = var_1_10006
		var_1(var_14_1, var_1_10004(var_1_10006)).alpha = 1
	end

	return
end

return var_0_1
