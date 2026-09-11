local SPHeroChallengeMainView = class("SPHeroChallengeMainView", ReduxView)

function SPHeroChallengeMainView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeMainUI"
end

function SPHeroChallengeMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SPHeroChallengeMainView:OnCtor()
	return
end

function SPHeroChallengeMainView:Init()
	self:InitUI()
	self:AddUIListener()

	self.scheduleList = {}

	for iter_4_0 = 1, SpHeroChallengeConst.scheduleNum do
		self.scheduleList[iter_4_0] = SPHeroChallengeScheduleItem.New(self["scheduleitem" .. iter_4_0 .. "Btn_"].gameObject)
	end
end

function SPHeroChallengeMainView:InitUI()
	self:BindCfgUI()
	self:InitController()

	self.timeLine2 = self.canvasGo_:GetComponent("PlayableDirector")
end

function SPHeroChallengeMainView:FinPlayable()
	if self.timeLine2 then
		self.timeLine2:Stop()
	end
end

function SPHeroChallengeMainView:InitController()
	self.entrustController = {}

	for iter_7_0 = 1, SPHeroChallengeTools:GetMaxStartEntrustPosNum((SPHeroChallengeData:GetActivityID())) do
		self.entrustController[iter_7_0] = self["entrust" .. iter_7_0 .. "Con"]:GetController("State")
	end

	self.spAwardController = self.spAwardCon:GetController("chipState")
	self.scheduleController = self.scheduleCon:GetController("Finish")
	self.bossOpenController = self.bossopenCon:GetController("bossOpen")
	self.animator = self.middleGo_:GetComponent("Animator")
	self.scheduleSelectController = self.scheduleCon:GetController("Select")
	self.miniGameSelectController = self.entrustCon:GetController("Select")
	self.scheduleAniamtor = self.scheduleShowCon:GetComponent("Animator")
	self.miniGameAniamtor = self.miniGameCon:GetComponent("Animator")
end

function SPHeroChallengeMainView:OnEnter()
	self.activityID = SPHeroChallengeData:GetActivityID()
	self.activityInfo = SPHeroChallengeData:GetCurActivityInfo()

	if self.activityInfo then
		self.scheduleInfo = self.activityInfo.curScheduleList
	end

	local var_8_0 = self.curButtonState

	if not self.curButtonState then
		var_8_0 = SPHeroChallengeData:GetPageState()
		var_8_0 = var_8_0 or "schedule"
	end

	self.curButtonState = var_8_0
	self.isOpenFlag = true

	self:StartTimeLine()
	self:RegisterEvents()
	self:RefreshView()
	self:RefreshBar()
	self:BindRedPonit()
	self:StartEnterTimer()
	self:RefreshSelectState()
end

function SPHeroChallengeMainView:OnTop()
	self:RefreshBar()
end

function SPHeroChallengeMainView:StartTimeLine()
	if self.curButtonState == "schedule" then
		-- block empty
	else
		self.timeLine2:Play()
	end
end

function SPHeroChallengeMainView:BindRedPonit()
	manager.redPoint:bindUIandKey(self.entrustBtn_.transform, RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST)
	manager.redPoint:bindUIandKey(self.heroChipBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].heroChipActivityID))
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].taskActivityID))
end

function SPHeroChallengeMainView:UnBindRedPonit()
	manager.redPoint:unbindUIandKey(self.entrustBtn_.transform, RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST)
	manager.redPoint:unbindUIandKey(self.heroChipBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].heroChipActivityID))
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].taskActivityID))
end

function SPHeroChallengeMainView:GotoHelp()
	JumpTools.OpenPageByJump("gameHelpPro", {
		isPrefab = true,
		pages = (GameSetting.hero_challenge_game_describe1 or nil) and (GameSetting.hero_challenge_game_describe1.value or {})
	})
end

function SPHeroChallengeMainView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1, true)
	manager.windowBar:SetGameHelpKey(SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].helpKey)
end

function SPHeroChallengeMainView:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPonit()
	self:RemoveAllEventListener()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	AnimatorTools.Stop()
	self:FinPlayable()
	SPHeroChallengeData:SavePageState(self.curButtonState)
end

