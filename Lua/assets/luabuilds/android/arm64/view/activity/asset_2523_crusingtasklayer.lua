local CrusingTaskLayer = class("CrusingTaskLayer", import("view.base.BaseUI"))

function CrusingTaskLayer:getUIName()
	return "CrusingTaskUI"
end

function CrusingTaskLayer:tempCache()
	return true
end

function CrusingTaskLayer:init()
	self.rtBg = self._tf:Find("bg")

	local var_3_0 = self._tf:Find("window")

	self.itemQuick = var_3_0:Find("item_quick")
	self.btnBack = var_3_0:Find("btn_back")
	self.btnHelp = var_3_0:Find("btn_help")
	self.textPhase = var_3_0:Find("text_phase")
	self.sliderPt = var_3_0:Find("Slider")
	self.textComplete = var_3_0:Find("text_complete")

	local var_3_1 = var_3_0:Find("view/content")

	self.taskGroupItemList = UIItemList.New(var_3_1, var_3_1:Find("tpl"))

	self.taskGroupItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			self:updateTaskGroup(arg_4_2, self.tempTaskGroup[arg_4_1])
		end

		return
	end)

	self.rtWeekToggles = var_3_0:Find("week_list")

	return
end

function CrusingTaskLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self.rtBg, function()
		self:emit(CrusingTaskMediator.ON_EXIT)
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnBack, function()
		self:emit(CrusingTaskMediator.ON_EXIT)
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("cruise_task_help_" .. pg.battlepass_event_pt[self.activity.id].map_name)
		})

		return
	end, SFX_PANEL)

	local var_5_0 = getProxy(TaskProxy)

	for iter_5_0, iter_5_1 in pairs(self.taskGroupList) do
		local var_5_1 = self.rtWeekToggles:Find(iter_5_0)

		if iter_5_0 > 0 then
			setText(var_5_1:Find("off/Text"), i18n("cruise_task_week", iter_5_0))
			setText(var_5_1:Find("on/Text"), i18n("cruise_task_week", iter_5_0))
		end

		setActive(var_5_1:Find("tip"), not iter_5_1.isLock and PlayerPrefs.GetInt(string.format("cursing_%d_task_week_%d", self.activity.id, iter_5_0), 0) == 0)
		onToggle(self, var_5_1, function(arg_9_0)
			if arg_9_0 then
				setActive(var_5_1:Find("tip"), false)
				PlayerPrefs.SetInt(string.format("cursing_%d_task_week_%d", self.activity.id, iter_5_0), 1)

				self.weekToggle = iter_5_0
				self.contextData.weekToggle = iter_5_0
				self.tempTaskGroup = underscore.map(iter_5_1.task_group, function(arg_10_0)
					return underscore.map(arg_10_0, function(arg_11_0)
						assert(var_5_0:getTaskVO(arg_11_0), "without this task:" .. arg_11_0)

						return var_5_0:getTaskVO(arg_11_0)
					end)
				end)

				table.sort(self.tempTaskGroup, CompareFuncs({
					function(arg_12_0)
						return underscore.all(arg_12_0, function(arg_13_0)
							return arg_13_0:isReceive()
						end) and 1 or 0
					end,
					function(arg_14_0)
						return arg_14_0[1].id
					end
				}))
				self.taskGroupItemList:align(#self.tempTaskGroup)
				self:updateTaskInfo()
			end

			return
		end, SFX_PANEL)

		if var_5_1:Find("mask") then
			setActive(var_5_1:Find("mask"), iter_5_1.isLock)
		end
	end

	local var_5_2 = underscore.keys(self.taskGroupList)

	table.sort(var_5_2, function(arg_15_0, arg_15_1)
		return arg_15_0 < arg_15_1
	end)

	if self.contextData.weekToggle and not self.taskGroupList[self.contextData.weekToggle].isLock then
		self.weekToggle = self.contextData.weekToggle
		self.contextData.weekToggle = nil
	else
		self.weekToggle = table.remove(var_5_2, 1)

		for iter_5_2, iter_5_3 in ipairs(var_5_2) do
			if self.taskGroupList[iter_5_3].isLock then
				break
			elseif underscore.any(underscore.flatten(self.taskGroupList[iter_5_3].task_group), function(arg_16_0)
				local var_16_0 = var_5_0:getTaskVO(arg_16_0)

				return var_16_0 and not var_16_0:isReceive()
			end) then
				self.weekToggle = iter_5_3

				break
			end
		end
	end

	triggerToggle(self.rtWeekToggles:Find(self.weekToggle), true)

	for iter_5_4, iter_5_5 in ipairs(self.taskGroupList) do
		local var_5_3 = self.rtWeekToggles:Find(iter_5_4)

		SetCompomentEnabled(var_5_3, typeof(Toggle), not iter_5_5.isLock)

		if not iter_5_5.isLock then
			setGray(var_5_3, underscore.all(underscore.flatten(iter_5_5.task_group), function(arg_17_0)
				local var_17_0 = var_5_0:getTaskVO(arg_17_0)

				return var_17_0 and var_17_0:isReceive()
			end))
		end
	end

	self:updatePhaseInfo()
	LoadImageSpriteAtlasAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = self.ptId
	}):getIcon(), "", self.sliderPt:Find("icon"), true)
	onButton(self, self.itemQuick, function()
		self:emit(CrusingTaskLayer.ON_DROP, {
			count = 1,
			type = DROP_TYPE_ITEM,
			id = Item.QUICK_TASK_PASS_TICKET_ID
		})

		return
	end, SFX_PANEL)
	LoadImageSpriteAtlasAsync(Drop.New({
		type = DROP_TYPE_ITEM,
		id = Item.QUICK_TASK_PASS_TICKET_ID
	}):getIcon(), "", self.itemQuick:Find("icon"), true)
	onButton(self, self.itemQuick:Find("plus"), function()
		shoppingBatch(61017, {
			id = Item.QUICK_TASK_PASS_TICKET_ID
		}, 20, "build_ship_quickly_buy_stone")

		return
	end)
	self:updateItemInfo()
	setText(self.textComplete:Find("Text"), i18n("cruise_task_tips"))

	return
