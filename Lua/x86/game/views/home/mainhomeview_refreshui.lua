local var_0_0 = partialClass("MainHomeView", ReduxView)

function var_0_0.RefreshPage(arg_1_0)
	SetActive(arg_1_0.btn_girl.gameObject, true)
end

function var_0_0.RefreshUserInfo(arg_2_0)
	local var_2_0 = arg_2_0.userData_

	arg_2_0.name_.text = GetI18NText(var_2_0.nick)
	arg_2_0.uid_.text = string.format("%d", var_2_0.userID)
	arg_2_0.level_.text = string.format("%d", var_2_0.userLevel)

	local var_2_1 = arg_2_0.userData_.remain_exp
	local var_2_2 = arg_2_0.userData_.userLevel

	if LvTools.GetIsMaxLv(var_2_2, "user") then
		arg_2_0.expImg_.fillAmount = 1
	else
		local var_2_3 = GameLevelSetting[var_2_2].user_level_exp

		arg_2_0.expImg_.fillAmount = var_2_3 == 0 and 0 or var_2_1 / var_2_3
	end
end

function var_0_0.RefreshDeviceMessage(arg_3_0)
	local var_3_0 = manager.time:STimeDescS(manager.time:GetServerTime(), "!%H:%M")

	if var_3_0 ~= arg_3_0.lastTimeString_ then
		arg_3_0.time_.text = var_3_0
		arg_3_0.lastTimeString = var_3_0
	end

	if arg_3_0.__isPc == nil then
		local var_3_1 = GameToSDK.IsPCPlatform()

		arg_3_0.__isPc = var_3_1

		if var_3_1 then
			SetActive(arg_3_0.signal_, false)
			SetActive(arg_3_0.wifi_, false)
			SetActive(arg_3_0.batteryGo_, false)
		end
	end

	if arg_3_0.__isPc then
		return
	end

	local var_3_2 = Application.internetReachability

	if var_3_2 ~= arg_3_0.lastNetMessage_ then
		SetActive(arg_3_0.signal_, var_3_2 == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork)
		SetActive(arg_3_0.wifi_, var_3_2 == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork)

		arg_3_0.lastNetMessage_ = var_3_2
	end

	local var_3_3 = UnityEngine.SystemInfo.batteryLevel

	if var_3_3 ~= arg_3_0.lastBatteryLevel_ then
		arg_3_0.battery_.fillAmount = var_3_3
		arg_3_0.lastBatteryLevel_ = var_3_3
	end
end

function var_0_0.RefreshVitalityLimit(arg_4_0)
	local var_4_0 = StoreTools.getMaterialMinTimestamp()

	if not var_4_0 then
		SetActive(arg_4_0.vitalityTimerGo_, false)

		return
	end

	arg_4_0.vitalityTimerText_.text = ItemTools.GetItemCountdownText(var_4_0)

	SetActive(arg_4_0.vitalityTimerGo_, true)
end

function var_0_0.RefreshRealtimeUI(arg_5_0)
	arg_5_0:RefreshDeviceMessage()
	arg_5_0:RefreshVitalityLimit()
	arg_5_0:UpdateSubModuleRedDot()
end

function var_0_0.RefreshBanner(arg_6_0)
	local var_6_0 = ActivityTools.GetCurrentAdvInfo()
	local var_6_1 = #var_6_0 > 0

	SetActive(arg_6_0.btnActivityGo_, var_6_1)

	if var_6_1 then
		arg_6_0.bannerView_:RefreshData(arg_6_0, {
			space = 0,
			vertical = true,
			data = var_6_0,
			onclick = function(arg_7_0)
				if not ActivityTools.IsValidAdv(arg_7_0.id) then
					ShowTips("TIME_OVER")
					arg_6_0:RefreshBanner()

					return
				end

				ActivityTools.ClickAdv(arg_7_0)
				OperationRecorder.RecordButtonTouch("homepage_banner_" .. arg_7_0.id)
				OperationRecorder.Record("home", "activity_open")
			end
		})
	end
end

function var_0_0.RefreshHide(arg_8_0)
	arg_8_0.hideCon_:SetSelectedState(arg_8_0.isHide_ and "true" or "false")
	SetActive(arg_8_0.bgmaskBtn_.gameObject, arg_8_0.isHide_)

	if arg_8_0.isHide_ then
		manager.windowBar:HideBar()
	else
		arg_8_0:InitBar()
	end

	arg_8_0:RefreshTalkBubbleHide()
end

