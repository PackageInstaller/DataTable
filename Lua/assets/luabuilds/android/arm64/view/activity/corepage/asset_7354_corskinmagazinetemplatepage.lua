local SkinMagazineTemplatePage = class("SkinMagazineTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

SkinMagazineTemplatePage.EXPAND_WIDTH = 839
SkinMagazineTemplatePage.CLOSE_WIDTH = 146
SkinMagazineTemplatePage.DURATION_PARAMETER = 1500
SkinMagazineTemplatePage.TIP_KEY = "SkinMagazinePage2_tip"

function SkinMagazineTemplatePage:OnInit()
	self.items = self._tf:Find("AD/items")
	self.countTf = self._tf:Find("AD/task/count")
	self.awardTf = self._tf:Find("AD/task/IconTpl")

	return
end

function SkinMagazineTemplatePage:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskList = self.activity:getConfig("config_data")
	self.totalCnt = #self.taskList

	return
end

function SkinMagazineTemplatePage:RefreshData()
	local var_3_0 = pg.TimeMgr.GetInstance()

	self.unlockCnt = (var_3_0:DiffDay(self.activity:getStartTime(), var_3_0:GetServerTime()) + 1) * self.activity:getConfig("config_id")
	self.unlockCnt = math.min(self.unlockCnt, self.totalCnt)
	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	return
end

function SkinMagazineTemplatePage:OnFirstFlush()
	self.usedCnt = self.activity:getData1()

	self:RefreshData()
	setText(self.awardTf:Find("get/tip/Text"), i18n(self.TIP_KEY))

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
			var_4_0:GetComponent(typeof(LayoutElement)).preferredWidth = self.EXPAND_WIDTH or self.CLOSE_WIDTH
		end

		setImageAlpha(var_4_0:Find("close"), iter_4_1 == self.index and 0 or 1)
		onButton(self, var_4_0, function()
			self:SelectItem(iter_4_1)

			return
		end, SFX_PANEL)
	end

	self:UpdateDrop()

	local var_4_1 = self.activity:getConfig("config_client").firstStory

	if var_4_1 then
		playStory(var_4_1)
	end

	return
end

function SkinMagazineTemplatePage:OnUpdateFlush()
	local var_6_0 = 0
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(self.taskList) do
		var_6_1[iter_6_1] = tobool(self.taskProxy:getFinishTaskById(iter_6_1))

		local var_6_2

		if var_6_1[iter_6_1] then
			var_6_0 = var_6_0 + 1
			var_6_2 = self.items:GetChild(iter_6_0 - 1)
		end

		setActive(var_6_2:Find("got"), var_6_1[iter_6_1])
	end

	if self.usedCnt ~= var_6_0 then
		self.usedCnt = var_6_0
		self.activity.data1 = self.usedCnt

		getProxy(ActivityProxy):updateActivity(self.activity)
	end

	self:RefreshData()
	setText(self.countTf, self.remainCnt)

	local var_6_3 = var_6_1[self.taskList[self.index]]

	setActive(self.awardTf:Find("got"), var_6_1[self.taskList[self.index]])
	setActive(self.awardTf:Find("get"), self.remainCnt > 0 and not var_6_3)

	local var_6_4 = self.activity:getConfig("config_client").story

	for iter_6_2, iter_6_3 in ipairs(self.taskList) do
		if self.taskProxy:getFinishTaskById(iter_6_3) and checkExist(var_6_4, {
			iter_6_2
		}, {
			1
		}) then
			playStory(var_6_4[iter_6_2][1])
		end
	end

	return
end

function SkinMagazineTemplatePage:SelectItem(arg_7_1)
	if self.index == arg_7_1 then
		return
	end

	self.index = arg_7_1

	for iter_7_0, iter_7_1 in ipairs(self.LTList or {}) do
		LeanTween.cancel(iter_7_1)
	end

	self.LTList = {}

	for iter_7_2 = 1, self.items.childCount do
		local var_7_0 = self.items:GetChild(iter_7_2 - 1)
		local var_7_1 = var_7_0:GetComponent(typeof(LayoutElement))
		local var_7_2 = var_7_1.preferredWidth

		if iter_7_2 == arg_7_1 then
			local var_7_3 = self.EXPAND_WIDTH or self.CLOSE_WIDTH

			if var_7_2 ~= var_7_3 then
				local var_7_4 = math.abs(var_7_3 - var_7_2) / self.DURATION_PARAMETER

				table.insert(self.LTList, LeanTween.value(go(var_7_0), var_7_2, var_7_3, var_7_4):setEase(LeanTweenType.easeOutSine):setOnUpdate(System.Action_float(function(arg_8_0)
					var_7_1.preferredWidth = arg_8_0

					return
				end)).uniqueId)
				table.insert(self.LTList, LeanTween.alpha(var_7_0:Find("close"), iter_7_2 == arg_7_1 and 0 or 1, var_7_4):setEase(LeanTweenType.easeOutSine).uniqueId)
			end
		end
	end

	self:UpdateDrop()

	return
end

function SkinMagazineTemplatePage:UpdateDrop()
	local var_9_0 = self.taskProxy:getTaskVO(self.taskList[self.index])
	local var_9_1 = Drop.Create(var_9_0:getConfig("award_display")[1])

	updateDrop(self.awardTf, var_9_1)
	onButton(self, self.awardTf:Find("get"), function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, var_9_0)

		return
	end, SFX_CONFIRM)
	onButton(self, self.awardTf, function()
		self:emit(BaseUI.ON_DROP, var_9_1)

		return
	end)

	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(self.taskList) do
		var_9_2[iter_9_1] = tobool(self.taskProxy:getFinishTaskById(iter_9_1))
	end

	local var_9_3 = var_9_2[self.taskList[self.index]]

	setActive(self.awardTf:Find("got"), var_9_2[self.taskList[self.index]])
	setActive(self.awardTf:Find("get"), self.remainCnt > 0 and not var_9_3)

	return
end

function SkinMagazineTemplatePage:OnDestroy()
	for iter_12_0, iter_12_1 in ipairs(self.LTList or {}) do
		LeanTween.cancel(iter_12_1)
	end

	return
end

return SkinMagazineTemplatePage
