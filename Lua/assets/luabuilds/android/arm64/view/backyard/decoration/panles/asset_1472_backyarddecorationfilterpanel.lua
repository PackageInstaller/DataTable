local BackYardDecorationFilterPanel = class("BackYardDecorationFilterPanel", import("....base.BaseSubView"))

BackYardDecorationFilterPanel.SORT_MODE = {
	BY_FUNC = 2,
	BY_CONFIG = 3,
	BY_DEFAULT = 1
}
BackYardDecorationFilterPanel.SORT_TAG = {
	{
		{
			1,
			"default"
		},
		i18n("backyard_sort_tag_default")
	},
	{
		{
			2,
			"sortPriceFunc"
		},
		i18n("backyard_sort_tag_price")
	},
	{
		{
			3,
			"comfortable"
		},
		i18n("backyard_sort_tag_comfortable")
	},
	{
		{
			2,
			"sortSizeFunc"
		},
		i18n("backyard_sort_tag_size")
	}
}
BackYardDecorationFilterPanel.ORDER_MODE_ASC = 1
BackYardDecorationFilterPanel.ORDER_MODE_DASC = 2

function BackYardDecorationFilterPanel:getUIName()
	return "BackYardIndexUI"
end

function BackYardDecorationFilterPanel:Ctor(arg_2_1, arg_2_2, arg_2_3)
	BackYardDecorationFilterPanel.super.Ctor(self, arg_2_1, arg_2_2, arg_2_3)

	self.filterConfig = pg.backyard_theme_template
	self.sortData = BackYardDecorationFilterPanel.SORT_TAG[1][1]
	self.sortTxt = BackYardDecorationFilterPanel.SORT_TAG[1][2]
	self.filterData = _.select(self.filterConfig.all, function(arg_3_0)
		return self.filterConfig[arg_3_0].is_view == 1
	end)
	self.totalThemeCnt = #self.filterData
	self.themes = pg.furniture_data_template.get_id_list_by_themeId

	return
end

function BackYardDecorationFilterPanel:OnLoaded()
	self.sortTpl = self._tf:Find("bg/sort_tpl")
	self.filterTpl = self._tf:Find("bg/filter_tpl")
	self.sortContainer = self._tf:Find("bg/frame/sorts/sort_container")
	self.filterContainer = self._tf:Find("bg/frame/filters/rect_view/conent/theme_panel")
	self.selectedAllBtn = self._tf:Find("bg/frame/filters/rect_view/conent/all_panel/sort_tpl")
	self.close = self._tf:Find("bg/close")

	setText(self._tf:Find("bg/frame/title"), i18n("indexsort_sort"))
	setText(self._tf:Find("bg/frame/title_filter"), i18n("indexsort_index"))
	setText(self.selectedAllBtn:Find("Text"), i18n("index_all"))
	setText(self._tf:Find("bg/frame/confirm_btn/Text"), i18n("word_ok"))
	setText(self._tf:Find("bg/title"), i18n("courtyard_label_filter"))

	return
end

function BackYardDecorationFilterPanel:setFilterData(arg_5_1)
	self.furnitures = arg_5_1 or {}

	return
end

function BackYardDecorationFilterPanel:GetFilterData()
	return self.furnitures
end

function BackYardDecorationFilterPanel:SetDorm(arg_7_1)
	self.dorm = arg_7_1

	return
end

function BackYardDecorationFilterPanel:updateOrderMode(arg_8_1)
	self.orderMode = arg_8_1 or BackYardDecorationFilterPanel.ORDER_MODE_ASC

	return
end

function BackYardDecorationFilterPanel:OnInit()
	onButton(self, self._tf:Find("bg/frame/confirm_btn"), function()
		self:filter()
		self:Hide()

		if self.confirmFunc then
			self.confirmFunc()
		end

		return
	end, SFX_PANEL)
	onButton(self, self._go, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.close, function()
		self:Hide()

		return
	end, SFX_PANEL)
	self:initSortPanel()
	self:initFilterPanel()
	triggerToggle(self.selectedAllBtn, true)
	triggerToggle(self.sortBtns[1], true)

	return
end

function BackYardDecorationFilterPanel:initSortPanel()
	self.sortBtns = {}

	for iter_13_0, iter_13_1 in pairs(BackYardDecorationFilterPanel.SORT_TAG) do
		local var_13_0 = cloneTplTo(self.sortTpl, self.sortContainer)

		setText(var_13_0:Find("Text"), iter_13_1[2])

		self.sortBtns[iter_13_0] = var_13_0

		self:onSwitch(var_13_0, function(arg_14_0)
			if arg_14_0 then
				self.sortData = iter_13_1[1]
				self.sortTxt = iter_13_1[2]
			end

			return
		end)
	end

	return
