local RefluxLetterView = class("RefluxLetterView", import("..base.BaseSubView"))

function RefluxLetterView:getUIName()
	return "RefluxLetterUI"
end

function RefluxLetterView:OnInit()
	self:initData()
	self:initUI()
	self:updateUI()

	return
end

function RefluxLetterView:OnDestroy()
	return
end

function RefluxLetterView:OnBackPress()
	self:Hide()

	if self.closeCB then
		self.closeCB()
	end

	return
end

function RefluxLetterView:initData()
	self.refluxProxy = getProxy(RefluxProxy)

	return
end

function RefluxLetterView:initUI()
	local var_6_0 = self._tf:Find("billboard")

	self.billboardTF = var_6_0
	self.yearText = var_6_0:Find("year")
	self.monthText = var_6_0:Find("month")
	self.dateText = var_6_0:Find("date")
	self.daysText = var_6_0:Find("days")
	self.countText = var_6_0:Find("count")
	self.shareBtn = var_6_0:Find("btn_share")

	setActive(self.shareBtn, false)
	onButton(self, self.billboardTF, function()
		self:OnBackPress()

		return
	end, SFX_PANEL)

	return
end

function RefluxLetterView:updateUI()
	local var_8_0 = pg.TimeMgr.GetInstance()
	local var_8_1 = var_8_0:STimeDescS(self.refluxProxy.returnLastTimestamp, "*t")

	setText(self.yearText, var_8_1.year % 100)
	setText(self.monthText, var_8_1.month)
	setText(self.dateText, var_8_1.day)
	setText(self.daysText, var_8_0:DiffDay(self.refluxProxy.returnLastTimestamp, self.refluxProxy.returnTimestamp))
	setText(self.countText, self.refluxProxy.returnShipNum)

	return
end

function RefluxLetterView:setCloseFunc(arg_9_1)
	self.closeCB = arg_9_1

	return
end

return RefluxLetterView
