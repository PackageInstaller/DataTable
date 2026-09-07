local AnniversaryIslandComposite2023Scene = class("AnniversaryIslandComposite2023Scene", import("view.base.BaseUI"))

AnniversaryIslandComposite2023Scene.FilterAll = bit.bor(1, 2)

function AnniversaryIslandComposite2023Scene:Ctor()
	AnniversaryIslandComposite2023Scene.super.Ctor(self)

	self.loader = AutoLoader.New()

	return
end

function AnniversaryIslandComposite2023Scene:getUIName()
	return "AnniversaryIslandComposite2023UI"
end

local var_0_1 = "ui/AnniversaryIslandComposite2023UI_atlas"
local var_0_2 = "ui/AtelierCommonUI_atlas"

function AnniversaryIslandComposite2023Scene:preload(arg_3_1)
	table.ParallelIpairsAsync({
		var_0_1,
		var_0_2
	}, function(arg_4_0, arg_4_1, arg_4_2)
		self.loader:LoadBundle(arg_4_1, arg_4_2)

		return
	end, arg_3_1)

	return
end

function AnniversaryIslandComposite2023Scene:init()
	self.layerFormulaList = self._tf:Find("Panel/FormulaList")
	self.layerFormulaDetail = self._tf:Find("Panel/FormulaDetail")
	self.top = self._tf:Find("Top")
	self.formulaRect = self.layerFormulaList:Find("ScrollView"):GetComponent("LScrollRect")

	setActive(self.layerFormulaList:Find("Item"), false)

	function self.formulaRect.onUpdateItem(arg_6_0, arg_6_1)
		self:UpdateFormulaListItem(arg_6_0 + 1, arg_6_1)

		return
	end

	self.formulaFilterButtons = _.map({
		1,
		2
	}, function(arg_7_0)
		return self.layerFormulaList:Find("Tabs"):GetChild(arg_7_0 - 1)
	end)
	self.lastEnv = nil
	self.env = {}
	self.listeners = {}

	setText(self.layerFormulaList:Find("Empty"), i18n("workbench_tips5"))
	setText(self.layerFormulaList:Find("Tabs/Furniture/UnSelected/Text"), i18n("word_furniture"))
	setText(self.layerFormulaList:Find("Tabs/Furniture/Selected/Text"), i18n("word_furniture"))
	setText(self.layerFormulaList:Find("Tabs/Item/UnSelected/Text"), i18n("workbench_tips7"))
	setText(self.layerFormulaList:Find("Tabs/Item/Selected/Text"), i18n("workbench_tips7"))
	setText(self.layerFormulaList:Find("Filter/Text"), i18n("workbench_tips10"))
	setText(self.layerFormulaDetail:Find("Counters/Text"), i18n("workbench_tips8"))
	setText(self.layerFormulaDetail:Find("MaterialsBG/MaterialsTitle"), i18n("workbench_tips9"))

	return
end

