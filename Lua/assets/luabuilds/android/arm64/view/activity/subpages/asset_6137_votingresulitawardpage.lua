local VotingResulitAwardPage = class("VotingResulitAwardPage", import(".TemplatePage.SkinMagazineTemplatePage"))

VotingResulitAwardPage.EXPAND_WIDTH = 973
VotingResulitAwardPage.CLOSE_WIDTH = 216
VotingResulitAwardPage.DURATION_PARAMETER = 2500

function VotingResulitAwardPage:OnInit()
	self.items = self._tf:Find("AD/items")
	self.dicLT = {}

	return
end

function VotingResulitAwardPage:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskList = self.activity:getConfig("config_data")
	self.totalCnt = #self.taskList
	self.usedCnt = underscore.reduce(self.taskList, 0, function(arg_3_0, arg_3_1)
		return arg_3_0 + (self.taskProxy:getFinishTaskById(arg_3_1) and 1 or 0)
	end)

	if self.activity:getData1() ~= self.usedCnt then
		self.activity.data1 = self.usedCnt

		getProxy(ActivityProxy):updateActivity(self.activity)

		return true
	end

	local var_2_0 = pg.TimeMgr.GetInstance()

	self.unlockCnt = (var_2_0:DiffDay(self.activity:getStartTime(), var_2_0:GetServerTime()) + 1) * self.activity:getConfig("config_id")
	self.unlockCnt = math.min(self.unlockCnt, self.totalCnt)
	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	return
end

function VotingResulitAwardPage:OnFirstFlush()
	self.usedCnt = self.activity:getData1()

	for iter_4_0, iter_4_1 in ipairs(self.taskList) do
		local var_4_0 = self.items:GetChild(iter_4_0 - 1)

		onButton(self, var_4_0:Find("close"), function()
			if self.index == iter_4_0 then
				return
			end

			self:UpdateDisplay(iter_4_0)

			return
		end, SFX_PANEL)

		local var_4_1 = self.taskProxy:getTaskVO(iter_4_1)
		local var_4_2 = Drop.Create(var_4_1:getConfig("award_display")[1])

		for iter_4_2, iter_4_3 in ipairs({
			"close",
			"expand"
		}) do
			local var_4_3 = var_4_0:Find(iter_4_3 .. "/IconTpl")

			updateDrop(var_4_3, var_4_2)
			setText(var_4_3:Find("get/tip/Text"), i18n("voting_page_reward"))
			onButton(self, var_4_3, function()
				self:emit(BaseUI.ON_DROP, var_4_2)

				return
			end, SFX_PANEL)
			onButton(self, var_4_3:Find("get"), function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_1)

				return
			end, SFX_CONFIRM)
		end
	end

	self:UpdateDisplay(1)

	local var_4_4 = self.activity:getConfig("config_client").firstStory

	if var_4_4 then
		playStory(var_4_4)
	end

	return
end

function VotingResulitAwardPage:OnUpdateFlush()
	for iter_8_0, iter_8_1 in ipairs(self.taskList) do
		local var_8_0 = self.taskProxy:getTaskVO(iter_8_1)

		for iter_8_2, iter_8_3 in ipairs({
			"close",
			"expand"
		}) do
			local var_8_1 = self.items:GetChild(iter_8_0 - 1):Find(iter_8_3 .. "/IconTpl")

			setActive(var_8_1:Find("get"), self.remainCnt > 0 and not var_8_0:isReceive())
			setActive(var_8_1:Find("got"), var_8_0:isReceive())
		end
	end

	return
end

function VotingResulitAwardPage:UpdateDisplay(arg_9_1)
	self.index = arg_9_1

	for iter_9_0 = 1, #self.taskList do
		local var_9_0 = self.items:GetChild(iter_9_0 - 1)
		local var_9_1 = var_9_0:GetComponent(typeof(LayoutElement))

		setActive(var_9_0:Find("expand/IconTpl"), iter_9_0 == self.index)

		var_9_1.flexibleWidth = iter_9_0 == self.index and 1 or -1

		if iter_9_0 == self.index then
			var_9_1.preferredWidth = VotingResulitAwardPage.EXPAND_WIDTH

			setActive(var_9_0:Find("close"), false)
		else
			local var_9_2 = {}

			if var_9_1.preferredWidth ~= VotingResulitAwardPage.CLOSE_WIDTH then
				if self.dicLT[iter_9_0] then
					LeanTween.cancel(self.dicLT[iter_9_0])

					self.dicLT[iter_9_0] = nil
				end

				table.insert(var_9_2, function(arg_10_0)
					self.dicLT[iter_9_0] = LeanTween.value(go(var_9_0), var_9_1.preferredWidth, self.CLOSE_WIDTH, math.abs(var_9_1.preferredWidth - self.CLOSE_WIDTH) / self.DURATION_PARAMETER):setEase(LeanTweenType.easeOutSine):setOnUpdate(System.Action_float(function(arg_11_0)
						var_9_1.preferredWidth = arg_11_0

						return
					end)):setOnComplete(System.Action(arg_10_0)).uniqueId

					return
				end)
			end

			seriesAsync(var_9_2, function()
				self.dicLT[iter_9_0] = nil

				setActive(var_9_0:Find("close"), true)

				return
			end)
		end
	end

	return
end

function VotingResulitAwardPage:OnDestroy()
	for iter_13_0, iter_13_1 in pairs(self.dicLT) do
		LeanTween.cancel(iter_13_1)
	end

	return
end

return VotingResulitAwardPage
