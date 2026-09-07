local WorldCruiseTaskPage = class("WorldCruiseTaskPage", import("view.base.BaseSubView"))

function WorldCruiseTaskPage:getUIName()
	return "WorldCruiseTaskPage"
end

function WorldCruiseTaskPage:UpdateActivity(arg_2_1)
	self.activity = arg_2_1 or getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	for iter_2_0, iter_2_1 in pairs(self.activity:GetCrusingInfo()) do
		self[iter_2_0] = iter_2_1
	end

	self.taskGroupList = {}

	local var_2_0 = pg.TimeMgr.GetInstance():GetServerOverWeek(self.activity:getStartTime())

	for iter_2_2, iter_2_3 in ipairs(self.activity:getConfig("config_data")) do
		self.taskGroupList[pg.battlepass_task_group[iter_2_3].group_mask] = {
			task_group = pg.battlepass_task_group[iter_2_3].task_group,
			isLock = var_2_0 < pg.battlepass_task_group[iter_2_3].group_mask
		}
	end

	updateCrusingActivityTask(self.activity)

	self.finishAll = self.phase == #self.awardList

	return
end

function WorldCruiseTaskPage:OnLoaded()
	self:UpdateActivity()

	local var_3_0 = self._tf:Find("frame")

	self.togglesTF = var_3_0:Find("week_list")

	local var_3_1 = var_3_0:Find("view/content")
	local var_3_2 = var_3_1:Find("tpl")

	setText(var_3_2:Find("info/go/Text"), i18n("task_go"))
	setText(var_3_2:Find("info/get/Text"), i18n("task_get"))
	setText(var_3_2:Find("info/got/Image/Text"), i18n("task_got"))

	local var_3_3 = var_3_2:Find("content/extend_tpl")

	setText(var_3_3:Find("go/Text"), i18n("task_go"))
	setText(var_3_3:Find("get/Text"), i18n("task_get"))
	setText(var_3_3:Find("got/Image/Text"), i18n("task_got"))

	self.taskGroupItemList = UIItemList.New(var_3_1, var_3_2)

	return
end

function WorldCruiseTaskPage:OnInit()
	self.taskGroupItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateTaskGroup(arg_5_2, self.tempTaskGroup[arg_5_1])
		end

		return
	end)

	return
end

