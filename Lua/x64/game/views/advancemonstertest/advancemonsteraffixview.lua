local var_0_0 = class("AdvanceMonsterAffixView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/BossTestUI/BossTestAffixUI"
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

	arg_4_0.customDesScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.CustomDesIndexItem), arg_4_0.customDesListGo_, CustomDesItem)
	arg_4_0.emptyController_ = arg_4_0.scrollviewController_:GetController("empty")
end

function var_0_0.CustomDesIndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = #arg_5_0.defaultStageList_

	if arg_5_1 <= var_5_0 then
		arg_5_2:RefreshUI(arg_5_0.defaultStageList_[arg_5_1], true)
	else
		local var_5_1 = arg_5_0.customSelectList_[arg_5_1 - var_5_0]
		local var_5_2 = ActivityAffixPoolCfg[var_5_1].affix

		arg_5_2:RefreshUI(var_5_2, false)
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST) then
			ShowTips("TIME_OVER")

			return
		end

		AdvanceMonsterTestAction:SaveCustomList(arg_6_0.stageID_, arg_6_0.customSelectList_)
		AdvanceMonsterTestData:SetCurStageID(arg_6_0.stageID_)
		arg_6_0:Go("/sectionSelectHero", {
			section = ActivityAdvanceMonsterTestCfg[arg_6_0.stageID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST,
			activityID = ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.stageID_ = arg_8_0.params_.stageID
	arg_8_0.customSelectList_ = AdvanceMonsterTestData:GetCustomList(arg_8_0.stageID_)

	local var_8_0 = ActivityAdvanceMonsterTestCfg[arg_8_0.stageID_]
	local var_8_1 = BattleActivityAdvanceMonsterTestCfg[var_8_0.stage_id]

	arg_8_0.defaultStageList_ = var_8_1.affix_type == "" and {} or var_8_1.affix_type

	arg_8_0:CreatCustomTable()
	arg_8_0:CreatCustomSelectTable()
	arg_8_0:RefreshUI()

	arg_8_0.pages = {}

	if ActivityAdvanceMonsterTestCfg[arg_8_0.stageID_].level_describe ~= "" then
		arg_8_0.pages = ActivityAdvanceMonsterTestCfg[arg_8_0.stageID_].level_describe
	end

	local var_8_2 = AdvanceMonsterTestData:GetCurStageID()
	local var_8_3 = 1

	if var_8_2 > 0 then
		var_8_3 = ActivityAdvanceMonsterTestCfg[var_8_2].type
	end

	if getData("monsterTest", "monsterTestStage_" .. arg_8_0.stageID_) ~= "1" and #arg_8_0.pages > 0 and var_8_3 == var_8_0.type then
		saveData("monsterTest", "monsterTestStage_" .. arg_8_0.stageID_, "1")
		TimeTools.StartAfterSeconds(0.1, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = arg_8_0.pages
			})
		end, {})
	end
end

function var_0_0.CreatCustomTable(arg_10_0)
	local var_10_0 = ActivityAdvanceMonsterTestCfg[arg_10_0.stageID_].pool

	arg_10_0.customTable_ = {
		all = {}
	}

	local var_10_1

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_2 = ActivityAffixPoolCfg[iter_10_1]

		if var_10_2 then
			if not arg_10_0.customTable_[var_10_2.affix[1]] then
				arg_10_0.customTable_[var_10_2.affix[1]] = {}

				table.insert(arg_10_0.customTable_.all, var_10_2.affix[1])
			end

			table.insert(arg_10_0.customTable_[var_10_2.affix[1]], iter_10_1)
		end
	end
end

function var_0_0.CreatCustomSelectTable(arg_11_0)
	local var_11_0

	arg_11_0.customSelectTable_ = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.customSelectList_) do
		local var_11_1 = ActivityAffixPoolCfg[iter_11_1]

		arg_11_0.customSelectTable_[var_11_1.affix[1]] = iter_11_1
	end
end

function var_0_0.GetSelectCustom(arg_12_0, arg_12_1)
	if arg_12_0.customSelectTable_[arg_12_1] then
		return arg_12_0.customSelectTable_[arg_12_1]
	end

	return nil
end

