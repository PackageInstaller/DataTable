local AbyssMainView = class("AbyssMainView", ReduxView)

function AbyssMainView:UIName()
	return "Widget/System/Challenge_Abyss/AbyssMainUI"
end

function AbyssMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AbyssMainView:OnCtor()
	return
end

function AbyssMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssMainView:InitUI()
	self:BindCfgUI()

	self.stageController_ = ControllerUtil.GetController(self.gameObject_.transform, "stage")
	self.unlockController_ = ControllerUtil.GetController(self.challengeGo_.transform, "unlock")
	self.levelNumController_ = ControllerUtil.GetController(self.gameObject_.transform, "levelNum")
	self.resetGrayedController_ = ControllerUtil.GetController(self.resetBtn_.transform, "grayed")
	self.levelItems_ = {}

	for iter_5_0, iter_5_1 in ipairs({
		self.levelGo1_,
		self.levelGo2_,
		self.levelGo3_,
		self.levelGo4_,
		self.levelGo5_
	}) do
		table.insert(self.levelItems_, (AbyssLevelItemView.New(iter_5_1)))
	end

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, AbyssListItemView)
	self.levelView_ = AbyssLevelView.New(self.bossGo_)
end

function AbyssMainView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.layerCfgIdList_[arg_6_1], handler(self, self.OnItemClick))
	arg_6_2:SetSelect(AbyssCfg[self.layerCfgIdList_[arg_6_1]].level == self.curLayer_)
end

function AbyssMainView:OnItemClick(arg_7_1)
	if self:SelectLayer(arg_7_1) then
		self:ReplayLayerTimeline()
	end
end

function AbyssMainView:ReplayLayerTimeline()
	for iter_8_0, iter_8_1 in ipairs(self.levelItems_) do
		iter_8_1.playableDirector_.time = 0.75
	end
end

function AbyssMainView:AddUIListener()
	self:AddBtnListener(self.bonusBtn_, nil, function()
		JumpTools.OpenPageByJump("abyssReward", {})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/abyssRank", {})
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		if AbyssData:GetLayerResetTime() <= 0 then
			ShowTips("ABYSS_LAYER_RESET_CLICK_TIP")

			return
		end

		local var_12_0 = AbyssData:GetCurrentLayer()

		if AbyssData:HaveUpperLevelChallenging(self.curLayer_) then
			ShowTips(string.format(GetTips("ABYSS_LAYER_CHALLENGING_RESET_TIP"), (AbyssData:GetLayerStatus(var_12_0) == 1 or nil) and var_12_0 - 1))

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ABYSS_LAYER_RESET_TIP"),
			SecondTip = GetTips("ABYSS_LAYER_RESET_TIMES"),
			SecondValue = AbyssData:GetLayerResetTime() .. "/" .. AbyssData:GetLayerResetLimit(),
			OkCallback = function(arg_13_0)
				if arg_13_0 ~= AbyssData:GetActivityId() then
					ShowTips("ERROR_ACTIVITY_NOT_OPEN")

					return
				end

				AbyssAction.ResetLayer(self.curLayer_)
			end,
			CancelCallback = function()
				return
			end,
			Param = AbyssData:GetActivityId()
		})
	end)

	for iter_9_0, iter_9_1 in ipairs(self.levelItems_) do
		self:AddBtnListener(iter_9_1.gameObject_:GetComponent(typeof(Button)), nil, function()
			self:SelectStage(iter_9_0)
		end)
	end
end

function AbyssMainView:SelectLayer(arg_16_1)
	if self.curLayer_ == arg_16_1 then
		return false
	end

	self.curLayer_ = arg_16_1

	saveData("abyss", "layer", arg_16_1)
	saveData("abyss", "refreshTime", AbyssData:GetRefreshTimestamp())

	self.curLevelCfg_ = AbyssData:GetAbyssCfg(self.curLayer_)

	self.uiList_:Refresh()
	self:UpdateLayerView()

	return true
end

function AbyssMainView:CancelSelectLevel()
	for iter_17_0, iter_17_1 in ipairs(self.levelItems_) do
		iter_17_1:SetSelect(false)
	end
end

function AbyssMainView:SelectStage(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self.levelItems_) do
		iter_18_1:SetSelect(iter_18_0 == arg_18_1)
	end

	self:SwitchToStage("detail", self.curLayer_, arg_18_1)
end

