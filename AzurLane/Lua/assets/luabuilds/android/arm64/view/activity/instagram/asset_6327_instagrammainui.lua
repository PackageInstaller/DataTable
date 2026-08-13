class = var_0_10000

local var_0_0 = "InstagramMainUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "InstagramMainUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.m02
	local var_2_1 = var_2.sendNotification

	GAME = var_1_10005

	var_2_1(var_2_0, var_1_10005.REQ_OLD_INSTAGRAM_DATA, {
		callback = function()
			arg_2_1()

			return
		end
	})

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.bg = var_1.Find(var_4_0, "bg")

	local var_4_1 = arg_4_0._tf

	arg_4_0.helpBtn = var_1.Find(var_4_1, "mainPanel/helpBtn")

	local var_4_2 = arg_4_0._tf

	arg_4_0.chatBtn = var_1.Find(var_4_2, "mainPanel/left/chatBtn")

	local var_4_3 = arg_4_0._tf

	arg_4_0.juusBtn = var_1.Find(var_4_3, "mainPanel/left/juusBtn")
	MainMusicPlayerView = var_1
	arg_4_0.musicPlayerView = var_1.New(arg_4_0._tf, arg_4_0.event)

	local var_4_4 = arg_4_0.musicPlayerView
	local var_4_5 = var_1.Load
	local var_4_6 = arg_4_0._tf

	var_4_5(var_4_4, var_4.Find(var_4_6, "MusicPlayer").gameObject)

	local var_4_7 = arg_4_0.musicPlayerView

	var_1.ActionInvoke(var_4_7, "Hide")
	arg_4_0:ChangeChatTip()
	arg_4_0:ChangeJuusTip()
	arg_4_0:BlurPanel(arg_4_0._tf)

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:SetUp()
	arg_5_0:FlushMusicPlayer()

	if arg_5_0.contextData.current then
		SetActive = var_1

		local var_5_0 = arg_5_0.chatBtn

		var_1(var_3.Find(var_5_0, "choose"), arg_5_0.contextData.current == "chat")

		SetActive = var_1

		local var_5_1 = arg_5_0.juusBtn

		var_1(var_3.Find(var_5_1, "choose"), arg_5_0.contextData.current == "juus")
	else
		triggerButton = var_1

		var_1(arg_5_0.chatBtn)
	end

	return
end

function var_0_1.FlushMusicPlayer(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.BgmMgr.GetInstance()
	local var_6_1 = var_1.GetNow(var_6_0) == "MainMusicPlayer"

	tobool = var_1_10002

	local var_6_2 = arg_6_0.musicPlayerView

	if var_1_10002(var_4.isShowing(var_6_2)) ~= var_6_1 then
		if var_6_1 then
			local var_6_3 = arg_6_0.musicPlayerView

			var_2.ExecuteAction(var_6_3, "Show", false)
		else
			local var_6_4 = arg_6_0.musicPlayerView

			var_2.ExecuteAction(var_6_4, "Hide")
		end
	end

	return
end

function var_0_1.SetUp(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.bg

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.OnClose(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.helpBtn

	local function var_7_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_9_2.type = var_2_10004
		pg = var_2_10004
		var_9_2.helps = var_2_10004.gametip.music_juus.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10006)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.chatBtn

	local function var_7_8()
		local var_10_0 = arg_7_0.contextData

		var_10_0.current = "chat"
		isActive = var_10_0

		local var_10_1 = arg_7_0.juusBtn
		local var_10_3

		if var_10_0(var_2.Find(var_10_1, "choose")) then
			local var_10_2 = arg_7_0

			var_10_3 = var_10_3.emit
			InstagramMainMediator = var_2_10003

			var_10_3(var_10_2, var_2_10003.CLOSE_JUUS_DETAIL)
		end

		SetActive = var_10_3

		local var_10_4 = arg_7_0.chatBtn

		var_10_3(var_2.Find(var_10_4, "choose"), arg_7_0.contextData.current == "chat")

		SetActive = var_10_3

		local var_10_5 = arg_7_0.juusBtn

		var_10_3(var_2.Find(var_10_5, "choose"), arg_7_0.contextData.current == "juus")

		local var_10_6 = arg_7_0
		local var_10_7 = var_0.emit

		InstagramMainMediator = var_3

		var_10_7(var_10_6, var_3.OPEN_CHAT)

		local var_10_8 = arg_7_0
		local var_10_9 = var_0.emit

		InstagramMainMediator = var_3

		var_10_9(var_10_8, var_3.CLOSE_JUUS)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10006)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.juusBtn

	local function var_7_11()
		local var_11_0 = arg_7_0.contextData

		var_11_0.current = "juus"
		SetActive = var_11_0

		local var_11_1 = arg_7_0.chatBtn

		var_11_0(var_2.Find(var_11_1, "choose"), arg_7_0.contextData.current == "chat")

		SetActive = var_11_0

		local var_11_2 = arg_7_0.juusBtn

		var_11_0(var_2.Find(var_11_2, "choose"), arg_7_0.contextData.current == "juus")

		local var_11_3 = arg_7_0
		local var_11_4 = var_0.emit

		InstagramMainMediator = var_3

		var_11_4(var_11_3, var_3.OPEN_JUUS)

		local var_11_5 = arg_7_0
		local var_11_6 = var_0.emit

		InstagramMainMediator = var_3

		var_11_6(var_11_5, var_3.CLOSE_CHAT)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10006)

	return
end

function var_0_1.OnClose(arg_12_0)
	isActive = var_1_10001

	local var_12_0 = arg_12_0.juusBtn

	if var_1_10001(var_3.Find(var_12_0, "choose")) then
		local var_12_1 = arg_12_0
		local var_12_2 = arg_12_0.emit

		InstagramMainMediator = var_1_10004

		var_12_2(var_12_1, var_1_10004.INS_BACK_PRESSED)
	else
		local var_12_3 = arg_12_0
		local var_12_4 = arg_12_0.emit

		InstagramMainMediator = var_1_10004

		var_12_4(var_12_3, var_1_10004.JUUS_BACK_PRESSED)
	end

	return
end

function var_0_1.ChangeJuusTip(arg_13_0)
	getProxy = var_1_10001
	InstagramProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)

	SetActive = var_1_10002

	local var_13_1 = arg_13_0.juusBtn

	var_1_10002(var_4.Find(var_13_1, "tip"), var_13_0:ShouldShowTip())

	return
end

function var_0_1.ChangeChatTip(arg_14_0)
	getProxy = var_1_10001
	InstagramChatProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	SetActive = var_1_10002

	local var_14_1 = arg_14_0.chatBtn
	local var_14_2 = var_4.Find(var_14_1, "tip")
	local var_14_3 = var_14_0
	local var_14_5

	if var_14_0.ShouldShowTip(var_14_3) then
		getProxy = var_14_5
		InstagramProxy = var_14_3

		local var_14_4 = var_14_5(var_14_3)

		var_14_5 = var_14_5.ShouldShowOfficialAccountsTip(var_14_4)
	end

	var_1_10002(var_14_2, var_14_5)

	return
end

function var_0_1.willExit(arg_15_0)
	local var_15_0 = arg_15_0.musicPlayerView

	var_1.Destroy(var_15_0)

	return
end

return var_0_1
