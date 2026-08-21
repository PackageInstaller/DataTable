local var_0_0 = class("RoguelikeAffixSelectView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/MatrixlUI/StrategyMatrixSelectAffixUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.customItems = {}
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.customData = {}
	arg_5_0.activity_id = arg_5_0.params_.activity_id
	arg_5_0.cfg = StrategyMatrixCfg[arg_5_0.activity_id]

	arg_5_0:MappingConfig(arg_5_0.cfg)
	arg_5_0:Refresh(true)
end

function var_0_0.Reset(arg_6_0)
	arg_6_0.customData = {}
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(arg_7_0.activity_id))
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0.gameObject_:InjectUI(arg_9_0)

	arg_9_0.affixGroupList_ = LuaList.New(handler(arg_9_0, arg_9_0.IndexGroupItem), arg_9_0.RectMonster, MatrixAffixGroupItem)
	arg_9_0.affixHeroGroupList_ = LuaList.New(handler(arg_9_0, arg_9_0.IndexGroupHeroItem), arg_9_0.RectHero, MatrixAffixGroupItem)
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.Btnbtn_ok, nil, function()
		StrategyMatrixAction.QueryStartMatrix(arg_10_0.cfg.hero_standard_system_id_list, arg_10_0.activity_id, arg_10_0.customData)
	end)
end

function var_0_0.MappingConfig(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	arg_12_0.monster_affix = {}
	arg_12_0.hero_affix = {}

	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = arg_12_1.custom_affix

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_3 = ActivityAffixPoolCfg[iter_12_1].affix
		local var_12_4 = var_12_3[1]

		if var_12_3[3] == 3 then
			if not var_12_1[var_12_4] then
				var_12_1[var_12_4] = {}
			end

			table.insert(var_12_1[var_12_4], iter_12_1)
		else
			if not var_12_0[var_12_4] then
				var_12_0[var_12_4] = {}
			end

			table.insert(var_12_0[var_12_4], iter_12_1)
		end
	end

	for iter_12_2, iter_12_3 in pairs(var_12_1) do
		table.sort(iter_12_3, function(arg_13_0, arg_13_1)
			return arg_13_1 < arg_13_0
		end)
		table.insert(arg_12_0.hero_affix, {
			id = iter_12_2,
			list = iter_12_3
		})
	end

	for iter_12_4, iter_12_5 in pairs(var_12_0) do
		table.sort(iter_12_5, function(arg_14_0, arg_14_1)
			return arg_14_1 < arg_14_0
		end)
		table.insert(arg_12_0.monster_affix, {
			id = iter_12_4,
			list = iter_12_5
		})
	end

	print("词缀长度-------------->", #arg_12_0.monster_affix, "--", #arg_12_0.hero_affix)
end

function var_0_0.GetHeroData(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = arg_15_0.cfg.hero_standard_system_id_list

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		table.insert(var_15_0, {
			hero_type = 2,
			hero_standard_system_id = iter_15_1
		})
	end

	return var_15_0
end

function var_0_0.Refresh(arg_16_0, arg_16_1)
	local var_16_0 = #arg_16_0.customData

	arg_16_0:GenerateItems(arg_16_0.customItems, #arg_16_0.customData, MatrixAffixLongItem, arg_16_0.GoItem, arg_16_0.Content)

	for iter_16_0 = 1, var_16_0 do
		local var_16_1 = arg_16_0.customData[iter_16_0]
		local var_16_2 = ActivityAffixPoolCfg[var_16_1].affix

		arg_16_0.customItems[iter_16_0]:Refresh(var_16_2, 2)
	end

	if arg_16_1 then
		arg_16_0.affixGroupList_:StartScroll(#arg_16_0.monster_affix)
		arg_16_0.affixHeroGroupList_:StartScroll(#arg_16_0.hero_affix)
	else
		arg_16_0.affixGroupList_:Refresh()
		arg_16_0.affixHeroGroupList_:Refresh()
	end

	local var_16_3 = 0
	local var_16_4 = 0

	for iter_16_1, iter_16_2 in ipairs(arg_16_0.customData) do
		local var_16_5 = ActivityAffixPoolCfg[iter_16_2]

		var_16_3 = var_16_3 + var_16_5.point
		var_16_4 = var_16_4 + var_16_5.multiple
	end

	local var_16_6 = var_16_4 / 10

	arg_16_0.TxtDifficult.text = tostring(var_16_3)
	arg_16_0.TxtRate.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_16_6 .. "%")
end

function var_0_0.IndexAffixOptionalItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.customData[arg_17_1]
	local var_17_1 = ActivityAffixPoolCfg[var_17_0].affix

	arg_17_2:Refresh(var_17_1, 2)
end

function var_0_0.IndexGroupItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.monster_affix[arg_18_1]

	arg_18_2:Refresh(var_18_0, {}, arg_18_0.customData)
	arg_18_2:RegistCallBack(handler(arg_18_0, arg_18_0.OnChooseCallBack))
end

function var_0_0.IndexGroupHeroItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.hero_affix[arg_19_1]

	arg_19_2:Refresh(var_19_0, {}, arg_19_0.customData)
	arg_19_2:RegistCallBack(handler(arg_19_0, arg_19_0.OnChooseCallBack))
end

function var_0_0.GenerateItems(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if not arg_20_0.pool then
		arg_20_0.pool = {}
	end

	local var_20_0 = #arg_20_0.pool
	local var_20_1 = #arg_20_1

	while var_20_1 < arg_20_2 do
		if var_20_0 > 0 then
			local var_20_2 = arg_20_0.pool[var_20_0]

			var_20_2.transform_:SetParent(arg_20_5)
			table.insert(arg_20_1, var_20_2)
			table.remove(arg_20_0.pool, var_20_0)
		else
			local var_20_3 = Object.Instantiate(arg_20_4, arg_20_5)
			local var_20_4 = arg_20_3.New(var_20_3)

			table.insert(arg_20_1, var_20_4)
		end

		var_20_1 = var_20_1 + 1
	end

	while arg_20_2 < var_20_1 do
		arg_20_1[var_20_1].gameObject_:SetActive(false)
		table.insert(arg_20_0.pool, arg_20_1[var_20_1])
		table.remove(arg_20_1, var_20_1)

		var_20_1 = var_20_1 - 1
	end

	for iter_20_0 = 1, var_20_1 do
		arg_20_1[iter_20_0].gameObject_:SetActive(true)
	end
end

function var_0_0.OnChooseCallBack(arg_21_0, arg_21_1)
	local var_21_0 = ActivityAffixPoolCfg[arg_21_1].affix[1]
	local var_21_1 = false

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.customData) do
		if iter_21_1 == arg_21_1 then
			table.remove(arg_21_0.customData, iter_21_0)

			var_21_1 = true

			break
		end

		if var_21_0 == ActivityAffixPoolCfg[iter_21_1].affix[1] then
			arg_21_0.customData[iter_21_0] = arg_21_1
			var_21_1 = true

			break
		end
	end

	if not var_21_1 then
		table.insert(arg_21_0.customData, 1, arg_21_1)
	end

	arg_21_0:Refresh()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.affixGroupList_:Dispose()
	arg_22_0.affixHeroGroupList_:Dispose()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.customItems) do
		iter_22_1:Dispose()
	end

	arg_22_0.customItems = {}

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
