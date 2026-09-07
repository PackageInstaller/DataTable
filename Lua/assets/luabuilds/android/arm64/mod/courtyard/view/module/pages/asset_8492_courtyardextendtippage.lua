local CourtYardExtendTipPage = class("CourtYardExtendTipPage", import(".CourtYardBaseSubPage"))

function CourtYardExtendTipPage:getUIName()
	return "CourtYardExtendTipUI"
end

function CourtYardExtendTipPage:OnLoaded()
	self.valueTxt = findTF(self._tf, "frame/tip_2/value_bg/Text")
	self.text1 = findTF(self._tf, "frame/tip_1/text_1")
	self.text2 = findTF(self._tf, "frame/tip_1/value_bg/Text")
	self.text3 = findTF(self._tf, "frame/tip_1/text_2")
	self.text4 = findTF(self._tf, "frame/tip_2/text_1")
	self.text5 = findTF(self._tf, "frame/tip_2/text_2")
	self.itemTF = findTF(self._tf, "frame")
	self.okBtn = findTF(self._tf, "frame/ok_btn")
	self.cancelBtn = findTF(self._tf, "frame/cancel_btn")
	self.closeBtn = findTF(self._tf, "frame/close")
	self._parent = self._tf.parent

	setText(self.okBtn:Find("Text"), i18n("word_ok"))
	setText(self.cancelBtn:Find("Text"), i18n("word_cancel"))
	setText(self._tf:Find("frame/tip_1/text_1"), i18n("backyard_extend_tip_1"))
	setText(self._tf:Find("frame/tip_1/text_2"), i18n("backyard_extend_tip_2"))
	setText(self._tf:Find("frame/tip_2/text_1"), i18n("backyard_extend_tip_3"))
	setText(self._tf:Find("frame/tip_2/text_2"), i18n("backyard_extend_tip_4"))
	setText(self._tf:Find("frame/title"), i18n("words_information"))

	return
end

function CourtYardExtendTipPage:OnInit()
	onButton(self, self.okBtn, function()
		self:Emit("Extend")
		self:Hide()

		return
	end, SFX_CONFIRM)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function CourtYardExtendTipPage:Show()
	local var_8_0 = getProxy(BagProxy):getItemById(ITEM_BACKYARD_AREA_EXTEND)
	local var_8_1

	if not var_8_0 then
		var_8_0 = Item.New({
			count = 0,
			id = ITEM_BACKYARD_AREA_EXTEND
		})
		var_8_1 = {}
	end

	for iter_8_0, iter_8_1 in ipairs(string.split(i18n("backyard_extendArea_tip", 1, var_8_0.count), "||")) do
		var_8_1["text" .. iter_8_0] = iter_8_1
	end

	setActive(self._tf, true)

	local var_8_2 = {
		type = DROP_TYPE_ITEM,
		id = var_8_0.id
	}

	setText(self.text1, var_8_1.text1)
	setText(self.text2, setColorStr(var_8_1.text2, "#72bc42"))
	setText(self.text3, var_8_1.text3)
	setText(self.text4, var_8_1.text4)
	setText(self.valueTxt, tonumber(var_8_0.count) <= 0 and setColorStr(var_8_0.count, COLOR_RED) or setColorStr(var_8_0.count, "#72bc42"))
	setText(self.text5, var_8_1.text6)
	updateDrop(self.itemTF, var_8_2)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	self.showing = true

	return
end

function CourtYardExtendTipPage:Hide()
	if self.showing == true then
		self.showing = false

		setActive(self._tf, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parent)
	end

	return
end

function CourtYardExtendTipPage:OnDestroy()
	self:Hide()

	return
end

return CourtYardExtendTipPage
