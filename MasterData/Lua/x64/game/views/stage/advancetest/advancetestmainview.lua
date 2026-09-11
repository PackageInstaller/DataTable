local AdvanceTestMainView = class("AdvanceTestMainView", ReduxView)

function AdvanceTestMainView:UIName()
	return "UI/AdvancetestingUI/AtestingMainUI"
end

function AdvanceTestMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AdvanceTestMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.bossItem_ = AdvanceTestBossItem.New(self.bossItem_)
	self.selectController_ = ControllerUtil.GetController(self.transform_, "status")
	self.clickItemHandler = handler(self, self.ChooseItemMode)
	self.clickBossBtnHandler = handler(self, self.ClickBtn)

	self.bossItem_:RegistClickFunc(self.clickBossBtnHandler)

	self.subStageList_ = LuaList.New(handler(self, self.IndexSubStageItem), self.m_list, AdvanceTestMainItem)
end

function AdvanceTestMainView:IndexSubStageItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(self.subStageIDList[arg_4_1], self.chooseSubStageID_, self.mainActivityID_)
	arg_4_2:RegistClickFunc(self.clickItemHandler)
end

function AdvanceTestMainView:ChooseItemMode(arg_5_1)
	self.chooseSubStageID_ = arg_5_1

	self:RefreshUI()
end

function AdvanceTestMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	self.mainActivityID_ = self.params_.activityID

	AdvanceTestData:SetCacheActivityID(self.mainActivityID_)

	local var_6_0 = ActivityData:GetActivityData(self.mainActivityID_)

	self.startTime_ = var_6_0.startTime
	self.stopTime_ = var_6_0.stopTime
	self.chooseSubStageID_ = AdvanceTestData:GetLastSelectIndex(self.mainActivityID_)
	self.goBtn_.enabled = false

	AdvanceTestData:InitDefalutHeroList()
	manager.windowBar:RegistBackCallBack(function()
		if self.selectController_:GetSelectedState() == "detail" then
			self.selectController_:SetSelectedState("list")
		else
			JumpTools.Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self.selectController_:SetSelectedState("list")
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:SetGameHelpKey(GetTips("TEST_CHALLENGE_DESCRIBE"))

	self.subStageIDList = {}
	self.subStageIDList = AdvanceTestCfg.get_id_list_by_activity_id[self.mainActivityID_]

	self.subStageList_:StartScroll(#self.subStageIDList)
	self:RefreshUI()
	self:AddTimer()
end

function AdvanceTestMainView:OnExit()
	self.chooseSubStageID_ = nil

	self.selectController_:SetSelectedState("list")

	self.panelAni_.enabled = true

	self:StopTimer()
	manager.windowBar:HideBar()
end

function AdvanceTestMainView:Dispose()
	AdvanceTestMainView.super.Dispose(self)
	self.bossItem_:Dispose()

	self.clickItemHandler = nil

	self.subStageList_:Dispose()
end

function AdvanceTestMainView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		self.selectController_:SetSelectedState("detail")
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		local var_13_0 = AdvanceTestData:GetCurActivityID()
		local var_13_1 = manager.time:GetServerTime()

		if var_13_0 ~= 0 then
			local var_13_2 = ActivityData:GetActivityData(var_13_0)

			if var_13_1 > var_13_2.startTime and var_13_1 < var_13_2.stopTime then
				gameContext:Go("/advanceTestRank", {
					activityID = var_13_0,
					stageType = AdvanceTestCfg[self.chooseSubStageID_].stage_type
				})

				return
			end
		end

		ShowTips("SOLO_NOT_OPEN")
	end)
end

function AdvanceTestMainView:ClickBtn()
	AdvanceTestData:SetLastSelectIndex(self.chooseSubStageID_, self.mainActivityID_)
	AdvanceTestData:SetHeroListByDifficult(AdvanceTestCfg[self.chooseSubStageID_].stage_type, self.mainActivityID_)

	if AdvanceTestCfg[self.chooseSubStageID_].stage_type <= 3 then
		gameContext:Go("/sectionSelectHero", {
			section = AdvanceTestCfg[self.chooseSubStageID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST,
			stageDifficult = AdvanceTestCfg[self.chooseSubStageID_].stage_type,
			activityID = self.mainActivityID_,
			dest = AdvanceTestCfg[self.chooseSubStageID_].id
		})
	elseif AdvanceTestCfg[self.chooseSubStageID_].stage_type == 4 then
		gameContext:Go("/advanceTest4AffixSelect", {
			stageID = AdvanceTestCfg[self.chooseSubStageID_].id,
			activityID = self.mainActivityID_
		})
	elseif AdvanceTestCfg[self.chooseSubStageID_].stage_type == 5 then
		gameContext:Go("/advanceTest5AffixSelect", {
			stageID = AdvanceTestCfg[self.chooseSubStageID_].id,
			activityID = self.mainActivityID_
		})
	else
		gameContext:Go("/sectionSelectHero", {
			section = AdvanceTestCfg[self.chooseSubStageID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST,
			stageDifficult = AdvanceTestCfg[self.chooseSubStageID_].stage_type,
			activityID = self.mainActivityID_,
			dest = AdvanceTestCfg[self.chooseSubStageID_].id
		})
	end
end

function AdvanceTestMainView:RefreshUI()
	SetActive(self.panelGo_, true)

	if AdvanceTestCfg[self.chooseSubStageID_].stage_type <= 3 then
		local var_15_0 = string.split(GetTips("TEST_CHALLENGE_TIPS_1"), ",")

		if var_15_0 ~= nil then
			self.tipTopText_.text = string.format(var_15_0[1], ({
				"SS",
				"SSS",
				"Ω"
			})[AdvanceTestCfg[self.chooseSubStageID_].stage_type])
			self.tipBottomText_.text = (AdvanceTestCfg[self.chooseSubStageID_].admin_chip_level == nil or AdvanceTestCfg[self.chooseSubStageID_].admin_chip_level == -1) and string.format(var_15_0[2], AdvanceTestCfg[self.chooseSubStageID_].weapon) or AdvanceTestCfg[self.chooseSubStageID_].admin_chip_level == 0 and string.format(var_15_0[2], AdvanceTestCfg[self.chooseSubStageID_].weapon) .. "," .. GetTips("TEST_CHALLENGE_STAGE_DES_6") or string.format(var_15_0[2], AdvanceTestCfg[self.chooseSubStageID_].weapon) .. "," .. GetTipsF("TEST_CHALLENGE_STAGE_DES_7", AdvanceTestCfg[self.chooseSubStageID_].admin_chip_level)
		end
	else
		self.tipTopText_.text = GetTips("TEST_CHALLENGE_STAGE_DES_4")
		self.tipBottomText_.text = (AdvanceTestCfg[self.chooseSubStageID_].admin_chip_level == nil or AdvanceTestCfg[self.chooseSubStageID_].admin_chip_level == -1) and "" or AdvanceTestCfg[self.chooseSubStageID_].admin_chip_level == 0 and GetTips("TEST_CHALLENGE_STAGE_DES_6") or GetTipsF("TEST_CHALLENGE_STAGE_DES_7", AdvanceTestCfg[self.chooseSubStageID_].admin_chip_level)
	end

	self.subStageList_:Refresh()
	self.bossItem_:RefreshUI(self.chooseSubStageID_)
end

function AdvanceTestMainView:AddTimer()
	self:StopTimer()

	self.leftTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self.leftTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	end, 1, -1)

	self.timer_:Start()

	self.aniTimer_ = Timer.New(function()
		self.panelAni_.enabled = false
		self.goBtn_.enabled = true
	end, 0.5, 1)

	self.aniTimer_:Start()
end

function AdvanceTestMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return AdvanceTestMainView
