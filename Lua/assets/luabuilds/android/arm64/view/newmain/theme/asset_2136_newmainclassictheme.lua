local NewMainClassicTheme = class("NewMainClassicTheme", import(".NewMainSceneBaseTheme"))

function NewMainClassicTheme:getUIName()
	return "NewMainClassicTheme"
end

function NewMainClassicTheme:OnLoaded()
	NewMainClassicTheme.super.OnLoaded(self)

	self.adapterView = MainAdpterView.New(self._tf:Find("top_bg"), self._tf:Find("bottom_bg"), self._tf:Find("bg/right"))

	self.changeView:SetAsmrTurnningParent(self._tf:Find("frame/right/asmrToggleContainer"))

	return
end

function NewMainClassicTheme:PlayEnterAnimation(arg_3_1, arg_3_2)
	self.adapterView:Init()
	NewMainClassicTheme.super.PlayEnterAnimation(self, arg_3_1, arg_3_2)

	return
end

function NewMainClassicTheme:_FoldPanels(arg_4_1, arg_4_2)
	NewMainClassicTheme.super._FoldPanels(self, arg_4_1, arg_4_2)
	self.adapterView:Fold(arg_4_1, arg_4_2)

	return
end

function NewMainClassicTheme:OnDestroy()
	NewMainClassicTheme.super.OnDestroy(self)

	if self.adapterView then
		self.adapterView:Dispose()

		self.adapterView = nil
	end

	return
end

function NewMainClassicTheme:SetEffectPanelVisible(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.panels) do
		if isa(iter_6_1, MainRightPanel) then
			iter_6_1:SetEffectVisible(arg_6_1)
		end
	end

	return
end

function NewMainClassicTheme:GetCalibrationBG()
	return "mainui_calibration"
end

function NewMainClassicTheme:GetPbList()
	return {
		self._tf:Find("frame/chatPreview"),
		self._tf:Find("frame/eventPanel")
	}
end

function NewMainClassicTheme:GetPaintingOffset(arg_9_1)
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

function NewMainClassicTheme:GetWordView()
	return MainWordView.New(self._tf:Find("chat"), self.event)
end

function NewMainClassicTheme:GetTagView()
	return MainTagsView.New(self._tf:Find("frame/bottom/tags"), self.event)
end

function NewMainClassicTheme:GetTopPanel()
	return MainTopPanel.New(self._tf:Find("frame/top"), self.event, self.contextData)
end

function NewMainClassicTheme:GetRightPanel()
	return MainRightPanel.New(self._tf:Find("frame/right"), self.event, self.contextData)
end

function NewMainClassicTheme:GetLeftPanel()
	return MainLeftPanel.New(self._tf:Find("frame/left"), self.event, self.contextData)
end

function NewMainClassicTheme:GetBottomPanel()
	return MainBottomPanel.New(self._tf:Find("frame/bottom"), self.event, self.contextData)
end

function NewMainClassicTheme:GetIconView()
	return MainIconView.New(self._tf:Find("frame/char"))
end

function NewMainClassicTheme:GetChatRoomView()
	return MainChatRoomView.New(self._tf:Find("frame/chatPreview"), self.event)
end

function NewMainClassicTheme:GetBannerView()
	return MainBannerView.New(self._tf:Find("frame/eventPanel"), self.event)
end

function NewMainClassicTheme:GetActBtnView()
	return MainActivityBtnView.New(self._tf:Find("frame/linkBtns"), self.event)
end

function NewMainClassicTheme:GetBuffView()
	return MainBuffView.New(self._tf:Find("frame/buffs"), self.event)
end

function NewMainClassicTheme:GetCalibrationView()
	return MainCalibrationPage.New(self._tf, self.event)
end

function NewMainClassicTheme:GetChangeSkinView()
	return MainChangeSkinView.New(self._tf:Find("frame/bottom/change_skin"), self.event)
end

function NewMainClassicTheme:GetAsmrChatView()
	return MainAsmrChatView.New(self._tf:Find("frame/bottom/asmr_chat"), self.event)
end

