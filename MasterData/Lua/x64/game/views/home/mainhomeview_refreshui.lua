local var_0_0 = partialClass("MainHomeView", ReduxView)

function var_0_0:RefreshPage()
	SetActive(self.btn_girl.gameObject, true)
end

function var_0_0:RefreshUserInfo()
	self.name_.text = GetI18NText(self.userData_.nick)
	self.uid_.text = string.format("%d", self.userData_.userID)
	self.level_.text = string.format("%d", self.userData_.userLevel)
	self.expImg_.fillAmount = LvTools.GetIsMaxLv(self.userData_.userLevel, "user") and 1 or GameLevelSetting[self.userData_.userLevel].user_level_exp == 0 and 0 or self.userData_.remain_exp / GameLevelSetting[self.userData_.userLevel].user_level_exp
end

function var_0_0:RefreshDeviceMessage()
	local var_3_0 = manager.time:STimeDescS(manager.time:GetServerTime(), "!%H:%M")

	if var_3_0 ~= self.lastTimeString_ then
		self.time_.text = var_3_0
		self.lastTimeString = var_3_0
	end

	if self.__isPc == nil then
		local var_3_1 = GameToSDK.IsPCPlatform()

		self.__isPc = var_3_1

		if var_3_1 then
			SetActive(self.signal_, false)
			SetActive(self.wifi_, false)
			SetActive(self.batteryGo_, false)
		end
	end

	if self.__isPc then
		return
	end

	local var_3_2 = Application.internetReachability

	if Application.internetReachability ~= self.lastNetMessage_ then
		SetActive(self.signal_, var_3_2 == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork)
		SetActive(self.wifi_, var_3_2 == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork)

		self.lastNetMessage_ = var_3_2
	end

	local var_3_3 = UnityEngine.SystemInfo.batteryLevel

	if UnityEngine.SystemInfo.batteryLevel ~= self.lastBatteryLevel_ then
		self.battery_.fillAmount = var_3_3
		self.lastBatteryLevel_ = var_3_3
	end
end

function var_0_0:RefreshVitalityLimit()
	local var_4_0 = StoreTools.getMaterialMinTimestamp()

	if not var_4_0 then
		SetActive(self.vitalityTimerGo_, false)

		return
	end

	self.vitalityTimerText_.text = ItemTools.GetItemCountdownText(var_4_0)

	SetActive(self.vitalityTimerGo_, true)
end

function var_0_0:RefreshRealtimeUI()
	self:RefreshDeviceMessage()
	self:RefreshVitalityLimit()
	self:UpdateSubModuleRedDot()
end

function var_0_0:RefreshBanner()
	local var_6_0 = ActivityTools.GetCurrentAdvInfo()
	local var_6_1 = #var_6_0 > 0

	SetActive(self.btnActivityGo_, #var_6_0 > 0)

	if var_6_1 then
		self.bannerView_:RefreshData(self, {
			space = 0,
			vertical = true,
			data = var_6_0,
			onclick = function(self)
				if not ActivityTools.IsValidAdv(self.id) then
					ShowTips("TIME_OVER")
					self:RefreshBanner()

					return
				end

				ActivityTools.ClickAdv(self)
				OperationRecorder.RecordButtonTouch("homepage_banner_" .. self.id)
				OperationRecorder.Record("home", "activity_open")
			end
		})
	end
end

function var_0_0:RefreshHide()
	self.hideCon_:SetSelectedState(self.isHide_ and "true" or "false")
	SetActive(self.bgmaskBtn_.gameObject, self.isHide_)

	if self.isHide_ then
		manager.windowBar:HideBar()
	else
		self:InitBar()
	end

	self:RefreshTalkBubbleHide()
end

function var_0_0:RefreshTalkBubbleHide()
	if self.subtitleBubble == nil then
		return true
	end

	local var_9_0 = true

	if self.isHide_ and SettingData:GetHideMainVoiceSubtitle() then
		-- block empty
	elseif self.talking_ then
		var_9_0 = false
	end

	self.subtitleBubble:SetVisible(not var_9_0)

	return var_9_0
end

function var_0_0:RefreshReceiveMessage()
	self:ClearMsgTimer()
	self:RefreshWorldChat()

	self.msgTimer_ = Timer.New(function()
		self:RefreshWorldChat()
	end, 2, -1)

	self.msgTimer_:Start()
end

function var_0_0:RefreshWorldChat()
	local var_12_0 = ChatData:GetWorldChatData()
	local var_12_1 = var_12_0[#var_12_0]

	if var_12_0[#var_12_0] then
		local var_12_2 = ""
		local var_12_3 = ""

		if var_12_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_12_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_12_2 = var_12_1.id == USER_ID and (PlayerData:GetPlayerInfo().nick or "") or var_12_1.nick or ""
			var_12_3 = var_12_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and (var_12_1.content or "") or string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_12_1.content)].name))
		end

		self.textLimit_:SetText((var_12_2 ~= "" or nil) and var_12_2 .. ":" .. var_12_3)

		return
	end

	self.textLimit_:SetText("")
