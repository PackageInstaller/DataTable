local FifthAnniversaryMaidPage = class("FifthAnniversaryMaidPage", import("...base.BaseActivityPage"))

function FifthAnniversaryMaidPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.countTF = self.bg:Find("count")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.itemList = UIItemList.New(self.items, self.item)

	return
end

function FifthAnniversaryMaidPage:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskList = self.activity:getConfig("config_data")
	self.totalCnt = #self.taskList

	return
end

function FifthAnniversaryMaidPage:OnFirstFlush()
	self.usedCnt = self.activity:getData1()
	self.unlockCnt = pg.TimeMgr.GetInstance():DiffDay(self.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1

	if self.unlockCnt > self.totalCnt then
		self.unlockCnt = self.totalCnt or self.unlockCnt
	end

	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	setActive(self.item, false)
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		local var_4_0 = self.taskProxy:getTaskById(self.taskList[arg_4_1]) or self.taskProxy:getFinishTaskById(self.taskList[arg_4_1])

		assert(var_4_0, "without this task by id: " .. self.taskList[arg_4_1])

		if arg_4_0 == UIItemList.EventInit then
			local var_4_1 = var_4_0:getConfig("award_display")[1]
			local var_4_2 = {
				type = var_4_1[1],
				id = var_4_1[2],
				count = var_4_1[3]
			}

			updateDrop(arg_4_2:Find("item"), var_4_2)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_2)

				return
			end, SFX_PANEL)
		elseif arg_4_0 == UIItemList.EventUpdate then
			local var_4_3 = var_4_0:getTaskStatus()
			local var_4_4 = arg_4_2:Find("got")
			local var_4_5 = arg_4_2:Find("get")

			setActive(var_4_5, var_4_3 == 1 and self.remainCnt > 0)
			setActive(var_4_4, var_4_3 == 2)
			onButton(self, var_4_5, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function FifthAnniversaryMaidPage:OnUpdateFlush()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(self.taskList) do
		if self.taskProxy:getFinishTaskById(iter_7_1) ~= nil then
			var_7_0 = var_7_0 + 1
		end
	end

	if self.usedCnt ~= var_7_0 then
		self.usedCnt = var_7_0
		self.activity.data1 = self.usedCnt

		getProxy(ActivityProxy):updateActivity(self.activity)
	end

	self.unlockCnt = pg.TimeMgr.GetInstance():DiffDay(self.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1

	if self.unlockCnt > self.totalCnt then
		self.unlockCnt = self.totalCnt or self.unlockCnt
	end

	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	setText(self.countTF, string.format("%02d", self.remainCnt))

	local var_7_1 = self.activity:getConfig("config_client").story

	for iter_7_2, iter_7_3 in ipairs(self.taskList) do
		if self.taskProxy:getFinishTaskById(iter_7_3) and checkExist(var_7_1, {
			iter_7_2
		}, {
			1
		}) then
			pg.NewStoryMgr.GetInstance():Play(var_7_1[iter_7_2][1])
		end
	end

	self.itemList:align(#self.taskList)

	return
end

function FifthAnniversaryMaidPage:OnDestroy()
	return
end

return FifthAnniversaryMaidPage
