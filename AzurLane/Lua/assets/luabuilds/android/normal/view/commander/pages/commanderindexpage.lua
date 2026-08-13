class = var_0_10000

local var_0_0 = "CommanderIndexPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2

var_0_1.NATION_OTHER = -1

local var_0_4 = {}

Nation = var_0_10004
var_0_4[1] = var_0_10004.US
Nation = var_4
var_0_4[2] = var_4.EN
Nation = var_4
var_0_4[3] = var_4.JP
Nation = var_4
var_0_4[4] = var_4.DE
Nation = var_4
var_0_4[5] = var_4.CN
Nation = var_4
var_0_4[6] = var_4.SN
Nation = var_4
var_0_4[7] = var_4.FF
Nation = var_4
var_0_4[8] = var_4.MNF

local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {
	nil,
	"id"
}

i18n = var_0_10007
var_0_7[1] = var_0_10007("word_achieved_item")
var_0_6[1] = var_0_7

local var_0_8 = {
	nil,
	"Level"
}

i18n = var_7
var_0_8[1] = var_7("word_level")
var_0_6[2] = var_0_8

local var_0_9 = {
	nil,
	"Rarity"
}

i18n = var_7
var_0_9[1] = var_7("word_rarity")
var_0_6[3] = var_0_9
var_0_5.sort = var_0_6
var_0_5.nation = {}

local var_0_10 = {}
local var_0_11 = {
	nil,
	5
}

i18n = var_7
var_0_11[1] = var_7("word_ssr")
var_0_10[1] = var_0_11

local var_0_12 = {
	nil,
	4
}

i18n = var_7
var_0_12[1] = var_7("word_sr")
var_0_10[2] = var_0_12

local var_0_13 = {
	nil,
	3
}

i18n = var_7
var_0_13[1] = var_7("word_r")
var_0_10[3] = var_0_13
var_0_5.rarity = var_0_10

local var_0_14 = {}
local var_0_15 = {}

i18n = var_7
var_0_15[1] = var_7("commandercat_label_raw_name")
var_0_15[2] = var_0_2
var_0_14[1] = var_0_15

local var_0_16 = {}

i18n = var_7
var_0_16[1] = var_7("commandercat_label_custom_name")
var_0_16[2] = var_0_3
var_0_14[2] = var_0_16
var_0_5.name = var_0_14
ipairs = var_0_14

for iter_0_0, iter_0_1 in var_0_14(var_0_4) do
	table = var_0_10010

	var_0_10010.insert(var_0_5.nation, iter_0_1)
end

table = var_5

var_5.insert(var_0_5.nation, var_0_1.NATION_OTHER)

function var_0_1.IsOtherNation(arg_1_0)
	if not var_0_1.displayNations then
		local var_1_0 = var_0_1

		var_1_0.displayNations = {}
		ipairs = var_1_0

		for iter_1_0, iter_1_1 in var_1_0(var_0_4) do
			var_0_1.displayNations[iter_1_1] = true
		end
	end

	return var_0_1.displayNations[arg_1_0] ~= true
end

