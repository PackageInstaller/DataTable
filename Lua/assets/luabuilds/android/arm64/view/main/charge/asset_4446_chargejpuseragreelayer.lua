local ChargeJPUserAgreeLayer = class("ChargeJPUserAgreeLayer", import("...base.BaseUI"))

function ChargeJPUserAgreeLayer:getUIName()
	return "ChargeJPUserAgreeUI"
end

function ChargeJPUserAgreeLayer:init()
	self:initData()
	self:findUI()
	self:addListener()
	self:initUIText()

	return
end

function ChargeJPUserAgreeLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setText(self.scrollText, self.contentStr or "")
	scrollTo(self.scrollRect, 0, 1)

	return
end

function ChargeJPUserAgreeLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function ChargeJPUserAgreeLayer:initData()
	self.contentStr = self.contextData.contentStr and self.contextData.contentStr.content

	return
end

function ChargeJPUserAgreeLayer:initUIText()
	return
end

function ChargeJPUserAgreeLayer:findUI()
	self.bg = self._tf:Find("bg")
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.scrollRect = self._tf:Find("container/scrollrect")
	self.scrollText = self.scrollRect:Find("content/Text")

	return
end

function ChargeJPUserAgreeLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

return ChargeJPUserAgreeLayer
