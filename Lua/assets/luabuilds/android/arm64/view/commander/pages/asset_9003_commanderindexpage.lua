local CommanderIndexPage = class("CommanderIndexPage", import("...base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2

CommanderIndexPage.NATION_OTHER = -1

local var_0_3 = {
	Nation.US,
	Nation.EN,
	Nation.JP,
	Nation.DE,
	Nation.CN,
	Nation.SN,
	Nation.FF,
	Nation.MNF
}
local var_0_4 = {
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

for iter_0_0, iter_0_1 in ipairs(var_0_3) do
	table.insert(var_0_4.nation, iter_0_1)
end

table.insert(var_0_4.nation, CommanderIndexPage.NATION_OTHER)

function CommanderIndexPage:IsOtherNation()
	if not CommanderIndexPage.displayNations then
		CommanderIndexPage.displayNations = {}

		for iter_1_0, iter_1_1 in ipairs(var_0_3) do
			CommanderIndexPage.displayNations[iter_1_1] = true
		end
	end

	return CommanderIndexPage.displayNations[self] ~= true
end

function CommanderIndexPage:getUIName()
	return "CommanderIndexUI"
end

function CommanderIndexPage:OnLoaded()
	self.sortPanel = self._tf:Find("frame/frame/frame/sort_panel/content")
	self.nationPanel = self._tf:Find("frame/frame/frame/nation_panel/content")
	self.rarityPanel = self._tf:Find("frame/frame/frame/rarity_panel/content")
	self.namePanel = self._tf:Find("frame/frame/frame/name_panel/content")
	self.sortTpl = self.sortPanel:Find("tpl")
	self.nationTpl = self.nationPanel:Find("tpl")
	self.rarityTpl = self.rarityPanel:Find("tpl")
	self.nameTpl = self.namePanel:Find("tpl")
	self.cancelBtn = self._tf:Find("frame/frame/cancel_btn")
	self.confirmBtn = self._tf:Find("frame/frame/confirm_btn")
	self.closeBtn = self._tf:Find("frame/close_btn")

	setText(self._tf:Find("frame/frame/frame/sort_panel/title/Text"), i18n("indexsort_sort"))
	setText(self._tf:Find("frame/frame/frame/nation_panel/title/Text"), i18n("indexsort_camp"))
	setText(self._tf:Find("frame/frame/frame/rarity_panel/title/Text"), i18n("indexsort_rarity"))
	setText(self._tf:Find("frame/frame/frame/name_panel/title/Text"), i18n("commandercat_label_display_name"))

	return
end

function CommanderIndexPage:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self.data.displayCustomName = self.displayName == var_0_2

		self:emit(CommanderCatDockPage.ON_SORT, self.data.displayCustomName)
		self:Hide()

		return
	end, SFX_PANEL)

	self.nationAllBtn = cloneTplTo(self.nationTpl, self.nationPanel)

	setText(self.nationAllBtn:Find("Text"), i18n("index_all"))
	onToggle(self, self.nationAllBtn, function(arg_9_0)
		if arg_9_0 then
			for iter_9_0, iter_9_1 in pairs(self.nationToggles) do
				triggerToggle(iter_9_1, false)
			end

			self.data.nationData = {}
		end

		setToggleEnabled(self.nationAllBtn, not arg_9_0)

		return
	end, SFX_PANEL)

	self.rarityAllBtn = cloneTplTo(self.rarityTpl, self.rarityPanel)

	setText(self.rarityAllBtn:Find("Text"), i18n("index_all"))
	onToggle(self, self.rarityAllBtn, function(arg_10_0)
		if arg_10_0 then
			for iter_10_0, iter_10_1 in pairs(self.rarityToggles) do
				triggerToggle(iter_10_1, false)
			end

			self.data.rarityData = {}
		end

		setToggleEnabled(self.rarityAllBtn, not arg_10_0)

		return
	end, SFX_PANEL)
	self:Reset()
	self:InitSort()
	self:InitNation()
	self:InitRarity()
	self:InitDisplayName()

	return
end

function CommanderIndexPage:InitSort()
	self.sortToggles = {}

	for iter_11_0, iter_11_1 in ipairs(var_0_4.sort) do
		local var_11_0 = cloneTplTo(self.sortTpl, self.sortPanel)

		onToggle(self, var_11_0, function(arg_12_0)
			if arg_12_0 then
				self.data.sortData = iter_11_1[2]
			end

			return
		end, SFX_PANEL)
		setText(var_11_0:Find("Text"), iter_11_1[1])

		self.sortToggles[iter_11_1[2]] = var_11_0
	end

	return
end

function CommanderIndexPage:InitNation()
	self.nationToggles = {}

	for iter_13_0, iter_13_1 in pairs(var_0_4.nation) do
		local var_13_0 = cloneTplTo(self.nationTpl, self.nationPanel)

		onToggle(self, var_13_0, function(arg_14_0)
			if arg_14_0 then
				if #self.data.nationData == 0 then
					triggerToggle(self.nationAllBtn, false)
				end

				table.insert(self.data.nationData, iter_13_1)

				if #self.data.nationData == #var_0_4.nation then
					triggerToggle(self.nationAllBtn, true)
				end
			elseif #self.data.nationData > 0 then
				local var_14_0 = table.indexof(self.data.nationData, iter_13_1)

				if var_14_0 then
					table.remove(self.data.nationData, var_14_0)

					if #self.data.nationData == 0 then
						triggerToggle(self.nationAllBtn, true)
					end
				end
			end

			return
		end, SFX_PANEL)
		setText(var_13_0:Find("Text"), self:Nation2Name(iter_13_1))

		self.nationToggles[iter_13_1] = var_13_0
	end

	return
end

function CommanderIndexPage:Nation2Name(arg_15_1)
	if arg_15_1 == CommanderIndexPage.NATION_OTHER then
		return i18n("index_other")
	else
		return Nation.Nation2Name(arg_15_1)
	end

	return
end

function CommanderIndexPage:InitRarity()
	self.rarityToggles = {}

	for iter_16_0, iter_16_1 in pairs(var_0_4.rarity) do
		local var_16_0 = cloneTplTo(self.rarityTpl, self.rarityPanel)

		onToggle(self, var_16_0, function(arg_17_0)
			if arg_17_0 then
				if #self.data.rarityData == 0 then
					triggerToggle(self.rarityAllBtn, false)
				end

				table.insert(self.data.rarityData, iter_16_1[2])

				if #self.data.rarityData == #var_0_4.rarity then
					triggerToggle(self.rarityAllBtn, true)
				end
			elseif #self.data.rarityData > 0 then
				local var_17_0 = table.indexof(self.data.rarityData, iter_16_1[2])

				if var_17_0 then
					table.remove(self.data.rarityData, var_17_0)

					if #self.data.rarityData == 0 then
						triggerToggle(self.rarityAllBtn, true)
					end
				end
			end

			return
		end, SFX_PANEL)
		setText(var_16_0:Find("Text"), iter_16_1[1])

		self.rarityToggles[iter_16_1[2]] = var_16_0
	end

	return
end

function CommanderIndexPage:InitDisplayName()
	self.nameToggles = {}

	for iter_18_0, iter_18_1 in ipairs(var_0_4.name) do
		local var_18_0 = cloneTplTo(self.nameTpl, self.namePanel)

		setText(var_18_0:Find("Text"), iter_18_1[1])
		onToggle(self, var_18_0, function(arg_19_0)
			if arg_19_0 then
				self.displayName = iter_18_1[2]
			end

			return
		end, SFX_PANEL)

		self.nameToggles[iter_18_1[2]] = var_18_0
	end

	return
end

function CommanderIndexPage:Show(arg_20_1)
	setActive(self._tf, true)
	self:UpdateSelected(arg_20_1)
	setParent(self._tf, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function CommanderIndexPage:UpdateSelected(arg_21_1)
	triggerToggle(self.sortToggles[arg_21_1.sortData or "Level"], true)

	local var_21_1 = arg_21_1.nationData or {}

	if #var_21_1 > 0 then
		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			triggerToggle(self.nationToggles[iter_21_1], true)
		end
	else
		triggerToggle(self.nationAllBtn, true)
	end

	local var_21_2 = arg_21_1.rarityData or {}

	if #var_21_2 > 0 then
		for iter_21_2, iter_21_3 in pairs(var_21_2) do
			triggerToggle(self.rarityToggles[iter_21_3], true)
		end
	else
		triggerToggle(self.rarityAllBtn, true)
	end

	triggerToggle(self.nameToggles[(defaultValue(arg_21_1.displayCustomName, true) or nil) and (var_0_2 or var_0_1)], true)

	return
end

function CommanderIndexPage:Reset()
	self.data = {
		displayCustomName = true,
		sortData = "Level",
		nationData = {},
		rarityData = {}
	}

	return
end

function CommanderIndexPage:Hide()
	setActive(self._tf, false)
	self:Reset()
	setParent(self._tf, self._parentTf)

	return
end

function CommanderIndexPage:OnDestroy()
	CommanderIndexPage.displayNations = nil

	return
end

return CommanderIndexPage
