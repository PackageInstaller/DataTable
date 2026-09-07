local TerminalAdventurePage = class("TerminalAdventurePage", import("view.base.BaseSubView"))

TerminalAdventurePage.BIND_PT_ACT_ID = ActivityConst.OTHER_WORLD_TERMINAL_PT_ID
TerminalAdventurePage.BIND_TASK_ACT_ID = ActivityConst.OTHER_WORLD_TERMINAL_TASK_ID

function TerminalAdventurePage:getUIName()
	return "TerminalAdventurePage"
end

function TerminalAdventurePage:OnLoaded()
	self._tf.name = tostring(OtherworldTerminalLayer.PAGE_ADVENTURE)
	self.levelTF = self._tf:Find("frame/level")

	setText(self.levelTF:Find("title/content/Text"), i18n("adventure_award_title"))
	setText(self.levelTF:Find("progress/title"), i18n("adventure_progress_title"))
	setText(self.levelTF:Find("lv"), i18n("adventure_lv_title"))

	self.ptIconTF = self.levelTF:Find("progress/Image")
	self.ptValueTF = self.levelTF:Find("progress/value")
	self.ptLvTF = self.levelTF:Find("lv/Text")
	self.awardView = self.levelTF:Find("awards/view")
	self.awardUIList = UIItemList.New(self.awardView:Find("content"), self.awardView:Find("content/tpl"))
	self.recordTF = self._tf:Find("frame/record")

	setText(self.recordTF:Find("title/content/Text"), i18n("adventure_record_title"))
	setText(self.recordTF:Find("grade"), i18n("adventure_record_grade_title"))

	self.recordGradeTF = self.recordTF:Find("grade/Text")
	self.taskUIList = UIItemList.New(self.recordTF:Find("form"), self.recordTF:Find("form/tpl"))

	setText(self._tf:Find("frame/tip"), i18n("adventure_award_end_tip"))

	self.getBtn = self._tf:Find("frame/get_all_btn")

	setText(self.getBtn:Find("Text"), i18n("adventure_get_all"))

	self.getGreyBtn = self._tf:Find("frame/get_all_btn_grey")

	setText(self.getGreyBtn:Find("Text"), i18n("adventure_get_all"))

	return
end

function TerminalAdventurePage:OnInit()
	local var_3_0 = getProxy(ActivityProxy):getActivityById(TerminalAdventurePage.BIND_PT_ACT_ID)

	assert(var_3_0, "not exist bind pt act, id" .. TerminalAdventurePage.BIND_PT_ACT_ID)

	self.ptData = ActivityPtData.New(var_3_0)
	self.taskActivity = getProxy(ActivityProxy):getActivityById(TerminalAdventurePage.BIND_TASK_ACT_ID)

	assert(self.taskActivity, "not exist bind task act, id" .. TerminalAdventurePage.BIND_TASK_ACT_ID)
	onButton(self, self.getBtn, function()
		self:emit(OtherworldTerminalMediator.ON_GET_PT_ALL_AWARD, {
			actId = TerminalAdventurePage.BIND_PT_ACT_ID,
			arg1 = self.ptData:GetCurrTarget()
		})

		return
	end, SFX_PANEL)
	self:InitPtUI()
	self:UpdatePtView()
	self:InitTaskUI()
	self:UpdateTaskView()

	return
end

function TerminalAdventurePage:InitPtUI()
	LoadImageSpriteAsync(Drop.New(self.ptData:GetRes()):getIcon(), self.ptIconTF, false)
	self.awardUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = arg_6_1 + 1
			local var_6_2 = Drop.New({
				type = self.ptData.dropList[arg_6_1 + 1][1],
				id = self.ptData.dropList[arg_6_1 + 1][2],
				count = self.ptData.dropList[arg_6_1 + 1][3]
			})

			updateDrop(arg_6_2:Find("IconTpl"), var_6_2, {
				hideName = true
			})
			onButton(self.binder, arg_6_2:Find("IconTpl"), function()
				self:emit(BaseUI.ON_DROP, var_6_2)

				return
			end, SFX_PANEL)

			local var_6_3 = self.ptData:GetLevel()

			setActive(arg_6_2:Find("IconTpl/got"), var_6_0 <= var_6_3)
			setText(arg_6_2:Find("lv"), "Lv:" .. var_6_0)
			setActive(arg_6_2:Find("lv0"), var_6_0 == 1)

			local var_6_4 = arg_6_2:Find("progress")

			setActive(var_6_4:Find("left"), var_6_0 ~= 1)
			setActive(var_6_4:Find("right"), var_6_0 == #self.ptData.targets)

			if var_6_0 <= var_6_3 then
				setSlider(var_6_4, 0, 1, 1)
			else
				setSlider(var_6_4, 0, 1, (self.ptData.count - (var_6_0 == 1 and 0 or self.ptData.targets[var_6_0 - 1])) / (self.ptData.targets[var_6_0] - (var_6_0 == 1 and 0 or self.ptData.targets[var_6_0 - 1])))
			end
		end

		return
	end)

	return
end

function TerminalAdventurePage:UpdatePt(arg_8_1)
	self.ptData = ActivityPtData.New(arg_8_1)

	self:UpdatePtView()

	return
end

function TerminalAdventurePage:UpdatePtView()
	local var_9_0 = self.ptData:CanGetAward()

	setActive(self.getBtn, var_9_0)
	setActive(self.getGreyBtn, not var_9_0)

	local var_9_1 = self.ptData:GetLevel()
	local var_9_2, var_9_3 = self.ptData:GetResProgress()

	setText(self.ptValueTF, math.max(var_9_3 - var_9_2, 0))
	setText(self.ptLvTF, var_9_1)
	self.awardUIList:align(#self.ptData.targets)
	scrollTo(self.awardView, var_9_1 / #self.ptData.targets, 0)

	return
end

function TerminalAdventurePage:InitTaskUI()
	self.taskIds = self.taskActivity:getConfig("config_data")

	self.taskUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = getProxy(TaskProxy):getTaskById(self.taskIds[arg_11_1 + 1])

			setText(arg_11_2:Find("name"), var_11_0:getConfig("desc"))
			setText(arg_11_2:Find("value"), var_11_0:getProgress())
		end

		return
	end)

	return
end

function TerminalAdventurePage:UpdateTask(arg_12_1)
	self.taskActivity = arg_12_1

	self:UpdateTaskView()

	return
end

function TerminalAdventurePage:UpdateTaskView()
	self.taskUIList:align(#self.taskIds)
	setText(self.recordGradeTF, self:GetAdventureGrade())

	return
end

function TerminalAdventurePage:GetAdventureGrade()
	for iter_14_0, iter_14_1 in ipairs((self.taskActivity:getConfig("config_client"))) do
		if #iter_14_1[2] > 0 then
			for iter_14_2, iter_14_3 in ipairs(iter_14_1[2]) do
				local var_14_0 = getProxy(TaskProxy):getTaskById(iter_14_3[1])

				if var_14_0 and iter_14_3[2] <= var_14_0:getProgress() then
					return iter_14_1[1]
				end
			end
		else
			return iter_14_1[1]
		end
	end

	return ""
end

function TerminalAdventurePage:OnDestroy()
	return
end

function TerminalAdventurePage.IsTip()
	local var_16_0 = getProxy(ActivityProxy):getActivityById(TerminalAdventurePage.BIND_PT_ACT_ID)

	if not var_16_0 or var_16_0:isEnd() then
		return false
	end

	return ActivityPtData.New(var_16_0):CanGetAward()
end

return TerminalAdventurePage