end

function BackYardDecorationFilterPanel:onSwitch(arg_15_1, arg_15_2)
	onToggle(self, arg_15_1, function(arg_16_0)
		arg_15_1:Find("Text"):GetComponent(typeof(Text)).color = arg_16_0 and Color.New(1, 1, 1, 1) or Color.New(0.2235294, 0.227451, 0.2352941, 1)

		arg_15_2(arg_16_0)

		return
	end, SFX_PANEL)

	return
end

function BackYardDecorationFilterPanel:initFilterPanel()
	self.filterBtns = {}

	local var_17_0 = Clone(self.filterConfig.all)

	table.sort(var_17_0, function(arg_18_0, arg_18_1)
		return self.filterConfig[arg_18_0].order < self.filterConfig[arg_18_1].order
	end)

	local var_17_1 = 0

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if self.filterConfig[iter_17_1].is_view == 1 then
			var_17_1 = var_17_1 + 1

			local var_17_2 = cloneTplTo(self.filterTpl, self.filterContainer)

			setText(var_17_2:Find("Text"), self.filterConfig[iter_17_1].name)

			self.filterBtns[iter_17_1] = var_17_2

			self:onSwitch(var_17_2, function(arg_19_0)
				if arg_19_0 then
					table.insert(self.filterData, iter_17_1)
					triggerToggle(self.selectedAllBtn, self:isSelectedAll())
				else
					self.filterData = _.reject(self.filterData, function(arg_20_0)
						return iter_17_1 == arg_20_0
					end)

					if self:isSelectedNone() then
						triggerToggle(self.selectedAllBtn, true)

						self.selectedAllBtn:Find("Text"):GetComponent(typeof(Text)).color = Color.New(1, 1, 1, 1)
					end
				end

				return
			end)
			setActive(var_17_2:Find("line"), var_17_1 % 4 ~= 0)
		end
	end

	self.otherTF = cloneTplTo(self.filterTpl, self.filterContainer)

	setText(self.otherTF:Find("Text"), i18n("backyard_filter_tag_other"))

	self.otherTFToggle = self.otherTF:GetComponent(typeof(Toggle))
	self.selectedOther = false

	self:onSwitch(self.otherTF, function(arg_21_0)
		self.selectedOther = arg_21_0

		if arg_21_0 then
			triggerToggle(self.selectedAllBtn, self:isSelectedAll())
		elseif self:isSelectedNone() then
			triggerToggle(self.selectedAllBtn, true)

			self.selectedAllBtn:Find("Text"):GetComponent(typeof(Text)).color = Color.New(0.2235294, 0.227451, 0.2352941, 1)
		end

		return
	end)
	onToggle(self, self.selectedAllBtn, function(arg_22_0)
		if self:isSelectedNone() then
			return
		end

		if arg_22_0 then
			_.each(self.filterData, function(arg_23_0)
				triggerToggle(self.filterBtns[arg_23_0], false)

				return
			end)

			self.filterData = {}

			triggerToggle(self.otherTF, false)

			self.selectedOther = false
		end

		self.selectedAllBtn:Find("Text"):GetComponent(typeof(Text)).color = arg_22_0 and Color.New(1, 1, 1, 1) or Color.New(0.2235294, 0.227451, 0.2352941, 1)

		return
	end, SFX_PANEL)

	return
end

function BackYardDecorationFilterPanel:isSelectedAll()
	return _.all(_.select(self.filterConfig.all, function(arg_25_0)
		return self.filterConfig[arg_25_0].is_view == 1
	end), function(arg_26_0)
		return table.contains(self.filterData, arg_26_0)
	end) and self.otherTFToggle.isOn == true or self:isSelectedNone()
end

function BackYardDecorationFilterPanel:isSelectedNone()
	return #self.filterData == 0 and self.otherTFToggle.isOn == false
end

function BackYardDecorationFilterPanel:filter()
	if table.getCount(self.furnitures) == 0 then
		return
	end

	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(self.filterData) do
		for iter_28_2, iter_28_3 in ipairs(self.themes[iter_28_1] or {}) do
			table.insert(var_28_0, iter_28_3)
		end
	end

	local function var_28_2(arg_29_0)
		local var_29_0 = arg_29_0:getConfig("themeId") == 0
		local var_29_1 = self.selectedOther and var_29_0

		if #self.filterData == self.totalThemeCnt and var_29_0 then
			return false
		end

		if var_29_1 then
			return false
		end

		return not table.contains(var_28_0, arg_29_0.id)
	end

	if #var_28_0 ~= 0 or not not self.selectedOther then
		for iter_28_4 = #self.furnitures, 1, -1 do
			if var_28_2(self.furnitures[iter_28_4]) then
				table.remove(self.furnitures, iter_28_4)
			end
		end
	end

	self:sort(self.furnitures)

	return
