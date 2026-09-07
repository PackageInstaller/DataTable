local BismarckChapterPage = class("BismarckChapterPage", import("...base.BaseActivityPage"))

BismarckChapterPage.tabPos = {
	[1] = 10,
	[2] = 182.3
}
BismarckChapterPage.IconShowFunc = {
	[DROP_TYPE_SHIP] = function(arg_1_0, arg_1_1)
		GetImageSpriteFromAtlasAsync("SquareIcon/" .. pg.ship_skin_template[pg.ship_data_statistics[arg_1_1].skin_id].painting, "", arg_1_0)

		return
	end,
	[DROP_TYPE_FURNITURE] = function(arg_2_0, arg_2_1)
		GetImageSpriteFromAtlasAsync("furnitureicon/" .. pg.furniture_data_template[arg_2_1].icon, "", arg_2_0)

		return
	end
}
BismarckChapterPage.TransformType = {
	[TASK_SUB_TYPE_COLLECT_SHIP] = DROP_TYPE_SHIP,
	[TASK_SUB_TYPE_COLLECT_FURNITURE] = DROP_TYPE_FURNITURE
}

function BismarckChapterPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.items = {}
	self.items[1] = self._tf:Find("AD/Item1")
	self.items[2] = self._tf:Find("AD/Item2")
	self.awardTF = self._tf:Find("AD/award")
	self.battleBtn = self._tf:Find("AD/battle_btn")
	self.shopBtn = self._tf:Find("AD/exchange_btn")
	self.buildBtn = self._tf:Find("AD/build_btn")
	self.tab = self._tf:Find("tab")
	self.bar = self._tf:Find("bar")
	self.scrollList = self.tab:Find("Scroll View")
	self.content = self.scrollList:Find("Content")
	self.listTmpl = self.tab:Find("listitem")
	self.taskList = UIItemList.New(self.content, self.listTmpl)
	self.finalTasks = {}
	self.subtasks = {}
	self.tabType = 0

	return
end

function BismarckChapterPage:OnFirstFlush()
	self.finalTasks = Clone(self.activity:getConfig("config_client"))

	_.each(self.finalTasks, function(arg_5_0)
		if pg.task_data_template[arg_5_0] and pg.task_data_template[arg_5_0].target_id then
			table.insert(self.subtasks, Clone(pg.task_data_template[arg_5_0] and pg.task_data_template[arg_5_0].target_id))
		end

		return
	end)
	setText(self.bg:Find("desc"), i18n("bismarck_chapter_desc"))
	self:SubimtCompletedMission()
	self:InitInteractable()

	return
end

function BismarckChapterPage:InitInteractable()
	local var_6_0 = getProxy(TaskProxy)

	for iter_6_0, iter_6_1 in ipairs(self.finalTasks) do
		onButton(self, self.items[iter_6_0], function()
			local var_7_0 = var_6_0:getTaskVO(iter_6_1)

			if var_7_0:getTaskStatus() == 1 then
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_7_0)

				return
			end

			if self.tabType == iter_6_0 then
				return
			end

			self.tabType = iter_6_0

			self:UpdateTab()

			return
		end, SFX_PANEL)
	end

	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.shopBtn, function()
		local var_9_0

		if configClinet.shopLinkActID then
			var_9_0 = getProxy(ActivityProxy):getActivitiesById(configClinet.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_10_0)
				return not arg_10_0:isEnd()
			end)

			if not var_9_0 or var_9_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end
		end

		self:emit(ActivityMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = var_9_0.id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.buildBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end, SFX_PANEL)
	onButton(self, self.bg, function()
		if self.tabType > 0 then
			self.tabType = 0

			self:UpdateTab()
		end

		return
	end)

	return
end

function BismarckChapterPage:OnUpdateFlush()
	self:UpdateView()
	self:UpdateTab()

	return
end

