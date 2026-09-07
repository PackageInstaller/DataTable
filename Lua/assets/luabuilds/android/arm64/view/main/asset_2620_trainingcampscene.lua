local TrainingCampScene = class("TrainingCampScene", import("..base.BaseUI"))

function TrainingCampScene:getUIName()
	return "TrainingCampUI"
end

function TrainingCampScene:init()
	self:findUI()
	self:initData()
	self:addListener()

	if TechnologyConst.isNormalActOn() then
		self:initNormalPanel()
	end

	if TechnologyConst.isTecActOn() then
		self:initTecPanel()
	end

	self:closeMsgBox()

	return
end

function TrainingCampScene:findUI()
	self.adaptPanel = self._tf:Find("blur_panel/adapt")
	self.panelContainer = self._tf:Find("PanelContainer")
	self.normalPanel = self.panelContainer:Find("NormalPanel")
	self.tecPanel = self.panelContainer:Find("TecPanel")
	self.switchToNormalBtn = self._tf:Find("SwitchToNormal")
	self.switchToTecBtn = self._tf:Find("SwitchToTec")
	self.switchToNormalLight = GetOrAddComponent(self.switchToNormalBtn:Find("Light"), "Animator")
	self.switchToTecLight = GetOrAddComponent(self.switchToTecBtn:Find("Light"), "Animator")
	self.awardMsg = self._tf:Find("ChooseAwardPanel")
	self.helpBtn = self._tf:Find("HelpBtn")
	self.titleTf = self._tf:Find("blur_panel/adapt/top/title")

	GetComponent(findTF(self.titleTf, "img"), typeof(Image)):SetNativeSize()

	return
end

function TrainingCampScene:initData()
	self.taskProxy = getProxy(TaskProxy)
	self.activityProxy = getProxy(ActivityProxy)
	self.normalTaskactivity = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS)
	self.tecTaskActivity = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)
	self.phaseId = nil
	self.cachePageID = nil
	self.activity = nil

	return
end

function TrainingCampScene:addListener()
	onButton(self, self.adaptPanel:Find("top/back_button"), function()
		self:emit(TrainingCampScene.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.switchToNormalBtn, function()
		if not self.isOnSwitchAni and TechnologyConst.isNormalActOn() then
			self:switchPanel(self.normalTaskactivity, true)
			setActive(self.switchToNormalBtn, false)
			setActive(self.switchToTecBtn, true)
			self:resetSwitchBtnsLight()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.switchToTecBtn, function()
		if not self.isOnSwitchAni and TechnologyConst.isTecActOn() then
			self:switchPanel(self.tecTaskActivity, true)
			setActive(self.switchToNormalBtn, true)
			setActive(self.switchToTecBtn, false)
			self:resetSwitchBtnsLight()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("newplayer_help_tip")
		})

		return
	end, SFX_PANEL)

	return
end

function TrainingCampScene:didEnter()
	self:updateSwitchBtns()
	self:updateSwitchBtnsTag()
	self:autoSelectPanel()

	return
end

function TrainingCampScene:willExit()
	LeanTween.cancel(go(self.normalPanel))
	LeanTween.cancel(go(self.tecPanel))

	return
end

function TrainingCampScene:updateSwitchBtns()
	local var_12_0, var_12_1 = TechnologyConst.isNormalActOn()
	local var_12_2, var_12_3 = TechnologyConst.isTecActOn()

	if not var_12_0 or not var_12_2 then
		setActive(self.switchToNormalBtn, false)
		setActive(self.switchToTecBtn, false)
	elseif var_12_0 and var_12_2 then
		setActive(self.switchToNormalBtn, true)
		setActive(self.switchToTecBtn, true)
	end

	setActive(self.switchToNormalBtn:Find("Tag"), var_12_1)
	setActive(self.switchToTecBtn:Find("Tag"), var_12_3)

	return
end

function TrainingCampScene:updateSwitchBtnsTag()
	local var_13_0, var_13_1 = TechnologyConst.isNormalActOn()
	local var_13_2, var_13_3 = TechnologyConst.isTecActOn()

	setActive(self.switchToNormalBtn:Find("Tag"), var_13_1)
	setActive(self.switchToTecBtn:Find("Tag"), var_13_3)

	local var_13_4 = PlayerPrefs.GetInt("TrainCamp_Tec_Catchup_First_Tag", 0)

	self.switchToNormalLight.enabled = var_13_4 == 0
	self.switchToTecLight.enabled = var_13_4 == 0

	if var_13_4 == 0 then
		PlayerPrefs.SetInt("TrainCamp_Tec_Catchup_First_Tag", 1)
	end

	return