end

function BackYardDecorationFilterPanel:SORT_BY_FUNC(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	if self[arg_30_2](self) == arg_30_1[arg_30_2](arg_30_1) then
		return arg_30_4()
	elseif arg_30_3 == BackYardDecorationFilterPanel.ORDER_MODE_ASC then
		return self[arg_30_2](self) < arg_30_1[arg_30_2](arg_30_1)
	else
		return self[arg_30_2](self) > arg_30_1[arg_30_2](arg_30_1)
	end

	return
end

function BackYardDecorationFilterPanel:SORT_BY_CONFIG(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if self:getConfig(arg_31_2) == arg_31_1:getConfig(arg_31_2) then
		return arg_31_4()
	elseif arg_31_3 == BackYardDecorationFilterPanel.ORDER_MODE_ASC then
		return self:getConfig(arg_31_2) < arg_31_1:getConfig(arg_31_2)
	else
		return self:getConfig(arg_31_2) > arg_31_1:getConfig(arg_31_2)
	end

	return
end

function BackYardDecorationFilterPanel:SortForDecorate(arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2[2]
	local var_32_2 = arg_32_2[4]
	local var_32_4 = arg_32_2[6]

	function BackYardDecorationFilterPanel:SortByDefault1(arg_33_1)
		return self.id < arg_33_1.id
	end

	function BackYardDecorationFilterPanel:SortByDefault2(arg_34_1)
		return self.id > arg_34_1.id
	end

	local var_32_5 = (var_32_4[self.configId] or 0) == self.count and 1 or 0
	local var_32_6 = (var_32_4[arg_32_1.configId] or 0) == arg_32_1.count and 1 or 0

	if var_32_5 == ((var_32_4[arg_32_1.configId] or 0) == arg_32_1.count and 1 or 0) then
		if arg_32_2[1] == BackYardDecorationFilterPanel.SORT_MODE.BY_DEFAULT then
			return BackYardDecorationFilterPanel["SortByDefault" .. var_32_2](self, arg_32_1)
		elseif arg_32_2[1] == BackYardDecorationFilterPanel.SORT_MODE.BY_FUNC then
			return BackYardDecorationFilterPanel.SORT_BY_FUNC(self, arg_32_1, var_32_0, var_32_2, function()
				return BackYardDecorationFilterPanel["SortByDefault" .. var_32_2](self, arg_32_1)
			end)
		elseif arg_32_2[1] == BackYardDecorationFilterPanel.SORT_MODE.BY_CONFIG then
			return BackYardDecorationFilterPanel.SORT_BY_CONFIG(self, arg_32_1, var_32_0, var_32_2, function()
				return BackYardDecorationFilterPanel["SortByDefault" .. var_32_2](self, arg_32_1)
			end)
		end
	else
		return var_32_6 < var_32_5
	end

	return
end

function BackYardDecorationFilterPanel:sort(arg_37_1)
	local var_37_0 = self:GetConfigIdAndCntMapInAllFloor(self.dorm)

	table.sort(arg_37_1, function(arg_38_0, arg_38_1)
		return BackYardDecorationFilterPanel.SortForDecorate(arg_38_0, arg_38_1, {
			self.sortData[1],
			self.sortData[2],
			self.dorm,
			self.orderMode,
			{},
			var_37_0
		})
	end)

	self.furnitures = arg_37_1

	return
end

function BackYardDecorationFilterPanel:GetConfigIdAndCntMapInAllFloor(arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(arg_39_1:GetThemeList()) do
		for iter_39_2, iter_39_3 in pairs(iter_39_1:GetAllFurniture()) do
			var_39_0[iter_39_2] = iter_39_3
		end
	end

	local var_39_1 = {}

	for iter_39_4, iter_39_5 in pairs(var_39_0) do
		var_39_1[iter_39_5.configId] = var_39_1[iter_39_5.configId] or 0
		var_39_1[iter_39_5.configId] = var_39_1[iter_39_5.configId] + 1
	end

	return var_39_1
end

function BackYardDecorationFilterPanel:Sort()
	self:sort(self.furnitures)

	return
end

function BackYardDecorationFilterPanel:Show()
	setActive(self._go, true)

	return
end

function BackYardDecorationFilterPanel:Hide()
	setActive(self._go, false)

	if self.onHideFunc then
		self.onHideFunc()
	end

	return
end

function BackYardDecorationFilterPanel:OnDestroy()
	return
end

return BackYardDecorationFilterPanel