function AnniversaryIslandComposite2023Scene:didEnter()
	self.contextData.filterType = self.contextData.filterType or AnniversaryIslandComposite2023Scene.FilterAll

	table.Foreach(self.formulaFilterButtons, function(arg_9_0, arg_9_1)
		onButton(self, arg_9_1, function()
			local var_10_0 = bit.lshift(1, arg_9_0 - 1)

			self.contextData.filterType = self.contextData.filterType == AnniversaryIslandComposite2023Scene.FilterAll and var_10_0 or self.contextData.filterType == var_10_0 and AnniversaryIslandComposite2023Scene.FilterAll or var_10_0

			self:UpdateFilterButtons()
			self:FilterFormulas()
			self:UpdateView()

			return
		end, SFX_PANEL)

		return
	end)

	self.showOnlyComposite = PlayerPrefs.GetInt("workbench_show_composite_avaliable", 0) == 1

	triggerToggle(self.layerFormulaList:Find("Filter/Toggle"), self.showOnlyComposite)
	onToggle(self, self.layerFormulaList:Find("Filter/Toggle"), function(arg_11_0)
		self.showOnlyComposite = arg_11_0

		PlayerPrefs.SetInt("workbench_show_composite_avaliable", arg_11_0 and 1 or 0)
		PlayerPrefs.Save()
		self:FilterFormulas()
		self:UpdateView()

		return
	end)
	onButton(self, self._tf:Find("BG"), function()
		self:onBackPressed()

		return
	end)
	onButton(self, self._tf:Find("Top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/Home"), function()
		self:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("workbench_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Top/Upgrade"), function()
		self:emit(AnniversaryIslandComposite2023Mediator.OPEN_UPGRADE_PANEL)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Top/StoreHouse"), function()
		self:emit(AnniversaryIslandComposite2023Mediator.OPEN_STOREHOUSE)

		return
	end, SFX_PANEL)
	self:BindEnv({
		"filterFormulas",
		"formulas",
		"bagAct",
		"formulaId"
	}, function()
		self:UpdateFormulaList()

		return
	end)
	self:BindEnv({
		"formulaId",
		"formulas",
		"bagAct"
	}, function(arg_19_0, arg_19_1)
		self:UpdateFormulaDetail(arg_19_0[1])

		return
	end)
	self:BindEnv({
		"BuildingLv"
	}, function(arg_20_0)
		self.loader:GetSpriteQuiet("ui/AnniversaryIslandComposite2023UI_atlas", "title_" .. arg_20_0[1], self.top:Find("Title/Number"))

		return
	end)
	self:BindEnv({
		"tip"
	}, function(arg_21_0)
		setActive(self._tf:Find("Top/Upgrade/Tip"), arg_21_0[1])

		return
	end)

	self.env.formulaId = self.contextData.formulaId

	self:UpdateFilterButtons()
	self:BuildActivityEnv()
	self:UpdateView()

	return
end

