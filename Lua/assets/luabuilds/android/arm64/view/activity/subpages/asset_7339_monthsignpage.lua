local MonthSignPage = class("MonthSignPage", import("...base.BaseActivityPage"))

MonthSignPage.SHOW_RE_MONTH_SIGN = "show re month sign award"
MonthSignPage.MILESTONE_SPECIAL_DATA = "month_sign_milestone_day"
MonthSignPage.MONTH_SIGN_SHOW = {}
MonthSignPage.MONTH_SIGN_SP_DAYS = {
	30,
	60,
	120,
	240,
	300
}

function MonthSignPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.items = self._tf:Find("items")
	self.item = self.items:Find("item")
	self.spDay = self._tf:Find("sp_day")
	self.spDayEffects = {}
	self.monthSignReSignUI = MonthSignReSignUI.New(self._tf, self.event, nil)

	self:bind(MonthSignPage.SHOW_RE_MONTH_SIGN, function(arg_2_0, arg_2_1, arg_2_2)
		if not self.monthSignReSignUI:GetLoaded() then
			self.monthSignReSignUI:Load()
		end

		self.monthSignReSignUI:ActionInvoke("setAwardShow", arg_2_1, arg_2_2)

		return
	end)

	for iter_1_0, iter_1_1 in ipairs(MonthSignPage.MONTH_SIGN_SP_DAYS) do
		local var_1_0 = self.spDay:Find(iter_1_1 .. "days")

		self.spDayEffects[iter_1_1] = var_1_0

		setActive(var_1_0, false)
	end

	setActive(self.spDay, false)
	setText(self._tf:Find("login/Text"), i18n("yearly_sign_in"))
	setText(self._tf:Find("login/count/Text"), i18n("word_date"))

	return
end

function MonthSignPage:OnDataSetting()
	self.config = pg.activity_month_sign[self.activity.data2]

	if not self.config then
		return true
	end

	self.monthDays = pg.TimeMgr.GetInstance():CalcMonthDays(self.activity.data1, self.activity.data2)

	if tonumber(pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "%m")) == pg.activity_template[ActivityConst.MONTH_SIGN_ACTIVITY_ID].config_client[1] then
		self.specialTag = true
		self.specialDay = pg.activity_template[ActivityConst.MONTH_SIGN_ACTIVITY_ID].config_client[2]
		self.isShowFrame = pg.activity_template[ActivityConst.MONTH_SIGN_ACTIVITY_ID].config_client[3]
	end

	return
end