end

function var_0_0:RefreshChat()
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHAT) then
		ChatAction.EnterChatUI(1)
		self:RefreshReceiveMessage()
		self.socializeCon_:SetSelectedState("on")
	else
		self.textLimit_:SetText("")
		self.socializeCon_:SetSelectedState("off")
	end
end

function var_0_0.Render(arg_14_0)
	return
end

function var_0_0:CheckPassportBtn()
	SetActive(self.btn_passport.gameObject, PassportData:IsOpen() and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.PASSPORT_MAIN))
	SetActive(self.passportDiscountHighlight_, (PassportData:HasDiscount()))
end

function var_0_0:CheckMomoTalkBtn()
	SetActive(self.momoTalkBtn_.gameObject, not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MOMO_TALK))
	MomoTalkData:UpdateMomoChatRedPoint()
end

function var_0_0:CheckLocked()
	self.drawLockCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DRAW) and "true" or "false")
	self.dormLockCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) and "true" or "false")
	self.guildCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD) and "true" or "false")
	self.shopCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) and "true" or "false")

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) then
		SetActive(self.shopRedPoint, false)
	elseif manager.redPoint:getTipValue(RedPointConst.RECHARGE_ENTER) >= 1 then
		SetActive(self.shopRedPoint, true)
	else
		SetActive(self.shopRedPoint, false)
	end
end

function var_0_0:CheckRecallActivity()
	local var_18_0 = ActivityData:GetActivityData(ActivityConst.RECALL_INVITE)

	if var_18_0.stopTime == 1 or ActivityRecallData:GetDataByPara("recallLevel") > self.userData_.userLevel or ActivityRecallData:GetDataByPara("recallActivityID") == nil then
		SetActive(self.btn_callback.gameObject, false)
	else
		SetActive(self.btn_callback.gameObject, var_18_0.stopTime > manager.time:GetServerTime())
	end
end

function var_0_0:CheckActivite()
	local function var_19_0()
		self:CheckHeroGiftActivite()
		self:CheckPreviewTaskActivity()
		self:CheckRecallActivity()
		AdminCatExploreData:UpdateRegionRedPoint()
	end

	var_19_0()

	if self.activiteTime_ == nil then
		self.activiteTime_ = Timer.New(var_19_0, 1, -1)

		self.activiteTime_:Start()
	end
end

function var_0_0:CheckHeroGiftActivite()
	local var_21_0 = ActivityData:GetActivityIsOpen(ActivityConst.HELLA_HERO_GIFT) and HeroGiftData:GetReceiveHeroGift(ActivityConst.HELLA_HERO_GIFT) == 0

	if self.isHeroGiftOpen_ == var_21_0 then
		return
	end

	self.isHeroGiftOpen_ = var_21_0

	SetActive(self.btnHeroGiftGo_, var_21_0)
