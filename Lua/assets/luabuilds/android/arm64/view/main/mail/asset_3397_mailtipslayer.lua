local MailTipsLayer = class("MailTipsLayer", import("view.base.BaseUI"))

function MailTipsLayer:getUIName()
	return "MailTipLayersMsgBoxUI"
end

function MailTipsLayer:init()
	self.btnBack = self._tf:Find("adapt/window/top/btnBack")
	self.goBtn = self._tf:Find("adapt/window/button_container/btn_ok")
	self.title = self._tf:Find("adapt/window/top/bg/infomation/title")
	self.bgBack = self._tf:Find("bg")
	self.context = self._tf:Find("adapt/window/msg_panel/content"):GetComponent("RichText")

	return
end

function MailTipsLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.bgBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.goBtn, function()
		self.contextData.onYes()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.context.text = self.contextData.content

	setText(self.title, i18n("mail_boxtitle_information"))
	setText(self.goBtn:Find("Text"), i18n("mail_box_confirm"))

	if not pg.NewStoryMgr.GetInstance():IsPlayed("NEW_MAIL_GUIDE") then
		pg.NewGuideMgr.GetInstance():Play("NEW_MAIL_GUIDE")
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = "NEW_MAIL_GUIDE"
		})
	end

	return
end

function MailTipsLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return MailTipsLayer
