class = var_0_10000

local var_0_0 = "NewMainClassicTheme"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewMainSceneBaseTheme"))

function var_0_1.getUIName(arg_1_0)
	return "NewMainClassicTheme"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	MainAdpterView = var_1

	local var_2_0 = var_1.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "top_bg")
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_4.Find(var_2_3, "bottom_bg")
	local var_2_5 = arg_2_0._tf

	arg_2_0.adapterView = var_2_0(var_2_2, var_2_4, var_5.Find(var_2_5, "bg/right"))

	local var_2_6 = arg_2_0.changeView
	local var_2_7 = var_1.SetAsmrTurnningParent
	local var_2_8 = arg_2_0._tf

	var_2_7(var_2_6, var_4.Find(var_2_8, "frame/right/asmrToggleContainer"))

	return
end

function var_0_1.PlayEnterAnimation(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.adapterView

	var_3.Init(var_3_0)
	var_0_1.super.PlayEnterAnimation(arg_3_0, arg_3_1, arg_3_2)

	return
end

function var_0_1._FoldPanels(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super._FoldPanels(arg_4_0, arg_4_1, arg_4_2)

	local var_4_0 = arg_4_0.adapterView

	var_3.Fold(var_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_1.OnDestroy(arg_5_0)
	var_0_1.super.OnDestroy(arg_5_0)

	if arg_5_0.adapterView then
		local var_5_0 = arg_5_0.adapterView

		var_1.Dispose(var_5_0)

		arg_5_0.adapterView = nil
	end

	return
end

function var_0_1.SetEffectPanelVisible(arg_6_0, arg_6_1)
	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.panels) do
		isa = var_1_10007

		local var_6_0 = iter_6_1

		MainRightPanel = var_1_10010

		if var_1_10007(var_6_0, var_1_10010) then
			iter_6_1:SetEffectVisible(arg_6_1)
		end
	end

	return
end

function var_0_1.GetCalibrationBG(arg_7_0)
	return "mainui_calibration"
end

function var_0_1.GetPbList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = arg_8_0._tf

	var_8_0[1] = var_2.Find(var_8_1, "frame/chatPreview")

	local var_8_2 = arg_8_0._tf

	var_8_0[2] = var_2.Find(var_8_2, "frame/eventPanel")

	return var_8_0
end

function var_0_1.GetPaintingOffset(arg_9_0, arg_9_1)
	MainPaintingShift = var_1_10002

	return var_1_10002.New({
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

function var_0_1.GetWordView(arg_10_0)
	MainWordView = var_1_10001

	local var_10_0 = var_1_10001.New
	local var_10_1 = arg_10_0._tf

	return var_10_0(var_3.Find(var_10_1, "chat"), arg_10_0.event)
end

function var_0_1.GetTagView(arg_11_0)
	MainTagsView = var_1_10001

	local var_11_0 = var_1_10001.New
	local var_11_1 = arg_11_0._tf

	return var_11_0(var_3.Find(var_11_1, "frame/bottom/tags"), arg_11_0.event)
end

function var_0_1.GetTopPanel(arg_12_0)
	MainTopPanel = var_1_10001

	local var_12_0 = var_1_10001.New
	local var_12_1 = arg_12_0._tf

	return var_12_0(var_3.Find(var_12_1, "frame/top"), arg_12_0.event, arg_12_0.contextData)
end

function var_0_1.GetRightPanel(arg_13_0)
	MainRightPanel = var_1_10001

	local var_13_0 = var_1_10001.New
	local var_13_1 = arg_13_0._tf

	return var_13_0(var_3.Find(var_13_1, "frame/right"), arg_13_0.event, arg_13_0.contextData)
end

function var_0_1.GetLeftPanel(arg_14_0)
	MainLeftPanel = var_1_10001

	local var_14_0 = var_1_10001.New
	local var_14_1 = arg_14_0._tf

	return var_14_0(var_3.Find(var_14_1, "frame/left"), arg_14_0.event, arg_14_0.contextData)
end

function var_0_1.GetBottomPanel(arg_15_0)
	MainBottomPanel = var_1_10001

	local var_15_0 = var_1_10001.New
	local var_15_1 = arg_15_0._tf

	return var_15_0(var_3.Find(var_15_1, "frame/bottom"), arg_15_0.event, arg_15_0.contextData)
end

function var_0_1.GetIconView(arg_16_0)
	MainIconView = var_1_10001

	local var_16_0 = var_1_10001.New
	local var_16_1 = arg_16_0._tf

	return var_16_0(var_3.Find(var_16_1, "frame/char"))
end

function var_0_1.GetChatRoomView(arg_17_0)
	MainChatRoomView = var_1_10001

	local var_17_0 = var_1_10001.New
	local var_17_1 = arg_17_0._tf

	return var_17_0(var_3.Find(var_17_1, "frame/chatPreview"), arg_17_0.event)
end

function var_0_1.GetBannerView(arg_18_0)
	MainBannerView = var_1_10001

	local var_18_0 = var_1_10001.New
	local var_18_1 = arg_18_0._tf

	return var_18_0(var_3.Find(var_18_1, "frame/eventPanel"), arg_18_0.event)
end

function var_0_1.GetActBtnView(arg_19_0)
	MainActivityBtnView = var_1_10001

	local var_19_0 = var_1_10001.New
	local var_19_1 = arg_19_0._tf

	return var_19_0(var_3.Find(var_19_1, "frame/linkBtns"), arg_19_0.event)
end

function var_0_1.GetBuffView(arg_20_0)
	MainBuffView = var_1_10001

	local var_20_0 = var_1_10001.New
	local var_20_1 = arg_20_0._tf

	return var_20_0(var_3.Find(var_20_1, "frame/buffs"), arg_20_0.event)
end

function var_0_1.GetCalibrationView(arg_21_0)
	MainCalibrationPage = var_1_10001

	return var_1_10001.New(arg_21_0._tf, arg_21_0.event)
end

function var_0_1.GetChangeSkinView(arg_22_0)
	MainChangeSkinView = var_1_10001

	local var_22_0 = var_1_10001.New
	local var_22_1 = arg_22_0._tf

	return var_22_0(var_3.Find(var_22_1, "frame/bottom/change_skin"), arg_22_0.event)
end

function var_0_1.GetAsmrChatView(arg_23_0)
	MainAsmrChatView = var_1_10001

	local var_23_0 = var_1_10001.New
	local var_23_1 = arg_23_0._tf

	return var_23_0(var_3.Find(var_23_1, "frame/bottom/asmr_chat"), arg_23_0.event)
end

function var_0_1.RegisterRedDots(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.EasyRedDotMgr.GetInstance()
	local var_24_1 = {}

	local function var_24_2(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0 = var_24_0

		var_3.RegisterRedDot(var_25_0, arg_25_0, arg_25_1, arg_25_2)

		table = var_3

		var_3.insert(var_24_1, arg_25_0)

		return
	end

	local var_24_3 = arg_24_0._tf

	var_24_2(var_6.Find(var_24_3, "frame/bottom/taskButton/tip"), {
		"TASK"
	}, function(arg_26_0)
		setActive = var_2_10001

		local var_26_0 = arg_26_0

		getProxy = var_2_10004
		TaskProxy = var_2_10006

		local var_26_1 = var_2_10004(var_2_10006)
		local var_26_3

		if not (var_4.getCanReceiveCount(var_26_1) > 0) then
			getProxy = var_4
			AvatarFrameProxy = var_26_1

			local var_26_2 = var_4(var_26_1)

			if not (var_4.getCanReceiveCount(var_26_2) > 0) then
				var_26_3 = false

				goto label_26_0
			end
		end

		var_26_3 = true

		::label_26_0::

		var_2_10001(var_26_0, var_26_3)

		return
	end)

	local var_24_4 = arg_24_0._tf
	local var_24_5 = var_4.Find(var_24_4, "frame/right/mailButton")

	findTF = var_1_10005

	local var_24_6 = var_1_10005(var_24_5, "unread")

	findTF = var_24_4

	local var_24_7 = var_24_4(var_24_5, "read")

	findTF = var_7

	local var_24_8 = var_7(var_24_5, "attachmentLabel")

	findTF = var_8

	local var_24_9 = var_8(var_24_8, "attachmentCountText")
	local var_24_10 = var_8.GetComponent

	typeof = var_11
	Text = var_1_10013

	local var_24_11 = var_24_10(var_24_9, var_11(var_1_10013))

	getProxy = var_9
	MailProxy = var_11

	local var_24_12 = var_9(var_11).total

	math = var_11

	local var_24_13 = var_11.clamp
	local var_24_14 = var_9.total

	MAIL_COUNT_LIMIT = var_1_10014

	local var_24_15 = var_1_10014 * 0.9

	MAIL_COUNT_LIMIT = var_1_10015

	if var_24_12 == var_24_13(var_24_14, var_24_15, var_1_10015) then
		pg = var_24_12

		local var_24_16 = var_24_12.TipsMgr.GetInstance()
		local var_24_17 = var_10.ShowTips

		i18n = var_24_14

		local var_24_18 = "warning_mail_max_1"
		local var_24_19 = var_9.total

		MAIL_COUNT_LIMIT = var_1_10017

		var_24_17(var_24_16, var_24_14(var_24_18, var_24_19, var_1_10017))
	end

	var_3(var_24_5, {
		"MAIL"
	}, function(arg_27_0)
		getProxy = var_2_10001
		MailProxy = var_2_10003

		local var_27_0 = var_2_10001(var_2_10003)
		local var_27_1 = var_1.GetUnreadCount(var_27_0)
		local var_27_2 = 99
		local var_27_4

		if 0 < var_27_1 then
			SetActive = var_27_4

			var_27_4(var_24_8, true)

			SetActive = var_27_4

			var_27_4(var_24_7, false)

			SetActive = var_27_4

			var_27_4(var_24_6, true)

			local var_27_3 = arg_27_0

			var_27_4 = arg_27_0.GetComponent
			typeof = var_6
			Button = var_2_10008
			var_27_4 = var_27_4(var_27_3, var_6(var_2_10008))

			local var_27_5 = var_24_6
			local var_27_6 = var_4.GetComponent

			typeof = var_2_10007
			Image = var_2_10009
			var_27_4.targetGraphic = var_27_6(var_27_5, var_2_10007(var_2_10009))
			var_27_4 = var_24_11

			local var_27_7

			if not (var_27_2 < var_27_1) or not (var_27_2 .. "+") then
				tostring = var_27_7
				var_27_7 = var_27_7(var_27_1)
			end

			var_27_4.text = var_27_7
		else
			SetActive = var_27_4

			var_27_4(var_24_7, true)

			SetActive = var_27_4

			var_27_4(var_24_6, false)

			SetActive = var_27_4

			var_27_4(var_24_8, false)

			local var_27_8 = arg_27_0
			local var_27_9 = arg_27_0.GetComponent

			typeof = var_6
			Button = var_2_10008

			local var_27_10 = var_27_9(var_27_8, var_6(var_2_10008))
			local var_27_11 = var_24_7
			local var_27_12 = var_4.GetComponent

			typeof = var_2_10007
			Image = var_2_10009
			var_27_10.targetGraphic = var_27_12(var_27_11, var_2_10007(var_2_10009))
		end

		return
	end)

	local var_24_20 = var_3
	local var_24_21 = arg_24_0._tf

	var_24_20(var_12.Find(var_24_21, "frame/bottom/buildButton/tip"), {
		"BUILD"
	}, function(arg_28_0)
		setActive = var_2_10001

		local var_28_0 = arg_28_0

		getProxy = var_2_10004
		BuildShipProxy = var_2_10006

		local var_28_1 = var_2_10004(var_2_10006)
		local var_28_3

		if not (var_4.getFinishCount(var_28_1) > 0) then
			tobool = var_4
			getProxy = var_28_1
			ActivityProxy = var_2_10008

			local var_28_2 = var_28_1(var_2_10008)

			var_28_3 = var_4(var_6.IsShowFreeBuildMark(var_28_2, true))

			if false then
				var_28_3 = false
			end
		else
			var_28_3 = true
		end

		var_2_10001(var_28_0, var_28_3)

		return
	end)

	local var_24_22 = var_3
	local var_24_23 = arg_24_0._tf

	var_24_22(var_12.Find(var_24_23, "frame/bottom/guildButton/tip"), {
		"GUILD"
	}, function(arg_29_0)
		setActive = var_2_10001

		local var_29_0 = arg_29_0

		getProxy = var_2_10004
		GuildProxy = var_2_10006

		local var_29_1 = var_2_10004(var_2_10006)

		var_2_10001(var_29_0, var_4.ShouldShowTip(var_29_1))

		return
	end)

	local var_24_24 = var_3
	local var_24_25 = arg_24_0._tf

	var_24_24(var_12.Find(var_24_25, "frame/top/tip"), {
		"ATTIRE"
	}, function(arg_30_0)
		setActive = var_2_10001

		local var_30_0 = arg_30_0

		getProxy = var_2_10004
		AttireProxy = var_2_10006

		local var_30_1 = var_2_10004(var_2_10006)
		local var_30_4

		if not var_4.IsShowRedDot(var_30_1) then
			getProxy = var_30_4
			SettingsProxy = var_30_1

			local var_30_2 = var_30_4(var_30_1)

			if not var_30_4.ShouldEducateCharTip(var_30_2) then
				getProxy = var_30_4
				ActivityProxy = var_30_2

				local var_30_3 = var_30_4(var_30_2)

				var_30_4 = var_30_4.IsTipLoveLetterMail(var_30_3)
			end
		end

		var_2_10001(var_30_0, var_30_4)

		return
	end)

	local var_24_26 = var_3
	local var_24_27 = arg_24_0._tf

	var_24_26(var_12.Find(var_24_27, "frame/right/memoryButton/tip"), {
		"MEMORY_REVIEW"
	}, function(arg_31_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_31_0 = var_2_10001(var_2_10003)

		if var_1.getRawData(var_31_0) then
			::label_31_0::

			_ = var_2_10002
			var_2_10002 = var_2_10002.any
			pg = var_2_10004
			var_2_10002 = var_2_10002(var_2_10004.memory_group.all, function(arg_32_0)
				PlayerPrefs = var_3_10001

				return var_3_10001.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_0.id .. " " .. arg_32_0, 0) == 1
			end)
		end

		if not var_2_10002 then
			getProxy = var_31_0
			LoveLetterProxy = var_2_10005

			local var_31_1 = var_31_0(var_2_10005)

			if var_31_0.getRawData(var_31_1) then
				getProxy = var_31_0
				LoveLetterProxy = var_31_1

				local var_31_2 = var_31_0(var_31_1)

				if var_31_0.IsTipUnlockLetter(var_31_2) then
					var_2_10002 = true
				end
			end
		end

		setActive = var_31_0

		local var_31_3 = arg_31_0

		tobool = var_2_10006

		var_31_0(var_31_3, var_2_10006(var_2_10002))

		return
	end)

	local var_24_28 = var_3
	local var_24_29 = arg_24_0._tf

	var_24_28(var_12.Find(var_24_29, "frame/right/collectionButton/tip"), {
		"COLLECTION"
	}, function(arg_33_0)
		setActive = var_2_10001

		local var_33_0 = arg_33_0

		getProxy = var_2_10004
		CollectionProxy = var_2_10006

		local var_33_1 = var_2_10004(var_2_10006)
		local var_33_5

		if not var_4.hasFinish(var_33_1) then
			getProxy = var_33_5
			AppreciateProxy = var_33_1

			local var_33_2 = var_33_5(var_33_1)

			if not var_33_5.isGalleryHaveNewRes(var_33_2) then
				getProxy = var_33_5
				AppreciateProxy = var_33_2

				local var_33_3 = var_33_5(var_33_2)

				if not var_33_5.isMusicHaveNewRes(var_33_3) then
					getProxy = var_33_5
					AppreciateProxy = var_33_3

					local var_33_4 = var_33_5(var_33_3)

					var_33_5 = var_33_5.isMangaHaveNewRes(var_33_4)
				end
			end
		end

		var_2_10001(var_33_0, var_33_5)

		return
	end)

	local var_24_30 = var_3
	local var_24_31 = arg_24_0._tf

	var_24_30(var_12.Find(var_24_31, "frame/right/friendButton/tip"), {
		"FRIEND"
	}, function(arg_34_0)
		setActive = var_2_10001

		local var_34_0 = arg_34_0

		getProxy = var_2_10004
		NotificationProxy = var_2_10006

		local var_34_1 = var_2_10004(var_2_10006)
		local var_34_3

		if not (var_4.getRequestCount(var_34_1) > 0) then
			getProxy = var_4
			FriendProxy = var_34_1

			local var_34_2 = var_4(var_34_1)

			if not (var_4.getNewMsgCount(var_34_2) > 0) then
				var_34_3 = false

				goto label_34_0
			end
		end

		var_34_3 = true

		::label_34_0::

		var_2_10001(var_34_0, var_34_3)

		return
	end)

	local var_24_32 = var_3
	local var_24_33 = arg_24_0._tf

	var_24_32(var_12.Find(var_24_33, "frame/left/commissionButton/tip"), {
		"COMMISSION"
	}, function(arg_35_0)
		setActive = var_2_10001

		local var_35_0 = arg_35_0

		getProxy = var_2_10004
		PlayerProxy = var_2_10006

		local var_35_1 = var_2_10004(var_2_10006)

		var_2_10001(var_35_0, var_4.IsShowCommssionTip(var_35_1))

		return
	end)

	local var_24_34 = var_3
	local var_24_35 = arg_24_0._tf

	var_24_34(var_12.Find(var_24_35, "frame/right/settingButton/tip"), {
		"SETTING"
	}, function(arg_36_0)
		setActive = var_2_10001

		local var_36_0 = arg_36_0

		PlayerPrefs = var_2_10004

		var_2_10001(var_36_0, var_2_10004.GetInt("firstIntoOtherPanel", 0) == 0)

		return
	end)

	local var_24_36 = var_3
	local var_24_37 = arg_24_0._tf

	var_24_36(var_12.Find(var_24_37, "frame/right/noticeButton/tip"), {
		"SERVER"
	}, function(arg_37_0)
		getProxy = var_2_10001
		ServerNoticeProxy = var_2_10003

		local var_37_0 = var_2_10001(var_2_10003)
		local var_37_1 = var_1.getServerNotices(var_37_0, false)

		setActive = var_2_10002

		local var_37_2 = arg_37_0
		local var_37_4

		if #var_37_1 > 0 then
			getProxy = var_5
			ServerNoticeProxy = var_2_10007

			local var_37_3 = var_5(var_2_10007)

			var_37_4 = var_5.hasNewNotice(var_37_3)
		else
			var_37_4 = false
		end

		if false then
			var_37_4 = true
		end

		var_2_10002(var_37_2, var_37_4)

		return
	end)

	local var_24_38 = var_3
	local var_24_39 = arg_24_0._tf

	var_24_38(var_12.Find(var_24_39, "frame/bottom/technologyButton/tip"), {
		"BLUEPRINT"
	}, function(arg_38_0)
		setActive = var_2_10001

		local var_38_0 = arg_38_0

		getProxy = var_2_10004
		TechnologyProxy = var_2_10006

		local var_38_1 = var_2_10004(var_2_10006)

		var_2_10001(var_38_0, var_4.IsShowTip(var_38_1))

		return
	end)

	local var_24_40 = var_3
	local var_24_41 = arg_24_0._tf

	var_24_40(var_12.Find(var_24_41, "frame/right/combatBtn/tip"), {
		"EVENT"
	}, function(arg_39_0)
		setActive = var_2_10001

		local var_39_0 = arg_39_0

		getProxy = var_2_10004
		EventProxy = var_2_10006

		local var_39_1 = var_2_10004(var_2_10006)
		local var_39_2

		if not var_4.hasFinishState(var_39_1) then
			LimitChallengeConst = var_39_2
			var_39_2 = var_39_2.IsShowRedPoint()
		end

		var_2_10001(var_39_0, var_39_2)

		return
	end)

	local var_24_42 = var_3
	local var_24_43 = arg_24_0._tf

	var_24_42(var_12.Find(var_24_43, "frame/bottom/liveButton/tip"), {
		"COURTYARD",
		"SCHOOL",
		"COMMANDER",
		"DORM3D_SHOP_TIMELIMIT",
		"EDUCATE_NEW_CHILD",
		"ISLAND_3D"
	}, function(arg_40_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_40_0 = var_2_10001(var_2_10003)
		local var_40_1 = var_1.getRawData(var_40_0)
		local var_40_2 = false
		local var_40_3 = var_40_1.level

		if 40 <= var_40_3 then
			getProxy = var_40_3
			CommanderProxy = var_2_10005

			local var_40_4 = var_40_3(var_2_10005)

			var_40_3 = var_40_3.IsFinishAllBox(var_40_4)
			LOCK_CATTERY = var_4

			if not var_4 then
				if not var_40_3 then
					::label_40_0::

					getProxy = var_4
					CommanderProxy = var_2_10006

					local var_40_5 = var_4(var_2_10006)

					if not var_4.AnyCatteryExistOP(var_40_5) then
						::label_40_1::

						getProxy = var_4
						CommanderProxy = var_40_5

						local var_40_6 = var_4(var_40_5)

						var_40_2 = var_4.AnyCatteryCanUse(var_40_6)
					end
				end
			else
				var_40_2 = var_40_3
			end
		end

		pg = var_40_3

		local var_40_7 = var_40_3.SystemOpenMgr.GetInstance()
		local var_40_8 = var_3.isOpenSystem(var_40_7, var_40_1.level, "SelectDorm3DMediator")

		setActive = var_4

		local var_40_9 = arg_40_0

		getProxy = var_7
		DormProxy = var_2_10009

		local var_40_10 = var_7(var_2_10009)

		if not var_7.IsShowRedDot(var_40_10) then
			getProxy = var_40_13
			NavalAcademyProxy = var_40_10

			local var_40_11 = var_40_13(var_40_10)

			if not var_40_13.IsShowTip(var_40_11) and not var_40_2 then
				::label_40_2::

				if var_40_8 then
					Dorm3dShopUI = var_40_13

					local var_40_13

					if not var_40_13.ShouldShowAllTip() then
						NewEducateHelper = var_40_13

						if not var_40_13.IsShowNewChildTip() then
							getProxy = var_40_13
							SystemTipProxy = var_40_11

							local var_40_12 = var_40_13(var_40_11)

							var_40_13 = var_40_13.IsIslandRedDotTip(var_40_12)
						end
					end

					var_4(var_40_9, var_40_13)

					return
				end
			end
		end
	end)

	return var_24_1
end

function var_0_1.OnAsmrTurnning(arg_41_0, arg_41_1)
	var_0_1.super.OnAsmrTurnning(arg_41_0, arg_41_1)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_41_0._tf, "top_bg"), not arg_41_1)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_41_0._tf, "bottom_bg"), not arg_41_1)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_41_0._tf, "bg"), not arg_41_1)

	GetOrAddComponent = var_2
	findTF = var_4

	local var_41_0 = var_4(arg_41_0._tf, "frame")

	typeof = var_5
	CanvasGroup = var_7

	local var_41_1 = var_2(var_41_0, var_5(var_7))

	var_41_1.alpha = arg_41_1 ~= true and 1 or 0
	GetOrAddComponent = var_41_1
	findTF = var_41_0

	local var_41_2 = var_41_0(arg_41_0._tf, "frame")

	typeof = var_5
	CanvasGroup = var_7
	var_41_1(var_41_2, var_5(var_7)).interactable = arg_41_1 ~= true and true or false

	return
end

return var_0_1
