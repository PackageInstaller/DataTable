local var_0_0 = class("EducateScheduleFilterLayer", import(".base.EducateBaseUI"))

var_0_0.FILTER_CONFIG = {
	{
		tag = "typeIndex",
		dropdown = false,
		title = i18n("child_filter_type1"),
		options = (function(arg_1_0)
			local var_1_0 = Clone(arg_1_0)

			table.remove(var_1_0, 1)

			return var_1_0
		end)(EducatePlanIndexConst.TypeIndexs),
		names = (function(arg_1_0)
			local var_1_0 = Clone(arg_1_0)

			table.remove(var_1_0, 1)

			return var_1_0
		end)(EducatePlanIndexConst.TypeNames),
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
		options = (function(arg_1_0)
			local var_1_0 = Clone(arg_1_0)

			table.remove(var_1_0, 1)

			return var_1_0
		end)(EducatePlanIndexConst.CostIndexs),
		names = (function(arg_1_0)
			local var_1_0 = Clone(arg_1_0)

			table.remove(var_1_0, 1)

			return var_1_0
		end)(EducatePlanIndexConst.CostNames),
		default = EducatePlanIndexConst.CostAll
	}
}

function var_0_0.getUIName(arg_2_0)
	return "EducateScheduleIndexUI"
end

function var_0_0.init(arg_3_0)
	arg_3_0.anim = arg_3_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_3_0.animEvent = arg_3_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_3_0.animEvent:SetEndEvent(function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_3_0.windowTF = arg_3_0._tf:Find("anim_root/window")

	setText(arg_3_0.windowTF:Find("top/title"), i18n("child_filter_title"))

	arg_3_0.filterContainer = arg_3_0.windowTF:Find("frame/filter_content")
	arg_3_0.filterTpl = arg_3_0._tf:Find("anim_root/filter_tpl")
	arg_3_0.itemTpl = arg_3_0._tf:Find("anim_root/item_tpl")

	setActive(arg_3_0.filterTpl, false)
	setActive(arg_3_0.itemTpl, false)

	arg_3_0.dropdownPanel = arg_3_0._tf:Find("anim_root/dropdown_panel")
	arg_3_0.dropdownUIList = UIItemList.New(arg_3_0.dropdownPanel:Find("dropdown/list"), arg_3_0.dropdownPanel:Find("dropdown/list/tpl"))

	setActive(arg_3_0.dropdownPanel, false)
	setText(arg_3_0.windowTF:Find("sure_btn/Text"), i18n("word_ok"))
	setText(arg_3_0.windowTF:Find("reset_btn/Text"), i18n("word_reset"))

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0.windowTF:Find("sure_btn"), function()
		if arg_5_0.contextData.callback then
			arg_5_0.contextData.callback(arg_5_0.contextData.indexDatas)

			arg_5_0.contextData.callback = nil
		end

		arg_5_0:_close()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.windowTF:Find("reset_btn"), function()
		arg_5_0.contextData.indexDatas = nil

		removeAllChildren(arg_5_0.filterContainer)
		arg_5_0:initFilters()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.dropdownPanel, function()
		arg_5_0:closeDropdownPanel()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("anim_root/bg"), function()
		arg_5_0:_close()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.windowTF:Find("top/close_btn"), function()
		arg_5_0:_close()

		return
	end, SFX_PANEL)
	arg_5_0:initDropdownPanel()
	arg_5_0:initFilters()
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1
	})

	return
end

