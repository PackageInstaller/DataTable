local var_0_0 = class("TrainingCampScene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "TrainingCampUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	if TechnologyConst.isNormalActOn() then
		arg_2_0:initNormalPanel()
	end

	if TechnologyConst.isTecActOn() then
		arg_2_0:initTecPanel()
	end

	arg_2_0:closeMsgBox()

	return
end

function var_0_0.findUI(arg_3_0)
	arg_3_0.adaptPanel = arg_3_0._tf:Find("blur_panel/adapt")
	arg_3_0.panelContainer = arg_3_0._tf:Find("PanelContainer")
	arg_3_0.normalPanel = arg_3_0.panelContainer:Find("NormalPanel")
	arg_3_0.tecPanel = arg_3_0.panelContainer:Find("TecPanel")
	arg_3_0.switchToNormalBtn = arg_3_0._tf:Find("SwitchToNormal")
	arg_3_0.switchToTecBtn = arg_3_0._tf:Find("SwitchToTec")
	arg_3_0.switchToNormalLight = GetOrAddComponent(arg_3_0.switchToNormalBtn:Find("Light"), "Animator")
	arg_3_0.switchToTecLight = GetOrAddComponent(arg_3_0.switchToTecBtn:Find("Light"), "Animator")
	arg_3_0.awardMsg = arg_3_0._tf:Find("ChooseAwardPanel")
	arg_3_0.helpBtn = arg_3_0._tf:Find("HelpBtn")
	arg_3_0.titleTf = arg_3_0._tf:Find("blur_panel/adapt/top/title")

	GetComponent(findTF(arg_3_0.titleTf, "img"), typeof(Image)):SetNativeSize()

	return
end

function var_0_0.initData(arg_4_0)
	arg_4_0.taskProxy = getProxy(TaskProxy)
	arg_4_0.activityProxy = getProxy(ActivityProxy)
	arg_4_0.normalTaskactivity = arg_4_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS)
	arg_4_0.tecTaskActivity = arg_4_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)
	arg_4_0.phaseId = nil
	arg_4_0.cachePageID = nil
	arg_4_0.activity = nil

	return
end

function var_0_0.addListener(arg_5_0)
	onButton(arg_5_0, arg_5_0.adaptPanel:Find("top/back_button"), function()
		arg_5_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.switchToNormalBtn, function()
		if not arg_5_0.isOnSwitchAni and TechnologyConst.isNormalActOn() then
			arg_5_0:switchPanel(arg_5_0.normalTaskactivity, true)
			setActive(arg_5_0.switchToNormalBtn, false)
			setActive(arg_5_0.switchToTecBtn, true)
			arg_5_0:resetSwitchBtnsLight()
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.switchToTecBtn, function()
		if not arg_5_0.isOnSwitchAni and TechnologyConst.isTecActOn() then
			arg_5_0:switchPanel(arg_5_0.tecTaskActivity, true)
			setActive(arg_5_0.switchToNormalBtn, true)
			setActive(arg_5_0.switchToTecBtn, false)
			arg_5_0:resetSwitchBtnsLight()
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("newplayer_help_tip")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_10_0)
	arg_10_0:updateSwitchBtns()
	arg_10_0:updateSwitchBtnsTag()
	arg_10_0:autoSelectPanel()

	return
end

function var_0_0.willExit(arg_11_0)
	LeanTween.cancel(go(arg_11_0.normalPanel))
	LeanTween.cancel(go(arg_11_0.tecPanel))

	return
end

function var_0_0.updateSwitchBtns(arg_12_0)
	local var_12_0, var_12_1 = TechnologyConst.isNormalActOn()
	local var_12_2, var_12_3 = TechnologyConst.isTecActOn()

	if not var_12_0 or not var_12_2 then
		setActive(arg_12_0.switchToNormalBtn, false)
		setActive(arg_12_0.switchToTecBtn, false)
	elseif var_12_0 and var_12_2 then
		setActive(arg_12_0.switchToNormalBtn, true)
		setActive(arg_12_0.switchToTecBtn, true)
	end

	setActive(arg_12_0.switchToNormalBtn:Find("Tag"), var_12_1)
	setActive(arg_12_0.switchToTecBtn:Find("Tag"), var_12_3)

	return
