local JiuJiuExpeditionPage = class("JiuJiuExpeditionPage", import("...base.BaseActivityPage"))

function JiuJiuExpeditionPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider")
	self.step = self.bg:Find("step")
	self.progress = self.bg:Find("progress")
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.help = self.bg:Find("help")
	self.book = self.bg:Find("book")
	self.startGame = self.bg:Find("startGame")
	self.desc = self.bg:Find("desc")

	return
end

function JiuJiuExpeditionPage:OnDataSetting()
	self.taskIDList = _.flatten((self.activity:getConfig("config_data")))
	self.dropList = {}
	self.descs = {}

	for iter_2_0, iter_2_1 in ipairs(self.taskIDList) do
		table.insert(self.dropList, Clone(pg.task_data_template[iter_2_1].award_display[1]))
		table.insert(self.descs, pg.task_data_template[iter_2_1].desc)
	end

	return updateActivityTaskStatus(self.activity)
end

function JiuJiuExpeditionPage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		if self.curTaskVO then
			self:emit(ActivityMediator.ON_TASK_GO, self.curTaskVO)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, self.curTaskVO)

		return
	end, SFX_PANEL)
	onButton(self, self.help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.jiujiu_expedition_help.tip
		})

		return
	end, SFX_PANEL)

	if PLATFORM_CODE ~= PLATFORM_JP then
		setActive(self.book, false)
	else
		local var_3_0, var_3_1, var_3_2, var_3_3 = JiuJiuExpeditionCollectionMediator.GetCollectionData()

		setActive(findTF(self.book, "tip"), var_3_3 < var_3_2)
		onButton(self, self.book, function()
			self:emit(ActivityMediator.OPEN_LAYER, Context.New({
				viewComponent = JiuJiuExpeditionCollectionLayer,
				mediator = JiuJiuExpeditionCollectionMediator
			}))

			return
		end, SFX_PANEL)
	end

	onButton(self, self.startGame, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.JIUJIU_EXPEDITION)

		return
	end, SFX_PANEL)

	return
end

function JiuJiuExpeditionPage:OnUpdateFlush()
	local var_9_0, var_9_1 = getActivityTask(self.activity)

	self.curTaskVO = var_9_1

	setText(self.desc, self.curTaskVO:getConfig("desc"))

	local var_9_2 = var_9_1:getConfig("award_display")[1]
	local var_9_3 = {
		type = var_9_2[1],
		id = var_9_2[2],
		count = var_9_2[3]
	}

	updateDrop(self.awardTF, var_9_3)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_9_3)

		return
	end, SFX_PANEL)

	local var_9_4 = var_9_1:getProgress()
	local var_9_5 = var_9_1:getConfig("target_num")

	setText(self.progress, (var_9_5 <= var_9_4 and setColorStr(var_9_4, COLOR_GREEN) or var_9_4) .. "/" .. var_9_5)
	setSlider(self.slider, 0, var_9_5, var_9_4)

	local var_9_6 = table.indexof(self.taskIDList, var_9_0, 1)

	setText(self.step, var_9_6 .. "/" .. #self.taskIDList)

	local var_9_7 = var_9_1:getTaskStatus()

	setActive(self.battleBtn, var_9_7 == 0)
	setActive(self.getBtn, var_9_7 == 1)
	setActive(self.gotBtn, var_9_7 == 2)

	self.finishedIndex = var_9_7 == 2 and var_9_6 or var_9_6 - 1

	return
end

function JiuJiuExpeditionPage:OnDestroy()
	return
end

return JiuJiuExpeditionPage