function var_0_1.getUIName(arg_2_0)
	return "CommanderIndexUI"
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.sortPanel = var_1.Find(var_3_0, "frame/frame/frame/sort_panel/content")

	local var_3_1 = arg_3_0._tf

	arg_3_0.nationPanel = var_1.Find(var_3_1, "frame/frame/frame/nation_panel/content")

	local var_3_2 = arg_3_0._tf

	arg_3_0.rarityPanel = var_1.Find(var_3_2, "frame/frame/frame/rarity_panel/content")

	local var_3_3 = arg_3_0._tf

	arg_3_0.namePanel = var_1.Find(var_3_3, "frame/frame/frame/name_panel/content")

	local var_3_4 = arg_3_0.sortPanel

	arg_3_0.sortTpl = var_1.Find(var_3_4, "tpl")

	local var_3_5 = arg_3_0.nationPanel

	arg_3_0.nationTpl = var_1.Find(var_3_5, "tpl")

	local var_3_6 = arg_3_0.rarityPanel

	arg_3_0.rarityTpl = var_1.Find(var_3_6, "tpl")

	local var_3_7 = arg_3_0.namePanel

	arg_3_0.nameTpl = var_1.Find(var_3_7, "tpl")

	local var_3_8 = arg_3_0._tf

	arg_3_0.cancelBtn = var_1.Find(var_3_8, "frame/frame/cancel_btn")

	local var_3_9 = arg_3_0._tf

	arg_3_0.confirmBtn = var_1.Find(var_3_9, "frame/frame/confirm_btn")

	local var_3_10 = arg_3_0._tf

	arg_3_0.closeBtn = var_1.Find(var_3_10, "frame/close_btn")
	setText = var_1

	local var_3_11 = arg_3_0._tf
	local var_3_12 = var_2.Find(var_3_11, "frame/frame/frame/sort_panel/title/Text")

	i18n = var_3_11

	var_1(var_3_12, var_3_11("indexsort_sort"))

	setText = var_1

	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_2.Find(var_3_13, "frame/frame/frame/nation_panel/title/Text")

	i18n = var_3_13

	var_1(var_3_14, var_3_13("indexsort_camp"))

	setText = var_1

	local var_3_15 = arg_3_0._tf
	local var_3_16 = var_2.Find(var_3_15, "frame/frame/frame/rarity_panel/title/Text")

	i18n = var_3_15

	var_1(var_3_16, var_3_15("indexsort_rarity"))

	setText = var_1

	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_2.Find(var_3_17, "frame/frame/frame/name_panel/title/Text")

	i18n = var_3_17

	var_1(var_3_18, var_3_17("commandercat_label_display_name"))

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.cancelBtn

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.closeBtn

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10005)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0._tf

	local function var_4_8()
		local var_7_0 = arg_4_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10005)

	onButton = var_1_10001

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.confirmBtn

	local function var_4_11()
		arg_4_0.data.displayCustomName = arg_4_0.displayName == var_0_3

		local var_8_0 = arg_4_0
		local var_8_1 = var_0.emit

		CommanderCatDockPage = var_2

		var_8_1(var_8_0, var_2.ON_SORT, arg_4_0.data.displayCustomName)

		local var_8_2 = arg_4_0

		var_0.Hide(var_8_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_9, var_4_10, var_4_11, var_1_10005)

	cloneTplTo = var_1_10001
	arg_4_0.nationAllBtn = var_1_10001(arg_4_0.nationTpl, arg_4_0.nationPanel)
	setText = var_1

	local var_4_12 = arg_4_0.nationAllBtn
	local var_4_13 = var_2.Find(var_4_12, "Text")

	i18n = var_4_12

	var_1(var_4_13, var_4_12("index_all"))

	onToggle = var_1

	local var_4_14 = arg_4_0
	local var_4_15 = arg_4_0.nationAllBtn

	local function var_4_16(arg_9_0)
		if arg_9_0 then
			pairs = var_2_10001

			for iter_9_0, iter_9_1 in var_2_10001(arg_4_0.nationToggles) do
				triggerToggle = var_2_10006

				var_2_10006(iter_9_1, false)
			end

			var_2_10001 = arg_4_0.data
			var_2_10001.nationData = {}
		end

		setToggleEnabled = var_2_10001

		var_2_10001(arg_4_0.nationAllBtn, not arg_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_14, var_4_15, var_4_16, var_1_10005)

	cloneTplTo = var_1
	arg_4_0.rarityAllBtn = var_1(arg_4_0.rarityTpl, arg_4_0.rarityPanel)
	setText = var_1

	local var_4_17 = arg_4_0.rarityAllBtn
	local var_4_18 = var_2.Find(var_4_17, "Text")

	i18n = var_4_17

	var_1(var_4_18, var_4_17("index_all"))

	onToggle = var_1

	local var_4_19 = arg_4_0
	local var_4_20 = arg_4_0.rarityAllBtn

	local function var_4_21(arg_10_0)
		if arg_10_0 then
			pairs = var_2_10001

			for iter_10_0, iter_10_1 in var_2_10001(arg_4_0.rarityToggles) do
				triggerToggle = var_2_10006

				var_2_10006(iter_10_1, false)
			end

			var_2_10001 = arg_4_0.data
			var_2_10001.rarityData = {}
		end

		setToggleEnabled = var_2_10001

		var_2_10001(arg_4_0.rarityAllBtn, not arg_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_19, var_4_20, var_4_21, var_1_10005)
	arg_4_0:Reset()
	arg_4_0:InitSort()
	arg_4_0:InitNation()
	arg_4_0:InitRarity()
	arg_4_0:InitDisplayName()

	return
