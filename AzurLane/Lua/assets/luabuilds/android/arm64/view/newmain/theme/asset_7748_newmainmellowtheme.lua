class = var_0_10000

local var_0_0 = "NewMainMellowTheme"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewMainSceneBaseTheme"))

function var_0_1.getUIName(arg_1_0)
	return "NewMainMellowTheme"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/right")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.switcherAnimationPlayer = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.animationPlayer = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.dftAniEvent = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0._tf

	arg_2_0.switcher = var_1.Find(var_2_7, "frame/right/switch")
	onToggle = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.switcher

	local function var_2_10(arg_3_0)
		local var_3_0 = arg_3_0 and "anim_newmain_switch_1to2" or "anim_newmain_switch_2to1"
		local var_3_1 = arg_2_0.switcherAnimationPlayer

		var_2.Play(var_3_1, var_3_0)

		pg = var_2

		local var_3_2 = var_2.EasyRedDotMgr.GetInstance()

		var_2.TriggerMarks(var_3_2, "COLLECTION", "FRIEND", "MEMORY_REVIEW", "EVENT")

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_8, var_2_9, var_2_10, var_1_10006)
	arg_2_0:Register()

	return
end

function var_0_1.Register(arg_4_0)
	return
end

function var_0_1.PlayEnterAnimation(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.bannerView

	var_3.Init(var_5_0)

	local var_5_1 = arg_5_0.actBtnView

	var_3.Init(var_5_1)

	local var_5_2 = arg_5_0.dftAniEvent

	var_3.SetStartEvent(var_5_2, nil)

	local var_5_3 = arg_5_0.dftAniEvent

	var_3.SetStartEvent(var_5_3, function()
		local var_6_0 = arg_5_0.dftAniEvent

		var_0.SetStartEvent(var_6_0, nil)

		arg_5_0.mainCG.alpha = 1

		return
	end)

	local var_5_4 = arg_5_0.animationPlayer

	var_3.Play(var_5_4, "anim_newmain_open")

	onDelayTick = var_3

	var_3(arg_5_2, 0.51)

	return
end

function var_0_1.Refresh(arg_7_0, arg_7_1)
	var_0_1.super.Refresh(arg_7_0, arg_7_1)

	originalPrint = var_2

	var_2(" >>>>>>>>>> run in play open anim")

	local var_7_0 = arg_7_0.animationPlayer

	var_2.Play(var_7_0, "anim_newmain_open")

	return
end

function var_0_1.OnFoldPanels(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = arg_8_0.animationPlayer

		var_2.Play(var_8_0, "anim_newmain_hide")
	else
		local var_8_1 = arg_8_0.animationPlayer

		var_2.Play(var_8_1, "anim_newmain_show")
	end

	return
end

function var_0_1.Disable(arg_9_0)
	var_0_1.super.Disable(arg_9_0)

	local var_9_0 = arg_9_0.dftAniEvent

	var_1.SetStartEvent(var_9_0, nil)

	triggerToggle = var_1

	var_1(arg_9_0.switcher, false)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	var_0_1.super.OnDestroy(arg_10_0)

	local var_10_0 = arg_10_0.dftAniEvent

	var_1.SetStartEvent(var_10_0, nil)

	return
end

function var_0_1.SetEffectPanelVisible(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.panels) do
		isa = var_1_10007

		local var_11_0 = iter_11_1

		MainRightPanel4Mellow = var_1_10010

		if var_1_10007(var_11_0, var_1_10010) then
			iter_11_1:SetEffectVisible(arg_11_1)
		end
	end

	return
end

function var_0_1.ApplyDefaultResUI(arg_12_0)
	return false
end

function var_0_1.GetCalibrationBG(arg_13_0)
	return "mainui_calibration_mellow"
end

function var_0_1.GetPbList(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = arg_14_0._tf

	var_14_0[1] = var_2.Find(var_14_1, "frame/bottom/frame")

	return var_14_0
end

function var_0_1.GetPaintingOffset(arg_15_0, arg_15_1)
	pg = var_1_10002

	local var_15_0

	if var_1_10002.ship_skin_newmainui_shift[arg_15_1:getSkinId()] then
		var_15_0 = arg_15_0:GetConfigShift(var_2)
		MainPaintingShift = var_1_10004

		local var_15_1 = var_1_10004.New

		var_1_10006 = var_15_0
		Vector3 = var_1_10007
		MainPaintingView = var_1_10009

		return var_15_1(var_1_10006, var_1_10007(-var_1_10009.MESH_POSITION_X_OFFSET, -10, 0))
	else
		MainPaintingShift = var_15_0

		local var_15_2 = var_15_0.New
		local var_15_3 = {
			nil,
			-10,
			nil,
			0,
			nil,
			0,
			1,
			1,
			1
		}

		MainPaintingView = var_1_10006
		var_15_3[1] = -var_1_10006.MESH_POSITION_X_OFFSET
		MainPaintingView = var_6
		var_15_3[3] = var_6.MESH_POSITION_X_OFFSET
		MainPaintingView = var_6
		var_15_3[5] = var_6.MESH_POSITION_X_OFFSET

		return var_15_2(var_15_3)
	end

	return
end

function var_0_1.GetConfigShift(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.skin_shift
	local var_16_1 = arg_16_1.l2d_shift[1] - var_16_0[1]
	local var_16_2 = var_3[2] - var_16_0[2]
	local var_16_3 = arg_16_1.spine_shift[1] - var_16_0[1]
	local var_16_4 = var_6[2] - var_16_0[2]

	return {
		var_16_0[1],
		var_16_0[2],
		var_16_1,
		var_16_2,
		var_16_3,
		var_16_4,
		var_16_0[4],
		var_3[4],
		var_6[4]
	}
end

function var_0_1.GetWordView(arg_17_0)
	MainWordView4Mellow = var_1_10001

	local var_17_0 = var_1_10001.New
	local var_17_1 = arg_17_0._tf

	return var_17_0(var_3.Find(var_17_1, "chat"), arg_17_0.event)
end

function var_0_1.GetTagView(arg_18_0)
	MainTagsView = var_1_10001

	local var_18_0 = var_1_10001.New
	local var_18_1 = arg_18_0._tf

	return var_18_0(var_3.Find(var_18_1, "frame/bottom/tags"), arg_18_0.event)
end

function var_0_1.GetTopPanel(arg_19_0)
	MainTopPanel4Mellow = var_1_10001

	local var_19_0 = var_1_10001.New
	local var_19_1 = arg_19_0._tf

	return var_19_0(var_3.Find(var_19_1, "frame/top"), arg_19_0.event, arg_19_0.contextData)
end

function var_0_1.GetRightPanel(arg_20_0)
	MainRightPanel4Mellow = var_1_10001

	local var_20_0 = var_1_10001.New
	local var_20_1 = arg_20_0._tf

	return var_20_0(var_3.Find(var_20_1, "frame/right"), arg_20_0.event, arg_20_0.contextData)
end

function var_0_1.GetLeftPanel(arg_21_0)
	MainLeftPanel4Mellow = var_1_10001

	local var_21_0 = var_1_10001.New
	local var_21_1 = arg_21_0._tf

	return var_21_0(var_3.Find(var_21_1, "frame/left"), arg_21_0.event, arg_21_0.contextData)
end

function var_0_1.GetBottomPanel(arg_22_0)
	MainBottomPanel4Mellow = var_1_10001

	local var_22_0 = var_1_10001.New
	local var_22_1 = arg_22_0._tf

	return var_22_0(var_3.Find(var_22_1, "frame/bottom"), arg_22_0.event, arg_22_0.contextData)
end

function var_0_1.GetIconView(arg_23_0)
	MainIconView4Mellow = var_1_10001

	local var_23_0 = var_1_10001.New
	local var_23_1 = arg_23_0._tf

	return var_23_0(var_3.Find(var_23_1, "frame/top/icon"), arg_23_0.event)
end

function var_0_1.GetChatRoomView(arg_24_0)
	MainChatRoomView4Mellow = var_1_10001

	local var_24_0 = var_1_10001.New
	local var_24_1 = arg_24_0._tf

	return var_24_0(var_3.Find(var_24_1, "frame/right/chat_room"), arg_24_0.event)
end

function var_0_1.GetBannerView(arg_25_0)
	MainBannerView4Mellow = var_1_10001

	local var_25_0 = var_1_10001.New
	local var_25_1 = arg_25_0._tf

	return var_25_0(var_3.Find(var_25_1, "frame/left/banner"), arg_25_0.event)
end

function var_0_1.GetActBtnView(arg_26_0)
	MainActivityBtnView4Mellow = var_1_10001

	local var_26_0 = var_1_10001.New
	local var_26_1 = arg_26_0._tf

	return var_26_0(var_3.Find(var_26_1, "frame"), arg_26_0.event)
end

function var_0_1.GetBuffView(arg_27_0)
	MainBuffView4Mellow = var_1_10001

	local var_27_0 = var_1_10001.New
	local var_27_1 = arg_27_0._tf

	return var_27_0(var_3.Find(var_27_1, "frame/top/buff_list"), arg_27_0.event)
end

function var_0_1.GetChangeSkinView(arg_28_0)
	MainChangeSkinView = var_1_10001

	local var_28_0 = var_1_10001.New
	local var_28_1 = arg_28_0._tf

	return var_28_0(var_3.Find(var_28_1, "frame/right/change_skin"), arg_28_0.event)
end

function var_0_1.GetAsmrChatView(arg_29_0)
	MainAsmrChatView = var_1_10001

	local var_29_0 = var_1_10001.New
	local var_29_1 = arg_29_0._tf

	return var_29_0(var_3.Find(var_29_1, "frame/bottom/asmr_chat"), arg_29_0.event)
end

function var_0_1.OnAsmrTurnning(arg_30_0, arg_30_1)
	var_0_1.super.OnAsmrTurnning(arg_30_0, arg_30_1)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_30_0._tf, "s"), not arg_30_1)

	return
end

function var_0_1.RegisterRedDots(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.EasyRedDotMgr.GetInstance()
	local var_31_1 = {}

	local function var_31_2(arg_32_0, arg_32_1, arg_32_2)
		local var_32_0 = var_31_0

		var_3.RegisterRedDot(var_32_0, arg_32_0, arg_32_1, arg_32_2)

		table = var_3

		var_3.insert(var_31_1, arg_32_0)

		return
	end

	local var_31_3 = arg_31_0._tf

	var_31_2(var_6.Find(var_31_3, "frame/bottom/frame/task/tip"), {
		"TASK"
	}, function(arg_33_0)
		setActive = var_2_10001

		local var_33_0 = arg_33_0

		getProxy = var_2_10004
		TaskProxy = var_2_10006

		local var_33_1 = var_2_10004(var_2_10006)
		local var_33_3

		if not (var_4.getCanReceiveCount(var_33_1) > 0) then
			getProxy = var_4
			AvatarFrameProxy = var_33_1

			local var_33_2 = var_4(var_33_1)

			if not (var_4.getCanReceiveCount(var_33_2) > 0) then
				var_33_3 = false

				goto label_33_0
			end
		end

		var_33_3 = true

		::label_33_0::

		var_2_10001(var_33_0, var_33_3)

		return
	end)

	local var_31_4 = arg_31_0._tf
	local var_31_5 = var_4.Find(var_31_4, "frame/top/btns/mail")

	findTF = var_1_10005

	local var_31_6 = var_1_10005(var_31_5, "tip")

	findTF = var_31_4

	local var_31_7 = var_31_4(var_31_5, "Text")
	local var_31_8 = var_6.GetComponent

	typeof = var_9
	Text = var_1_10011

	local var_31_9 = var_31_8(var_31_7, var_9(var_1_10011))

	getProxy = var_7
	MailProxy = var_9

	local var_31_10 = var_7(var_9).total

	MAIL_COUNT_LIMIT = var_9

	if var_9 <= var_31_10 then
		pg = var_31_10

		local var_31_11 = var_31_10.TipsMgr.GetInstance()
		local var_31_12 = var_8.ShowTips

		i18n = var_1_10011

		var_31_12(var_31_11, var_1_10011("warning_mail_max_2"))
	else
		local var_31_13 = var_7.total

		MAIL_COUNT_LIMIT = var_9

		if var_31_13 > var_9 * 0.9 then
			pg = var_31_13

			local var_31_14 = var_31_13.TipsMgr.GetInstance()
			local var_31_15 = var_8.ShowTips

			i18n = var_1_10011

			local var_31_16 = "warning_mail_max_1"

			var_1_10014 = var_7.total
			MAIL_COUNT_LIMIT = var_1_10015

			var_31_15(var_31_14, var_1_10011(var_31_16, var_1_10014, var_1_10015))
		end
	end

	var_3(var_31_5, {
		"MAIL"
	}, function(arg_34_0)
		getProxy = var_2_10001
		MailProxy = var_2_10003

		local var_34_0 = var_2_10001(var_2_10003)
		local var_34_1 = var_1.GetUnreadCount(var_34_0)
		local var_34_2 = 99
		local var_34_3

		if 0 < var_34_1 then
			SetActive = var_34_3

			var_34_3(var_31_6, true)

			var_34_3 = var_31_9

			if not (var_34_2 < var_34_1) or not (var_34_2 .. "+") then
				tostring = var_2_10004
				var_2_10004 = var_2_10004(var_34_1)
			end

			var_34_3.text = var_2_10004
		else
			SetActive = var_34_3

			var_34_3(var_31_6, false)

			var_31_9.text = ""
		end

		return
	end)

	local var_31_17 = var_3
	local var_31_18 = arg_31_0._tf

	var_31_17(var_10.Find(var_31_18, "frame/bottom/frame/build/tip"), {
		"BUILD"
	}, function(arg_35_0)
		setActive = var_2_10001

		local var_35_0 = arg_35_0

		getProxy = var_2_10004
		BuildShipProxy = var_2_10006

		local var_35_1 = var_2_10004(var_2_10006)
		local var_35_3

		if not (var_4.getFinishCount(var_35_1) > 0) then
			tobool = var_4
			getProxy = var_35_1
			ActivityProxy = var_2_10008

			local var_35_2 = var_35_1(var_2_10008)

			var_35_3 = var_4(var_6.IsShowFreeBuildMark(var_35_2, true))

			if false then
				var_35_3 = false
			end
		else
			var_35_3 = true
		end

		var_2_10001(var_35_0, var_35_3)

		return
	end)

	local var_31_19 = var_3
	local var_31_20 = arg_31_0._tf

	var_31_19(var_10.Find(var_31_20, "frame/bottom/frame/guild/tip"), {
		"GUILD"
	}, function(arg_36_0)
		setActive = var_2_10001

		local var_36_0 = arg_36_0

		getProxy = var_2_10004
		GuildProxy = var_2_10006

		local var_36_1 = var_2_10004(var_2_10006)

		var_2_10001(var_36_0, var_4.ShouldShowTip(var_36_1))

		return
	end)

	local var_31_21 = var_3
	local var_31_22 = arg_31_0._tf

	var_31_21(var_10.Find(var_31_22, "frame/top/icon_front/tip"), {
		"ATTIRE"
	}, function(arg_37_0)
		setActive = var_2_10001

		local var_37_0 = arg_37_0

		getProxy = var_2_10004
		AttireProxy = var_2_10006

		local var_37_1 = var_2_10004(var_2_10006)
		local var_37_4

		if not var_4.IsShowRedDot(var_37_1) then
			getProxy = var_37_4
			SettingsProxy = var_37_1

			local var_37_2 = var_37_4(var_37_1)

			if not var_37_4.ShouldEducateCharTip(var_37_2) then
				getProxy = var_37_4
				ActivityProxy = var_37_2

				local var_37_3 = var_37_4(var_37_2)

				var_37_4 = var_37_4.IsTipLoveLetterMail(var_37_3)
			end
		end

		var_2_10001(var_37_0, var_37_4)

		return
	end)

	local var_31_23 = var_3
	local var_31_24 = arg_31_0._tf

	var_31_23(var_10.Find(var_31_24, "frame/right/2/menor/root/tip"), {
		"MEMORY_REVIEW"
	}, function(arg_38_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_38_0 = var_2_10001(var_2_10003)

		if var_1.getRawData(var_38_0) then
			::label_38_0::

			_ = var_2_10002
			var_2_10002 = var_2_10002.any
			pg = var_2_10004
			var_2_10002 = var_2_10002(var_2_10004.memory_group.all, function(arg_39_0)
				PlayerPrefs = var_3_10001

				return var_3_10001.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_0.id .. " " .. arg_39_0, 0) == 1
			end)
		end

		if not var_2_10002 then
			getProxy = var_38_0
			LoveLetterProxy = var_2_10005

			local var_38_1 = var_38_0(var_2_10005)

			if var_38_0.getRawData(var_38_1) then
				getProxy = var_38_0
				LoveLetterProxy = var_38_1

				local var_38_2 = var_38_0(var_38_1)

				if var_38_0.IsTipUnlockLetter(var_38_2) then
					var_2_10002 = true
				end
			end
		end

		setActive = var_38_0

		local var_38_3 = arg_38_0

		tobool = var_2_10006

		var_38_0(var_38_3, var_2_10006(var_2_10002))

		return
	end)

	local var_31_25 = var_3
	local var_31_26 = arg_31_0._tf

	var_31_25(var_10.Find(var_31_26, "frame/right/2/collection/root/tip"), {
		"COLLECTION"
	}, function(arg_40_0)
		setActive = var_2_10001

		local var_40_0 = arg_40_0

		getProxy = var_2_10004
		CollectionProxy = var_2_10006

		local var_40_1 = var_2_10004(var_2_10006)
		local var_40_5

		if not var_4.hasFinish(var_40_1) then
			getProxy = var_40_5
			AppreciateProxy = var_40_1

			local var_40_2 = var_40_5(var_40_1)

			if not var_40_5.isGalleryHaveNewRes(var_40_2) then
				getProxy = var_40_5
				AppreciateProxy = var_40_2

				local var_40_3 = var_40_5(var_40_2)

				if not var_40_5.isMusicHaveNewRes(var_40_3) then
					getProxy = var_40_5
					AppreciateProxy = var_40_3

					local var_40_4 = var_40_5(var_40_3)

					var_40_5 = var_40_5.isMangaHaveNewRes(var_40_4)
				end
			end
		end

		var_2_10001(var_40_0, var_40_5)

		return
	end)

	local var_31_27 = var_3
	local var_31_28 = arg_31_0._tf

	var_31_27(var_10.Find(var_31_28, "frame/right/2/friend/root/tip"), {
		"FRIEND"
	}, function(arg_41_0)
		setActive = var_2_10001

		local var_41_0 = arg_41_0

		getProxy = var_2_10004
		NotificationProxy = var_2_10006

		local var_41_1 = var_2_10004(var_2_10006)
		local var_41_3

		if not (var_4.getRequestCount(var_41_1) > 0) then
			getProxy = var_4
			FriendProxy = var_41_1

			local var_41_2 = var_4(var_41_1)

			if not (var_4.getNewMsgCount(var_41_2) > 0) then
				var_41_3 = false

				goto label_41_0
			end
		end

		var_41_3 = true

		::label_41_0::

		var_2_10001(var_41_0, var_41_3)

		return
	end)

	local var_31_29 = var_3
	local var_31_30 = arg_31_0._tf

	var_31_29(var_10.Find(var_31_30, "frame/left/extend/tip"), {
		"COMMISSION"
	}, function(arg_42_0)
		setActive = var_2_10001

		local var_42_0 = arg_42_0

		getProxy = var_2_10004
		PlayerProxy = var_2_10006

		local var_42_1 = var_2_10004(var_2_10006)

		var_2_10001(var_42_0, var_4.IsShowCommssionTip(var_42_1))

		return
	end)

	local var_31_31 = var_3
	local var_31_32 = arg_31_0._tf

	var_31_31(var_10.Find(var_31_32, "frame/top/btns/settings/tip"), {
		"SETTING"
	}, function(arg_43_0)
		setActive = var_2_10001

		local var_43_0 = arg_43_0

		PlayerPrefs = var_2_10004

		var_2_10001(var_43_0, var_2_10004.GetInt("firstIntoOtherPanel", 0) == 0)

		return
	end)

	local var_31_33 = var_3
	local var_31_34 = arg_31_0._tf

	var_31_33(var_10.Find(var_31_34, "frame/top/btns/noti/tip"), {
		"SERVER"
	}, function(arg_44_0)
		getProxy = var_2_10001
		ServerNoticeProxy = var_2_10003

		local var_44_0 = var_2_10001(var_2_10003)
		local var_44_1 = var_1.getServerNotices(var_44_0, false)

		setActive = var_2_10002

		local var_44_2 = arg_44_0
		local var_44_4

		if #var_44_1 > 0 then
			getProxy = var_5
			ServerNoticeProxy = var_2_10007

			local var_44_3 = var_5(var_2_10007)

			var_44_4 = var_5.hasNewNotice(var_44_3)
		else
			var_44_4 = false
		end

		if false then
			var_44_4 = true
		end

		var_2_10002(var_44_2, var_44_4)

		return
	end)

	local var_31_35 = var_3
	local var_31_36 = arg_31_0._tf

	var_31_35(var_10.Find(var_31_36, "frame/bottom/frame/tech/tip"), {
		"BLUEPRINT"
	}, function(arg_45_0)
		setActive = var_2_10001

		local var_45_0 = arg_45_0

		getProxy = var_2_10004
		TechnologyProxy = var_2_10006

		local var_45_1 = var_2_10004(var_2_10006)

		var_2_10001(var_45_0, var_4.IsShowTip(var_45_1))

		return
	end)

	local var_31_37 = var_3
	local var_31_38 = arg_31_0._tf

	var_31_37(var_10.Find(var_31_38, "frame/right/1/battle/root/tip"), {
		"EVENT"
	}, function(arg_46_0)
		setActive = var_2_10001

		local var_46_0 = arg_46_0

		getProxy = var_2_10004
		EventProxy = var_2_10006

		local var_46_1 = var_2_10004(var_2_10006)
		local var_46_2

		if not var_4.hasFinishState(var_46_1) then
			LimitChallengeConst = var_46_2
			var_46_2 = var_46_2.IsShowRedPoint()
		end

		var_2_10001(var_46_0, var_46_2)

		return
	end)

	local var_31_39 = var_3
	local var_31_40 = arg_31_0._tf

	var_31_39(var_10.Find(var_31_40, "frame/bottom/frame/live/tip"), {
		"COURTYARD",
		"SCHOOL",
		"COMMANDER",
		"DORM3D_SHOP_TIMELIMIT",
		"EDUCATE_NEW_CHILD",
		"ISLAND_3D"
	}, function(arg_47_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_47_0 = var_2_10001(var_2_10003)
		local var_47_1 = var_1.getRawData(var_47_0)
		local var_47_2 = false
		local var_47_3 = var_47_1.level

		if 40 <= var_47_3 then
			getProxy = var_47_3
			CommanderProxy = var_2_10005

			local var_47_4 = var_47_3(var_2_10005)

			var_47_3 = var_47_3.IsFinishAllBox(var_47_4)
			LOCK_CATTERY = var_4

			if not var_4 then
				if not var_47_3 then
					::label_47_0::

					getProxy = var_4
					CommanderProxy = var_2_10006

					local var_47_5 = var_4(var_2_10006)

					if not var_4.AnyCatteryExistOP(var_47_5) then
						::label_47_1::

						getProxy = var_4
						CommanderProxy = var_47_5

						local var_47_6 = var_4(var_47_5)

						var_47_2 = var_4.AnyCatteryCanUse(var_47_6)
					end
				end
			else
				var_47_2 = var_47_3
			end
		end

		pg = var_47_3

		local var_47_7 = var_47_3.SystemOpenMgr.GetInstance()
		local var_47_8 = var_3.isOpenSystem(var_47_7, var_47_1.level, "SelectDorm3DMediator")

		setActive = var_4

		local var_47_9 = arg_47_0

		getProxy = var_7
		DormProxy = var_2_10009

		local var_47_10 = var_7(var_2_10009)

		if not var_7.IsShowRedDot(var_47_10) then
			getProxy = var_47_13
			NavalAcademyProxy = var_47_10

			local var_47_11 = var_47_13(var_47_10)

			if not var_47_13.IsShowTip(var_47_11) and not var_47_2 then
				::label_47_2::

				if var_47_8 then
					Dorm3dShopUI = var_47_13

					local var_47_13

					if not var_47_13.ShouldShowAllTip() then
						NewEducateHelper = var_47_13

						if not var_47_13.IsShowNewChildTip() then
							getProxy = var_47_13
							SystemTipProxy = var_47_11

							local var_47_12 = var_47_13(var_47_11)

							var_47_13 = var_47_13.IsIslandRedDotTip(var_47_12)
						end
					end

					var_4(var_47_9, var_47_13)

					return
				end
			end
		end
	end)

	local var_31_41 = arg_31_0._tf
	local var_31_42 = var_8.Find(var_31_41, "frame/right/switch")
	local var_31_43 = var_8.GetComponent

	typeof = var_12
	Toggle = var_1_10014

	local var_31_44 = var_31_43(var_31_42, var_12(var_1_10014))
	local var_31_45 = var_8:Find("on")

	var_3(var_31_45, {
		"COLLECTION",
		"FRIEND",
		"MEMORY_REVIEW"
	}, function(arg_48_0)
		getProxy = var_2_10001
		CollectionProxy = var_2_10003

		local var_48_0 = var_2_10001(var_2_10003)
		local var_48_5

		if not var_1.hasFinish(var_48_0) then
			getProxy = var_48_5
			AppreciateProxy = var_48_0

			local var_48_1 = var_48_5(var_48_0)

			if not var_48_5.isGalleryHaveNewRes(var_48_1) then
				getProxy = var_48_5
				AppreciateProxy = var_48_1

				local var_48_2 = var_48_5(var_48_1)

				if not var_48_5.isMusicHaveNewRes(var_48_2) then
					getProxy = var_48_5
					AppreciateProxy = var_48_2

					local var_48_3 = var_48_5(var_48_2)

					if not var_48_5.isMangaHaveNewRes(var_48_3) then
						getProxy = var_48_5
						NotificationProxy = var_48_3

						local var_48_4 = var_48_5(var_48_3)

						var_48_5 = var_48_5.getRequestCount(var_48_4)

						if not (0 < var_48_5) then
							getProxy = var_48_5
							FriendProxy = var_48_4

							local var_48_6 = var_48_5(var_48_4)

							var_48_5 = var_48_5.getNewMsgCount(var_48_6)

							if not (0 < var_48_5) then
								var_48_5 = (function()
									getProxy = var_3_10000
									PlayerProxy = var_3_10002

									local var_49_0 = var_3_10000(var_3_10002)

									if var_0.getRawData(var_49_0) then
										_ = var_3_10001
										var_3_10001 = var_3_10001.any
										pg = var_3_10003

										if var_3_10001(var_3_10003.memory_group.all, function(arg_50_0)
											PlayerPrefs = var_4_10001

											return var_4_10001.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_0.id .. " " .. arg_50_0, 0) == 1
										end) then
											return true
										end
									end

									tobool = var_3_10001
									getProxy = var_3_10003
									LoveLetterProxy = var_3_10005

									local var_49_1 = var_3_10003(var_3_10005)
									local var_49_3

									if var_3.getRawData(var_49_1) then
										getProxy = var_49_3
										LoveLetterProxy = var_49_1

										local var_49_2 = var_49_3(var_49_1)

										var_49_3 = var_49_3.IsTipUnlockLetter(var_49_2)
									end

									return var_3_10001(var_49_3)
								end)()

								if false then
									var_48_5 = false
								end

								goto label_48_0
							end
						end

						var_48_5 = true
					end
				end
			end
		end

		::label_48_0::

		setActive = var_2_10002

		var_2_10002(arg_48_0, var_48_5 and not var_31_44.isOn)

		return
	end)

	local var_31_46 = var_8:Find("off")

	var_3(var_31_46, {
		"EVENT"
	}, function(arg_51_0)
		setActive = var_2_10001

		local var_51_0 = arg_51_0

		getProxy = var_2_10004
		EventProxy = var_2_10006

		local var_51_1 = var_2_10004(var_2_10006)

		if not var_4.hasFinishState(var_51_1) then
			LimitChallengeConst = var_4

			local var_51_2

			if var_4.IsShowRedPoint() then
				var_51_2 = var_31_44.isOn
			end

			var_2_10001(var_51_0, var_51_2)

			return
		end
	end)

	return var_31_1
end

return var_0_1
