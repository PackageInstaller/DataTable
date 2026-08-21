local var_0_0 = class("InstagramMainUI", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "InstagramMainUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	pg.m02:sendNotification(GAME.REQ_OLD_INSTAGRAM_DATA, {
		callback = function()
			arg_2_1()

			return
		end
	})

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.bg = arg_4_0._tf:Find("bg")
	arg_4_0.helpBtn = arg_4_0._tf:Find("mainPanel/helpBtn")
	arg_4_0.chatBtn = arg_4_0._tf:Find("mainPanel/left/chatBtn")
	arg_4_0.juusBtn = arg_4_0._tf:Find("mainPanel/left/juusBtn")
	arg_4_0.musicPlayerView = MainMusicPlayerView.New(arg_4_0._tf, arg_4_0.event)

	arg_4_0.musicPlayerView:Load(arg_4_0._tf:Find("MusicPlayer").gameObject)
	arg_4_0.musicPlayerView:ActionInvoke("Hide")
	arg_4_0:ChangeChatTip()
	arg_4_0:ChangeJuusTip()
	arg_4_0:BlurPanel(arg_4_0._tf)

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:SetUp()
	arg_5_0:FlushMusicPlayer()

	if arg_5_0.contextData.current then
		SetActive(arg_5_0.chatBtn:Find("choose"), arg_5_0.contextData.current == "chat")
		SetActive(arg_5_0.juusBtn:Find("choose"), arg_5_0.contextData.current == "juus")
	else
		triggerButton(arg_5_0.chatBtn)
	end

	return
end

function var_0_0.FlushMusicPlayer(arg_6_0)
	local var_6_0 = pg.BgmMgr.GetInstance():GetNow() == "MainMusicPlayer"

	if tobool(arg_6_0.musicPlayerView:isShowing()) ~= var_6_0 then
		if var_6_0 then
			arg_6_0.musicPlayerView:ExecuteAction("Show", false)
		else
			arg_6_0.musicPlayerView:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_0.SetUp(arg_7_0)
	onButton(arg_7_0, arg_7_0.bg, function()
		arg_7_0:OnClose()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_juus.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.chatBtn, function()
		arg_7_0.contextData.current = "chat"

		if isActive(arg_7_0.juusBtn:Find("choose")) then
			arg_7_0:emit(InstagramMainMediator.CLOSE_JUUS_DETAIL)
		end

		SetActive(arg_7_0.chatBtn:Find("choose"), arg_7_0.contextData.current == "chat")
		SetActive(arg_7_0.juusBtn:Find("choose"), arg_7_0.contextData.current == "juus")
		arg_7_0:emit(InstagramMainMediator.OPEN_CHAT)
		arg_7_0:emit(InstagramMainMediator.CLOSE_JUUS)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.juusBtn, function()
		arg_7_0.contextData.current = "juus"

		SetActive(arg_7_0.chatBtn:Find("choose"), arg_7_0.contextData.current == "chat")
		SetActive(arg_7_0.juusBtn:Find("choose"), arg_7_0.contextData.current == "juus")
		arg_7_0:emit(InstagramMainMediator.OPEN_JUUS)
		arg_7_0:emit(InstagramMainMediator.CLOSE_CHAT)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnClose(arg_12_0)
	if isActive(arg_12_0.juusBtn:Find("choose")) then
		arg_12_0:emit(InstagramMainMediator.INS_BACK_PRESSED)
	else
		arg_12_0:emit(InstagramMainMediator.JUUS_BACK_PRESSED)
	end

	return
end

function var_0_0.ChangeJuusTip(arg_13_0)
	SetActive(arg_13_0.juusBtn:Find("tip"), getProxy(InstagramProxy):ShouldShowTip())

	return
end

function var_0_0.ChangeChatTip(arg_14_0)
	local var_14_0 = getProxy(InstagramChatProxy):ShouldShowTip()

	var_14_0 = var_14_0 and getProxy(InstagramProxy):ShouldShowOfficialAccountsTip()

	SetActive(arg_14_0.chatBtn:Find("tip"), var_14_0)

	return
end

function var_0_0.willExit(arg_15_0)
	arg_15_0.musicPlayerView:Destroy()

	return
end

return var_0_0
