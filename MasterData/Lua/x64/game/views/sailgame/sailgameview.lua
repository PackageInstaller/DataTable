local SailBuildingView = class("SailBuildingView", ReduxView)

function SailBuildingView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesUI"
end

function SailBuildingView:UIParent()
	return manager.ui.uiMain.transform
end

function SailBuildingView:Init()
	self:InitUI()
end

function SailBuildingView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.coinIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
	self.animTimerList_ = {}
	self.maxTime_ = GameSetting.activity_skadi_sea_total_time.value[1]
	self.pauseHandler_ = handler(self, self.OnPause)
	self.triggerEventHandler_ = handler(self, self.OnTriggerEvent)
	self.triggerTipsHandler_ = handler(self, self.OnTriggerTips)
end

function SailBuildingView:OnEnter()
	self.activityID_ = self.params_.activityID

	if isNil(SailGameManager.Instance) then
		SailGameTools.GoToGameView(self.activityID_)
	end

	manager.ui:SetMainCamera("sailGame")

	manager.ui.mainCameraCom_.orthographic = true

	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnActivityUpdate))
end

function SailBuildingView:OnTop()
	SetActive(self.eventTriggerGo_, false)
	SetActive(self.tipsGo_, false)
	SetActive(self.coinVaryGo_, false)
	self:GameStart()

	self.curGameData_ = SailGameData:GetCurGameData(self.activityID_)

	self:UpdateBar()

	local var_6_0 = SailGameData:GetEventEndMark(self.activityID_)

	if var_6_0.isEnd == true then
		self:OnEventEnd(var_6_0)
	end
end

function SailBuildingView:OnExit()
	manager.windowBar:HideBar()
	self:StopAllAnimTimer()
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	self:RemoveAllEventListener()
end

function SailBuildingView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		SailGameManager.Instance:SetGamePause(true)

		local var_9_0 = self.activityID_

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_SKADI_SEA_BE_OUT_EXIT"),
			OkCallback = function()
				SailGameAction.GiveUp(var_9_0)
			end,
			CancelCallback = function()
				SailGameManager.Instance:SetGamePause(false)
			end,
			MaskCallback = function()
				SailGameManager.Instance:SetGamePause(false)
			end
		})
	end)
end

function SailBuildingView:UpdateBar()
	self.coinNumText_.text = SailGameData:GetTempCurrency(self.activityID_).lastNum
end

function SailBuildingView:Dispose()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end

	self:StopAllAnimTimer()
	SailGameTools.ShutDown()

	self.pauseHandler_ = nil
	self.triggerEventHandler_ = nil
	self.triggerTipsHandler_ = nil

	SailBuildingView.super.Dispose(self)
end

function SailBuildingView:InitGame()
	SailGameManager.Instance:SetGamePauseHandler(self.pauseHandler_)
	SailGameManager.Instance:SetTriggerEventHandler(self.triggerEventHandler_)
	SailGameManager.Instance:SetTriggerTipsHandler(self.triggerTipsHandler_)
end

function SailBuildingView:GameStart()
	if not SailGameManager.Instance:IsRunning() then
		self:InitGame()
		SailGameManager.Instance:GameStart()
	else
		SailGameManager.Instance:SetGamePause(false)
	end

	self:RecoverAnim()
end

function SailBuildingView:GoToEventView()
	local var_17_0 = self.curGameData_.curStageIndex
	local var_17_1 = self.curGameData_.eventList[self.curGameData_.curStageIndex].id

	JumpTools.OpenPageByJump(SailGameConst.EVENT_VIEW_ROUTE[SailGameEventCfg[self.curGameData_.eventList[self.curGameData_.curStageIndex].id] and SailGameEventCfg[var_17_1].type or 0], {
		activityID = self.activityID_,
		stageIndex = var_17_0,
		eventID = var_17_1
	})
end

function SailBuildingView:OnPause(arg_18_1)
	if arg_18_1 == true then
		self:PauseAnim()
	else
		self:RecoverAnim()
	end
end

function SailBuildingView:OnTriggerTips(arg_19_1)
	if SailGameConst.GAME_TIME_TIPS[arg_19_1] then
		self.gameTipsText_.text = GetTips(SailGameConst.GAME_TIME_TIPS[arg_19_1])

		self:PlayTipsAnim()
	end
end

function SailBuildingView:OnTriggerEvent(arg_20_1)
	self:PlayEventAnim(self.curGameData_.curStageIndex == #self.curGameData_.eventList and 0 or self.curGameData_.eventList[self.curGameData_.curStageIndex].id, function()
		self:GoToEventView()
	end)
end