function AbyssMainView:UpdateLayerView()
	self.levelNumController_:SetSelectedState(tostring(#self.curLevelCfg_.stage_list))

	for iter_19_0 = 1, #self.curLevelCfg_.stage_list do
		self.levelItems_[iter_19_0]:SetData(self.curLevelCfg_, iter_19_0)
	end

	self.currentFloorLabel_.text = self.curLevelCfg_.level

	if AbyssData:GetLayerStatus(self.curLayer_) == 0 then
		self.unlockController_:SetSelectedState("false")
	else
		self.unlockController_:SetSelectedState("true")
	end

	SetActive(self.resetBtn_.gameObject, (AbyssData:IsLayerChallenging(self.curLayer_)))

	if AbyssData:GetLayerResetTime() <= 0 then
		self.resetGrayedController_:SetSelectedState("true")
	else
		self.resetGrayedController_:SetSelectedState("false")
	end
end

function AbyssMainView:AddEventListeners()
	self:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function(arg_21_0, arg_21_1)
		if arg_21_0 == self.curLayer_ then
			self.uiList_:Refresh()
			self:UpdateLayerView()
		end
	end)
	self:RegistEventListener(ABYSS_LAYER_RESET_TIME_UPDATE, function(arg_22_0)
		if arg_22_0 == self.curLayer_ then
			ShowTips("ABYSS_RESET_LAYER_FINISH_TIP")
			self.uiList_:Refresh()
			self:UpdateLayerView()
		end
	end)
end

function AbyssMainView:OnAbyssUpdate()
	self:OnItemClick(self:GetInitLayer())
end

function AbyssMainView:OnTop()
	self:UpdateBar()

	if AbyssData:GetActivityId() ~= self.enterActivityId_ and self.curLayer_ ~= nil then
		if self.stageController_:GetSelectedState() == "detail" then
			self:CancelSelectLevel()
			self:SwitchToStage("list", self.curLayer_, self.curStageIndex_)
		end

		self.enterActivityId_ = AbyssData:GetActivityId()

		self.uiList_:Refresh()
		self:UpdateLayerView()
	else
		self:UpdateLayerView()
	end
end

function AbyssMainView:OnBehind()
	manager.windowBar:HideBar()
end

function AbyssMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ABYSS_DESC")
	manager.windowBar:RegistBackCallBack(function()
		if self.stageController_:GetSelectedState() == "detail" then
			self:CancelSelectLevel()
			self:SwitchToStage("list", self.curLayer_, self.curStageIndex_)
		else
			JumpTools.Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self:CancelSelectLevel()
		gameContext:Go("/home", nil, nil, true)
	end)
end

function AbyssMainView:SwitchToStage(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	arg_29_4 = arg_29_4 or false

	if self.stageController_:GetSelectedState() ~= arg_29_1 then
		self:PlaySound()
	end

	self.stageController_:SetSelectedState(arg_29_1, arg_29_4)

	if self.curStageIndex_ == arg_29_3 and arg_29_2 == self.curStageOfLayer_ then
		return
	end

	self.curStageIndex_ = arg_29_3
	self.curStageOfLayer_ = arg_29_2

	if self.stageController_:GetSelectedState() == "detail" and arg_29_1 == "detail" then
		self.levelView_.animator_:Play("AbyssLevelItemUI_right_cx", -1, 0)
	end

	self.levelView_:SetData(self.curLayer_, self.curStageIndex_)
end

function AbyssMainView:PlaySound()
	manager.audio:PlayEffect("ui_system", "Challenge_whoosh", "")
end

function AbyssMainView:InitData()
	self.enterActivityId_ = AbyssData:GetActivityId()
	self.layerCfgIdList_ = {}

	local var_31_0 = AbyssData:GetCurrentIdList()

	for iter_31_0 = #var_31_0, 1, -1 do
		table.insert(self.layerCfgIdList_, var_31_0[iter_31_0])
	end
end

function AbyssMainView:OnEnter()
	self:InitData()
	self:AddEventListeners()
	AbyssAction.ClickChallengeRedPoint()

	if self.levelView_ then
		self.levelView_:OnEnter()
	end

	for iter_32_0, iter_32_1 in ipairs(self.levelItems_) do
		iter_32_1:OnEnter()
	end

	self.uiList_:StartScroll(#self.layerCfgIdList_)
	self:SelectLayer(self:GetInitLayer())
	self:SwitchToStage("list", self.curLayer_, 1, true)
	manager.redPoint:bindUIandKey(self.rewardNoticeContainer_, RedPointConst.ABYSS_REWARD, {
		x = 0,
		y = 0
	})
	self:StartTimer()
	self:UpdateTimer()

	if AbyssData:NeedTipBack() then
		ShowTips(string.format(GetTips("ABYSS_BACK_TIP"), AbyssData:GetFirstLockLayer()))
		AbyssAction.ReadBackFlag()
	end

	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.ABYSS) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.ABYSS)
			end
		})
	end
end

function AbyssMainView:OnExit()
	self:CancelSelectLevel()

	self.keepLayer_ = self.curLayer_

	manager.redPoint:unbindUIandKey(self.rewardNoticeContainer_, RedPointConst.ABYSS_REWARD)
	self:StopTimer()
	self:RemoveAllEventListener()

	if self.levelView_ then
		self.levelView_:OnExit()
	end

	for iter_34_0, iter_34_1 in ipairs(self.levelItems_) do
		iter_34_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function AbyssMainView:GetInitLayer()
	local var_35_0 = getData("abyss", "layer") or AbyssData:GetCurrentLayer()

	if (getData("abyss", "refreshTime") or 0) > manager.time:GetServerTime() then
		return (self.params_.refresh or nil) and AbyssData:GetCurrentLayer()
	end

	return AbyssData:GetCurrentLayer()
end

function AbyssMainView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function AbyssMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AbyssMainView:UpdateTimer()
	self.lastDayLabel_.text = manager.time:GetLostTimeStr(AbyssData:GetRefreshTimestamp(), nil, true)
end

function AbyssMainView:OnAbyssRefresh()
	if self:IsTop() then
		self.uiList_:Refresh()
		self:SelectLayer(AbyssData:GetCurrentLayer())

		if self.stageController_:GetSelectedState() == "detail" then
			self:CancelSelectLevel()
			self:SwitchToStage("list", self.curLayer_, self.curStageIndex_)
		end
	end
end

function AbyssMainView:OnMainHomeViewTop()
	self.keepLayer_ = nil
end

function AbyssMainView:Dispose()
	manager.windowBar:HideBar()
	self:StopTimer()

	if self.levelItems_ then
		for iter_42_0, iter_42_1 in pairs(self.levelItems_) do
			iter_42_1:Dispose()
		end

		self.levelItems_ = nil
	end

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	if self.levelView_ then
		self.levelView_:Dispose()

		self.levelView_ = nil
	end

	AbyssMainView.super.Dispose(self)
end

return AbyssMainView
