local WorldInPictureRePage = class("WorldInPictureRePage", import(".TemplatePage.SkinTemplatePage"))

function WorldInPictureRePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("items/item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.help = self._tf:Find("AD/help")
	self.start = self._tf:Find("AD/start")
	self.dayTF = self.bg:Find("Text")
	self.tip = self._tf:Find("AD/tip")

	return
end

function WorldInPictureRePage:OnFirstFlush()
	WorldInPictureRePage.super.OnFirstFlush(self)
	onButton(self, self.help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.worldinpicture_task_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.start, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLDINPICTURE)

		return
	end, SFX_PANEL)

	self.miniGameAct = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)

	return
end

function WorldInPictureRePage:UpdateTask(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:Find("item")
	local var_5_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_5_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_5_1 + 1])

	assert(var_5_1, "without this task by id: " .. self.taskGroup[self.nday][arg_5_1 + 1])

	local var_5_2 = var_5_1:getConfig("award_display")[1]
	local var_5_3 = {
		type = var_5_2[1],
		id = var_5_2[2],
		count = var_5_2[3]
	}

	updateDrop(var_5_0, var_5_3)
	onButton(self, var_5_0, function()
		self:emit(BaseUI.ON_DROP, var_5_3)

		return
	end, SFX_PANEL)

	local var_5_4 = var_5_1:getProgress()
	local var_5_5 = var_5_1:getConfig("target_num")

	setText(arg_5_2:Find("description"), var_5_1:getConfig("desc"))
	setSlider(arg_5_2:Find("progress"), 0, var_5_5, var_5_4)

	local var_5_6 = arg_5_2:Find("go_btn")
	local var_5_7 = arg_5_2:Find("get_btn")
	local var_5_8 = arg_5_2:Find("got_btn")
	local var_5_9 = var_5_1:getTaskStatus()

	setActive(var_5_6, var_5_9 == 0)
	setActive(var_5_7, var_5_9 == 1)
	setActive(var_5_8, var_5_9 == 2)
	onButton(self, var_5_6, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_5_1)

		return
	end, SFX_PANEL)
	onButton(self, var_5_7, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, var_5_1)

		return
	end, SFX_PANEL)
	setText(arg_5_2:Find("progressText"), "<color=#789143>" .. var_5_4 .. "</color><color=#a3876f>/" .. var_5_5 .. "</color>")

	return
end

function WorldInPictureRePage:OnUpdateFlush()
	WorldInPictureRePage.super.OnUpdateFlush(self)
	setActive(self.tip, self.miniGameAct and not self.miniGameAct:isEnd() and self.miniGameAct:readyToAchieve())

	return
end

return WorldInPictureRePage
