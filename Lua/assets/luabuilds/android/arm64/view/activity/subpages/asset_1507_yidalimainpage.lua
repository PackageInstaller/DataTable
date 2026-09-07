local YidaliMainPage = class("YidaliMainPage", import(".TemplatePage.PreviewTemplatePage"))

function YidaliMainPage:OnInit()
	YidaliMainPage.super.OnInit(self)
	self:initUI()

	return
end

function YidaliMainPage:OnFirstFlush()
	YidaliMainPage.super.OnFirstFlush(self)

	self.fight = self.btnList:Find("fight")

	onButton(self, self.fight, function()
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)

	self.build = self.btnList:Find("build")

	onButton(self, self.build, function()
		local var_4_0
		local var_4_1

		if self.activity:getConfig("config_client") ~= "" then
			var_4_0 = self.activity:getConfig("config_client").linkActID

			if var_4_0 then
				var_4_1 = getProxy(ActivityProxy):getActivityById(var_4_0)
			end
		end

		if not var_4_0 then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})
		elseif var_4_1 and not var_4_1:isEnd() then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	self:initData()
	self:submitFinishedTask()

	return
end

function YidaliMainPage:OnUpdateFlush()
	self:updateAwardBtn()

	return
end

function YidaliMainPage:initData()
	self.finalTaskID = self.activity:getConfig("config_client")[1]
	self.YDLtaskIDList = self.activity:getConfig("config_data")
	self.taskIDList = Clone(pg.task_data_template[self.finalTaskID].target_id)
	self.taskProxy = getProxy(TaskProxy)

	return
end

function YidaliMainPage:initUI()
	self.awardTF = self.bg:Find("Item")
	self.activeTF = self.awardTF:Find("Active")
	self.finishedTF = self.awardTF:Find("Finished")
	self.achievedTF = self.awardTF:Find("Achieved")

	setActive(self.activeTF, false)
	setActive(self.finishedTF, false)
	setActive(self.achievedTF, false)

	self.achievementBtn = self.bg:Find("AchieveMentBtn")
	self.subViewContainer = self._tf:Find("SubViewContainer")

	return
end

function YidaliMainPage:updateAwardBtn()
	local var_8_0 = self:getFinalTaskStatus()

	print("final taskid:" .. self.finalTaskID)
	print("task status:" .. var_8_0)

	if var_8_0 == 0 then
		setActive(self.activeTF, true)
		setActive(self.finishedTF, false)
		setActive(self.achievedTF, false)
	elseif var_8_0 == 1 then
		setActive(self.activeTF, false)
		setActive(self.finishedTF, true)
		setActive(self.achievedTF, false)
		onButton(self, self.awardTF, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, (self.taskProxy:getTaskVO(self.finalTaskID)))

			return
		end, SFX_PANEL)
	elseif var_8_0 == 2 then
		setActive(self.activeTF, false)
		setActive(self.finishedTF, false)
		setActive(self.achievedTF, true)
		onButton(self, self.awardTF, function()
			return
		end, SFX_PANEL)
	end

	return
end

function YidaliMainPage:submitFinishedTask()
	for iter_11_0, iter_11_1 in ipairs(self.YDLtaskIDList) do
		local var_11_0 = self.taskProxy:getTaskById(iter_11_1)

		if var_11_0 and var_11_0:isFinish() and not var_11_0:isReceive() then
			print("!!!!!!!!!!!!!20190907!!!!!!!YDLtaskIDList emit:" .. iter_11_1)
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_11_0)
		end
	end

	return
end

function YidaliMainPage:getFinalTaskStatus()
	return self.taskProxy:getTaskVO(self.finalTaskID):getTaskStatus()
end

return YidaliMainPage
