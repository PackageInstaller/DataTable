local var_0_0 = class("AnniversaryIslandComposite2023Scene", import("view.base.BaseUI"))

var_0_0.FilterAll = bit.bor(1, 2)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.loader = AutoLoader.New()

	return
end

function var_0_0.getUIName(arg_2_0)
	return "AnniversaryIslandComposite2023UI"
end

local var_0_1 = "ui/AnniversaryIslandComposite2023UI_atlas"
local var_0_2 = "ui/AtelierCommonUI_atlas"

function var_0_0.preload(arg_3_0, arg_3_1)
	table.ParallelIpairsAsync({
		var_0_1,
		var_0_2
	}, function(arg_4_0, arg_4_1, arg_4_2)
		arg_3_0.loader:LoadBundle(arg_4_1, arg_4_2)

		return
	end, arg_3_1)

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.layerFormulaList = arg_5_0._tf:Find("Panel/FormulaList")
	arg_5_0.layerFormulaDetail = arg_5_0._tf:Find("Panel/FormulaDetail")
	arg_5_0.top = arg_5_0._tf:Find("Top")
	arg_5_0.formulaRect = arg_5_0.layerFormulaList:Find("ScrollView"):GetComponent("LScrollRect")

	setActive(arg_5_0.layerFormulaList:Find("Item"), false)

	function arg_5_0.formulaRect.onUpdateItem(arg_6_0, arg_6_1)
		arg_5_0:UpdateFormulaListItem(arg_6_0 + 1, arg_6_1)

		return
	end

	arg_5_0.formulaFilterButtons = _.map({
		1,
		2
	}, function(arg_7_0)
		return arg_5_0.layerFormulaList:Find("Tabs"):GetChild(arg_7_0 - 1)
	end)
	arg_5_0.lastEnv = nil
	arg_5_0.env = {}
	arg_5_0.listeners = {}

	setText(arg_5_0.layerFormulaList:Find("Empty"), i18n("workbench_tips5"))
	setText(arg_5_0.layerFormulaList:Find("Tabs/Furniture/UnSelected/Text"), i18n("word_furniture"))
	setText(arg_5_0.layerFormulaList:Find("Tabs/Furniture/Selected/Text"), i18n("word_furniture"))
	setText(arg_5_0.layerFormulaList:Find("Tabs/Item/UnSelected/Text"), i18n("workbench_tips7"))
	setText(arg_5_0.layerFormulaList:Find("Tabs/Item/Selected/Text"), i18n("workbench_tips7"))
	setText(arg_5_0.layerFormulaList:Find("Filter/Text"), i18n("workbench_tips10"))
	setText(arg_5_0.layerFormulaDetail:Find("Counters/Text"), i18n("workbench_tips8"))
	setText(arg_5_0.layerFormulaDetail:Find("MaterialsBG/MaterialsTitle"), i18n("workbench_tips9"))

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0.contextData.filterType = arg_8_0.contextData.filterType or var_0_0.FilterAll

	table.Foreach(arg_8_0.formulaFilterButtons, function(arg_9_0, arg_9_1)
		onButton(arg_8_0, arg_9_1, function()
			local var_10_0 = bit.lshift(1, arg_9_0 - 1)

			arg_8_0.contextData.filterType = arg_8_0.contextData.filterType == var_0_0.FilterAll and var_10_0 or arg_8_0.contextData.filterType == var_10_0 and var_0_0.FilterAll or var_10_0

			arg_8_0:UpdateFilterButtons()
			arg_8_0:FilterFormulas()
			arg_8_0:UpdateView()

			return
		end, SFX_PANEL)

		return
	end)

	arg_8_0.showOnlyComposite = PlayerPrefs.GetInt("workbench_show_composite_avaliable", 0) == 1

	triggerToggle(arg_8_0.layerFormulaList:Find("Filter/Toggle"), arg_8_0.showOnlyComposite)
	onToggle(arg_8_0, arg_8_0.layerFormulaList:Find("Filter/Toggle"), function(arg_11_0)
		arg_8_0.showOnlyComposite = arg_11_0

		PlayerPrefs.SetInt("workbench_show_composite_avaliable", arg_11_0 and 1 or 0)
		PlayerPrefs.Save()
		arg_8_0:FilterFormulas()
		arg_8_0:UpdateView()

		return
	end)
	onButton(arg_8_0, arg_8_0._tf:Find("BG"), function()
		arg_8_0:onBackPressed()

		return
	end)
	onButton(arg_8_0, arg_8_0._tf:Find("Top/Back"), function()
		arg_8_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0._tf:Find("Top/Home"), function()
		arg_8_0:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("workbench_help")
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._tf:Find("Top/Upgrade"), function()
		arg_8_0:emit(AnniversaryIslandComposite2023Mediator.OPEN_UPGRADE_PANEL)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._tf:Find("Top/StoreHouse"), function()
		arg_8_0:emit(AnniversaryIslandComposite2023Mediator.OPEN_STOREHOUSE)

		return
	end, SFX_PANEL)
	arg_8_0:BindEnv({
		"filterFormulas",
		"formulas",
		"bagAct",
		"formulaId"
	}, function()
		arg_8_0:UpdateFormulaList()

		return
	end)
	arg_8_0:BindEnv({
		"formulaId",
		"formulas",
		"bagAct"
	}, function(arg_19_0, arg_19_1)
		arg_8_0:UpdateFormulaDetail(arg_19_0[1])

		return
	end)
	arg_8_0:BindEnv({
		"BuildingLv"
	}, function(arg_20_0)
		arg_8_0.loader:GetSpriteQuiet("ui/AnniversaryIslandComposite2023UI_atlas", "title_" .. arg_20_0[1], arg_8_0.top:Find("Title/Number"))

		return
	end)
	arg_8_0:BindEnv({
		"tip"
	}, function(arg_21_0)
		setActive(arg_8_0._tf:Find("Top/Upgrade/Tip"), arg_21_0[1])

		return
	end)

	arg_8_0.env.formulaId = arg_8_0.contextData.formulaId

	arg_8_0:UpdateFilterButtons()
	arg_8_0:BuildActivityEnv()
	arg_8_0:UpdateView()

	return
