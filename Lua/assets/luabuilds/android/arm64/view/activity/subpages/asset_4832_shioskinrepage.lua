local ShioSkinRePage = class("ShioSkinRePage", import(".TemplatePage.SkinTemplatePage"))

function ShioSkinRePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.dayTF = self.bg:Find("day")
	self.item1TF = self.bg:Find("item1")
	self.item2TF = self.bg:Find("item2")
	self.itemTFList = {
		self.item1TF,
		self.item2TF
	}

	return
end

function ShioSkinRePage:OnFirstFlush()
	return
end

function ShioSkinRePage:OnUpdateFlush()
	self.nday = self.activity.data3

	if self.dayTF then
		setText(self.dayTF, self.nday .. "/" .. #self.activity:getConfig("config_data"))
	end

	local var_3_0 = self.activity:getConfig("config_client").story

	if checkExist(var_3_0, {
		self.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_3_0[self.nday][1])
	end

	for iter_3_0 = 1, 2 do
		local var_3_2 = self.itemTFList[iter_3_0]:Find("item")
		local var_3_3 = self.taskProxy:getTaskById(self.taskGroup[self.nday][iter_3_0]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][iter_3_0])

		assert(var_3_3, "without this task by id: " .. self.taskGroup[self.nday][iter_3_0])

		local var_3_4 = var_3_3:getConfig("award_display")[1]
		local var_3_5 = {
			type = var_3_4[1],
			id = var_3_4[2],
			count = var_3_4[3]
		}

		updateDrop(var_3_2, var_3_5)
		onButton(self, var_3_2, function()
			self:emit(BaseUI.ON_DROP, var_3_5)

			return
		end, SFX_PANEL)

		local var_3_6 = var_3_3:getProgress()
		local var_3_7 = var_3_3:getConfig("target_num")

		setText(self.itemTFList[iter_3_0]:Find("description"), var_3_3:getConfig("desc"))
		setText(self.itemTFList[iter_3_0]:Find("progressText"), var_3_6 .. "/" .. var_3_7)
		setSlider(self.itemTFList[iter_3_0]:Find("progress"), 0, var_3_7, var_3_6)

		local var_3_8 = self.itemTFList[iter_3_0]:Find("go_btn")
		local var_3_9 = self.itemTFList[iter_3_0]:Find("get_btn")
		local var_3_10 = self.itemTFList[iter_3_0]:Find("got_btn")
		local var_3_11 = var_3_3:getTaskStatus()

		setActive(var_3_8, var_3_11 == 0)
		setActive(var_3_9, var_3_11 == 1)
		setActive(var_3_10, var_3_11 == 2)
		onButton(self, var_3_8, function()
			self:emit(ActivityMediator.ON_TASK_GO, var_3_3)

			return
		end, SFX_PANEL)
		onButton(self, var_3_9, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_3)

			return
		end, SFX_PANEL)
	end

	return
end

function ShioSkinRePage:OnDestroy()
	return
end

return ShioSkinRePage