end

function TrainingCampScene:resetSwitchBtnsLight()
	self.switchToNormalLight.enabled = false
	self.switchToTecLight.enabled = false

	return
end

function TrainingCampScene:autoSelectPanel()
	local var_15_0, var_15_1 = TechnologyConst.isNormalActOn()
	local var_15_2, var_15_3 = TechnologyConst.isTecActOn()

	if var_15_0 and var_15_2 then
		self:switchPanel(self.normalTaskactivity)
		setActive(self.switchToNormalBtn, false)
		setActive(self.switchToTecBtn, true)
	elseif var_15_0 then
		self:switchPanel(self.normalTaskactivity)
	elseif var_15_2 then
		self:switchPanel(self.tecTaskActivity)
	end

	return
end

function TrainingCampScene:initNormalPanel()
	local var_16_0 = self.normalPanel:Find("ToggleList")

	self.normalToggles = {
		var_16_0:Find("Phase1"),
		var_16_0:Find("Phase2"),
		var_16_0:Find("Phase3")
	}
	self.normalTaskUIItemList = UIItemList.New(self.normalPanel:Find("ScrollRect/Content"), self.normalPanel:Find("ScrollRect/TaskTpl"))
	self.normalProgressPanel = self.normalPanel:Find("ProgressPanel")

	for iter_16_0, iter_16_1 in pairs(self.normalToggles) do
		onToggle(self, iter_16_1, function(arg_17_0)
			if arg_17_0 then
				if self.phaseId < iter_16_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("newplayer_notice_7"))
					triggerToggle(self.normalToggles[self.cachePageID], true)
				else
					self:updateNormalPanel(iter_16_0)
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function TrainingCampScene:updateNormalPanel(arg_18_1)
	self.cachePageID = arg_18_1

	local var_18_0 = self.normalTaskactivity:getConfig("config_data")[3]

	self:sortTaskIDList(var_18_0[arg_18_1][1])
	self:updateTaskUIItemList(self.normalTaskUIItemList, var_18_0[arg_18_1][1])
	self:updateNormalProgressPanel(arg_18_1, var_18_0[arg_18_1][2], var_18_0[arg_18_1][1])

	return
end

