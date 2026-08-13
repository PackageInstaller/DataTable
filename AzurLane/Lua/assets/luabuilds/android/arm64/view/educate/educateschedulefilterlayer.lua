class = var_0_10000

local var_0_0 = "EducateScheduleFilterLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateBaseUI"))

local function var_0_2(arg_1_0)
	Clone = var_1_10001

	local var_1_0 = var_1_10001(arg_1_0)

	table = var_1_10002

	var_1_10002.remove(var_1_0, 1)

	return var_1_0
end

local var_0_3 = {}
local var_0_4 = {
	tag = "typeIndex",
	dropdown = false
}

i18n = var_0_10004
var_0_4.title = var_0_10004("child_filter_type1")

local var_0_5 = var_0_2

EducatePlanIndexConst = var_6
var_0_4.options = var_0_5(var_6.TypeIndexs)

local var_0_6 = var_0_2

EducatePlanIndexConst = var_6
var_0_4.names = var_0_6(var_6.TypeNames)
EducatePlanIndexConst = var_4
var_0_4.default = var_4.TypeAll
var_0_3[1] = var_0_4

local var_0_7 = {
	dropdown = true
}

i18n = var_4
var_0_7.title = var_4("child_filter_type2")

local var_0_8 = {}

EducatePlanIndexConst = var_5
var_0_8[1] = var_5.AwardResIndexs
EducatePlanIndexConst = var_5
var_0_8[2] = var_5.AwardNatureIndexs
EducatePlanIndexConst = var_5
var_0_8[3] = var_5.AwardAttr1Indexs
EducatePlanIndexConst = var_5
var_0_8[4] = var_5.AwardAttr2Indexs
var_0_7.options = var_0_8

local var_0_9 = {}

EducatePlanIndexConst = var_5
var_0_9[1] = var_5.AwardResNames
EducatePlanIndexConst = var_5
var_0_9[2] = var_5.AwardNatureNames
EducatePlanIndexConst = var_5
var_0_9[3] = var_5.AwardAttr1Names
EducatePlanIndexConst = var_5
var_0_9[4] = var_5.AwardAttr2Names
var_0_7.names = var_0_9
var_0_7.tags = {
	"awardResIndex",
	"awardNatureIndex",
	"awardAttr1Index",
	"awardAttr2Index"
}

local var_0_10 = {}

EducatePlanIndexConst = var_5
var_0_10[1] = var_5.AwardResAll
EducatePlanIndexConst = var_5
var_0_10[2] = var_5.AwardNatureAll
EducatePlanIndexConst = var_5
var_0_10[3] = var_5.AwardAttr1All
EducatePlanIndexConst = var_5
var_0_10[4] = var_5.AwardAttr2All
var_0_7.defaults = var_0_10
var_0_3[2] = var_0_7

local var_0_11 = {
	tag = "costIndex",
	dropdown = false
}

i18n = var_0_10
var_0_11.title = var_0_10("child_filter_type3")

local var_0_12 = var_0_2

EducatePlanIndexConst = var_6
var_0_11.options = var_0_12(var_6.CostIndexs)

local var_0_13 = var_0_2

EducatePlanIndexConst = var_6
var_0_11.names = var_0_13(var_6.CostNames)
EducatePlanIndexConst = var_4
var_0_11.default = var_4.CostAll
var_0_3[3] = var_0_11
var_0_1.FILTER_CONFIG = var_0_3