function BismarckChapterPage:UpdateView()
	local var_14_0 = getProxy(TaskProxy)

	for iter_14_0 = 1, #self.finalTasks do
		local var_14_1 = self.items[iter_14_0]

		setActive(self.items[iter_14_0], true)
		self:UpdateIcon(var_14_1:Find("icon"), pg.task_data_template[self.finalTasks[iter_14_0]].award_display[1][1], pg.task_data_template[self.finalTasks[iter_14_0]].award_display[1][2])

		local var_14_2 = var_14_0:getTaskVO(self.finalTasks[iter_14_0]):getTaskStatus()

		setActive(var_14_1:Find("active"), var_14_2 == 0)
		setActive(var_14_1:Find("finished"), var_14_2 == 1)
		setActive(var_14_1:Find("achieved"), var_14_2 == 2)
		setButtonEnabled(var_14_1, var_14_2 < 2)

		self.tabType = self.tabType == iter_14_0 and var_14_2 == 2 and 0 or self.tabType
	end

	for iter_14_1 = #self.finalTasks + 1, #self.items do
		setActive(self.items[iter_14_1], false)

		self.tabType = self.tabType == iter_14_1 and 0 or self.tabType
	end

	return
end

function BismarckChapterPage:UpdateTab()
	if self.tabType == 0 then
		setActive(self.tab, false)

		return
	end

	local var_15_0 = self.subtasks[self.tabType]

	self.taskList:align(#self.subtasks[self.tabType])

	local var_15_1 = getProxy(TaskProxy)
	local var_15_2 = 0

	for iter_15_0 = 1, #self.subtasks[self.tabType] do
		local var_15_3 = self.content:GetChild(iter_15_0 - 1)

		setText(var_15_3:Find("title/Text"), string.format("Task-%02d", iter_15_0))

		local var_15_4 = var_15_0[iter_15_0]
		local var_15_5 = pg.task_data_template[var_15_0[iter_15_0]]
		local var_15_6 = tonumber(pg.task_data_template[var_15_0[iter_15_0]].target_id)
		local var_15_7 = BismarckChapterPage.TransformType[pg.task_data_template[var_15_0[iter_15_0]].sub_type]

		setActive(var_15_3:Find("tip2"), BismarckChapterPage.TransformType[pg.task_data_template[var_15_0[iter_15_0]].sub_type] == DROP_TYPE_FURNITURE)
		setActive(var_15_3:Find("tip"), var_15_7 == DROP_TYPE_SHIP)

		local var_15_9 = var_15_1:getTaskById(var_15_4) or var_15_1:getFinishTaskById(var_15_4)

		setActive(var_15_3:Find("completed"), defaultValue(var_15_9 and var_15_9:isFinish(), false))
		setText(var_15_3:Find("text"), var_15_5.desc)
		self:UpdateIcon(var_15_3:Find("icon"), var_15_7, var_15_6)

		var_15_2 = var_15_2 + (var_15_9 and var_15_9:isFinish() and 1 or 0)
	end

	setText(self.tab:Find("slider/progress"), string.format("[%d/%d]", var_15_2, #self.subtasks[self.tabType]))

	self.scrollList:GetComponent(typeof(ScrollRect)).verticalNormalizedPosition = 1
	self.tab.transform.anchoredPosition.x = BismarckChapterPage.tabPos[self.tabType]

	setAnchoredPosition(self.tab, self.tab.transform.anchoredPosition)

	self.bar.sizeDelta.x = self._tf.sizeDelta.x - self.bar.anchoredPosition.x - self.tab.transform.anchoredPosition.x - self.tab.sizeDelta.x
	self.bar.sizeDelta = self.bar.sizeDelta

	setActive(self.tab, true)

	return
end

function BismarckChapterPage:UpdateIcon(arg_16_1, arg_16_2, arg_16_3)
	if BismarckChapterPage.IconShowFunc[arg_16_2] then
		BismarckChapterPage.IconShowFunc[arg_16_2](arg_16_1, arg_16_3)
	end

	return
end

function BismarckChapterPage:OnDestroy()
	return
end

function BismarckChapterPage:SubimtCompletedMission()
	local var_18_0 = getProxy(TaskProxy)

	for iter_18_0, iter_18_1 in pairs(self.subtasks) do
		for iter_18_2, iter_18_3 in pairs(iter_18_1) do
			local var_18_1 = var_18_0:getTaskById(iter_18_3)

			if var_18_1 and var_18_1:isFinish() then
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_18_1)
			end
		end
	end

	return
end

return BismarckChapterPage