end

function var_0_0:CheckPreviewTaskActivity()
	local var_22_0 = ActivityData:GetActivityIsOpen((PreviewTaskData:GetCurActivityID()))

	if self.isPreviewTaskOpen_ == var_22_0 then
		return
	end

	self.isPreviewTaskOpen_ = var_22_0

	SetActive(self.btnPreviewTaskGo_, var_22_0)
	SetActive(self.advanceTestBtn_, (AdvanceTestData:GetIsActivityOpen()))
	SetActive(self.advanceMonsterTestBtn_, (ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST)))
end

function var_0_0:SetPureMode(arg_23_1, arg_23_2)
	if arg_23_1 then
		self:StopViewHideTimer()
		self.puremodeCon_:SetSelectedState("hide")

		self.isHide_ = false

		self:RefreshHide()
		self.animator_:Play("HomeUI_cx")
	else
		self.isHide_ = true

		if self:IsTop() then
			self:RefreshHide()
			self:StartViewHideTimer()
			self:ShowPureModeBar()
		end

		if not arg_23_2 then
			self.animator_:Play("HomeUI_hide")
		end

		self.puremodeCon_:SetSelectedState("show")
		OperationRecorder.RecordButtonTouch("homepage_hide")
	end
end

function var_0_0:RecordPureModeLog(arg_24_1, arg_24_2)
	local var_24_0 = manager.posterGirl:GetInteractionsTimes()
	local var_24_1 = manager.time:GetServerTime()

	if arg_24_1 then
		SDKTools.SendMessageToSDK("duration", {
			opt = 1,
			duration_name = "homepage_heroshow_enjoy",
			type = arg_24_2
		})
	else
		local var_24_3 = var_24_0 - (self.lastInteractionsTimes or 0)

		SDKTools.SendMessageToSDK("duration", {
			opt = 2,
			duration_name = "homepage_heroshow_enjoy",
			touch_times = var_24_3,
			duration = (self.lastPureModeTime or nil) and (var_24_1 - self.lastPureModeTime or 0)
		})
	end

	self.lastInteractionsTimes = var_24_0
	self.lastPureModeTime = var_24_1
end

function var_0_0:SetPureModeBtnActive(arg_25_1, arg_25_2)
	if arg_25_2 then
		if arg_25_1 then
			self:ShowPureModeBar()
		else
			manager.windowBar:HideBar()
		end
	end

	SetActive(self.appearViewBtn_.gameObject, false)
	SetActive(self.btn_arrow_hide2Btn_.gameObject, arg_25_1)
end

function var_0_0:AdaptLeft()
	if self.leftBtnPos_ == nil then
		self.leftBtnPos_ = self.puremode_leftGo_.transform.anchoredPosition
	end

	self.puremode_leftGo_.transform.anchoredPosition = Vector2.New(self.leftBtnPos_.x + var_0_0.VIEW_ADAPT_DISTANCE, self.leftBtnPos_.y)

	var_0_0.super.AdaptLeft(self)
end

function var_0_0:AdaptRight()
	if self.rightBtnPos_ == nil then
		self.rightBtnPos_ = self.btn_youBtn_.transform.anchoredPosition
	end

	self.btn_youBtn_.transform.anchoredPosition = Vector2.New(self.rightBtnPos_.x - var_0_0.VIEW_ADAPT_DISTANCE, self.rightBtnPos_.y)

	var_0_0.super.AdaptRight(self)
end

function var_0_0.InitBar(arg_28_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function var_0_0.ShowPureModeBar(arg_29_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_29_0.isPureMode_ = false

		arg_29_0:SetPureMode(true)

		arg_29_0.params_.isPureMode = false

		arg_29_0:RecordPureModeLog(false)
		arg_29_0:InitBar()
		PlayerData:SetIsDeskMode(false)
	end)
end