function SPHeroChallengeMainView:AddUIListener()
	self:AddBtnListenerScale(self.trainBtn_, nil, function()
		if not self.playAnimation then
			JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
				groupIndex = SpHeroChallengeConst.ChapterType.story
			})
		end
	end)
	self:AddBtnListenerScale(self.shopBtn_, nil, function()
		if self.activityID and not self.playAnimation then
			JumpTools.GoToSystem("/activityShop", {
				shopId = SPHeroChallengeData.activityCfg[self.activityID].shopID,
				showShops = {
					SPHeroChallengeData.activityCfg[self.activityID].shopID
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	self:AddBtnListenerScale(self.heroChipBtn_, nil, function()
		if self.activityID and not self.playAnimation then
			JumpTools.OpenPageByJump("spHeroChallengeHeroChipTaskView", {
				activityID = SPHeroChallengeData.activityCfg[self.activityID].heroChipActivityID
			})
		end
	end)
	self:AddBtnListenerScale(self.taskBtn_, nil, function()
		if self.activityID and not self.playAnimation then
			JumpTools.OpenPageByJump("spHeroChallengeActivityTaskView", {
				activityID = SPHeroChallengeData.activityCfg[self.activityID].taskActivityID
			})
		end
	end)
	self:AddBtnListenerScale(self.scheduleBtn_, nil, function()
		if self.curButtonState == "schedule" then
			if self.activityInfo:CheckCurScheduleFinish() and not self.activityInfo:CheckDailyScheduleAwardReceived() then
				SPHeroChallengeAction:GetScheduleAward()
			else
				JumpTools.OpenPageByJump("/spHeroChallengeScheduleView")
			end

			return
		end

		if not self.playAnimation then
			if self.curButtonState == "schedule" then
				self:ShowBtnList("schedule", not self.isOpenFlag)
			else
				self:ExchangePosition()
			end
		end
	end)

	for iter_16_0 = 1, SpHeroChallengeConst.scheduleNum do
		if not self.playAnimation then
			self:AddBtnListener(self["scheduleitem" .. iter_16_0 .. "Btn_"], nil, function()
				self:ClickScheduleItem(iter_16_0)
			end)
		end
	end

	self:AddBtnListenerScale(self.miniGameBtn_, nil, function()
		if not self.playAnimation then
			if self.curButtonState == "miniGame" then
				self:ShowBtnList("miniGame", not self.isOpenFlag)
			else
				self:ExchangePosition()
			end
		end
	end)
	self:AddBtnListenerScale(self.entrustBtn_, nil, function()
		if not self.playAnimation then
			JumpTools.OpenPageByJump("/spHeroChallengeEntrustView")
		end
	end)
	self:AddBtnListenerScale(self.barbecueBtn_, nil, function()
		if not self.playAnimation then
			SPHeroChallengeTools:JumpSystemByScheduleType(SpHeroChallengeConst.ScheduleSubType.barbuce, nil, self.curButtonState)
		end
	end)
	self:AddBtnListenerScale(self.mysteryBtn_, nil, function()
		if not self.playAnimation then
			SPHeroChallengeTools:JumpSystemByScheduleType(SpHeroChallengeConst.ScheduleSubType.decode)
		end
	end)

	for iter_16_1, iter_16_2 in ipairs({
		self.scheduleBtn_.gameObject,
		self.miniGameBtn_.gameObject,
		self.scorllbtnBtn_.gameObject
	}) do
		self:AddPressByTimeListener(iter_16_2, 0.2, function()
			return
		end, function(arg_28_0, arg_28_1, arg_28_2)
			if arg_28_0 == self.scheduleBtn_.gameObject and self.curButtonState == "miniGame" then
				return
			end

			if arg_28_0 == self.miniGameBtn_.gameObject and self.curButtonState == "schedule" then
				return
			end

			if not self.playAnimation then
				self:StartDrag()
			end
		end, function(arg_29_0, arg_29_1, arg_29_2)
			self:EndDrag()
		end)
		self:AddDragListener(iter_16_2, function()
			return
		end, function()
			self:OnDrag()
		end, function()
			return
		end)
	end
end

function SPHeroChallengeMainView:StartDrag()
	self.startPos = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
end

function SPHeroChallengeMainView:EndDrag()
	self.startPos = nil
end

function SPHeroChallengeMainView:OnDrag()
	if self.startPos then
		local var_35_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)

		if MathTools.GetDistance(self.startPos, var_35_0) > GameDisplayCfg.activity_hero_challenge_slide.value[1] then
			self.playAnimation = true

			if (self.startPos - var_35_0).y < 0 then
				if self.curButtonState == "schedule" then
					self.miniGameSelectController:SetSelectedState("closeTrain")
					self:ShowBtnList("schedule", false, function()
						AnimatorTools.PlayAnimatorWithCallback(self.animator, "Fx_startScheduleList_counterclockwise", function()
							self:ShowBtnList("miniGame", true)

							self.curButtonState = "miniGame"

							self:RefreshSelectState()
						end, false)
					end)
				else
					self:ShowBtnList("miniGame", false, function()
						AnimatorTools.PlayAnimatorWithCallback(self.animator, "Fx_miniGameList_counterclockwise", function()
							self:ShowBtnList("schedule", true)

							self.curButtonState = "schedule"

							self:RefreshSelectState()
						end, false)
					end)
				end
			elseif self.curButtonState == "schedule" then
				self.miniGameSelectController:SetSelectedState("closeTrain")
				self:ShowBtnList("schedule", false, function()
					AnimatorTools.PlayAnimatorWithCallback(self.animator, "Fx_miniGameList_clockwise", function()
						self:ShowBtnList("miniGame", true)

						self.curButtonState = "miniGame"

						self:RefreshSelectState()
					end, false)
				end)
			else
				self:ShowBtnList("miniGame", false, function()
					AnimatorTools.PlayAnimatorWithCallback(self.animator, "Fx_startScheduleList_clockwise", function()
						self:ShowBtnList("schedule", true)

						self.curButtonState = "schedule"

						self:RefreshSelectState()
					end, false)
				end)
			end

			self:EndDrag()
		end
	end
end

function SPHeroChallengeMainView:RegisterEvents()
	self:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_SCHEDULE, function()
		self:RefreshView()
	end)
	self:RegistEventListener(SP_HERO_CHALLENGE_GET_SCHEDULE_AWARD, function()
		self:RefreshScheduleState()
	end)
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshHeroChipInfo()
	end)
	self:RegistEventListener(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM, function()
		self:RefreshView()
	end)
end

function SPHeroChallengeMainView:Dispose()
	if self.scheduleList then
		for iter_49_0, iter_49_1 in pairs(self.scheduleList) do
			iter_49_1:Dispose()
		end

		self.scheduleList = nil
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	AnimatorTools.Stop()
	self:FinPlayable()
	SPHeroChallengeMainView.super.Dispose(self)
end

function SPHeroChallengeMainView:RefreshView()
	self:RefreshHeroChipInfo()
	self:RefreshButtonLayer()
	self:RefreshEntrustState()
	self:RefreshScheduleState()
	self:RefreshBossOpenState()
end

function SPHeroChallengeMainView:RefreshAutoInfo()
	if SPHeroChallengeTools:ShowAutoScheduleTips(self.activityID) then
		local var_51_0 = getData("SPHeroChallenge", "AutoTime")
		local var_51_1 = manager.time:GetServerTime()

		if not var_51_0 or not manager.time:CheckIsToday(var_51_0, var_51_1) then
			saveData("SPHeroChallenge", "AutoTime", var_51_1)
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_AUTO_TIPS"),
				OkCallback = function()
					SPHeroChallengeTools:AutoChooseSchedule()
					SPHeroChallengeAction:ConfirmScheduleList(self.activityInfo:GetScheduleDailyList(), true)
				end,
				CancelCallback = function()
					JumpTools.OpenPageByJump("/spHeroChallengeScheduleView")
				end
			})
		end
	end
