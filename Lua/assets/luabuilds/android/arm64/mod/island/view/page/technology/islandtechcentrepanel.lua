local var_0_0 = class("IslandTechCentrePanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandTechCentrePanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.viewTF = arg_2_0._tf:Find("view")
	arg_2_0.scrollRect = arg_2_0.viewTF:Find("content"):GetComponent("LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0:InifConfigData()

	arg_5_0.cards = {}

	return
end

function var_0_0.InifConfigData(arg_6_0)
	arg_6_0.config = pg.island_technology_template
	arg_6_0.level2Ids = {}
	arg_6_0.levels = {}
	arg_6_0.allIds = arg_6_0.config.get_id_list_by_tech_belong[IslandTechBelong.CENTRE]

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.allIds) do
		if not arg_6_0.level2Ids[arg_6_0.config[iter_6_1].island_level] then
			arg_6_0.level2Ids[arg_6_0.config[iter_6_1].island_level] = {}

			table.insert(arg_6_0.levels, arg_6_0.config[iter_6_1].island_level)
		end

		table.insert(arg_6_0.level2Ids[arg_6_0.config[iter_6_1].island_level], iter_6_1)
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0.level2Ids) do
		table.sort(iter_6_3, CompareFuncs({
			function(arg_7_0)
				return arg_6_0.config[arg_7_0].axis[2]
			end,
			function(arg_8_0)
				return arg_8_0
			end
		}))
	end

	table.sort(arg_6_0.levels)

	arg_6_0.level2UIList = {}

	return
end

function var_0_0.OnInitItem(arg_9_0, arg_9_1)
	arg_9_0.cards[arg_9_1] = IslandTechCentreCard.New(arg_9_1)

	return
end

function var_0_0.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.cards[arg_10_2]

	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)

		var_10_0 = arg_10_0.cards[arg_10_2]
	end

	local var_10_1 = arg_10_1 + 1
	local var_10_2 = arg_10_0.levels[arg_10_1 + 1]
	local var_10_3 = arg_10_0.level2Ids[arg_10_0.levels[arg_10_1 + 1]]

	if arg_10_0.levels[arg_10_1] then
		local var_10_4 = arg_10_0.level2Ids[arg_10_0.levels[arg_10_1]]
		local var_10_5

		if not arg_10_0.level2Ids[arg_10_0.levels[arg_10_1]] then
			var_10_4 = {}
			var_10_5 = var_10_1 == #arg_10_0.levels
		end

		var_10_0:Update(var_10_2, var_10_3, var_10_5, var_10_2 > arg_10_0.islandLevel or arg_10_0:IsAnyUnFinish(var_10_4), arg_10_0.contextData.onItemClick)

		return
	end
end

function var_0_0.IsAnyUnFinish(arg_11_0, arg_11_1)
	return underscore.any(arg_11_1, function(arg_12_0)
		return not arg_11_0.techAgency:IsFinishedTech(arg_12_0)
	end)
end

function var_0_0.Show(arg_13_0)
	arg_13_0.super.Show(arg_13_0)
	arg_13_0:Flush()
	arg_13_0:AutoFocus()

	return
end

function var_0_0.Flush(arg_14_0)
	local var_14_0 = getProxy(IslandProxy):GetIsland()

	arg_14_0.islandLevel = var_14_0:GetLevel()
	arg_14_0.techAgency = var_14_0:GetTechnologyAgency()
	arg_14_0.scrollRect.enabled = true

	arg_14_0.scrollRect:SetTotalCount(#arg_14_0.levels, 0)

	return
end

function var_0_0.AutoFocus(arg_15_0)
	arg_15_0.scrollRect:ScrollTo(math.max(table.indexof(arg_15_0.levels, arg_15_0.config[arg_15_0:GetFocusTechId()].island_level) - 4, 0) / (#arg_15_0.levels - 7))

	return
end

function var_0_0.GetFocusTechId(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.allIds) do
		local var_16_0 = arg_16_0.techAgency:GetTechnology(iter_16_1):GetStatus()

		if not ({})[var_16_0] then
			({})[var_16_0] = {}
		end

		table.insert(({})[var_16_0], iter_16_1)
	end

	for iter_16_2, iter_16_3 in ipairs(IslandTechTreePanel.FocusPriorities) do
		if ({})[iter_16_3] and #({})[iter_16_3] > 0 then
			table.sort(({})[iter_16_3], CompareFuncs({
				function(arg_17_0)
					return arg_16_0.config[arg_17_0].island_level
				end,
				function(arg_18_0)
					return arg_18_0
				end
			}))

			return ({})[iter_16_3][1]
		end
	end

	return arg_16_0.allIds[1]
end

function var_0_0.OnDestroy(arg_19_0)
	ClearLScrollrect(arg_19_0.scrollRect)

	for iter_19_0, iter_19_1 in pairs(arg_19_0.cards) do
		iter_19_1:Dispose()
	end

	arg_19_0.cards = {}

	return
end

return var_0_0
