local NewMainMellowTheme = class("NewMainMellowTheme", import(".NewMainSceneBaseTheme"))

function NewMainMellowTheme:getUIName()
	return "NewMainMellowTheme"
end

function NewMainMellowTheme:OnLoaded()
	NewMainMellowTheme.super.OnLoaded(self)

	self.switcherAnimationPlayer = self._tf:Find("frame/right"):GetComponent(typeof(Animation))
	self.animationPlayer = self._tf:GetComponent(typeof(Animation))
	self.dftAniEvent = self._tf:GetComponent(typeof(DftAniEvent))
	self.switcher = self._tf:Find("frame/right/switch")

	onToggle(self, self.switcher, function(arg_3_0)
		self.switcherAnimationPlayer:Play(arg_3_0 and "anim_newmain_switch_1to2" or "anim_newmain_switch_2to1")
		pg.EasyRedDotMgr.GetInstance():TriggerMarks("COLLECTION", "FRIEND", "MEMORY_REVIEW", "EVENT")

		return
	end, SFX_PANEL)
	self:Register()

	return
end

function NewMainMellowTheme:Register()
	return
end

function NewMainMellowTheme:PlayEnterAnimation(arg_5_1, arg_5_2)
	self.bannerView:Init()
	self.actBtnView:Init()
	self.dftAniEvent:SetStartEvent(nil)
	self.dftAniEvent:SetStartEvent(function()
		self.dftAniEvent:SetStartEvent(nil)

		self.mainCG.alpha = 1

		return
	end)
	self.animationPlayer:Play("anim_newmain_open")
	onDelayTick(arg_5_2, 0.51)

	return
end

function NewMainMellowTheme:Refresh(arg_7_1)
	NewMainMellowTheme.super.Refresh(self, arg_7_1)
	originalPrint(" >>>>>>>>>> run in play open anim")
	self.animationPlayer:Play("anim_newmain_open")

	return
end

function NewMainMellowTheme:OnFoldPanels(arg_8_1)
	if arg_8_1 then
		self.animationPlayer:Play("anim_newmain_hide")
	else
		self.animationPlayer:Play("anim_newmain_show")
	end

	return
end

function NewMainMellowTheme:Disable()
	NewMainMellowTheme.super.Disable(self)
	self.dftAniEvent:SetStartEvent(nil)
	triggerToggle(self.switcher, false)

	return
end

function NewMainMellowTheme:OnDestroy()
	NewMainMellowTheme.super.OnDestroy(self)
	self.dftAniEvent:SetStartEvent(nil)

	return
end

function NewMainMellowTheme:SetEffectPanelVisible(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self.panels) do
		if isa(iter_11_1, MainRightPanel4Mellow) then
			iter_11_1:SetEffectVisible(arg_11_1)
		end
	end

	return
end

function NewMainMellowTheme:ApplyDefaultResUI()
	return false
end

function NewMainMellowTheme:GetCalibrationBG()
	return "mainui_calibration_mellow"
end

function NewMainMellowTheme:GetPbList()
	return {
		self._tf:Find("frame/bottom/frame")
	}
end

function NewMainMellowTheme:GetPaintingOffset(arg_15_1)
	local var_15_0 = pg.ship_skin_newmainui_shift[arg_15_1:getSkinId()]

	if var_15_0 then
		return MainPaintingShift.New(self:GetConfigShift(var_15_0), Vector3(-MainPaintingView.MESH_POSITION_X_OFFSET, -10, 0))
	else
		return MainPaintingShift.New({
			-MainPaintingView.MESH_POSITION_X_OFFSET,
			-10,
			MainPaintingView.MESH_POSITION_X_OFFSET,
			0,
			MainPaintingView.MESH_POSITION_X_OFFSET,
			0,
			1,
			1,
			1
		})
	end

	return
end

function NewMainMellowTheme:GetConfigShift(arg_16_1)
	return {
		arg_16_1.skin_shift[1],
		arg_16_1.skin_shift[2],
		arg_16_1.l2d_shift[1] - arg_16_1.skin_shift[1],
		arg_16_1.l2d_shift[2] - arg_16_1.skin_shift[2],
		arg_16_1.spine_shift[1] - arg_16_1.skin_shift[1],
		arg_16_1.spine_shift[2] - arg_16_1.skin_shift[2],
		arg_16_1.skin_shift[4],
		arg_16_1.l2d_shift[4],
		arg_16_1.spine_shift[4]
	}
