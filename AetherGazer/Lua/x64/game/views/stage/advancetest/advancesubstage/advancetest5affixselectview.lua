local var_0_0 = class("AdvanceTest5AffixSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/AdvanceTest/AdvanceTest_StageType5UI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.showTipController = arg_4_0.controller_:GetController("showTips")
	arg_4_0.buffList = LuaList.New(handler(arg_4_0, arg_4_0.IndexBuffItem), arg_4_0.bufflList_, AdvanceTest5AffixSelectItem)
	arg_4_0.deBuffList = LuaList.New(handler(arg_4_0, arg_4_0.IndexDeBuffItem), arg_4_0.debuffList_, AdvanceTest5AffixSelectItem)
	arg_4_0.clickAffixHandler = handler(arg_4_0, arg_4_0.ClickAffix)
	arg_4_0.selectAffixHandler = handler(arg_4_0, arg_4_0.SelectAffix)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0.showTipController:SetSelectedIndex(0)

		arg_5_0.showSelectGen = 0

		arg_5_0.buffList:Refresh()
		arg_5_0.deBuffList:Refresh()
	end)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		local var_7_0 = AdvanceTestCfg[arg_5_0.subStageID]

		gameContext:Go("/sectionSelectHero", {
			section = var_7_0.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST,
			stageDifficult = var_7_0.stage_type,
			activityID = arg_5_0.mainActivityID_,
			dest = var_7_0.id
		})
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.subStageID = arg_9_0.params_.stageID
	arg_9_0.select_affix = AdvanceTestData:GetSelectGen(arg_9_0.subStageID)
	arg_9_0.mainActivityID_ = arg_9_0.params_.activityID
	arg_9_0.showSelectGen = 0

	arg_9_0.showTipController:SetSelectedIndex(0)

	arg_9_0.maxCost = GameSetting.test_challenge_core_mode2_cost_num.value[1]
	arg_9_0.activityID = arg_9_0.params_.activityID

	local var_9_0 = AdvanceTestCfg[arg_9_0.subStageID]

	arg_9_0.titleText_.text = var_9_0.stage_name

	local var_9_1 = AdvanceTestData:GetHistortyMaxScoreByIndex(var_9_0.stage_type, arg_9_0.mainActivityID_)

	if var_9_1 == -1 or var_9_1 == 0 then
		arg_9_0.scoreText_.text = "--"
	else
		arg_9_0.scoreText_.text = var_9_1
	end

	arg_9_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/Bgbc", var_9_0.stage_target))

	local var_9_2 = var_9_0.affix_id ~= "" and var_9_0.affix_id[1] or 0

	if ActivityAffixPoolCfg[var_9_2] then
		local var_9_3 = ActivityAffixPoolCfg[var_9_2].affix

		arg_9_0.comAffixName_.text = getAffixName(var_9_3)
		arg_9_0.comAffixDesc_.text = getAffixDesc(var_9_3)
	else
		arg_9_0.comAffixName_.text = ""
		arg_9_0.comAffixDesc_.text = ""
	end

	local var_9_4 = var_9_0.affix_id ~= "" and var_9_0.affix_id[2] or 0

	if ActivityAffixPoolCfg[var_9_4] then
		local var_9_5 = ActivityAffixPoolCfg[var_9_4].affix

		arg_9_0.stageAffixName_.text = getAffixName(var_9_5)
		arg_9_0.stageAffixDesc_.text = getAffixDesc(var_9_5)
		arg_9_0.stageAffixImg_.sprite = getAffixSprite(var_9_5)
	else
		arg_9_0.stageAffixName_.text = ""
		arg_9_0.stageAffixDesc_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.bufflList_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.debuffList_.transform)
	TimeTools.StartAfterSeconds(0.033, function()
		if var_9_0.affix_buff == "" then
			arg_9_0.buffList:StartScroll(0)
		else
			arg_9_0.affix_buff = var_9_0.affix_buff

			arg_9_0.buffList:StartScroll(#arg_9_0.affix_buff)
		end

		if var_9_0.affix_debuff == "" then
			arg_9_0.deBuffList:StartScroll(0)
		else
			arg_9_0.affix_debuff = var_9_0.affix_debuff

			arg_9_0.deBuffList:StartScroll(#arg_9_0.affix_debuff)
		end

		arg_9_0:RefreshUI(true)
	end, {})
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()

	arg_11_0.showSelectGen = 0

	arg_11_0.showTipController:SetSelectedIndex(0)
	arg_11_0:RecordSelect()
end

function var_0_0.RecordSelect(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.select_affix) do
		local var_12_1 = math.floor(iter_12_1 / 100)
		local var_12_2 = iter_12_1 % 100
		local var_12_3 = (var_12_1 == 0 and arg_12_0.affix_buff or arg_12_0.affix_debuff)[var_12_2][1]

		table.insert(var_12_0, var_12_3)
	end

	AdvanceTestData:RecordSelectAffix(arg_12_0.subStageID, arg_12_0.select_affix, var_12_0)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.buffList:Dispose()
	arg_13_0.deBuffList:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.RefreshUI(arg_14_0, arg_14_1)
	local var_14_0 = 100
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.select_affix) do
		local var_14_2 = math.floor(iter_14_1 / 100)
		local var_14_3 = iter_14_1 % 100
		local var_14_4 = (var_14_2 == 0 and arg_14_0.affix_buff or arg_14_0.affix_debuff)[var_14_3][1]
		local var_14_5 = ActivityAffixPoolCfg[var_14_4].point * 10

		var_14_1 = var_14_1 + ActivityAffixPoolCfg[var_14_4].point

		if var_14_2 == 1 then
			var_14_0 = var_14_0 + var_14_5
		end
	end

	arg_14_0.efficiencyNum_.text = var_14_0 .. "%"

	if not arg_14_1 then
		arg_14_0.buffList:Refresh()
		arg_14_0.deBuffList:Refresh()
	end

	arg_14_0.limitNumText_.text = var_14_1 .. "/" .. arg_14_0.maxCost
end

function var_0_0.ShowTipsView(arg_15_0, arg_15_1)
	arg_15_0.showTipController:SetSelectedIndex(1)

	local var_15_0 = ActivityAffixPoolCfg[arg_15_1].affix

	arg_15_0.tipsNameText_.text = getAffixName(var_15_0)
	arg_15_0.tipsDescText_.text = getAffixDesc(var_15_0)
	arg_15_0.tipsLimitText_.text = ActivityAffixPoolCfg[arg_15_1].point

	arg_15_0.buffList:Refresh()
	arg_15_0.deBuffList:Refresh()
end

function var_0_0.IndexBuffItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.affix_buff[arg_16_1]
	local var_16_1 = 0 + arg_16_1
	local var_16_2 = table.indexof(arg_16_0.select_affix, var_16_1)

	arg_16_2:RefreshUI(arg_16_1, var_16_0, 0, var_16_2 ~= false, arg_16_0.showSelectGen == var_16_1)
	arg_16_2:RegisterClickListener(arg_16_0.clickAffixHandler)
	arg_16_2:RegisterSelectListener(arg_16_0.selectAffixHandler)
end

function var_0_0.IndexDeBuffItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.affix_debuff[arg_17_1]
	local var_17_1 = 100 + arg_17_1
	local var_17_2 = table.indexof(arg_17_0.select_affix, var_17_1)

	arg_17_2:RefreshUI(arg_17_1, var_17_0, 1, var_17_2 ~= false, arg_17_0.showSelectGen == var_17_1)
	arg_17_2:RegisterClickListener(arg_17_0.clickAffixHandler)
	arg_17_2:RegisterSelectListener(arg_17_0.selectAffixHandler)
end

function var_0_0.IndexSelectItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.select_affix[arg_18_1]
	local var_18_1 = math.floor(var_18_0 / 100)
	local var_18_2 = var_18_0 % 100
	local var_18_3 = (var_18_1 == 0 and arg_18_0.affix_buff or arg_18_0.affix_debuff)[var_18_2][1]

	arg_18_2:SetData(arg_18_1, var_18_3, var_18_1)
end

function var_0_0.ClickAffix(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_2 * 100 + arg_19_1

	if arg_19_0.showSelectGen == var_19_0 then
		arg_19_0.showTipController:SetSelectedIndex(0)
		arg_19_0:RefreshUI()

		arg_19_0.showSelectGen = 0
	else
		arg_19_0.showSelectGen = var_19_0

		arg_19_0:ShowTipsView(arg_19_3)
	end
end

function var_0_0.SelectAffix(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2 * 100 + arg_20_1
	local var_20_1 = table.indexof(arg_20_0.select_affix, var_20_0)

	if var_20_1 then
		table.remove(arg_20_0.select_affix, var_20_1)
		arg_20_0:RefreshUI()
	else
		local var_20_2 = 0

		for iter_20_0, iter_20_1 in pairs(arg_20_0.select_affix) do
			local var_20_3 = math.floor(iter_20_1 / 100)
			local var_20_4 = iter_20_1 % 100
			local var_20_5 = (var_20_3 == 0 and arg_20_0.affix_buff or arg_20_0.affix_debuff)[var_20_4]
			local var_20_6 = var_20_5[1]
			local var_20_7 = var_20_5[2]

			var_20_2 = var_20_2 + ActivityAffixPoolCfg[var_20_6].point
		end

		local var_20_8 = (arg_20_2 == 0 and arg_20_0.affix_buff or arg_20_0.affix_debuff)[arg_20_1]
		local var_20_9 = var_20_8[1]
		local var_20_10 = var_20_8[2]

		if var_20_2 + ActivityAffixPoolCfg[var_20_9].point > arg_20_0.maxCost then
			ShowTips("CORE_VERIFICATION_CL_COST_OVERLIMIT")

			return
		end

		table.insert(arg_20_0.select_affix, var_20_0)
		arg_20_0:RefreshUI()
	end
end

return var_0_0
