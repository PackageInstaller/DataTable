local var_0_0 = class("NewMainClassicTheme", import(".NewMainSceneBaseTheme"))

function var_0_0.getUIName(arg_1_0)
	return "NewMainClassicTheme"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.adapterView = MainAdpterView.New(arg_2_0._tf:Find("top_bg"), arg_2_0._tf:Find("bottom_bg"), arg_2_0._tf:Find("bg/right"))

	arg_2_0.changeView:SetAsmrTurnningParent(arg_2_0._tf:Find("frame/right/asmrToggleContainer"))

	return
end

function var_0_0.PlayEnterAnimation(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.adapterView:Init()
	var_0_0.super.PlayEnterAnimation(arg_3_0, arg_3_1, arg_3_2)

	return
end

function var_0_0._FoldPanels(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super._FoldPanels(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.adapterView:Fold(arg_4_1, arg_4_2)

	return
end

function var_0_0.OnDestroy(arg_5_0)
	var_0_0.super.OnDestroy(arg_5_0)

	if arg_5_0.adapterView then
		arg_5_0.adapterView:Dispose()

		arg_5_0.adapterView = nil
	end

	return
end

function var_0_0.SetEffectPanelVisible(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.panels) do
		if isa(iter_6_1, MainRightPanel) then
			iter_6_1:SetEffectVisible(arg_6_1)
		end
	end

	return
end

function var_0_0.GetCalibrationBG(arg_7_0)
	return "mainui_calibration"
end

function var_0_0.GetPbList(arg_8_0)
	return {
		arg_8_0._tf:Find("frame/chatPreview"),
		arg_8_0._tf:Find("frame/eventPanel")
	}
end

function var_0_0.GetPaintingOffset(arg_9_0, arg_9_1)
	return MainPaintingShift.New({
		-600,
		-10,
		170,
		0,
		170,
		0,
		1,
		1,
		1
	})
end

function var_0_0.GetWordView(arg_10_0)
	return MainWordView.New(arg_10_0._tf:Find("chat"), arg_10_0.event)
end

function var_0_0.GetTagView(arg_11_0)
	return MainTagsView.New(arg_11_0._tf:Find("frame/bottom/tags"), arg_11_0.event)
end

function var_0_0.GetTopPanel(arg_12_0)
	return MainTopPanel.New(arg_12_0._tf:Find("frame/top"), arg_12_0.event, arg_12_0.contextData)
end

function var_0_0.GetRightPanel(arg_13_0)
	return MainRightPanel.New(arg_13_0._tf:Find("frame/right"), arg_13_0.event, arg_13_0.contextData)
end

function var_0_0.GetLeftPanel(arg_14_0)
	return MainLeftPanel.New(arg_14_0._tf:Find("frame/left"), arg_14_0.event, arg_14_0.contextData)
end

function var_0_0.GetBottomPanel(arg_15_0)
	return MainBottomPanel.New(arg_15_0._tf:Find("frame/bottom"), arg_15_0.event, arg_15_0.contextData)
end

function var_0_0.GetIconView(arg_16_0)
	return MainIconView.New(arg_16_0._tf:Find("frame/char"))
end

function var_0_0.GetChatRoomView(arg_17_0)
	return MainChatRoomView.New(arg_17_0._tf:Find("frame/chatPreview"), arg_17_0.event)
end

function var_0_0.GetBannerView(arg_18_0)
	return MainBannerView.New(arg_18_0._tf:Find("frame/eventPanel"), arg_18_0.event)
end

function var_0_0.GetActBtnView(arg_19_0)
	return MainActivityBtnView.New(arg_19_0._tf:Find("frame/linkBtns"), arg_19_0.event)
end

function var_0_0.GetBuffView(arg_20_0)
	return MainBuffView.New(arg_20_0._tf:Find("frame/buffs"), arg_20_0.event)
end

function var_0_0.GetCalibrationView(arg_21_0)
	return MainCalibrationPage.New(arg_21_0._tf, arg_21_0.event)
end

function var_0_0.GetChangeSkinView(arg_22_0)
	return MainChangeSkinView.New(arg_22_0._tf:Find("frame/bottom/change_skin"), arg_22_0.event)
end

function var_0_0.GetAsmrChatView(arg_23_0)
	return MainAsmrChatView.New(arg_23_0._tf:Find("frame/bottom/asmr_chat"), arg_23_0.event)
end

function var_0_0.RegisterRedDots(arg_24_0)
	local var_24_0 = pg.EasyRedDotMgr.GetInstance()
	local var_24_1 = {}

	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/bottom/taskButton/tip"), {
		"TASK"
	}, function(arg_26_0)
		local var_26_0 = arg_26_0
		local var_26_1

		if getProxy(TaskProxy):getCanReceiveCount() <= 0 then
			if getProxy(AvatarFrameProxy):getCanReceiveCount() <= 0 then
				var_26_1 = false

				goto label_26_0
			end
		end

		var_26_1 = true

		::label_26_0::

		setActive(var_26_0, var_26_1)

		return
	end)

	local var_24_2 = arg_24_0._tf:Find("frame/right/mailButton")
	local var_24_3 = findTF(var_24_2, "unread")
	local var_24_4 = findTF(var_24_2, "read")
	local var_24_5 = findTF(findTF(var_24_2, "attachmentLabel"), "attachmentCountText"):GetComponent(typeof(Text))
	local var_24_6 = getProxy(MailProxy)

	if var_24_6.total == math.clamp(var_24_6.total, MAIL_COUNT_LIMIT * 0.9, MAIL_COUNT_LIMIT) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("warning_mail_max_1", var_24_6.total, MAIL_COUNT_LIMIT))
	end

	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(var_24_2, {
		"MAIL"
	}, function(arg_27_0)
		local var_27_0 = getProxy(MailProxy):GetUnreadCount()

		if var_27_0 > 0 then
			SetActive(var_0, true)
			SetActive(var_24_4, false)
			SetActive(var_24_3, true)

			arg_27_0:GetComponent(typeof(Button)).targetGraphic = var_24_3:GetComponent(typeof(Image))

			local var_27_1 = var_24_5

			if 99 < var_27_0 then
				var_27_1.text = 99 .. "+" or tostring(var_27_0)

				if false then
					SetActive(var_24_4, true)
					SetActive(var_24_3, false)
					SetActive(var_0, false)

					arg_27_0:GetComponent(typeof(Button)).targetGraphic = var_24_4:GetComponent(typeof(Image))
				end

				return
			end
		end
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/bottom/buildButton/tip"), {
		"BUILD"
	}, function(arg_28_0)
		local var_28_0 = arg_28_0
		local var_28_1

		if getProxy(BuildShipProxy):getFinishCount() <= 0 then
			var_28_1 = tobool(getProxy(ActivityProxy):IsShowFreeBuildMark(true))

			if false then
				var_28_1 = false
			end
		else
			var_28_1 = true
		end

		setActive(var_28_0, var_28_1)

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/bottom/guildButton/tip"), {
		"GUILD"
	}, function(arg_29_0)
		setActive(arg_29_0, getProxy(GuildProxy):ShouldShowTip())

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/top/tip"), {
		"ATTIRE"
	}, function(arg_30_0)
		local var_30_0 = getProxy(AttireProxy):IsShowRedDot()

		if not var_30_0 then
			var_30_0 = getProxy(SettingsProxy):ShouldEducateCharTip()
			var_30_0 = var_30_0 or getProxy(ActivityProxy):IsTipLoveLetterMail()
		end

		setActive(arg_30_0, var_30_0)

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/right/memoryButton/tip"), {
		"MEMORY_REVIEW"
	}, function(arg_31_0)
		local var_31_0 = getProxy(PlayerProxy):getRawData() and _.any(pg.memory_group.all, function(arg_32_0)
			return PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_0.id .. " " .. arg_32_0, 0) == 1
		end)

		if not var_31_0 then
			if getProxy(LoveLetterProxy):getRawData() then
				if getProxy(LoveLetterProxy):IsTipUnlockLetter() then
					var_31_0 = true
				end
			end
		end

		setActive(arg_31_0, tobool(var_31_0))

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/right/collectionButton/tip"), {
		"COLLECTION"
	}, function(arg_33_0)
		local var_33_0 = getProxy(CollectionProxy):hasFinish()

		if not var_33_0 then
			var_33_0 = getProxy(AppreciateProxy):isGalleryHaveNewRes()

			if not var_33_0 then
				var_33_0 = getProxy(AppreciateProxy):isMusicHaveNewRes()
				var_33_0 = var_33_0 or getProxy(AppreciateProxy):isMangaHaveNewRes()
			end
		end

		setActive(arg_33_0, var_33_0)

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/right/friendButton/tip"), {
		"FRIEND"
	}, function(arg_34_0)
		local var_34_0 = arg_34_0
		local var_34_1

		if getProxy(NotificationProxy):getRequestCount() <= 0 then
			if getProxy(FriendProxy):getNewMsgCount() <= 0 then
				var_34_1 = false

				goto label_34_0
			end
		end

		var_34_1 = true

		::label_34_0::

		setActive(var_34_0, var_34_1)

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/left/commissionButton/tip"), {
		"COMMISSION"
	}, function(arg_35_0)
		setActive(arg_35_0, getProxy(PlayerProxy):IsShowCommssionTip())

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/right/settingButton/tip"), {
		"SETTING"
	}, function(arg_36_0)
		setActive(arg_36_0, PlayerPrefs.GetInt("firstIntoOtherPanel", 0) == 0)

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/right/noticeButton/tip"), {
		"SERVER"
	}, function(arg_37_0)
		local var_37_0 = getProxy(ServerNoticeProxy)
		local var_37_2 = arg_37_0
		local var_37_3 = #var_37_0:getServerNotices(false) > 0 and getProxy(ServerNoticeProxy):hasNewNotice()

		var_37_1(var_37_2, var_37_3)

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/bottom/technologyButton/tip"), {
		"BLUEPRINT"
	}, function(arg_38_0)
		setActive(arg_38_0, getProxy(TechnologyProxy):IsShowTip())

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/right/combatBtn/tip"), {
		"EVENT"
	}, function(arg_39_0)
		local var_39_0 = getProxy(EventProxy):hasFinishState()

		var_39_0 = var_39_0 or LimitChallengeConst.IsShowRedPoint()

		setActive(arg_39_0, var_39_0)

		return
	end)
	;(function(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end)(arg_24_0._tf:Find("frame/bottom/liveButton/tip"), {
		"COURTYARD",
		"SCHOOL",
		"COMMANDER",
		"DORM3D_SHOP_TIMELIMIT",
		"EDUCATE_NEW_CHILD",
		"ISLAND_3D"
	}, function(arg_40_0)
		local var_40_0 = getProxy(PlayerProxy):getRawData()
		local var_40_1 = false

		if var_40_0.level >= 40 then
			local var_40_2 = getProxy(CommanderProxy):IsFinishAllBox()

			if not LOCK_CATTERY then
				if not var_40_2 then
					::label_40_0::

					local var_40_3 = getProxy(CommanderProxy)

					var_40_1 = var_40_3:AnyCatteryExistOP() or getProxy(CommanderProxy):AnyCatteryCanUse()
				end
			else
				var_40_1 = var_40_2
			end
		end

		local var_40_4 = pg.SystemOpenMgr.GetInstance():isOpenSystem(var_40_0.level, "SelectDorm3DMediator")
		local var_40_5 = getProxy(DormProxy):IsShowRedDot()

		if not var_40_5 then
			var_40_5 = getProxy(NavalAcademyProxy):IsShowTip()

			if not var_40_5 and not var_40_1 then
				::label_40_1::

				if var_40_4 then
					var_40_5 = Dorm3dShopUI.ShouldShowAllTip()

					if not var_40_5 then
						var_40_5 = NewEducateHelper.IsShowNewChildTip()
						var_40_5 = var_40_5 or getProxy(SystemTipProxy):IsIslandRedDotTip()
					end

					setActive(arg_40_0, var_40_5)

					return
				end
			end
		end
	end)

	return {}
end

function var_0_0.OnAsmrTurnning(arg_41_0, arg_41_1)
	var_0_0.super.OnAsmrTurnning(arg_41_0, arg_41_1)
	setActive(findTF(arg_41_0._tf, "top_bg"), not arg_41_1)
	setActive(findTF(arg_41_0._tf, "bottom_bg"), not arg_41_1)
	setActive(findTF(arg_41_0._tf, "bg"), not arg_41_1)

	GetOrAddComponent(findTF(arg_41_0._tf, "frame"), typeof(CanvasGroup)).alpha = arg_41_1 ~= true and 1 or 0
	GetOrAddComponent(findTF(arg_41_0._tf, "frame"), typeof(CanvasGroup)).interactable = arg_41_1 ~= true

	return
end

return var_0_0
