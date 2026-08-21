local var_0_0 = class("SpringFestival2026FireworkAndSpringPage", import("view.activity.CorePage.CoreActivityBackHillTemplate"))

var_0_0.edge2area = {
	default = "_SDPlace"
}
var_0_0.EffectPoolCnt = 3
var_0_0.Id2EffectName = {
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
var_0_0.FireworkRange = Vector2(300, 300)
var_0_0.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
var_0_0.EffectInterval = 1
var_0_0.DelayPop = 2.5
var_0_0.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0._map = arg_1_0._tf:Find("BG/map")
	arg_1_0._shipTpl = arg_1_0._tf:Find("BG/ship")
	arg_1_0.fireworksTF = arg_1_0._tf:Find("BG/fireworks")
	arg_1_0._SDPlace = arg_1_0._tf:Find("BG/SDPlace")
	arg_1_0.containers = {
		arg_1_0._SDPlace
	}
	arg_1_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.FireworkAndSpringGraph"))
	arg_1_0.backBtn = arg_1_0._tf:Find("BG/panel/btn_back")
	arg_1_0.tipBtn = arg_1_0._tf:Find("BG/panel/btn_tip")
	arg_1_0.ptBtn = arg_1_0._tf:Find("BG/panel/btn_pt")
	arg_1_0.stage = arg_1_0._tf:Find("BG/panel/btn_pt/stage")
	arg_1_0.pt = arg_1_0._tf:Find("BG/panel/btn_pt/pt")
	arg_1_0.taskBtn = arg_1_0._tf:Find("BG/panel/btn_task")
	arg_1_0.fireworkBtn = arg_1_0._tf:Find("BG/panel/btn_firework")
	arg_1_0.springBtn = arg_1_0._tf:Find("BG/panel/btn_spring")
	arg_1_0.subPanel = arg_1_0._tf:Find("BG/subPanel")
	arg_1_0.subPanelPanel = arg_1_0.subPanel:Find("panel")
	arg_1_0.subLeft = arg_1_0.subPanelPanel:Find("left")
	arg_1_0.subRight = arg_1_0.subPanelPanel:Find("right")
	arg_1_0.subPtBtn = arg_1_0.subLeft:Find("ptBtn")
	arg_1_0.subTaskBtn = arg_1_0.subLeft:Find("taskBtn")
	arg_1_0.subFireworkBtn = arg_1_0.subLeft:Find("fireworkBtn")
	arg_1_0.subSpringBtn = arg_1_0.subLeft:Find("springBtn")
	arg_1_0.ptPanel = arg_1_0.subRight:Find("ptPanel")
	arg_1_0.taskPanel = arg_1_0.subRight:Find("taskPanel")
	arg_1_0.fireworkPanel = arg_1_0.subRight:Find("fireworkPanel")
	arg_1_0.springPanel = arg_1_0.subRight:Find("springPanel")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0:InitData()
	arg_2_0:UpdateMainPt()

	arg_2_0.firePools = {}

	arg_2_0:PlayFireworks()
	arg_2_0:InitStudents()
	arg_2_0:SetTips()
	arg_2_0:CloseSubPanel()

	arg_2_0.hasClonedFireworkArrows = false

	onButton(arg_2_0, arg_2_0.backBtn, function()
		arg_2_0:closeView()

		return
	end)
	onButton(arg_2_0, arg_2_0.tipBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.firework_2025_tip.tip
		})

		return
	end)
	onButton(arg_2_0, arg_2_0.ptBtn, function()
		arg_2_0:OpenSubPanel(arg_2_0.ptPanel)
		arg_2_0:SetPtPanel()

		return
	end)
	onButton(arg_2_0, arg_2_0.taskBtn, function()
		arg_2_0:OpenSubPanel(arg_2_0.taskPanel)
		arg_2_0:SetTaskPanel()

		return
	end)
	onButton(arg_2_0, arg_2_0.fireworkBtn, function()
		arg_2_0:OpenSubPanel(arg_2_0.fireworkPanel)
		arg_2_0:SetFireWorkPanel()

		return
	end)
	onButton(arg_2_0, arg_2_0.springBtn, function()
		arg_2_0:OpenSubPanel(arg_2_0.springPanel)
		arg_2_0:SetSpringPanel()

		return
	end)
	onButton(arg_2_0, arg_2_0.ptPanel:Find("btnClose"), function()
		arg_2_0:CloseSubPanel()
		arg_2_0:PlayFireworks()

		return
	end)
	onButton(arg_2_0, arg_2_0.taskPanel:Find("btnClose"), function()
		arg_2_0:CloseSubPanel()
		arg_2_0:PlayFireworks()

		return
	end)
	onButton(arg_2_0, arg_2_0.fireworkPanel:Find("btnClose"), function()
		arg_2_0:CloseSubPanel()
		arg_2_0:PlayFireworks()

		return
	end)
	onButton(arg_2_0, arg_2_0.springPanel:Find("btnClose"), function()
		arg_2_0:CloseSubPanel()
		arg_2_0:PlayFireworks()

		return
	end)
	onButton(arg_2_0, arg_2_0.subPtBtn, function()
		arg_2_0:SetSubPanel(arg_2_0.ptPanel)
		arg_2_0:SetPtPanel()

		return
	end)
	onButton(arg_2_0, arg_2_0.subTaskBtn, function()
		arg_2_0:SetSubPanel(arg_2_0.taskPanel)
		arg_2_0:SetTaskPanel()

		return
	end)
	onButton(arg_2_0, arg_2_0.subFireworkBtn, function()
		arg_2_0:SetSubPanel(arg_2_0.fireworkPanel)
		arg_2_0:SetFireWorkPanel()

		return
	end)
	onButton(arg_2_0, arg_2_0.subSpringBtn, function()
		arg_2_0:SetSubPanel(arg_2_0.springPanel)
		arg_2_0:SetSpringPanel()

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_17_0)
	arg_17_0:UpdateTaskData()
	arg_17_0:UpdatePtData()
	arg_17_0:UpdateMainPt()
	arg_17_0:SetTaskPanel()
	arg_17_0:UpdateSpringData()
	arg_17_0:SetPtPanel()
	arg_17_0:SetTips()
	arg_17_0:UpdateFireworkData()
	arg_17_0:SetFireWorkPanel()

	if isActive(arg_17_0.springPanel) then
		arg_17_0:UpdateSpringActivityAndUI()
	end

	return