end

function var_0_1.InitSort(arg_11_0)
	arg_11_0.sortToggles = {}
	ipairs = var_1

	for iter_11_0, iter_11_1 in var_1(var_0_5.sort) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_11_0.sortTpl, arg_11_0.sortPanel)
		onToggle = var_7

		local var_11_0 = arg_11_0
		local var_11_1 = var_1_10006

		local function var_11_2(arg_12_0)
			if arg_12_0 then
				arg_11_0.data.sortData = iter_11_1[2]
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_11_0, var_11_1, var_11_2, var_1_10011)

		setText = var_7

		var_7(var_1_10006:Find("Text"), iter_11_1[1])

		arg_11_0.sortToggles[iter_11_1[2]] = var_1_10006
	end

	return
end

function var_0_1.InitNation(arg_13_0)
	arg_13_0.nationToggles = {}
	pairs = var_1

	for iter_13_0, iter_13_1 in var_1(var_0_5.nation) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_13_0.nationTpl, arg_13_0.nationPanel)
		onToggle = var_7

		local var_13_0 = arg_13_0
		local var_13_1 = var_1_10006

		local function var_13_2(arg_14_0)
			if arg_14_0 then
				if #arg_13_0.data.nationData == 0 then
					triggerToggle = var_1

					var_1(arg_13_0.nationAllBtn, false)
				end

				table = var_1

				var_1.insert(arg_13_0.data.nationData, iter_13_1)

				if #arg_13_0.data.nationData == #var_0_5.nation then
					triggerToggle = var_1

					var_1(arg_13_0.nationAllBtn, true)
				end
			elseif #arg_13_0.data.nationData > 0 then
				table = var_1

				if var_1.indexof(arg_13_0.data.nationData, iter_13_1) then
					table = var_2

					var_2.remove(arg_13_0.data.nationData, var_1)

					if #arg_13_0.data.nationData == 0 then
						triggerToggle = var_2

						var_2(arg_13_0.nationAllBtn, true)
					end
				end
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_13_0, var_13_1, var_13_2, var_1_10011)

		setText = var_7

		var_7(var_1_10006:Find("Text"), arg_13_0:Nation2Name(iter_13_1))

		arg_13_0.nationToggles[iter_13_1] = var_1_10006
	end

	return
end

function var_0_1.Nation2Name(arg_15_0, arg_15_1)
	if arg_15_1 == var_0_1.NATION_OTHER then
		i18n = var_2

		return var_2("index_other")
	else
		Nation = var_2

		return var_2.Nation2Name(arg_15_1)
	end

	return
end

