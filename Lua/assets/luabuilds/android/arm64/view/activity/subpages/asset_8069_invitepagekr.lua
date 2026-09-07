local InvitePageKR = class("InvitePageKR", import(".TemplatePage.LoginTemplatePage"))

function InvitePageKR:OnInit()
	self.AD = self._tf:Find("AD")
	self.btnGroup = self.AD:Find("btn_list")
	self.btnClick = self.btnGroup:Find("click")
	self.btnGet = self.btnGroup:Find("get")
	self.btnGot = self.btnGroup:Find("got")
	self.redpoint = self.btnGroup:Find("red")
	self.showList = self.AD:Find("show_list")
	self.progress = self.showList:Find("progress")
	self.tabCount = tf(self.progress).childCount
	self.tabsList = {}

	table.insert(self.tabsList, self.progress:Find("item"))

	for iter_1_0 = 1, 6 do
		table.insert(self.tabsList, self.progress:Find("item_" .. iter_1_0))
	end

	self.award = self.showList:Find("award")
	self.gotAward = self.award:Find("got")

	return
end

function InvitePageKR:OnFirstFlush()
	self.nday = self.activity.data1

	self:RefreshTab()
	warning("First是第几次签到" .. self.nday)
	onButton(self, self.btnClick, function()
		if self.activity:readyToAchieve() == false then
			return
		end

		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnGet, function()
		if self.activity:readyToAchieve() == false then
			return
		end

		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_CONFIRM)

	return
end

function InvitePageKR:OnUpdateFlush()
	self.nday = self.activity.data1

	warning("update是第几次签到" .. self.nday)
	self:RefreshTab()

	local var_5_0 = self.activity:readyToAchieve()

	setActive(self.redpoint, var_5_0)
	setActive(self.btnClick, self.nday <= self.tabCount - 1)
	setGray(self.btnClick, not var_5_0 and not finsh)
	setActive(self.btnGot, self.nday >= self.tabCount)
	setActive(self.gotAward, self.nday >= self.tabCount)
	self:lastDayShow(var_5_0)

	return
end

function InvitePageKR:OnDestroy()
	return
end

function InvitePageKR:lastDayShow(arg_7_1)
	if self.nday == 6 and arg_7_1 then
		setActive(self.tabsList[7], true)
		setActive(self.btnGet, true)

		return
	end

	setActive(self.btnGet, false)

	return
end

function InvitePageKR:RefreshTab()
	for iter_8_0 = 1, self.tabCount do
		setActive(self.tabsList[iter_8_0], iter_8_0 <= self.nday)
	end

	return
end

return InvitePageKR
