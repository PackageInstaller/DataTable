local var_0_0 = class("CommanderIndexPage", import("...base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2

var_0_0.NATION_OTHER = -1

local var_0_3 = {
	sort = {
		{
			i18n("word_achieved_item"),
			"id"
		},
		{
			i18n("word_level"),
			"Level"
		},
		{
			i18n("word_rarity"),
			"Rarity"
		}
	},
	nation = {},
	rarity = {
		{
			i18n("word_ssr"),
			5
		},
		{
			i18n("word_sr"),
			4
		},
		{
			i18n("word_r"),
			3
		}
	},
	name = {
		{
			i18n("commandercat_label_raw_name"),
			1
		},
		{
			i18n("commandercat_label_custom_name"),
			2
		}
	}
}

for iter_0_0, iter_0_1 in ipairs({
	Nation.US,
	Nation.EN,
	Nation.JP,
	Nation.DE,
	Nation.CN,
	Nation.SN,
	Nation.FF,
	Nation.MNF
}) do
	table.insert(var_0_3.nation, iter_0_1)
end

table.insert(var_0_3.nation, var_0_0.NATION_OTHER)

function var_0_0.IsOtherNation(arg_1_0)
	if not var_0_0.displayNations then
		var_0_0.displayNations = {}

		for iter_1_0, iter_1_1 in ipairs(var_0) do
			var_0_0.displayNations[iter_1_1] = true
		end
	end

	return var_0_0.displayNations[arg_1_0] ~= true
end

function var_0_0.getUIName(arg_2_0)
	return "CommanderIndexUI"
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.sortPanel = arg_3_0._tf:Find("frame/frame/frame/sort_panel/content")
	arg_3_0.nationPanel = arg_3_0._tf:Find("frame/frame/frame/nation_panel/content")
	arg_3_0.rarityPanel = arg_3_0._tf:Find("frame/frame/frame/rarity_panel/content")
	arg_3_0.namePanel = arg_3_0._tf:Find("frame/frame/frame/name_panel/content")
	arg_3_0.sortTpl = arg_3_0.sortPanel:Find("tpl")
	arg_3_0.nationTpl = arg_3_0.nationPanel:Find("tpl")
	arg_3_0.rarityTpl = arg_3_0.rarityPanel:Find("tpl")
	arg_3_0.nameTpl = arg_3_0.namePanel:Find("tpl")
	arg_3_0.cancelBtn = arg_3_0._tf:Find("frame/frame/cancel_btn")
	arg_3_0.confirmBtn = arg_3_0._tf:Find("frame/frame/confirm_btn")
	arg_3_0.closeBtn = arg_3_0._tf:Find("frame/close_btn")

	setText(arg_3_0._tf:Find("frame/frame/frame/sort_panel/title/Text"), i18n("indexsort_sort"))
	setText(arg_3_0._tf:Find("frame/frame/frame/nation_panel/title/Text"), i18n("indexsort_camp"))
	setText(arg_3_0._tf:Find("frame/frame/frame/rarity_panel/title/Text"), i18n("indexsort_rarity"))
	setText(arg_3_0._tf:Find("frame/frame/frame/name_panel/title/Text"), i18n("commandercat_label_display_name"))

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0.cancelBtn, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.closeBtn, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.confirmBtn, function()
		arg_4_0.data.displayCustomName = arg_4_0.displayName == var_0_2

		arg_4_0:emit(CommanderCatDockPage.ON_SORT, arg_4_0.data.displayCustomName)
		arg_4_0:Hide()

		return
	end, SFX_PANEL)

	arg_4_0.nationAllBtn = cloneTplTo(arg_4_0.nationTpl, arg_4_0.nationPanel)

	setText(arg_4_0.nationAllBtn:Find("Text"), i18n("index_all"))
	onToggle(arg_4_0, arg_4_0.nationAllBtn, function(arg_9_0)
		if arg_9_0 then
			for iter_9_0, iter_9_1 in pairs(arg_4_0.nationToggles) do
				triggerToggle(iter_9_1, false)
			end

			arg_4_0.data.nationData = {}
		end

		setToggleEnabled(arg_4_0.nationAllBtn, not arg_9_0)

		return
	end, SFX_PANEL)

	arg_4_0.rarityAllBtn = cloneTplTo(arg_4_0.rarityTpl, arg_4_0.rarityPanel)

	setText(arg_4_0.rarityAllBtn:Find("Text"), i18n("index_all"))
	onToggle(arg_4_0, arg_4_0.rarityAllBtn, function(arg_10_0)
		if arg_10_0 then
			for iter_10_0, iter_10_1 in pairs(arg_4_0.rarityToggles) do
				triggerToggle(iter_10_1, false)
			end

			arg_4_0.data.rarityData = {}
		end

		setToggleEnabled(arg_4_0.rarityAllBtn, not arg_10_0)

		return
	end, SFX_PANEL)
	arg_4_0:Reset()
	arg_4_0:InitSort()
	arg_4_0:InitNation()
	arg_4_0:InitRarity()
	arg_4_0:InitDisplayName()

	return
end

function var_0_0.InitSort(arg_11_0)
	arg_11_0.sortToggles = {}

	for iter_11_0, iter_11_1 in ipairs(var_0_3.sort) do
		local var_11_0 = cloneTplTo(arg_11_0.sortTpl, arg_11_0.sortPanel)

		onToggle(arg_11_0, var_11_0, function(arg_12_0)
			if arg_12_0 then
				arg_11_0.data.sortData = iter_11_1[2]
			end

			return
		end, SFX_PANEL)
		setText(var_11_0:Find("Text"), iter_11_1[1])

		arg_11_0.sortToggles[iter_11_1[2]] = var_11_0
	end

	return
end

function var_0_0.InitNation(arg_13_0)
	arg_13_0.nationToggles = {}

	for iter_13_0, iter_13_1 in pairs(var_0_3.nation) do
		local var_13_0 = cloneTplTo(arg_13_0.nationTpl, arg_13_0.nationPanel)

		onToggle(arg_13_0, var_13_0, function(arg_14_0)
			if arg_14_0 then
				if #arg_13_0.data.nationData == 0 then
					triggerToggle(arg_13_0.nationAllBtn, false)
				end

				table.insert(arg_13_0.data.nationData, iter_13_1)

				if #arg_13_0.data.nationData == #var_0_3.nation then
					triggerToggle(arg_13_0.nationAllBtn, true)
				end
			elseif #arg_13_0.data.nationData > 0 then
				local var_14_0 = table.indexof(arg_13_0.data.nationData, iter_13_1)

				if var_14_0 then
					table.remove(arg_13_0.data.nationData, var_14_0)

					if #arg_13_0.data.nationData == 0 then
						triggerToggle(arg_13_0.nationAllBtn, true)
					end
				end
			end

			return
		end, SFX_PANEL)
		setText(var_13_0:Find("Text"), arg_13_0:Nation2Name(iter_13_1))

		arg_13_0.nationToggles[iter_13_1] = var_13_0
	end

	return
end

function var_0_0.Nation2Name(arg_15_0, arg_15_1)
	if arg_15_1 == var_0_0.NATION_OTHER then
		return i18n("index_other")
	else
		return Nation.Nation2Name(arg_15_1)
	end

	return
end

function var_0_0.InitRarity(arg_16_0)
	arg_16_0.rarityToggles = {}

	for iter_16_0, iter_16_1 in pairs(var_0_3.rarity) do
		local var_16_0 = cloneTplTo(arg_16_0.rarityTpl, arg_16_0.rarityPanel)

		onToggle(arg_16_0, var_16_0, function(arg_17_0)
			if arg_17_0 then
				if #arg_16_0.data.rarityData == 0 then
					triggerToggle(arg_16_0.rarityAllBtn, false)
				end

				table.insert(arg_16_0.data.rarityData, iter_16_1[2])

				if #arg_16_0.data.rarityData == #var_0_3.rarity then
					triggerToggle(arg_16_0.rarityAllBtn, true)
				end
			elseif #arg_16_0.data.rarityData > 0 then
				local var_17_0 = table.indexof(arg_16_0.data.rarityData, iter_16_1[2])

				if var_17_0 then
					table.remove(arg_16_0.data.rarityData, var_17_0)

					if #arg_16_0.data.rarityData == 0 then
						triggerToggle(arg_16_0.rarityAllBtn, true)
					end
				end
			end

			return
		end, SFX_PANEL)
		setText(var_16_0:Find("Text"), iter_16_1[1])

		arg_16_0.rarityToggles[iter_16_1[2]] = var_16_0
	end

	return
end

function var_0_0.InitDisplayName(arg_18_0)
	arg_18_0.nameToggles = {}

	for iter_18_0, iter_18_1 in ipairs(var_0_3.name) do
		local var_18_0 = cloneTplTo(arg_18_0.nameTpl, arg_18_0.namePanel)

		setText(var_18_0:Find("Text"), iter_18_1[1])
		onToggle(arg_18_0, var_18_0, function(arg_19_0)
			if arg_19_0 then
				arg_18_0.displayName = iter_18_1[2]
			end

			return
		end, SFX_PANEL)

		arg_18_0.nameToggles[iter_18_1[2]] = var_18_0
	end

	return
end

function var_0_0.Show(arg_20_0, arg_20_1)
	setActive(arg_20_0._tf, true)
	arg_20_0:UpdateSelected(arg_20_1)
	setParent(arg_20_0._tf, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_0.UpdateSelected(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.sortData or "Level"

	triggerToggle(arg_21_0.sortToggles[var_21_0], true)

	local var_21_1 = arg_21_1.nationData or {}

	if #var_21_1 > 0 then
		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			triggerToggle(arg_21_0.nationToggles[iter_21_1], true)
		end
	else
		triggerToggle(arg_21_0.nationAllBtn, true)
	end

	local var_21_2 = arg_21_1.rarityData or {}

	if #var_21_2 > 0 then
		for iter_21_2, iter_21_3 in pairs(var_21_2) do
			triggerToggle(arg_21_0.rarityToggles[iter_21_3], true)
		end
	else
		triggerToggle(arg_21_0.rarityAllBtn, true)
	end

	if defaultValue(arg_21_1.displayCustomName, true) then
		local var_21_3 = var_0_2 or var_0_1

		triggerToggle(arg_21_0.nameToggles[var_21_3], true)

		return
	end
end

function var_0_0.Reset(arg_22_0)
	arg_22_0.data = {
		displayCustomName = true,
		sortData = "Level",
		nationData = {},
		rarityData = {}
	}

	return
end

function var_0_0.Hide(arg_23_0)
	setActive(arg_23_0._tf, false)
	arg_23_0:Reset()
	setParent(arg_23_0._tf, arg_23_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_24_0)
	var_0_0.displayNations = nil

	return
end

return var_0_0