end

function NewMainMellowTheme:GetWordView()
	return MainWordView4Mellow.New(self._tf:Find("chat"), self.event)
end

function NewMainMellowTheme:GetTagView()
	return MainTagsView.New(self._tf:Find("frame/bottom/tags"), self.event)
end

function NewMainMellowTheme:GetTopPanel()
	return MainTopPanel4Mellow.New(self._tf:Find("frame/top"), self.event, self.contextData)
end

function NewMainMellowTheme:GetRightPanel()
	return MainRightPanel4Mellow.New(self._tf:Find("frame/right"), self.event, self.contextData)
end

function NewMainMellowTheme:GetLeftPanel()
	return MainLeftPanel4Mellow.New(self._tf:Find("frame/left"), self.event, self.contextData)
end

function NewMainMellowTheme:GetBottomPanel()
	return MainBottomPanel4Mellow.New(self._tf:Find("frame/bottom"), self.event, self.contextData)
end

function NewMainMellowTheme:GetIconView()
	return MainIconView4Mellow.New(self._tf:Find("frame/top/icon"), self.event)
end

function NewMainMellowTheme:GetChatRoomView()
	return MainChatRoomView4Mellow.New(self._tf:Find("frame/right/chat_room"), self.event)
end

function NewMainMellowTheme:GetBannerView()
	return MainBannerView4Mellow.New(self._tf:Find("frame/left/banner"), self.event)
end

function NewMainMellowTheme:GetActBtnView()
	return MainActivityBtnView4Mellow.New(self._tf:Find("frame"), self.event)
end

function NewMainMellowTheme:GetBuffView()
	return MainBuffView4Mellow.New(self._tf:Find("frame/top/buff_list"), self.event)
end

function NewMainMellowTheme:GetChangeSkinView()
	return MainChangeSkinView.New(self._tf:Find("frame/right/change_skin"), self.event)
end

function NewMainMellowTheme:GetAsmrChatView()
	return MainAsmrChatView.New(self._tf:Find("frame/bottom/asmr_chat"), self.event)
end

function NewMainMellowTheme:OnAsmrTurnning(arg_30_1)
	NewMainMellowTheme.super.OnAsmrTurnning(self, arg_30_1)
	setActive(findTF(self._tf, "s"), not arg_30_1)

	return
end

