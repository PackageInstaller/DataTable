local DALStagePage = class("DALStagePage", import("view.activity.CorePage.CoreActivityPage"))

function DALStagePage:OnInit()
	self.AD = self._tf:Find("AD")
	self.tabs = self.AD:Find("tabs")
	self.tabsList = self.tabs.transform.childCount

	setText(self.AD:Find("headline_bg/Text (Legacy)"), i18n("DAL_story_tip"))

	return
end

function DALStagePage:OnFirstFlush()
	self.taskProxy = getProxy(TaskProxy)
	self.config_data = self.activity:getConfig("config_data")
	self.config_client = self.activity:getConfig("config_client").story

	return
end

function DALStagePage:OnUpdateFlush()
	for iter_3_0 = 1, #self.config_data do
		local var_3_0 = self.taskProxy:getTaskVO(self.config_data[iter_3_0]):getTaskStatus()

		SetActive(self.AD:Find("tabs/" .. iter_3_0 .. "/got_red"), var_3_0 == 2)
		SetActive(self.AD:Find("tabs/" .. iter_3_0 .. "/red"), var_3_0 == 1)

		if var_3_0 == 2 then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(self.config_client[iter_3_0][1]) then
				local var_3_1, var_3_2 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(self.config_client[iter_3_0][1])

				pg.m02:sendNotification(GAME.STORY_UPDATE_LIST, {
					storyIds = {
						var_3_1
					},
					callback = callback
				})
			end
		end
	end

	local var_3_3 = -1

	for iter_3_1 = 0, self.tabsList - 1 do
		onToggle(self, self.tabs:GetChild(iter_3_1), function(arg_4_0)
			if arg_4_0 then
				if var_3_3 ~= iter_3_1 then
					self:OnUpdata(iter_3_1 + 1)
				end

				var_3_3 = iter_3_1
			end

			return
		end, SFX_PANEL)
	end

	triggerToggle(self.tabs:Find("1"), true)

	return
end

function DALStagePage:OnUpdata(arg_5_1)
	setText(self.AD:Find("id"), "0" .. arg_5_1)
	setText(self.AD:Find("id/Text"), i18n("dal_story_tip_name_en_" .. arg_5_1))
	setText(self.AD:Find("go/name"), i18n("text_goto"))
	setImageSprite(self.AD:Find("Image"), LoadSprite("ui/DALStagePage_atlas", arg_5_1), true)

	local var_5_0 = self.taskProxy:getTaskVO(self.config_data[arg_5_1])

	setText(self.AD:Find("Image/lock/Text"), var_5_0:getConfig("desc"))
	setText(self.AD:Find("Text"), var_5_0:getConfig("name"))

	local var_5_1 = var_5_0:getConfig("award_display")[1]
	local var_5_2 = {
		type = var_5_1[1],
		id = var_5_1[2],
		count = var_5_1[3]
	}

	updateDrop(self.AD:Find("award"), var_5_2)
	onButton(self, self.AD:Find("award/icon_mask"), function()
		self:emit(BaseUI.ON_DROP, var_5_2)

		return
	end, SFX_PANEL)

	local var_5_3 = var_5_0:getTaskStatus()

	SetActive(self.AD:Find("award/lock"), var_5_3 == 2)
	SetActive(self.AD:Find("play"), var_5_3 == 1 and not self.IsPlayeds)
	SetActive(self.AD:Find("go"), var_5_3 == 0)
	SetActive(self.AD:Find("Image/lock"), var_5_3 == 0)
	onButton(self, self.AD:Find("play"), function()
		pg.NewStoryMgr.GetInstance():Play(self.config_client[arg_5_1][1], function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_5_0)

			return
		end, true)

		return
	end, SFX_PANEL)
	onButton(self, self.AD:Find("go"), function()
		self:emit(ActivityMediator.ON_TASK_GO, var_5_0)

		return
	end, SFX_PANEL)

	if var_5_3 == 0 then
		setText(self.AD:Find("rule"), i18n("dal_story_tip1"))
	elseif var_5_3 == 1 then
		setText(self.AD:Find("rule"), i18n("dal_story_tip2"))
	elseif var_5_3 == 2 then
		setText(self.AD:Find("rule"), i18n("dal_story_tip3"))
	end

	return
end

return DALStagePage