end

function SPHeroChallengeMainView:RefreshHeroChipInfo()
	local var_54_0, var_54_1, var_54_2, var_54_3 = self.activityInfo:CheckCanGetHeroChipTaskAward()

	if var_54_1 then
		self.spAwardController:SetSelectedState("received")
	elseif var_54_3 < var_54_2 then
		self.spAwardController:SetSelectedState("unavaliable")
	else
		self.spAwardController:SetSelectedState("obtainable")
	end

	self.heroChipText.text = string.format(GetTips("ACTIVITY_HERO_CLUE_COLLECT"), tostring(var_54_3), tostring(var_54_2))
end

function SPHeroChallengeMainView:RefreshBossOpenState()
	if ActivityData:GetActivityIsOpen(SPHeroChallengeData.activityCfg[self.activityID].bossActivityID) and self.activityInfo.bossStart then
		self.bossOpenController:SetSelectedState("open")
	else
		self.bossOpenController:SetSelectedState("close")
	end
end

function SPHeroChallengeMainView:RefreshButtonLayer()
	if self.isOpenFlag then
		self:RefreshEntrustState()
		self:RefreshScheduleList()
	end
end

function SPHeroChallengeMainView:ShowBtnList(arg_57_1, arg_57_2, arg_57_3)
	self.playAnimation = true

	if arg_57_1 == "schedule" then
		if arg_57_2 then
			AnimatorTools.PlayAnimatorWithCallback(self.scheduleAniamtor, "Fx_activityHeroChallengeScheduleBtn_cx", function()
				if arg_57_3 then
					arg_57_3()
				else
					self.playAnimation = false
				end
			end, false)
		else
			AnimatorTools.PlayAnimatorWithCallback(self.scheduleAniamtor, "Fx_activityHeroChallengeScheduleBtn_xs", function()
				if arg_57_3 then
					arg_57_3()
				else
					self.playAnimation = false
				end
			end, false)
		end
	elseif arg_57_1 == "miniGame" then
		if arg_57_2 then
			AnimatorTools.PlayAnimatorWithCallback(self.miniGameAniamtor, "Fx_activityHeroChallengeMiniGameBtn_cx", function()
				if arg_57_3 then
					arg_57_3()
				else
					self.playAnimation = false
				end
			end, false)
		else
			AnimatorTools.PlayAnimatorWithCallback(self.miniGameAniamtor, "Fx_activityHeroChallengeMiniGameBtn_xs", function()
				if arg_57_3 then
					arg_57_3()
				else
					self.playAnimation = false
				end
			end, false)
		end
	end

	self.isOpenFlag = arg_57_2

	self:RefreshButtonLayer()