function SailBuildingView:OnEventEnd(arg_22_1)
	self:UpdateCurrency()

	if arg_22_1.tipsIndex then
		self.gameTipsText_.text = SailGameEventCfg[self.curGameData_.eventList[arg_22_1.stageIndex].id].tip[arg_22_1.tipsIndex]

		self:PlayTipsAnim()
	end
end

function SailBuildingView:UpdateCurrency()
	local var_23_0 = SailGameData:GetTempCurrency(self.activityID_)

	if var_23_0.curNum - var_23_0.lastNum > 0 then
		self.coinVaryText_.text = "+" .. var_23_0.curNum - var_23_0.lastNum

		SetActive(self.coinVaryGo_, true)

		self.coinAnim_.enabled = true

		self:PlayAnim("XH3rdVoyagesGameUI_text", self.coinAnim_, function()
			SetActive(self.coinVaryGo_, false)
			self:PlayCurrencyRollAnim()
			self:PlayAnim("XH3rdVoyagesGameUI_coin", self.coinAnim_, function()
				self.coinAnim_.enabled = false
			end)
		end)
	end
end

function SailBuildingView:PlayCurrencyRollAnim()
	local var_26_0 = SailGameData:GetTempCurrency(self.activityID_)
	local var_26_1 = var_26_0.lastNum
	local var_26_2 = var_26_0.curNum

	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end

	self.tween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
		local var_27_0 = var_26_1 or 0

		self.coinNumText_.text = tostring((math.floor(var_27_0 + (var_26_2 - var_27_0) * arg_27_0)))
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if self.tween_ then
			self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			self.tween_ = nil
		end

		self.coinNumText_.text = var_26_2
	end)):setEase(LeanTweenType.easeOutQuad)
end

function SailBuildingView:PlayEventAnim(arg_29_1, arg_29_2)
	SetActive(self.eventTriggerGo_, true)
	SetActive(self.tipsGo_, false)

	self.tipsAnim_.enabled = false
	self.eventRoleImg_.sprite = arg_29_1 ~= 0 and pureGetSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. SailGameEventCfg[arg_29_1].picture) or getSprite(GameDisplayCfg.activity_skadi_sea_box_picture.value[1], GameDisplayCfg.activity_skadi_sea_box_picture.value[2])

	self.eventRoleImg_:SetNativeSize()
	self:PlayAnim("XH3rdVoyagesUI_role", self.eventAnim_, arg_29_2)
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_pop1", "")
end

function SailBuildingView:PlayTipsAnim()
	SetActive(self.tipsGo_, true)

	self.tipsAnim_.enabled = true

	self:PlayAnim("XH3rdVoyagesUI_pop", self.tipsAnim_, function()
		SetActive(self.tipsGo_, false)

		self.tipsAnim_.enabled = false
	end)
end

function SailBuildingView:PlayAnim(arg_32_1, arg_32_2, arg_32_3)
	if not arg_32_2 then
		return
	end

	arg_32_2:Play(arg_32_1, -1, 0)
	arg_32_2:Update(0)
	self:StopAnimTimer(arg_32_1)

	self.animTimerList_[arg_32_1] = Timer.New(function()
		local var_33_0 = arg_32_2:GetCurrentAnimatorStateInfo(0)

		if var_33_0:IsName(arg_32_1) and var_33_0.normalizedTime >= 1 then
			self:StopAnimTimer(arg_32_1)

			if arg_32_3 then
				arg_32_3()

				arg_32_3 = nil
			end
		end
	end, 0.033, -1)

	self.animTimerList_[arg_32_1]:Start()
end

function SailBuildingView:PauseAnim()
	self.tipsAnim_.speed = 0
	self.coinAnim_.speed = 0

	if self.tween_ then
		LeanTween.pause(self.tween_.id)
	end
end

function SailBuildingView:RecoverAnim()
	self.tipsAnim_.speed = 1
	self.coinAnim_.speed = 1

	if self.tween_ then
		LeanTween.resume(self.tween_.id)
	end
end

function SailBuildingView:StopAllAnimTimer()
	for iter_36_0, iter_36_1 in pairs(self.animTimerList_) do
		self.animTimerList_[iter_36_0]:Stop()

		self.animTimerList_[iter_36_0] = nil
	end
end

function SailBuildingView:StopAnimTimer(arg_37_1)
	if self.animTimerList_[arg_37_1] then
		self.animTimerList_[arg_37_1]:Stop()

		self.animTimerList_[arg_37_1] = nil
	end
end

function SailBuildingView:OnActivityUpdate(arg_38_1)
	if arg_38_1 == self.activityID_ and not ActivityData:GetActivityIsOpen(arg_38_1) then
		ShowTips("TIME_OVER")
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = self.activityID_
		})
	end
end

return SailBuildingView
