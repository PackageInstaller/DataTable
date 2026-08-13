class = var_0_10000

local var_0_0 = "IslandPostProdPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.ScrollValue = 0

function var_0_1.getUIName(arg_1_0)
	return "IslandPostProdPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	setActive = var_1_10001

	local var_2_0 = arg_2_0._tf

	var_1_10001(var_3.Find(var_2_0, "tpl"), false)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "view")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_2, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	local var_2_3 = arg_2_0.scrollRect

	function var_2_3.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	IslandDelegationSelectPanel = var_2_3

	local var_2_4 = var_2_3.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = arg_2_0.event

	setmetatable = var_2_0
	arg_2_0.selectPanel = var_2_4(var_2_5, var_2_6, var_2_0({
		isPost = true,
		ShowMsgBox = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_2_0.contextData

			var_2.ShowMsgBox(var_5_0, arg_5_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))

	return
end

function var_0_1.OnInit(arg_6_0)
	pg = var_1_10001
	arg_6_0.placeIds = var_1_10001.island_set.post_manage_produce.key_value_varchar
	arg_6_0.cards = {}
	arg_6_0.flushAll = true

	local var_6_0 = arg_6_0.scrollRect.onValueChanged

	var_1.RemoveAllListeners(var_6_0)

	pg = var_2

	var_2.DelegateInfo.Add(arg_6_0, var_1)
	var_1:AddListener(function(arg_7_0)
		var_0_1.ScrollValue = arg_7_0.y

		return
	end)

	return
end

function var_0_1.OnInitItem(arg_8_0, arg_8_1)
	IslandPostPlaceCard = var_1_10002

	local var_8_0 = var_1_10002.New(arg_8_1)

	arg_8_0.cards[arg_8_1] = var_8_0

	return
end

function var_0_1.OnUpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if not arg_9_0.cards[arg_9_2] then
		arg_9_0:OnInitItem(arg_9_1, arg_9_2)

		var_9_0 = arg_9_0.cards[arg_9_2]
	end

	if arg_9_0.placeIds[arg_9_1 + 1] then
		var_9_0:Update(var_4, function(arg_10_0)
			local var_10_0 = arg_9_0

			var_1.OpenSelectPanel(var_10_0, arg_10_0)

			return
		end)
	end

	return
end

function var_0_1.Show(arg_11_0)
	arg_11_0.super.Show(arg_11_0)

	if arg_11_0.flushAll then
		arg_11_0:Flush()
	end

	arg_11_0.flushAll = false

	local var_11_0 = arg_11_0.scrollRect

	var_1.ScrollTo(var_11_0, var_0_1.ScrollValue)

	return
end

function var_0_1.Flush(arg_12_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.GetIsland(var_12_0)

	arg_12_0.buildingAgency = var_1.GetBuildingAgency(var_12_1)

	local var_12_2 = arg_12_0.buildingAgency

	arg_12_0.buildings = var_1.GetBuildings(var_12_2)

	local var_12_3 = arg_12_0.scrollRect

	var_1.SetTotalCount(var_12_3, #arg_12_0.placeIds, -1)

	local var_12_4 = arg_12_0.selectPanel

	if var_1.isShowing(var_12_4) then
		local var_12_5 = arg_12_0.selectPanel

		var_1.ExecuteAction(var_12_5, "Flush")
	end

	return
end

function var_0_1.FlushSlot(arg_13_0, arg_13_1)
	pg = var_1_10002

	local var_13_0 = var_1_10002.island_production_slot[arg_13_1].place

	pairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(arg_13_0.cards) do
		if iter_13_1.id == var_13_0 then
			iter_13_1:UpdateSlot(arg_13_1)
		end
	end

	local var_13_1 = arg_13_0.selectPanel

	if var_3.isShowing(var_13_1) then
		local var_13_2 = arg_13_0.selectPanel

		var_3.ExecuteAction(var_13_2, "Flush")
	end

	return
end

function var_0_1.OpenSelectPanel(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.selectPanel

	var_2.ExecuteAction(var_14_0, "Show", arg_14_1)

	return
end

function var_0_1.Hide(arg_15_0)
	arg_15_0.super.Hide(arg_15_0)

	local var_15_0 = arg_15_0.selectPanel

	var_1.ExecuteAction(var_15_0, "Hide")

	return
end

function var_0_1.OnDestroy(arg_16_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_16_0.scrollRect)

	if arg_16_0.selectPanel then
		local var_16_0 = arg_16_0.selectPanel

		var_1.Destroy(var_16_0)

		arg_16_0.selectPanel = nil
	end

	pairs = var_1

	for iter_16_0, iter_16_1 in var_1(arg_16_0.cards) do
		iter_16_1:Dispose()
	end

	arg_16_0.cards = {}

	return
end

return var_0_1
