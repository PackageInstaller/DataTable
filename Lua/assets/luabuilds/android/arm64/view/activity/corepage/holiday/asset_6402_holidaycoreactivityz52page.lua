local HolidayCoreActivityZ52Page = class("HolidayCoreActivityZ52Page", import("view.activity.CorePage.CoreActivityPage"))

function HolidayCoreActivityZ52Page:OnInit()
	self.progTF = self._tf:Find("bg/prog")
	self.btnLock = self._tf:Find("bg/btnLock")
	self.lock = self.btnLock:Find("lock")
	self.btnGo = self._tf:Find("bg/btnGo")
	self.btnSign = self._tf:Find("bg/btnSign")
	self.tipSign = self.btnSign:Find("tip")
	self.remainTimes = self.btnSign:Find("remainTimes")
	self.prog = {}

	for iter_1_0 = 1, self.progTF.childCount do
		self.prog[iter_1_0] = self:createProg(self.progTF:Find("prog_" .. iter_1_0))
	end

	return
end

function HolidayCoreActivityZ52Page:OnDataSetting()
	self.curDay = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.preStory = self.activity:getConfig("config_client").preStory

	return updateActivityTaskStatus(self.activity)
end

function HolidayCoreActivityZ52Page:OnFirstFlush()
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
	onButton(self, self.btnGo, function()
		if self:isTargetLocking() then
			return
		end

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.MALL_MAP)

		return
	end, SFX_PANEL)
	setText(self.lock, i18n("20260514_story_unlock_tip"))

	return
end

function HolidayCoreActivityZ52Page:OnUpdateFlush()
	self.curDay = self.activity.data3
	self.enableSign = false

	local var_8_0 = self:isAllSigned()
	local var_8_1 = self:isTargetLocking()

	setActive(self.btnSign, not var_8_0)
	setActive(self.btnLock, var_8_1 and var_8_0)
	setActive(self.btnGo, not var_8_1 and var_8_0)

	if not var_8_0 then
		self.curTaskVO = self.taskProxy:getTaskById(self.taskGroup[self.curDay]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.curDay])
		self.remain = math.max(math.min(self.activity:getDayIndex(), #self.taskGroup) - self.curDay, 0)

		if self.curTaskVO:getTaskStatus() == 1 then
			self.remain = self.remain + 1
		end

		self.enableSign = self.remain > 0

		setText(self.remainTimes, self.remain)
	end

	local var_8_2

	if self.enableSign then
		var_8_2 = self.curDay - 1 or self.curDay
	end

	for iter_8_0 = 1, var_8_2 do
		local var_8_3 = self.prog[iter_8_0]

		setActive(self.prog[iter_8_0].signed, iter_8_0 <= var_8_2)
		setActive(var_8_3.current, iter_8_0 == var_8_2 and not var_8_0)
	end

	setActive(self.tipSign, self.enableSign)
	setGray(self.btnSign, not self.enableSign, true)

	return
end

function HolidayCoreActivityZ52Page:createProg(arg_9_1)
	local var_9_0 = {
		current = arg_9_1:Find("current"),
		signed = arg_9_1:Find("signed")
	}

	setActive(var_9_0.current, false)
	setActive(var_9_0.signed, false)

	return var_9_0
end

function HolidayCoreActivityZ52Page:getTargetID()
	return 50619
end

function HolidayCoreActivityZ52Page:isTargetLocking()
	local var_11_0 = getProxy(ActivityProxy):getActivityById(self:getTargetID())

	return not var_11_0 or var_11_0:isEnd()
end

function HolidayCoreActivityZ52Page:isAllSigned()
	local var_12_0 = self.taskProxy:getTaskById(self.taskGroup[#self.taskGroup]) or self.taskProxy:getFinishTaskById(self.taskGroup[#self.taskGroup])

	return var_12_0 and var_12_0:getTaskStatus() == 2
end

return HolidayCoreActivityZ52Page