function var_0_1.getUIName(arg_2_0)
	return "EducateScheduleIndexUI"
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "anim_root")
	local var_3_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_3_0.anim = var_3_2(var_3_1, var_4(var_1_10006))

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_1.Find(var_3_3, "anim_root")
	local var_3_5 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_3_0.animEvent = var_3_5(var_3_4, var_4(var_1_10006))

	local var_3_6 = arg_3_0.animEvent

	var_1.SetEndEvent(var_3_6, function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_3_7 = arg_3_0._tf

	arg_3_0.windowTF = var_1.Find(var_3_7, "anim_root/window")
	setText = var_1

	local var_3_8 = arg_3_0.windowTF
	local var_3_9 = var_3.Find(var_3_8, "top/title")

	i18n = var_4

	var_1(var_3_9, var_4("child_filter_title"))

	local var_3_10 = arg_3_0.windowTF

	arg_3_0.filterContainer = var_1.Find(var_3_10, "frame/filter_content")

	local var_3_11 = arg_3_0._tf

	arg_3_0.filterTpl = var_1.Find(var_3_11, "anim_root/filter_tpl")

	local var_3_12 = arg_3_0._tf

	arg_3_0.itemTpl = var_1.Find(var_3_12, "anim_root/item_tpl")
	setActive = var_1

	var_1(arg_3_0.filterTpl, false)

	setActive = var_1

	var_1(arg_3_0.itemTpl, false)

	local var_3_13 = arg_3_0._tf

	arg_3_0.dropdownPanel = var_1.Find(var_3_13, "anim_root/dropdown_panel")
	UIItemList = var_1

	local var_3_14 = var_1.New
	local var_3_15 = arg_3_0.dropdownPanel
	local var_3_16 = var_3.Find(var_3_15, "dropdown/list")
	local var_3_17 = arg_3_0.dropdownPanel

	arg_3_0.dropdownUIList = var_3_14(var_3_16, var_4.Find(var_3_17, "dropdown/list/tpl"))
	setActive = var_1

	var_1(arg_3_0.dropdownPanel, false)

	setText = var_1

	local var_3_18 = arg_3_0.windowTF
	local var_3_19 = var_3.Find(var_3_18, "sure_btn/Text")

	i18n = var_4

	var_1(var_3_19, var_4("word_ok"))

	setText = var_1

	local var_3_20 = arg_3_0.windowTF
	local var_3_21 = var_3.Find(var_3_20, "reset_btn/Text")

	i18n = var_4

	var_1(var_3_21, var_4("word_reset"))

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.windowTF
	local var_5_2 = var_4.Find(var_5_1, "sure_btn")

	local function var_5_3()
		if arg_5_0.contextData.callback then
			arg_5_0.contextData.callback(arg_5_0.contextData.indexDatas)

			arg_5_0.contextData.callback = nil
		end

		local var_6_0 = arg_5_0

		var_0._close(var_6_0)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.windowTF
	local var_5_6 = var_4.Find(var_5_5, "reset_btn")

	local function var_5_7()
		local var_7_0 = arg_5_0.contextData

		var_7_0.indexDatas = nil
		removeAllChildren = var_7_0

		var_7_0(arg_5_0.filterContainer)

		local var_7_1 = arg_5_0

		var_0.initFilters(var_7_1)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.dropdownPanel

	local function var_5_10()
		local var_8_0 = arg_5_0

		var_0.closeDropdownPanel(var_8_0)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_8, var_5_9, var_5_10, var_5_5)

	onButton = var_1_10001

	local var_5_11 = arg_5_0
	local var_5_12 = arg_5_0._tf
	local var_5_13 = var_4.Find(var_5_12, "anim_root/bg")

	local function var_5_14()
		local var_9_0 = arg_5_0

		var_0._close(var_9_0)

		return
	end

	SFX_PANEL = var_5_12

	var_1_10001(var_5_11, var_5_13, var_5_14, var_5_12)

	onButton = var_1_10001

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.windowTF
	local var_5_17 = var_4.Find(var_5_16, "top/close_btn")

	local function var_5_18()
		local var_10_0 = arg_5_0

		var_0._close(var_10_0)

		return
	end

	SFX_PANEL = var_5_16

	var_1_10001(var_5_15, var_5_17, var_5_18, var_5_16)
	arg_5_0:initDropdownPanel()
	arg_5_0:initFilters()
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1
	})

	return
end