function var_0_0.SetSelectCustom(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.customSelectTable_[arg_13_1]

	if var_13_0 then
		table.remove(arg_13_0.customSelectList_, table.indexof(arg_13_0.customSelectList_, var_13_0))
	end

	if arg_13_2 then
		arg_13_0.customSelectTable_[arg_13_1] = arg_13_2

		table.insert(arg_13_0.customSelectList_, arg_13_2)
	else
		arg_13_0.customSelectTable_[arg_13_1] = nil
	end
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:CalculatePoint()
	arg_14_0:RefreshDesList(true)
	arg_14_0:InitMultipleAffixList()
	arg_14_0:CustomAffixListUpdate()
end

function var_0_0.InitMultipleAffixList(arg_15_0)
	local var_15_0 = ActivityAdvanceMonsterTestCfg[arg_15_0.stageID_]
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_0.pool) do
		var_15_1[ActivityAffixPoolCfg[iter_15_1].affix[1]] = true
	end

	local var_15_2 = {}
	local var_15_3 = {}

	for iter_15_2, iter_15_3 in pairs(var_15_0.multiple_affix) do
		local var_15_4 = ActivityAffixPoolCfg[iter_15_3]
		local var_15_5 = var_15_4.affix[1]
		local var_15_6 = var_15_3[var_15_5]

		if not var_15_6 then
			var_15_3[var_15_5] = iter_15_3
		elseif var_15_4.affix[2] > ActivityAffixPoolCfg[var_15_6].affix[2] then
			var_15_3[var_15_5] = iter_15_3
		end
	end

	for iter_15_4, iter_15_5 in ipairs(var_15_0.multiple_affix) do
		local var_15_7 = ActivityAffixPoolCfg[iter_15_5].affix[1]

		if var_15_3[var_15_7] == iter_15_5 and not var_15_1[var_15_7] then
			table.insert(var_15_2, iter_15_5)
		end
	end

	arg_15_0.multipleAffixList = var_15_2
end

function var_0_0.CustomMultipleAffixUpdate(arg_16_0)
	local var_16_0 = arg_16_0.multipleAffixList

	if not arg_16_0.multipleAffixItem then
		arg_16_0.multipleAffixItem = arg_16_0:CreateMultipleAffixCustomItem()
	end

	SetActive(arg_16_0.multipleAffixItem.gameObject_, false)

	if var_16_0 and #var_16_0 > 0 then
		SetActive(arg_16_0.multipleAffixItem.gameObject_, true)
		arg_16_0.multipleAffixItem:RefreshUI(var_16_0, arg_16_0.customSelectList_)
	end
end