end

function var_0_0.InitCounter(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_2[2] = math.max(arg_22_2[1], arg_22_2[2])

	local var_22_0 = arg_22_1
	local var_22_1 = arg_22_0.layerFormulaDetail:Find("Counters")

	assert(var_22_1)
	;(function()
		local var_23_0 = var_22_0

		if var_22_0 == 0 then
			var_23_0 = setColorStr(var_23_0, "#f9c461")
		end

		setText(var_22_1:Find("Number"), var_23_0)
		arg_22_3(var_22_0)

		return
	end)()
	pressPersistTrigger(var_22_1:Find("Plus"), 0.5, function(arg_24_0)
		var_22_0 = var_22_0 + 1
		var_22_0 = math.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_22_0 == var_22_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips3"))
			arg_24_0()

			return
		end

		var_0()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(var_22_1:Find("Minus"), 0.5, function(arg_25_0)
		var_22_0 = var_22_0 - 1
		var_22_0 = math.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_22_0 == var_22_0 then
			arg_25_0()

			return
		end

		var_0()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_22_0, var_22_1:Find("Plus10"), function()
		var_22_0 = var_22_0 + 10
		var_22_0 = math.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_22_0 == var_22_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips3"))

			return
		end

		var_0()

		return
	end)
	onButton(arg_22_0, var_22_1:Find("Minus10"), function()
		var_22_0 = var_22_0 - 10
		var_22_0 = math.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		var_0()

		return
	end)
	onButton(arg_22_0, arg_22_0.layerFormulaDetail:Find("Composite"), function()
		existCall(arg_22_4, var_22_0)

		return
	end, SFX_PANEL)

	return
end

local var_0_3 = {
	[DROP_TYPE_FURNITURE] = "word_furniture",
	[DROP_TYPE_WORKBENCH_DROP] = "workbench_tips7"
}

function var_0_0.UpdateFormulaListItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = tf(arg_29_2)
	local var_29_1 = arg_29_0.env.filterFormulas[arg_29_1]
	local var_29_2 = arg_29_0.env.filterFormulas[arg_29_1]:GetProduction()
	local var_29_3 = var_29_0:Find("BG/Icon")

	assert(var_29_3)
	arg_29_0:UpdateActivityDrop(var_29_3, {
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
	setActive(var_29_0:Find("Selected"), var_29_1:GetConfigID() == arg_29_0.env.formulaId)
	setActive(var_29_0:Find("Completed"), not var_29_1:IsAvaliable())

	local var_29_5

	if var_29_1:GetMaxLimit() > 0 then
		local var_29_6 = var_29_1:GetMaxLimit() - var_29_1:GetUsedCount()
		local var_29_7 = var_29_6 <= 0 and setColorStr(var_29_6, "#bb6754") or var_29_6

		var_29_5 = var_29_7 .. "/" .. var_29_1:GetMaxLimit()
	else
		var_29_5 = "∞"
	end

	setText(var_29_0:Find("BG/Count"), var_29_5)
	onButton(arg_29_0, var_29_0, function()
		if not var_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips1"))

			return
		end

		if var_29_4 then
			local var_30_0 = var_29_1:GetLockLimit()

			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips4", var_30_0 and var_30_0[3]))

			return
		end

		arg_29_0.env.formulaId = var_29_1:GetConfigID()

		arg_29_0:UpdateView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateFilterButtons(arg_31_0)
	table.Foreach(arg_31_0.formulaFilterButtons, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_31_0.contextData.filterType ~= var_0_0.FilterAll and bit.band(arg_31_0.contextData.filterType, bit.lshift(1, arg_32_0 - 1)) > 0

		setActive(arg_32_1:Find("Selected"), var_32_0)
		setActive(arg_32_1:Find("UnSelected"), not var_32_0)

		return
	end)

	return
end

function var_0_0.BuildActivityEnv(arg_33_0)
	arg_33_0.env.formulas = _.map(pg.activity_workbench_recipe.all, function(arg_34_0)
		local var_34_0 = WorkBenchFormula.New({
			configId = arg_34_0
		})

		var_34_0:BuildFromActivity()

		return var_34_0
	end)

	if arg_33_0.env.formulaId then
		local var_33_0 = _.detect(arg_33_0.env.formulas, function(arg_35_0)
			return arg_35_0:GetConfigID() == arg_33_0.env.formulaId
		end)

		if not var_33_0 or not var_33_0:IsAvaliable() then
			arg_33_0.env.formulaId = nil
		end
	end

	arg_33_0.env.bagAct = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	local var_33_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

	arg_33_0.env.BuildingLv = var_33_1:GetBuildingLevel(table.keyof(AnniversaryIsland2023Scene.Buildings, "craft"))
	arg_33_0.env.tip = AnniversaryIsland2023Scene.UpdateBuildingTip(nil, var_33_1, table.keyof(AnniversaryIsland2023Scene.Buildings, "craft"))

	arg_33_0:FilterFormulas()

	return
end

function var_0_0.FilterFormulas(arg_36_0)
	local var_36_0 = arg_36_0.contextData.filterType

	for iter_36_0, iter_36_1 in ipairs(_.values(arg_36_0.env.formulas)) do
		if (function(arg_37_0)
			if var_36_0 == var_0_0.FilterAll then
				return true
			end

			return switch(arg_37_0:GetProduction()[1], {
				[DROP_TYPE_WORKBENCH_DROP] = function()
					return bit.band(var_36_0, 1) > 0
				end
			}, function()
				return bit.band(var_36_0, 2) > 0
			end)
		end)(iter_36_1) and (not arg_36_0.showOnlyComposite or iter_36_1:IsUnlock() and iter_36_1:IsAvaliable() and _.all(iter_36_1:GetMaterials(), function(arg_40_0)
			return arg_40_0[3] <= arg_36_0.env.bagAct:getVitemNumber(arg_40_0[2])
		end)) then
			table.insert({}, iter_36_1)
		end
	end

	table.sort({}, (CompareFuncs({
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

	arg_36_0.env.filterFormulas = {}

	return
end

function var_0_0.UpdateFormulaList(arg_44_0)
	local var_44_0 = #arg_44_0.env.filterFormulas == 0

	setActive(arg_44_0.layerFormulaList:Find("Empty"), #arg_44_0.env.filterFormulas == 0)
	setActive(arg_44_0.layerFormulaList:Find("ScrollView"), not var_44_0)
	arg_44_0.formulaRect:SetTotalCount(#arg_44_0.env.filterFormulas)

	return
end

function var_0_0.UpdateFormulaDetail(arg_45_0, arg_45_1)
	arg_45_0.contextData.formulaId = arg_45_1

	setActive(arg_45_0.layerFormulaDetail, arg_45_1)

	if not arg_45_1 then
		return
	end

	local var_45_0 = _.detect(arg_45_0.env.formulas, function(arg_46_0)
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

		local var_47_2 = arg_45_0.layerFormulaDetail:Find("Icon")

		assert(var_47_2)
		arg_45_0:UpdateActivityDrop(var_47_2, {
			type = var_45_1[1],
			id = var_45_1[2],
			count = var_45_1[3]
		})
		onButton(arg_45_0, var_47_2, function()
			if var_47_0.type == DROP_TYPE_WORKBENCH_DROP then
				arg_45_0:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, WorkBenchItem.New({
					configId = var_47_0.id,
					count = var_47_0.count
				}))
			else
				arg_45_0:emit(BaseUI.ON_DROP, var_47_0)
			end

			return
		end)
		setText(arg_45_0.layerFormulaDetail:Find("Name"), ({
			type = var_45_1[1],
			id = var_45_1[2],
			count = var_45_1[3]
		}):getConfig("name"))

		return
	end)()

	local var_45_4 = 100
	local var_45_5 = arg_45_0.env.bagAct

	UIItemList.StaticAlign(arg_45_0.layerFormulaDetail:Find("Materials"), arg_45_0.layerFormulaDetail:Find("Materials/Item"), #var_45_0:GetMaterials(), function(arg_49_0, arg_49_1, arg_49_2)
		if arg_49_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_49_0 = var_45_2[arg_49_1 + 1]

		arg_45_0:UpdateActivityDrop(arg_49_2:Find("Icon"), {
			type = var_45_2[arg_49_1 + 1][1],
			id = var_45_2[arg_49_1 + 1][2],
			count = var_45_2[arg_49_1 + 1][3]
		})
		onButton(arg_45_0, arg_49_2:Find("Icon"), function()
			if var_0.type == DROP_TYPE_WORKBENCH_DROP then
				arg_45_0:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, WorkBenchItem.New({
					configId = var_0.id,
					count = var_0.count
				}))
			else
				arg_45_0:emit(BaseUI.ON_DROP, var_0)
			end

			return
		end)

		if var_49_0[3] > 0 then
			var_45_4 = math.min(var_45_4, math.floor(var_45_5:getVitemNumber(var_49_0[2]) / var_49_0[3]))
		end

		return
	end)

	local var_45_6 = math.min(1, 100)

	arg_45_0:InitCounter(var_45_6, {
		0,
		100
	}, function(arg_51_0)
		UIItemList.StaticAlign(arg_45_0.layerFormulaDetail:Find("Materials"), arg_45_0.layerFormulaDetail:Find("Materials/Item"), #var_45_2, function(arg_52_0, arg_52_1, arg_52_2)
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
	end, function(arg_53_0)
		arg_45_0:emit(GAME.WORKBENCH_COMPOSITE, arg_45_1, arg_53_0)

		return
	end)
	;(function(arg_51_0)
		UIItemList.StaticAlign(arg_45_0.layerFormulaDetail:Find("Materials"), arg_45_0.layerFormulaDetail:Find("Materials/Item"), #var_45_2, function(arg_52_0, arg_52_1, arg_52_2)
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
	end)(var_45_6)

	return
end

function var_0_0.BindEnv(arg_54_0, arg_54_1, arg_54_2)
	table.insert(arg_54_0.listeners, {
		keys = arg_54_1,
		func = arg_54_2
	})

	return
end

function var_0_0.RefreshData(arg_55_0)
	arg_55_0.lastEnv = arg_55_0.lastEnv or {}

	local var_55_0 = {}
	local var_55_1

	for iter_55_0, iter_55_1 in pairs(arg_55_0.env) do
		if iter_55_1 ~= arg_55_0.lastEnv[iter_55_0] then
			(function(arg_56_0, arg_56_1)
				if var_55_0[arg_56_0] then
					return
				end

				var_55_0[arg_56_0] = arg_56_1
				var_55_1 = var_55_1 or {}

				_.each(_.select(arg_55_0.listeners, function(arg_57_0)
					return table.contains(arg_57_0.keys, arg_56_0)
				end), function(arg_58_0)
					var_55_1[arg_58_0] = true

					return
				end)

				return
			end)(iter_55_0, iter_55_1)
		end
	end

	for iter_55_2, iter_55_3 in pairs(arg_55_0.lastEnv) do
		if iter_55_3 ~= arg_55_0.env[iter_55_2] then
			(function(arg_56_0, arg_56_1)
				if var_55_0[arg_56_0] then
					return
				end

				var_55_0[arg_56_0] = arg_56_1
				var_55_1 = var_55_1 or {}

				_.each(_.select(arg_55_0.listeners, function(arg_57_0)
					return table.contains(arg_57_0.keys, arg_56_0)
				end), function(arg_58_0)
					var_55_1[arg_58_0] = true

					return
				end)

				return
			end)(iter_55_2, arg_55_0.env[iter_55_2])
		end
	end

	if nil then
		table.Foreach(nil, function(arg_59_0)
			arg_59_0.func(table.map(arg_59_0.keys, function(arg_60_0)
				return arg_55_0.env[arg_60_0]
			end), (table.map(arg_59_0.keys, function(arg_61_0)
				return arg_55_0.lastEnv[arg_61_0]
			end)))

			return
		end)
	end

	arg_55_0.lastEnv = table.shallowCopy(arg_55_0.env)

	return
end

function var_0_0.UpdateView(arg_62_0)
	arg_62_0:RefreshData()
	AnniversaryIsland2023Scene.PlayStory()

	return
end

function var_0_0.OnReceiveFormualRequest(arg_63_0, arg_63_1)
	arg_63_0.env.formulaId = arg_63_1

	arg_63_0:UpdateView()

	return
end

function var_0_0.UpdateActivityDrop(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
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

	arg_64_0.loader:GetSpriteQuiet(var_0_2, var_64_1, arg_64_1)

	return
end

function var_0_0.willExit(arg_65_0)
	arg_65_0.loader:Clear()

	return
end

return var_0_0
