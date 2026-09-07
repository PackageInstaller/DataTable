local IslandMechaTaskPage = class("IslandMechaTaskPage", import("view.base.BaseActivityPage"))

function IslandMechaTaskPage:OnInit()
	self.item = self._tf:Find("bg/tasks/task")
	self.items = self._tf:Find("bg/tasks")
	self.uilist = UIItemList.New(self.items, self.item)
	self.timeTxt = self._tf:Find("bg/time/Text"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("bg/desc"):GetComponent(typeof(Text))
	self.progressTxt = self._tf:Find("bg/progress"):GetComponent(typeof(Text))
	self.lookAllBtn = self._tf:Find("bg/look_all")
	self.preViewBtn = self._tf:Find("bg/preview")

	setText(self._tf:Find("bg/preview/Text"), i18n("island_mecha_task_preview"))
	setText(self._tf:Find("bg/look_all/Text"), i18n("island_mecha_task_look_all"))

	self.descPage = IslandMechaTaskDescPage.New(pg.UIMgr.GetInstance().OverlayMain, self.event)

	onButton(self, self.preViewBtn, function()
		pg.m02:sendNotification(IslandMediator.OPEN_MACHA_MODEL_PREVIEW)

		return
	end, SFX_PANEL)
	onButton(self, self.lookAllBtn, function()
		self.descPage:ExecuteAction("Show", self.activity:getStartTime(), self.activity:getDayIndex(), self.taskGroup)

		return
	end, SFX_PANEL)
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function IslandMechaTaskPage:OnFirstFlush()
	IslandTaskActhelper.SetNonFirstEnter(self.activity.id)

	return
end

function IslandMechaTaskPage:OnDataSetting()
	self.nday = 0
	self.taskGroup = self.activity:getIslandConfig("config_data")

	return
end

function IslandMechaTaskPage:UpdateTask(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:Find("item")
	local var_7_1 = self.taskGroup[self.nday][arg_7_1 + 1]
	local var_7_2 = IslandTask.New({
		id = self.taskGroup[self.nday][arg_7_1 + 1],
		process_list = {}
	})

	assert(var_7_2, "without this task by id: " .. self.taskGroup[self.nday][arg_7_1 + 1])

	local var_7_3 = var_7_2:GetAwards()[1]

	updateCustomDrop(var_7_0, var_7_3)
	onButton(self, var_7_0, function()
		self:emit(IslandMediator.SHOW_MSG_BOX, {
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_7_3
		})

		return
	end, SFX_PANEL)

	local var_7_4 = arg_7_2:Find("go_btn")
	local var_7_5 = arg_7_2:Find("get_btn")
	local var_7_6 = arg_7_2:Find("got_btn")
	local var_7_7 = arg_7_2:Find("un_finish")
	local var_7_8, var_7_9, var_7_10 = IslandTaskActhelper.GetIslandTaskState(self.taskGroup[self.nday][arg_7_1 + 1])

	setText(arg_7_2:Find("description"), var_7_2:getConfig("task_desc"))
	setText(arg_7_2:Find("progressText"), var_7_8 .. "/" .. var_7_9)
	setSlider(arg_7_2:Find("progress"), 0, var_7_9, var_7_8)

	local var_7_11 = pg.island_task_target[var_7_2:GetTargetList()[1].id]
	local var_7_12 = tonumber(var_7_11.tips)
	local var_7_13 = tonumber(var_7_11.jump_ui)
	local var_7_14 = var_7_12 or var_7_13

	setActive(var_7_7, var_7_10 == 0 and not var_7_14)
	setActive(var_7_4, var_7_10 == 0 and var_7_14)
	setActive(var_7_5, var_7_10 == 1)
	setActive(var_7_6, var_7_10 == 2)
	onButton(self, var_7_4, function()
		if not var_7_14 then
			return
		end

		if var_7_13 then
			self:_SkipBtn(var_7_13)
		elseif var_7_12 then
			if IslandMainBtnTipHelper.IsUnlock("map") then
				self:_SkipObj(var_7_12)
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, var_7_5, function()
		pg.m02:sendNotification(GAME.ISLAND_SUBMIT_TASK, {
			taskId = var_7_1
		})

		return
	end, SFX_PANEL)

	return
end

function IslandMechaTaskPage:UpdateAll()
	if not self.activity then
		return
	end

	self.nday = IslandTaskActhelper.GetNDay(self.activity)

	self:UpdateDay()
	self:UpdateDesc()
	self:UpdateProgress()
	self.uilist:align(#(self.taskGroup[self.nday] or {}))

	return
end

function IslandMechaTaskPage:OnUpdateFlush()
	self:UpdateAll()

	return
end

function IslandMechaTaskPage:OnShowFlush()
	self:UpdateAll()

	return
end

function IslandMechaTaskPage:UpdateDay()
	local var_14_0 = self.activity:getConfig("time")

	self.timeTxt.text = string.format("%d.%d - %d.%d%s", var_14_0[2][1][2], var_14_0[2][1][3], var_14_0[3][1][2], var_14_0[3][1][3], i18n("island_draw_time_1"))

	return
end

function IslandMechaTaskPage:UpdateDesc()
	self.descTxt.text = i18n("island_mecha_task_description")

	return
end

function IslandMechaTaskPage:UpdateProgress()
	self.progressTxt.text = i18n("island_mecha_task_progress", self.nday, #self.taskGroup)

	return
end

function IslandMechaTaskPage:Hide()
	IslandMechaTaskPage.super.Hide(self)

	if self.descPage and self.descPage:isShowing() then
		self.descPage:Hide()
	end

	return
end

function IslandMechaTaskPage:OnDestroy()
	if self.descPage then
		self.descPage:Destroy()

		self.descPage = nil
	end

	eachChild(self.items, function(arg_19_0)
		Destroy(arg_19_0)

		return
	end)

	return
end

function IslandMechaTaskPage:_SkipBtn(arg_20_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_main_btns[arg_20_1].ability_id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_systemnoopen_tips"))

		return
	end

	if pg.island_main_btns[arg_20_1].open_page ~= "" then
		self:emit(IslandMediator.OPEN_PAGE, pg.island_main_btns[arg_20_1].open_page, pg.island_main_btns[arg_20_1].page_param)
	end

	return
end

function IslandMechaTaskPage:_SkipObj(arg_21_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockMap(pg.island_world_objects[arg_21_1].mapId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_placenoopen_tips"))

		return
	end

	self:emit(IslandSeasonPage.CLOSE)

	if _IslandCore then
		if pg.island_world_objects[arg_21_1].mapId == _IslandCore:GetController():GetMapID() then
			return
		end
	end

	self:emit(IslandBaseMediator.SWITCH_MAP, pg.island_world_objects[arg_21_1].mapId, pg.island_map[pg.island_world_objects[arg_21_1].mapId].born_object)

	return
end

return IslandMechaTaskPage