function TrainingCampScene:updateNormalProgressPanel(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = self:getTask(arg_19_2)

	if arg_19_1 == self.phaseId and self:isMissTask(arg_19_3) then
		self:emit(TrainingCampMediator.ON_TRIGGER, {
			cmd = 1,
			activity_id = self.activity.id
		})
	end

	if var_19_0 and var_19_0:isClientTrigger() and not var_19_0:isFinish() then
		self:emit(TrainingCampMediator.ON_UPDATE, var_19_0)
	end

	local var_19_1 = self.normalProgressPanel:Find("Get")
	local var_19_2 = self.normalProgressPanel:Find("Go")

	setActive(var_19_1, var_19_0 and var_19_0:isFinish() and not var_19_0:isReceive())
	setActive(self.normalProgressPanel:Find("Lock"), not var_19_0)
	setActive(var_19_2, var_19_0 and not var_19_0:isFinish())
	setActive(self.normalProgressPanel:Find("Pass"), var_19_0 and var_19_0:isReceive())

	local var_19_3 = self.normalProgressPanel:Find("Slider/LabelText")
	local var_19_4 = self.normalProgressPanel:Find("Slider/ProgressText")

	if not var_19_0 then
		var_19_0 = Task.New({
			id = arg_19_2
		})

		if self:isFinishedAll(arg_19_3) then
			self:emit(TrainingCampMediator.ON_TRIGGER, {
				cmd = 2,
				activity_id = self.activity.id
			})
		end

		setText(var_19_3, i18n("newplayer_notice_" .. arg_19_1))

		local var_19_5 = 0

		_.each(arg_19_3, function(arg_20_0)
			if self.taskProxy:getFinishTaskById(arg_20_0) ~= nil then
				var_19_5 = var_19_5 + 1
			end

			return
		end)
		setText(var_19_4, 0 .. "/" .. #arg_19_3)
	else
		setText(var_19_3, var_19_0:getConfig("desc"))
		setText(var_19_4, math.min(var_19_0.progress, var_19_0:getConfig("target_num")) .. "/" .. var_19_0:getConfig("target_num"))
	end

	self.normalProgressPanel:Find("Slider"):GetComponent(typeof(Slider)).value = var_19_0.progress / var_19_0:getConfig("target_num")
	self.normalProgressPanel:Find("Icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/trainingcampui_atlas", "panel_phase_award_" .. arg_19_1)

	setText(self.normalProgressPanel:Find("TipText"), i18n("newplayer_notice_" .. 3 + arg_19_1))
	onButton(self, var_19_1, function()
		if var_19_0:isSelectable() then
			self:openMsgbox(function(arg_22_0)
				self:emit(TrainingCampMediator.ON_SELECTABLE_GET, var_19_0, arg_22_0)

				return
			end)
		else
			self:emit(TrainingCampMediator.ON_GET, var_19_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_19_2, function()
		self:emit(TrainingCampMediator.ON_GO, var_19_0)

		return
	end, SFX_PANEL)

	return
end

function TrainingCampScene:initTecPanel()
	local var_24_0 = self.tecTaskActivity:getConfig("config_data")[3]

	self.allTechPhase = #self.tecTaskActivity:getConfig("config_data")[3] + 1

	local var_24_1 = self.tecPanel:Find("ToggleList")

	UIItemList.StaticAlign(var_24_1, var_24_1:Find("Phase1"), self.allTechPhase, function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			arg_25_2.name = "Phase" .. arg_25_1

			setText(arg_25_2:Find("TextImg"), i18n("tec_catchup_" .. arg_25_1))
			onToggle(self, arg_25_2, function(arg_26_0)
				setTextColor(arg_25_2:Find("TextImg"), (arg_26_0 or nil) and (Color.white or Color.NewHex("525252")))

				if arg_26_0 then
					self:updateTecPanel(arg_25_1)
				end

				return
			end, SFX_PANEL)
			onButton(self, arg_25_2:Find("Disable"), function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("tec_notice_not_open_tip"))

				return
			end, SFX_PANEL)
			onButton(self, arg_25_2:Find("Unlock"), function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = string.format("are you unlock phase %d ?", arg_25_1),
					onYes = function()
						if arg_25_1 == 1 then
							warning("cmd 3")
							self:emit(TrainingCampMediator.ON_TRIGGER, {
								cmd = 3,
								activity_id = self.tecTaskActivity.id
							})
						else
							self:emit(TrainingCampMediator.ON_TRIGGER, {
								cmd = 1,
								activity_id = self.tecTaskActivity.id,
								arg1 = arg_25_1 == 0 and 1 or arg_25_1
							})
						end

						return
					end
				})

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.tecTaskUIItemList = UIItemList.New(self.tecPanel:Find("ScrollRect/Content"), self.tecPanel:Find("ScrollRect/TaskTpl"))
	self.tecProgressPanel = self.tecPanel:Find("ProgressPanel")

	return
end

function TrainingCampScene:updateTecPanel(arg_30_1)
	self.cachePageID = arg_30_1

	local var_30_0 = self.tecTaskActivity:getConfig("config_data")[3]
	local var_30_1 = var_30_0[math.max(1, arg_30_1)][1]

	self:sortTaskIDList(var_30_1)
	self:updateTaskUIItemList(self.tecTaskUIItemList, var_30_1)
	self:updateTecProgressPanel(var_30_0[math.max(1, arg_30_1)][2], arg_30_1, var_30_1)

	return
end

function TrainingCampScene:updateTecProgressPanel(arg_31_1, arg_31_2, arg_31_3)
	if self:isFinishedAll(arg_31_3) then
		self:emit(TrainingCampMediator.ON_TRIGGER, {
			cmd = 2,
			activity_id = self.activity.id
		})
	end

	local var_31_0 = self.phaseId == arg_31_2 and self.taskProxy:getTaskVO(arg_31_1) or self:getTask(arg_31_1)

	if var_31_0 and var_31_0:isClientTrigger() and not var_31_0:isFinish() then
		self:emit(TrainingCampMediator.ON_UPDATE, var_31_0)
	end

	local var_31_1 = self.tecProgressPanel:Find("Get")
	local var_31_2 = self.tecProgressPanel:Find("Go")

	setActive(var_31_1, var_31_0 and var_31_0:isFinish() and not var_31_0:isReceive())
	setActive(self.tecProgressPanel:Find("Lock"), not var_31_0)
	setActive(var_31_2, var_31_0 and not var_31_0:isFinish())
	setActive(self.tecProgressPanel:Find("Pass"), var_31_0 and var_31_0:isReceive())

	local var_31_3 = self.tecProgressPanel:Find("Slider/LabelText")
	local var_31_4 = self.tecProgressPanel:Find("Slider/ProgressText")

	if not var_31_0 then
		local var_31_5 = 0

		_.each(arg_31_3, function(arg_32_0)
			local var_32_0 = self.taskProxy:getTaskVO(arg_32_0)

			if var_32_0 and var_32_0:isReceive() then
				var_31_5 = var_31_5 + 1
			end

			return
		end)

		var_31_0 = Task.New({
			id = arg_31_1
		})

		setText(var_31_3, i18n("tec_notice", i18n("tec_catchup_" .. arg_31_2)))
	else
		setText(var_31_3, var_31_0:getConfig("desc"))
	end

	setText(var_31_4, math.min(var_31_0.progress, var_31_0:getConfig("target_num")) .. "/" .. var_31_0:getConfig("target_num"))
	setSlider(self.tecProgressPanel:Find("Slider"), 0, var_31_0:getConfig("target_num"), var_31_0.progress)

	local var_31_6 = self.tecProgressPanel:Find("Icon/Item")
	local var_31_7 = var_31_0:getConfig("award_display")[1]
	local var_31_8 = {
		type = var_31_7[1],
		id = var_31_7[2],
		count = var_31_7[3]
	}

	updateDrop(var_31_6, var_31_8)
	onButton(self, var_31_6, function()
		self:emit(BaseUI.ON_DROP, var_31_8)

		return
	end, SFX_PANEL)
	setActive(self.tecProgressPanel:Find("TipText"), false)
	onButton(self, var_31_1, function()
		if var_31_0:isSelectable() then
			self:openMsgbox(function(arg_35_0)
				self:emit(TrainingCampMediator.ON_SELECTABLE_GET, var_31_0, arg_35_0)

				return
			end)
		else
			self:emit(TrainingCampMediator.ON_GET, var_31_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_31_2, function()
		self:emit(TrainingCampMediator.ON_GO, var_31_0)

		return
	end, SFX_PANEL)

	return
end

function TrainingCampScene:updateToggleDisable(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		setActive(iter_37_1:Find("Disable"), iter_37_0 > self.phaseId)
	end

	return
end

function TrainingCampScene:updateTechToggleState()
	local var_38_0 = self.techFinishTaskId and self.taskProxy:getTaskVO(self.techFinishTaskId)
	local var_38_1 = self.phaseId == "ready" or TechnologyConst.isTecActOn() and var_38_0 and var_38_0:isReceive()

	eachChild(self.tecPanel:Find("ToggleList"), function(arg_39_0, arg_39_1)
		local var_39_0 = not self.finishPhaseDic[arg_39_1] and self.phaseId ~= arg_39_1
		local var_39_1 = var_38_1

		if var_38_1 then
			if arg_39_1 == 1 then
				var_39_1 = self.finishPhaseDic[0] or self.phaseId == 0
			end
		end

		setActive(arg_39_0:Find("Unlock"), var_39_0 and var_39_1)
		setActive(arg_39_0:Find("Disable"), var_39_0 and not var_39_1)

		return
	end)

	return
end

function TrainingCampScene:updateTaskUIItemList(arg_40_1, arg_40_2)
	arg_40_1:make(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == UIItemList.EventUpdate then
			arg_41_1 = arg_41_1 + 1

			self:updateTask(arg_40_2[arg_41_1], arg_41_2)
		end

		return
	end)
	arg_40_1:align(#arg_40_2)

	return
end

function TrainingCampScene:updateTask(arg_42_1, arg_42_2)
	local var_42_0 = arg_42_2:Find("Get")
	local var_42_1 = arg_42_2:Find("Go")
	local var_42_2 = self:getTask(arg_42_1)

	setActive(var_42_0, var_42_2 and var_42_2:isFinish() and not var_42_2:isReceive())
	setActive(arg_42_2:Find("Got"), var_42_2 and var_42_2:isReceive())
	setActive(var_42_1, not var_42_2 or var_42_2 and not var_42_2:isFinish())

	if var_42_2 and var_42_2:isClientTrigger() and not var_42_2:isFinish() then
		self:emit(TrainingCampMediator.ON_UPDATE, var_42_2)
	end

	setText(arg_42_2:Find("TitleText"), var_42_2:getConfig("desc"))

	local var_42_3 = var_42_2:getConfig("award_display")[1]
	local var_42_4 = arg_42_2:Find("Item")
	local var_42_5 = {
		type = var_42_3[1],
		id = var_42_3[2],
		count = var_42_3[3]
	}

	updateDrop(var_42_4, var_42_5)
	onButton(self, var_42_4, function()
		self:emit(BaseUI.ON_DROP, var_42_5)

		return
	end, SFX_PANEL)
	setText(arg_42_2:Find("ProgressText"), math.min(var_42_2.progress, var_42_2:getConfig("target_num")) .. "/" .. var_42_2:getConfig("target_num"))
	onButton(self, var_42_0, function()
		self:emit(TrainingCampMediator.ON_GET, var_42_2)

		return
	end, SFX_PANEL)
	onButton(self, var_42_1, function()
		self:emit(TrainingCampMediator.ON_GO, var_42_2)

		return
	end, SFX_PANEL)

	return
end

function TrainingCampScene:getTask(arg_46_1)
	local var_46_0 = self.taskProxy:getTaskVO(arg_46_1)

	if not var_46_0 then
		var_46_0 = Task.New({
			id = arg_46_1
		})
		var_46_0.progress = var_46_0:getConfig("target_num")
		var_46_0.submitTime = 1
	end

	return var_46_0
end

function TrainingCampScene:getTaskState(arg_47_1)
	if arg_47_1:isReceive() then
		return 0
	elseif arg_47_1:isFinish() then
		return 2
	elseif not arg_47_1:isFinish() then
		return 1
	end

	return -1
end

function TrainingCampScene:sortTaskIDList(arg_48_1)
	table.sort(arg_48_1, function(arg_49_0, arg_49_1)
		local var_49_0 = self.taskProxy:getTaskVO(arg_49_0) or Task.New({
			id = arg_49_0
		})
		local var_49_1 = self.taskProxy:getTaskVO(arg_49_1) or Task.New({
			id = arg_49_1
		})
		local var_49_2 = self:getTaskState(var_49_0)
		local var_49_3 = self:getTaskState(var_49_1)

		if var_49_2 == var_49_3 then
			return var_49_0.id < var_49_1.id
		else
			return var_49_3 < var_49_2
		end

		return
	end)

	return arg_48_1
end

function TrainingCampScene:isFinishedAll(arg_50_1)
	return _.all(arg_50_1, function(arg_51_0)
		local var_51_0 = self.taskProxy:getTaskVO(arg_51_0)

		return var_51_0 and var_51_0:isReceive() or false
	end)
end

function TrainingCampScene:isMissTask(arg_52_1)
	return _.any(arg_52_1, function(arg_53_0)
		return self.taskProxy:getTaskVO(arg_53_0) == nil
	end)
end

function TrainingCampScene:setPhrase()
	if self.lockFirst == true then
		self.phaseId = 1

		return
	end

	local var_54_0 = 1
	local var_54_1 = self.activity:getConfig("config_data")[3]

	local function var_54_2(arg_55_0)
		if arg_55_0 > 1 then
			return self.taskProxy:getFinishTaskById(var_54_1[arg_55_0 - 1][2]) ~= nil
		end

		return
	end

	for iter_54_0 = #var_54_1, 1, -1 do
		if _.all(var_54_1[iter_54_0][1], function(arg_56_0)
			return self.taskProxy:getTaskVO(arg_56_0) ~= nil
		end) or var_54_2(iter_54_0) then
			var_54_0 = iter_54_0

			break
		end
	end

	self.phaseId = var_54_0

	return
end

function TrainingCampScene:setTechPhrase()
	if self.activity.data1 == 0 then
		self.phaseId = "ready"
	else
		self.phaseId = self.activity.data1

		if self.phaseId == 1 and self.activity.data2 < 1 then
			self.phaseId = 0
		end
	end

	self.techFinishTaskId = self.phaseId ~= "ready" and self.activity:getConfig("config_data")[3][math.max(1, self.phaseId)][2] or nil
	self.finishPhaseDic = {}

	for iter_57_0, iter_57_1 in ipairs(self.activity.data1_list) do
		self.finishPhaseDic[iter_57_1] = true
	end

	self.finishPhaseDic[0] = self.finishPhaseDic[1]
	self.finishPhaseDic[1] = self.activity.data2 == 1 and self.activity.data1 ~= 1

	self:updateTechToggleState()

	return
end

function TrainingCampScene:switchPanel(arg_58_1, arg_58_2)
	self.activity = arg_58_1

	if arg_58_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS then
		self:setPhrase()

		if arg_58_2 then
			self:aniOnSwitch(self.normalPanel, self.tecPanel)
		else
			setActive(self.normalPanel, true)
			setActive(self.tecPanel, false)
		end

		self:updateToggleDisable(self.normalToggles)
		triggerToggle(self.normalToggles[self.phaseId], true)
	elseif arg_58_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP then
		self:setTechPhrase()

		local var_58_0 = self.phaseId == "ready"

		self.tecPanel:Find("ToggleList"):GetComponent(typeof(ToggleGroup)).allowSwitchOff = self.phaseId == "ready"

		setActive(self.tecPanel:Find("ScrollRect"), not var_58_0)
		setActive(self.tecPanel:Find("ProgressPanel"), not var_58_0)

		if arg_58_2 then
			self:aniOnSwitch(self.tecPanel, self.normalPanel)
		else
			setActive(self.normalPanel, false)
			setActive(self.tecPanel, true)
		end

		if self.phaseId == "ready" then
			eachChild(self.tecPanel:Find("ToggleList"), function(arg_59_0)
				triggerToggle(arg_59_0, false)

				return
			end)
		else
			triggerToggle(self.tecPanel:Find("ToggleList"):GetChild(self.phaseId), true)
		end
	end

	return
end

function TrainingCampScene:switchPageByMediator()
	if self.activity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS then
		self:switchPanel(self.normalTaskactivity)
	elseif self.activity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP then
		self:switchPanel(self.tecTaskActivity)
	end

	return
end

function TrainingCampScene:aniOnSwitch(arg_61_1, arg_61_2)
	self.isOnSwitchAni = true

	arg_61_1:SetAsLastSibling()
	setActive(arg_61_1, true)
	GetOrAddComponent(arg_61_1, "DftAniEvent"):SetEndEvent(function()
		self.isOnSwitchAni = false

		setActive(arg_61_2, false)

		return
	end)

	return
end

function TrainingCampScene:openMsgbox(arg_63_1)
	setActive(self.switchToNormalBtn, false)
	setActive(self.switchToTecBtn, false)
	setActive(self.awardMsg, true)
	setActive(self.normalPanel, false)

	local var_63_0
	local var_63_1 = self.awardMsg:Find("photos")

	for iter_63_0 = 1, var_63_1.childCount do
		onToggle(self, var_63_1:GetChild(iter_63_0 - 1), function(arg_64_0)
			if arg_64_0 then
				var_63_0 = iter_63_0
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.awardMsg:Find("confirm_btn"), function()
		if var_63_0 then
			if arg_63_1 then
				arg_63_1(var_63_0)
			end

			self:closeMsgBox()
		end

		return
	end, SFX_PANEL)

	return
end

function TrainingCampScene:closeMsgBox()
	setActive(self.awardMsg, false)
	setActive(self.normalPanel, true)
	self:updateSwitchBtns()

	return
end

function TrainingCampScene:tryShowTecFixTip(arg_67_1)
	if self.tecTaskActivity and arg_67_1 == self.tecTaskActivity.id then
		self.tecTaskActivity = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)
	end

	return
end

return TrainingCampScene
