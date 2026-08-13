class = var_0_10000

local var_0_0 = "IslandSelectableOpView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandASynLoadAndCacheSubView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandSelectableOpUI"
end

function var_0_1.SetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().topContainer
end

function var_0_1.FirstFlush(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.frameTr = var_1.Find(var_3_0, "list")

	local var_3_1 = arg_3_0._tf

	arg_3_0.cotainer = var_1.Find(var_3_1, "list/content")

	local var_3_2 = arg_3_0._tf

	arg_3_0.tpl = var_1.Find(var_3_2, "list/content/item")

	local var_3_3 = arg_3_0.cotainer
	local var_3_4 = var_1.GetComponent

	typeof = var_4
	GridLayoutGroup = var_1_10006
	arg_3_0.gridLayoutGroup = var_3_4(var_3_3, var_4(var_1_10006))
	UIItemList = var_1
	arg_3_0.uiItemList = var_1.New(arg_3_0.cotainer, arg_3_0.tpl)
	IslandSelectableDescPanel = var_1

	local var_3_5 = var_1.New
	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_3.Find(var_3_6, "desc")
	local var_3_8 = arg_3_0

	arg_3_0.descPanle = var_3_5(var_3_7, arg_3_0.IsShowItemCount(var_3_8))
	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0._tf

	local function var_3_11()
		local var_4_0 = arg_3_0.descPanle

		if var_0.IsShowing(var_4_0) then
			local var_4_1 = arg_3_0.descPanle

			var_0.Hide(var_4_1)

			return
		end

		local var_4_2 = arg_3_0

		var_0.Dispose(var_4_2)

		return
	end

	SFX_PANEL = var_3_8

	var_1(var_3_9, var_3_10, var_3_11, var_3_8)

	return
end

function var_0_1.Filter(arg_5_0, arg_5_1)
	local var_5_0 = {}

	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_1) do
		assert = var_1_10008
		isa = var_1_10010

		local var_5_1 = iter_5_1

		IslandItem = var_1_10013

		var_1_10008(var_1_10010(var_5_1, var_1_10013), "v is not a IslandItem")

		var_1_10010 = iter_5_1

		if iter_5_1.GetCount(var_1_10010) > 0 then
			table = var_1_10008

			var_1_10008.insert(var_5_0, iter_5_1)
		end
	end

	arg_5_0:Sort(var_5_0)

	return var_5_0
end

function var_0_1.Sort(arg_6_0, arg_6_1)
	table = var_1_10002

	var_1_10002.sort(arg_6_1, function(arg_7_0, arg_7_1)
		if arg_7_0:GetRarity() == arg_7_1:GetRarity() then
			return arg_7_0.id > arg_7_1.id
		else
			return var_3 < var_2
		end

		return
	end)

	return
end

function var_0_1.Flush(arg_8_0)
	arg_8_0.selectedId = arg_8_0:GetSelectedId()
	arg_8_0.displays = arg_8_0:Filter(arg_8_0:GetDisplayData())
	seriesAsync = var_1

	var_1({
		function(arg_9_0)
			local var_9_0 = arg_8_0

			var_1.PreloadList(var_9_0, arg_9_0)

			return
		end
	}, function()
		local var_10_0 = arg_8_0

		var_0.UpdateLayout(var_10_0)

		local var_10_1 = arg_8_0

		var_0.UpdateList(var_10_1)

		return
	end)

	return
end

function var_0_1.PreloadList(arg_11_0, arg_11_1)
	if #arg_11_0.displays <= 5 then
		arg_11_1()

		return
	end

	local var_11_0 = {}

	ipairs = var_4

	for iter_11_0, iter_11_1 in var_4(var_2) do
		table = var_1_10009

		var_1_10009.insert(var_11_0, function(arg_12_0)
			cloneTplTo = var_2_10001

			var_2_10001(arg_11_0.tpl, arg_11_0.cotainer)

			if iter_11_0 % 3 == 0 then
				onNextTick = var_1

				var_1(arg_12_0)
			else
				arg_12_0()
			end

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_11_0, arg_11_1)

	return
end