function MonthSignPage:OnFirstFlush()
	self.list = UIItemList.New(self.items, self.item)

	self.list:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = arg_5_1 + 1
			local var_5_1 = _.map(self.config["day" .. arg_5_1 + 1], function(arg_6_0)
				return Drop.Create(arg_6_0)
			end)

			updateDrop(arg_5_2, var_5_1[1])
			onButton(self, arg_5_2, function()
				if #var_5_1 == 1 then
					self:emit(BaseUI.ON_DROP, var_5_1[1])
				else
					self:emit(BaseUI.ON_DROP_LIST, {
						content = "",
						item2Row = true,
						itemList = var_5_1
					})
				end

				return
			end, SFX_PANEL)
			setText(arg_5_2:Find("day/Text"), "Day " .. var_5_0)
			setActive(arg_5_2:Find("got"), var_5_0 <= #self.activity.data1_list)
			setActive(arg_5_2:Find("today"), var_5_0 == #self.activity.data1_list)

			if self.specialTag and var_5_0 == self.specialDay then
				local var_5_2 = arg_5_2:Find("icon_bg/SpecialFrame")

				if self.isShowFrame == 1 then
					setActive(var_5_2, false)
				else
					setActive(var_5_2, true)
				end
			end
		end

		return
	end)
	self:UpdateLoginInfo()

	return
end

function MonthSignPage:OnUpdateFlush()
	if self:isDirtyRes() then
		return
	end

	self:UpdateLoginInfo()
	self.list:align(self.monthDays)

	if self.specialTag then
		setText(self._tf:Find("DayNumText"), (self.specialDay - #self.activity.data1_list < 0 or nil) and 0)

		GetComponent(self._tf:Find("ProgressBar"), "Slider").value = #self.activity.data1_list
	end

	local var_8_1 = self.activity:getSpecialData("month_sign_awards")

	if var_8_1 and #var_8_1 > 0 then
		local var_8_2 = getProxy(PlayerProxy):getPlayerId()

		if not table.contains(MonthSignPage.MONTH_SIGN_SHOW, self.activity.id .. ":" .. var_8_2) then
			table.insert(MonthSignPage.MONTH_SIGN_SHOW, self.activity.id .. ":" .. var_8_2)

			if not self.monthSignReSignUI:GetLoaded() then
				self.monthSignReSignUI:Load()
			end

			self.monthSignReSignUI:ActionInvoke("setAwardShow", var_8_1)
		elseif self.monthSignReSignUI then
			self.monthSignReSignUI:ActionInvoke("setAwardShow", var_8_1)
		end
	end

	return
end

function MonthSignPage:showReMonthSign()
	return
end

function MonthSignPage:OnDestroy()
	if self.spEffectLT then
		LeanTween.cancel(self.spEffectLT)

		self.spEffectLT = nil
	end

	removeAllChildren(self.items)

	self.monthSignPageTool = nil

	self.monthSignReSignUI:Destroy()

	self.monthSignReSignUI = nil

	return
end

function MonthSignPage:UseSecondPage(arg_11_1)
	return tonumber(pg.TimeMgr.GetInstance():CurrentSTimeDesc("%m", true)) == pg.activity_template[arg_11_1.id].config_client[1]
end

function MonthSignPage:isDirtyRes()
	if self.specialTag and self:getUIName() ~= self.activity:getConfig("page_info").ui_name2 then
		return true
	end

	return
end

function MonthSignPage:UpdateLoginInfo()
	local var_13_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOGIN_RECORD)
	local var_13_1 = self._tf:Find("login")

	setActive(var_13_1, var_13_0 and not var_13_0:isEnd())

	if var_13_0 and not var_13_0:isEnd() then
		local var_13_2, var_13_3, var_13_4 = unpack(var_13_0:getConfig("time"))

		setText(var_13_1:Find("month"), string.format("%02d/%02d/%02d-%02d/%02d/%02d", var_13_3[1][1] % 100, var_13_3[1][2], var_13_3[1][3], var_13_4[1][1] % 100, var_13_4[1][2], var_13_4[1][3]))
		setText(var_13_1:Find("count/day"), var_13_0:getData1())
	end

	return
end

function MonthSignPage:TryShowSpEffect(arg_14_1)
	local var_14_0 = self.spDayEffects[self.activity:getSpecialData(MonthSignPage.MILESTONE_SPECIAL_DATA)]

	self.activity:setSpecialData(MonthSignPage.MILESTONE_SPECIAL_DATA, nil)
	setActive(self.spDay, true)

	if self.spEffectLT then
		LeanTween.cancel(self.spEffectLT)

		self.spEffectLT = nil
	end

	setActive(var_14_0, true)

	self.spEffectLT = LeanTween.value(go(var_14_0), 0, 1, (self:GetEffectLeftTime((var_14_0:Find("heidi"):GetComponent(typeof("UnityEngine.ParticleSystem")))))):setOnComplete(System.Action(function()
		self.spEffectLT = nil

		self:HideSPEffect(arg_14_1)

		return
	end)).uniqueId

	return
end

function MonthSignPage:GetEffectLeftTime(arg_16_1)
	return arg_16_1.main.startDelay.constantMax + arg_16_1.main.duration + arg_16_1.main.startLifetime.constantMax
end

function MonthSignPage:HideSPEffect(arg_17_1)
	for iter_17_0, iter_17_1 in pairs(self.spDayEffects) do
		if iter_17_1 then
			setActive(iter_17_1, false)
		end
	end

	setActive(self.spDay, false)
	existCall(arg_17_1)

	return
end

function MonthSignPage:ShouldPlaySpEffect()
	if not self then
		return false
	end

	if self:getConfig("type") ~= ActivityConst.ACTIVITY_TYPE_MONTHSIGN then
		return false
	end

	local var_18_0 = self:getSpecialData(MonthSignPage.MILESTONE_SPECIAL_DATA)

	return var_18_0 and table.contains(MonthSignPage.MONTH_SIGN_SP_DAYS, var_18_0)
end

return MonthSignPage
