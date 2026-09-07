local InstagramMainUI = class("InstagramMainUI", import("...base.BaseUI"))

function InstagramMainUI:getUIName()
	return "InstagramMainUI"
end

function InstagramMainUI:preload(arg_2_1)
	pg.m02:sendNotification(GAME.REQ_OLD_INSTAGRAM_DATA, {
		callback = function()
			arg_2_1()

			return
		end
	})

	return
end

function InstagramMainUI:init()
	self.bg = self._tf:Find("bg")
	self.helpBtn = self._tf:Find("mainPanel/helpBtn")
	self.chatBtn = self._tf:Find("mainPanel/left/chatBtn")
	self.juusBtn = self._tf:Find("mainPanel/left/juusBtn")
	self.musicPlayerView = MainMusicPlayerView.New(self._tf, self.event)

	self.musicPlayerView:Load(self._tf:Find("MusicPlayer").gameObject)
	self.musicPlayerView:ActionInvoke("Hide")
	self:ChangeChatTip()
	self:ChangeJuusTip()
	self:BlurPanel(self._tf)

	return
end

function InstagramMainUI:didEnter()
	self:SetUp()
	self:FlushMusicPlayer()

	if self.contextData.current then
		SetActive(self.chatBtn:Find("choose"), self.contextData.current == "chat")
		SetActive(self.juusBtn:Find("choose"), self.contextData.current == "juus")
	else
		triggerButton(self.chatBtn)
	end

	return
end

function InstagramMainUI:FlushMusicPlayer()
	local var_6_0 = pg.BgmMgr.GetInstance():GetNow() == "MainMusicPlayer"

	if tobool(self.musicPlayerView:isShowing()) ~= var_6_0 then
		if var_6_0 then
			self.musicPlayerView:ExecuteAction("Show", false)
		else
			self.musicPlayerView:ExecuteAction("Hide")
		end
	end

	return
end

function InstagramMainUI:SetUp()
	onButton(self, self.bg, function()
		self:OnClose()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_juus.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.chatBtn, function()
		self.contextData.current = "chat"

		if isActive(self.juusBtn:Find("choose")) then
			self:emit(InstagramMainMediator.CLOSE_JUUS_DETAIL)
		end

		SetActive(self.chatBtn:Find("choose"), self.contextData.current == "chat")
		SetActive(self.juusBtn:Find("choose"), self.contextData.current == "juus")
		self:emit(InstagramMainMediator.OPEN_CHAT)
		self:emit(InstagramMainMediator.CLOSE_JUUS)

		return
	end, SFX_PANEL)
	onButton(self, self.juusBtn, function()
		self.contextData.current = "juus"

		SetActive(self.chatBtn:Find("choose"), self.contextData.current == "chat")
		SetActive(self.juusBtn:Find("choose"), self.contextData.current == "juus")
		self:emit(InstagramMainMediator.OPEN_JUUS)
		self:emit(InstagramMainMediator.CLOSE_CHAT)

		return
	end, SFX_PANEL)

	return
end

function InstagramMainUI:OnClose()
	if isActive(self.juusBtn:Find("choose")) then
		self:emit(InstagramMainMediator.INS_BACK_PRESSED)
	else
		self:emit(InstagramMainMediator.JUUS_BACK_PRESSED)
	end

	return
end

function InstagramMainUI:ChangeJuusTip()
	SetActive(self.juusBtn:Find("tip"), getProxy(InstagramProxy):ShouldShowTip())

	return
end

function InstagramMainUI:ChangeChatTip()
	local var_14_0 = getProxy(InstagramChatProxy):ShouldShowTip()

	var_14_0 = var_14_0 and getProxy(InstagramProxy):ShouldShowOfficialAccountsTip()

	SetActive(self.chatBtn:Find("tip"), var_14_0)

	return
end

function InstagramMainUI:willExit()
	self.musicPlayerView:Destroy()

	return
end

return InstagramMainUI
