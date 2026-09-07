local EducateScheduleFilterLayer = class("EducateScheduleFilterLayer", import(".base.EducateBaseUI"))

local function var_0_1(arg_1_0)
	local var_1_0 = Clone(arg_1_0)

	table.remove(var_1_0, 1)

	return var_1_0
end

EducateScheduleFilterLayer.FILTER_CONFIG = {
	{
		tag = "typeIndex",
		dropdown = false,
		title = i18n("child_filter_type1"),
		options = var_0_1(EducatePlanIndexConst.TypeIndexs),
		names = var_0_1(EducatePlanIndexConst.TypeNames),
		default = EducatePlanIndexConst.TypeAll
	},
	{
		dropdown = true,
		title = i18n("child_filter_type2"),
		options = {
			EducatePlanIndexConst.AwardResIndexs,
			EducatePlanIndexConst.AwardNatureIndexs,
			EducatePlanIndexConst.AwardAttr1Indexs,
			EducatePlanIndexConst.AwardAttr2Indexs
		},
		names = {
			EducatePlanIndexConst.AwardResNames,
			EducatePlanIndexConst.AwardNatureNames,
			EducatePlanIndexConst.AwardAttr1Names,
			EducatePlanIndexConst.AwardAttr2Names
		},
		tags = {
			"awardResIndex",
			"awardNatureIndex",
			"awardAttr1Index",
			"awardAttr2Index"
		},
		defaults = {
			EducatePlanIndexConst.AwardResAll,
			EducatePlanIndexConst.AwardNatureAll,
			EducatePlanIndexConst.AwardAttr1All,
			EducatePlanIndexConst.AwardAttr2All
		}
	},
	{
		tag = "costIndex",
		dropdown = false,
		title = i18n("child_filter_type3"),
		options = var_0_1(EducatePlanIndexConst.CostIndexs),
		names = var_0_1(EducatePlanIndexConst.CostNames),
		default = EducatePlanIndexConst.CostAll
	}
}

function EducateScheduleFilterLayer:getUIName()
	return "EducateScheduleIndexUI"
end

function EducateScheduleFilterLayer:init()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateScheduleFilterLayer.ON_CLOSE)

		return
	end)

	self.windowTF = self._tf:Find("anim_root/window")

	setText(self.windowTF:Find("top/title"), i18n("child_filter_title"))

	self.filterContainer = self.windowTF:Find("frame/filter_content")
	self.filterTpl = self._tf:Find("anim_root/filter_tpl")
	self.itemTpl = self._tf:Find("anim_root/item_tpl")

	setActive(self.filterTpl, false)
	setActive(self.itemTpl, false)

	self.dropdownPanel = self._tf:Find("anim_root/dropdown_panel")
	self.dropdownUIList = UIItemList.New(self.dropdownPanel:Find("dropdown/list"), self.dropdownPanel:Find("dropdown/list/tpl"))

	setActive(self.dropdownPanel, false)
	setText(self.windowTF:Find("sure_btn/Text"), i18n("word_ok"))
	setText(self.windowTF:Find("reset_btn/Text"), i18n("word_reset"))

	return
end

function EducateScheduleFilterLayer:didEnter()
	onButton(self, self.windowTF:Find("sure_btn"), function()
		if self.contextData.callback then
			self.contextData.callback(self.contextData.indexDatas)

			self.contextData.callback = nil
		end

		self:_close()

		return
	end, SFX_PANEL)
	onButton(self, self.windowTF:Find("reset_btn"), function()
		self.contextData.indexDatas = nil

		removeAllChildren(self.filterContainer)
		self:initFilters()

		return
	end, SFX_PANEL)
	onButton(self, self.dropdownPanel, function()
		self:closeDropdownPanel()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("anim_root/bg"), function()
		self:_close()

		return
	end, SFX_PANEL)
	onButton(self, self.windowTF:Find("top/close_btn"), function()
		self:_close()

		return
	end, SFX_PANEL)
	self:initDropdownPanel()
	self:initFilters()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})

	return
end

