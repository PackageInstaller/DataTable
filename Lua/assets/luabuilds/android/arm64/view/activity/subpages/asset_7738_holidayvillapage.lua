local HolidayVillaPage = class("HolidayVillaPage", import("view.base.BaseActivityPage"))

function HolidayVillaPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.signTF = self.bg:Find("sign")
	self.getBtn = self.signTF:Find("get")
	self.got = self.signTF:Find("got")
	self.getBtn_tip = self.signTF:Find("get/tip")
	self.countbg = self.signTF:Find("count_bg")
	self.countText = self.signTF:Find("count_bg/count")
	self.go = self.signTF:Find("go_btn")
	self.Notbtn = self.signTF:Find("Not_unlocked")
	self.list = {
		self.signTF:Find("list/unfinished_1"),
		self.signTF:Find("list/unfinished_2"),
		self.signTF:Find("list/unfinished_3"),
		self.signTF:Find("list/unfinished_4"),
		self.signTF:Find("list/unfinished_5")
	}

	setActive(self.go, false)
	setActive(self.Notbtn, false)

	return
end

function HolidayVillaPage:OnDataSetting()
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.preStory = self.activity:getConfig("config_client").preStory

	return updateActivityTaskStatus(self.activity)
end

function HolidayVillaPage:OnFirstFlush()
	onButton(self, self.getBtn, function()
		if not self.remainCnt or self.remainCnt <= 0 then
			return
		end

		seriesAsync({
			function(arg_5_0)
				local var_5_0 = self.activity:getConfig("config_client").story

				if checkExist(var_5_0, {
					self.nday
				}, {
					1
				}) then
					pg.NewStoryMgr.GetInstance():Play(var_5_0[self.nday][1], arg_5_0)
				else
					arg_5_0()
				end

				return
			end,
			function(arg_6_0)
				if self.curTaskVO:getTaskStatus() == 1 then
					self:emit(ActivityMediator.ON_TASK_SUBMIT, self.curTaskVO, arg_6_0)
				else
					arg_6_0()
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.go, function()
		if self:IsLockLiner() then
			return
		end

		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.HOLIDAY_VILLA_MAP)

		return
	end, SFX_PANEL)

	return
end

function HolidayVillaPage:OnUpdateFlush()
	self.nday = self.activity.data3

	local var_8_0 = self:IsFinishSign()

	setActive(self.got, false)
	setActive(self.go, not self:IsLockLiner() and var_8_0)
	setActive(self.Notbtn, self:IsLockLiner())

	if not var_8_0 then
		setActive(self.Notbtn, false)

		self.curTaskVO = self.taskProxy:getTaskById(self.taskGroup[self.nday]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday])
		self.remainCnt = math.min(self.activity:getDayIndex(), #self.taskGroup) - self.nday

		if self.curTaskVO:getTaskStatus() == 1 then
			self.remainCnt = self.remainCnt + 1
		end

		warning("self.remainCnt   :", self.remainCnt)
		setActive(self.getBtn_tip, self.remainCnt > 0)
		setActive(self.getBtn, self.remainCnt > 0)
		setActive(self.got, self.remainCnt == 0)
		setActive(self.countbg, true)
		setText(self.countText, i18n("liner_sign_cnt_tip") .. self.remainCnt)
	else
		setActive(self.countbg, false)
		setActive(self.getBtn, false)
	end

	for iter_8_0, iter_8_1 in ipairs(self.list) do
		setActive(self.list[iter_8_0]:Find("accomplish"), var_8_0 or iter_8_0 < self.nday)
		setImageAlpha(iter_8_1, (var_8_0 or iter_8_0 < self.nday) and 0 or 1)
		setActive(self.list[iter_8_0]:Find("Check_point"), not var_8_0 and iter_8_0 == self.nday)
	end

	return
end

function HolidayVillaPage:IsFinishSign()
	local var_9_0 = self.taskProxy:getTaskById(self.taskGroup[#self.taskGroup]) or self.taskProxy:getFinishTaskById(self.taskGroup[#self.taskGroup])

	return var_9_0 and var_9_0:getTaskStatus() == 2
end

function HolidayVillaPage:IsLockLiner()
	local var_10_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.HOLIDAY_ACT_ID)

	return not var_10_0 or var_10_0:isEnd()
end

return HolidayVillaPage
