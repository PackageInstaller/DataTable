local SecretsAbyssSkinMagazinePage = class("SecretsAbyssSkinMagazinePage", import("view.activity.CorePage.CoreActivityPage"))

function SecretsAbyssSkinMagazinePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.items = self.bg:Find("page/items")
	self.rtTask = self.bg:Find("page/task")
	self.countTF = self.rtTask:Find("count")
	self.rtAward = self.rtTask:Find("IconTpl")

	return
end

function SecretsAbyssSkinMagazinePage:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskList = self.activity:getConfig("config_data")
	self.totalCnt = #self.taskList

	return
end

local var_0_1 = 146
local var_0_2 = 540

function SecretsAbyssSkinMagazinePage:RefreshData()
	local var_3_0 = pg.TimeMgr.GetInstance()

	self.unlockCnt = (var_3_0:DiffDay(self.activity:getStartTime(), var_3_0:GetServerTime()) + 1) * self.activity:getConfig("config_id")
	self.unlockCnt = math.min(self.unlockCnt, self.totalCnt)
	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	return
end

function SecretsAbyssSkinMagazinePage:OnFirstFlush()
	self.usedCnt = self.activity:getData1()

	self:RefreshData()

	self.index = #self.taskList

	for iter_4_0 = 1, #self.taskList do
		if not self.taskProxy:getTaskVO(self.taskList[iter_4_0]):isReceive() then
			self.index = iter_4_0

			break
		end
	end

	for iter_4_1 = 1, self.items.childCount do
		local var_4_0 = self.items:GetChild(iter_4_1 - 1)

		if iter_4_1 == self.index then
			var_4_0:GetComponent(typeof(LayoutElement)).preferredWidth = var_0_2 or var_0_1
		end

		setImageAlpha(var_4_0:Find("window/Image"), iter_4_1 == self.index and 0 or 1)
		setImageAlpha(var_4_0:Find("window/main"), 1)
		onButton(self, var_4_0, function()
			self:SelectPage(iter_4_1)

			return
		end, SFX_PANEL)
	end

	local var_4_1 = {}

	var_4_1.type, var_4_1.id, var_4_1.count = unpack(self.taskProxy:getTaskVO(self.taskList[self.index]):getConfig("award_display")[1])

	updateDrop(self.rtAward, var_4_1)
	onButton(self, self.rtAward:Find("get"), function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, self.taskProxy:getTaskVO(self.taskList[self.index]))

		return
	end, SFX_CONFIRM)
	onButton(self, self.rtAward, function()
		self:emit(BaseUI.ON_DROP, var_4_1)

		return
	end)

	local var_4_2 = self.activity:getConfig("config_client").firstStory

	if var_4_2 then
		pg.NewStoryMgr.GetInstance():Play(var_4_2)
	end

	return
end

function SecretsAbyssSkinMagazinePage:OnUpdateFlush()
	local var_8_0 = 0
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(self.taskList) do
		var_8_1[iter_8_1] = tobool(self.taskProxy:getFinishTaskById(iter_8_1))

		local var_8_2

		if var_8_1[iter_8_1] then
			var_8_0 = var_8_0 + 1
			var_8_2 = self.items:GetChild(iter_8_0 - 1)
		end

		setActive(var_8_2:Find("window/got"), var_8_1[iter_8_1])
	end

	if self.usedCnt ~= var_8_0 then
		self.usedCnt = var_8_0
		self.activity.data1 = self.usedCnt

		getProxy(ActivityProxy):updateActivity(self.activity)
	end

	self:RefreshData()
	setText(self.countTF, self.remainCnt)

	local var_8_3 = var_8_1[self.taskList[self.index]]

	setActive(self.rtAward:Find("got"), var_8_1[self.taskList[self.index]])
	setActive(self.rtAward:Find("get"), self.remainCnt > 0 and not var_8_3)

	local var_8_4 = self.activity:getConfig("config_client").story

	for iter_8_2, iter_8_3 in ipairs(self.taskList) do
		if self.taskProxy:getFinishTaskById(iter_8_3) and checkExist(var_8_4, {
			iter_8_2
		}, {
			1
		}) then
			pg.NewStoryMgr.GetInstance():Play(var_8_4[iter_8_2][1])
		end
	end

	return
end

function SecretsAbyssSkinMagazinePage:SelectPage(arg_9_1)
	if self.index == arg_9_1 then
		return
	end

	self.index = arg_9_1

	for iter_9_0, iter_9_1 in ipairs(self.LTList or {}) do
		LeanTween.cancel(iter_9_1)
	end

	self.LTList = {}

	for iter_9_2 = 1, self.items.childCount do
		local var_9_0 = self.items:GetChild(iter_9_2 - 1)
		local var_9_1 = var_9_0:GetComponent(typeof(LayoutElement))
		local var_9_2 = var_9_0:Find("window/Image")
		local var_9_3 = var_9_0:Find("window/main")
		local var_9_4 = var_9_1.preferredWidth

		if iter_9_2 == arg_9_1 then
			local var_9_5 = var_0_2 or var_0_1

			if var_9_4 ~= var_9_5 then
				local var_9_6 = math.abs(var_9_5 - var_9_4) / 2000

				table.insert(self.LTList, LeanTween.value(go(var_9_0), var_9_4, var_9_5, var_9_6):setEase(LeanTweenType.easeOutSine):setOnUpdate(System.Action_float(function(arg_10_0)
					var_9_1.preferredWidth = arg_10_0

					return
				end)).uniqueId)
				table.insert(self.LTList, LeanTween.alpha(var_9_0:Find("window/Image"), iter_9_2 == arg_9_1 and 0 or 1, var_9_6):setEase(LeanTweenType.easeOutSine).uniqueId)
			end
		end
	end

	local var_9_7 = self.taskProxy:getTaskVO(self.taskList[self.index])
	local var_9_8 = {}

	var_9_8.type, var_9_8.id, var_9_8.count = unpack(var_9_7:getConfig("award_display")[1])

	updateDrop(self.rtAward, {})

	local var_9_9 = var_9_7:isReceive()

	setActive(self.rtAward:Find("got"), var_9_9)
	setActive(self.rtAward:Find("get"), self.remainCnt > 0 and not var_9_9)
	setActive(self.rtTask, false)
	setActive(self.rtTask, true)

	return
end

function SecretsAbyssSkinMagazinePage:OnDestroy()
	for iter_11_0, iter_11_1 in ipairs(self.LTList or {}) do
		LeanTween.cancel(iter_11_1)
	end

	return
end

return SecretsAbyssSkinMagazinePage