end

function var_0_0.InitData(arg_18_0)
	arg_18_0.ptActId = ActivityConst.HorseYearSpringFestival2026_ID_1
	arg_18_0.taskActId = ActivityConst.HorseYearSpringFestival2026_ID_2
	arg_18_0.fireworkActId = ActivityConst.HorseYearSpringFestival2026_ID_4
	arg_18_0.springActId = ActivityConst.HorseYearSpringFestival2026_ID_3

	arg_18_0:UpdatePtData()
	arg_18_0:UpdateTaskData()
	arg_18_0:UpdateFireworkData()
	arg_18_0:UpdateSpringData()

	return
end

function var_0_0.UpdatePtData(arg_19_0)
	arg_19_0.ptActivity = getProxy(ActivityProxy):getActivityById(arg_19_0.ptActId)
	arg_19_0.ptData = ActivityPtData.New(arg_19_0.ptActivity)

	return
end

function var_0_0.UpdateTaskData(arg_20_0)
	arg_20_0.taskActivity = getProxy(ActivityProxy):getActivityById(arg_20_0.taskActId)
	arg_20_0.taskVOs = {}

	for iter_20_0, iter_20_1 in pairs((arg_20_0.taskActivity:getConfig("config_data"))) do
		local var_20_0 = getProxy(TaskProxy)

		table.insert(arg_20_0.taskVOs, var_20_0:getTaskVO(iter_20_1))
	end

	arg_20_0.canGetTaskVOs = {}
	arg_20_0.canGetTaskIds = {}

	arg_20_0:sort(arg_20_0.taskVOs)

	return
end

function var_0_0.sort(arg_21_0, arg_21_1)
	arg_21_0.canGetTaskAward = false

	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		if iter_21_1:getTaskStatus() == 1 then
			table.insert({}, iter_21_1)
			table.insert(arg_21_0.canGetTaskVOs, iter_21_1)
			table.insert(arg_21_0.canGetTaskIds, iter_21_1.id)

			arg_21_0.canGetTaskAward = true
		end
	end

	for iter_21_2, iter_21_3 in pairs(arg_21_1) do
		if iter_21_3:getTaskStatus() == 0 then
			table.insert({}, iter_21_3)
		end
	end

	for iter_21_4, iter_21_5 in pairs(arg_21_1) do
		if iter_21_5:getTaskStatus() == 2 then
			table.insert({}, iter_21_5)
		end
	end

	arg_21_0.taskVOs = {}

	return
end

function var_0_0.UpdateFireworkData(arg_22_0)
	arg_22_0.fireworkActivity = getProxy(ActivityProxy):getActivityById(arg_22_0.fireworkActId)
	arg_22_0.fireworkUnlockIds = arg_22_0.fireworkActivity.data1_list
	arg_22_0.fireworkGotIds = arg_22_0.fireworkActivity.data2_list
	arg_22_0.fireworkAllIds = arg_22_0.fireworkActivity:GetPicturePuzzleIds()
	arg_22_0.playerId = getProxy(PlayerProxy):getData().id
	arg_22_0.fireworkOrderIds = arg_22_0:GetFireWorkLocalData()

	return
end

function var_0_0.GetFireWorkLocalData(arg_23_0)
	for iter_23_0 = 1, #arg_23_0.fireworkAllIds do
		local var_23_0 = PlayerPrefs.GetInt("fireworks_" .. arg_23_0.fireworkActId .. "_" .. arg_23_0.playerId .. "_pos_" .. iter_23_0)

		if var_23_0 ~= 0 then
			table.insert({}, var_23_0)
		end
	end

	return {}
end

function var_0_0.SetFireWorkLocalData(arg_24_0)
	for iter_24_0 = 1, #arg_24_0.fireworkAllIds do
		local var_24_0 = arg_24_0.fireworkOrderIds[iter_24_0] or 0

		PlayerPrefs.SetInt("fireworks_" .. arg_24_0.fireworkActId .. "_" .. arg_24_0.playerId .. "_pos_" .. iter_24_0, var_24_0)
	end

	return
end