end

function CrusingTaskLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function CrusingTaskLayer:setActivity(arg_21_1)
	self.activity = arg_21_1

	for iter_21_0, iter_21_1 in pairs(arg_21_1:GetCrusingInfo()) do
		self[iter_21_0] = iter_21_1
	end

	self.taskGroupList = {}

	local var_21_0 = pg.TimeMgr.GetInstance():GetServerOverWeek(arg_21_1:getStartTime())

	for iter_21_2, iter_21_3 in ipairs(arg_21_1:getConfig("config_data")) do
		self.taskGroupList[pg.battlepass_task_group[iter_21_3].group_mask] = {
			task_group = pg.battlepass_task_group[iter_21_3].task_group,
			isLock = var_21_0 < pg.battlepass_task_group[iter_21_3].group_mask
		}
	end

	return
end

function CrusingTaskLayer:updatePhaseInfo()
	setText(self.textPhase, i18n("cruise_task_phase", self.phase))

	if self.phase < #self.awardList then
		local var_22_0 = self.pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt)

		setSlider(self.sliderPt, 0, self.awardList[self.phase + 1].pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt), self.pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt))
		setText(self.sliderPt:Find("Text"), var_22_0 .. "/" .. self.awardList[self.phase + 1].pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt))
	else
		setSlider(self.sliderPt, 0, 1, 1)
		setText(self.sliderPt:Find("Text"), "MAX")
	end

	return
end

function CrusingTaskLayer:updateTaskInfo()
	local var_23_0 = 0
	local var_23_1 = 0

	underscore.each(self.tempTaskGroup, function(arg_24_0)
		underscore.each(arg_24_0, function(arg_25_0)
			var_23_1 = var_23_1 + 1

			if arg_25_0:isReceive() then
				var_23_0 = var_23_0 + 1
			end

			return
		end)

		return
	end)
	setText(self.textComplete, 0 .. "/" .. 0)

	return
end

function CrusingTaskLayer:updateItemInfo()
	setText(self.itemQuick, getProxy(BagProxy):getItemCountById(Item.QUICK_TASK_PASS_TICKET_ID))

	return
end

