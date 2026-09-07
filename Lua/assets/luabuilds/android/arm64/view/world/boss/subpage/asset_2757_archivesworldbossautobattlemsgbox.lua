local ArchivesWorldBossAutoBattleMsgbox = class("ArchivesWorldBossAutoBattleMsgbox", import("view.base.BaseSubView"))

function ArchivesWorldBossAutoBattleMsgbox:getUIName()
	return "ArchivesWorldBossAutoBattleMsgUI"
end

function ArchivesWorldBossAutoBattleMsgbox:OnLoaded()
	self.contentTxt = self._tf:Find("window/msg_panel/content/time"):GetComponent(typeof(Text))
	self.startBtn = self._tf:Find("window/btns/start")
	self.startTxt = self.startBtn:Find("pic"):GetComponent(typeof(Text))
	self.cancelBtn = self._tf:Find("window/btns/cancel")
	self.cancelTxt = self.cancelBtn:Find("pic"):GetComponent(typeof(Text))
	self.closeBtn = self._tf:Find("window/top/close")
	self.titleTxt = self._tf:Find("window/top/title"):GetComponent(typeof(Text))

	setText(self._tf:Find("window/msg_panel/content/label"), i18n("world_boss_archives_stop_auto_battle_tip"))
	setText(self._tf:Find("window/msg_panel/label1"), i18n("world_boss_archives_stop_auto_battle_tip1"))

	return
end

function ArchivesWorldBossAutoBattleMsgbox:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		if self.OnNo then
			self.OnNo()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		if self.OnYes then
			self.OnYes()
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function ArchivesWorldBossAutoBattleMsgbox:Show(arg_8_1)
	ArchivesWorldBossAutoBattleMsgbox.super.Show(self)
	self:RemoveTimer()

	if arg_8_1.onContent then
		self:AddTimer(arg_8_1)
	else
		self.contentTxt.text = arg_8_1.content
	end

	self.titleTxt.text = arg_8_1.title
	self.OnYes = arg_8_1.onYes
	self.OnNo = arg_8_1.onNo

	setActive(self.cancelBtn, not arg_8_1.noNo)

	self.startTxt.text = arg_8_1.yesText or i18n("word_ok")
	self.cancelTxt.text = arg_8_1.noText or i18n("word_cancel")

	return
end

function ArchivesWorldBossAutoBattleMsgbox:AddTimer(arg_9_1)
	self.timer = Timer.New(function()
		local var_10_0 = arg_9_1.onContent()

		if var_10_0 == nil then
			self:Hide()
		end

		self.contentTxt.text = var_10_0

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function ArchivesWorldBossAutoBattleMsgbox:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function ArchivesWorldBossAutoBattleMsgbox:Hide()
	ArchivesWorldBossAutoBattleMsgbox.super.Hide(self)
	self:RemoveTimer()

	self.OnYes = nil
	self.OnNo = nil

	return
end

function ArchivesWorldBossAutoBattleMsgbox:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return ArchivesWorldBossAutoBattleMsgbox