function var_0_0.UpdateSpringData(arg_25_0)
	arg_25_0.springActivity = getProxy(ActivityProxy):getActivityById(arg_25_0.springActId)
	arg_25_0.springShipIds = _.map(arg_25_0.springActivity:GetShipIds(), function(arg_26_0)
		if getProxy(BayProxy):RawGetShipById(arg_26_0) then
			return arg_26_0
		else
			return 0
		end

		return
	end)
	arg_25_0.springMaxCnt = arg_25_0.springActivity:GetSlotCount()
	arg_25_0.springSlotLockList = {}
	arg_25_0.springUnlockSlotCount = arg_25_0.springActivity:getConfig("config_client").initialCount

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.springActivity:getConfig("config_client").unlockPt) do
		if iter_25_1 <= arg_25_0.ptData.count then
			arg_25_0.springUnlockSlotCount = arg_25_0.springUnlockSlotCount + 1
		end
	end

	for iter_25_2 = 1, arg_25_0.springMaxCnt do
		arg_25_0.springSlotLockList[iter_25_2] = iter_25_2 > arg_25_0.springUnlockSlotCount
	end

	arg_25_0.energyRecoverAddition = arg_25_0.springActivity:GetEnergyRecoverAddition() * 10

	return
end

function var_0_0.OpenSubPanel(arg_27_0, arg_27_1)
	setActive(arg_27_0.subPanel, true)
	arg_27_0:SetSubPanel(arg_27_1)

	return
end

function var_0_0.CloseSubPanel(arg_28_0)
	setActive(arg_28_0.subPanel, false)

	return
end

function var_0_0.SetSubPanel(arg_29_0, arg_29_1)
	setActive(arg_29_0.ptPanel, false)
	setActive(arg_29_0.taskPanel, false)
	setActive(arg_29_0.fireworkPanel, false)
	setActive(arg_29_0.springPanel, false)
	setActive(arg_29_1, true)
	setActive(arg_29_0.subPtBtn:Find("selected"), arg_29_1 == arg_29_0.ptPanel)
	setActive(arg_29_0.subTaskBtn:Find("selected"), arg_29_1 == arg_29_0.taskPanel)
	setActive(arg_29_0.subFireworkBtn:Find("selected"), arg_29_1 == arg_29_0.fireworkPanel)
	setActive(arg_29_0.subSpringBtn:Find("selected"), arg_29_1 == arg_29_0.springPanel)

	return
end

function var_0_0.UpdateMainPt(arg_30_0)
	setText(arg_30_0.stage, "Lv." .. arg_30_0.ptData:GetCurrLevel())

	if not arg_30_0.ptData:IsMaxLevel() then
		setText(arg_30_0.pt, arg_30_0.ptData.count .. "/" .. arg_30_0.ptData:GetNextLevelTarget())
	else
		setText(arg_30_0.pt, "MAX")
	end

	return
end