function WorldCruiseTaskPage:Flush(arg_6_1)
	if arg_6_1 then
		self:UpdateActivity(arg_6_1)
	end

	local var_6_0 = getProxy(TaskProxy)

	for iter_6_0, iter_6_1 in pairs(self.taskGroupList) do
		local var_6_1 = self.togglesTF:Find(iter_6_0)

		if iter_6_0 > 0 then
			setText(var_6_1:Find("off/Text"), i18n("cruise_task_week", iter_6_0))
			setText(var_6_1:Find("on/Text"), i18n("cruise_task_week", iter_6_0))
		end

		setActive(var_6_1:Find("tip"), not iter_6_1.isLock and PlayerPrefs.GetInt(string.format("cursing_%d_task_week_%d", self.activity.id, iter_6_0), 0) == 0)
		onToggle(self, var_6_1, function(arg_7_0)
			if arg_7_0 then
				setActive(var_6_1:Find("tip"), false)
				PlayerPrefs.SetInt(string.format("cursing_%d_task_week_%d", self.activity.id, iter_6_0), 1)

				self.weekToggle = iter_6_0
				self.contextData.weekToggle = iter_6_0
				self.tempTaskGroup = underscore.map(iter_6_1.task_group, function(arg_8_0)
					return underscore.map(arg_8_0, function(arg_9_0)
						assert(var_6_0:getTaskVO(arg_9_0), "without this task:" .. arg_9_0)

						return var_6_0:getTaskVO(arg_9_0)
					end)
				end)

				table.sort(self.tempTaskGroup, CompareFuncs({
					function(arg_10_0)
						return underscore.all(arg_10_0, function(arg_11_0)
							return arg_11_0:isReceive()
						end) and 1 or 0
					end,
					function(arg_12_0)
						return arg_12_0[1].id
					end
				}))
				self.taskGroupItemList:align(#self.tempTaskGroup)
			end

			return
		end, SFX_PANEL)

		if var_6_1:Find("mask") then
			setActive(var_6_1:Find("mask"), iter_6_1.isLock)
		end
	end

	local var_6_2 = underscore.keys(self.taskGroupList)

	table.sort(var_6_2, function(arg_13_0, arg_13_1)
		return arg_13_0 < arg_13_1
	end)

	if self.contextData.weekToggle and not self.taskGroupList[self.contextData.weekToggle].isLock then
		self.weekToggle = self.contextData.weekToggle
		self.contextData.weekToggle = nil
	else
		self.weekToggle = table.remove(var_6_2, 1)

		for iter_6_2, iter_6_3 in ipairs(var_6_2) do
			if self.taskGroupList[iter_6_3].isLock then
				break
			elseif underscore.any(underscore.flatten(self.taskGroupList[iter_6_3].task_group), function(arg_14_0)
				local var_14_0 = var_6_0:getTaskVO(arg_14_0)

				return var_14_0 and not var_14_0:isReceive()
			end) then
				self.weekToggle = iter_6_3

				break
			end
		end
	end

	triggerToggle(self.togglesTF:Find(self.weekToggle), true)

	for iter_6_4, iter_6_5 in ipairs(self.taskGroupList) do
		local var_6_3 = self.togglesTF:Find(iter_6_4)

		SetCompomentEnabled(var_6_3, typeof(Toggle), not iter_6_5.isLock)

		if not iter_6_5.isLock then
			setGray(var_6_3, underscore.all(underscore.flatten(iter_6_5.task_group), function(arg_15_0)
				local var_15_0 = var_6_0:getTaskVO(arg_15_0)

				return var_15_0 and var_15_0:isReceive()
			end))
		end
	end

	self:Show()

	return
end

function WorldCruiseTaskPage:UpdateTaskGroup(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:Find("info")

	LoadImageSpriteAtlasAsync("ui/worldcruiseui_atlas", tostring(self.weekToggle), var_16_0:Find("week"), true)

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
		if not iter_16_1:isReceive() then
			table.insert(var_16_1, iter_16_1)
		end
	end

	triggerToggle(var_16_0, false)

	local var_16_2 = #var_16_1 > 0 and table.remove(var_16_1, 1) or arg_16_2[#arg_16_2]

	SetCompomentEnabled(var_16_0, typeof(Toggle), #var_16_1 > 0)
	self:UpdateTaskDisplay(var_16_0, var_16_2)
	setActive(var_16_0:Find("quick"), var_16_2:getConfig("quick_finish") > 0 and var_16_2:getTaskStatus() == 0)
	onButton(self, var_16_0:Find("quick"), function()
		self:OnQuickClick(var_16_2)

		return
	end, SFX_CONFIRM)
	setActive(var_16_0:Find("toggle_mark"), #var_16_1 > 0)

	if #var_16_1 > 0 then
		local var_16_3 = arg_16_1:Find("content")
		local var_16_4 = UIItemList.New(var_16_3, var_16_3:Find("extend_tpl"))

		var_16_4:make(function(arg_18_0, arg_18_1, arg_18_2)
			arg_18_1 = arg_18_1 + 1

			if arg_18_0 == UIItemList.EventUpdate then
				self:UpdateTaskDisplay(arg_18_2, var_16_1[arg_18_1])
			end

			return
		end)
		var_16_4:align(#var_16_1)
	end

	return
end

function WorldCruiseTaskPage:UpdateTaskDisplay(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2:getProgress()
	local var_19_1 = arg_19_2:getConfig("target_num")

	setSlider(arg_19_1:Find("Slider"), 0, var_19_1, var_19_0)
	setText(arg_19_1:Find("desc"), string.format("%s(%d/%d)", arg_19_2:getConfig("desc"), var_19_0, var_19_1))

	local var_19_2 = Drop.Create(arg_19_2:getConfig("award_display")[1])

	updateDrop(arg_19_1:Find("outline/mask/IconTpl"), var_19_2)
	onButton(self, arg_19_1:Find("outline/mask/IconTpl"), function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_19_2
		})

		return
	end, SFX_PANEL)

	local var_19_3 = self.finishAll and 2 or arg_19_2:getTaskStatus()

	setActive(arg_19_1:Find("go"), var_19_3 == 0)
	setActive(arg_19_1:Find("get"), var_19_3 == 1)
	setActive(arg_19_1:Find("got"), var_19_3 == 2)
	setActive(arg_19_1:Find("outline/mask/IconTpl/mask"), var_19_3 == 2)
	onButton(self, arg_19_1:Find("go"), function()
		self:emit(WorldCruiseMediator.ON_TASK_GO, arg_19_2)

		return
	end, SFX_PANEL)
	onButton(self, arg_19_1:Find("get"), function()
		self:emit(WorldCruiseMediator.ON_TASK_SUBMIT, arg_19_2)

		return
	end, SFX_CONFIRM)
	setActive(arg_19_1:Find("quick"), arg_19_2:getConfig("quick_finish") > 0 and arg_19_2:getTaskStatus() == 0)
	onButton(self, arg_19_1:Find("quick"), function()
		self:OnQuickClick(arg_19_2)

		return
	end, SFX_CONFIRM)

	return
end

function WorldCruiseTaskPage:OnQuickClick(arg_24_1)
	local var_24_0 = getProxy(BagProxy):getItemCountById(Item.QUICK_TASK_PASS_TICKET_ID)
	local var_24_1 = arg_24_1:getConfig("quick_finish")

	if var_24_0 < var_24_1 then
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
			contentText = i18n("battlepass_task_quickfinish2", var_24_1 - var_24_0),
			onConfirm = function()
				shoppingBatchNewStyle(Goods.CRUISE_QUICK_TASK_TICKET_ID, {
					id = Item.QUICK_TASK_PASS_TICKET_ID
				}, 20, "build_ship_quickly_buy_stone")

				return
			end
		})
	else
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
			contentText = i18n("battlepass_task_quickfinish1", var_24_1, var_24_0),
			onConfirm = function()
				self:emit(WorldCruiseMediator.ON_TASK_QUICK_SUBMIT, arg_24_1)

				return
			end
		})
	end

	return
end

function WorldCruiseTaskPage:OnDestroy()
	return
end

return WorldCruiseTaskPage