function var_0_1.UpdateLayout(arg_13_0)
	local var_13_0 = arg_13_0.displays
	local var_13_1 = arg_13_0:GetMaxHrzCnt()

	math = var_1_10003

	local var_13_2 = var_1_10003.min(#var_13_0, var_13_1)

	arg_13_0.gridLayoutGroup.constraintCount = var_13_2

	local var_13_3 = arg_13_0:GetTargetTr()

	arg_13_0.frameTr.position = var_0_1.TrPosition2LocalPos(var_13_3.parent, arg_13_0.frameTr.parent, var_13_3.position)

	return
end

function var_0_1.TrPosition2LocalPos(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0 == arg_14_1 then
		return arg_14_2
	else
		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.TransformPoint(var_14_0, arg_14_2)
		local var_14_2 = arg_14_1:InverseTransformPoint(var_14_1)

		Vector3 = var_14_0

		return var_14_0(var_14_2.x, var_14_2.y, 0)
	end

	return
end

function var_0_1.UpdateList(arg_15_0)
	local var_15_0 = arg_15_0.displays
	local var_15_1 = arg_15_0.uiItemList

	var_2.make(var_15_1, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_15_0

			var_3.UpdateItem(var_16_0, arg_16_2, var_15_0[arg_16_1 + 1])
		end

		return
	end)

	local var_15_2 = arg_15_0.uiItemList

	var_2.align(var_15_2, #var_15_0)
	arg_15_0:UpdateSelected()

	return
end

function var_0_1.UpdateItem(arg_17_0, arg_17_1, arg_17_2)
	assert = var_1_10003
	isa = var_1_10005

	local var_17_0 = arg_17_2

	IslandItem = var_1_10008

	var_1_10003(var_1_10005(var_17_0, var_1_10008), "islandItem is not a IslandItem")

	updateCustomDrop = var_1_10003

	local var_17_1 = arg_17_1

	Drop = var_6

	local var_17_2 = var_6.New
	local var_17_3 = {}

	DROP_TYPE_ISLAND_ITEM = var_1_10009
	var_17_3.type = var_1_10009
	var_17_3.id = arg_17_2.id
	var_17_3.count = arg_17_2:GetCount()

	var_1_10003(var_17_1, var_17_2(var_17_3))

	setActive = var_1_10003

	var_1_10003(arg_17_1:Find("icon_bg/count_bg"), arg_17_0:IsShowItemCount())

	local var_17_4 = false

	onButton = var_1_10004

	local var_17_5 = arg_17_0
	local var_17_6 = arg_17_1

	local function var_17_7()
		if var_17_4 then
			var_17_4 = false

			return
		end

		arg_17_0.selectedId = arg_17_2.id

		local var_18_0 = arg_17_0

		var_0.UpdateSelected(var_18_0)

		local var_18_1 = arg_17_0

		var_0.OnSelected(var_18_1, arg_17_2.id)

		local var_18_2 = arg_17_0

		var_0.Dispose(var_18_2)

		return
	end

	SFX_PANEL = var_9

	var_1_10004(var_17_5, var_17_6, var_17_7, var_9)

	GetOrAddComponent = var_1_10004

	local var_17_8 = arg_17_1

	typeof = var_17_6
	UILongPressTrigger = var_9

	local var_17_9 = var_1_10004(var_17_8, var_17_6(var_9)).onLongPressed

	var_5.RemoveAllListeners(var_17_9)

	local var_17_10 = var_4.onLongPressed

	var_5.AddListener(var_17_10, function()
		var_17_4 = true

		local var_19_0 = arg_17_0.descPanle

		var_0.Show(var_19_0, arg_17_1.position, arg_17_2)

		return
	end)

	return
end

function var_0_1.UpdateSelected(arg_20_0)
	local var_20_0 = arg_20_0.displays
	local var_20_1 = arg_20_0.uiItemList

	var_2.eachActive(var_20_1, function(arg_21_0, arg_21_1)
		local var_21_0 = var_20_0[arg_21_0 + 1]

		setActive = var_3

		var_3(arg_21_1:Find("select"), arg_20_0.selectedId == var_21_0.id)

		return
	end)

	return
end

function var_0_1.OnHide(arg_22_0)
	local var_22_0 = arg_22_0.descPanle

	var_1.Hide(var_22_0)

	arg_22_0.selectedId = nil

	local var_22_1 = arg_22_0.uiItemList

	var_1.each(var_22_1, function(arg_23_0, arg_23_1)
		GetOrAddComponent = var_2_10002

		local var_23_0 = arg_23_1

		typeof = var_2_10005
		UILongPressTrigger = var_2_10007

		local var_23_1 = var_2_10002(var_23_0, var_2_10005(var_2_10007)).onLongPressed

		var_3.RemoveAllListeners(var_23_1)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_24_0)
	if arg_24_0.descPanle then
		local var_24_0 = arg_24_0.descPanle

		var_1.Dispose(var_24_0)

		arg_24_0.descPanle = nil
	end

	return
end

function var_0_1.GetDisplayData(arg_25_0)
	assert = var_1_10001

	var_1_10001(false, "over write me")

	return
end

function var_0_1.GetTargetTr(arg_26_0)
	assert = var_1_10001

	var_1_10001(false, "over write me")

	return
end

function var_0_1.IsShowItemCount(arg_27_0)
	return true
end

function var_0_1.GetSelectedId(arg_28_0)
	return 0
end

function var_0_1.OnSelected(arg_29_0, arg_29_1)
	return
end

function var_0_1.GetMaxHrzCnt(arg_30_0)
	return 7
end

return var_0_1