function NewMainMellowTheme:RegisterRedDots()
	local var_31_0 = pg.EasyRedDotMgr.GetInstance()
	local var_31_1 = {}

	local function var_31_2(arg_32_0, arg_32_1, arg_32_2)
		var_31_0:RegisterRedDot(arg_32_0, arg_32_1, arg_32_2)
		table.insert(var_31_1, arg_32_0)

		return
	end

	var_31_2(self._tf:Find("frame/bottom/frame/task/tip"), {
		"TASK"
	}, function(arg_33_0)
		local var_33_0 = arg_33_0
		local var_33_1

		if getProxy(TaskProxy):getCanReceiveCount() <= 0 then
			if getProxy(AvatarFrameProxy):getCanReceiveCount() <= 0 then
				var_33_1 = false

				goto label_33_0
			end
		end

		::label_33_0::

		setActive(var_33_0, true)

		return
	end)

	local var_31_3 = self._tf:Find("frame/top/btns/mail")
	local var_31_4 = findTF(var_31_3, "tip")
	local var_31_5 = findTF(var_31_3, "Text"):GetComponent(typeof(Text))
	local var_31_6 = getProxy(MailProxy)

	if var_31_6.total >= MAIL_COUNT_LIMIT then
		pg.TipsMgr.GetInstance():ShowTips(i18n("warning_mail_max_2"))
	elseif var_31_6.total > MAIL_COUNT_LIMIT * 0.9 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("warning_mail_max_1", var_31_6.total, MAIL_COUNT_LIMIT))
	end

	var_31_2(var_31_3, {
		"MAIL"
	}, function(arg_34_0)
		local var_34_0 = getProxy(MailProxy):GetUnreadCount()

		if var_34_0 > 0 then
			SetActive(var_31_4, true)

			if 99 < var_34_0 then
				var_31_5.text = 99 .. "+" or tostring(var_34_0)
			end
		else
			SetActive(var_31_4, false)

			var_31_5.text = ""
		end

		return
	end)
	var_31_2(self._tf:Find("frame/bottom/frame/build/tip"), {
		"BUILD"
	}, function(arg_35_0)
		local var_35_0 = arg_35_0

		setActive(var_35_0, getProxy(BuildShipProxy):getFinishCount() <= 0 and tobool(getProxy(ActivityProxy):IsShowFreeBuildMark(true)) or true)

		return
	end)
	var_31_2(self._tf:Find("frame/bottom/frame/guild/tip"), {
		"GUILD"
	}, function(arg_36_0)
		setActive(arg_36_0, getProxy(GuildProxy):ShouldShowTip())

		return
	end)
	var_31_2(self._tf:Find("frame/top/icon_front/tip"), {
		"ATTIRE"
	}, function(arg_37_0)
		local var_37_0 = getProxy(AttireProxy):IsShowRedDot()

		if not var_37_0 then
			var_37_0 = getProxy(SettingsProxy):ShouldEducateCharTip()
			var_37_0 = var_37_0 or getProxy(ActivityProxy):IsTipLoveLetterMail()
		end

		setActive(arg_37_0, var_37_0)

		return
	end)
	var_31_2(self._tf:Find("frame/right/2/menor/root/tip"), {
		"MEMORY_REVIEW"
	}, function(arg_38_0)
		local var_38_0 = getProxy(PlayerProxy):getRawData()
		local var_38_1 = var_38_0 and _.any(pg.memory_group.all, function(arg_39_0)
			return PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_38_0.id .. " " .. arg_39_0, 0) == 1
		end)

		if not var_38_1 then
			if getProxy(LoveLetterProxy):getRawData() then
				if getProxy(LoveLetterProxy):IsTipUnlockLetter() then
					var_38_1 = true
				end
			end
		end

		setActive(arg_38_0, tobool(var_38_1))

		return
	end)
	var_31_2(self._tf:Find("frame/right/2/collection/root/tip"), {
		"COLLECTION"
	}, function(arg_40_0)
		local var_40_0 = getProxy(CollectionProxy):hasFinish()

		if not var_40_0 then
			var_40_0 = getProxy(AppreciateProxy):isGalleryHaveNewRes()

			if not var_40_0 then
				var_40_0 = getProxy(AppreciateProxy):isMusicHaveNewRes()
				var_40_0 = var_40_0 or getProxy(AppreciateProxy):isMangaHaveNewRes()
			end
		end

		setActive(arg_40_0, var_40_0)

		return
	end)
	var_31_2(self._tf:Find("frame/right/2/friend/root/tip"), {
		"FRIEND"
	}, function(arg_41_0)
		local var_41_0 = arg_41_0
		local var_41_1

		if getProxy(NotificationProxy):getRequestCount() <= 0 then
			if getProxy(FriendProxy):getNewMsgCount() <= 0 then
				var_41_1 = false

				goto label_41_0
			end
		end

		::label_41_0::

		setActive(var_41_0, true)

		return
	end)
	var_31_2(self._tf:Find("frame/left/extend/tip"), {
		"COMMISSION"
	}, function(arg_42_0)
		setActive(arg_42_0, getProxy(PlayerProxy):IsShowCommssionTip())

		return
	end)
	var_31_2(self._tf:Find("frame/top/btns/settings/tip"), {
		"SETTING"
	}, function(arg_43_0)
		setActive(arg_43_0, PlayerPrefs.GetInt("firstIntoOtherPanel", 0) == 0)

		return
	end)
	var_31_2(self._tf:Find("frame/top/btns/noti/tip"), {
		"SERVER"
	}, function(arg_44_0)
		setActive(arg_44_0, #getProxy(ServerNoticeProxy):getServerNotices(false) > 0 and getProxy(ServerNoticeProxy):hasNewNotice())

		return
	end)
	var_31_2(self._tf:Find("frame/bottom/frame/tech/tip"), {
		"BLUEPRINT"
	}, function(arg_45_0)
		setActive(arg_45_0, getProxy(TechnologyProxy):IsShowTip())

		return
	end)
	var_31_2(self._tf:Find("frame/right/1/battle/root/tip"), {
		"EVENT"
	}, function(arg_46_0)
		local var_46_0 = getProxy(EventProxy):hasFinishState()

		var_46_0 = var_46_0 or LimitChallengeConst.IsShowRedPoint()

		setActive(arg_46_0, var_46_0)

		return
	end)
	var_31_2(self._tf:Find("frame/bottom/frame/live/tip"), {
		"COURTYARD",
		"SCHOOL",
		"COMMANDER",
		"DORM3D_SHOP_TIMELIMIT",
		"EDUCATE_NEW_CHILD",
		"ISLAND_3D"
	}, function(arg_47_0)
		local var_47_0 = getProxy(PlayerProxy):getRawData()
		local var_47_1 = false

		if var_47_0.level >= 40 then
			local var_47_2 = getProxy(CommanderProxy):IsFinishAllBox()

			if not LOCK_CATTERY then
				if not var_47_2 then
					::label_47_0::

					var_47_1 = getProxy(CommanderProxy):AnyCatteryExistOP() or getProxy(CommanderProxy):AnyCatteryCanUse()
				end
			else
				var_47_1 = var_47_2
			end
		end

		local var_47_3 = pg.SystemOpenMgr.GetInstance():isOpenSystem(var_47_0.level, "SelectDorm3DMediator")
		local var_47_4 = getProxy(DormProxy):IsShowRedDot()

		if not var_47_4 then
			var_47_4 = getProxy(NavalAcademyProxy):IsShowTip()

			if not var_47_4 and not var_47_1 then
				::label_47_1::

				if var_47_3 then
					var_47_4 = Dorm3dShopUI.ShouldShowAllTip()

					if not var_47_4 then
						var_47_4 = NewEducateHelper.IsShowNewChildTip()
						var_47_4 = var_47_4 or getProxy(SystemTipProxy):IsIslandRedDotTip()
					end
				end
			end
		end

		setActive(arg_47_0, var_47_4)

		return
	end)

	local var_31_7 = self._tf:Find("frame/right/switch")
	local var_31_8 = var_31_7:GetComponent(typeof(Toggle))

	var_31_2(var_31_7:Find("on"), {
		"COLLECTION",
		"FRIEND",
		"MEMORY_REVIEW"
	}, function(arg_48_0)
		local var_48_0 = getProxy(CollectionProxy):hasFinish()

		if not var_48_0 then
			var_48_0 = getProxy(AppreciateProxy):isGalleryHaveNewRes()

			if not var_48_0 then
				var_48_0 = getProxy(AppreciateProxy):isMusicHaveNewRes()

				if not var_48_0 then
					var_48_0 = getProxy(AppreciateProxy):isMangaHaveNewRes()

					if not var_48_0 then
						if getProxy(NotificationProxy):getRequestCount() <= 0 then
							if getProxy(FriendProxy):getNewMsgCount() <= 0 then
								var_48_0 = (function()
									local var_49_0 = getProxy(PlayerProxy):getRawData()

									if var_49_0 and _.any(pg.memory_group.all, function(arg_50_0)
										return PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_49_0.id .. " " .. arg_50_0, 0) == 1
									end) then
										return true
									end

									local var_49_1 = tobool
									local var_49_2 = getProxy(LoveLetterProxy):getRawData()

									var_49_2 = var_49_2 and getProxy(LoveLetterProxy):IsTipUnlockLetter()

									return var_49_1(var_49_2)
								end)()

								goto label_48_0
							end
						end

						var_48_0 = true
					end
				end
			end
		end

		::label_48_0::

		setActive(arg_48_0, var_48_0 and not var_31_8.isOn)

		return
	end)
	var_31_2(var_31_7:Find("off"), {
		"EVENT"
	}, function(arg_51_0)
		setActive(arg_51_0, (getProxy(EventProxy):hasFinishState() or LimitChallengeConst.IsShowRedPoint()) and var_31_8.isOn)

		return
	end)

	return var_31_1
end

return NewMainMellowTheme
