local AnimeMidtermLoginPage = class("AnimeMidtermLoginPage", import(".TemplatePage.LoginTemplatePage"))

function AnimeMidtermLoginPage:OnInit()
	self.dayProgressImg = self._tf:Find("DayProgress")
	self.awardImg = self._tf:Find("Award")
	self.maskImg = self.awardImg:Find("Mask")

	addSlip(SLIP_TYPE_HRZ, self.awardImg, function()
		if self.curShowDay > 1 then
			triggerButton(self.arrowLeft)
		end

		return
	end, function()
		if self.curShowDay < self.allDaycount then
			triggerButton(self.arrowRight)
		end

		return
	end)

	self.arrowLeft = self._tf:Find("ArrowLeft")
	self.arrowRight = self._tf:Find("ArrowRight")

	onButton(self, self.arrowLeft, function()
		self.curShowDay = self.curShowDay - 1

		self:updateAwardInfo(self.curShowDay)

		return
	end, SFX_PANEL)
	onButton(self, self.arrowRight, function()
		self.curShowDay = self.curShowDay + 1

		self:updateAwardInfo(self.curShowDay)

		return
	end, SFX_PANEL)

	self.pointTpl = self._tf:Find("Point")
	self.pointContainer = self._tf:Find("PointList")
	self.pointUIItemList = UIItemList.New(self.pointContainer, self.pointTpl)

	self.pointUIItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			arg_6_1 = arg_6_1 + 1

			local var_6_0 = arg_6_2:Find("Selected")

			if arg_6_1 <= self.nday then
				setImageAlpha(arg_6_2, 1)
			else
				setImageAlpha(arg_6_2, 0.3)
			end

			setActive(var_6_0, arg_6_1 == self.curShowDay)
		end

		return
	end)

	self.loader = AutoLoader.New()

	return
end

function AnimeMidtermLoginPage:OnDataSetting()
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]
	self.allDaycount = #self.config.front_drops
	self.nday = self.activity.data1
	self.curShowDay = self.nday

	return
end

function AnimeMidtermLoginPage:OnFirstFlush()
	return
end

function AnimeMidtermLoginPage:OnUpdateFlush()
	self.nday = self.activity.data1
	self.curShowDay = self.nday

	self:updateAwardInfo(self.curShowDay)

	return
end

function AnimeMidtermLoginPage:OnDestroy()
	self.loader:Clear()

	return
end

function AnimeMidtermLoginPage:updateAwardInfo(arg_11_1)
	arg_11_1 = math.max(arg_11_1, 1)

	self.loader:GetOffSpriteRequest(self.dayProgressImg)
	self.loader:GetOffSpriteRequest(self.awardImg)
	self.loader:GetSprite("ui/activityuipage/animelogin_atlas", "tianshu_" .. arg_11_1, self.dayProgressImg, true)
	self.loader:GetSprite("ui/activityuipage/animemidtermloginpage_atlas", "icon_" .. arg_11_1, self.awardImg, true)
	setActive(self.maskImg, arg_11_1 <= self.nday)
	setActive(self.arrowLeft, arg_11_1 ~= 1)
	setActive(self.arrowRight, arg_11_1 ~= self.allDaycount)
	self.pointUIItemList:align(self.allDaycount)

	return
end

return AnimeMidtermLoginPage