function AnniversaryIslandComposite2023Scene:InitCounter(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_2[2] = math.max(arg_22_2[1], arg_22_2[2])

	local var_22_0 = arg_22_1
	local var_22_1 = self.layerFormulaDetail:Find("Counters")

	assert(var_22_1)

	local function var_22_2()
		local var_23_0 = var_22_0

		if var_22_0 == 0 then
			var_23_0 = setColorStr(var_23_0, "#f9c461")
		end

		setText(var_22_1:Find("Number"), var_23_0)
		arg_22_3(var_22_0)

		return
	end

	var_22_2()
	pressPersistTrigger(var_22_1:Find("Plus"), 0.5, function(arg_24_0)
		var_22_0 = var_22_0 + 1
		var_22_0 = math.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_22_0 == var_22_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips3"))
			arg_24_0()

			return
		end

		var_22_2()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(var_22_1:Find("Minus"), 0.5, function(arg_25_0)
		var_22_0 = var_22_0 - 1
		var_22_0 = math.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_22_0 == var_22_0 then
			arg_25_0()

			return
		end

		var_22_2()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, var_22_1:Find("Plus10"), function()
		var_22_0 = var_22_0 + 10
		var_22_0 = math.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_22_0 == var_22_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips3"))

			return
		end

		var_22_2()

		return
	end)
	onButton(self, var_22_1:Find("Minus10"), function()
		var_22_0 = var_22_0 - 10
		var_22_0 = math.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		var_22_2()

		return
	end)
	onButton(self, self.layerFormulaDetail:Find("Composite"), function()
		existCall(arg_22_4, var_22_0)

		return
	end, SFX_PANEL)

	return
end

local var_0_3 = {
	[DROP_TYPE_FURNITURE] = "word_furniture",
	[DROP_TYPE_WORKBENCH_DROP] = "workbench_tips7"
}

function AnniversaryIslandComposite2023Scene:UpdateFormulaListItem(arg_29_1, arg_29_2)
	local var_29_0 = tf(arg_29_2)
	local var_29_1 = self.env.filterFormulas[arg_29_1]
	local var_29_2 = self.env.filterFormulas[arg_29_1]:GetProduction()
	local var_29_3 = var_29_0:Find("BG/Icon")

	assert(var_29_3)
	self:UpdateActivityDrop(var_29_3, {
		type = var_29_2[1],
		id = var_29_2[2]
	}, true)

	local var_29_4 = not var_29_1:IsUnlock()

	setActive(var_29_0:Find("Lock"), var_29_4)
	setActive(var_29_0:Find("BG"), not var_29_4)

	if var_29_4 then
		setText(var_29_0:Find("Lock/Text"), var_29_1:GetLockDesc())
	end

	setText(var_29_0:Find("BG/Type"), i18n(var_0_3[var_29_2[1]]))
	setScrollText(var_29_0:Find("BG/Name/Text"), var_29_1:GetName())
	setActive(var_29_0:Find("Selected"), var_29_1:GetConfigID() == self.env.formulaId)

	local var_29_5 = var_29_1:IsAvaliable()

	setActive(var_29_0:Find("Completed"), not var_29_5)

	local var_29_6

	if var_29_1:GetMaxLimit() > 0 then
		local var_29_7 = var_29_1:GetMaxLimit() - var_29_1:GetUsedCount()

		var_29_6 = (var_29_7 <= 0 and setColorStr(var_29_7, "#bb6754") or var_29_7) .. "/" .. var_29_1:GetMaxLimit()
	else
		var_29_6 = "∞"
	end

	setText(var_29_0:Find("BG/Count"), var_29_6)
	onButton(self, var_29_0, function()
		if not var_29_5 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips1"))

			return
		end

		if var_29_4 then
			local var_30_0 = var_29_1:GetLockLimit()

			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips4", var_30_0 and var_30_0[3]))

			return
		end

		self.env.formulaId = var_29_1:GetConfigID()

		self:UpdateView()

		return
	end, SFX_PANEL)

	return
end

function AnniversaryIslandComposite2023Scene:UpdateFilterButtons()
	table.Foreach(self.formulaFilterButtons, function(arg_32_0, arg_32_1)
		local var_32_0 = self.contextData.filterType ~= AnniversaryIslandComposite2023Scene.FilterAll and bit.band(self.contextData.filterType, bit.lshift(1, arg_32_0 - 1)) > 0

		setActive(arg_32_1:Find("Selected"), var_32_0)
		setActive(arg_32_1:Find("UnSelected"), not var_32_0)

		return
	end)

	return
end

function AnniversaryIslandComposite2023Scene:BuildActivityEnv()
	self.env.formulas = _.map(pg.activity_workbench_recipe.all, function(arg_34_0)
		local var_34_0 = WorkBenchFormula.New({
			configId = arg_34_0
		})

		var_34_0:BuildFromActivity()

		return var_34_0
	end)

	if self.env.formulaId then
		local var_33_0 = _.detect(self.env.formulas, function(arg_35_0)
			return arg_35_0:GetConfigID() == self.env.formulaId
		end)

		if not var_33_0 or not var_33_0:IsAvaliable() then
			self.env.formulaId = nil
		end
	end

	self.env.bagAct = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	local var_33_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

	self.env.BuildingLv = var_33_1:GetBuildingLevel(table.keyof(AnniversaryIsland2023Scene.Buildings, "craft"))
	self.env.tip = AnniversaryIsland2023Scene.UpdateBuildingTip(nil, var_33_1, table.keyof(AnniversaryIsland2023Scene.Buildings, "craft"))

	self:FilterFormulas()

	return
end

function AnniversaryIslandComposite2023Scene:FilterFormulas()
	local var_36_0 = {}
	local var_36_1 = self.contextData.filterType

	local function var_36_2(arg_37_0)
		if var_36_1 == AnniversaryIslandComposite2023Scene.FilterAll then
			return true
		end

		return switch(arg_37_0:GetProduction()[1], {
			[DROP_TYPE_WORKBENCH_DROP] = function()
				return bit.band(var_36_1, 1) > 0
			end
		}, function()
			return bit.band(var_36_1, 2) > 0
		end)
	end

	for iter_36_0, iter_36_1 in ipairs(_.values(self.env.formulas)) do
		if var_36_2(iter_36_1) and (not self.showOnlyComposite or iter_36_1:IsUnlock() and iter_36_1:IsAvaliable() and _.all(iter_36_1:GetMaterials(), function(arg_40_0)
			return arg_40_0[3] <= self.env.bagAct:getVitemNumber(arg_40_0[2])
		end)) then
			table.insert(var_36_0, iter_36_1)
		end
	end

	table.sort(var_36_0, (CompareFuncs({
		function(arg_41_0)
			return arg_41_0:IsAvaliable() and 0 or 1
		end,
		function(arg_42_0)
			return arg_42_0:IsUnlock() and 0 or 1
		end,
		function(arg_43_0)
			return arg_43_0:GetConfigID()
		end
	})))

	self.env.filterFormulas = var_36_0

	return
end

function AnniversaryIslandComposite2023Scene:UpdateFormulaList()
	local var_44_0 = #self.env.filterFormulas == 0

	setActive(self.layerFormulaList:Find("Empty"), #self.env.filterFormulas == 0)
	setActive(self.layerFormulaList:Find("ScrollView"), not var_44_0)
	self.formulaRect:SetTotalCount(#self.env.filterFormulas)

	return
end

function AnniversaryIslandComposite2023Scene:UpdateFormulaDetail(arg_45_1)
	self.contextData.formulaId = arg_45_1

	setActive(self.layerFormulaDetail, arg_45_1)

	if not arg_45_1 then
		return
	end

	local var_45_0 = _.detect(self.env.formulas, function(arg_46_0)
		return arg_46_0:GetConfigID() == arg_45_1
	end)

	assert(var_45_0)

	local var_45_1 = var_45_0:GetProduction()
	local var_45_2 = var_45_0:GetMaterials()
	local var_45_3 = 100

	;(function()
		local var_47_0 = {
			type = var_45_1[1],
			id = var_45_1[2],
			count = var_45_1[3]
		}
		local var_47_1 = var_45_0:GetMaxLimit()

		if var_47_1 > 0 then
			var_45_3 = var_47_1 - getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH):GetFormulaUseCount(arg_45_1)
		end

		local var_47_2 = self.layerFormulaDetail:Find("Icon")

		assert(var_47_2)
		self:UpdateActivityDrop(var_47_2, var_47_0)
		onButton(self, var_47_2, function()
			if var_47_0.type == DROP_TYPE_WORKBENCH_DROP then
				self:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, WorkBenchItem.New({
					configId = var_47_0.id,
					count = var_47_0.count
				}))
			else
				self:emit(BaseUI.ON_DROP, var_47_0)
			end

			return
		end)
		setText(self.layerFormulaDetail:Find("Name"), var_47_0:getConfig("name"))

		return
	end)()

	local var_45_4 = 100
	local var_45_5 = self.env.bagAct

	UIItemList.StaticAlign(self.layerFormulaDetail:Find("Materials"), self.layerFormulaDetail:Find("Materials/Item"), #var_45_2, function(arg_49_0, arg_49_1, arg_49_2)
		if arg_49_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_49_0 = var_45_2[arg_49_1 + 1]
		local var_49_1 = {
			type = var_45_2[arg_49_1 + 1][1],
			id = var_45_2[arg_49_1 + 1][2],
			count = var_45_2[arg_49_1 + 1][3]
		}

		self:UpdateActivityDrop(arg_49_2:Find("Icon"), var_49_1)
		onButton(self, arg_49_2:Find("Icon"), function()
			if var_49_1.type == DROP_TYPE_WORKBENCH_DROP then
				self:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, WorkBenchItem.New({
					configId = var_49_1.id,
					count = var_49_1.count
				}))
			else
				self:emit(BaseUI.ON_DROP, var_49_1)
			end

			return
		end)

		if var_49_0[3] > 0 then
			var_45_4 = math.min(var_45_4, math.floor(var_45_5:getVitemNumber(var_49_0[2]) / var_49_0[3]))
		end

		return
	end)

	local function var_45_6(arg_51_0)
		UIItemList.StaticAlign(self.layerFormulaDetail:Find("Materials"), self.layerFormulaDetail:Find("Materials/Item"), #var_45_2, function(arg_52_0, arg_52_1, arg_52_2)
			if arg_52_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_52_0 = var_45_2[arg_52_1 + 1][3]
			local var_52_1 = var_45_5:getVitemNumber(var_45_2[arg_52_1 + 1][2])

			arg_51_0 = math.max(arg_51_0, 1)

			setText(arg_52_2:Find("Text"), setColorStr(var_52_1, var_52_1 < var_52_0 * arg_51_0 and "#bb6754" or "#6b5a48") .. "/" .. var_52_0 * arg_51_0)

			return
		end)

		return
	end

	local var_45_7 = math.min(1, 100)

	self:InitCounter(var_45_7, {
		0,
		100
	}, var_45_6, function(arg_53_0)
		self:emit(GAME.WORKBENCH_COMPOSITE, arg_45_1, arg_53_0)

		return
	end)
	var_45_6(var_45_7)

	return
end

function AnniversaryIslandComposite2023Scene:BindEnv(arg_54_1, arg_54_2)
	table.insert(self.listeners, {
		keys = arg_54_1,
		func = arg_54_2
	})

	return
end

function AnniversaryIslandComposite2023Scene:RefreshData()
	self.lastEnv = self.lastEnv or {}

	local var_55_0 = {}
	local var_55_1

	local function var_55_2(arg_56_0, arg_56_1)
		if var_55_0[arg_56_0] then
			return
		end

		var_55_0[arg_56_0] = arg_56_1
		var_55_1 = var_55_1 or {}

		_.each(_.select(self.listeners, function(arg_57_0)
			return table.contains(arg_57_0.keys, arg_56_0)
		end), function(arg_58_0)
			var_55_1[arg_58_0] = true

			return
		end)

		return
	end

	for iter_55_0, iter_55_1 in pairs(self.env) do
		if iter_55_1 ~= self.lastEnv[iter_55_0] then
			var_55_2(iter_55_0, iter_55_1)
		end
	end

	for iter_55_2, iter_55_3 in pairs(self.lastEnv) do
		if iter_55_3 ~= self.env[iter_55_2] then
			var_55_2(iter_55_2, self.env[iter_55_2])
		end
	end

	if nil then
		table.Foreach(nil, function(arg_59_0)
			arg_59_0.func(table.map(arg_59_0.keys, function(arg_60_0)
				return self.env[arg_60_0]
			end), (table.map(arg_59_0.keys, function(arg_61_0)
				return self.lastEnv[arg_61_0]
			end)))

			return
		end)
	end

	self.lastEnv = table.shallowCopy(self.env)

	return
end

function AnniversaryIslandComposite2023Scene:UpdateView()
	self:RefreshData()
	AnniversaryIsland2023Scene.PlayStory()

	return
end

function AnniversaryIslandComposite2023Scene:OnReceiveFormualRequest(arg_63_1)
	self.env.formulaId = arg_63_1

	self:UpdateView()

	return
end

function AnniversaryIslandComposite2023Scene:UpdateActivityDrop(arg_64_1, arg_64_2, arg_64_3)
	updateDrop(arg_64_1, arg_64_2)
	SetCompomentEnabled(arg_64_1:Find("icon_bg"), typeof(Image), false)
	setActive(arg_64_1:Find("bg"), false)
	setActive(arg_64_1:Find("icon_bg/frame"), false)
	setActive(arg_64_1:Find("icon_bg/stars"), false)

	local var_64_0 = arg_64_2:getConfig("rarity")

	if arg_64_2.type == DROP_TYPE_EQUIP or arg_64_2.type == DROP_TYPE_EQUIPMENT_SKIN then
		var_64_0 = var_64_0 - 1
	end

	local var_64_1 = "icon_frame_" .. var_64_0

	if arg_64_3 then
		var_64_1 = var_64_1 .. "_small"
	end

	self.loader:GetSpriteQuiet(var_0_2, var_64_1, arg_64_1)

	return
end

function AnniversaryIslandComposite2023Scene:willExit()
	self.loader:Clear()

	return
end

return AnniversaryIslandComposite2023Scene
