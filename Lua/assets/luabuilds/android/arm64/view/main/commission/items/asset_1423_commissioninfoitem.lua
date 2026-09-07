local CommissionInfoItem = class("CommissionInfoItem")

function CommissionInfoItem:Ctor(arg_1_1, arg_1_2)
	self.view = arg_1_2

	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.parentTF = self._tf.parent
	self.goBtn = self._tf:Find("frame/go_btn")
	self.finishedBtn = self._tf:Find("frame/finish_btn")
	self.toggle = self._tf:Find("frame")
	self.foldFlag = self._tf:Find("frame/tip")
	self.finishedCounterContainer = self._tf:Find("frame/counter/finished")
	self.ongoingCounterContainer = self._tf:Find("frame/counter/ongoing")
	self.leisureCounterContainer = self._tf:Find("frame/counter/leisure")
	self.finishedCounter = self._tf:Find("frame/counter/finished/Text"):GetComponent(typeof(Text))
	self.ongoingCounter = self._tf:Find("frame/counter/ongoing/Text"):GetComponent(typeof(Text))
	self.leisureCounter = self._tf:Find("frame/counter/leisure/Text"):GetComponent(typeof(Text))

	local var_1_0 = self._tf:Find("list")
	local var_1_1 = var_1_0:GetChild(0)

	self.uilist = UIItemList.New(var_1_0, var_1_1)

	setActive(self.finishedCounterContainer, false)
	setActive(self.ongoingCounterContainer, false)
	setActive(self.leisureCounterContainer, false)

	if getProxy(SettingsProxy):IsMellowStyle() then
		setText(self.goBtn:Find("Image"), i18n("commission_label_go_mellow"))
		setText(self.finishedBtn:Find("Image"), i18n("commission_label_finish_mellow"))
		setText(var_1_1:Find("unlock/leisure/go_btn/Image"), i18n("commission_label_go_mellow"))
		setText(var_1_1:Find("unlock/finished/finish_btn/Image"), i18n("commission_label_finish_mellow"))
	else
		setText(self.goBtn:Find("Image"), i18n("commission_label_go"))
		setText(self.finishedBtn:Find("Image"), i18n("commission_label_finish"))
		setText(var_1_1:Find("unlock/leisure/go_btn/Image"), i18n("commission_label_go"))
		setText(var_1_1:Find("unlock/finished/finish_btn/Image"), i18n("commission_label_finish"))
	end

	self.timers = {}

	return
end

function CommissionInfoItem:Init()
	onToggle(self, self.toggle, function(arg_3_0)
		self.foldFlag.localScale = Vector3(1, arg_3_0 and -1 or 1, 1)

		if not arg_3_0 then
			return
		end

		local var_3_0, var_3_1 = self:CanOpen()

		if not var_3_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_3_1)
			triggerToggle(self._tf, false)

			return
		end

		self:Adpater()

		if not self.isInitList then
			self:UpdateList()

			self.isInitList = true
		end

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		self:OnSkip()

		return
	end, SFX_PANEL)
	onButton(self, self.finishedBtn, function()
		self:OnFinishAll()

		return
	end, SFX_PANEL)
	self.uilist:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateListItem(arg_6_1 + 1, self.list[arg_6_1 + 1], arg_6_2)
		end

		return
	end)
	self:Flush()

	return
end

function CommissionInfoItem:Adpater()
	self.parentTF.localPosition = Vector3(self.parentTF.localPosition.x, math.abs(self._tf.localPosition.y), 0)

	return
end

function CommissionInfoItem:CanOpen()
	return true
end

function CommissionInfoItem:Flush()
	if self:CanOpen() then
		self:OnFlush()
	end

	return
end

function CommissionInfoItem:Update()
	self:Flush()

	if self.isInitList then
		self:UpdateList()
	end

	return
end

function CommissionInfoItem:RemoveTimers()
	for iter_11_0, iter_11_1 in pairs(self.timers or {}) do
		iter_11_1:Stop()
	end

	self.timers = {}

	return
end

function CommissionInfoItem:UpdateList()
	self:RemoveTimers()

	local var_12_0, var_12_1 = self:GetList()

	self.uilist:align(var_12_1 or #var_12_0)

	self.list = var_12_0

	return
end

function CommissionInfoItem:OnFlush()
	return
end

function CommissionInfoItem:UpdateListItem(arg_14_1, arg_14_2, arg_14_3)
	return
end

function CommissionInfoItem:GetList()
	assert(false)

	return
end

function CommissionInfoItem:OnSkip()
	assert(false)

	return
end

function CommissionInfoItem:OnFinishAll()
	assert(false)

	return
end

function CommissionInfoItem:emit(...)
	self.view:emit(...)

	return
end

function CommissionInfoItem:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:RemoveTimers()

	return
end

return CommissionInfoItem
