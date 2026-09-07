local FireworkAndSpringScene = class("FireworkAndSpringScene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function FireworkAndSpringScene:getUIName()
	return "FireworkAndSpringUI"
end

FireworkAndSpringScene.edge2area = {
	default = "_SDPlace"
}
FireworkAndSpringScene.EffectPoolCnt = 3
FireworkAndSpringScene.Id2EffectName = {
	[65522] = "yanhua_02",
	[65529] = "yanhua_xinxin",
	[65521] = "yanhua_01",
	[65530] = "yanhua_xiaojiajia",
	[65528] = "yanhua_jiezhi",
	[70175] = "yanhua_2024",
	[65527] = "yanhua_huangji",
	[65531] = "yanhua_hongbao",
	[65526] = "yanhua_chuanmao",
	[65532] = "yanhua_she",
	[65525] = "yanhua_2025",
	[65524] = "yanhua_denglong",
	[65523] = "yanhua_maomao",
	[70178] = "yanhua_denglong"
}
FireworkAndSpringScene.FireworkRange = Vector2(300, 300)
FireworkAndSpringScene.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
FireworkAndSpringScene.EffectInterval = 1
FireworkAndSpringScene.DelayPop = 2.5
FireworkAndSpringScene.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function FireworkAndSpringScene:init()
	self:InitData()
	FireworkAndSpringScene.super.init(self)

	self._map = self._tf:Find("map")
	self._shipTpl = self._tf:Find("ship")
	self.fireworksTF = self._tf:Find("fireworks")
	self._SDPlace = self._tf:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.FireworkAndSpringGraph"))
	self.backBtn = self._tf:Find("panel/btn_back")
	self.tipBtn = self._tf:Find("panel/btn_tip")
	self.ptBtn = self._tf:Find("panel/btn_pt")
	self.stage = self._tf:Find("panel/btn_pt/stage")
	self.pt = self._tf:Find("panel/btn_pt/pt")
	self.taskBtn = self._tf:Find("panel/btn_task")
	self.fireworkBtn = self._tf:Find("panel/btn_firework")
	self.springBtn = self._tf:Find("panel/btn_spring")
	self.subPanel = self._tf:Find("subPanel")
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

function FireworkAndSpringScene:didEnter()
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
	onButton(self, self.subPanel, function()
		self:CloseSubPanel()
		self:PlayFireworks()

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

function FireworkAndSpringScene:InitData()
	self.ptActId = ActivityConst.FireworkAndSpring_PT_ID
	self.taskActId = ActivityConst.FireworkAndSpring_TASK_ID
	self.fireworkActId = ActivityConst.FireworkAndSpring_ACT_ID
	self.springActId = ActivityConst.FireworkAndSpring_EMO_ID

	self:UpdatePtData()
	self:UpdateTaskData()
	self:UpdateFireworkData()
	self:UpdateSpringData()

	return
end

function FireworkAndSpringScene:UpdatePtData()
	self.ptActivity = getProxy(ActivityProxy):getActivityById(self.ptActId)
	self.ptData = ActivityPtData.New(self.ptActivity)

	return
end

function FireworkAndSpringScene:UpdateTaskData()
	self.taskActivity = getProxy(ActivityProxy):getActivityById(self.taskActId)
	self.taskVOs = {}

	for iter_21_0, iter_21_1 in pairs((self.taskActivity:getConfig("config_data"))) do
		table.insert(self.taskVOs, getProxy(TaskProxy):getTaskVO(iter_21_1))
	end

	self.canGetTaskVOs = {}
	self.canGetTaskIds = {}

	self:sort(self.taskVOs)

	return
end

function FireworkAndSpringScene:sort(arg_22_1)
	local var_22_0 = {}

	self.canGetTaskAward = false

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		if iter_22_1:getTaskStatus() == 1 then
			table.insert(var_22_0, iter_22_1)
			table.insert(self.canGetTaskVOs, iter_22_1)
			table.insert(self.canGetTaskIds, iter_22_1.id)

			self.canGetTaskAward = true
		end
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_1) do
		if iter_22_3:getTaskStatus() == 0 then
			table.insert(var_22_0, iter_22_3)
		end
	end

	for iter_22_4, iter_22_5 in pairs(arg_22_1) do
		if iter_22_5:getTaskStatus() == 2 then
			table.insert(var_22_0, iter_22_5)
		end
	end

	self.taskVOs = var_22_0

	return
end

function FireworkAndSpringScene:UpdateFireworkData()
	self.fireworkActivity = getProxy(ActivityProxy):getActivityById(self.fireworkActId)
	self.fireworkUnlockIds = self.fireworkActivity.data1_list
	self.fireworkGotIds = self.fireworkActivity.data2_list
	self.fireworkAllIds = self.fireworkActivity:GetPicturePuzzleIds()
	self.playerId = getProxy(PlayerProxy):getData().id
	self.fireworkOrderIds = self:GetFireWorkLocalData()

	return
end

function FireworkAndSpringScene:GetFireWorkLocalData()
	local var_24_0 = {}

	for iter_24_0 = 1, #self.fireworkAllIds do
		local var_24_1 = PlayerPrefs.GetInt("fireworks_" .. self.fireworkActId .. "_" .. self.playerId .. "_pos_" .. iter_24_0)

		if var_24_1 ~= 0 then
			table.insert(var_24_0, var_24_1)
		end
	end

	return var_24_0
end

function FireworkAndSpringScene:SetFireWorkLocalData()
	for iter_25_0 = 1, #self.fireworkAllIds do
		PlayerPrefs.SetInt("fireworks_" .. self.fireworkActId .. "_" .. self.playerId .. "_pos_" .. iter_25_0, self.fireworkOrderIds[iter_25_0] or 0)
	end

	return
end

function FireworkAndSpringScene:UpdateSpringData()
	self.springActivity = getProxy(ActivityProxy):getActivityById(self.springActId)
	self.springShipIds = _.map(self.springActivity:GetShipIds(), function(arg_27_0)
		if getProxy(BayProxy):RawGetShipById(arg_27_0) then
			return arg_27_0
		else
			return 0
		end

		return
	end)
	self.springMaxCnt = self.springActivity:GetSlotCount()
	self.springSlotLockList = {}
	self.springUnlockSlotCount = self.springActivity:getConfig("config_client").initialCount

	for iter_26_0, iter_26_1 in ipairs(self.springActivity:getConfig("config_client").unlockPt) do
		if iter_26_1 <= self.ptData.count then
			self.springUnlockSlotCount = self.springUnlockSlotCount + 1
		end
	end

	for iter_26_2 = 1, self.springMaxCnt do
		self.springSlotLockList[iter_26_2] = iter_26_2 > self.springUnlockSlotCount
	end

	self.energyRecoverAddition = self.springActivity:GetEnergyRecoverAddition() * 10

	return
end

function FireworkAndSpringScene:OpenSubPanel(arg_28_1)
	setActive(self.subPanel, true)
	self:SetSubPanel(arg_28_1)
	pg.UIMgr.GetInstance():BlurPanel(self.subPanelPanel)

	return
end

function FireworkAndSpringScene:CloseSubPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.subPanelPanel, self.subPanel)
	setActive(self.subPanel, false)

	return
