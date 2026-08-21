local var_0_0 = class("NewMainMellowTheme", import(".NewMainSceneBaseTheme"))

function var_0_0.getUIName(arg_1_0)
	return "NewMainMellowTheme"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.switcherAnimationPlayer = arg_2_0._tf:Find("frame/right"):GetComponent(typeof(Animation))
	arg_2_0.animationPlayer = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.dftAniEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))
	arg_2_0.switcher = arg_2_0._tf:Find("frame/right/switch")

	onToggle(arg_2_0, arg_2_0.switcher, function(arg_3_0)
		arg_2_0.switcherAnimationPlayer:Play(arg_3_0 and "anim_newmain_switch_1to2" or "anim_newmain_switch_2to1")
		pg.EasyRedDotMgr.GetInstance():TriggerMarks("COLLECTION", "FRIEND", "MEMORY_REVIEW", "EVENT")

		return
	end, SFX_PANEL)
	arg_2_0:Register()

	return
end

function var_0_0.Register(arg_4_0)
	return
end

function var_0_0.PlayEnterAnimation(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.bannerView:Init()
	arg_5_0.actBtnView:Init()
	arg_5_0.dftAniEvent:SetStartEvent(nil)
	arg_5_0.dftAniEvent:SetStartEvent(function()
		arg_5_0.dftAniEvent:SetStartEvent(nil)

		arg_5_0.mainCG.alpha = 1

		return
	end)
	arg_5_0.animationPlayer:Play("anim_newmain_open")
	onDelayTick(arg_5_2, 0.51)

	return
end

function var_0_0.Refresh(arg_7_0, arg_7_1)
	var_0_0.super.Refresh(arg_7_0, arg_7_1)
	originalPrint(" >>>>>>>>>> run in play open anim")
	arg_7_0.animationPlayer:Play("anim_newmain_open")

	return
end

function var_0_0.OnFoldPanels(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.animationPlayer:Play("anim_newmain_hide")
	else
		arg_8_0.animationPlayer:Play("anim_newmain_show")
	end

	return
end

function var_0_0.Disable(arg_9_0)
	var_0_0.super.Disable(arg_9_0)
	arg_9_0.dftAniEvent:SetStartEvent(nil)
	triggerToggle(arg_9_0.switcher, false)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	var_0_0.super.OnDestroy(arg_10_0)
	arg_10_0.dftAniEvent:SetStartEvent(nil)

	return
end

function var_0_0.SetEffectPanelVisible(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.panels) do
		if isa(iter_11_1, MainRightPanel4Mellow) then
			iter_11_1:SetEffectVisible(arg_11_1)
		end
	end

	return
end

function var_0_0.ApplyDefaultResUI(arg_12_0)
	return false
end

function var_0_0.GetCalibrationBG(arg_13_0)
	return "mainui_calibration_mellow"
end

function var_0_0.GetPbList(arg_14_0)
	return {
		arg_14_0._tf:Find("frame/bottom/frame")
	}
end

function var_0_0.GetPaintingOffset(arg_15_0, arg_15_1)
	local var_15_0 = pg.ship_skin_newmainui_shift[arg_15_1:getSkinId()]

	if var_15_0 then
		return MainPaintingShift.New(arg_15_0:GetConfigShift(var_15_0), Vector3(-MainPaintingView.MESH_POSITION_X_OFFSET, -10, 0))
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

function var_0_0.GetConfigShift(arg_16_0, arg_16_1)
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

function var_0_0.GetWordView(arg_17_0)
	return MainWordView4Mellow.New(arg_17_0._tf:Find("chat"), arg_17_0.event)
end

function var_0_0.GetTagView(arg_18_0)
	return MainTagsView.New(arg_18_0._tf:Find("frame/bottom/tags"), arg_18_0.event)
end

function var_0_0.GetTopPanel(arg_19_0)
	return MainTopPanel4Mellow.New(arg_19_0._tf:Find("frame/top"), arg_19_0.event, arg_19_0.contextData)
end

function var_0_0.GetRightPanel(arg_20_0)
	return MainRightPanel4Mellow.New(arg_20_0._tf:Find("frame/right"), arg_20_0.event, arg_20_0.contextData)
end

function var_0_0.GetLeftPanel(arg_21_0)
	return MainLeftPanel4Mellow.New(arg_21_0._tf:Find("frame/left"), arg_21_0.event, arg_21_0.contextData)
end

function var_0_0.GetBottomPanel(arg_22_0)
	return MainBottomPanel4Mellow.New(arg_22_0._tf:Find("frame/bottom"), arg_22_0.event, arg_22_0.contextData)
end

function var_0_0.GetIconView(arg_23_0)
	return MainIconView4Mellow.New(arg_23_0._tf:Find("frame/top/icon"), arg_23_0.event)
end

function var_0_0.GetChatRoomView(arg_24_0)
	return MainChatRoomView4Mellow.New(arg_24_0._tf:Find("frame/right/chat_room"), arg_24_0.event)
end

function var_0_0.GetBannerView(arg_25_0)
	return MainBannerView4Mellow.New(arg_25_0._tf:Find("frame/left/banner"), arg_25_0.event)
end

function var_0_0.GetActBtnView(arg_26_0)
	return MainActivityBtnView4Mellow.New(arg_26_0._tf:Find("frame"), arg_26_0.event)
end

function var_0_0.GetBuffView(arg_27_0)
	return MainBuffView4Mellow.New(arg_27_0._tf:Find("frame/top/buff_list"), arg_27_0.event)
end

function var_0_0.GetChangeSkinView(arg_28_0)
	return MainChangeSkinView.New(arg_28_0._tf:Find("frame/right/change_skin"), arg_28_0.event)
end

function var_0_0.GetAsmrChatView(arg_29_0)
	return MainAsmrChatView.New(arg_29_0._tf:Find("frame/bottom/asmr_chat"), arg_29_0.event)
end

function var_0_0.OnAsmrTurnning(arg_30_0, arg_30_1)
	var_0_0.super.OnAsmrTurnning(arg_30_0, arg_30_1)
	setActive(findTF(arg_30_0._tf, "s"), not arg_30_1)

	return
end

function var_0_0.RegisterRedDots(arg_31_0)
	local var_31_0 = pg.EasyRedDotMgr.GetInstance()
	local var_31_1 = {}

	;(function(arg_32_0, arg_32_1, arg_32_2)
		var_31_0:RegisterRedDot(arg_32_0, arg_32_1, arg_32_2)
		table.insert(var_31_1, arg_32_0)

		return
	end)(arg_31_0._tf:Find("frame/bottom/frame/task/tip"), {
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

		var_33_1 = true

		::label_33_0::

		setActive(var_33_0, var_33_1)

		return
	end)

	local var_31_3 = arg_31_0._tf:Find("frame/top/btns/mail")
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

			local var_34_1 = var_31_5

			if 99 < var_34_0 then
				var_34_1.text = 99 .. "+" or tostring(var_34_0)

				if false then
					SetActive(var_31_4, false)

					var_31_5.text = ""
				end

				return
			end
		end
	end)
	var_31_2(arg_31_0._tf:Find("frame/bottom/frame/build/tip"), {
		"BUILD"
	}, function(arg_35_0)
		local var_35_0 = arg_35_0
		local var_35_1

		if getProxy(BuildShipProxy):getFinishCount() <= 0 then
			var_35_1 = tobool(getProxy(ActivityProxy):IsShowFreeBuildMark(true))

			if false then
				var_35_1 = false
			end
		else
			var_35_1 = true
		end

		setActive(var_35_0, var_35_1)

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/bottom/frame/guild/tip"), {
		"GUILD"
	}, function(arg_36_0)
		setActive(arg_36_0, getProxy(GuildProxy):ShouldShowTip())

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/top/icon_front/tip"), {
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
	var_31_2(arg_31_0._tf:Find("frame/right/2/menor/root/tip"), {
		"MEMORY_REVIEW"
	}, function(arg_38_0)
		local var_38_0 = getProxy(PlayerProxy):getRawData() and _.any(pg.memory_group.all, function(arg_39_0)
			return PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_0.id .. " " .. arg_39_0, 0) == 1
		end)

		if not var_38_0 then
			if getProxy(LoveLetterProxy):getRawData() then
				if getProxy(LoveLetterProxy):IsTipUnlockLetter() then
					var_38_0 = true
				end
			end
		end

		setActive(arg_38_0, tobool(var_38_0))

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/right/2/collection/root/tip"), {
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
	var_31_2(arg_31_0._tf:Find("frame/right/2/friend/root/tip"), {
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

		var_41_1 = true

		::label_41_0::

		setActive(var_41_0, var_41_1)

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/left/extend/tip"), {
		"COMMISSION"
	}, function(arg_42_0)
		setActive(arg_42_0, getProxy(PlayerProxy):IsShowCommssionTip())

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/top/btns/settings/tip"), {
		"SETTING"
	}, function(arg_43_0)
		setActive(arg_43_0, PlayerPrefs.GetInt("firstIntoOtherPanel", 0) == 0)

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/top/btns/noti/tip"), {
		"SERVER"
	}, function(arg_44_0)
		local var_44_0 = getProxy(ServerNoticeProxy)
		local var_44_2 = arg_44_0
		local var_44_3 = #var_44_0:getServerNotices(false) > 0 and getProxy(ServerNoticeProxy):hasNewNotice()

		var_44_1(var_44_2, var_44_3)

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/bottom/frame/tech/tip"), {
		"BLUEPRINT"
	}, function(arg_45_0)
		setActive(arg_45_0, getProxy(TechnologyProxy):IsShowTip())

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/right/1/battle/root/tip"), {
		"EVENT"
	}, function(arg_46_0)
		local var_46_0 = getProxy(EventProxy):hasFinishState()

		var_46_0 = var_46_0 or LimitChallengeConst.IsShowRedPoint()

		setActive(arg_46_0, var_46_0)

		return
	end)
	var_31_2(arg_31_0._tf:Find("frame/bottom/frame/live/tip"), {
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

					local var_47_3 = getProxy(CommanderProxy)

					var_47_1 = var_47_3:AnyCatteryExistOP() or getProxy(CommanderProxy):AnyCatteryCanUse()
				end
			else
				var_47_1 = var_47_2
			end
		end

		local var_47_4 = pg.SystemOpenMgr.GetInstance():isOpenSystem(var_47_0.level, "SelectDorm3DMediator")
		local var_47_5 = getProxy(DormProxy):IsShowRedDot()

		if not var_47_5 then
			var_47_5 = getProxy(NavalAcademyProxy):IsShowTip()

			if not var_47_5 and not var_47_1 then
				::label_47_1::

				if var_47_4 then
					var_47_5 = Dorm3dShopUI.ShouldShowAllTip()

					if not var_47_5 then
						var_47_5 = NewEducateHelper.IsShowNewChildTip()
						var_47_5 = var_47_5 or getProxy(SystemTipProxy):IsIslandRedDotTip()
					end

					setActive(arg_47_0, var_47_5)

					return
				end
			end
		end
	end)

	local var_31_7 = arg_31_0._tf:Find("frame/right/switch")
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
									if getProxy(PlayerProxy):getRawData() and _.any(pg.memory_group.all, function(arg_50_0)
										return PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_0.id .. " " .. arg_50_0, 0) == 1
									end) then
										return true
									end

									local var_49_1 = getProxy(LoveLetterProxy):getRawData()

									var_49_1 = var_49_1 and getProxy(LoveLetterProxy):IsTipUnlockLetter()

									return var_49_0(var_49_1)
								end)()

								if false then
									var_48_0 = false
								end

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
		local var_51_0 = (getProxy(EventProxy):hasFinishState() or LimitChallengeConst.IsShowRedPoint()) and var_31_8.isOn

		setActive(arg_51_0, var_51_0)

		return
	end)

	return var_31_1
end

return var_0_0