function EducateScheduleFilterLayer:initDropdownPanel()
	self.dropdownUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = self.dropdownCfg.names[self.dropdownCfgIndex][arg_12_1 + 1 + 1]
			local var_12_1 = self.dropdownCfg.options[self.dropdownCfgIndex][arg_12_1 + 1 + 1]
			local var_12_2 = self.dropdownCfg.tags[self.dropdownCfgIndex]
			local var_12_3 = self.dropdownCfg.defaults[self.dropdownCfgIndex]

			setActive(arg_12_2:Find("line"), arg_12_1 + 1 + 1 ~= #self.dropdownCfg.options[self.dropdownCfgIndex])
			setText(arg_12_2:Find("Text"), var_12_0)
			onButton(self, arg_12_2, function()
				self.contextData.indexDatas[var_12_2] = self.contextData.indexDatas[var_12_2] == var_12_1 and var_12_3 or var_12_1

				self:closeDropdownPanel()
				self.uiList[self.updateListIndex]:align(#self.dropdownCfg.options)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function EducateScheduleFilterLayer:initFilters()
	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.uiList = {}

	for iter_14_0, iter_14_1 in ipairs(EducateScheduleFilterLayer.FILTER_CONFIG) do
		local var_14_0 = cloneTplTo(self.filterTpl, self.filterContainer)

		setText(var_14_0:Find("title/title"), iter_14_1.title)

		if not iter_14_1.dropdown then
			self:initNormal(iter_14_0, iter_14_1, var_14_0)
		else
			self:initDropdown(iter_14_0, iter_14_1, var_14_0)
		end
	end

	return
end

function EducateScheduleFilterLayer:initNormal(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = UIItemList.New(arg_15_3:Find("content/container"), self.itemTpl)

	var_15_0:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventInit then
			local var_16_0 = arg_16_1 + 1
			local var_16_1 = arg_15_2.options[arg_16_1 + 1]

			setText(arg_16_2:Find("Text"), arg_15_2.names[arg_16_1 + 1])
			setActive(arg_16_2:Find("line"), var_16_0 ~= #arg_15_2.names)
			setActive(arg_16_2:Find("arrow"), false)

			self.contextData.indexDatas[arg_15_2.tag] = self.contextData.indexDatas[arg_15_2.tag] or arg_15_2.default

			onButton(self, arg_16_2, function()
				self.contextData.indexDatas[arg_15_2.tag] = self.contextData.indexDatas[arg_15_2.tag] == arg_15_2.default and var_16_1 or bit.bxor(self.contextData.indexDatas[arg_15_2.tag], var_16_1)

				if self.contextData.indexDatas[arg_15_2.tag] == 0 then
					self.contextData.indexDatas[arg_15_2.tag] = arg_15_2.default
				end

				var_15_0:align(#arg_15_2.options)

				return
			end, SFX_PANEL)
		elseif arg_16_0 == UIItemList.EventUpdate then
			local var_16_2 = (self.contextData.indexDatas[arg_15_2.tag] ~= arg_15_2.default or false) and bit.band(self.contextData.indexDatas[arg_15_2.tag], arg_15_2.options[arg_16_1 + 1]) > 0

			setActive(arg_16_2:Find("selected"), nil)
			setTextColor(arg_16_2:Find("Text"), (var_16_2 or nil) and (Color.white or Color.NewHex("393a3c")))
		end

		return
	end)
	var_15_0:align(#arg_15_2.options)

	self.uiList[arg_15_1] = var_15_0

	return
end

function EducateScheduleFilterLayer:initDropdown(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = UIItemList.New(arg_18_3:Find("content/container"), self.itemTpl)

	var_18_0:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventInit then
			local var_19_0 = arg_19_1 + 1
			local var_19_1 = arg_18_2.tags[arg_19_1 + 1]
			local var_19_2 = arg_18_2.defaults[arg_19_1 + 1]

			setActive(arg_19_2:Find("line"), arg_19_1 + 1 ~= #arg_18_2.tags)
			setActive(arg_19_2:Find("arrow"), true)

			self.contextData.indexDatas[var_19_1] = self.contextData.indexDatas[var_19_1] or var_19_2

			onButton(self, arg_19_2, function()
				self.dropdownCfg = arg_18_2
				self.dropdownCfgIndex = var_19_0
				self.updateListIndex = arg_18_1

				self:showDropdownPanel((self._tf:InverseTransformPoint(arg_19_2.position)))

				return
			end, SFX_PANEL)
		elseif arg_19_0 == UIItemList.EventUpdate then
			local var_19_3 = ""
			local var_19_4 = true

			if self.contextData.indexDatas[arg_18_2.tags[arg_19_1 + 1]] == arg_18_2.defaults[arg_19_1 + 1] then
				var_19_4 = false
				var_19_3 = arg_18_2.names[arg_19_1 + 1][1]
			else
				for iter_19_0, iter_19_1 in ipairs(arg_18_2.options[arg_19_1 + 1]) do
					if self.contextData.indexDatas[arg_18_2.tags[arg_19_1 + 1]] == iter_19_1 then
						var_19_3 = arg_18_2.names[arg_19_1 + 1][iter_19_0]

						break
					end
				end
			end

			setText(arg_19_2:Find("Text"), var_19_3)
			setActive(arg_19_2:Find("selected"), var_19_4)
			setTextColor(arg_19_2:Find("Text"), (var_19_4 or nil) and (Color.white or Color.NewHex("393a3c")))
			setImageColor(arg_19_2:Find("arrow"), (var_19_4 or nil) and (Color.white or Color.NewHex("393a3c")))
		end

		return
	end)
	var_18_0:align(#arg_18_2.options)

	self.uiList[arg_18_1] = var_18_0

	return
end

function EducateScheduleFilterLayer:showDropdownPanel(arg_21_1)
	setAnchoredPosition(self.dropdownPanel:Find("dropdown"), arg_21_1)
	setActive(self.dropdownPanel, true)
	self.dropdownUIList:align(#self.dropdownCfg.options[self.dropdownCfgIndex] - 1)

	return
end

function EducateScheduleFilterLayer:closeDropdownPanel()
	setActive(self.dropdownPanel, false)

	return
end

function EducateScheduleFilterLayer:_close()
	self.anim:Play("anim_educate_scheduleindex_out")

	return
end

function EducateScheduleFilterLayer:onBackPressed()
	self:_close()

	return
end

function EducateScheduleFilterLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return EducateScheduleFilterLayer