function var_0_1.initDropdownPanel(arg_11_0)
	local var_11_0 = arg_11_0.dropdownUIList

	var_1.make(var_11_0, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_12_1 + 1 + 1
			local var_12_1 = arg_11_0.dropdownCfg.names[arg_11_0.dropdownCfgIndex][var_12_0]
			local var_12_2 = arg_11_0.dropdownCfg.options[arg_11_0.dropdownCfgIndex][var_12_0]
			local var_12_3 = arg_11_0.dropdownCfg.tags[arg_11_0.dropdownCfgIndex]
			local var_12_4 = arg_11_0.dropdownCfg.defaults[arg_11_0.dropdownCfgIndex]

			setActive = var_8

			var_8(arg_12_2:Find("line"), var_12_0 ~= #arg_11_0.dropdownCfg.options[arg_11_0.dropdownCfgIndex])

			setText = var_8

			var_8(arg_12_2:Find("Text"), var_12_1)

			onButton = var_8

			local var_12_5 = arg_11_0
			local var_12_6 = arg_12_2

			local function var_12_7()
				if arg_11_0.contextData.indexDatas[var_12_3] == var_12_2 then
					arg_11_0.contextData.indexDatas[var_12_3] = var_12_4
				else
					arg_11_0.contextData.indexDatas[var_12_3] = var_12_2
				end

				local var_13_0 = arg_11_0

				var_0.closeDropdownPanel(var_13_0)

				local var_13_1 = arg_11_0.uiList[arg_11_0.updateListIndex]

				var_0.align(var_13_1, #arg_11_0.dropdownCfg.options)

				return
			end

			SFX_PANEL = var_13

			var_8(var_12_5, var_12_6, var_12_7, var_13)
		end

		return
	end)

	return
end

function var_0_1.initFilters(arg_14_0)
	local var_14_0 = arg_14_0.contextData
	local var_14_1

	if not arg_14_0.contextData.indexDatas then
		var_14_1 = {}
	end

	var_14_0.indexDatas = var_14_1
	arg_14_0.uiList = {}
	ipairs = var_1

	for iter_14_0, iter_14_1 in var_1(var_0_1.FILTER_CONFIG) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_14_0.filterTpl, arg_14_0.filterContainer)
		setText = var_1_10007

		var_1_10007(var_1_10006:Find("title/title"), iter_14_1.title)

		if not iter_14_1.dropdown then
			arg_14_0:initNormal(iter_14_0, iter_14_1, var_1_10006)
		else
			arg_14_0:initDropdown(iter_14_0, iter_14_1, var_1_10006)
		end
	end

	return
end

function var_0_1.initNormal(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_3:Find("content/container")

	UIItemList = var_1_10005

	local var_15_1 = var_1_10005.New(var_15_0, arg_15_0.itemTpl)

	var_5.make(var_15_1, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		local var_16_0

		if arg_16_0 == var_2_10003.EventInit then
			var_16_0 = arg_16_1 + 1

			local var_16_1 = arg_15_2.names[var_16_0]
			local var_16_2 = arg_15_2.options[var_16_0]

			setText = var_2_10006

			var_2_10006(arg_16_2:Find("Text"), var_16_1)

			setActive = var_2_10006

			var_2_10006(arg_16_2:Find("line"), var_16_0 ~= #arg_15_2.names)

			setActive = var_2_10006

			var_2_10006(arg_16_2:Find("arrow"), false)

			local var_16_3

			if not arg_15_0.contextData.indexDatas[arg_15_2.tag] then
				var_16_3 = arg_15_0.contextData.indexDatas
				var_16_3[arg_15_2.tag] = arg_15_2.default
			end

			onButton = var_16_3

			local var_16_4 = arg_15_0
			local var_16_5 = arg_16_2

			local function var_16_6()
				if arg_15_0.contextData.indexDatas[arg_15_2.tag] == arg_15_2.default then
					arg_15_0.contextData.indexDatas[arg_15_2.tag] = var_16_2
				else
					local var_17_0 = arg_15_0.contextData.indexDatas
					local var_17_1 = arg_15_2.tag

					bit = var_3_10002
					var_17_0[var_17_1] = var_3_10002.bxor(arg_15_0.contextData.indexDatas[arg_15_2.tag], var_16_2)
				end

				if arg_15_0.contextData.indexDatas[arg_15_2.tag] == 0 then
					arg_15_0.contextData.indexDatas[arg_15_2.tag] = arg_15_2.default
				end

				local var_17_2 = var_0

				var_0.align(var_17_2, #arg_15_2.options)

				return
			end

			SFX_PANEL = var_11

			var_16_3(var_16_4, var_16_5, var_16_6, var_11)

			goto label_16_0
		end

		UIItemList = var_16_0

		if arg_16_0 == var_16_0.EventUpdate then
			local var_16_7 = arg_16_1 + 1
			local var_16_8 = arg_15_2.options[var_16_7]
			local var_16_9

			if arg_15_0.contextData.indexDatas[arg_15_2.tag] == arg_15_2.default then
				var_16_9 = false
			else
				bit = var_6
				var_16_9 = var_6.band(arg_15_0.contextData.indexDatas[arg_15_2.tag], var_16_8) > 0
			end

			setActive = var_6

			var_6(arg_16_2:Find("selected"), var_16_9)

			setTextColor = var_6

			local var_16_10 = arg_16_2:Find("Text")

			if var_16_9 then
				Color = var_16_11

				do
					local var_16_11

					if not var_16_11.white then
						Color = var_16_11
						var_16_11 = var_16_11.NewHex("393a3c")
					end

					var_6(var_16_10, var_16_11)
				end

				::label_16_0::

				return
			end
		end
	end)
	var_5:align(#arg_15_2.options)

	arg_15_0.uiList[arg_15_1] = var_5

	return
end

function var_0_1.initDropdown(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_3:Find("content/container")

	UIItemList = var_1_10005

	local var_18_1 = var_1_10005.New(var_18_0, arg_18_0.itemTpl)

	var_5.make(var_18_1, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		local var_19_0

		if arg_19_0 == var_2_10003.EventInit then
			var_19_0 = arg_19_1 + 1

			local var_19_1 = arg_18_2.tags[var_19_0]
			local var_19_2 = arg_18_2.defaults[var_19_0]

			setActive = var_2_10006

			local var_19_3 = arg_19_2:Find("line")

			var_2_10009 = var_19_0 ~= #arg_18_2.tags

			var_2_10006(var_19_3, var_2_10009)

			setActive = var_2_10006

			var_2_10006(arg_19_2:Find("arrow"), true)

			local var_19_4

			if not arg_18_0.contextData.indexDatas[var_19_1] then
				var_19_4 = arg_18_0.contextData.indexDatas
				var_19_4[var_19_1] = var_19_2
			end

			onButton = var_19_4

			local var_19_5 = arg_18_0

			var_2_10009 = arg_19_2

			local function var_19_6()
				arg_18_0.dropdownCfg = arg_18_2
				arg_18_0.dropdownCfgIndex = var_19_0
				arg_18_0.updateListIndex = arg_18_1

				local var_20_0 = arg_18_0._tf
				local var_20_1 = var_0.InverseTransformPoint(var_20_0, arg_19_2.position)
				local var_20_2 = arg_18_0

				var_1.showDropdownPanel(var_20_2, var_20_1)

				return
			end

			SFX_PANEL = var_11

			var_19_4(var_19_5, var_2_10009, var_19_6, var_11)

			goto label_19_0
		end

		UIItemList = var_19_0

		if arg_19_0 == var_19_0.EventUpdate then
			local var_19_7 = arg_19_1 + 1
			local var_19_8 = arg_18_2.tags[var_19_7]
			local var_19_9 = arg_18_2.defaults[var_19_7]
			local var_19_10 = ""
			local var_19_11 = true
			local var_19_12

			if arg_18_0.contextData.indexDatas[var_19_8] == var_19_9 then
				var_19_11 = false
				var_19_10 = arg_18_2.names[var_19_7][1]
			else
				var_19_12 = arg_18_2.options[var_19_7]
				ipairs = var_2_10009

				for iter_19_0, iter_19_1 in var_2_10009(var_19_12) do
					if arg_18_0.contextData.indexDatas[var_19_8] == iter_19_1 then
						var_19_10 = arg_18_2.names[var_19_7][iter_19_0]

						break
					end
				end
			end

			setText = var_19_12

			var_19_12(arg_19_2:Find("Text"), var_19_10)

			setActive = var_19_12

			var_19_12(arg_19_2:Find("selected"), var_19_11)

			setTextColor = var_19_12

			local var_19_13 = arg_19_2:Find("Text")

			if var_19_11 then
				Color = var_19_14

				local var_19_14

				if not var_19_14.white then
					Color = var_19_14
					var_19_14 = var_19_14.NewHex("393a3c")
				end

				var_19_12(var_19_13, var_19_14)

				setImageColor = var_19_12

				local var_19_15 = arg_19_2:Find("arrow")

				if var_19_11 then
					Color = var_19_14

					if not var_19_14.white then
						Color = var_19_14
						var_19_14 = var_19_14.NewHex("393a3c")
					end

					var_19_12(var_19_15, var_19_14)

					::label_19_0::

					return
				end
			end
		end
	end)
	var_5:align(#arg_18_2.options)

	arg_18_0.uiList[arg_18_1] = var_5

	return
end

function var_0_1.showDropdownPanel(arg_21_0, arg_21_1)
	setAnchoredPosition = var_1_10002

	local var_21_0 = arg_21_0.dropdownPanel

	var_1_10002(var_4.Find(var_21_0, "dropdown"), arg_21_1)

	setActive = var_1_10002

	var_1_10002(arg_21_0.dropdownPanel, true)

	local var_21_1 = arg_21_0.dropdownUIList

	var_2.align(var_21_1, #arg_21_0.dropdownCfg.options[arg_21_0.dropdownCfgIndex] - 1)

	return
end

function var_0_1.closeDropdownPanel(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.dropdownPanel, false)

	return
end

function var_0_1._close(arg_23_0)
	local var_23_0 = arg_23_0.anim

	var_1.Play(var_23_0, "anim_educate_scheduleindex_out")

	return
end

function var_0_1.onBackPressed(arg_24_0)
	arg_24_0:_close()

	return
end

function var_0_1.willExit(arg_25_0)
	local var_25_0 = arg_25_0.animEvent

	var_1.SetEndEvent(var_25_0, nil)
	arg_25_0:UnOverlayPanel(arg_25_0._tf)

	return
end

return var_0_1
