local SpringFestival2026FireworkAndSpringPage = class("SpringFestival2026FireworkAndSpringPage", import("view.activity.CorePage.CoreActivityBackHillTemplate"))

SpringFestival2026FireworkAndSpringPage.edge2area = {
	default = "_SDPlace"
}
SpringFestival2026FireworkAndSpringPage.EffectPoolCnt = 3
SpringFestival2026FireworkAndSpringPage.Id2EffectName = {
	[65842] = "yanhua_xiaojiajia",
	[65841] = "yanhua_xinxin",
	[65840] = "yanhua_jiezhi",
	[65839] = "yanhua_huangji",
	[65838] = "yanhua_chuanmao",
	[65837] = "yanhua_hongbao",
	[65836] = "yanhua_denglong",
	[65835] = "yanhua_maomao",
	[65834] = "yanhua_02",
	[65833] = "yanhua_01",
	[65531] = "yanhua_hongbao",
	[70178] = "yanhua_denglong",
	[65844] = "yanhua_ma",
	[65843] = "yanhua_2026"
}
SpringFestival2026FireworkAndSpringPage.FireworkRange = Vector2(300, 300)
SpringFestival2026FireworkAndSpringPage.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
SpringFestival2026FireworkAndSpringPage.EffectInterval = 1
SpringFestival2026FireworkAndSpringPage.DelayPop = 2.5
SpringFestival2026FireworkAndSpringPage.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function SpringFestival2026FireworkAndSpringPage:OnInit()
	SpringFestival2026FireworkAndSpringPage.super.OnInit(self)

	self._map = self._tf:Find("BG/map")
	self._shipTpl = self._tf:Find("BG/ship")
	self.fireworksTF = self._tf:Find("BG/fireworks")
	self._SDPlace = self._tf:Find("BG/SDPlace")
	self.containers = {
		self._SDPlace
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.FireworkAndSpringGraph"))
	self.backBtn = self._tf:Find("BG/panel/btn_back")
	self.tipBtn = self._tf:Find("BG/panel/btn_tip")
	self.ptBtn = self._tf:Find("BG/panel/btn_pt")
	self.stage = self._tf:Find("BG/panel/btn_pt/stage")
	self.pt = self._tf:Find("BG/panel/btn_pt/pt")
	self.taskBtn = self._tf:Find("BG/panel/btn_task")
	self.fireworkBtn = self._tf:Find("BG/panel/btn_firework")
	self.springBtn = self._tf:Find("BG/panel/btn_spring")
	self.subPanel = self._tf:Find("BG/subPanel")
	self.subPanelPanel = self.subPanel:Find("panel")
	self.subLeft = self.subPanelPanel:Find("left")
	self.subRight = self.subPanelPanel:Find("right")
	self.subPtBtn = self.subLeft:Find("ptBtn")
	self.subTaskBtn = self.subLeft:Find("taskBtn")
	self.subFireworkBtn = self.subLeft:Find("fireworkBtn")
	self.subSpringBtn = self.subLeft:Find("springBtn")
	self.ptPanel = self.subRight:Find("ptPanel")
	self.taskPanel = self.subRight:Find("taskPanel")
	self.fireworkPanel = self.subRight:Find("fireworkPanel")
	self.springPanel = self.subRight:Find("springPanel")

	return
end

function SpringFestival2026FireworkAndSpringPage:OnFirstFlush()
	self:InitData()
	self:UpdateMainPt()

	self.firePools = {}

	self:PlayFireworks()
	self:InitStudents()
	self:SetTips()
	self:CloseSubPanel()

	self.hasClonedFireworkArrows = false

	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end)
	onButton(self, self.tipBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.firework_2025_tip.tip
		})

		return
	end)
	onButton(self, self.ptBtn, function()
		self:OpenSubPanel(self.ptPanel)
		self:SetPtPanel()

		return
	end)
	onButton(self, self.taskBtn, function()
		self:OpenSubPanel(self.taskPanel)
		self:SetTaskPanel()

		return
	end)
	onButton(self, self.fireworkBtn, function()
		self:OpenSubPanel(self.fireworkPanel)
		self:SetFireWorkPanel()

		return
	end)
	onButton(self, self.springBtn, function()
		self:OpenSubPanel(self.springPanel)
		self:SetSpringPanel()

		return
	end)
	onButton(self, self.ptPanel:Find("btnClose"), function()
		self:CloseSubPanel()
		self:PlayFireworks()

		return
	end)
	onButton(self, self.taskPanel:Find("btnClose"), function()
		self:CloseSubPanel()
		self:PlayFireworks()

		return
	end)
	onButton(self, self.fireworkPanel:Find("btnClose"), function()
		self:CloseSubPanel()
		self:PlayFireworks()

		return
	end)
	onButton(self, self.springPanel:Find("btnClose"), function()
		self:CloseSubPanel()
		self:PlayFireworks()

		return
	end)
	onButton(self, self.subPtBtn, function()
		self:SetSubPanel(self.ptPanel)
		self:SetPtPanel()

		return
	end)
	onButton(self, self.subTaskBtn, function()
		self:SetSubPanel(self.taskPanel)
		self:SetTaskPanel()

		return
	end)
	onButton(self, self.subFireworkBtn, function()
		self:SetSubPanel(self.fireworkPanel)
		self:SetFireWorkPanel()

		return
	end)
	onButton(self, self.subSpringBtn, function()
		self:SetSubPanel(self.springPanel)
		self:SetSpringPanel()

		return
	end)

	return
