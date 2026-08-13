class = var_0_10000

local var_0_0 = "IslandTechCentrePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTechCentrePanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.viewTF = var_1.Find(var_2_0, "view")

	local var_2_1 = arg_2_0.viewTF
	local var_2_2 = var_1.Find(var_2_1, "content")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_2, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_1.OnInit(arg_5_0)
	arg_5_0:InifConfigData()

	arg_5_0.cards = {}

	return
end

function var_0_1.InifConfigData(arg_6_0)
	pg = var_1_10001
	arg_6_0.config = var_1_10001.island_technology_template
	arg_6_0.level2Ids = {}
	arg_6_0.levels = {}

	local var_6_0 = arg_6_0.config.get_id_list_by_tech_belong

	IslandTechBelong = var_1_10002
	arg_6_0.allIds = var_6_0[var_1_10002.CENTRE]
	ipairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0.allIds) do
		var_1_10006 = arg_6_0.config[iter_6_1].island_level

		local var_6_1

		if not arg_6_0.level2Ids[var_1_10006] then
			var_6_1 = arg_6_0.level2Ids
			var_6_1[var_1_10006] = {}
			table = var_6_1

			var_6_1.insert(arg_6_0.levels, var_1_10006)
		end

		table = var_6_1

		var_6_1.insert(arg_6_0.level2Ids[var_1_10006], iter_6_1)
	end

	pairs = var_1

	for iter_6_2, iter_6_3 in var_1(arg_6_0.level2Ids) do
		table = var_1_10006
		var_1_10006 = var_1_10006.sort

		local var_6_2 = iter_6_3

		CompareFuncs = var_1_10009

		var_1_10006(var_6_2, var_1_10009({
			function(arg_7_0)
				return arg_6_0.config[arg_7_0].axis[2]
			end,
			function(arg_8_0)
				return arg_8_0
			end
		}))
	end

	table = var_1

	var_1.sort(arg_6_0.levels)

	arg_6_0.level2UIList = {}

	return
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	IslandTechCentreCard = var_1_10002

	local var_9_0 = var_1_10002.New(arg_9_1)

	arg_9_0.cards[arg_9_1] = var_9_0

	return
end

function var_0_1.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)

		var_10_0 = arg_10_0.cards[arg_10_2]
	end

	local var_10_1 = arg_10_1 + 1
	local var_10_2 = arg_10_0.levels[var_10_1]
	local var_10_3 = arg_10_0.level2Ids[var_10_2]
	local var_10_4

	if not arg_10_0.levels[arg_10_1] or not arg_10_0.level2Ids[var_7] then
		var_10_4 = {}
	end

	local var_10_5 = var_10_2 > arg_10_0.islandLevel or arg_10_0:IsAnyUnFinish(var_10_4)
	local var_10_6 = var_10_1 == #arg_10_0.levels

	var_10_0:Update(var_10_2, var_10_3, var_10_6, var_10_5, arg_10_0.contextData.onItemClick)

	return
end

function var_0_1.IsAnyUnFinish(arg_11_0, arg_11_1)
	underscore = var_1_10002

	return var_1_10002.any(arg_11_1, function(arg_12_0)
		local var_12_0 = arg_11_0.techAgency

		return not var_1.IsFinishedTech(var_12_0, arg_12_0)
	end)
end

function var_0_1.Show(arg_13_0)
	arg_13_0.super.Show(arg_13_0)
	arg_13_0:Flush()
	arg_13_0:AutoFocus()

	return
end

function var_0_1.Flush(arg_14_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)
	local var_14_1 = var_1.GetIsland(var_14_0)

	arg_14_0.islandLevel = var_1.GetLevel(var_14_1)
	arg_14_0.techAgency = var_1:GetTechnologyAgency()
	arg_14_0.scrollRect.enabled = true

	local var_14_2 = arg_14_0.scrollRect

	var_2.SetTotalCount(var_14_2, #arg_14_0.levels, 0)

	return
end

function var_0_1.AutoFocus(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetFocusTechId(var_15_0)
	local var_15_2 = arg_15_0.config[var_15_1].island_level

	table = var_15_0

	local var_15_3 = var_15_0.indexof(arg_15_0.levels, var_15_2)
	local var_15_4 = arg_15_0.scrollRect
	local var_15_5 = var_4.ScrollTo

	math = var_1_10007

	var_15_5(var_15_4, var_1_10007.max(var_15_3 - 4, 0) / (#arg_15_0.levels - 7))

	return
end

function var_0_1.GetFocusTechId(arg_16_0)
	local var_16_0 = {}

	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.allIds) do
		local var_16_1 = arg_16_0.techAgency
		local var_16_2 = var_7.GetTechnology(var_16_1, iter_16_1)

		if not var_16_0[var_7.GetStatus(var_16_2)] then
			var_16_0[var_7] = {}
		end

		table = var_8

		var_8.insert(var_16_0[var_7], iter_16_1)
	end

	ipairs = var_2
	IslandTechTreePanel = var_4

	for iter_16_2, iter_16_3 in var_2(var_4.FocusPriorities) do
		if var_16_0[iter_16_3] and #var_7 > 0 then
			table = var_8

			local var_16_3 = var_8.sort
			local var_16_4 = var_7

			CompareFuncs = var_1_10011

			var_16_3(var_16_4, var_1_10011({
				function(arg_17_0)
					return arg_16_0.config[arg_17_0].island_level
				end,
				function(arg_18_0)
					return arg_18_0
				end
			}))

			return var_7[1]
		end
	end

	return arg_16_0.allIds[1]
end

function var_0_1.OnDestroy(arg_19_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_19_0.scrollRect)

	pairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.cards) do
		iter_19_1:Dispose()
	end

	arg_19_0.cards = {}

	return
end

return var_0_1
