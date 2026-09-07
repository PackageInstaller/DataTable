local ArchivesWorldBossMsgboxPage = class("ArchivesWorldBossMsgboxPage", import("view.base.BaseSubView"))

function ArchivesWorldBossMsgboxPage:getUIName()
	return "ArchivesWorldBossMsgboxUI"
end

function ArchivesWorldBossMsgboxPage:OnLoaded()
	self.yesBtn = self._tf:Find("Box/ConfirmBtn")
	self.cancelBtn = self._tf:Find("Box/CancelBtn")
	self.contentTxt = self._tf:Find("Box/Text"):GetComponent(typeof(Text))

	return
end

function ArchivesWorldBossMsgboxPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.yesBtn, function()
		if self.onYes then
			self.onYes()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function ArchivesWorldBossMsgboxPage:Show(arg_7_1)
	ArchivesWorldBossMsgboxPage.super.Show(self)

	self.contentTxt.text = arg_7_1.content
	self.onYes = arg_7_1.onYes

	return
end

function ArchivesWorldBossMsgboxPage:Hide()
	ArchivesWorldBossMsgboxPage.super.Hide(self)

	if self.onYes then
		self.onYes = nil
	end

	return
end

function ArchivesWorldBossMsgboxPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return ArchivesWorldBossMsgboxPage