function var_0_0.SetPtPanel(arg_31_0)
	setText(arg_31_0.ptPanel:Find("lvText"), arg_31_0.ptData:GetCurrLevel())

	if not arg_31_0.ptData:IsMaxLevel() then
		setText(arg_31_0.ptPanel:Find("pt"), arg_31_0.ptData.count .. "/" .. arg_31_0.ptData:GetNextLevelTarget())
		setSlider(arg_31_0.ptPanel:Find("slider"), 0, arg_31_0.ptData:GetNextLevelTarget(), arg_31_0.ptData.count)
	else
		setText(arg_31_0.ptPanel:Find("pt"), "MAX")
		setSlider(arg_31_0.ptPanel:Find("slider"), 0, 1, 1)
	end

	setText(arg_31_0.ptPanel:Find("ptScroll/Viewport/Content/tpl/get/Text"), i18n("firework_2025_get"))
	setText(arg_31_0.ptPanel:Find("ptScroll/Viewport/Content/tpl/got/Text"), i18n("firework_2025_got"))

	local var_31_0 = UIItemList.New(arg_31_0.ptPanel:Find("ptScroll/Viewport/Content"), arg_31_0.ptPanel:Find("ptScroll/Viewport/Content/tpl"))

	var_31_0:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			setText(arg_32_2:Find("level"), i18n("firework_2025_level", arg_32_1 + 1))
			updateDrop(arg_32_2:Find("award"), (Drop.Create(arg_31_0.ptData.dropList[arg_32_1 + 1])))
			onButton(arg_31_0, arg_32_2:Find("award"), function()
				arg_31_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_32_1 = arg_31_0.ptData:GetDroptItemState(arg_32_1 + 1)

			if var_32_1 == ActivityPtData.STATE_LOCK then
				setActive(arg_32_2:Find("lock"), true)
				setActive(arg_32_2:Find("get"), false)
				setActive(arg_32_2:Find("got"), false)
			elseif var_32_1 == ActivityPtData.STATE_CAN_GET then
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
	var_31_0:align(#arg_31_0.ptData.dropList)

	local var_31_1 = rtf(arg_31_0.ptPanel:Find("ptScroll/Viewport/Content/tpl")).rect.width
	local var_31_2 = arg_31_0.ptPanel:Find("ptScroll/Viewport/Content"):GetComponent(typeof(HorizontalLayoutGroup)).spacing
	local var_31_3 = rtf(arg_31_0.ptPanel:Find("ptScroll/Viewport")).rect.width

	scrollTo(arg_31_0.ptPanel:Find("ptScroll"), arg_31_0.ptData.level * (var_31_1 + var_31_2) / (#arg_31_0.ptData.targets * (var_31_1 + var_31_2) - var_31_2 - var_31_3), 0)

	arg_31_0.importants = arg_31_0.ptActivity:getConfig("config_client").highValueItemSort
	arg_31_0.importantsPos = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.importants) do
		table.insert(arg_31_0.importantsPos, (iter_31_1 - 6 - 1) * (var_31_1 + var_31_2) / (#arg_31_0.ptData.targets * (var_31_1 + var_31_2) - var_31_2 - var_31_3))
	end

	arg_31_0:PtScrollToDo(arg_31_0.ptData.level * (var_31_1 + var_31_2) / (#arg_31_0.ptData.targets * (var_31_1 + var_31_2) - var_31_2 - var_31_3))
	onScroll(arg_31_0, arg_31_0.ptPanel:Find("ptScroll"), function(arg_34_0)
		arg_31_0:PtScrollToDo(arg_34_0.x)

		return
	end)

	if arg_31_0.ptData:CanGetAward() then
		setActive(arg_31_0.ptPanel:Find("btn_get"), true)
		onButton(arg_31_0, arg_31_0.ptPanel:Find("btn_get"), function()
			local var_35_0 = arg_31_0.ptData:GetAllAvailableAwards()
			local var_35_1 = getProxy(PlayerProxy):getRawData()
			local var_35_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
			local var_35_3, var_35_4 = Task.StaticJudgeOverflow(var_35_1.gold, var_35_1.oil, var_35_2, true, true, var_35_0)

			if var_35_3 then
				table.insert({}, function(arg_36_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_35_4,
						onYes = arg_36_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_31_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 4,
					activity_id = arg_31_0.ptData:GetId(),
					arg1 = arg_31_0.ptData:GetCurrTarget()
				})

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(arg_31_0.ptPanel:Find("btn_get"), false)
		removeOnButton(arg_31_0.ptPanel:Find("btn_get"))
	end

	setText(arg_31_0.ptPanel:Find("ptName"), i18n("firework_2025_pt"))

	return
end

function var_0_0.PtScrollToDo(arg_38_0, arg_38_1)
	local var_38_0 = 0

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.importantsPos) do
		if arg_38_1 < iter_38_1 or iter_38_0 == #arg_38_0.importants then
			var_38_0 = arg_38_0.importants[iter_38_0]

			break
		end
	end

	updateDrop(arg_38_0.ptPanel:Find("award"), (Drop.Create(arg_38_0.ptData.dropList[var_38_0])))
	onButton(arg_38_0, arg_38_0.ptPanel:Find("award"), function()
		arg_38_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setText(arg_38_0.ptPanel:Find("awardInfo/Text"), i18n("firework_2025_level", var_38_0))
	setActive(arg_38_0.ptPanel:Find("award/got"), var_38_0 <= arg_38_0.ptData.level)

	return
end

function var_0_0.SetTaskPanel(arg_40_0)
	setText(arg_40_0.taskPanel:Find("lvText"), arg_40_0.ptData:GetCurrLevel())

	if not arg_40_0.ptData:IsMaxLevel() then
		setText(arg_40_0.taskPanel:Find("pt"), arg_40_0.ptData.count .. "/" .. arg_40_0.ptData:GetNextLevelTarget())
		setSlider(arg_40_0.taskPanel:Find("slider"), 0, arg_40_0.ptData:GetNextLevelTarget(), arg_40_0.ptData.count)
	else
		setText(arg_40_0.taskPanel:Find("pt"), "MAX")
		setSlider(arg_40_0.taskPanel:Find("slider"), 0, 1, 1)
	end

	local var_40_0 = UIItemList.New(arg_40_0.taskPanel:Find("taskScroll/Viewport/Content"), arg_40_0.taskPanel:Find("taskScroll/Viewport/Content/Tasktpl"))

	var_40_0:make(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == UIItemList.EventUpdate then
			local var_41_0 = arg_40_0.taskVOs[arg_41_1 + 1]

			setText(arg_41_2:Find("frame/name"), arg_40_0.taskVOs[arg_41_1 + 1]:getConfig("name"))
			setText(arg_41_2:Find("frame/desc"), arg_40_0.taskVOs[arg_41_1 + 1]:getConfig("desc"))

			local var_41_1 = arg_40_0.taskVOs[arg_41_1 + 1]:getConfig("target_num")
			local var_41_2 = math.min(arg_40_0.taskVOs[arg_41_1 + 1]:getProgress(), var_41_1)

			setText(arg_41_2:Find("frame/progress"), var_41_2 .. "/" .. var_41_1)

			arg_41_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_41_2 / var_41_1

			local var_41_3 = arg_41_2:Find("frame/awards")

			arg_40_0:updateTaskAwards(arg_40_0.taskVOs[arg_41_1 + 1]:getConfig("award_display"), var_41_3, (var_41_3:GetChild(0)))

			local var_41_4 = arg_41_2:Find("frame/go_btn")
			local var_41_5 = arg_41_2:Find("frame/get_btn")
			local var_41_6 = arg_41_2:Find("frame/got_btn")

			if arg_40_0.taskVOs[arg_41_1 + 1]:getTaskStatus() == 0 then
				setActive(var_41_4, true)
				setActive(var_41_5, false)
				setActive(var_41_6, false)
			elseif arg_40_0.taskVOs[arg_41_1 + 1]:getTaskStatus() == 1 then
				setActive(var_41_4, false)
				setActive(var_41_5, true)
				setActive(var_41_6, false)
			elseif arg_40_0.taskVOs[arg_41_1 + 1]:getTaskStatus() == 2 then
				setActive(var_41_4, false)
				setActive(var_41_5, false)
				setActive(var_41_6, true)
			end

			onButton(arg_40_0, var_41_4, function()
				arg_40_0:emit(ActivityMediator.ON_TASK_GO, var_41_0)

				return
			end, SFX_PANEL)
			onButton(arg_40_0, var_41_5, function()
				arg_40_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_41_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_40_0:align(#arg_40_0.taskVOs)

	if arg_40_0.canGetTaskAward then
		setActive(arg_40_0.taskPanel:Find("btn_get"), true)
		onButton(arg_40_0, arg_40_0.taskPanel:Find("btn_get"), function()
			local var_44_0 = {}

			for iter_44_0, iter_44_1 in pairs(arg_40_0.canGetTaskVOs) do
				for iter_44_2, iter_44_3 in ipairs((iter_44_1:getConfig("award_display"))) do
					local var_44_2 = false

					for iter_44_4, iter_44_5 in pairs(var_44_0) do
						if iter_44_5[1] == iter_44_3[1] and iter_44_5[2] == iter_44_3[2] then
							var_44_2 = true
							iter_44_5[3] = iter_44_5[3] + iter_44_3[3]

							break
						end
					end

					if not var_44_2 then
						table.insert(var_44_0, iter_44_3)
					end
				end
			end

			local var_44_3 = getProxy(PlayerProxy):getRawData()
			local var_44_4 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
			local var_44_5, var_44_6 = Task.StaticJudgeOverflow(var_44_3.gold, var_44_3.oil, var_44_4, true, true, var_44_0)

			if var_44_5 then
				table.insert({}, function(arg_45_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_44_6,
						onYes = arg_45_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_40_0:emit(ActivityMediator.ON_ACTIVITY_TASK_LIST_SUBMIT, {
					activityId = arg_40_0.taskActId,
					ids = arg_40_0.canGetTaskIds
				})

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(arg_40_0.taskPanel:Find("btn_get"), false)
		removeOnButton(arg_40_0.taskPanel:Find("btn_get"))
	end

	setText(arg_40_0.taskPanel:Find("ptName"), i18n("firework_2025_pt"))

	return
end

function var_0_0.updateTaskAwards(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = _.slice(arg_47_1, 1, 3)

	for iter_47_0 = arg_47_2.childCount, #var_47_0 - 1 do
		cloneTplTo(arg_47_3, arg_47_2)
	end

	for iter_47_1 = 1, arg_47_2.childCount do
		local var_47_1 = arg_47_2:GetChild(iter_47_1 - 1)
		local var_47_2 = iter_47_1 <= #var_47_0

		setActive(var_47_1, iter_47_1 <= #var_47_0)

		if var_47_2 then
			updateDrop(var_47_1, {
				type = var_47_0[iter_47_1][1],
				id = var_47_0[iter_47_1][2],
				count = var_47_0[iter_47_1][3]
			})
			onButton(arg_47_0, var_47_1, function()
				arg_47_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.SetFireWorkPanel(arg_49_0)
	local var_49_0 = arg_49_0.fireworkPanel:Find("left_panel")
	local var_49_1 = arg_49_0.fireworkPanel:Find("right_panel")

	arg_49_0.leftUIList = UIItemList.New(var_49_0:Find("scrollrect/content"), (var_49_0:Find("scrollrect/content/item_tpl")))
	arg_49_0.rightUIList = UIItemList.New(var_49_1:Find("content"), (var_49_1:Find("content/item_tpl")))

	local var_49_2 = var_49_1:Find("arrows")

	onButton(arg_49_0, var_49_1:Find("fire_btn"), function()
		arg_49_0:CloseSubPanel()
		arg_49_0:PlayFireworks()

		return
	end)
	setText(var_49_1:Find("tip"), i18n("activity_yanhua_tip7"))
	setText(var_49_0:Find("tip"), i18n("firework_2025_tip1"))
	arg_49_0.leftUIList:make(function(arg_51_0, arg_51_1, arg_51_2)
		if arg_51_0 == UIItemList.EventUpdate then
			local var_51_0 = arg_49_0.fireworkAllIds[arg_51_1 + 1]

			GetImageSpriteFromAtlasAsync(Item.getConfigData(arg_49_0.fireworkAllIds[arg_51_1 + 1]).icon, "", (arg_51_2:Find("firework/icon")))
			setActive(arg_51_2:Find("firework/selected"), (table.contains(arg_49_0.fireworkOrderIds, arg_49_0.fireworkAllIds[arg_51_1 + 1])))

			if not table.contains(arg_49_0.fireworkUnlockIds, arg_49_0.fireworkAllIds[arg_51_1 + 1]) then
				setActive(arg_51_2:Find("firework/lock"), true)
				setActive(arg_51_2:Find("firework/get"), false)
			elseif not table.contains(arg_49_0.fireworkGotIds, arg_49_0.fireworkAllIds[arg_51_1 + 1]) then
				setActive(arg_51_2:Find("firework/lock"), false)
				setActive(arg_51_2:Find("firework/get"), true)
				onButton(arg_49_0, arg_51_2, function()
					arg_49_0:emit(ActivityMediator.EVENT_OPERATION, {
						arg_49_0.fireworkActId,
						PuzzleActivity.CMD_ACTIVATE,
						var_51_0
					})

					return
				end, SFX_PANEL)
			else
				setActive(arg_51_2:Find("firework/lock"), false)
				setActive(arg_51_2:Find("firework/get"), false)
				onButton(arg_49_0, arg_51_2, function()
					arg_49_0:FireworkLeftClick(var_51_0, var_0)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	arg_49_0.leftUIList:align(#arg_49_0.fireworkAllIds)

	if not arg_49_0.hasClonedFireworkArrows then
		arg_49_0.hasClonedFireworkArrows = true

		for iter_49_0 = 1, #arg_49_0.fireworkAllIds - 2 do
			cloneTplTo(var_49_2:Find("tpl"), var_49_2)
		end
	end

	arg_49_0.rightUIList:make(function(arg_54_0, arg_54_1, arg_54_2)
		if arg_54_0 == UIItemList.EventUpdate then
			local var_54_0 = arg_54_1 + 1
			local var_54_1 = arg_54_2:Find("icon")

			setActive(arg_54_2:Find("add"), arg_54_1 + 1 > #arg_49_0.fireworkOrderIds)

			if var_54_0 > #arg_49_0.fireworkOrderIds then
				setActive(var_54_1, false)
			else
				local var_54_2 = arg_49_0.fireworkOrderIds[var_54_0]

				setActive(var_54_1, true)
				GetImageSpriteFromAtlasAsync(Item.getConfigData(var_54_2).icon, "", var_54_1)
				onButton(arg_49_0, var_54_1, function()
					arg_49_0:FireworkRightClick(var_54_2)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	arg_49_0.rightUIList:align(#arg_49_0.fireworkAllIds)

	return
end

function var_0_0.FireworkLeftClick(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_2 then
		table.removebyvalue(arg_56_0.fireworkOrderIds, arg_56_1)
	else
		table.insert(arg_56_0.fireworkOrderIds, arg_56_1)
	end

	arg_56_0:SetFireWorkLocalData()
	arg_56_0.leftUIList:align(#arg_56_0.fireworkAllIds)
	arg_56_0.rightUIList:align(#arg_56_0.fireworkAllIds)

	return
end

function var_0_0.FireworkRightClick(arg_57_0, arg_57_1)
	table.removebyvalue(arg_57_0.fireworkOrderIds, arg_57_1)
	arg_57_0:SetFireWorkLocalData()
	arg_57_0.leftUIList:align(#arg_57_0.fireworkAllIds)
	arg_57_0.rightUIList:align(#arg_57_0.fireworkAllIds)

	return
end

function var_0_0.SetSpringPanel(arg_58_0)
	arg_58_0:CreateSpringUI()
	arg_58_0:UpdateSpringUI()

	return
end

function var_0_0.CreateSpringUI(arg_59_0)
	setText(arg_59_0.springPanel:Find("list/iconTpl/lock/Text"), i18n("firework_2025_unlock_tip1"))

	arg_59_0.springList = UIItemList.New(arg_59_0.springPanel:Find("list"), arg_59_0.springPanel:Find("list/iconTpl"))

	arg_59_0.springList:make(function(arg_60_0, arg_60_1, arg_60_2)
		if arg_60_0 == UIItemList.EventUpdate then
			local var_60_0 = arg_59_0.springShipIds[arg_60_1 + 1]
			local var_60_1 = arg_59_0.springSlotLockList[arg_60_1 + 1]
			local var_60_2 = arg_59_0.springShipIds[arg_60_1 + 1] and var_60_0 > 0

			setActive(arg_60_2:Find("lock"), arg_59_0.springSlotLockList[arg_60_1 + 1])
			setActive(arg_60_2:Find("add"), not var_60_1 and not var_60_2)
			setActive(arg_60_2:Find("ship"), not var_60_1 and var_60_2)

			if var_60_1 then
				setText(arg_60_2:Find("lock/taskText"), i18n("firework_2025_unlock_tip2", arg_59_0.springActivity:getConfig("config_client").unlockPt[arg_60_1 + 1 - arg_59_0.springActivity:getConfig("config_client").initialCount]))
			end

			onButton(arg_59_0, arg_60_2, function()
				if var_60_1 then
					return
				end

				local var_61_0

				if var_60_2 then
					var_61_0 = getProxy(BayProxy):getShipById(var_60_0)
				end

				arg_59_0:StopPlayFireworks()
				arg_59_0:emit(CoreActivityMainMediator.OPEN_CHUANWU, arg_59_0.springActId, arg_60_1 + 1, var_61_0, arg_59_0.springUnlockSlotCount)

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
	setText(arg_59_0.springPanel:Find("tipText1"), i18n("firework_2025_tip2"))
	setText(arg_59_0.springPanel:Find("tipText2"), "+" .. arg_59_0.energyRecoverAddition .. "/h")

	return
end

function var_0_0.UpdateSpringUI(arg_62_0)
	arg_62_0.springList:align(arg_62_0.springMaxCnt)

	return
end

function var_0_0.UpdateSpringActivityAndUI(arg_63_0)
	arg_63_0:UpdateSpringData()
	arg_63_0:UpdateSpringUI()
	arg_63_0:clearStudents()
	arg_63_0:InitStudents()

	return
end

function var_0_0.PlayFireworks(arg_64_0)
	arg_64_0.fireworks = Clone(arg_64_0.fireworkOrderIds)

	if #arg_64_0.fireworks == 0 then
		return
	end

	eachChild(arg_64_0.fireworksTF, function(arg_65_0)
		setActive(arg_65_0, false)

		return
	end)
	setActive(arg_64_0.fireworksTF, true)
	arg_64_0:StopFireworksTimer()

	arg_64_0.fireworkIndex = 1
	arg_64_0.fireworksTimer = Timer.New(function()
		arg_64_0:PlayerOneFirework()

		return
	end, var_0_0.EffectInterval, #arg_64_0.fireworks)

	arg_64_0.fireworksTimer:Start()

	return
end

function var_0_0.PlayerOneFirework(arg_67_0)
	if arg_67_0.fireworkIndex == #arg_67_0.fireworks then
		arg_67_0:managedTween(LeanTween.delayedCall, function()
			if arg_67_0.fireworks then
				arg_67_0:StopPlayFireworks()
				arg_67_0:PlayFireworks()
			end

			return
		end, var_0_0.DelayPop, nil)
	end

	local var_67_0 = arg_67_0.fireworks[arg_67_0.fireworkIndex]
	local var_67_1 = math.random(#var_0_0.SFX_LIST)

	if arg_67_0.firePools[arg_67_0.fireworks[arg_67_0.fireworkIndex]] and #arg_67_0.firePools[var_67_0] >= var_0_0.EffectPoolCnt then
		setLocalPosition(arg_67_0.firePools[var_67_0][1], arg_67_0:GetFireworkPos())
		setActive(arg_67_0.firePools[var_67_0][1], true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_0.SFX_LIST[math.random(#var_0_0.SFX_LIST)])
		table.removebyvalue(arg_67_0.firePools[var_67_0], arg_67_0.firePools[var_67_0][1])
		table.insert(arg_67_0.firePools[var_67_0], arg_67_0.firePools[var_67_0][1])
	else
		arg_67_0.loader:GetPrefab("ui/" .. var_0_0.Id2EffectName[var_67_0], "", function(arg_69_0)
			pg.ViewUtils.SetSortingOrder(arg_69_0, 1)
			setParent(arg_69_0, arg_67_0.fireworksTF)
			setLocalPosition(arg_69_0, arg_67_0:GetFireworkPos())
			setActive(arg_69_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_0.SFX_LIST[var_67_1])

			arg_67_0.firePools[var_67_0] = arg_67_0.firePools[var_67_0] or {}

			table.insert(arg_67_0.firePools[var_67_0], arg_69_0)

			return
		end)
	end

	arg_67_0.fireworkIndex = arg_67_0.fireworkIndex + 1

	return
end

function var_0_0.GetFireworkPos(arg_70_0)
	local var_70_0 = Vector2(0, 0)

	if arg_70_0.lastPos then
		local var_70_1 = Vector2(arg_70_0.lastPos.x, arg_70_0.lastPos.y)
		local var_70_2 = math.abs(var_70_1.x - arg_70_0.lastPos.x)
		local var_70_3 = math.abs(var_70_1.y - arg_70_0.lastPos.y)

		while var_70_2 < var_0_0.FireworkRange.x / 2 and var_70_3 < var_0_0.FireworkRange.y or var_70_3 < var_0_0.FireworkRange.y / 2 and var_70_2 < var_0_0.FireworkRange.x do
			var_70_1.x = math.random(var_0_0.EffectPosLimit.limitX[1], var_0_0.EffectPosLimit.limitX[2])
			var_70_1.y = math.random(var_0_0.EffectPosLimit.limitY[1], var_0_0.EffectPosLimit.limitY[2])
			var_70_2 = math.abs(var_70_1.x - arg_70_0.lastPos.x)
			var_70_3 = math.abs(var_70_1.y - arg_70_0.lastPos.y)
		end

		var_70_0 = var_70_1
	else
		var_70_0.x = math.random(var_0_0.EffectPosLimit.limitX[1], var_0_0.EffectPosLimit.limitX[2])
		var_70_0.y = math.random(var_0_0.EffectPosLimit.limitY[1], var_0_0.EffectPosLimit.limitY[2])
	end

	arg_70_0.lastPos = var_70_0

	return var_70_0
end

function var_0_0.StopFireworksTimer(arg_71_0)
	if arg_71_0.fireworksTimer then
		arg_71_0.fireworksTimer:Stop()

		arg_71_0.fireworksTimer = nil
	end

	return
end

function var_0_0.StopPlayFireworks(arg_72_0)
	arg_72_0:StopFireworksTimer()

	arg_72_0.fireworks = nil
	arg_72_0.fireworkIndex = nil

	setActive(arg_72_0.fireworksTF, false)

	return
end

function var_0_0.getStudents(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = {}

	if not arg_73_0.springActivity then
		return {}
	end

	local var_73_1 = arg_73_0.springActivity:GetShipIds()

	for iter_73_0 = 1, arg_73_0.springMaxCnt do
		if var_73_1[iter_73_0] and var_73_1[iter_73_0] ~= 0 then
			local var_73_2 = getProxy(BayProxy):RawGetShipById(var_73_1[iter_73_0])

			if var_73_2 then
				table.insert(var_73_0, var_73_2)
			end
		end
	end

	if not arg_73_1 or not arg_73_2 then
		arg_73_1 = #var_73_0
		arg_73_2 = #var_73_0
	end

	local var_73_3 = math.random(arg_73_1, arg_73_2)

	while var_73_3 > 0 and #var_73_0 > 0 do
		local var_73_4 = math.random(1, #var_73_0)

		table.insert({}, var_73_0[var_73_4]:getPrefab())

		var_73_0[var_73_4] = var_73_0[#var_73_0]
		var_73_3 = var_73_3 - 1
	end

	return {}
end

function var_0_0.InitStudents(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_0:getStudents(arg_74_1, arg_74_2)

	for iter_74_0, iter_74_1 in pairs(arg_74_0.graphPath.points) do
		if not iter_74_1.outRandom then
			table.insert({}, iter_74_1)
		end
	end

	arg_74_0.academyStudents = {}

	for iter_74_2, iter_74_3 in pairs(var_74_0) do
		local var_74_3

		if not arg_74_0.academyStudents[iter_74_2] then
			local var_74_1 = cloneTplTo(arg_74_0._shipTpl, arg_74_0._map)

			var_74_1.gameObject.name = iter_74_2

			local var_74_2 = arg_74_0:ChooseRandomPos({}, #{})

			var_74_3 = (#{} - 2) % #{} + 1

			local var_74_4 = SummerFeastNavigationAgent.New(var_74_1.gameObject)

			var_74_4.normalSpeed = 100

			var_74_4:attach()
			var_74_4:setPathFinder(arg_74_0.graphPath)
			var_74_4:SetPositionTable({})
			var_74_4:setCurrentIndex(var_74_2 and var_74_2.id)
			var_74_4:SetOnTransEdge(function(arg_75_0, arg_75_1, arg_75_2)
				arg_75_2 = math.max(arg_75_1, arg_75_2)
				arg_75_1 = math.min(arg_75_1, arg_75_2)

				local var_75_0 = arg_74_0.edge2area[arg_75_1 .. "_" .. arg_75_2] or arg_74_0.edge2area.default

				arg_75_0._tf:SetParent(arg_74_0[var_75_0])

				return
			end)
			var_74_4:updateStudent(iter_74_3)

			arg_74_0.academyStudents[iter_74_2] = var_74_4
		end
	end

	if #var_74_0 > 0 then
		arg_74_0.sortTimer = Timer.New(function()
			arg_74_0:sortStudents()

			return
		end, 0.2, -1)

		arg_74_0.sortTimer:Start()
		arg_74_0.sortTimer.func()
	end

	return
end

function var_0_0.ChooseRandomPos(arg_77_0, arg_77_1, arg_77_2)
	local var_77_0 = math.random(1, arg_77_2)

	if not var_77_0 then
		return nil
	end

	pg.Tool.Swap(arg_77_1, var_77_0, arg_77_2)

	return arg_77_1[arg_77_2]
end

function var_0_0.SetTips(arg_78_0)
	arg_78_0:SetPtTip()
	arg_78_0:SetTaskTip()
	arg_78_0:SetFireworkTip()
	arg_78_0:SetSpringTip()

	return
end

function var_0_0.SetPtTip(arg_79_0)
	local var_79_0 = arg_79_0.ptData:CanGetAward()

	setActive(arg_79_0.ptBtn:Find("tip"), var_79_0)
	setActive(arg_79_0.subPtBtn:Find("tip"), var_79_0)

	return
end

function var_0_0.SetTaskTip(arg_80_0)
	setActive(arg_80_0.taskBtn:Find("tip"), arg_80_0.canGetTaskAward)
	setActive(arg_80_0.subTaskBtn:Find("tip"), arg_80_0.canGetTaskAward)

	return
end

function var_0_0.SetFireworkTip(arg_81_0)
	local var_81_0 = #arg_81_0.fireworkUnlockIds ~= #arg_81_0.fireworkGotIds

	setActive(arg_81_0.fireworkBtn:Find("tip"), #arg_81_0.fireworkUnlockIds ~= #arg_81_0.fireworkGotIds)
	setActive(arg_81_0.subFireworkBtn:Find("tip"), var_81_0)

	return
end

function var_0_0.SetSpringTip(arg_82_0)
	local var_82_0 = false

	for iter_82_0 = 1, arg_82_0.springUnlockSlotCount do
		if arg_82_0.springShipIds[iter_82_0] == 0 then
			var_82_0 = true

			break
		end
	end

	setActive(arg_82_0.springBtn:Find("tip"), var_82_0)
	setActive(arg_82_0.subSpringBtn:Find("tip"), var_82_0)

	return
end

function var_0_0.OnDestroy(arg_83_0)
	arg_83_0:CloseSubPanel()
	arg_83_0:StopPlayFireworks()
	arg_83_0:clearStudents()
	var_0_0.super.OnDestroy(arg_83_0)

	return
end

return var_0_0