function CrusingTaskLayer:updateTaskGroup(arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1:Find("info")

	LoadImageSpriteAtlasAsync("ui/crusingtaskui_atlas", tostring(self.weekToggle), var_27_0:Find("week"), true)

	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		if not iter_27_1:isReceive() then
			table.insert(var_27_1, iter_27_1)
		end
	end

	triggerToggle(var_27_0, false)

	local var_27_2 = #var_27_1 > 0 and table.remove(var_27_1, 1) or arg_27_2[#arg_27_2]

	SetCompomentEnabled(var_27_0, typeof(Toggle), #var_27_1 > 0)
	self:updateTaskDisplay(var_27_0, var_27_2)
	setActive(var_27_0:Find("quick"), var_27_2:getConfig("quick_finish") > 0 and var_27_2:getTaskStatus() == 0)
	onButton(self, var_27_0:Find("quick"), function()
		local var_28_0 = getProxy(BagProxy):getItemCountById(Item.QUICK_TASK_PASS_TICKET_ID)
		local var_28_1 = var_27_2:getConfig("quick_finish")

		if var_28_0 < var_28_1 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("battlepass_task_quickfinish2", var_28_1 - var_28_0),
				onYes = function()
					shoppingBatch(61017, {
						id = Item.QUICK_TASK_PASS_TICKET_ID
					}, 20, "build_ship_quickly_buy_stone")

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("battlepass_task_quickfinish1", var_28_1, var_28_0),
				onYes = function()
					self:emit(CrusingTaskMediator.ON_TASK_QUICK_SUBMIT, var_27_2)

					return
				end
			})
		end

		return
	end, SFX_CONFIRM)
	setActive(var_27_0:Find("toggle_mark"), #var_27_1 > 0)

	if #var_27_1 > 0 then
		local var_27_3 = arg_27_1:Find("content")
		local var_27_4 = UIItemList.New(var_27_3, var_27_3:Find("extend_tpl"))

		var_27_4:make(function(arg_31_0, arg_31_1, arg_31_2)
			arg_31_1 = arg_31_1 + 1

			if arg_31_0 == UIItemList.EventUpdate then
				self:updateTaskDisplay(arg_31_2, var_27_1[arg_31_1])
			end

			return
		end)
		var_27_4:align(#var_27_1)
	end

	return
end

function CrusingTaskLayer:updateTaskDisplay(arg_32_1, arg_32_2)
	setText(arg_32_1:Find("desc"), arg_32_2:getConfig("desc"))

	local var_32_0 = arg_32_2:getProgress()
	local var_32_1 = arg_32_2:getConfig("target_num")

	setSlider(arg_32_1:Find("Slider"), 0, var_32_1, var_32_0)
	setText(arg_32_1:Find("Slider/Text"), var_32_0 .. "/" .. var_32_1)

	local var_32_2 = arg_32_2:getConfig("award_display")[1]
	local var_32_3 = {
		type = var_32_2[1],
		id = var_32_2[2],
		count = var_32_2[3]
	}

	updateDrop(arg_32_1:Find("IconTpl"), var_32_3)
	onButton(self, arg_32_1:Find("IconTpl"), function()
		self:emit(CrusingTaskLayer.ON_DROP, var_32_3)

		return
	end, SFX_PANEL)

	local var_32_4 = arg_32_2:getTaskStatus()

	setActive(arg_32_1:Find("go"), var_32_4 == 0)
	setActive(arg_32_1:Find("get"), var_32_4 == 1)
	setActive(arg_32_1:Find("got"), var_32_4 == 2)
	setActive(arg_32_1:Find("IconTpl/mask"), var_32_4 == 2)
	setActive(arg_32_1:Find("IconTpl/mark"), var_32_4 == 2)
	onButton(self, arg_32_1:Find("go"), function()
		self:emit(CrusingTaskMediator.ON_TASK_GO, arg_32_2)

		return
	end, SFX_PANEL)
	onButton(self, arg_32_1:Find("get"), function()
		self:emit(CrusingTaskMediator.ON_TASK_SUBMIT, arg_32_2)

		return
	end, SFX_CONFIRM)

	return
end

function CrusingTaskLayer:updateCurrentTaskGroup()
	triggerToggle(self.rtWeekToggles:Find(self.weekToggle), true)

	return
end

return CrusingTaskLayer
