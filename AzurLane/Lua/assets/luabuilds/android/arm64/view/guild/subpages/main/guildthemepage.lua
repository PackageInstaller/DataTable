class = var_0_10000

local var_0_0 = "GuildThemePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.GuildBasePage"))

function var_0_1.getTargetUI(arg_1_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	if var_1.IsMellowStyle(var_1_0) then
		return "GuildThemeBlueUI4Mellow", "GuildThemeRedUI4Mellow"
	else
		return "GuildThemeBlueUI", "GuildThemeRedUI"
	end

	return
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0.chatBtn = var_1.Find(var_2_1, "chat_bg")

	local var_2_2 = arg_2_0.chatBtn

	arg_2_0.chatBtnTip = var_1.Find(var_2_2, "tip")

	local var_2_3 = arg_2_0.chatBtn
	local var_2_4 = var_1.Find(var_2_3, "tip/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.chatBtnTipCnt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf

	arg_2_0.chatPanel = var_1.Find(var_2_6, "chat_frame")

	local var_2_7 = arg_2_0.chatPanel

	arg_2_0.chatCloseBtn = var_1.Find(var_2_7, "close")

	local var_2_8 = arg_2_0._tf

	arg_2_0.bottomPanel = var_1.Find(var_2_8, "bottom")

	local var_2_9 = arg_2_0._tf

	arg_2_0.battleEvent = var_1.Find(var_2_9, "bottom/battle_event")

	local var_2_10 = arg_2_0.battleEvent

	arg_2_0.battleEventTip = var_1.Find(var_2_10, "tip")

	local var_2_11 = arg_2_0.battleEventTip
	local var_2_12 = var_1.Find(var_2_11, "Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.battleEventTipCnt = var_2_13(var_2_12, var_4(var_1_10006))

	local var_2_14 = arg_2_0._tf

	arg_2_0.battleReport = var_1.Find(var_2_14, "bottom/battle_report")

	local var_2_15 = arg_2_0.battleReport

	arg_2_0.battleReportTip = var_1.Find(var_2_15, "tip")

	local var_2_16 = arg_2_0.battleReportTip
	local var_2_17 = var_1.Find(var_2_16, "Text")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.battleReportCnt = var_2_18(var_2_17, var_4(var_1_10006))

	local var_2_19 = arg_2_0._tf

	arg_2_0.shopBtn = var_1.Find(var_2_19, "bottom/battle_shop")

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_1.Find(var_2_20, "top/name/Text")
	local var_2_22 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTxt = var_2_22(var_2_21, var_4(var_1_10006))

	local var_2_23 = arg_2_0._tf

	arg_2_0.modifyBtn = var_1.Find(var_2_23, "top/name")

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_1.Find(var_2_24, "top/level/Text")
	local var_2_26 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.levelImg = var_2_26(var_2_25, var_4(var_1_10006))

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_1.Find(var_2_27, "top/policy/label")
	local var_2_29 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.factionTxt = var_2_29(var_2_28, var_4(var_1_10006))

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_1.Find(var_2_30, "top/policy/Text")
	local var_2_32 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.policyTxt = var_2_32(var_2_31, var_4(var_1_10006))

	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_1.Find(var_2_33, "top/id/Text")
	local var_2_35 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.idTxt = var_2_35(var_2_34, var_4(var_1_10006))

	local var_2_36 = arg_2_0._tf
	local var_2_37 = var_1.Find(var_2_36, "top/id/number")
	local var_2_38 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.numberTxt = var_2_38(var_2_37, var_4(var_1_10006))

	local var_2_39 = arg_2_0._tf

	arg_2_0.expImg = var_1.Find(var_2_39, "top/exp/bar")

	local var_2_40 = arg_2_0._tf
	local var_2_41 = var_1.Find(var_2_40, "top/exp/lv/Text")
	local var_2_42 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.levelTxt = var_2_42(var_2_41, var_4(var_1_10006))

	local var_2_43 = 300

	arg_2_0.topPanelWidth = arg_2_0.top.rect.height
	arg_2_0.bottomPanelWidth = -165
	arg_2_0.chatPanelWidth = arg_2_0.chatPanel.rect.width + var_2_43
	arg_2_0.chatBtnWidth = arg_2_0.chatBtn.rect.width + var_2_43
	setAnchoredPosition = var_2

	var_2(arg_2_0.chatPanel, {
		x = arg_2_0.chatPanelWidth
	})

	setAnchoredPosition = var_2

	var_2(arg_2_0.chatBtn, {
		x = 0
	})

	GuildModifitonPage = var_2
	arg_2_0.modifyPage = var_2.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.chatBubbles = {}

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.battleEvent

	local function var_3_2()
		local var_4_0 = arg_3_0.contextData.toggles

		GuildMainScene = var_2_10001

		local var_4_1 = var_4_0[var_2_10001.TOGGLE_TAG[6]]

		triggerToggle = var_1

		var_1(var_4_1, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.battleReport

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		GuildMainMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.OPEN_EVENT_REPORT)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.shopBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		GuildMainMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.OPEN_SHOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.chatBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.InitChatWindow(var_7_0)

		local var_7_1 = arg_3_0

		var_0.ShowOrHideChatWindow(var_7_1, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.chatCloseBtn

	local function var_3_14()
		getProxy = var_2_10000
		GuildProxy = var_2_10002

		local var_8_0 = var_2_10000(var_2_10002)

		var_0.ClearNewChatMsgCnt(var_8_0)

		local var_8_1 = arg_3_0

		var_0.UpdateChatBtn(var_8_1)

		local var_8_2 = arg_3_0

		var_0.ShowOrHideChatWindow(var_8_2, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.modifyBtn

	local function var_3_17()
		local var_9_0 = arg_3_0.modifyPage

		var_0.ExecuteAction(var_9_0, "Show", arg_3_0.guildVO, arg_3_0.playerVO)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10006)

	return
end

function var_0_1.Update(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:UpdateData(arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:UpdateMainInfo()
	arg_10_0:UpdateChatBtn()
	arg_10_0:UpdateBattleBtn()
	arg_10_0:Show()

	return
end

function var_0_1.ResUISettings(arg_11_0)
	local var_11_0 = {}

	PlayerResUI = var_1_10002
	var_11_0.showType = var_1_10002.TYPE_ALL

	return var_11_0
end

function var_0_1.UpdateData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0:UpdateGuild(arg_12_1)

	arg_12_0.playerVO = arg_12_2
	arg_12_0.chatMsgs = arg_12_3
	arg_12_0.isAdmin = arg_12_1:IsAdministrator()

	return
end

function var_0_1.UpdateGuild(arg_13_0, arg_13_1)
	arg_13_0.guildVO = arg_13_1

	return
end

function var_0_1.RefreshReportBtn(arg_14_0)
	arg_14_0:UpdateBattleBtn()

	return
end

function var_0_1.UpdateBattleBtn(arg_15_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1 = var_1.GetReports(var_15_0)

	setActive = var_1_10002

	local var_15_2 = arg_15_0.battleEvent
	local var_15_3 = arg_15_0.guildVO

	var_1_10002(var_15_2, var_5.GetActiveEvent(var_15_3) ~= nil)

	setActive = var_1_10002

	var_1_10002(arg_15_0.battleEventTip, false)

	local var_15_4 = arg_15_0.guildVO
	local var_15_5 = var_2.getMemberById(var_15_4, arg_15_0.playerVO.id)

	_ = var_15_0

	local var_15_6 = var_15_0.select

	_ = var_5

	local var_15_7 = #var_15_6(var_5.values(var_15_1), function(arg_16_0)
		return arg_16_0:CanSubmit()
	end)
	local var_15_8 = 0 < var_15_7 and not var_15_5:IsRecruit()

	setActive = var_5

	var_5(arg_15_0.battleReport, var_15_8)

	setActive = var_5

	var_5(arg_15_0.battleReportTip, var_15_8)

	if var_15_8 then
		arg_15_0.battleReportCnt.text = #var_3
	end

	return
end

function var_0_1.UpdateChatBtn(arg_17_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_17_0 = var_1_10001(var_1_10003)
	local var_17_1 = var_1.GetNewChatMsgCnt(var_17_0) > 0

	setActive = var_17_0

	var_17_0(arg_17_0.chatBtnTip, var_17_1)

	if var_17_1 then
		arg_17_0.chatBtnTipCnt.text = var_1
	end

	return
end

function var_0_1.InitChatWindow(arg_18_0)
	if arg_18_0.isInitChatWindow then
		return
	end

	arg_18_0.isInitChatWindow = true

	local var_18_0 = arg_18_0.chatPanel
	local var_18_1 = var_1.Find(var_18_0, "log/notice/InputField")
	local var_18_2 = var_1.GetComponent

	typeof = var_4
	InputField = var_1_10006
	arg_18_0.noticeTxt = var_18_2(var_18_1, var_4(var_1_10006))

	local var_18_3 = arg_18_0.chatPanel

	arg_18_0.noticeMask = var_1.Find(var_18_3, "log/notice/mask")

	local var_18_4 = arg_18_0.chatPanel
	local var_18_5 = var_1.Find(var_18_4, "log/notice/mask/label")
	local var_18_6 = var_1.GetComponent

	typeof = var_4
	ScrollText = var_1_10006
	arg_18_0.noticeScrollTxt = var_18_6(var_18_5, var_4(var_1_10006))

	local var_18_7 = arg_18_0.chatPanel

	arg_18_0.logContent = var_1.Find(var_18_7, "log/content/viewport/list")
	arg_18_0.prefabPublic = arg_18_0:getTpl("tpl", arg_18_0.logContent)

	local var_18_8 = arg_18_0.chatPanel

	arg_18_0.chatRect = var_1.Find(var_18_8, "bottom/list")

	local var_18_9 = arg_18_0.chatPanel

	arg_18_0.chatContent = var_1.Find(var_18_9, "bottom/list/content")

	local var_18_10 = arg_18_0.chatPanel

	arg_18_0.prefabOthers = var_1.Find(var_18_10, "bottom/list/popo_other")

	local var_18_11 = arg_18_0.chatPanel

	arg_18_0.prefabSelf = var_1.Find(var_18_11, "bottom/list/popo_self")

	local var_18_12 = arg_18_0.chatPanel

	arg_18_0.prefabWorldboss = var_1.Find(var_18_12, "bottom/list/popo_worldboss")

	local var_18_13 = arg_18_0.chatPanel

	arg_18_0.sendBtn = var_1.Find(var_18_13, "bottom/bottom/send")

	local var_18_14 = arg_18_0.chatPanel
	local var_18_15 = var_1.Find(var_18_14, "bottom/bottom/input")
	local var_18_16 = var_1.GetComponent

	typeof = var_4
	InputField = var_1_10006
	arg_18_0.msgInput = var_18_16(var_18_15, var_4(var_1_10006))

	local var_18_17 = arg_18_0.chatPanel

	arg_18_0.emojiBtn = var_1.Find(var_18_17, "bottom/bottom/emoji")

	local var_18_18 = arg_18_0.chatPanel

	arg_18_0.newMsgTip = var_1.Find(var_18_18, "bottom/bottom/tip")
	onButton = var_1

	local var_18_19 = arg_18_0
	local var_18_20 = arg_18_0.sendBtn

	local function var_18_21()
		local var_19_0 = arg_18_0.msgInput.text

		wordVer = var_2_10001

		local var_19_1 = var_2_10001(var_19_0)

		if 0 < var_19_1 then
			pg = var_19_1

			local var_19_2 = var_19_1.TipsMgr.GetInstance()

			var_19_1 = var_19_1.ShowTips
			i18n = var_2_10004

			var_19_1(var_19_2, var_2_10004("playerinfo_mask_word"))

			return
		end

		if var_19_0 == "" then
			pg = var_19_1

			local var_19_3 = var_19_1.TipsMgr.GetInstance()
			local var_19_4 = var_1.ShowTips

			i18n = var_2_10004

			var_19_4(var_19_3, var_2_10004("guild_msg_is_null"))

			return
		end

		if arg_18_0.chatTimer then
			pg = var_1

			local var_19_5 = var_1.TimeMgr.GetInstance()

			if var_1.GetServerTime(var_19_5) - arg_18_0.chatTimer < 5 then
				pg = var_1

				local var_19_6 = var_1.TipsMgr.GetInstance()
				local var_19_7 = var_1.ShowTips

				i18n = var_2_10004

				var_19_7(var_19_6, var_2_10004("dont_send_message_frequently"))

				return
			end
		end

		local var_19_8 = arg_18_0

		pg = var_2

		local var_19_9 = var_2.TimeMgr.GetInstance()

		var_19_8.chatTimer = var_2.GetServerTime(var_19_9)

		local var_19_10 = arg_18_0
		local var_19_11 = var_1.emit

		GuildMainMediator = var_19_9

		var_19_11(var_19_10, var_19_9.SEND_MSG, var_19_0)

		arg_18_0.msgInput.text = ""

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_18_19, var_18_20, var_18_21, var_1_10006)

	onButton = var_1

	local var_18_22 = arg_18_0
	local var_18_23 = arg_18_0.emojiBtn

	local function var_18_24()
		local var_20_0 = arg_18_0.emojiBtn.position
		local var_20_1 = arg_18_0
		local var_20_2 = var_1.emit

		GuildMainMediator = var_2_10004

		local var_20_3 = var_2_10004.OPEN_EMOJI

		Vector3 = var_2_10005

		var_20_2(var_20_1, var_20_3, var_2_10005(var_20_0.x, var_20_0.y, 0), function(arg_21_0)
			local var_21_0 = arg_18_0
			local var_21_1 = var_1.emit

			GuildMainMediator = var_3_10004

			local var_21_2 = var_3_10004.SEND_MSG

			string = var_3_10005

			local var_21_3 = var_3_10005.gsub

			ChatConst = var_3_10007

			var_21_1(var_21_0, var_21_2, var_21_3(var_3_10007.EmojiCode, "code", arg_21_0))

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_18_22, var_18_23, var_18_24, var_1_10006)

	GetOrAddComponent = var_1

	local var_18_25 = arg_18_0.chatRect

	typeof = var_18_23
	EventTriggerListener = var_1_10006

	local var_18_26 = var_1(var_18_25, var_18_23(var_1_10006))

	var_1.AddDragEndFunc(var_18_26, function(arg_22_0, arg_22_1)
		GetComponent = var_2_10002

		local var_22_0 = arg_18_0.chatRect

		typeof = var_2_10005
		ScrollRect = var_2_10007

		if var_2_10002(var_22_0, var_2_10005(var_2_10007)).normalizedPosition.y <= 0.1 then
			local var_22_1 = arg_18_0

			var_4.ClearChatTip(var_22_1)
		end

		return
	end)
	arg_18_0:UpdateChatWindow()

	if arg_18_0.isAdmin then
		onInputEndEdit = var_2

		var_2(arg_18_0, arg_18_0.noticeTxt.gameObject, function()
			local var_23_0 = arg_18_0.guildVO
			local var_23_1

			if not var_0.GetAnnounce(var_23_0) then
				var_23_1 = ""
			end

			getInputText = var_2_10001

			if var_2_10001(arg_18_0.noticeTxt.gameObject) == "" or var_1 == var_23_1 then
				return
			end

			wordVer = var_23_0

			if var_23_0(var_1) > 0 then
				pg = var_2

				local var_23_2 = var_2.TipsMgr.GetInstance()
				local var_23_3 = var_2.ShowTips

				i18n = var_2_10005

				var_23_3(var_23_2, var_2_10005("playerinfo_mask_word"))

				setInputText = var_23_3

				var_23_3(arg_18_0.noticeTxt.gameObject, "")

				return
			end

			local var_23_4 = arg_18_0.noticeScrollTxt

			var_2.SetText(var_23_4, var_1)

			local var_23_5 = arg_18_0
			local var_23_6 = var_2.emit

			GuildMainMediator = var_5

			var_23_6(var_23_5, var_5.MODIFY, 5, 0, var_1)

			setInputText = var_23_6

			var_23_6(arg_18_0.noticeTxt.gameObject, "")

			return
		end)
	end

	setButtonEnabled = var_2

	var_2(arg_18_0.noticeMask, arg_18_0.isAdmin)

	return
end

function var_0_1.UpdateChatWindow(arg_24_0)
	local var_24_0 = arg_24_0.guildVO

	arg_24_0:UpdateNotice()

	local var_24_1 = var_24_0.logInfo

	arg_24_0:UpdateAllLog(var_24_1)

	local var_24_2 = arg_24_0.chatMsgs

	arg_24_0:UpdateAllChat(var_24_2)

	return
end

function var_0_1.UpdateNotice(arg_25_0)
	local var_25_0 = arg_25_0.guildVO

	if not var_1.GetAnnounce(var_25_0) or var_2 == "" then
		i18n = var_25_0

		local var_25_1

		if not var_25_0("guild_not_exist_notifycation") then
			var_25_1 = var_2
		end

		local var_25_2 = arg_25_0.noticeScrollTxt

		var_5.SetText(var_25_2, var_25_1)

		return
	end
end

function var_0_1.UpdateAllLog(arg_26_0, arg_26_1)
	removeAllChildren = var_1_10002

	var_1_10002(arg_26_0.logContent)

	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_1) do
		arg_26_0:AppendLog(iter_26_1)
	end

	return
end

function var_0_1.AppendLog(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.isInitChatWindow then
		return
	end

	local var_27_1

	if arg_27_0.logContent.childCount >= 200 then
		local var_27_0 = arg_27_0

		var_27_1 = arg_27_0.emit
		GuildMainMediator = var_1_10006

		var_27_1(var_27_0, var_1_10006.ON_REBUILD_LOG_ALL)
	else
		cloneTplTo = var_27_1

		local var_27_2 = var_27_1(arg_27_0.prefabPublic, arg_27_0.logContent)

		if arg_27_2 then
			var_27_2:SetAsFirstSibling()
		end

		local var_27_3 = var_27_2:Find("text")
		local var_27_4 = var_4.GetComponent(var_27_3, "RichText")
		local var_27_5 = var_27_2:Find("time")
		local var_27_6 = var_5.GetComponent

		typeof = var_8
		Text = var_1_10010

		local var_27_7 = var_27_6(var_27_5, var_8(var_1_10010))
		local var_27_8, var_27_9 = arg_27_1:getConent()
		local var_27_10 = arg_27_1.cmd

		GuildLogInfo = var_1_10009

		if var_27_10 == var_1_10009.CMD_TYPE_GET_SHIP then
			ChatProxy = var_27_10

			var_27_10.InjectPublic(var_27_4, var_27_8, true)
		else
			var_27_4.text = var_27_8
		end

		var_27_7.text = var_27_9
	end

	return
end

function var_0_1.UpdateAllChat(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1 or {}

	removeAllChildren = var_1_10003

	var_1_10003(arg_28_0.chatContent)

	local var_28_1 = {}

	math = var_1_10004

	local var_28_2 = var_1_10004.max
	local var_28_3 = 1
	local var_28_4 = #var_28_0

	GuildConst = var_1_10008
	arg_28_0.index = var_28_2(var_28_3, var_28_4 - var_1_10008.CHAT_LOG_MAX_COUNT)

	for iter_28_0 = arg_28_0.index, #var_28_0 do
		table = var_8

		var_8.insert(var_28_1, function(arg_29_0)
			local var_29_0 = arg_28_0

			var_1.Append(var_29_0, var_28_0[iter_28_0], -1, true)
			arg_29_0()

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_28_1, function()
		Timer = var_2_10000

		local var_30_0 = var_2_10000.New(function()
			IsNil = var_3_10000

			if not var_3_10000(arg_28_0.chatContent) then
				scrollToBottom = var_0

				var_0(arg_28_0.chatContent.parent)
			end

			return
		end, 0.5, 1)

		var_0.Start(var_30_0)

		return
	end)

	return
end

function var_0_1.Append(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0:UpdateChatBtn()

	if not arg_32_0.isInitChatWindow then
		return
	end

	local var_32_0 = arg_32_0.chatContent.childCount

	GuildConst = var_1_10005

	if var_32_0 >= var_1_10005.CHAT_LOG_MAX_COUNT * 2 then
		local var_32_1 = arg_32_0
		local var_32_2 = arg_32_0.emit

		GuildMainMediator = var_1_10007

		var_32_2(var_32_1, var_1_10007.REBUILD_ALL)
	elseif arg_32_1.id and arg_32_1.id == 4 then
		arg_32_0:AddWorldBossMsg(arg_32_1, arg_32_2, arg_32_3)
	else
		arg_32_0:AppendWorld(arg_32_1, arg_32_2, arg_32_3)
	end

	return
end

function var_0_1.ShowChatTip(arg_33_0)
	setActive = var_1_10001

	var_1_10001(arg_33_0.newMsgTip, true)

	return
end

function var_0_1.ClearChatTip(arg_34_0)
	setActive = var_1_10001

	var_1_10001(arg_34_0.newMsgTip, false)

	return
end

function var_0_1.AddWorldBossMsg(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	Clone = var_1_10004

	local var_35_0 = var_1_10004(arg_35_1).player

	if not arg_35_3 then
		arg_35_0:ShowChatTip()
	end

	cloneTplTo = var_6

	local var_35_1 = var_6(arg_35_0.prefabWorldboss, arg_35_0.chatContent)

	ChatBubbleWorldBoss = var_1_10007

	local var_35_2 = var_1_10007.New(var_35_1)

	if arg_35_2 >= 0 then
		local var_35_3 = var_35_2.tf

		var_8.SetSiblingIndex(var_35_3, arg_35_2)
	end

	var_35_2:update(var_4)

	table = var_8

	var_8.insert(arg_35_0.chatBubbles, var_35_2)

	return
end

function var_0_1.AppendWorld(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	Clone = var_1_10004

	local var_36_0 = var_1_10004(arg_36_1).player
	local var_36_1 = arg_36_0.prefabOthers

	if var_36_0.id == arg_36_0.playerVO.id then
		var_36_1 = arg_36_0.prefabSelf
		setmetatable = var_7
		Clone = var_1_10009
		var_4.player = var_7(var_1_10009(arg_36_0.playerVO), {
			__index = var_4.player
		})
	elseif not arg_36_3 then
		arg_36_0:ShowChatTip()
	end

	cloneTplTo = var_7

	local var_36_2 = var_7(var_36_1, arg_36_0.chatContent)

	GuildChatBubble = var_8

	local var_36_3 = var_8.New(var_36_2)

	if arg_36_2 >= 0 then
		local var_36_4 = var_36_3.tf

		var_9.SetSiblingIndex(var_36_4, arg_36_2)
	end

	var_4.isSelf = var_36_0.id == arg_36_0.playerVO.id

	var_36_3:update(var_4)

	if not arg_36_3 and var_4.isSelf then
		onNextTick = var_9

		var_9(function()
			scrollToBottom = var_2_10000

			var_2_10000(arg_36_0.chatContent.parent)

			return
		end)
	end

	table = var_9

	var_9.insert(arg_36_0.chatBubbles, var_36_3)

	return
end

function var_0_1.UpdateMainInfo(arg_38_0)
	local var_38_0 = arg_38_0.guildVO

	arg_38_0.nameTxt.text = var_38_0:getName()
	arg_38_0.factionTxt.text = var_38_0:getFactionName()
	arg_38_0.policyTxt.text = var_38_0:getPolicyName()
	arg_38_0.idTxt.text = "ID:" .. var_38_0.id

	local var_38_1 = arg_38_0.numberTxt

	var_38_1.text = var_38_0.memberCount .. "/" .. var_38_0:getMaxMember()
	setFillAmount = var_38_1

	local var_38_2 = arg_38_0.expImg
	local var_38_3 = var_38_0.exp

	math = var_1_10006

	var_38_1(var_38_2, var_38_3 / var_1_10006.max(var_38_0:getLevelMaxExp(), 1))

	local var_38_4 = arg_38_0.levelTxt
	local var_38_5

	if not (var_38_0.level <= 9) or not ("0" .. var_38_0.level) then
		var_38_5 = var_38_0.level
	end

	var_38_4.text = var_38_5

	local var_38_6 = ""
	local var_38_7 = ""

	math = var_4

	local var_38_8 = var_4.floor(var_38_0.level / 10)

	for iter_38_0 = 1, var_38_8 do
		var_38_7 = var_38_7 .. ":"
	end

	local var_38_9 = var_38_0.level % 10
	local var_38_10 = var_38_7 .. (var_38_9 == 0 and "" or var_38_9)

	arg_38_0.levelImg.text = var_38_10

	if arg_38_0.isInitChatWindow then
		arg_38_0:UpdateNotice()
	end

	return
end

function var_0_1.ShowOrHideChatWindow(arg_39_0, arg_39_1)
	LeanTween = var_1_10002

	local var_39_0 = var_1_10002.isTweening

	go = var_1_10004

	if var_39_0(var_1_10004(arg_39_0.chatPanel)) then
		return
	end

	local var_39_1
	local var_39_2
	local var_39_3
	local var_39_4

	if not arg_39_1 then
		var_39_1, var_39_2 = 0, arg_39_0.chatPanelWidth
		var_39_3, var_39_4 = arg_39_0.chatBtnWidth, 0
	else
		var_39_1, var_39_2 = arg_39_0.chatPanelWidth, 0
		var_39_3, var_39_4 = 0, arg_39_0.chatBtnWidth
	end

	arg_39_0.isShowChatWindow = arg_39_1

	local function var_39_5()
		local var_40_1

		if arg_39_1 then
			setParent = var_40_1

			local var_40_0 = arg_39_0.chatPanel

			pg = var_2_10003

			var_40_1(var_40_0, var_2_10003.UIMgr.GetInstance().OverlayMain, true)

			var_40_1 = arg_39_0.chatPanel.localPosition

			local var_40_2 = arg_39_0.chatPanel

			Vector3 = var_40_0
			var_40_2.localPosition = var_40_0(var_40_1.x, var_40_1.y, 0)
			pg = var_40_2

			local var_40_3 = var_40_2.UIMgr.GetInstance()

			var_1.OverlayPanel(var_40_3, arg_39_0.chatPanel, {
				groupName = "group_GuildMainUI",
				pbList = {
					arg_39_0.chatPanel
				}
			})

			arg_39_0.chatPanelAnchoredPositionX = arg_39_0.chatPanel.anchoredPosition.x
		else
			pg = var_40_1

			local var_40_4 = var_40_1.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_40_4, arg_39_0.chatPanel, arg_39_0._tf)
		end

		return
	end

	LeanTween = var_1_10007

	local var_39_6 = var_1_10007.value

	go = var_1_10009

	local var_39_7 = var_39_6(var_1_10009(arg_39_0.chatPanel), var_39_1, var_39_2, 0.3)
	local var_39_8 = var_7.setOnUpdate

	System = var_10

	local var_39_9 = var_39_8(var_39_7, var_10.Action_float(function(arg_41_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_39_0.chatPanel, {
			x = arg_41_0
		})

		return
	end))
	local var_39_10 = var_7.setOnComplete

	System = var_10

	var_39_10(var_39_9, var_10.Action(var_39_5))

	LeanTween = var_39_10

	local var_39_11 = var_39_10.value

	go = var_39_9

	local var_39_12 = var_39_11(var_39_9(arg_39_0.chatBtn), var_39_3, var_39_4, 0.3)
	local var_39_13 = var_7.setOnUpdate

	System = var_10

	var_39_13(var_39_12, var_10.Action_float(function(arg_42_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_39_0.chatBtn, {
			x = arg_42_0
		})

		return
	end))

	return
end

function var_0_1.EnterOrExitPreView(arg_43_0, arg_43_1)
	LeanTween = var_1_10002

	local var_43_0 = var_1_10002.isTweening

	go = var_1_10004

	if not var_43_0(var_1_10004(arg_43_0.top)) then
		LeanTween = var_2

		local var_43_1 = var_2.isTweening

		go = var_4

		if not var_43_1(var_4(arg_43_0.bottomPanel)) then
			LeanTween = var_2

			local var_43_2 = var_2.isTweening

			go = var_4

			if not var_43_2(var_4(arg_43_0.chatPanel)) then
				LeanTween = var_2

				local var_43_3 = var_2.isTweening

				go = var_4

				if var_43_3(var_4(arg_43_0.chatBtn)) then
					return
				end

				local var_43_4

				if not arg_43_1 or not {
					0,
					arg_43_0.topPanelWidth
				} then
					var_43_4 = {
						arg_43_0.topPanelWidth,
						0
					}
				end

				LeanTween = var_1_10003

				local var_43_5 = var_1_10003.value

				go = var_1_10005

				local var_43_6 = var_43_5(var_1_10005(arg_43_0.top), var_43_4[1], var_43_4[2], 0.3)
				local var_43_7 = var_3.setOnUpdate

				System = var_6

				var_43_7(var_43_6, var_6.Action_float(function(arg_44_0)
					setAnchoredPosition = var_2_10001

					var_2_10001(arg_43_0.top, {
						y = arg_44_0
					})

					return
				end))

				local var_43_8

				if not arg_43_1 or not {
					94,
					94 + arg_43_0.bottomPanelWidth
				} then
					var_43_8 = {
						94 + arg_43_0.bottomPanelWidth,
						94
					}
				end

				LeanTween = var_4

				local var_43_9 = var_4.value

				go = var_6

				local var_43_10 = var_43_9(var_6(arg_43_0.bottomPanel), var_43_8[1], var_43_8[2], 0.3)
				local var_43_11 = var_4.setOnUpdate

				System = var_7

				var_43_11(var_43_10, var_7.Action_float(function(arg_45_0)
					setAnchoredPosition = var_2_10001

					var_2_10001(arg_43_0.bottomPanel, {
						y = arg_45_0
					})

					return
				end))

				local var_43_13

				if arg_43_0.isShowChatWindow then
					local var_43_12

					if not arg_43_1 or not {
						0,
						arg_43_0.chatPanelWidth
					} then
						var_43_12 = {
							arg_43_0.chatPanelWidth
						}

						if not arg_43_0.chatPanelAnchoredPositionX then
							var_43_6 = 0
						end

						var_43_12[2] = var_43_6
					end

					LeanTween = var_43_6
					var_43_6 = var_43_6.value
					go = var_43_13
					var_43_13 = var_43_6(var_43_13(arg_43_0.chatPanel), var_43_12[1], var_43_12[2], 0.3)
					var_43_6 = var_43_6.setOnUpdate
					System = var_8

					var_43_6(var_43_13, var_8.Action_float(function(arg_46_0)
						setAnchoredPosition = var_2_10001

						var_2_10001(arg_43_0.chatPanel, {
							x = arg_46_0
						})

						return
					end))
				else
					local var_43_14

					if not arg_43_1 or not {
						0,
						arg_43_0.chatBtnWidth
					} then
						var_43_14 = {
							arg_43_0.chatBtnWidth,
							0
						}
					end

					LeanTween = var_43_6

					local var_43_15 = var_43_6.value

					go = var_43_13

					local var_43_16 = var_43_15(var_43_13(arg_43_0.chatBtn), var_43_14[1], var_43_14[2], 0.3)
					local var_43_17 = var_5.setOnUpdate

					System = var_8

					var_43_17(var_43_16, var_8.Action_float(function(arg_47_0)
						setAnchoredPosition = var_2_10001

						var_2_10001(arg_43_0.chatBtn, {
							x = arg_47_0
						})

						return
					end))
				end

				return
			end
		end
	end
end

function var_0_1.InsertEmojiToInputText(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.msgInput
	local var_48_1 = arg_48_0.msgInput.text

	string = var_1_10004

	local var_48_2 = var_1_10004.gsub

	ChatConst = var_1_10006
	var_48_0.text = var_48_1 .. var_48_2(var_1_10006.EmojiIconCode, "code", arg_48_1)

	return
end

function var_0_1.OnDestroy(arg_49_0)
	if arg_49_0.isShowChatWindow then
		pg = var_1
		var_1_10003 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_1_10003, arg_49_0.chatPanel, arg_49_0._tf)
	end

	LeanTween = var_1

	local var_49_0 = var_1.isTweening

	go = var_1_10003

	local var_49_1

	if var_49_0(var_1_10003(arg_49_0.chatPanel)) then
		LeanTween = var_49_1
		var_49_1 = var_49_1.cancel
		go = var_3

		var_49_1(var_3(arg_49_0.chatPanel))
	end

	LeanTween = var_49_1

	local var_49_2 = var_49_1.isTweening

	go = var_3

	if var_49_2(var_3(arg_49_0.chatBtn)) then
		LeanTween = var_1

		local var_49_3 = var_1.cancel

		go = var_3

		var_49_3(var_3(arg_49_0.chatBtn))
	end

	local var_49_4 = arg_49_0.modifyPage

	var_1.Destroy(var_49_4)

	ipairs = var_1

	for iter_49_0, iter_49_1 in var_1(arg_49_0.chatBubbles) do
		if iter_49_1 then
			iter_49_1:dispose()
		end
	end

	arg_49_0.chatBubbles = nil

	arg_49_0:Hide()

	return
end

return var_0_1