end

function SpringFestival2026FireworkAndSpringPage:OnUpdateFlush()
	self:UpdateTaskData()
	self:UpdatePtData()
	self:UpdateMainPt()
	self:SetTaskPanel()
	self:UpdateSpringData()
	self:SetPtPanel()
	self:SetTips()
	self:UpdateFireworkData()
	self:SetFireWorkPanel()

	if isActive(self.springPanel) then
		self:UpdateSpringActivityAndUI()
	end

	return
end

function SpringFestival2026FireworkAndSpringPage:InitData()
	self.ptActId = ActivityConst.HorseYearSpringFestival2026_ID_1
	self.taskActId = ActivityConst.HorseYearSpringFestival2026_ID_2
	self.fireworkActId = ActivityConst.HorseYearSpringFestival2026_ID_4
	self.springActId = ActivityConst.HorseYearSpringFestival2026_ID_3

	self:UpdatePtData()
	self:UpdateTaskData()
	self:UpdateFireworkData()
	self:UpdateSpringData()

	return
end

function SpringFestival2026FireworkAndSpringPage:UpdatePtData()
	self.ptActivity = getProxy(ActivityProxy):getActivityById(self.ptActId)
	self.ptData = ActivityPtData.New(self.ptActivity)

	return
end

function SpringFestival2026FireworkAndSpringPage:UpdateTaskData()
	self.taskActivity = getProxy(ActivityProxy):getActivityById(self.taskActId)
	self.taskVOs = {}

	for iter_20_0, iter_20_1 in pairs((self.taskActivity:getConfig("config_data"))) do
		table.insert(self.taskVOs, getProxy(TaskProxy):getTaskVO(iter_20_1))
	end

	self.canGetTaskVOs = {}
	self.canGetTaskIds = {}

	self:sort(self.taskVOs)

	return
end

function SpringFestival2026FireworkAndSpringPage:sort(arg_21_1)
	local var_21_0 = {}

	self.canGetTaskAward = false

	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		if iter_21_1:getTaskStatus() == 1 then
			table.insert(var_21_0, iter_21_1)
			table.insert(self.canGetTaskVOs, iter_21_1)
			table.insert(self.canGetTaskIds, iter_21_1.id)

			self.canGetTaskAward = true
		end
	end

	for iter_21_2, iter_21_3 in pairs(arg_21_1) do
		if iter_21_3:getTaskStatus() == 0 then
			table.insert(var_21_0, iter_21_3)
		end
	end

	for iter_21_4, iter_21_5 in pairs(arg_21_1) do
		if iter_21_5:getTaskStatus() == 2 then
			table.insert(var_21_0, iter_21_5)
		end
	end

	self.taskVOs = var_21_0

	return
end

function SpringFestival2026FireworkAndSpringPage:UpdateFireworkData()
	self.fireworkActivity = getProxy(ActivityProxy):getActivityById(self.fireworkActId)
	self.fireworkUnlockIds = self.fireworkActivity.data1_list
	self.fireworkGotIds = self.fireworkActivity.data2_list
	self.fireworkAllIds = self.fireworkActivity:GetPicturePuzzleIds()
	self.playerId = getProxy(PlayerProxy):getData().id
	self.fireworkOrderIds = self:GetFireWorkLocalData()

	return
end

function SpringFestival2026FireworkAndSpringPage:GetFireWorkLocalData()
	local var_23_0 = {}

	for iter_23_0 = 1, #self.fireworkAllIds do
		local var_23_1 = PlayerPrefs.GetInt("fireworks_" .. self.fireworkActId .. "_" .. self.playerId .. "_pos_" .. iter_23_0)

		if var_23_1 ~= 0 then
			table.insert(var_23_0, var_23_1)
		end
	end

	return var_23_0
end

function SpringFestival2026FireworkAndSpringPage:SetFireWorkLocalData()
	for iter_24_0 = 1, #self.fireworkAllIds do
		PlayerPrefs.SetInt("fireworks_" .. self.fireworkActId .. "_" .. self.playerId .. "_pos_" .. iter_24_0, self.fireworkOrderIds[iter_24_0] or 0)
	end

	return
end