end

function var_0_0.updateSwitchBtnsTag(arg_13_0)
	local var_13_0, var_13_1 = TechnologyConst.isNormalActOn()
	local var_13_2, var_13_3 = TechnologyConst.isTecActOn()

	setActive(arg_13_0.switchToNormalBtn:Find("Tag"), var_13_1)
	setActive(arg_13_0.switchToTecBtn:Find("Tag"), var_13_3)

	local var_13_4 = PlayerPrefs.GetInt("TrainCamp_Tec_Catchup_First_Tag", 0)

	arg_13_0.switchToNormalLight.enabled = var_13_4 == 0
	arg_13_0.switchToTecLight.enabled = var_13_4 == 0

	if var_13_4 == 0 then
		PlayerPrefs.SetInt("TrainCamp_Tec_Catchup_First_Tag", 1)
	end

	return
end

function var_0_0.resetSwitchBtnsLight(arg_14_0)
	arg_14_0.switchToNormalLight.enabled = false
	arg_14_0.switchToTecLight.enabled = false

	return
end

function var_0_0.autoSelectPanel(arg_15_0)
	local var_15_0, var_15_1 = TechnologyConst.isNormalActOn()
	local var_15_2, var_15_3 = TechnologyConst.isTecActOn()

	if var_15_0 and var_15_2 then
		arg_15_0:switchPanel(arg_15_0.normalTaskactivity)
		setActive(arg_15_0.switchToNormalBtn, false)
		setActive(arg_15_0.switchToTecBtn, true)
	elseif var_15_0 then
		arg_15_0:switchPanel(arg_15_0.normalTaskactivity)
	elseif var_15_2 then
		arg_15_0:switchPanel(arg_15_0.tecTaskActivity)
	end

	return
end

function var_0_0.initNormalPanel(arg_16_0)
	local var_16_0 = arg_16_0.normalPanel:Find("ToggleList")

	arg_16_0.normalToggles = {
		var_16_0:Find("Phase1"),
		var_16_0:Find("Phase2"),
		var_16_0:Find("Phase3")
	}
	arg_16_0.normalTaskUIItemList = UIItemList.New(arg_16_0.normalPanel:Find("ScrollRect/Content"), arg_16_0.normalPanel:Find("ScrollRect/TaskTpl"))
	arg_16_0.normalProgressPanel = arg_16_0.normalPanel:Find("ProgressPanel")

	for iter_16_0, iter_16_1 in pairs(arg_16_0.normalToggles) do
		onToggle(arg_16_0, iter_16_1, function(arg_17_0)
			if arg_17_0 then
				if arg_16_0.phaseId < iter_16_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("newplayer_notice_7"))
					triggerToggle(arg_16_0.normalToggles[arg_16_0.cachePageID], true)
				else
					arg_16_0:updateNormalPanel(iter_16_0)
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateNormalPanel(arg_18_0, arg_18_1)
	arg_18_0.cachePageID = arg_18_1

	local var_18_0 = arg_18_0.normalTaskactivity:getConfig("config_data")[3]

	arg_18_0:sortTaskIDList(var_18_0[arg_18_1][1])
	arg_18_0:updateTaskUIItemList(arg_18_0.normalTaskUIItemList, var_18_0[arg_18_1][1])
	arg_18_0:updateNormalProgressPanel(arg_18_1, var_18_0[arg_18_1][2], var_18_0[arg_18_1][1])

	return
end

