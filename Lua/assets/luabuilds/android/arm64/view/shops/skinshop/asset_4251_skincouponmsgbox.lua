local SkinCouponMsgBox = class("SkinCouponMsgBox", import("view.base.BaseSubView"))

function SkinCouponMsgBox:getUIName()
	return "SkinCouponMsgBoxUI"
end

function SkinCouponMsgBox:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.cancelBtn = self._tf:Find("window/button_container/cancel")
	self.confirmBtn = self._tf:Find("window/button_container/confirm")
	self.label1 = self._tf:Find("window/frame/Text"):GetComponent(typeof(Text))
	self.leftItemTr = self._tf:Find("window/frame/left")
	self.nameTxt = self.leftItemTr:Find("name_bg/Text"):GetComponent(typeof(Text))

	setText(self.cancelBtn:Find("pic"), i18n("msgbox_text_cancel"))
	setText(self.confirmBtn:Find("pic"), i18n("msgbox_text_confirm"))
	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("words_information"))

	return
end

function SkinCouponMsgBox:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SkinCouponMsgBox:Show(arg_7_1)
	SkinCouponMsgBox.super.Show(self)

	self.settings = arg_7_1

	self:UpdateItem(arg_7_1)
	self:RegisterBtn(arg_7_1)
	self:UpdateContent(arg_7_1)

	return
end

function SkinCouponMsgBox:RegisterBtn(arg_8_1)
	onButton(self, self.confirmBtn, function()
		if arg_8_1.onYes then
			arg_8_1.onYes()
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SkinCouponMsgBox:UpdateContent(arg_10_1)
	self.label1.text = i18n("skin_purchase_confirm", arg_10_1.drop:getName(), arg_10_1.price, arg_10_1.skinName)

	setActive(self.label1, false)
	setActive(self.label1, true)

	self.nameTxt.text = arg_10_1.drop:getName()

	return
end

function SkinCouponMsgBox:UpdateItem(arg_11_1)
	updateDrop(self.leftItemTr, arg_11_1.drop)

	return
end

function SkinCouponMsgBox:Hide()
	self.settings = nil

	SkinCouponMsgBox.super.Hide(self)
	self:Destroy()

	return
end

function SkinCouponMsgBox:OnDestroy()
	return
end

return SkinCouponMsgBox
