local NewOrleansLoginPage = class("NewOrleansLoginPage", import("...base.BaseActivityPage"))

function NewOrleansLoginPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.showItemTpl = self.bg:Find("ShowItem")
	self.showItemContainer = self.bg:Find("ItemShowList")
	self.itemList = UIItemList.New(self.showItemContainer, self.showItemTpl)

	setActive(self.showItemTpl, false)

	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)

	setActive(self.item, false)

	self.stepText = self.bg:Find("step_text")

	return
end

function NewOrleansLoginPage:OnDataSetting()
	self.linkActivity = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").act_id)
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.linkActivity:getConfig("config_data")
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]
	self.Day = #self.config.front_drops
	self.curDay = 0

	return updateActivityTaskStatus(self.linkActivity)
end

function NewOrleansLoginPage:OnFirstFlush()
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_4_2:Find("item")
			local var_4_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_4_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_4_1 + 1])

			assert(var_4_1, "without this task by id: " .. self.taskGroup[self.nday][arg_4_1 + 1])

			local var_4_2 = var_4_1:getConfig("award_display")[1]
			local var_4_3 = {
				type = var_4_2[1],
				id = var_4_2[2],
				count = var_4_2[3]
			}

			updateDrop(var_4_0, var_4_3)
			onButton(self, var_4_0, function()
				self:emit(BaseUI.ON_DROP, var_4_3)

				return
			end, SFX_PANEL)

			local var_4_4 = var_4_1:getProgress()
			local var_4_5 = var_4_1:getConfig("target_num")

			setText(arg_4_2:Find("description"), var_4_1:getConfig("desc"))
			setText(arg_4_2:Find("progressText"), var_4_4 .. "/" .. var_4_5)
			setSlider(arg_4_2:Find("progress"), 0, var_4_5, var_4_4)

			local var_4_6 = arg_4_2:Find("go_btn")
			local var_4_7 = arg_4_2:Find("get_btn")
			local var_4_8 = arg_4_2:Find("got_btn")
			local var_4_9 = var_4_1:getTaskStatus()

			setActive(var_4_6, var_4_9 == 0)
			setActive(var_4_7, var_4_9 == 1)
			setActive(var_4_8, var_4_9 == 2)
			onButton(self, var_4_6, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_4_1)

				return
			end, SFX_PANEL)
			onButton(self, var_4_7, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_1)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.itemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventInit then
			local var_8_0 = {
				type = self.config.front_drops[arg_8_1 + 1][1],
				id = self.config.front_drops[arg_8_1 + 1][2],
				count = self.config.front_drops[arg_8_1 + 1][3]
			}

			updateDrop(arg_8_2, var_8_0)
			onButton(self, arg_8_2, function()
				self:emit(BaseUI.ON_DROP, var_8_0)

				return
			end, SFX_PANEL)
		elseif arg_8_0 == UIItemList.EventUpdate then
			setActive(arg_8_2:Find("icon_mask"), arg_8_1 < self.curDay)
		end

		return
	end)

	return
end

function NewOrleansLoginPage:OnUpdateFlush()
	self.nday = self.linkActivity.data3

	local var_10_0 = self.linkActivity:getConfig("config_client").story

	if checkExist(var_10_0, {
		self.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_10_0[self.nday][1])
	end

	if self.stepText then
		setText(self.stepText, tostring(self.nday))
	end

	self.uilist:align(#self.taskGroup[self.nday])

	self.curDay = self.activity.data1

	self.itemList:align(self.Day)

	return
end

function NewOrleansLoginPage:OnDestroy()
	return
end

return NewOrleansLoginPage
