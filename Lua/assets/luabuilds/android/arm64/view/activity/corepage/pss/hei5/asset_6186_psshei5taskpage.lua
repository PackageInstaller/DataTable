local PSSHei5TaskPage = class("PSSHei5TaskPage", import("view.base.BaseSubView"))

function PSSHei5TaskPage:getUIName()
	return "PSSHei5TaskPage"
end

function PSSHei5TaskPage:UpdateActivity(arg_2_1)
	self.activity = arg_2_1 or getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5)

	for iter_2_0, iter_2_1 in pairs(self.activity:GetHei5Info()) do
		self[iter_2_0] = iter_2_1
	end

	self.taskGroupList = {}

	local var_2_0 = pg.TimeMgr.GetInstance():GetServerDay(self.activity:getStartTime())

	for iter_2_2, iter_2_3 in ipairs(self.activity:getConfig("config_data")) do
		self.taskGroupList[pg.black_friday_battlepass_task_group[iter_2_3].group_mask] = {
			task_group = pg.black_friday_battlepass_task_group[iter_2_3].task_group,
			isLock = var_2_0 < pg.black_friday_battlepass_task_group[iter_2_3].group_mask
		}
	end

	updateCrusingHei5ActivityTask(self.activity)

	self.finishAll = self.phase == #self.awardList

	return
end

function PSSHei5TaskPage:initTplVar()
	self.btnGoText = "task_go"
	self.btnGetText = "task_get"
	self.taskDayText = "blackfriday_cruise_task_day"
	self.pticonAtlas = "ui/PSSHei5UI_atlas"
	self.pticonName = "battlepass_blackfriday"

	return
end

function PSSHei5TaskPage:OnLoaded()
	self:initTplVar()
	self:UpdateActivity()

	local var_4_0 = self._tf:Find("frame")

	self.togglesTF = var_4_0:Find("week_list")
	self.toggleCount = self.togglesTF:Find("count")

	local var_4_1 = var_4_0:Find("view/content")
	local var_4_2 = var_4_1:Find("tpl")

	setText(var_4_2:Find("info/go/Text"), i18n(self.btnGoText))
	setText(var_4_2:Find("info/get/Text"), i18n(self.btnGetText))
	setText(var_4_2:Find("info/got/Text"), i18n("task_got"))

	self.taskGroupItemList = UIItemList.New(var_4_1, var_4_2)

	return
end

function PSSHei5TaskPage:OnInit()
	self.taskGroupItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateTaskGroup(arg_6_2, self.tempTaskGroup[arg_6_1])
		end

		return
	end)

	return
end