function SpringFestival2026FireworkAndSpringPage:UpdateSpringData()
	self.springActivity = getProxy(ActivityProxy):getActivityById(self.springActId)
	self.springShipIds = _.map(self.springActivity:GetShipIds(), function(arg_26_0)
		if getProxy(BayProxy):RawGetShipById(arg_26_0) then
			return arg_26_0
		else
			return 0
		end

		return
	end)
	self.springMaxCnt = self.springActivity:GetSlotCount()
	self.springSlotLockList = {}
	self.springUnlockSlotCount = self.springActivity:getConfig("config_client").initialCount

	for iter_25_0, iter_25_1 in ipairs(self.springActivity:getConfig("config_client").unlockPt) do
		if iter_25_1 <= self.ptData.count then
			self.springUnlockSlotCount = self.springUnlockSlotCount + 1
		end
	end

	for iter_25_2 = 1, self.springMaxCnt do
		self.springSlotLockList[iter_25_2] = iter_25_2 > self.springUnlockSlotCount
	end

	self.energyRecoverAddition = self.springActivity:GetEnergyRecoverAddition() * 10

	return
end

function SpringFestival2026FireworkAndSpringPage:OpenSubPanel(arg_27_1)
	setActive(self.subPanel, true)
	self:SetSubPanel(arg_27_1)

	return
end

function SpringFestival2026FireworkAndSpringPage:CloseSubPanel()
	setActive(self.subPanel, false)

	return
end

function SpringFestival2026FireworkAndSpringPage:SetSubPanel(arg_29_1)
	setActive(self.ptPanel, false)
	setActive(self.taskPanel, false)
	setActive(self.fireworkPanel, false)
	setActive(self.springPanel, false)
	setActive(arg_29_1, true)
	setActive(self.subPtBtn:Find("selected"), arg_29_1 == self.ptPanel)
	setActive(self.subTaskBtn:Find("selected"), arg_29_1 == self.taskPanel)
	setActive(self.subFireworkBtn:Find("selected"), arg_29_1 == self.fireworkPanel)
	setActive(self.subSpringBtn:Find("selected"), arg_29_1 == self.springPanel)

	return
end

function SpringFestival2026FireworkAndSpringPage:UpdateMainPt()
	setText(self.stage, "Lv." .. self.ptData:GetCurrLevel())

	if not self.ptData:IsMaxLevel() then
		setText(self.pt, self.ptData.count .. "/" .. self.ptData:GetNextLevelTarget())
	else
		setText(self.pt, "MAX")
	end

	return
end