function var_0_1.InitRarity(arg_16_0)
	arg_16_0.rarityToggles = {}
	pairs = var_1

	for iter_16_0, iter_16_1 in var_1(var_0_5.rarity) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_16_0.rarityTpl, arg_16_0.rarityPanel)
		onToggle = var_7

		local var_16_0 = arg_16_0
		local var_16_1 = var_1_10006

		local function var_16_2(arg_17_0)
			if arg_17_0 then
				if #arg_16_0.data.rarityData == 0 then
					triggerToggle = var_1

					var_1(arg_16_0.rarityAllBtn, false)
				end

				table = var_1

				var_1.insert(arg_16_0.data.rarityData, iter_16_1[2])

				if #arg_16_0.data.rarityData == #var_0_5.rarity then
					triggerToggle = var_1

					var_1(arg_16_0.rarityAllBtn, true)
				end
			elseif #arg_16_0.data.rarityData > 0 then
				table = var_1

				if var_1.indexof(arg_16_0.data.rarityData, iter_16_1[2]) then
					table = var_2

					var_2.remove(arg_16_0.data.rarityData, var_1)

					if #arg_16_0.data.rarityData == 0 then
						triggerToggle = var_2

						var_2(arg_16_0.rarityAllBtn, true)
					end
				end
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_16_0, var_16_1, var_16_2, var_1_10011)

		setText = var_7

		var_7(var_1_10006:Find("Text"), iter_16_1[1])

		arg_16_0.rarityToggles[iter_16_1[2]] = var_1_10006
	end

	return
end

function var_0_1.InitDisplayName(arg_18_0)
	arg_18_0.nameToggles = {}
	ipairs = var_1

	for iter_18_0, iter_18_1 in var_1(var_0_5.name) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_18_0.nameTpl, arg_18_0.namePanel)
		setText = var_7

		var_7(var_1_10006:Find("Text"), iter_18_1[1])

		onToggle = var_7

		local var_18_0 = arg_18_0
		local var_18_1 = var_1_10006

		local function var_18_2(arg_19_0)
			if arg_19_0 then
				arg_18_0.displayName = iter_18_1[2]
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_18_0, var_18_1, var_18_2, var_1_10011)

		arg_18_0.nameToggles[iter_18_1[2]] = var_1_10006
	end

	return
end

function var_0_1.Show(arg_20_0, arg_20_1)
	setActive = var_1_10002

	var_1_10002(arg_20_0._tf, true)
	arg_20_0:UpdateSelected(arg_20_1)

	setParent = var_2

	local var_20_0 = arg_20_0._tf

	pg = var_4

	var_2(var_20_0, var_4.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_1.UpdateSelected(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_1.sortData then
		var_21_0 = "Level"
	end

	triggerToggle = var_1_10003

	var_1_10003(arg_21_0.sortToggles[var_21_0], true)

	local var_21_1

	if not arg_21_1.nationData then
		var_21_1 = {}
	end

	if #var_21_1 > 0 then
		pairs = var_4

		for iter_21_0, iter_21_1 in var_4(var_21_1) do
			triggerToggle = var_1_10009

			var_1_10009(arg_21_0.nationToggles[iter_21_1], true)
		end
	else
		triggerToggle = var_4

		var_4(arg_21_0.nationAllBtn, true)
	end

	local var_21_2

	if not arg_21_1.rarityData then
		var_21_2 = {}
	end

	if #var_21_2 > 0 then
		pairs = var_5

		for iter_21_2, iter_21_3 in var_5(var_21_2) do
			triggerToggle = var_1_10010

			var_1_10010(arg_21_0.rarityToggles[iter_21_3], true)
		end
	else
		triggerToggle = var_5

		var_5(arg_21_0.rarityAllBtn, true)
	end

	defaultValue = var_5

	local var_21_3

	if not var_5(arg_21_1.displayCustomName, true) or not var_0_3 then
		var_21_3 = var_0_2
	end

	triggerToggle = var_7

	var_7(arg_21_0.nameToggles[var_21_3], true)

	return
end

function var_0_1.Reset(arg_22_0)
	arg_22_0.data = {
		displayCustomName = true,
		sortData = "Level",
		nationData = {},
		rarityData = {}
	}

	return
end

function var_0_1.Hide(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0._tf, false)
	arg_23_0:Reset()

	setParent = var_1

	var_1(arg_23_0._tf, arg_23_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_24_0)
	var_0_1.displayNations = nil

	return
end

return var_0_1