function var_0_0.CustomAffixListUpdate(arg_17_0)
	arg_17_0:CustomMultipleAffixUpdate()

	if not arg_17_0.customAffixList then
		arg_17_0.customAffixList = {}
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.customAffixList or {}) do
		SetActive(iter_17_1.gameObject_, false)
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0.customTable_.all) do
		if not arg_17_0.customAffixList[iter_17_2] then
			arg_17_0.customAffixList[iter_17_2] = arg_17_0:CreateAffixCustomItem()
		end

		local var_17_0 = arg_17_0.customAffixList[iter_17_2]

		SetActive(var_17_0.gameObject_, true)

		local var_17_1 = arg_17_0.customTable_.all[iter_17_2]
		local var_17_2 = arg_17_0:GetSelectCustom(var_17_1)

		var_17_0:RefreshUI(var_17_1, arg_17_0.customTable_[var_17_1], var_17_2)
	end

	if (arg_17_0.multipleAffixList and #arg_17_0.multipleAffixList or 0) + (arg_17_0.customTable_.all and #arg_17_0.customTable_.all or 0) > 0 then
		arg_17_0.emptyController_:SetSelectedState("false")
	else
		arg_17_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.CreateAffixCustomItem(arg_18_0)
	local var_18_0 = GameObject.Instantiate(arg_18_0.affixGroupGo_, arg_18_0.affixContent_)
	local var_18_1 = CustomBox.New(var_18_0)

	var_18_1:RegisterClickListener(function(arg_19_0)
		local var_19_0 = ActivityAffixPoolCfg[arg_19_0].affix[1]

		if arg_18_0:GetSelectCustom(var_19_0) ~= arg_19_0 then
			arg_18_0:SetSelectCustom(var_19_0, arg_19_0)
		else
			arg_18_0:SetSelectCustom(var_19_0)
		end

		var_18_1:RefreshUI(var_19_0, arg_18_0.customTable_[var_19_0], arg_18_0:GetSelectCustom(var_19_0))
		arg_18_0:CalculatePoint()
		arg_18_0:RefreshDesList(false, arg_19_0)
	end)

	return var_18_1
end

function var_0_0.CreateMultipleAffixCustomItem(arg_20_0)
	local var_20_0 = GameObject.Instantiate(arg_20_0.affixMultipleGroupGo_, arg_20_0.affixContent_)
	local var_20_1 = AdvanceMonsterMultipleAffixItem.New(var_20_0)

	var_20_1:RegisterClickListener(function(arg_21_0)
		local var_21_0 = ActivityAffixPoolCfg[arg_21_0].affix[1]

		arg_20_0:SelectMultipleCustom(arg_21_0)

		local var_21_1 = ActivityAdvanceMonsterTestCfg[arg_20_0.stageID_]

		var_20_1:RefreshUI(arg_20_0.multipleAffixList, arg_20_0.customSelectList_)
		arg_20_0:CalculatePoint()
		arg_20_0:RefreshDesList(false, arg_21_0)
	end)

	return var_20_1
end

function var_0_0.SelectMultipleCustom(arg_22_0, arg_22_1)
	local var_22_0 = table.indexof(arg_22_0.customSelectList_, arg_22_1)

	if var_22_0 then
		table.remove(arg_22_0.customSelectList_, var_22_0)
	else
		table.insert(arg_22_0.customSelectList_, arg_22_1)
	end
end

function var_0_0.CalculatePoint(arg_23_0)
	local var_23_0
	local var_23_1 = ActivityAdvanceMonsterTestCfg[arg_23_0.stageID_].base_point

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.customSelectList_) do
		var_23_1 = var_23_1 + ActivityAffixPoolCfg[iter_23_1].point
	end

	arg_23_0.pointText_.text = string.format("<color=#FE972E>%d</color>", var_23_1)
end

function var_0_0.RefreshDesList(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 then
		arg_24_0.customDesScrollHelper_:StartScroll(#arg_24_0.defaultStageList_ + #arg_24_0.customSelectList_)
	else
		local var_24_0 = table.indexof(arg_24_0.customSelectList_, arg_24_2)

		if var_24_0 then
			arg_24_0.customDesScrollHelper_:StartScroll(#arg_24_0.defaultStageList_ + #arg_24_0.customSelectList_, #arg_24_0.defaultStageList_ + var_24_0)
		else
			arg_24_0.customDesScrollHelper_:StartScrollByPosition(#arg_24_0.defaultStageList_ + #arg_24_0.customSelectList_, arg_24_0.customDesScrollHelper_:GetScrolledPosition())
		end
	end
end

function var_0_0.OnTop(arg_25_0)
	if #arg_25_0.pages > 0 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:RegistHomeCallBack(function()
		AdvanceMonsterTestAction:SaveCustomList(arg_25_0.stageID_, arg_25_0.customSelectList_)
		arg_25_0:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistBackCallBack(function()
		AdvanceMonsterTestAction:SaveCustomList(arg_25_0.stageID_, arg_25_0.customSelectList_)
		arg_25_0:Back()
	end)
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = arg_25_0.pages
		})
	end)
end

function var_0_0.OnExit(arg_29_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_30_0)
	var_0_0.super.Dispose(arg_30_0)

	if arg_30_0.customDesScrollHelper_ then
		arg_30_0.customDesScrollHelper_:Dispose()

		arg_30_0.customDesScrollHelper_ = nil
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_0.customAffixList) do
		if iter_30_1 then
			iter_30_1:Dispose()

			iter_30_1 = nil
		end
	end

	if arg_30_0.multipleAffixItem then
		arg_30_0.multipleAffixItem:Dispose()

		arg_30_0.multipleAffixItem = nil
	end
end

return var_0_0