end

function SPHeroChallengeMainView:RefreshScheduleList()
	if self.scheduleList then
		for iter_62_0, iter_62_1 in pairs(self.scheduleList) do
			iter_62_1:RefreshUI(iter_62_0)
		end
	end
end

function SPHeroChallengeMainView:RefreshEntrustState()
	for iter_63_0 = 1, SPHeroChallengeTools:GetMaxStartEntrustPosNum(self.activityID) do
		local var_63_1 = SPHeroChallengeTools:GetEntrustPosState(self.activityID, iter_63_0)

		if self.entrustController and self.entrustController[iter_63_0] then
			self.entrustController[iter_63_0]:SetSelectedState(var_63_1)

			if var_63_1 == SpHeroChallengeConst.EntrustPosState.empty or var_63_1 == SpHeroChallengeConst.EntrustPosState.fin then
				-- block empty
			end
		end
	end
end

function SPHeroChallengeMainView:RefreshScheduleState()
	if self.activityInfo:CheckCurScheduleFinish() then
		if self.activityInfo:CheckDailyScheduleAwardReceived() then
			self.scheduleController:SetSelectedState("recived")
		else
			self.scheduleController:SetSelectedState("award")
		end
	else
		self.scheduleController:SetSelectedState("none")
	end
end

function SPHeroChallengeMainView:ClickScheduleItem(arg_65_1)
	if self.scheduleInfo and self.scheduleInfo[arg_65_1] then
		if self.scheduleInfo[arg_65_1].isFinish then
			return
		end

		SPHeroChallengeTools:JumpSystemByScheduleType(ActivityHeroChallengeScheduleCfg[self.scheduleInfo[arg_65_1].scheduleID].server_type, true, self.curButtonState)
	else
		JumpTools.OpenPageByJump("/spHeroChallengeScheduleView")
	end
end

function SPHeroChallengeMainView:StartEnterTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.playAnimation = true
	self.timer = Timer.New(function()
		self.timer:Stop()

		self.timer = nil
		self.playAnimation = false
	end, 1, 1)

	self.timer:Start()
end

function SPHeroChallengeMainView:ExchangePosition()
	if self.curButtonState == "schedule" then
		self.miniGameSelectController:SetSelectedState("closeTrain")
		self:ShowBtnList("schedule", false, function()
			self.playAnimation = true

			AnimatorTools.PlayAnimatorWithCallback(self.animator, "Fx_miniGameList_clockwise", function()
				self:ShowBtnList("miniGame", true)

				self.curButtonState = "miniGame"

				self:RefreshSelectState()
			end, false)
		end)
	else
		self:ShowBtnList("miniGame", false, function()
			self.playAnimation = true

			AnimatorTools.PlayAnimatorWithCallback(self.animator, "Fx_startScheduleList_clockwise", function()
				self:ShowBtnList("schedule", true)

				self.curButtonState = "schedule"

				self:RefreshSelectState()
			end, false)
		end)
	end
end

function SPHeroChallengeMainView:RefreshSelectState()
	if self.curButtonState == "schedule" then
		self.scheduleSelectController:SetSelectedState("Selected")

		if SPHeroChallengeTools:CheckBossActivityIsOpen() then
			self.miniGameSelectController:SetSelectedState("UnSelected")
		else
			self.miniGameSelectController:SetSelectedState("closeTrain")
		end
	else
		self.scheduleSelectController:SetSelectedState("UnSelected")
		self.miniGameSelectController:SetSelectedState("Selected")
	end
end

return SPHeroChallengeMainView