function PSSHei5TaskPage:Flush(arg_7_1)
	if arg_7_1 then
		self:UpdateActivity(arg_7_1)
	end

	local var_7_0 = getProxy(TaskProxy)

	for iter_7_0, iter_7_1 in pairs(self.taskGroupList) do
		local var_7_1 = iter_7_0 == 0 and self._tf:Find("frame/" .. iter_7_0) or self.toggleCount:Find(iter_7_0)

		if iter_7_0 > 0 then
			setText(var_7_1:Find("off/Text"), i18n(self.taskDayText, iter_7_0))
			setText(var_7_1:Find("on/Text"), i18n(self.taskDayText, iter_7_0))
		end

		setActive(var_7_1:Find("tip"), not iter_7_1.isLock and PlayerPrefs.GetInt(string.format("cursing_%d_task_week_%d", self.activity.id, iter_7_0), 0) == 0)
		onToggle(self, var_7_1, function(arg_8_0)
			if arg_8_0 then
				setActive(var_7_1:Find("tip"), false)
				PlayerPrefs.SetInt(string.format("cursing_%d_task_week_%d", self.activity.id, iter_7_0), 1)

				self.weekToggle = iter_7_0
				self.contextData.weekToggle = iter_7_0
				self.tempTaskGroup = underscore.map(iter_7_1.task_group, function(arg_9_0)
					return underscore.map(arg_9_0, function(arg_10_0)
						assert(var_7_0:getTaskVO(arg_10_0), "without this task:" .. arg_10_0)

						return var_7_0:getTaskVO(arg_10_0)
					end)
				end)

				table.sort(self.tempTaskGroup, CompareFuncs({
					function(arg_11_0)
						return underscore.all(arg_11_0, function(arg_12_0)
							return arg_12_0:isReceive()
						end) and 1 or 0
					end,
					function(arg_13_0)
						return arg_13_0[1].id
					end
				}))
				self.taskGroupItemList:align(#self.tempTaskGroup)
			end

			return
		end, SFX_PANEL)

		if var_7_1:Find("mask") then
			setActive(var_7_1:Find("mask"), iter_7_1.isLock)
		end
	end

	local var_7_2 = underscore.keys(self.taskGroupList)

	table.sort(var_7_2, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	if self.contextData.weekToggle and not self.taskGroupList[self.contextData.weekToggle].isLock then
		self.weekToggle = self.contextData.weekToggle
		self.contextData.weekToggle = nil
	else
		self.weekToggle = table.remove(var_7_2, 1)

		for iter_7_2, iter_7_3 in ipairs(var_7_2) do
			if self.taskGroupList[iter_7_3].isLock then
				break
			elseif underscore.any(underscore.flatten(self.taskGroupList[iter_7_3].task_group), function(arg_15_0)
				local var_15_0 = var_7_0:getTaskVO(arg_15_0)

				return var_15_0 and not var_15_0:isReceive()
			end) then
				self.weekToggle = iter_7_3

				break
			end
		end
	end

	if self.weekToggle == 0 then
		triggerToggle(self._tf:Find("frame/0"), true)
	else
		triggerToggle(self.toggleCount:Find(self.weekToggle), true)
	end

	for iter_7_4, iter_7_5 in ipairs(self.taskGroupList) do
		local var_7_3 = self.toggleCount:Find(iter_7_4)

		SetCompomentEnabled(var_7_3, typeof(Toggle), not iter_7_5.isLock)

		if not iter_7_5.isLock then
			setGray(var_7_3, underscore.all(underscore.flatten(iter_7_5.task_group), function(arg_16_0)
				local var_16_0 = var_7_0:getTaskVO(arg_16_0)

				return var_16_0 and var_16_0:isReceive()
			end))
		end
	end

	self:Show()

	return
end

function PSSHei5TaskPage:UpdateTaskGroup(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Find("info")
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
		if not iter_17_1:isReceive() then
			table.insert(var_17_1, iter_17_1)
		end
	end

	self:UpdateTaskDisplay(var_17_0, #var_17_1 > 0 and table.remove(var_17_1, 1) or arg_17_2[#arg_17_2])

	return
end

function PSSHei5TaskPage:UpdateTaskDisplay(arg_18_1, arg_18_2)
	setText(arg_18_1:Find("desc"), string.format("%s(%d/%d)", arg_18_2:getConfig("desc"), arg_18_2:getProgress(), (arg_18_2:getConfig("target_num"))))

	local var_18_0 = Drop.Create(arg_18_2:getConfig("award_display")[1])
	local var_18_1 = self.finishAll and 2 or arg_18_2:getTaskStatus()

	setActive(arg_18_1:Find("go"), var_18_1 == 0)
	setActive(arg_18_1:Find("get"), var_18_1 == 1)
	setActive(arg_18_1:Find("got"), var_18_1 == 2)
	setText(arg_18_1:Find("go/Text"), i18n("island_word_go"))
	setText(arg_18_1:Find("get/Text"), i18n("handbook_research_final_task_btn_claim"))
	setText(arg_18_1:Find("got/Text"), i18n("handbook_research_final_task_btn_finished"))

	local var_18_2 = Drop.Create(arg_18_2:getConfig("award_display")[1])

	setText(arg_18_1:Find("icon/num"), "X" .. arg_18_2:getConfig("award_display")[1][3])

	if self.pticonAtlas and self.pticonName then
		setImageSprite(arg_18_1:Find("icon"), LoadSprite("ui/PSSHei5UI_atlas", "battlepass_blackfriday"), false)
	end

	onButton(self, arg_18_1:Find("icon"), function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_18_2
		})

		return
	end, SFX_PANEL)
	onButton(self, arg_18_1:Find("go"), function()
		self:emit(PSSHei5Mediator.ON_TASK_GO, arg_18_2)

		return
	end, SFX_PANEL)
	onButton(self, arg_18_1:Find("get"), function()
		self:emit(PSSHei5Mediator.ON_TASK_SUBMIT, arg_18_2)

		return
	end, SFX_CONFIRM)

	return
end

function PSSHei5TaskPage:OnDestroy()
	return
end

return PSSHei5TaskPage