end

function FireworkAndSpringScene:SetSubPanel(arg_30_1)
	setActive(self.ptPanel, false)
	setActive(self.taskPanel, false)
	setActive(self.fireworkPanel, false)
	setActive(self.springPanel, false)
	setActive(arg_30_1, true)
	setActive(self.subPtBtn:Find("selected"), arg_30_1 == self.ptPanel)
	setActive(self.subTaskBtn:Find("selected"), arg_30_1 == self.taskPanel)
	setActive(self.subFireworkBtn:Find("selected"), arg_30_1 == self.fireworkPanel)
	setActive(self.subSpringBtn:Find("selected"), arg_30_1 == self.springPanel)

	return
end

function FireworkAndSpringScene:UpdateMainPt()
	setText(self.stage, "Lv." .. self.ptData:GetCurrLevel())

	if not self.ptData:IsMaxLevel() then
		setText(self.pt, self.ptData.count .. "/" .. self.ptData:GetNextLevelTarget())
	else
		setText(self.pt, "MAX")
	end

	return
end

function FireworkAndSpringScene:SetPtPanel()
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

	local var_32_0 = UIItemList.New(self.ptPanel:Find("ptScroll/Viewport/Content"), self.ptPanel:Find("ptScroll/Viewport/Content/tpl"))

	var_32_0:make(function(arg_33_0, arg_33_1, arg_33_2)
		if arg_33_0 == UIItemList.EventUpdate then
			setText(arg_33_2:Find("level"), i18n("firework_2025_level", arg_33_1 + 1))

			local var_33_1 = Drop.Create(self.ptData.dropList[arg_33_1 + 1])

			updateDrop(arg_33_2:Find("award"), var_33_1)
			onButton(self, arg_33_2:Find("award"), function()
				self:emit(BaseUI.ON_DROP, var_33_1)

				return
			end, SFX_PANEL)

			local var_33_2 = self.ptData:GetDroptItemState(arg_33_1 + 1)

			if var_33_2 == ActivityPtData.STATE_LOCK then
				setActive(arg_33_2:Find("lock"), true)
				setActive(arg_33_2:Find("get"), false)
				setActive(arg_33_2:Find("got"), false)
			elseif var_33_2 == ActivityPtData.STATE_CAN_GET then
				setActive(arg_33_2:Find("lock"), false)
				setActive(arg_33_2:Find("get"), true)
				setActive(arg_33_2:Find("got"), false)
			else
				setActive(arg_33_2:Find("lock"), false)
				setActive(arg_33_2:Find("get"), false)
				setActive(arg_33_2:Find("got"), true)
			end
		end

		return
	end)
	var_32_0:align(#self.ptData.dropList)

	local var_32_1 = rtf(self.ptPanel:Find("ptScroll/Viewport/Content/tpl")).rect.width
	local var_32_2 = self.ptPanel:Find("ptScroll/Viewport/Content"):GetComponent(typeof(HorizontalLayoutGroup)).spacing
	local var_32_3 = rtf(self.ptPanel:Find("ptScroll/Viewport")).rect.width

	scrollTo(self.ptPanel:Find("ptScroll"), self.ptData.level * (var_32_1 + var_32_2) / (#self.ptData.targets * (var_32_1 + var_32_2) - var_32_2 - var_32_3), 0)

	self.importants = self.ptActivity:getConfig("config_client").highValueItemSort
	self.importantsPos = {}

	for iter_32_0, iter_32_1 in ipairs(self.importants) do
		table.insert(self.importantsPos, (iter_32_1 - 6 - 1) * (var_32_1 + var_32_2) / (#self.ptData.targets * (var_32_1 + var_32_2) - var_32_2 - var_32_3))
	end

	self:PtScrollToDo(self.ptData.level * (var_32_1 + var_32_2) / (#self.ptData.targets * (var_32_1 + var_32_2) - var_32_2 - var_32_3))
	onScroll(self, self.ptPanel:Find("ptScroll"), function(arg_35_0)
		self:PtScrollToDo(arg_35_0.x)

		return
	end)

	if self.ptData:CanGetAward() then
		setActive(self.ptPanel:Find("btn_get"), true)
		onButton(self, self.ptPanel:Find("btn_get"), function()
			local var_36_0 = {}
			local var_36_1 = self.ptData:GetAllAvailableAwards()
			local var_36_2 = getProxy(PlayerProxy):getRawData()
			local var_36_3, var_36_4 = Task.StaticJudgeOverflow(var_36_2.gold, var_36_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_36_1)

			if var_36_3 then
				table.insert(var_36_0, function(arg_37_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_36_4,
						onYes = arg_37_0
					})

					return
				end)
			end

			seriesAsync(var_36_0, function()
				self:emit(FireworkAndSpringMediator.EVENT_PT_OPERATION, {
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

function FireworkAndSpringScene:PtScrollToDo(arg_39_1)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs(self.importantsPos) do
		if arg_39_1 < iter_39_1 or iter_39_0 == #self.importants then
			var_39_0 = self.importants[iter_39_0]

			break
		end
	end

	local var_39_1 = Drop.Create(self.ptData.dropList[var_39_0])

	updateDrop(self.ptPanel:Find("award"), var_39_1)
	onButton(self, self.ptPanel:Find("award"), function()
		self:emit(BaseUI.ON_DROP, var_39_1)

		return
	end, SFX_PANEL)
	setText(self.ptPanel:Find("awardInfo/Text"), i18n("firework_2025_level", var_39_0))
	setActive(self.ptPanel:Find("award/got"), var_39_0 <= self.ptData.level)

	return
end

function FireworkAndSpringScene:SetTaskPanel()
	setText(self.taskPanel:Find("lvText"), self.ptData:GetCurrLevel())

	if not self.ptData:IsMaxLevel() then
		setText(self.taskPanel:Find("pt"), self.ptData.count .. "/" .. self.ptData:GetNextLevelTarget())
		setSlider(self.taskPanel:Find("slider"), 0, self.ptData:GetNextLevelTarget(), self.ptData.count)
	else
		setText(self.taskPanel:Find("pt"), "MAX")
		setSlider(self.taskPanel:Find("slider"), 0, 1, 1)
	end

	local var_41_0 = UIItemList.New(self.taskPanel:Find("taskScroll/Viewport/Content"), self.taskPanel:Find("taskScroll/Viewport/Content/Tasktpl"))

	var_41_0:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventUpdate then
			local var_42_0 = self.taskVOs[arg_42_1 + 1]

			setText(arg_42_2:Find("frame/name"), self.taskVOs[arg_42_1 + 1]:getConfig("name"))
			setText(arg_42_2:Find("frame/desc"), self.taskVOs[arg_42_1 + 1]:getConfig("desc"))

			local var_42_1 = self.taskVOs[arg_42_1 + 1]:getConfig("target_num")
			local var_42_2 = math.min(self.taskVOs[arg_42_1 + 1]:getProgress(), var_42_1)

			setText(arg_42_2:Find("frame/progress"), var_42_2 .. "/" .. var_42_1)

			arg_42_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_42_2 / var_42_1

			local var_42_3 = arg_42_2:Find("frame/awards")

			self:updateTaskAwards(self.taskVOs[arg_42_1 + 1]:getConfig("award_display"), var_42_3, (var_42_3:GetChild(0)))

			local var_42_4 = arg_42_2:Find("frame/go_btn")
			local var_42_5 = arg_42_2:Find("frame/get_btn")
			local var_42_6 = arg_42_2:Find("frame/got_btn")

			if self.taskVOs[arg_42_1 + 1]:getTaskStatus() == 0 then
				setActive(var_42_4, true)
				setActive(var_42_5, false)
				setActive(var_42_6, false)
			elseif self.taskVOs[arg_42_1 + 1]:getTaskStatus() == 1 then
				setActive(var_42_4, false)
				setActive(var_42_5, true)
				setActive(var_42_6, false)
			elseif self.taskVOs[arg_42_1 + 1]:getTaskStatus() == 2 then
				setActive(var_42_4, false)
				setActive(var_42_5, false)
				setActive(var_42_6, true)
			end

			onButton(self, var_42_4, function()
				self:emit(FireworkAndSpringMediator.ON_TASK_GO, var_42_0)

				return
			end, SFX_PANEL)
			onButton(self, var_42_5, function()
				self:emit(FireworkAndSpringMediator.ON_TASK_SUBMIT, var_42_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_41_0:align(#self.taskVOs)

	if self.canGetTaskAward then
		setActive(self.taskPanel:Find("btn_get"), true)
		onButton(self, self.taskPanel:Find("btn_get"), function()
			local var_45_0 = {}
			local var_45_1 = {}

			for iter_45_0, iter_45_1 in pairs(self.canGetTaskVOs) do
				for iter_45_2, iter_45_3 in ipairs((iter_45_1:getConfig("award_display"))) do
					local var_45_3 = false

					for iter_45_4, iter_45_5 in pairs(var_45_1) do
						if iter_45_5[1] == iter_45_3[1] and iter_45_5[2] == iter_45_3[2] then
							var_45_3 = true
							iter_45_5[3] = iter_45_5[3] + iter_45_3[3]

							break
						end
					end

					if not var_45_3 then
						table.insert(var_45_1, iter_45_3)
					end
				end
			end

			local var_45_4 = getProxy(PlayerProxy):getRawData()
			local var_45_5, var_45_6 = Task.StaticJudgeOverflow(var_45_4.gold, var_45_4.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_45_1)

			if var_45_5 then
				table.insert(var_45_0, function(arg_46_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_45_6,
						onYes = arg_46_0
					})

					return
				end)
			end

			seriesAsync(var_45_0, function()
				self:emit(FireworkAndSpringMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActId, self.canGetTaskIds)

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

function FireworkAndSpringScene:updateTaskAwards(arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = _.slice(arg_48_1, 1, 3)

	for iter_48_0 = arg_48_2.childCount, #var_48_0 - 1 do
		cloneTplTo(arg_48_3, arg_48_2)
	end

	for iter_48_1 = 1, arg_48_2.childCount do
		local var_48_1 = arg_48_2:GetChild(iter_48_1 - 1)
		local var_48_2 = iter_48_1 <= #var_48_0

		setActive(var_48_1, iter_48_1 <= #var_48_0)

		if var_48_2 then
			local var_48_3 = {
				type = var_48_0[iter_48_1][1],
				id = var_48_0[iter_48_1][2],
				count = var_48_0[iter_48_1][3]
			}

			updateDrop(var_48_1, var_48_3)
			onButton(self, var_48_1, function()
				self:emit(BaseUI.ON_DROP, var_48_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function FireworkAndSpringScene:SetFireWorkPanel()
	local var_50_0 = self.fireworkPanel:Find("left_panel")
	local var_50_1 = self.fireworkPanel:Find("right_panel")

	self.leftUIList = UIItemList.New(var_50_0:Find("scrollrect/content"), (var_50_0:Find("scrollrect/content/item_tpl")))
	self.rightUIList = UIItemList.New(var_50_1:Find("content"), (var_50_1:Find("content/item_tpl")))

	local var_50_2 = var_50_1:Find("arrows")

	onButton(self, var_50_1:Find("fire_btn"), function()
		self:CloseSubPanel()
		self:PlayFireworks()

		return
	end)
	setText(var_50_1:Find("tip"), i18n("activity_yanhua_tip7"))
	setText(var_50_0:Find("tip"), i18n("firework_2025_tip1"))
	self.leftUIList:make(function(arg_52_0, arg_52_1, arg_52_2)
		if arg_52_0 == UIItemList.EventUpdate then
			local var_52_0 = self.fireworkAllIds[arg_52_1 + 1]

			GetImageSpriteFromAtlasAsync(Item.getConfigData(self.fireworkAllIds[arg_52_1 + 1]).icon, "", (arg_52_2:Find("firework/icon")))

			local var_52_1 = table.contains(self.fireworkOrderIds, self.fireworkAllIds[arg_52_1 + 1])

			setActive(arg_52_2:Find("firework/selected"), var_52_1)

			if not table.contains(self.fireworkUnlockIds, self.fireworkAllIds[arg_52_1 + 1]) then
				setActive(arg_52_2:Find("firework/lock"), true)
				setActive(arg_52_2:Find("firework/get"), false)
			elseif not table.contains(self.fireworkGotIds, self.fireworkAllIds[arg_52_1 + 1]) then
				setActive(arg_52_2:Find("firework/lock"), false)
				setActive(arg_52_2:Find("firework/get"), true)
				onButton(self, arg_52_2, function()
					self:emit(FireworkAndSpringMediator.ACTIVITY_OPERATION, self.fireworkActId, var_52_0)

					return
				end, SFX_PANEL)
			else
				setActive(arg_52_2:Find("firework/lock"), false)
				setActive(arg_52_2:Find("firework/get"), false)
				onButton(self, arg_52_2, function()
					self:FireworkLeftClick(var_52_0, var_52_1)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	self.leftUIList:align(#self.fireworkAllIds)

	if not self.hasClonedFireworkArrows then
		self.hasClonedFireworkArrows = true

		for iter_50_0 = 1, #self.fireworkAllIds - 2 do
			cloneTplTo(var_50_2:Find("tpl"), var_50_2)
		end
	end

	self.rightUIList:make(function(arg_55_0, arg_55_1, arg_55_2)
		if arg_55_0 == UIItemList.EventUpdate then
			local var_55_0 = arg_55_1 + 1
			local var_55_1 = arg_55_2:Find("icon")

			setActive(arg_55_2:Find("add"), arg_55_1 + 1 > #self.fireworkOrderIds)

			if var_55_0 > #self.fireworkOrderIds then
				setActive(var_55_1, false)
			else
				local var_55_2 = self.fireworkOrderIds[var_55_0]

				setActive(var_55_1, true)
				GetImageSpriteFromAtlasAsync(Item.getConfigData(var_55_2).icon, "", var_55_1)
				onButton(self, var_55_1, function()
					self:FireworkRightClick(var_55_2)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	self.rightUIList:align(#self.fireworkAllIds)

	return
end

function FireworkAndSpringScene:FireworkLeftClick(arg_57_1, arg_57_2)
	if arg_57_2 then
		table.removebyvalue(self.fireworkOrderIds, arg_57_1)
	else
		table.insert(self.fireworkOrderIds, arg_57_1)
	end

	self:SetFireWorkLocalData()
	self.leftUIList:align(#self.fireworkAllIds)
	self.rightUIList:align(#self.fireworkAllIds)

	return
end

function FireworkAndSpringScene:FireworkRightClick(arg_58_1)
	table.removebyvalue(self.fireworkOrderIds, arg_58_1)
	self:SetFireWorkLocalData()
	self.leftUIList:align(#self.fireworkAllIds)
	self.rightUIList:align(#self.fireworkAllIds)

	return
end

function FireworkAndSpringScene:SetSpringPanel()
	self:CreateSpringUI()
	self:UpdateSpringUI()

	return
end

function FireworkAndSpringScene:CreateSpringUI()
	setText(self.springPanel:Find("list/iconTpl/lock/Text"), i18n("firework_2025_unlock_tip1"))

	self.springList = UIItemList.New(self.springPanel:Find("list"), self.springPanel:Find("list/iconTpl"))

	self.springList:make(function(arg_61_0, arg_61_1, arg_61_2)
		if arg_61_0 == UIItemList.EventUpdate then
			local var_61_0 = self.springShipIds[arg_61_1 + 1]
			local var_61_1 = self.springSlotLockList[arg_61_1 + 1]
			local var_61_2 = self.springShipIds[arg_61_1 + 1] and var_61_0 > 0

			setActive(arg_61_2:Find("lock"), self.springSlotLockList[arg_61_1 + 1])
			setActive(arg_61_2:Find("add"), not var_61_1 and not var_61_2)
			setActive(arg_61_2:Find("ship"), not var_61_1 and var_61_2)

			if var_61_1 then
				setText(arg_61_2:Find("lock/taskText"), i18n("firework_2025_unlock_tip2", self.springActivity:getConfig("config_client").unlockPt[arg_61_1 + 1 - self.springActivity:getConfig("config_client").initialCount]))
			end

			onButton(self, arg_61_2, function()
				if var_61_1 then
					return
				end

				local var_62_0

				if var_61_2 then
					var_62_0 = getProxy(BayProxy):getShipById(var_61_0)
				end

				self:StopPlayFireworks()
				self:emit(FireworkAndSpringMediator.OPEN_CHUANWU, self.springActId, arg_61_1 + 1, var_62_0, self.springUnlockSlotCount)

				return
			end, SFX_PANEL)

			if not var_61_2 then
				return
			end

			local var_61_3 = getProxy(BayProxy):RawGetShipById(var_61_0)

			setImageSprite(arg_61_2:Find("ship/mask/icon"), (LoadSprite("shipyardicon/" .. var_61_3:getPainting())))
			setText(arg_61_2:Find("ship/name/Text"), var_61_3:getName())
		end

		return
	end)
	setText(self.springPanel:Find("tipText1"), i18n("firework_2025_tip2"))
	setText(self.springPanel:Find("tipText2"), "+" .. self.energyRecoverAddition .. "/h")

	return
end

function FireworkAndSpringScene:UpdateSpringUI()
	self.springList:align(self.springMaxCnt)

	return
end

function FireworkAndSpringScene:UpdateSpringActivityAndUI()
	self:UpdateSpringData()
	self:UpdateSpringUI()
	self:clearStudents()
	self:InitStudents()

	return
end

function FireworkAndSpringScene:PlayFireworks()
	self.fireworks = Clone(self.fireworkOrderIds)

	if #self.fireworks == 0 then
		return
	end

	eachChild(self.fireworksTF, function(arg_66_0)
		setActive(arg_66_0, false)

		return
	end)
	setActive(self.fireworksTF, true)
	self:StopFireworksTimer()

	self.fireworkIndex = 1
	self.fireworksTimer = Timer.New(function()
		self:PlayerOneFirework()

		return
	end, FireworkAndSpringScene.EffectInterval, #self.fireworks)

	self.fireworksTimer:Start()

	return
end

function FireworkAndSpringScene:PlayerOneFirework()
	if self.fireworkIndex == #self.fireworks then
		self:managedTween(LeanTween.delayedCall, function()
			if self.fireworks then
				self:StopPlayFireworks()
				self:PlayFireworks()
			end

			return
		end, FireworkAndSpringScene.DelayPop, nil)
	end

	local var_68_0 = self.fireworks[self.fireworkIndex]
	local var_68_1 = math.random(#FireworkAndSpringScene.SFX_LIST)

	if self.firePools[self.fireworks[self.fireworkIndex]] and #self.firePools[var_68_0] >= FireworkAndSpringScene.EffectPoolCnt then
		setLocalPosition(self.firePools[var_68_0][1], self:GetFireworkPos())
		setActive(self.firePools[var_68_0][1], true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(FireworkAndSpringScene.SFX_LIST[var_68_1])
		table.removebyvalue(self.firePools[var_68_0], self.firePools[var_68_0][1])
		table.insert(self.firePools[var_68_0], self.firePools[var_68_0][1])
	else
		self.loader:GetPrefab("ui/" .. FireworkAndSpringScene.Id2EffectName[var_68_0], "", function(arg_70_0)
			pg.ViewUtils.SetSortingOrder(arg_70_0, 1)
			setParent(arg_70_0, self.fireworksTF)
			setLocalPosition(arg_70_0, self:GetFireworkPos())
			setActive(arg_70_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(FireworkAndSpringScene.SFX_LIST[var_68_1])

			self.firePools[var_68_0] = self.firePools[var_68_0] or {}

			table.insert(self.firePools[var_68_0], arg_70_0)

			return
		end)
	end

	self.fireworkIndex = self.fireworkIndex + 1

	return
end

function FireworkAndSpringScene:GetFireworkPos()
	local var_71_0 = Vector2(0, 0)

	if self.lastPos then
		local var_71_1 = Vector2(self.lastPos.x, self.lastPos.y)
		local var_71_2 = math.abs(var_71_1.x - self.lastPos.x)
		local var_71_3 = math.abs(var_71_1.y - self.lastPos.y)

		while var_71_2 < FireworkAndSpringScene.FireworkRange.x / 2 and var_71_3 < FireworkAndSpringScene.FireworkRange.y or var_71_3 < FireworkAndSpringScene.FireworkRange.y / 2 and var_71_2 < FireworkAndSpringScene.FireworkRange.x do
			var_71_1.x = math.random(FireworkAndSpringScene.EffectPosLimit.limitX[1], FireworkAndSpringScene.EffectPosLimit.limitX[2])
			var_71_1.y = math.random(FireworkAndSpringScene.EffectPosLimit.limitY[1], FireworkAndSpringScene.EffectPosLimit.limitY[2])
			var_71_2 = math.abs(var_71_1.x - self.lastPos.x)
			var_71_3 = math.abs(var_71_1.y - self.lastPos.y)
		end

		var_71_0 = var_71_1
	else
		var_71_0.x = math.random(FireworkAndSpringScene.EffectPosLimit.limitX[1], FireworkAndSpringScene.EffectPosLimit.limitX[2])
		var_71_0.y = math.random(FireworkAndSpringScene.EffectPosLimit.limitY[1], FireworkAndSpringScene.EffectPosLimit.limitY[2])
	end

	self.lastPos = var_71_0

	return var_71_0
end

function FireworkAndSpringScene:StopFireworksTimer()
	if self.fireworksTimer then
		self.fireworksTimer:Stop()

		self.fireworksTimer = nil
	end

	return
end

function FireworkAndSpringScene:StopPlayFireworks()
	self:StopFireworksTimer()

	self.fireworks = nil
	self.fireworkIndex = nil

	setActive(self.fireworksTF, false)

	return
end

function FireworkAndSpringScene:getStudents(arg_74_1, arg_74_2)
	local var_74_0 = {}
	local var_74_1 = {}

	if not self.springActivity then
		return var_74_0
	end

	local var_74_2 = self.springActivity:GetShipIds()

	for iter_74_0 = 1, self.springMaxCnt do
		if var_74_2[iter_74_0] and var_74_2[iter_74_0] ~= 0 then
			local var_74_3 = getProxy(BayProxy):RawGetShipById(var_74_2[iter_74_0])

			if var_74_3 then
				table.insert(var_74_1, var_74_3)
			end
		end
	end

	if not arg_74_1 or not arg_74_2 then
		arg_74_1 = #var_74_1
		arg_74_2 = #var_74_1
	end

	local var_74_4 = math.random(arg_74_1, arg_74_2)

	while var_74_4 > 0 and #var_74_1 > 0 do
		local var_74_5 = math.random(1, #var_74_1)

		table.insert(var_74_0, var_74_1[var_74_5]:getPrefab())

		var_74_1[var_74_5] = var_74_1[#var_74_1]
		var_74_4 = var_74_4 - 1
	end

	return var_74_0
end

function FireworkAndSpringScene:InitStudents(arg_75_1, arg_75_2)
	local var_75_0 = self:getStudents(arg_75_1, arg_75_2)
	local var_75_1 = {}

	for iter_75_0, iter_75_1 in pairs(self.graphPath.points) do
		if not iter_75_1.outRandom then
			table.insert(var_75_1, iter_75_1)
		end
	end

	self.academyStudents = {}

	local var_75_2 = {}

	for iter_75_2, iter_75_3 in pairs(var_75_0) do
		if not self.academyStudents[iter_75_2] then
			local var_75_3 = cloneTplTo(self._shipTpl, self._map)

			var_75_3.gameObject.name = iter_75_2

			local var_75_4 = self:ChooseRandomPos(var_75_1, #var_75_1)
			local var_75_6 = SummerFeastNavigationAgent.New(var_75_3.gameObject)

			var_75_6.normalSpeed = 100

			var_75_6:attach()
			var_75_6:setPathFinder(self.graphPath)
			var_75_6:SetPositionTable(var_75_2)
			var_75_6:setCurrentIndex(var_75_4 and var_75_4.id)
			var_75_6:SetOnTransEdge(function(arg_76_0, arg_76_1, arg_76_2)
				arg_76_2 = math.max(arg_76_1, arg_76_2)
				arg_76_1 = math.min(arg_76_1, arg_76_2)

				arg_76_0._tf:SetParent(self[self.edge2area[arg_76_1 .. "_" .. arg_76_2] or self.edge2area.default])

				return
			end)
			var_75_6:updateStudent(iter_75_3)

			self.academyStudents[iter_75_2] = var_75_6
		end
	end

	if #var_75_0 > 0 then
		self.sortTimer = Timer.New(function()
			self:sortStudents()

			return
		end, 0.2, -1)

		self.sortTimer:Start()
		self.sortTimer.func()
	end

	return
end

function FireworkAndSpringScene:ChooseRandomPos(arg_78_1, arg_78_2)
	local var_78_0 = math.random(1, arg_78_2)

	if not var_78_0 then
		return nil
	end

	pg.Tool.Swap(arg_78_1, var_78_0, arg_78_2)

	return arg_78_1[arg_78_2]
end

function FireworkAndSpringScene:SetTips()
	self:SetPtTip()
	self:SetTaskTip()
	self:SetFireworkTip()
	self:SetSpringTip()

	return
end

function FireworkAndSpringScene:SetPtTip()
	local var_80_0 = self.ptData:CanGetAward()

	setActive(self.ptBtn:Find("tip"), var_80_0)
	setActive(self.subPtBtn:Find("tip"), var_80_0)

	return
end

function FireworkAndSpringScene:SetTaskTip()
	setActive(self.taskBtn:Find("tip"), self.canGetTaskAward)
	setActive(self.subTaskBtn:Find("tip"), self.canGetTaskAward)

	return
end

function FireworkAndSpringScene:SetFireworkTip()
	local var_82_0 = #self.fireworkUnlockIds ~= #self.fireworkGotIds

	setActive(self.fireworkBtn:Find("tip"), #self.fireworkUnlockIds ~= #self.fireworkGotIds)
	setActive(self.subFireworkBtn:Find("tip"), var_82_0)

	return
end

function FireworkAndSpringScene:SetSpringTip()
	local var_83_0 = false

	for iter_83_0 = 1, self.springUnlockSlotCount do
		if self.springShipIds[iter_83_0] == 0 then
			var_83_0 = true

			break
		end
	end

	setActive(self.springBtn:Find("tip"), var_83_0)
	setActive(self.subSpringBtn:Find("tip"), var_83_0)

	return
end

function FireworkAndSpringScene:willExit()
	self:CloseSubPanel()
	self:StopPlayFireworks()
	self:clearStudents()
	FireworkAndSpringScene.super.willExit(self)

	return
end

function FireworkAndSpringScene:IsShowMainTip()
	local var_85_0 = ActivityConst.FireworkAndSpring_EMO_ID
	local var_85_1 = getProxy(ActivityProxy)
	local var_85_2 = ActivityPtData.New((var_85_1:getActivityById(ActivityConst.FireworkAndSpring_PT_ID)))
	local var_85_3 = var_85_2:CanGetAward()
	local var_85_4 = {}

	for iter_85_0, iter_85_1 in pairs((var_85_1:getActivityById(ActivityConst.FireworkAndSpring_TASK_ID):getConfig("config_data"))) do
		table.insert(var_85_4, getProxy(TaskProxy):getTaskVO(iter_85_1))
	end

	local var_85_5 = false

	for iter_85_2, iter_85_3 in pairs(var_85_4) do
		if iter_85_3:getTaskStatus() == 1 then
			var_85_5 = true

			break
		end
	end

	local var_85_6 = var_85_1:getActivityById(ActivityConst.FireworkAndSpring_ACT_ID)
	local var_85_7 = #var_85_6.data1_list ~= #var_85_6.data2_list
	local var_85_8 = var_85_1:getActivityById(var_85_0)
	local var_85_9 = _.map(var_85_8:GetShipIds(), function(arg_86_0)
		if getProxy(BayProxy):RawGetShipById(arg_86_0) then
			return arg_86_0
		else
			return 0
		end

		return
	end)
	local var_85_10 = {}
	local var_85_11 = var_85_8:getConfig("config_client").initialCount

	for iter_85_4, iter_85_5 in ipairs(var_85_8:getConfig("config_client").unlockPt) do
		if iter_85_5 <= var_85_2.count then
			var_85_11 = var_85_11 + 1
		end
	end

	for iter_85_6 = 1, var_85_8:GetSlotCount() do
		var_85_10[iter_85_6] = var_85_11 < iter_85_6
	end

	local var_85_12 = false

	for iter_85_7 = 1, var_85_11 do
		if var_85_9[iter_85_7] == 0 then
			var_85_12 = true

			break
		end
	end

	return var_85_3 or var_85_5 or var_85_7 or var_85_12
end

return FireworkAndSpringScene
