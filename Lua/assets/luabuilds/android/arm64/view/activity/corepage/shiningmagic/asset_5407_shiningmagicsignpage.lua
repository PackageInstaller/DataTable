local ShiningMagicSignPage = class("ShiningMagicSignPage", import("view.activity.CorePage.CoreActivityPage"))

function ShiningMagicSignPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.daysTF = self.bg:Find("days")
	self.btnSign = self.bg:Find("btn_sign")
	self.remainTimes = self.btnSign:Find("remainTimes")
	self.tipSign = self.btnSign:Find("tip")
	self.btnSigned = self.bg:Find("btn_sign_gray")
	self.btnSignedAll = self.bg:Find("btn_sign_gray_all")
	self.days = {}

	for iter_1_0 = 1, self.daysTF.childCount do
		self.days[iter_1_0] = self:initDayTpl(self.daysTF:Find("day_" .. iter_1_0))
	end

	return
end

function ShiningMagicSignPage:OnDataSetting()
	self.curDay = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.preStory = self.activity:getConfig("config_client").preStory

	return updateActivityTaskStatus(self.activity)
end

function ShiningMagicSignPage:OnFirstFlush()
	onButton(self, self.btnSign, function()
		if not self.enableSign then
			return
		end

		seriesAsync({
			function(arg_5_0)
				local var_5_0 = self.activity:getConfig("config_client").story

				if checkExist(var_5_0, {
					self.curDay
				}, {
					1
				}) then
					pg.NewStoryMgr.GetInstance():Play(var_5_0[self.curDay][1], arg_5_0)
				else
					arg_5_0()
				end

				return
			end,
			function(arg_6_0)
				if self.curTaskVO and self.curTaskVO:getTaskStatus() == 1 then
					self:emit(ActivityMediator.ON_TASK_SUBMIT, self.curTaskVO, arg_6_0)
				else
					arg_6_0()
				end

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function ShiningMagicSignPage:OnUpdateFlush()
	self.curDay = self.activity.data3
	self.enableSign = false

	local var_7_0 = self:isAllSigned()

	setActive(self.btnSignedAll, var_7_0)

	if not var_7_0 then
		self.curTaskVO = self.taskProxy:getTaskById(self.taskGroup[self.curDay]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.curDay])
		self.remain = math.max(math.min(self.activity:getDayIndex(), #self.taskGroup) - self.curDay, 0)

		if self.curTaskVO:getTaskStatus() == 1 then
			self.remain = self.remain + 1
		end

		self.enableSign = self.remain > 0

		setText(self.remainTimes, i18n("shiningmagicsignpage_sign_remain") .. "  " .. self.remain)
	end

	local var_7_1

	if self.enableSign then
		var_7_1 = self.curDay - 1 or self.curDay
	end

	for iter_7_0 = 1, var_7_1 do
		setActive(self.days[iter_7_0].signed, iter_7_0 <= var_7_1)
	end

	setActive(self.btnSign, self.enableSign)

	return
end

function ShiningMagicSignPage:initDayTpl(arg_8_1)
	local var_8_0 = {
		signed = arg_8_1:Find("on")
	}

	setActive(var_8_0.signed, false)

	return var_8_0
end

function ShiningMagicSignPage:isAllSigned()
	local var_9_0 = self.taskProxy:getTaskById(self.taskGroup[#self.taskGroup]) or self.taskProxy:getFinishTaskById(self.taskGroup[#self.taskGroup])

	return var_9_0 and var_9_0:getTaskStatus() == 2
end

return ShiningMagicSignPage