function var_0_0.initDropdownPanel(arg_11_0)
	arg_11_0.dropdownUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = arg_11_0.dropdownCfg.names[arg_11_0.dropdownCfgIndex][arg_12_1 + 1 + 1]
			local var_12_1 = arg_11_0.dropdownCfg.options[arg_11_0.dropdownCfgIndex][arg_12_1 + 1 + 1]
			local var_12_2 = arg_11_0.dropdownCfg.tags[arg_11_0.dropdownCfgIndex]
			local var_12_3 = arg_11_0.dropdownCfg.defaults[arg_11_0.dropdownCfgIndex]

			setActive(arg_12_2:Find("line"), arg_12_1 + 1 + 1 ~= #arg_11_0.dropdownCfg.options[arg_11_0.dropdownCfgIndex])
			setText(arg_12_2:Find("Text"), var_12_0)
			onButton(arg_11_0, arg_12_2, function()
				arg_11_0.contextData.indexDatas[var_12_2] = arg_11_0.contextData.indexDatas[var_12_2] == var_12_1 and var_12_3 or var_12_1

				arg_11_0:closeDropdownPanel()
				arg_11_0.uiList[arg_11_0.updateListIndex]:align(#arg_11_0.dropdownCfg.options)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.initFilters(arg_14_0)
	arg_14_0.contextData.indexDatas = arg_14_0.contextData.indexDatas or {}
	arg_14_0.uiList = {}

	for iter_14_0, iter_14_1 in ipairs(var_0_0.FILTER_CONFIG) do
		local var_14_0 = cloneTplTo(arg_14_0.filterTpl, arg_14_0.filterContainer)

		setText(var_14_0:Find("title/title"), iter_14_1.title)

		if not iter_14_1.dropdown then
			arg_14_0:initNormal(iter_14_0, iter_14_1, var_14_0)
		else
			arg_14_0:initDropdown(iter_14_0, iter_14_1, var_14_0)
		end
	end

	return
end

function var_0_0.initNormal(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = UIItemList.New(arg_15_3:Find("content/container"), arg_15_0.itemTpl)

	var_15_0:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventInit then
			local var_16_0 = arg_16_1 + 1
			local var_16_1 = arg_15_2.options[arg_16_1 + 1]

			setText(arg_16_2:Find("Text"), arg_15_2.names[arg_16_1 + 1])
			setActive(arg_16_2:Find("line"), var_16_0 ~= #arg_15_2.names)
			setActive(arg_16_2:Find("arrow"), false)

			arg_15_0.contextData.indexDatas[arg_15_2.tag] = arg_15_0.contextData.indexDatas[arg_15_2.tag] or arg_15_2.default

			onButton(arg_15_0, arg_16_2, function()
				arg_15_0.contextData.indexDatas[arg_15_2.tag] = arg_15_0.contextData.indexDatas[arg_15_2.tag] == arg_15_2.default and var_16_1 or bit.bxor(arg_15_0.contextData.indexDatas[arg_15_2.tag], var_16_1)

				if arg_15_0.contextData.indexDatas[arg_15_2.tag] == 0 then
					arg_15_0.contextData.indexDatas[arg_15_2.tag] = arg_15_2.default
				end

				var_15_0:align(#arg_15_2.options)

				return
			end, SFX_PANEL)

			goto label_16_0
		end

		::label_16_0::

		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_2 = (arg_15_0.contextData.indexDatas[arg_15_2.tag] ~= arg_15_2.default or false) and bit.band(arg_15_0.contextData.indexDatas[arg_15_2.tag], arg_15_2.options[arg_16_1 + 1]) > 0

			setActive(arg_16_2:Find("selected"), nil)

			local var_16_5 = arg_16_2:Find("Text")

			if var_16_2 then
				do
					local var_16_6 = Color.white or Color.NewHex("393a3c")

					var_16_4(var_16_5, var_16_6)
				end

				return
			end
		end
	end)
	var_15_0:align(#arg_15_2.options)

	arg_15_0.uiList[arg_15_1] = var_15_0

	return
end

function var_0_0.initDropdown(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = UIItemList.New(arg_18_3:Find("content/container"), arg_18_0.itemTpl)

	var_18_0:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventInit then
			local var_19_0 = arg_18_2.tags[arg_19_1 + 1]
			local var_19_1 = arg_18_2.defaults[arg_19_1 + 1]

			setActive(arg_19_2:Find("line"), arg_19_1 + 1 ~= #arg_18_2.tags)
			setActive(arg_19_2:Find("arrow"), true)

			arg_18_0.contextData.indexDatas[var_19_0] = arg_18_0.contextData.indexDatas[var_19_0] or var_19_1

			onButton(arg_18_0, arg_19_2, function()
				arg_18_0.dropdownCfg = arg_18_2
				arg_18_0.dropdownCfgIndex = var_0
				arg_18_0.updateListIndex = arg_18_1

				arg_18_0:showDropdownPanel((arg_18_0._tf:InverseTransformPoint(arg_19_2.position)))

				return
			end, SFX_PANEL)

			goto label_19_0
		end

		::label_19_0::

		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_2 = ""
			local var_19_3 = true

			if arg_18_0.contextData.indexDatas[arg_18_2.tags[arg_19_1 + 1]] == arg_18_2.defaults[arg_19_1 + 1] then
				var_19_3 = false
				var_19_2 = arg_18_2.names[arg_19_1 + 1][1]
			else
				for iter_19_0, iter_19_1 in ipairs(arg_18_2.options[arg_19_1 + 1]) do
					if arg_18_0.contextData.indexDatas[arg_18_2.tags[arg_19_1 + 1]] == iter_19_1 then
						var_19_2 = arg_18_2.names[arg_19_1 + 1][iter_19_0]

						break
					end
				end
			end

			setText(arg_19_2:Find("Text"), var_19_2)
			setActive(arg_19_2:Find("selected"), var_19_3)

			local var_19_5 = arg_19_2:Find("Text")

			if var_19_3 then
				local var_19_6 = Color.white or Color.NewHex("393a3c")

				var_19_4(var_19_5, var_19_6)

				local var_19_8 = arg_19_2:Find("arrow")

				if var_19_3 then
					do
						local var_19_9 = Color.white or Color.NewHex("393a3c")

						var_19_7(var_19_8, var_19_9)
					end

					return
				end
			end
		end
	end)
	var_18_0:align(#arg_18_2.options)

	arg_18_0.uiList[arg_18_1] = var_18_0

	return
end

function var_0_0.showDropdownPanel(arg_21_0, arg_21_1)
	setAnchoredPosition(arg_21_0.dropdownPanel:Find("dropdown"), arg_21_1)
	setActive(arg_21_0.dropdownPanel, true)
	arg_21_0.dropdownUIList:align(#arg_21_0.dropdownCfg.options[arg_21_0.dropdownCfgIndex] - 1)

	return
end

function var_0_0.closeDropdownPanel(arg_22_0)
	setActive(arg_22_0.dropdownPanel, false)

	return
end

function var_0_0._close(arg_23_0)
	arg_23_0.anim:Play("anim_educate_scheduleindex_out")

	return
end

function var_0_0.onBackPressed(arg_24_0)
	arg_24_0:_close()

	return
end

function var_0_0.willExit(arg_25_0)
	arg_25_0.animEvent:SetEndEvent(nil)
	arg_25_0:UnOverlayPanel(arg_25_0._tf)

	return
end

return var_0_0
