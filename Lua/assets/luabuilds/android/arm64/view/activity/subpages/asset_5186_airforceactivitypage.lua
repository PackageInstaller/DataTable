local AirForceActivityPage = class("AirForceActivityPage", import("view.base.BaseActivityPage"))

function AirForceActivityPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnBattle = self.bg:Find("battle_btn")
	self.iconAward = self.bg:Find("award")
	self.iconGot = self.bg:Find("got_btn")
	self.textStep = self.bg:Find("step")
	self.textCount = self.bg:Find("count")
	self.items = self.bg:Find("items")
	self.blur = self._tf:Find("Blur")
	self.window = self.blur:Find("window")
	self.textTitle = self.window:Find("title")
	self.textContent = self.window:Find("content")

	setActive(self.blur, false)

	return
end

function AirForceActivityPage:OnDataSetting()
	self.linkActivity = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").linkActID)
	self.taskIds = self.linkActivity:getConfig("config_data")

	local var_2_0 = _.map(self.taskIds, function(arg_3_0)
		local var_3_0 = getProxy(TaskProxy):getTaskVO(arg_3_0)

		var_3_0 = var_3_0 or Task.New({
			id = arg_3_0
		})

		return var_3_0
	end)

	self.summaryTask = _.detect(var_2_0, function(arg_4_0)
		return arg_4_0:getConfig("sub_type") == 90
	end)
	self.subTasks = _.select(var_2_0, function(arg_5_0)
		return arg_5_0:getConfig("sub_type") ~= 90
	end)

	return
end

function AirForceActivityPage:TrySubmitTask()
	if not self.summaryTask then
		return
	end

	if self.summaryTask:isFinish() and not self.summaryTask:isReceive() then
		pg.m02:sendNotification(GAME.SUBMIT_TASK, self.summaryTask.id)

		return true
	end

	return
end

function AirForceActivityPage:OnFirstFlush()
	onButton(self, self.btnBattle, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.AIRFORCE_DRAGONEMPERY)

		return
	end, SFX_PANEL)
	onButton(self, self.blur, function()
		self:CloseWindow()
		self:TrySubmitTask()

		return
	end)

	for iter_7_0 = 1, #self.subTasks do
		onButton(self, self.items:GetChild(iter_7_0 - 1), function()
			if not self.subTasks[iter_7_0]:isReceive() then
				pg.m02:sendNotification(GAME.SUBMIT_TASK, self.subTasks[iter_7_0].id)
			end

			setText(self.textTitle, i18n("airforce_title_" .. iter_7_0))
			setText(self.textContent, i18n("airforce_desc_" .. iter_7_0))
			pg.UIMgr.GetInstance():OverlayPanel(self.blur, {
				pbList = {
					self.blur
				}
			})
			setActive(self.blur, true)

			return
		end, SFX_PANEL)
	end

	local var_7_0 = self.summaryTask:getConfig("award_display")[1]
	local var_7_1 = Drop.New({
		type = var_7_0[1],
		id = var_7_0[2],
		count = var_7_0[3]
	})

	updateDrop(self.iconAward, var_7_1)
	onButton(self, self.iconAward, function()
		self:emit(BaseUI.ON_DROP, var_7_1)

		return
	end, SFX_PANEL)
	self:TrySubmitTask()

	return
end

function AirForceActivityPage:OnUpdateFlush()
	local var_12_0 = 0

	for iter_12_0 = 1, #self.subTasks do
		local var_12_1 = self.subTasks[iter_12_0]:isReceive()

		setActive(self.items:GetChild(iter_12_0 - 1):Find("viewed"), var_12_1)

		if var_12_1 then
			var_12_0 = var_12_0 + 1
		end
	end

	setText(self.textStep, var_12_0 .. "/" .. #self.subTasks)
	setText(self.textCount, self:GetFightCount())
	setActive(self.iconGot, self.summaryTask:isReceive())
	setActive(self.btnBattle:Find("tip"), self.activity:readyToAchieve())

	return
end

function AirForceActivityPage:GetFightCount()
	local var_13_0 = 0

	for iter_13_0 = 1, self.activity:GetLevelCount() do
		var_13_0 = var_13_0 + (self.activity:getKVPList(1, iter_13_0) or 0)
	end

	local var_13_1 = pg.TimeMgr.GetInstance()

	return math.min((var_13_1:DiffDay(self.activity.data1, var_13_1:GetServerTime()) + 1) * self.activity:GetPerDayCount(), (self.activity:GetMaxProgress())) - var_13_0
end

function AirForceActivityPage:CloseWindow()
	setActive(self.blur, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.blur, self._tf)

	return
end

function AirForceActivityPage:ShowOrHide(arg_15_1)
	if not arg_15_1 and isActive(self.blur) then
		self:CloseWindow()
	end

	AirForceActivityPage.super.ShowOrHide(self, arg_15_1)

	return
end

function AirForceActivityPage:OnDestroy()
	if isActive(self.blur) then
		self:CloseWindow()
	end

	AirForceActivityPage.super.OnDestroy(self)

	return
end

return AirForceActivityPage