function NewMainClassicTheme:RegisterRedDots()
	local var_24_0 = pg.EasyRedDotMgr.GetInstance()
	local var_24_1 = {}

	local function var_24_2(arg_25_0, arg_25_1, arg_25_2)
		var_24_0:RegisterRedDot(arg_25_0, arg_25_1, arg_25_2)
		table.insert(var_24_1, arg_25_0)

		return
	end

	var_24_2(self._tf:Find("frame/bottom/taskButton/tip"), {
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

		::label_26_0::

		setActive(var_26_0, true)

		return
	end)

	local var_24_3 = self._tf:Find("frame/right/mailButton")
	local var_24_4 = findTF(var_24_3, "unread")
	local var_24_5 = findTF(var_24_3, "read")
	local var_24_6 = findTF(var_24_3, "attachmentLabel")
	local var_24_7 = findTF(var_24_6, "attachmentCountText"):GetComponent(typeof(Text))
	local var_24_8 = getProxy(MailProxy)

	if var_24_8.total == math.clamp(var_24_8.total, MAIL_COUNT_LIMIT * 0.9, MAIL_COUNT_LIMIT) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("warning_mail_max_1", var_24_8.total, MAIL_COUNT_LIMIT))
	end

	var_24_2(var_24_3, {
		"MAIL"
	}, function(arg_27_0)
		local var_27_0 = getProxy(MailProxy):GetUnreadCount()

		if var_27_0 > 0 then
			SetActive(var_24_6, true)
			SetActive(var_24_5, false)
			SetActive(var_24_4, true)

			arg_27_0:GetComponent(typeof(Button)).targetGraphic = var_24_4:GetComponent(typeof(Image))

			if 99 < var_27_0 then
				var_24_7.text = 99 .. "+" or tostring(var_27_0)
			end
		else
			SetActive(var_24_5, true)
			SetActive(var_24_4, false)
			SetActive(var_24_6, false)

			arg_27_0:GetComponent(typeof(Button)).targetGraphic = var_24_5:GetComponent(typeof(Image))
		end

		return
	end)
	var_24_2(self._tf:Find("frame/bottom/buildButton/tip"), {
		"BUILD"
	}, function(arg_28_0)
		local var_28_0 = arg_28_0

		setActive(var_28_0, getProxy(BuildShipProxy):getFinishCount() <= 0 and tobool(getProxy(ActivityProxy):IsShowFreeBuildMark(true)) or true)

		return
	end)
	var_24_2(self._tf:Find("frame/bottom/guildButton/tip"), {
		"GUILD"
	}, function(arg_29_0)
		setActive(arg_29_0, getProxy(GuildProxy):ShouldShowTip())

		return
	end)
	var_24_2(self._tf:Find("frame/top/tip"), {
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
	var_24_2(self._tf:Find("frame/right/memoryButton/tip"), {
		"MEMORY_REVIEW"
	}, function(arg_31_0)
		local var_31_0 = getProxy(PlayerProxy):getRawData()
		local var_31_1 = var_31_0 and _.any(pg.memory_group.all, function(arg_32_0)
			return PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_31_0.id .. " " .. arg_32_0, 0) == 1
		end)

		if not var_31_1 then
			if getProxy(LoveLetterProxy):getRawData() then
				if getProxy(LoveLetterProxy):IsTipUnlockLetter() then
					var_31_1 = true
				end
			end
		end

		setActive(arg_31_0, tobool(var_31_1))

		return
	end)
	var_24_2(self._tf:Find("frame/right/collectionButton/tip"), {
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
	var_24_2(self._tf:Find("frame/right/friendButton/tip"), {
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

		::label_34_0::

		setActive(var_34_0, true)

		return
	end)
	var_24_2(self._tf:Find("frame/left/commissionButton/tip"), {
		"COMMISSION"
	}, function(arg_35_0)
		setActive(arg_35_0, getProxy(PlayerProxy):IsShowCommssionTip())

		return
	end)
	var_24_2(self._tf:Find("frame/right/settingButton/tip"), {
		"SETTING"
	}, function(arg_36_0)
		setActive(arg_36_0, PlayerPrefs.GetInt("firstIntoOtherPanel", 0) == 0)

		return
	end)
	var_24_2(self._tf:Find("frame/right/noticeButton/tip"), {
		"SERVER"
	}, function(arg_37_0)
		setActive(arg_37_0, #getProxy(ServerNoticeProxy):getServerNotices(false) > 0 and getProxy(ServerNoticeProxy):hasNewNotice())

		return
	end)
	var_24_2(self._tf:Find("frame/bottom/technologyButton/tip"), {
		"BLUEPRINT"
	}, function(arg_38_0)
		setActive(arg_38_0, getProxy(TechnologyProxy):IsShowTip())

		return
	end)
	var_24_2(self._tf:Find("frame/right/combatBtn/tip"), {
		"EVENT"
	}, function(arg_39_0)
		local var_39_0 = getProxy(EventProxy):hasFinishState()

		var_39_0 = var_39_0 or LimitChallengeConst.IsShowRedPoint()

		setActive(arg_39_0, var_39_0)

		return
	end)
	var_24_2(self._tf:Find("frame/bottom/liveButton/tip"), {
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

					var_40_1 = getProxy(CommanderProxy):AnyCatteryExistOP() or getProxy(CommanderProxy):AnyCatteryCanUse()
				end
			else
				var_40_1 = var_40_2
			end
		end

		local var_40_3 = pg.SystemOpenMgr.GetInstance():isOpenSystem(var_40_0.level, "SelectDorm3DMediator")
		local var_40_4 = getProxy(DormProxy):IsShowRedDot()

		if not var_40_4 then
			var_40_4 = getProxy(NavalAcademyProxy):IsShowTip()

			if not var_40_4 and not var_40_1 then
				::label_40_1::

				if var_40_3 then
					var_40_4 = Dorm3dShopUI.ShouldShowAllTip()

					if not var_40_4 then
						var_40_4 = NewEducateHelper.IsShowNewChildTip()
						var_40_4 = var_40_4 or getProxy(SystemTipProxy):IsIslandRedDotTip()
					end
				end
			end
		end

		setActive(arg_40_0, var_40_4)

		return
	end)

	return var_24_1
end

function NewMainClassicTheme:OnAsmrTurnning(arg_41_1)
	NewMainClassicTheme.super.OnAsmrTurnning(self, arg_41_1)
	setActive(findTF(self._tf, "top_bg"), not arg_41_1)
	setActive(findTF(self._tf, "bottom_bg"), not arg_41_1)
	setActive(findTF(self._tf, "bg"), not arg_41_1)

	GetOrAddComponent(findTF(self._tf, "frame"), typeof(CanvasGroup)).alpha = arg_41_1 ~= true and 1 or 0
	GetOrAddComponent(findTF(self._tf, "frame"), typeof(CanvasGroup)).interactable = arg_41_1 ~= true

	return
end

return NewMainClassicTheme