function var_0_0.updateNormalProgressPanel(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:getTask(arg_19_2)

	if arg_19_1 == arg_19_0.phaseId and arg_19_0:isMissTask(arg_19_3) then
		arg_19_0:emit(TrainingCampMediator.ON_TRIGGER, {
			cmd = 1,
			activity_id = arg_19_0.activity.id
		})
	end

	if var_19_0 and var_19_0:isClientTrigger() and not var_19_0:isFinish() then
		arg_19_0:emit(TrainingCampMediator.ON_UPDATE, var_19_0)
	end

	local var_19_1 = arg_19_0.normalProgressPanel:Find("Get")
	local var_19_2 = arg_19_0.normalProgressPanel:Find("Go")
	local var_19_3 = var_19_0 and var_19_0:isFinish() and not var_19_0:isReceive()

	setActive(var_19_1, var_19_3)
	setActive(arg_19_0.normalProgressPanel:Find("Lock"), not var_19_0)
	setActive(var_19_2, var_19_0 and not var_19_0:isFinish())
	setActive(arg_19_0.normalProgressPanel:Find("Pass"), var_19_0 and var_19_0:isReceive())

	local var_19_4 = arg_19_0.normalProgressPanel:Find("Slider/LabelText")
	local var_19_5 = arg_19_0.normalProgressPanel:Find("Slider/ProgressText")

	if not var_19_0 then
		var_19_0 = Task.New({
			id = arg_19_2
		})

		if arg_19_0:isFinishedAll(arg_19_3) then
			arg_19_0:emit(TrainingCampMediator.ON_TRIGGER, {
				cmd = 2,
				activity_id = arg_19_0.activity.id
			})
		end

		setText(var_19_4, i18n("newplayer_notice_" .. arg_19_1))

		local var_19_6 = 0

		_.each(arg_19_3, function(arg_20_0)
			if arg_19_0.taskProxy:getFinishTaskById(arg_20_0) ~= nil then
				var_19_6 = var_19_6 + 1
			end

			return
		end)
		setText(var_19_5, 0 .. "/" .. #arg_19_3)
	else
		setText(var_19_4, var_19_0:getConfig("desc"))
		setText(var_19_5, math.min(var_19_0.progress, var_19_0:getConfig("target_num")) .. "/" .. var_19_0:getConfig("target_num"))
	end

	local var_19_7 = arg_19_0.normalProgressPanel:Find("Slider")

	var_19_7:GetComponent(typeof(Slider)).value = var_19_0.progress / var_19_0:getConfig("target_num")
	arg_19_0.normalProgressPanel:Find("Icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/trainingcampui_atlas", "panel_phase_award_" .. arg_19_1)

	setText(arg_19_0.normalProgressPanel:Find("TipText"), i18n("newplayer_notice_" .. 3 + arg_19_1))
	onButton(arg_19_0, var_19_1, function()
		if var_19_0:isSelectable() then
			arg_19_0:openMsgbox(function(arg_22_0)
				arg_19_0:emit(TrainingCampMediator.ON_SELECTABLE_GET, var_19_0, arg_22_0)

				return
			end)
		else
			arg_19_0:emit(TrainingCampMediator.ON_GET, var_19_0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_19_0, var_19_2, function()
		arg_19_0:emit(TrainingCampMediator.ON_GO, var_19_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initTecPanel(arg_24_0)
	local var_24_0 = arg_24_0.tecTaskActivity:getConfig("config_data")[3]

	arg_24_0.allTechPhase = #arg_24_0.tecTaskActivity:getConfig("config_data")[3] + 1

	local var_24_1 = arg_24_0.tecPanel:Find("ToggleList")

	UIItemList.StaticAlign(var_24_1, var_24_1:Find("Phase1"), arg_24_0.allTechPhase, function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			arg_25_2.name = "Phase" .. arg_25_1

			setText(arg_25_2:Find("TextImg"), i18n("tec_catchup_" .. arg_25_1))
			onToggle(arg_24_0, arg_25_2, function(arg_26_0)
				local var_26_0 = arg_25_2:Find("TextImg")

				if arg_26_0 then
					local var_26_1 = Color.white or Color.NewHex("525252")

					setTextColor(var_26_0, var_26_1)

					if arg_26_0 then
						arg_24_0:updateTecPanel(arg_25_1)
					end

					return
				end
			end, SFX_PANEL)
			onButton(arg_24_0, arg_25_2:Find("Disable"), function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("tec_notice_not_open_tip"))

				return
			end, SFX_PANEL)
			onButton(arg_24_0, arg_25_2:Find("Unlock"), function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = string.format("are you unlock phase %d ?", arg_25_1),
					onYes = function()
						if arg_25_1 == 1 then
							warning("cmd 3")
							arg_24_0:emit(TrainingCampMediator.ON_TRIGGER, {
								cmd = 3,
								activity_id = arg_24_0.tecTaskActivity.id
							})
						else
							arg_24_0:emit(TrainingCampMediator.ON_TRIGGER, {
								cmd = 1,
								activity_id = arg_24_0.tecTaskActivity.id,
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

	arg_24_0.tecTaskUIItemList = UIItemList.New(arg_24_0.tecPanel:Find("ScrollRect/Content"), arg_24_0.tecPanel:Find("ScrollRect/TaskTpl"))
	arg_24_0.tecProgressPanel = arg_24_0.tecPanel:Find("ProgressPanel")

	return
end

function var_0_0.updateTecPanel(arg_30_0, arg_30_1)
	arg_30_0.cachePageID = arg_30_1

	local var_30_0 = arg_30_0.tecTaskActivity:getConfig("config_data")[3]
	local var_30_1 = var_30_0[math.max(1, arg_30_1)][1]

	arg_30_0:sortTaskIDList(var_30_1)
	arg_30_0:updateTaskUIItemList(arg_30_0.tecTaskUIItemList, var_30_1)
	arg_30_0:updateTecProgressPanel(var_30_0[math.max(1, arg_30_1)][2], arg_30_1, var_30_1)

	return
end

function var_0_0.updateTecProgressPanel(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_0:isFinishedAll(arg_31_3) then
		arg_31_0:emit(TrainingCampMediator.ON_TRIGGER, {
			cmd = 2,
			activity_id = arg_31_0.activity.id
		})
	end

	local var_31_0 = arg_31_0.phaseId == arg_31_2 and arg_31_0.taskProxy:getTaskVO(arg_31_1) or arg_31_0:getTask(arg_31_1)

	if var_31_0 and var_31_0:isClientTrigger() and not var_31_0:isFinish() then
		arg_31_0:emit(TrainingCampMediator.ON_UPDATE, var_31_0)
	end

	local var_31_1 = arg_31_0.tecProgressPanel:Find("Get")
	local var_31_2 = arg_31_0.tecProgressPanel:Find("Go")
	local var_31_3 = var_31_0 and var_31_0:isFinish() and not var_31_0:isReceive()

	setActive(var_31_1, var_31_3)
	setActive(arg_31_0.tecProgressPanel:Find("Lock"), not var_31_0)
	setActive(var_31_2, var_31_0 and not var_31_0:isFinish())
	setActive(arg_31_0.tecProgressPanel:Find("Pass"), var_31_0 and var_31_0:isReceive())

	local var_31_4 = arg_31_0.tecProgressPanel:Find("Slider/LabelText")
	local var_31_5 = arg_31_0.tecProgressPanel:Find("Slider/ProgressText")

	if not var_31_0 then
		local var_31_6 = 0

		_.each(arg_31_3, function(arg_32_0)
			local var_32_0 = arg_31_0.taskProxy:getTaskVO(arg_32_0)

			if var_32_0 and var_32_0:isReceive() then
				var_31_6 = var_31_6 + 1
			end

			return
		end)

		var_31_0 = Task.New({
			id = arg_31_1
		})

		setText(var_31_4, i18n("tec_notice", i18n("tec_catchup_" .. arg_31_2)))
	else
		setText(var_31_4, var_31_0:getConfig("desc"))
	end

	setText(var_31_5, math.min(var_31_0.progress, var_31_0:getConfig("target_num")) .. "/" .. var_31_0:getConfig("target_num"))
	setSlider(arg_31_0.tecProgressPanel:Find("Slider"), 0, var_31_0:getConfig("target_num"), var_31_0.progress)

	local var_31_7 = arg_31_0.tecProgressPanel:Find("Icon/Item")
	local var_31_8 = var_31_0:getConfig("award_display")[1]

	updateDrop(var_31_7, {
		type = var_31_8[1],
		id = var_31_8[2],
		count = var_31_8[3]
	})
	onButton(arg_31_0, var_31_7, function()
		arg_31_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setActive(arg_31_0.tecProgressPanel:Find("TipText"), false)
	onButton(arg_31_0, var_31_1, function()
		if var_31_0:isSelectable() then
			arg_31_0:openMsgbox(function(arg_35_0)
				arg_31_0:emit(TrainingCampMediator.ON_SELECTABLE_GET, var_31_0, arg_35_0)

				return
			end)
		else
			arg_31_0:emit(TrainingCampMediator.ON_GET, var_31_0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_31_0, var_31_2, function()
		arg_31_0:emit(TrainingCampMediator.ON_GO, var_31_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateToggleDisable(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		setActive(iter_37_1:Find("Disable"), iter_37_0 > arg_37_0.phaseId)
	end

	return
end

function var_0_0.updateTechToggleState(arg_38_0)
	local var_38_0 = arg_38_0.techFinishTaskId and arg_38_0.taskProxy:getTaskVO(arg_38_0.techFinishTaskId)
	local var_38_1 = arg_38_0.phaseId == "ready" or TechnologyConst.isTecActOn() and var_38_0 and var_38_0:isReceive()

	eachChild(arg_38_0.tecPanel:Find("ToggleList"), function(arg_39_0, arg_39_1)
		local var_39_0 = not arg_38_0.finishPhaseDic[arg_39_1] and arg_38_0.phaseId ~= arg_39_1
		local var_39_1 = var_38_1

		if var_38_1 then
			if arg_39_1 == 1 then
				var_39_1 = arg_38_0.finishPhaseDic[0]

				if not arg_38_0.finishPhaseDic[0] then
					if arg_38_0.phaseId ~= 0 then
						var_39_1 = false

						goto label_39_0
					end

					var_39_1 = true
				end

				::label_39_0::

				setActive(arg_39_0:Find("Unlock"), var_39_0 and var_39_1)
				setActive(arg_39_0:Find("Disable"), var_39_0 and not var_39_1)

				return
			end
		end
	end)

	return
end

function var_0_0.updateTaskUIItemList(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1:make(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == UIItemList.EventUpdate then
			arg_41_1 = arg_41_1 + 1

			arg_40_0:updateTask(arg_40_2[arg_41_1], arg_41_2)
		end

		return
	end)
	arg_40_1:align(#arg_40_2)

	return
end

function var_0_0.updateTask(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_2:Find("Get")
	local var_42_1 = arg_42_2:Find("Go")
	local var_42_2 = arg_42_0:getTask(arg_42_1)
	local var_42_3 = var_42_2 and var_42_2:isFinish() and not var_42_2:isReceive()

	setActive(var_42_0, var_42_3)
	setActive(arg_42_2:Find("Got"), var_42_2 and var_42_2:isReceive())
	setActive(var_42_1, not var_42_2 or var_42_2 and not var_42_2:isFinish())

	if var_42_2 and var_42_2:isClientTrigger() and not var_42_2:isFinish() then
		arg_42_0:emit(TrainingCampMediator.ON_UPDATE, var_42_2)
	end

	setText(arg_42_2:Find("TitleText"), var_42_2:getConfig("desc"))

	local var_42_4 = var_42_2:getConfig("award_display")[1]
	local var_42_5 = arg_42_2:Find("Item")

	updateDrop(var_42_5, {
		type = var_42_4[1],
		id = var_42_4[2],
		count = var_42_4[3]
	})
	onButton(arg_42_0, var_42_5, function()
		arg_42_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setText(arg_42_2:Find("ProgressText"), math.min(var_42_2.progress, var_42_2:getConfig("target_num")) .. "/" .. var_42_2:getConfig("target_num"))
	onButton(arg_42_0, var_42_0, function()
		arg_42_0:emit(TrainingCampMediator.ON_GET, var_42_2)

		return
	end, SFX_PANEL)
	onButton(arg_42_0, var_42_1, function()
		arg_42_0:emit(TrainingCampMediator.ON_GO, var_42_2)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.getTask(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.taskProxy:getTaskVO(arg_46_1)

	if not var_46_0 then
		var_46_0 = Task.New({
			id = arg_46_1
		})
		var_46_0.progress = var_46_0:getConfig("target_num")
		var_46_0.submitTime = 1
	end

	return var_46_0
end

function var_0_0.getTaskState(arg_47_0, arg_47_1)
	if arg_47_1:isReceive() then
		return 0
	elseif arg_47_1:isFinish() then
		return 2
	elseif not arg_47_1:isFinish() then
		return 1
	end

	return -1
end

function var_0_0.sortTaskIDList(arg_48_0, arg_48_1)
	table.sort(arg_48_1, function(arg_49_0, arg_49_1)
		local var_49_0 = arg_48_0.taskProxy:getTaskVO(arg_49_0) or Task.New({
			id = arg_49_0
		})
		local var_49_1 = arg_48_0.taskProxy:getTaskVO(arg_49_1) or Task.New({
			id = arg_49_1
		})
		local var_49_2 = arg_48_0:getTaskState(var_49_0)
		local var_49_3 = arg_48_0:getTaskState(var_49_1)

		if var_49_2 == var_49_3 then
			return var_49_0.id < var_49_1.id
		else
			return var_49_3 < var_49_2
		end

		return
	end)

	return arg_48_1
end

function var_0_0.isFinishedAll(arg_50_0, arg_50_1)
	return _.all(arg_50_1, function(arg_51_0)
		local var_51_0 = arg_50_0.taskProxy:getTaskVO(arg_51_0)

		return var_51_0 and var_51_0:isReceive() or false
	end)
end

function var_0_0.isMissTask(arg_52_0, arg_52_1)
	return _.any(arg_52_1, function(arg_53_0)
		return arg_52_0.taskProxy:getTaskVO(arg_53_0) == nil
	end)
end

function var_0_0.setPhrase(arg_54_0)
	if arg_54_0.lockFirst == true then
		arg_54_0.phaseId = 1

		return
	end

	local var_54_0 = 1
	local var_54_1 = arg_54_0.activity:getConfig("config_data")[3]

	for iter_54_0 = #var_54_1, 1, -1 do
		if _.all(var_54_1[iter_54_0][1], function(arg_56_0)
			return arg_54_0.taskProxy:getTaskVO(arg_56_0) ~= nil
		end) or (function(arg_55_0)
			if arg_55_0 > 1 then
				return arg_54_0.taskProxy:getFinishTaskById(var_54_1[arg_55_0 - 1][2]) ~= nil
			end

			return
		end)(iter_54_0) then
			var_54_0 = iter_54_0

			break
		end
	end

	arg_54_0.phaseId = var_54_0

	return
end

function var_0_0.setTechPhrase(arg_57_0)
	if arg_57_0.activity.data1 == 0 then
		arg_57_0.phaseId = "ready"
	else
		arg_57_0.phaseId = arg_57_0.activity.data1

		if arg_57_0.phaseId == 1 and arg_57_0.activity.data2 < 1 then
			arg_57_0.phaseId = 0
		end
	end

	arg_57_0.techFinishTaskId = arg_57_0.phaseId ~= "ready" and arg_57_0.activity:getConfig("config_data")[3][math.max(1, arg_57_0.phaseId)][2] or nil
	arg_57_0.finishPhaseDic = {}

	for iter_57_0, iter_57_1 in ipairs(arg_57_0.activity.data1_list) do
		arg_57_0.finishPhaseDic[iter_57_1] = true
	end

	arg_57_0.finishPhaseDic[0] = arg_57_0.finishPhaseDic[1]
	arg_57_0.finishPhaseDic[1] = arg_57_0.activity.data2 == 1 and arg_57_0.activity.data1 ~= 1

	arg_57_0:updateTechToggleState()

	return
end

function var_0_0.switchPanel(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0.activity = arg_58_1

	if arg_58_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS then
		arg_58_0:setPhrase()

		if arg_58_2 then
			arg_58_0:aniOnSwitch(arg_58_0.normalPanel, arg_58_0.tecPanel)
		else
			setActive(arg_58_0.normalPanel, true)
			setActive(arg_58_0.tecPanel, false)
		end

		arg_58_0:updateToggleDisable(arg_58_0.normalToggles)
		triggerToggle(arg_58_0.normalToggles[arg_58_0.phaseId], true)
	elseif arg_58_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP then
		arg_58_0:setTechPhrase()

		local var_58_0 = arg_58_0.phaseId == "ready"

		arg_58_0.tecPanel:Find("ToggleList"):GetComponent(typeof(ToggleGroup)).allowSwitchOff = arg_58_0.phaseId == "ready"

		setActive(arg_58_0.tecPanel:Find("ScrollRect"), not var_58_0)
		setActive(arg_58_0.tecPanel:Find("ProgressPanel"), not var_58_0)

		if arg_58_2 then
			arg_58_0:aniOnSwitch(arg_58_0.tecPanel, arg_58_0.normalPanel)
		else
			setActive(arg_58_0.normalPanel, false)
			setActive(arg_58_0.tecPanel, true)
		end

		if arg_58_0.phaseId == "ready" then
			eachChild(arg_58_0.tecPanel:Find("ToggleList"), function(arg_59_0)
				triggerToggle(arg_59_0, false)

				return
			end)
		else
			triggerToggle(arg_58_0.tecPanel:Find("ToggleList"):GetChild(arg_58_0.phaseId), true)
		end
	end

	return
end

function var_0_0.switchPageByMediator(arg_60_0)
	if arg_60_0.activity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS then
		arg_60_0:switchPanel(arg_60_0.normalTaskactivity)
	elseif arg_60_0.activity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP then
		arg_60_0:switchPanel(arg_60_0.tecTaskActivity)
	end

	return
end

function var_0_0.aniOnSwitch(arg_61_0, arg_61_1, arg_61_2)
	arg_61_0.isOnSwitchAni = true

	arg_61_1:SetAsLastSibling()
	setActive(arg_61_1, true)
	GetOrAddComponent(arg_61_1, "DftAniEvent"):SetEndEvent(function()
		arg_61_0.isOnSwitchAni = false

		setActive(arg_61_2, false)

		return
	end)

	return
end

function var_0_0.openMsgbox(arg_63_0, arg_63_1)
	setActive(arg_63_0.switchToNormalBtn, false)
	setActive(arg_63_0.switchToTecBtn, false)
	setActive(arg_63_0.awardMsg, true)
	setActive(arg_63_0.normalPanel, false)

	local var_63_0
	local var_63_1 = arg_63_0.awardMsg:Find("photos")

	for iter_63_0 = 1, var_63_1.childCount do
		onToggle(arg_63_0, var_63_1:GetChild(iter_63_0 - 1), function(arg_64_0)
			if arg_64_0 then
				var_63_0 = iter_63_0
			end

			return
		end, SFX_PANEL)
	end

	onButton(arg_63_0, arg_63_0.awardMsg:Find("confirm_btn"), function()
		if var_63_0 then
			if arg_63_1 then
				arg_63_1(var_63_0)
			end

			arg_63_0:closeMsgBox()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.closeMsgBox(arg_66_0)
	setActive(arg_66_0.awardMsg, false)
	setActive(arg_66_0.normalPanel, true)
	arg_66_0:updateSwitchBtns()

	return
end

function var_0_0.tryShowTecFixTip(arg_67_0, arg_67_1)
	if arg_67_0.tecTaskActivity and arg_67_1 == arg_67_0.tecTaskActivity.id then
		arg_67_0.tecTaskActivity = arg_67_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)
	end

	return
end

return var_0_0