function SpringFestival2026FireworkAndSpringPage:SetPtPanel()
	setText(self.ptPanel:Find("lvText"), self.ptData:GetCurrLevel())

	if not self.ptData:IsMaxLevel() then
		setText(self.ptPanel:Find("pt"), self.ptData.count .. "/" .. self.ptData:GetNextLevelTarget())
		setSlider(self.ptPanel:Find("slider"), 0, self.ptData:GetNextLevelTarget(), self.ptData.count)
	else
		setText(self.ptPanel:Find("pt"), "MAX")
		setSlider(self.ptPanel:Find("slider"), 0, 1, 1)
	end

	setText(self.ptPanel:Find("ptScroll/Viewport/Content/tpl/get/Text"), i18n("firework_2025_get"))
	setText(self.ptPanel:Find("ptScroll/Viewport/Content/tpl/got/Text"), i18n("firework_2025_got"))

	local var_31_0 = UIItemList.New(self.ptPanel:Find("ptScroll/Viewport/Content"), self.ptPanel:Find("ptScroll/Viewport/Content/tpl"))

	var_31_0:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			setText(arg_32_2:Find("level"), i18n("firework_2025_level", arg_32_1 + 1))

			local var_32_1 = Drop.Create(self.ptData.dropList[arg_32_1 + 1])

			updateDrop(arg_32_2:Find("award"), var_32_1)
			onButton(self, arg_32_2:Find("award"), function()
				self:emit(BaseUI.ON_DROP, var_32_1)

				return
			end, SFX_PANEL)

			local var_32_2 = self.ptData:GetDroptItemState(arg_32_1 + 1)

			if var_32_2 == ActivityPtData.STATE_LOCK then
				setActive(arg_32_2:Find("lock"), true)
				setActive(arg_32_2:Find("get"), false)
				setActive(arg_32_2:Find("got"), false)
			elseif var_32_2 == ActivityPtData.STATE_CAN_GET then
				setActive(arg_32_2:Find("lock"), false)
				setActive(arg_32_2:Find("get"), true)
				setActive(arg_32_2:Find("got"), false)
			else
				setActive(arg_32_2:Find("lock"), false)
				setActive(arg_32_2:Find("get"), false)
				setActive(arg_32_2:Find("got"), true)
			end
		end

		return
	end)
	var_31_0:align(#self.ptData.dropList)

	local var_31_1 = rtf(self.ptPanel:Find("ptScroll/Viewport/Content/tpl")).rect.width
	local var_31_2 = self.ptPanel:Find("ptScroll/Viewport/Content"):GetComponent(typeof(HorizontalLayoutGroup)).spacing
	local var_31_3 = rtf(self.ptPanel:Find("ptScroll/Viewport")).rect.width

	scrollTo(self.ptPanel:Find("ptScroll"), self.ptData.level * (var_31_1 + var_31_2) / (#self.ptData.targets * (var_31_1 + var_31_2) - var_31_2 - var_31_3), 0)

	self.importants = self.ptActivity:getConfig("config_client").highValueItemSort
	self.importantsPos = {}

	for iter_31_0, iter_31_1 in ipairs(self.importants) do
		table.insert(self.importantsPos, (iter_31_1 - 6 - 1) * (var_31_1 + var_31_2) / (#self.ptData.targets * (var_31_1 + var_31_2) - var_31_2 - var_31_3))
	end

	self:PtScrollToDo(self.ptData.level * (var_31_1 + var_31_2) / (#self.ptData.targets * (var_31_1 + var_31_2) - var_31_2 - var_31_3))
	onScroll(self, self.ptPanel:Find("ptScroll"), function(arg_34_0)
		self:PtScrollToDo(arg_34_0.x)

		return
	end)

	if self.ptData:CanGetAward() then
		setActive(self.ptPanel:Find("btn_get"), true)
		onButton(self, self.ptPanel:Find("btn_get"), function()
			local var_35_0 = {}
			local var_35_1 = self.ptData:GetAllAvailableAwards()
			local var_35_2 = getProxy(PlayerProxy):getRawData()
			local var_35_3, var_35_4 = Task.StaticJudgeOverflow(var_35_2.gold, var_35_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_35_1)

			if var_35_3 then
				table.insert(var_35_0, function(arg_36_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_35_4,
						onYes = arg_36_0
					})

					return
				end)
			end

			seriesAsync(var_35_0, function()
				self:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 4,
					activity_id = self.ptData:GetId(),
					arg1 = self.ptData:GetCurrTarget()
				})

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(self.ptPanel:Find("btn_get"), false)
		removeOnButton(self.ptPanel:Find("btn_get"))
	end

	setText(self.ptPanel:Find("ptName"), i18n("firework_2025_pt"))

	return
end

function SpringFestival2026FireworkAndSpringPage:PtScrollToDo(arg_38_1)
	local var_38_0 = 0

	for iter_38_0, iter_38_1 in ipairs(self.importantsPos) do
		if arg_38_1 < iter_38_1 or iter_38_0 == #self.importants then
			var_38_0 = self.importants[iter_38_0]

			break
		end
	end

	local var_38_1 = Drop.Create(self.ptData.dropList[var_38_0])

	updateDrop(self.ptPanel:Find("award"), var_38_1)
	onButton(self, self.ptPanel:Find("award"), function()
		self:emit(BaseUI.ON_DROP, var_38_1)

		return
	end, SFX_PANEL)
	setText(self.ptPanel:Find("awardInfo/Text"), i18n("firework_2025_level", var_38_0))
	setActive(self.ptPanel:Find("award/got"), var_38_0 <= self.ptData.level)

	return
end

function SpringFestival2026FireworkAndSpringPage:SetTaskPanel()
	setText(self.taskPanel:Find("lvText"), self.ptData:GetCurrLevel())

	if not self.ptData:IsMaxLevel() then
		setText(self.taskPanel:Find("pt"), self.ptData.count .. "/" .. self.ptData:GetNextLevelTarget())
		setSlider(self.taskPanel:Find("slider"), 0, self.ptData:GetNextLevelTarget(), self.ptData.count)
	else
		setText(self.taskPanel:Find("pt"), "MAX")
		setSlider(self.taskPanel:Find("slider"), 0, 1, 1)
	end

	local var_40_0 = UIItemList.New(self.taskPanel:Find("taskScroll/Viewport/Content"), self.taskPanel:Find("taskScroll/Viewport/Content/Tasktpl"))

	var_40_0:make(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == UIItemList.EventUpdate then
			local var_41_0 = self.taskVOs[arg_41_1 + 1]

			setText(arg_41_2:Find("frame/name"), self.taskVOs[arg_41_1 + 1]:getConfig("name"))
			setText(arg_41_2:Find("frame/desc"), self.taskVOs[arg_41_1 + 1]:getConfig("desc"))

			local var_41_1 = self.taskVOs[arg_41_1 + 1]:getConfig("target_num")
			local var_41_2 = math.min(self.taskVOs[arg_41_1 + 1]:getProgress(), var_41_1)

			setText(arg_41_2:Find("frame/progress"), var_41_2 .. "/" .. var_41_1)

			arg_41_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_41_2 / var_41_1

			local var_41_3 = arg_41_2:Find("frame/awards")

			self:updateTaskAwards(self.taskVOs[arg_41_1 + 1]:getConfig("award_display"), var_41_3, (var_41_3:GetChild(0)))

			local var_41_4 = arg_41_2:Find("frame/go_btn")
			local var_41_5 = arg_41_2:Find("frame/get_btn")
			local var_41_6 = arg_41_2:Find("frame/got_btn")

			if self.taskVOs[arg_41_1 + 1]:getTaskStatus() == 0 then
				setActive(var_41_4, true)
				setActive(var_41_5, false)
				setActive(var_41_6, false)
			elseif self.taskVOs[arg_41_1 + 1]:getTaskStatus() == 1 then
				setActive(var_41_4, false)
				setActive(var_41_5, true)
				setActive(var_41_6, false)
			elseif self.taskVOs[arg_41_1 + 1]:getTaskStatus() == 2 then
				setActive(var_41_4, false)
				setActive(var_41_5, false)
				setActive(var_41_6, true)
			end

			onButton(self, var_41_4, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_41_0)

				return
			end, SFX_PANEL)
			onButton(self, var_41_5, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_41_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_40_0:align(#self.taskVOs)

	if self.canGetTaskAward then
		setActive(self.taskPanel:Find("btn_get"), true)
		onButton(self, self.taskPanel:Find("btn_get"), function()
			local var_44_0 = {}
			local var_44_1 = {}

			for iter_44_0, iter_44_1 in pairs(self.canGetTaskVOs) do
				for iter_44_2, iter_44_3 in ipairs((iter_44_1:getConfig("award_display"))) do
					local var_44_3 = false

					for iter_44_4, iter_44_5 in pairs(var_44_1) do
						if iter_44_5[1] == iter_44_3[1] and iter_44_5[2] == iter_44_3[2] then
							var_44_3 = true
							iter_44_5[3] = iter_44_5[3] + iter_44_3[3]

							break
						end
					end

					if not var_44_3 then
						table.insert(var_44_1, iter_44_3)
					end
				end
			end

			local var_44_4 = getProxy(PlayerProxy):getRawData()
			local var_44_5, var_44_6 = Task.StaticJudgeOverflow(var_44_4.gold, var_44_4.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_44_1)

			if var_44_5 then
				table.insert(var_44_0, function(arg_45_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_44_6,
						onYes = arg_45_0
					})

					return
				end)
			end

			seriesAsync(var_44_0, function()
				self:emit(ActivityMediator.ON_ACTIVITY_TASK_LIST_SUBMIT, {
					activityId = self.taskActId,
					ids = self.canGetTaskIds
				})

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(self.taskPanel:Find("btn_get"), false)
		removeOnButton(self.taskPanel:Find("btn_get"))
	end

	setText(self.taskPanel:Find("ptName"), i18n("firework_2025_pt"))

	return
end

function SpringFestival2026FireworkAndSpringPage:updateTaskAwards(arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = _.slice(arg_47_1, 1, 3)

	for iter_47_0 = arg_47_2.childCount, #var_47_0 - 1 do
		cloneTplTo(arg_47_3, arg_47_2)
	end

	for iter_47_1 = 1, arg_47_2.childCount do
		local var_47_1 = arg_47_2:GetChild(iter_47_1 - 1)
		local var_47_2 = iter_47_1 <= #var_47_0

		setActive(var_47_1, iter_47_1 <= #var_47_0)

		if var_47_2 then
			local var_47_3 = {
				type = var_47_0[iter_47_1][1],
				id = var_47_0[iter_47_1][2],
				count = var_47_0[iter_47_1][3]
			}

			updateDrop(var_47_1, var_47_3)
			onButton(self, var_47_1, function()
				self:emit(BaseUI.ON_DROP, var_47_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function SpringFestival2026FireworkAndSpringPage:SetFireWorkPanel()
	local var_49_0 = self.fireworkPanel:Find("left_panel")
	local var_49_1 = self.fireworkPanel:Find("right_panel")

	self.leftUIList = UIItemList.New(var_49_0:Find("scrollrect/content"), (var_49_0:Find("scrollrect/content/item_tpl")))
	self.rightUIList = UIItemList.New(var_49_1:Find("content"), (var_49_1:Find("content/item_tpl")))

	local var_49_2 = var_49_1:Find("arrows")

	onButton(self, var_49_1:Find("fire_btn"), function()
		self:CloseSubPanel()
		self:PlayFireworks()

		return
	end)
	setText(var_49_1:Find("tip"), i18n("activity_yanhua_tip7"))
	setText(var_49_0:Find("tip"), i18n("firework_2025_tip1"))
	self.leftUIList:make(function(arg_51_0, arg_51_1, arg_51_2)
		if arg_51_0 == UIItemList.EventUpdate then
			local var_51_0 = self.fireworkAllIds[arg_51_1 + 1]

			GetImageSpriteFromAtlasAsync(Item.getConfigData(self.fireworkAllIds[arg_51_1 + 1]).icon, "", (arg_51_2:Find("firework/icon")))

			local var_51_1 = table.contains(self.fireworkOrderIds, self.fireworkAllIds[arg_51_1 + 1])

			setActive(arg_51_2:Find("firework/selected"), var_51_1)

			if not table.contains(self.fireworkUnlockIds, self.fireworkAllIds[arg_51_1 + 1]) then
				setActive(arg_51_2:Find("firework/lock"), true)
				setActive(arg_51_2:Find("firework/get"), false)
			elseif not table.contains(self.fireworkGotIds, self.fireworkAllIds[arg_51_1 + 1]) then
				setActive(arg_51_2:Find("firework/lock"), false)
				setActive(arg_51_2:Find("firework/get"), true)
				onButton(self, arg_51_2, function()
					self:emit(ActivityMediator.EVENT_OPERATION, {
						self.fireworkActId,
						PuzzleActivity.CMD_ACTIVATE,
						var_51_0
					})

					return
				end, SFX_PANEL)
			else
				setActive(arg_51_2:Find("firework/lock"), false)
				setActive(arg_51_2:Find("firework/get"), false)
				onButton(self, arg_51_2, function()
					self:FireworkLeftClick(var_51_0, var_51_1)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	self.leftUIList:align(#self.fireworkAllIds)

	if not self.hasClonedFireworkArrows then
		self.hasClonedFireworkArrows = true

		for iter_49_0 = 1, #self.fireworkAllIds - 2 do
			cloneTplTo(var_49_2:Find("tpl"), var_49_2)
		end
	end

	self.rightUIList:make(function(arg_54_0, arg_54_1, arg_54_2)
		if arg_54_0 == UIItemList.EventUpdate then
			local var_54_0 = arg_54_1 + 1
			local var_54_1 = arg_54_2:Find("icon")

			setActive(arg_54_2:Find("add"), arg_54_1 + 1 > #self.fireworkOrderIds)

			if var_54_0 > #self.fireworkOrderIds then
				setActive(var_54_1, false)
			else
				local var_54_2 = self.fireworkOrderIds[var_54_0]

				setActive(var_54_1, true)
				GetImageSpriteFromAtlasAsync(Item.getConfigData(var_54_2).icon, "", var_54_1)
				onButton(self, var_54_1, function()
					self:FireworkRightClick(var_54_2)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	self.rightUIList:align(#self.fireworkAllIds)

	return
end

function SpringFestival2026FireworkAndSpringPage:FireworkLeftClick(arg_56_1, arg_56_2)
	if arg_56_2 then
		table.removebyvalue(self.fireworkOrderIds, arg_56_1)
	else
		table.insert(self.fireworkOrderIds, arg_56_1)
	end

	self:SetFireWorkLocalData()
	self.leftUIList:align(#self.fireworkAllIds)
	self.rightUIList:align(#self.fireworkAllIds)

	return
end

function SpringFestival2026FireworkAndSpringPage:FireworkRightClick(arg_57_1)
	table.removebyvalue(self.fireworkOrderIds, arg_57_1)
	self:SetFireWorkLocalData()
	self.leftUIList:align(#self.fireworkAllIds)
	self.rightUIList:align(#self.fireworkAllIds)

	return
end

function SpringFestival2026FireworkAndSpringPage:SetSpringPanel()
	self:CreateSpringUI()
	self:UpdateSpringUI()

	return
end

function SpringFestival2026FireworkAndSpringPage:CreateSpringUI()
	setText(self.springPanel:Find("list/iconTpl/lock/Text"), i18n("firework_2025_unlock_tip1"))

	self.springList = UIItemList.New(self.springPanel:Find("list"), self.springPanel:Find("list/iconTpl"))

	self.springList:make(function(arg_60_0, arg_60_1, arg_60_2)
		if arg_60_0 == UIItemList.EventUpdate then
			local var_60_0 = self.springShipIds[arg_60_1 + 1]
			local var_60_1 = self.springSlotLockList[arg_60_1 + 1]
			local var_60_2 = self.springShipIds[arg_60_1 + 1] and var_60_0 > 0

			setActive(arg_60_2:Find("lock"), self.springSlotLockList[arg_60_1 + 1])
			setActive(arg_60_2:Find("add"), not var_60_1 and not var_60_2)
			setActive(arg_60_2:Find("ship"), not var_60_1 and var_60_2)

			if var_60_1 then
				setText(arg_60_2:Find("lock/taskText"), i18n("firework_2025_unlock_tip2", self.springActivity:getConfig("config_client").unlockPt[arg_60_1 + 1 - self.springActivity:getConfig("config_client").initialCount]))
			end

			onButton(self, arg_60_2, function()
				if var_60_1 then
					return
				end

				local var_61_0

				if var_60_2 then
					var_61_0 = getProxy(BayProxy):getShipById(var_60_0)
				end

				self:StopPlayFireworks()
				self:emit(CoreActivityMainMediator.OPEN_CHUANWU, self.springActId, arg_60_1 + 1, var_61_0, self.springUnlockSlotCount)

				return
			end, SFX_PANEL)

			if not var_60_2 then
				return
			end

			local var_60_3 = getProxy(BayProxy):RawGetShipById(var_60_0)

			setImageSprite(arg_60_2:Find("ship/mask/icon"), (LoadSprite("shipyardicon/" .. var_60_3:getPainting())))
			setScrollText(arg_60_2:Find("ship/name/Text"), var_60_3:getName())
		end

		return
	end)
	setText(self.springPanel:Find("tipText1"), i18n("firework_2025_tip2"))
	setText(self.springPanel:Find("tipText2"), "+" .. self.energyRecoverAddition .. "/h")

	return
end

function SpringFestival2026FireworkAndSpringPage:UpdateSpringUI()
	self.springList:align(self.springMaxCnt)

	return
end

function SpringFestival2026FireworkAndSpringPage:UpdateSpringActivityAndUI()
	self:UpdateSpringData()
	self:UpdateSpringUI()
	self:clearStudents()
	self:InitStudents()

	return
end

function SpringFestival2026FireworkAndSpringPage:PlayFireworks()
	self.fireworks = Clone(self.fireworkOrderIds)

	if #self.fireworks == 0 then
		return
	end

	eachChild(self.fireworksTF, function(arg_65_0)
		setActive(arg_65_0, false)

		return
	end)
	setActive(self.fireworksTF, true)
	self:StopFireworksTimer()

	self.fireworkIndex = 1
	self.fireworksTimer = Timer.New(function()
		self:PlayerOneFirework()

		return
	end, SpringFestival2026FireworkAndSpringPage.EffectInterval, #self.fireworks)

	self.fireworksTimer:Start()

	return
end

function SpringFestival2026FireworkAndSpringPage:PlayerOneFirework()
	if self.fireworkIndex == #self.fireworks then
		self:managedTween(LeanTween.delayedCall, function()
			if self.fireworks then
				self:StopPlayFireworks()
				self:PlayFireworks()
			end

			return
		end, SpringFestival2026FireworkAndSpringPage.DelayPop, nil)
	end

	local var_67_0 = self.fireworks[self.fireworkIndex]
	local var_67_1 = math.random(#SpringFestival2026FireworkAndSpringPage.SFX_LIST)

	if self.firePools[self.fireworks[self.fireworkIndex]] and #self.firePools[var_67_0] >= SpringFestival2026FireworkAndSpringPage.EffectPoolCnt then
		setLocalPosition(self.firePools[var_67_0][1], self:GetFireworkPos())
		setActive(self.firePools[var_67_0][1], true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SpringFestival2026FireworkAndSpringPage.SFX_LIST[var_67_1])
		table.removebyvalue(self.firePools[var_67_0], self.firePools[var_67_0][1])
		table.insert(self.firePools[var_67_0], self.firePools[var_67_0][1])
	else
		self.loader:GetPrefab("ui/" .. SpringFestival2026FireworkAndSpringPage.Id2EffectName[var_67_0], "", function(arg_69_0)
			pg.ViewUtils.SetSortingOrder(arg_69_0, 1)
			setParent(arg_69_0, self.fireworksTF)
			setLocalPosition(arg_69_0, self:GetFireworkPos())
			setActive(arg_69_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SpringFestival2026FireworkAndSpringPage.SFX_LIST[var_67_1])

			self.firePools[var_67_0] = self.firePools[var_67_0] or {}

			table.insert(self.firePools[var_67_0], arg_69_0)

			return
		end)
	end

	self.fireworkIndex = self.fireworkIndex + 1

	return
end

function SpringFestival2026FireworkAndSpringPage:GetFireworkPos()
	local var_70_0 = Vector2(0, 0)

	if self.lastPos then
		local var_70_1 = Vector2(self.lastPos.x, self.lastPos.y)
		local var_70_2 = math.abs(var_70_1.x - self.lastPos.x)
		local var_70_3 = math.abs(var_70_1.y - self.lastPos.y)

		while var_70_2 < SpringFestival2026FireworkAndSpringPage.FireworkRange.x / 2 and var_70_3 < SpringFestival2026FireworkAndSpringPage.FireworkRange.y or var_70_3 < SpringFestival2026FireworkAndSpringPage.FireworkRange.y / 2 and var_70_2 < SpringFestival2026FireworkAndSpringPage.FireworkRange.x do
			var_70_1.x = math.random(SpringFestival2026FireworkAndSpringPage.EffectPosLimit.limitX[1], SpringFestival2026FireworkAndSpringPage.EffectPosLimit.limitX[2])
			var_70_1.y = math.random(SpringFestival2026FireworkAndSpringPage.EffectPosLimit.limitY[1], SpringFestival2026FireworkAndSpringPage.EffectPosLimit.limitY[2])
			var_70_2 = math.abs(var_70_1.x - self.lastPos.x)
			var_70_3 = math.abs(var_70_1.y - self.lastPos.y)
		end

		var_70_0 = var_70_1
	else
		var_70_0.x = math.random(SpringFestival2026FireworkAndSpringPage.EffectPosLimit.limitX[1], SpringFestival2026FireworkAndSpringPage.EffectPosLimit.limitX[2])
		var_70_0.y = math.random(SpringFestival2026FireworkAndSpringPage.EffectPosLimit.limitY[1], SpringFestival2026FireworkAndSpringPage.EffectPosLimit.limitY[2])
	end

	self.lastPos = var_70_0

	return var_70_0
end

function SpringFestival2026FireworkAndSpringPage:StopFireworksTimer()
	if self.fireworksTimer then
		self.fireworksTimer:Stop()

		self.fireworksTimer = nil
	end

	return
end

function SpringFestival2026FireworkAndSpringPage:StopPlayFireworks()
	self:StopFireworksTimer()

	self.fireworks = nil
	self.fireworkIndex = nil

	setActive(self.fireworksTF, false)

	return
end

function SpringFestival2026FireworkAndSpringPage:getStudents(arg_73_1, arg_73_2)
	local var_73_0 = {}
	local var_73_1 = {}

	if not self.springActivity then
		return var_73_0
	end

	local var_73_2 = self.springActivity:GetShipIds()

	for iter_73_0 = 1, self.springMaxCnt do
		if var_73_2[iter_73_0] and var_73_2[iter_73_0] ~= 0 then
			local var_73_3 = getProxy(BayProxy):RawGetShipById(var_73_2[iter_73_0])

			if var_73_3 then
				table.insert(var_73_1, var_73_3)
			end
		end
	end

	if not arg_73_1 or not arg_73_2 then
		arg_73_1 = #var_73_1
		arg_73_2 = #var_73_1
	end

	local var_73_4 = math.random(arg_73_1, arg_73_2)

	while var_73_4 > 0 and #var_73_1 > 0 do
		local var_73_5 = math.random(1, #var_73_1)

		table.insert(var_73_0, var_73_1[var_73_5]:getPrefab())

		var_73_1[var_73_5] = var_73_1[#var_73_1]
		var_73_4 = var_73_4 - 1
	end

	return var_73_0
end

function SpringFestival2026FireworkAndSpringPage:InitStudents(arg_74_1, arg_74_2)
	local var_74_0 = self:getStudents(arg_74_1, arg_74_2)
	local var_74_1 = {}

	for iter_74_0, iter_74_1 in pairs(self.graphPath.points) do
		if not iter_74_1.outRandom then
			table.insert(var_74_1, iter_74_1)
		end
	end

	self.academyStudents = {}

	local var_74_2 = {}

	for iter_74_2, iter_74_3 in pairs(var_74_0) do
		if not self.academyStudents[iter_74_2] then
			local var_74_3 = cloneTplTo(self._shipTpl, self._map)

			var_74_3.gameObject.name = iter_74_2

			local var_74_4 = self:ChooseRandomPos(var_74_1, #var_74_1)
			local var_74_6 = SummerFeastNavigationAgent.New(var_74_3.gameObject)

			var_74_6.normalSpeed = 100

			var_74_6:attach()
			var_74_6:setPathFinder(self.graphPath)
			var_74_6:SetPositionTable(var_74_2)
			var_74_6:setCurrentIndex(var_74_4 and var_74_4.id)
			var_74_6:SetOnTransEdge(function(arg_75_0, arg_75_1, arg_75_2)
				arg_75_2 = math.max(arg_75_1, arg_75_2)
				arg_75_1 = math.min(arg_75_1, arg_75_2)

				arg_75_0._tf:SetParent(self[self.edge2area[arg_75_1 .. "_" .. arg_75_2] or self.edge2area.default])

				return
			end)
			var_74_6:updateStudent(iter_74_3)

			self.academyStudents[iter_74_2] = var_74_6
		end
	end

	if #var_74_0 > 0 then
		self.sortTimer = Timer.New(function()
			self:sortStudents()

			return
		end, 0.2, -1)

		self.sortTimer:Start()
		self.sortTimer.func()
	end

	return
end

function SpringFestival2026FireworkAndSpringPage:ChooseRandomPos(arg_77_1, arg_77_2)
	local var_77_0 = math.random(1, arg_77_2)

	if not var_77_0 then
		return nil
	end

	pg.Tool.Swap(arg_77_1, var_77_0, arg_77_2)

	return arg_77_1[arg_77_2]
end

function SpringFestival2026FireworkAndSpringPage:SetTips()
	self:SetPtTip()
	self:SetTaskTip()
	self:SetFireworkTip()
	self:SetSpringTip()

	return
end

function SpringFestival2026FireworkAndSpringPage:SetPtTip()
	local var_79_0 = self.ptData:CanGetAward()

	setActive(self.ptBtn:Find("tip"), var_79_0)
	setActive(self.subPtBtn:Find("tip"), var_79_0)

	return
end

function SpringFestival2026FireworkAndSpringPage:SetTaskTip()
	setActive(self.taskBtn:Find("tip"), self.canGetTaskAward)
	setActive(self.subTaskBtn:Find("tip"), self.canGetTaskAward)

	return
end

function SpringFestival2026FireworkAndSpringPage:SetFireworkTip()
	local var_81_0 = #self.fireworkUnlockIds ~= #self.fireworkGotIds

	setActive(self.fireworkBtn:Find("tip"), #self.fireworkUnlockIds ~= #self.fireworkGotIds)
	setActive(self.subFireworkBtn:Find("tip"), var_81_0)

	return
end

function SpringFestival2026FireworkAndSpringPage:SetSpringTip()
	local var_82_0 = false

	for iter_82_0 = 1, self.springUnlockSlotCount do
		if self.springShipIds[iter_82_0] == 0 then
			var_82_0 = true

			break
		end
	end

	setActive(self.springBtn:Find("tip"), var_82_0)
	setActive(self.subSpringBtn:Find("tip"), var_82_0)

	return
end

function SpringFestival2026FireworkAndSpringPage:OnDestroy()
	self:CloseSubPanel()
	self:StopPlayFireworks()
	self:clearStudents()
	SpringFestival2026FireworkAndSpringPage.super.OnDestroy(self)

	return
end

return SpringFestival2026FireworkAndSpringPage
