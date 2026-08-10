local var_0_0 = class("AdvanceTestMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/AdvancetestingUI/AtestingMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.bossItem_ = AdvanceTestBossItem.New(arg_3_0.bossItem_)
	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
	arg_3_0.clickItemHandler = handler(arg_3_0, arg_3_0.ChooseItemMode)
	arg_3_0.clickBossBtnHandler = handler(arg_3_0, arg_3_0.ClickBtn)

	arg_3_0.bossItem_:RegistClickFunc(arg_3_0.clickBossBtnHandler)

	arg_3_0.subStageList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexSubStageItem), arg_3_0.m_list, AdvanceTestMainItem)
end

function var_0_0.IndexSubStageItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.subStageIDList[arg_4_1]

	arg_4_2:RefreshUI(var_4_0, arg_4_0.chooseSubStageID_, arg_4_0.mainActivityID_)
	arg_4_2:RegistClickFunc(arg_4_0.clickItemHandler)
end

function var_0_0.ChooseItemMode(arg_5_0, arg_5_1)
	arg_5_0.chooseSubStageID_ = arg_5_1

	arg_5_0:RefreshUI()
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	arg_6_0.mainActivityID_ = arg_6_0.params_.activityID

	AdvanceTestData:SetCacheActivityID(arg_6_0.mainActivityID_)

	local var_6_0 = ActivityData:GetActivityData(arg_6_0.mainActivityID_)

	arg_6_0.startTime_ = var_6_0.startTime
	arg_6_0.stopTime_ = var_6_0.stopTime
	arg_6_0.chooseSubStageID_ = AdvanceTestData:GetLastSelectIndex(arg_6_0.mainActivityID_)
	arg_6_0.goBtn_.enabled = false

	AdvanceTestData:InitDefalutHeroList()
	manager.windowBar:RegistBackCallBack(function()
		if arg_6_0.selectController_:GetSelectedState() == "detail" then
			arg_6_0.selectController_:SetSelectedState("list")
		else
			JumpTools.Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		arg_6_0.selectController_:SetSelectedState("list")
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:SetGameHelpKey(GetTips("TEST_CHALLENGE_DESCRIBE"))

	arg_6_0.subStageIDList = {}
	arg_6_0.subStageIDList = AdvanceTestCfg.get_id_list_by_activity_id[arg_6_0.mainActivityID_]

	arg_6_0.subStageList_:StartScroll(#arg_6_0.subStageIDList)
	arg_6_0:RefreshUI()
	arg_6_0:AddTimer()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0.chooseSubStageID_ = nil

	arg_9_0.selectController_:SetSelectedState("list")

	arg_9_0.panelAni_.enabled = true

	arg_9_0:StopTimer()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	arg_10_0.bossItem_:Dispose()

	arg_10_0.clickItemHandler = nil

	arg_10_0.subStageList_:Dispose()
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.goBtn_, nil, function()
		arg_11_0.selectController_:SetSelectedState("detail")
	end)
	arg_11_0:AddBtnListener(arg_11_0.rankBtn_, nil, function()
		local var_13_0 = AdvanceTestData:GetCurActivityID()
		local var_13_1 = manager.time:GetServerTime()
		local var_13_2 = AdvanceTestCfg[arg_11_0.chooseSubStageID_]

		if var_13_0 ~= 0 then
			local var_13_3 = ActivityData:GetActivityData(var_13_0)
			local var_13_4 = var_13_3.stopTime

			if var_13_1 > var_13_3.startTime and var_13_1 < var_13_4 then
				gameContext:Go("/advanceTestRank", {
					activityID = var_13_0,
					stageType = var_13_2.stage_type
				})

				return
			end
		end

		ShowTips("SOLO_NOT_OPEN")
	end)
end

function var_0_0.ClickBtn(arg_14_0)
	AdvanceTestData:SetLastSelectIndex(arg_14_0.chooseSubStageID_, arg_14_0.mainActivityID_)

	local var_14_0 = AdvanceTestCfg[arg_14_0.chooseSubStageID_]

	AdvanceTestData:SetHeroListByDifficult(var_14_0.stage_type, arg_14_0.mainActivityID_)

	local var_14_1 = var_14_0.stage_type

	if var_14_1 <= 3 then
		gameContext:Go("/sectionSelectHero", {
			section = var_14_0.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST,
			stageDifficult = var_14_0.stage_type,
			activityID = arg_14_0.mainActivityID_,
			dest = var_14_0.id
		})
	elseif var_14_1 == 4 then
		gameContext:Go("/advanceTest4AffixSelect", {
			stageID = var_14_0.id,
			activityID = arg_14_0.mainActivityID_
		})
	elseif var_14_1 == 5 then
		gameContext:Go("/advanceTest5AffixSelect", {
			stageID = var_14_0.id,
			activityID = arg_14_0.mainActivityID_
		})
	else
		gameContext:Go("/sectionSelectHero", {
			section = var_14_0.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST,
			stageDifficult = var_14_0.stage_type,
			activityID = arg_14_0.mainActivityID_,
			dest = var_14_0.id
		})
	end
end

function var_0_0.RefreshUI(arg_15_0)
	SetActive(arg_15_0.panelGo_, true)

	local var_15_0 = AdvanceTestCfg[arg_15_0.chooseSubStageID_]
	local var_15_1 = var_15_0.stage_type

	if var_15_1 <= 3 then
		local var_15_2 = {
			"SS",
			"SSS",
			"Ω"
		}
		local var_15_3 = string.split(GetTips("TEST_CHALLENGE_TIPS_1"), ",")

		if var_15_3 ~= nil then
			arg_15_0.tipTopText_.text = string.format(var_15_3[1], var_15_2[var_15_1])

			if var_15_0.admin_chip_level == nil or var_15_0.admin_chip_level == -1 then
				arg_15_0.tipBottomText_.text = string.format(var_15_3[2], var_15_0.weapon)
			elseif var_15_0.admin_chip_level == 0 then
				arg_15_0.tipBottomText_.text = string.format(var_15_3[2], var_15_0.weapon) .. "," .. GetTips("TEST_CHALLENGE_STAGE_DES_6")
			else
				arg_15_0.tipBottomText_.text = string.format(var_15_3[2], var_15_0.weapon) .. "," .. GetTipsF("TEST_CHALLENGE_STAGE_DES_7", var_15_0.admin_chip_level)
			end
		end
	else
		arg_15_0.tipTopText_.text = GetTips("TEST_CHALLENGE_STAGE_DES_4")

		if var_15_0.admin_chip_level == nil or var_15_0.admin_chip_level == -1 then
			arg_15_0.tipBottomText_.text = ""
		elseif var_15_0.admin_chip_level == 0 then
			arg_15_0.tipBottomText_.text = GetTips("TEST_CHALLENGE_STAGE_DES_6")
		else
			arg_15_0.tipBottomText_.text = GetTipsF("TEST_CHALLENGE_STAGE_DES_7", var_15_0.admin_chip_level)
		end
	end

	arg_15_0.subStageList_:Refresh()
	arg_15_0.bossItem_:RefreshUI(arg_15_0.chooseSubStageID_)
end

function var_0_0.AddTimer(arg_16_0)
	arg_16_0:StopTimer()

	arg_16_0.leftTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(arg_16_0.stopTime_, nil, true)
	arg_16_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_16_0.stopTime_ then
			return
		end

		arg_16_0.leftTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(arg_16_0.stopTime_, nil, true)
	end, 1, -1)

	arg_16_0.timer_:Start()

	arg_16_0.aniTimer_ = Timer.New(function()
		arg_16_0.panelAni_.enabled = false
		arg_16_0.goBtn_.enabled = true
	end, 0.5, 1)

	arg_16_0.aniTimer_:Start()
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

return var_0_0
