local IslandTechCentrePanel = class("IslandTechCentrePanel", import("view.base.BaseSubView"))

function IslandTechCentrePanel:getUIName()
	return "IslandTechCentrePanel"
end

function IslandTechCentrePanel:OnLoaded()
	self.viewTF = self._tf:Find("view")
	self.scrollRect = self.viewTF:Find("content"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function IslandTechCentrePanel:OnInit()
	self:InifConfigData()

	self.cards = {}

	return
end

function IslandTechCentrePanel:InifConfigData()
	self.config = pg.island_technology_template
	self.level2Ids = {}
	self.levels = {}
	self.allIds = self.config.get_id_list_by_tech_belong[IslandTechBelong.CENTRE]

	for iter_6_0, iter_6_1 in ipairs(self.allIds) do
		if not self.level2Ids[self.config[iter_6_1].island_level] then
			self.level2Ids[self.config[iter_6_1].island_level] = {}

			table.insert(self.levels, self.config[iter_6_1].island_level)
		end

		table.insert(self.level2Ids[self.config[iter_6_1].island_level], iter_6_1)
	end

	for iter_6_2, iter_6_3 in pairs(self.level2Ids) do
		table.sort(iter_6_3, CompareFuncs({
			function(arg_7_0)
				return self.config[arg_7_0].axis[2]
			end,
			function(arg_8_0)
				return arg_8_0
			end
		}))
	end

	table.sort(self.levels)

	self.level2UIList = {}

	return
end

function IslandTechCentrePanel:OnInitItem(arg_9_1)
	self.cards[arg_9_1] = IslandTechCentreCard.New(arg_9_1)

	return
end

function IslandTechCentrePanel:OnUpdateItem(arg_10_1, arg_10_2)
	local var_10_0 = self.cards[arg_10_2]

	if not self.cards[arg_10_2] then
		self:OnInitItem(arg_10_2)

		var_10_0 = self.cards[arg_10_2]
	end

	local var_10_1 = self.levels[arg_10_1 + 1]
	local var_10_2

	if self.levels[arg_10_1] then
		var_10_2 = self.level2Ids[self.levels[arg_10_1]]

		local var_10_3

		if not self.level2Ids[self.levels[arg_10_1]] then
			var_10_2 = {}
			var_10_3 = arg_10_1 + 1 == #self.levels
		end
	end

	var_10_0:Update(var_10_1, self.level2Ids[self.levels[arg_10_1 + 1]], var_10_3, var_10_1 > self.islandLevel or self:IsAnyUnFinish(var_10_2), self.contextData.onItemClick)

	return
end

function IslandTechCentrePanel:IsAnyUnFinish(arg_11_1)
	return underscore.any(arg_11_1, function(arg_12_0)
		return not self.techAgency:IsFinishedTech(arg_12_0)
	end)
end

function IslandTechCentrePanel:Show()
	self.super.Show(self)
	self:Flush()
	self:AutoFocus()

	return
end

function IslandTechCentrePanel:Flush()
	local var_14_0 = getProxy(IslandProxy):GetIsland()

	self.islandLevel = var_14_0:GetLevel()
	self.techAgency = var_14_0:GetTechnologyAgency()
	self.scrollRect.enabled = true

	self.scrollRect:SetTotalCount(#self.levels, 0)

	return
end

function IslandTechCentrePanel:AutoFocus()
	self.scrollRect:ScrollTo(math.max(table.indexof(self.levels, self.config[self:GetFocusTechId()].island_level) - 4, 0) / (#self.levels - 7))

	return
end

function IslandTechCentrePanel:GetFocusTechId()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self.allIds) do
		local var_16_1 = self.techAgency:GetTechnology(iter_16_1):GetStatus()

		var_16_0[var_16_1] = var_16_0[var_16_1] or {}

		table.insert(var_16_0[var_16_1], iter_16_1)
	end

	for iter_16_2, iter_16_3 in ipairs(IslandTechTreePanel.FocusPriorities) do
		if var_16_0[iter_16_3] and #var_16_0[iter_16_3] > 0 then
			table.sort(var_16_0[iter_16_3], CompareFuncs({
				function(arg_17_0)
					return self.config[arg_17_0].island_level
				end,
				function(arg_18_0)
					return arg_18_0
				end
			}))

			return var_16_0[iter_16_3][1]
		end
	end

	return self.allIds[1]
end

function IslandTechCentrePanel:OnDestroy()
	ClearLScrollrect(self.scrollRect)

	for iter_19_0, iter_19_1 in pairs(self.cards) do
		iter_19_1:Dispose()
	end

	self.cards = {}

	return
end

return IslandTechCentrePanel