function var_0_0.RefreshTalkBubbleHide(arg_9_0)
	if arg_9_0.subtitleBubble == nil then
		return true
	end

	local var_9_0 = true

	if arg_9_0.isHide_ and SettingData:GetHideMainVoiceSubtitle() then
		-- block empty
	elseif arg_9_0.talking_ then
		var_9_0 = false
	end

	arg_9_0.subtitleBubble:SetVisible(not var_9_0)

	return var_9_0
end

function var_0_0.RefreshReceiveMessage(arg_10_0)
	arg_10_0:ClearMsgTimer()
	arg_10_0:RefreshWorldChat()

	arg_10_0.msgTimer_ = Timer.New(function()
		arg_10_0:RefreshWorldChat()
	end, 2, -1)

	arg_10_0.msgTimer_:Start()
end

function var_0_0.RefreshWorldChat(arg_12_0)
	local var_12_0 = ChatData:GetWorldChatData()
	local var_12_1 = var_12_0[#var_12_0]

	if var_12_1 then
		local var_12_2 = ""
		local var_12_3 = ""

		if var_12_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_12_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			if var_12_1.id == USER_ID then
				var_12_2 = PlayerData:GetPlayerInfo().nick or ""
			else
				var_12_2 = var_12_1.nick or ""
			end

			if var_12_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT then
				var_12_3 = var_12_1.content or ""
			else
				var_12_3 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_12_1.content)].name))
			end
		end

		local var_12_4 = ""

		if var_12_2 ~= "" then
			var_12_4 = var_12_2 .. ":" .. var_12_3
		end

		arg_12_0.textLimit_:SetText(var_12_4)

		return
	end

	arg_12_0.textLimit_:SetText("")
end

function var_0_0.RefreshChat(arg_13_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHAT) then
		ChatAction.EnterChatUI(1)
		arg_13_0:RefreshReceiveMessage()
		arg_13_0.socializeCon_:SetSelectedState("on")
	else
		arg_13_0.textLimit_:SetText("")
		arg_13_0.socializeCon_:SetSelectedState("off")
	end
end

function var_0_0.Render(arg_14_0)
	return
end

function var_0_0.CheckPassportBtn(arg_15_0)
	SetActive(arg_15_0.btn_passport.gameObject, PassportData:IsOpen() and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.PASSPORT_MAIN))

	local var_15_0 = PassportData:HasDiscount()

	SetActive(arg_15_0.passportDiscountHighlight_, var_15_0)
end

function var_0_0.CheckMomoTalkBtn(arg_16_0)
	local var_16_0 = not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MOMO_TALK)

	SetActive(arg_16_0.momoTalkBtn_.gameObject, var_16_0)
	MomoTalkData:UpdateMomoChatRedPoint()
end

function var_0_0.CheckLocked(arg_17_0)
	arg_17_0.drawLockCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DRAW) and "true" or "false")
	arg_17_0.dormLockCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) and "true" or "false")
	arg_17_0.guildCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD) and "true" or "false")
	arg_17_0.shopCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) and "true" or "false")

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) then
		SetActive(arg_17_0.shopRedPoint, false)
	elseif manager.redPoint:getTipValue(RedPointConst.RECHARGE_ENTER) >= 1 then
		SetActive(arg_17_0.shopRedPoint, true)
	else
		SetActive(arg_17_0.shopRedPoint, false)
	end
end

function var_0_0.CheckRecallActivity(arg_18_0)
	local var_18_0 = ActivityData:GetActivityData(ActivityConst.RECALL_INVITE)
	local var_18_1 = ActivityRecallData:GetDataByPara("recallLevel")
	local var_18_2 = ActivityRecallData:GetDataByPara("recallActivityID")

	if var_18_0.stopTime == 1 or var_18_1 > arg_18_0.userData_.userLevel or var_18_2 == nil then
		SetActive(arg_18_0.btn_callback.gameObject, false)
	else
		SetActive(arg_18_0.btn_callback.gameObject, var_18_0.stopTime > manager.time:GetServerTime())
	end
end

function var_0_0.CheckActivite(arg_19_0)
	local function var_19_0()
		arg_19_0:CheckHeroGiftActivite()
		arg_19_0:CheckPreviewTaskActivity()
		arg_19_0:CheckRecallActivity()
		AdminCatExploreData:UpdateRegionRedPoint()
	end

	var_19_0()

	if arg_19_0.activiteTime_ == nil then
		arg_19_0.activiteTime_ = Timer.New(var_19_0, 1, -1)

		arg_19_0.activiteTime_:Start()
	end
