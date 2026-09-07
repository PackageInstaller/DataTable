local NewNavalTacticsUnlockSlotPage = class("NewNavalTacticsUnlockSlotPage", import("....base.BaseSubView"))

function NewNavalTacticsUnlockSlotPage:getUIName()
	return "NewNavalTacticsUnlockSlotPage"
end

function NewNavalTacticsUnlockSlotPage:OnLoaded()
	self.contentTxt = self._tf:Find("content/Text"):GetComponent(typeof(Text))
	self.discountDateTxt = self._tf:Find("content/discountDate"):GetComponent(typeof(Text))
	self.discountTxt = self._tf:Find("content/discountInfo/Text"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("content/confirm_btn")
	self.cancelBtn = self._tf:Find("content/cancel_btn")
	self.closeBtn = self._tf:Find("content/btnBack")

	setText(self.confirmBtn:Find("pic"), i18n("word_ok"))
	setText(self.cancelBtn:Find("pic"), i18n("word_cancel"))

	return
end

function NewNavalTacticsUnlockSlotPage:OnInit()
	onButton(self, self.confirmBtn, function()
		if self.callback then
			self.callback()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function NewNavalTacticsUnlockSlotPage:Show(arg_8_1, arg_8_2)
	NewNavalTacticsUnlockSlotPage.super.Show(self)

	self.callback = arg_8_2

	local var_8_0 = CommonCommodity.New({
		id = arg_8_1
	}, Goods.TYPE_SHOPSTREET)

	self:Flush(var_8_0)

	self.commodity = var_8_0

	return
end

function NewNavalTacticsUnlockSlotPage:Flush(arg_9_1)
	self:RemoveTimer()

	local var_9_0 = arg_9_1:isDisCount()

	if var_9_0 then
		self:UpdateDiscountView(arg_9_1)
	else
		self.contentTxt.text = i18n("open_skill_pos", (arg_9_1:GetPrice()))
	end

	setActive(self.discountDateTxt.gameObject, var_9_0)
	setActive(self.discountTxt.gameObject.transform.parent, var_9_0)

	return
end

function NewNavalTacticsUnlockSlotPage:UpdateDiscountView(arg_10_1)
	local var_10_0, var_10_1 = arg_10_1:GetPrice()

	self:AddTimer((arg_10_1:GetDiscountEndTime()))

	self.discountTxt.text = var_10_1 .. "%"
	self.contentTxt.text = i18n("open_skill_pos_discount", arg_10_1:getConfig("resource_num"), var_10_0)

	onNextTick(function()
		local var_11_0 = self.contentTxt.gameObject.transform:GetChild(self.contentTxt.gameObject.transform.childCount - 1)

		if not IsNil(var_11_0) then
			setAnchoredPosition(var_11_0, {
				y = var_11_0.anchoredPosition.y + 15
			})
		end

		return
	end)

	return
end

function NewNavalTacticsUnlockSlotPage:AddTimer(arg_12_1)
	self.timer = Timer.New(function()
		local var_13_0 = arg_12_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_13_0 <= 0 then
			self.discountDateTxt.text = ""

			self:Flush(self.commodity)
		else
			local var_13_1 = i18n("discount_time", self:WarpDateTip(var_13_0) .. i18n("word_date"))

			if var_13_1 ~= self.str then
				self.discountDateTxt.text = var_13_1
				self.str = var_13_1
			end
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function NewNavalTacticsUnlockSlotPage:WarpDateTip(arg_14_1)
	return arg_14_1 >= 0 and math.floor(arg_14_1 / 0) or arg_14_1 >= 3600 and math.floor(arg_14_1 / 16) or math.floor(arg_14_1 / 60)
end

function NewNavalTacticsUnlockSlotPage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function NewNavalTacticsUnlockSlotPage:Hide()
	self:RemoveTimer()
	NewNavalTacticsUnlockSlotPage.super.Hide(self)

	self.callback = nil
	self.commodity = nil

	return
end

function NewNavalTacticsUnlockSlotPage:OnDestroy()
	self:Hide()

	return
end

return NewNavalTacticsUnlockSlotPage