end

function var_0_0.CheckHeroGiftActivite(arg_21_0)
	local var_21_0 = ActivityData:GetActivityIsOpen(ActivityConst.HELLA_HERO_GIFT) and HeroGiftData:GetReceiveHeroGift(ActivityConst.HELLA_HERO_GIFT) == 0

	if arg_21_0.isHeroGiftOpen_ == var_21_0 then
		return
	end

	arg_21_0.isHeroGiftOpen_ = var_21_0

	SetActive(arg_21_0.btnHeroGiftGo_, var_21_0)
end

function var_0_0.CheckPreviewTaskActivity(arg_22_0)
	local var_22_0 = PreviewTaskData:GetCurActivityID()
	local var_22_1 = ActivityData:GetActivityIsOpen(var_22_0)

	if arg_22_0.isPreviewTaskOpen_ == var_22_1 then
		return
	end

	arg_22_0.isPreviewTaskOpen_ = var_22_1

	SetActive(arg_22_0.btnPreviewTaskGo_, var_22_1)

	local var_22_2 = AdvanceTestData:GetIsActivityOpen()

	SetActive(arg_22_0.advanceTestBtn_, var_22_2)

	local var_22_3 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST)

	SetActive(arg_22_0.advanceMonsterTestBtn_, var_22_3)
end

function var_0_0.SetPureMode(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 then
		arg_23_0:StopViewHideTimer()
		arg_23_0.puremodeCon_:SetSelectedState("hide")

		arg_23_0.isHide_ = false

		arg_23_0:RefreshHide()
		arg_23_0.animator_:Play("HomeUI_cx")
	else
		arg_23_0.isHide_ = true

		if arg_23_0:IsTop() then
			arg_23_0:RefreshHide()
			arg_23_0:StartViewHideTimer()
			arg_23_0:ShowPureModeBar()
		end

		if not arg_23_2 then
			arg_23_0.animator_:Play("HomeUI_hide")
		end

		arg_23_0.puremodeCon_:SetSelectedState("show")
		OperationRecorder.RecordButtonTouch("homepage_hide")
	end
end

function var_0_0.RecordPureModeLog(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = manager.posterGirl:GetInteractionsTimes()
	local var_24_1 = manager.time:GetServerTime()

	if arg_24_1 then
		SDKTools.SendMessageToSDK("duration", {
			opt = 1,
			duration_name = "homepage_heroshow_enjoy",
			type = arg_24_2
		})
	else
		local var_24_2 = var_24_0 - (arg_24_0.lastInteractionsTimes or 0)
		local var_24_3 = arg_24_0.lastPureModeTime and var_24_1 - arg_24_0.lastPureModeTime or 0

		SDKTools.SendMessageToSDK("duration", {
			opt = 2,
			duration_name = "homepage_heroshow_enjoy",
			touch_times = var_24_2,
			duration = var_24_3
		})
	end

	arg_24_0.lastInteractionsTimes = var_24_0
	arg_24_0.lastPureModeTime = var_24_1
end

function var_0_0.SetPureModeBtnActive(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 then
		if arg_25_1 then
			arg_25_0:ShowPureModeBar()
		else
			manager.windowBar:HideBar()
		end
	end

	SetActive(arg_25_0.appearViewBtn_.gameObject, false)
	SetActive(arg_25_0.btn_arrow_hide2Btn_.gameObject, arg_25_1)
end

function var_0_0.AdaptLeft(arg_26_0)
	if arg_26_0.leftBtnPos_ == nil then
		arg_26_0.leftBtnPos_ = arg_26_0.puremode_leftGo_.transform.anchoredPosition
	end

	local var_26_0 = arg_26_0.leftBtnPos_

	arg_26_0.puremode_leftGo_.transform.anchoredPosition = Vector2.New(var_26_0.x + var_0_0.VIEW_ADAPT_DISTANCE, var_26_0.y)

	var_0_0.super.AdaptLeft(arg_26_0)
end

function var_0_0.AdaptRight(arg_27_0)
	if arg_27_0.rightBtnPos_ == nil then
		arg_27_0.rightBtnPos_ = arg_27_0.btn_youBtn_.transform.anchoredPosition
	end

	local var_27_0 = arg_27_0.rightBtnPos_

	arg_27_0.btn_youBtn_.transform.anchoredPosition = Vector2.New(var_27_0.x - var_0_0.VIEW_ADAPT_DISTANCE, var_27_0.y)

	var_0_0.super.AdaptRight(arg_27_0)
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
