local var_0_0 = class("FireworkAndSpringScene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "FireworkAndSpringUI"
end

var_0_0.edge2area = {
	default = "_SDPlace"
}
var_0_0.EffectPoolCnt = 3
var_0_0.Id2EffectName = {
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

function var_0_0.init(arg_2_0)
	arg_2_0:InitData()
	var_0_0.super.init(arg_2_0)

	arg_2_0._map = arg_2_0._tf:Find("map")
	arg_2_0._shipTpl = arg_2_0._tf:Find("ship")
	arg_2_0.fireworksTF = arg_2_0._tf:Find("fireworks")
	arg_2_0._SDPlace = arg_2_0._tf:Find("SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.FireworkAndSpringGraph"))
	arg_2_0.backBtn = arg_2_0._tf:Find("panel/btn_back")
	arg_2_0.tipBtn = arg_2_0._tf:Find("panel/btn_tip")
	arg_2_0.ptBtn = arg_2_0._tf:Find("panel/btn_pt")
	arg_2_0.stage = arg_2_0._tf:Find("panel/btn_pt/stage")
	arg_2_0.pt = arg_2_0._tf:Find("panel/btn_pt/pt")
	arg_2_0.taskBtn = arg_2_0._tf:Find("panel/btn_task")
	arg_2_0.fireworkBtn = arg_2_0._tf:Find("panel/btn_firework")
	arg_2_0.springBtn = arg_2_0._tf:Find("panel/btn_spring")
	arg_2_0.subPanel = arg_2_0._tf:Find("subPanel")
	arg_2_0.subPanelPanel = arg_2_0.subPanel:Find("panel")
	arg_2_0.subLeft = arg_2_0.subPanelPanel:Find("left")
	arg_2_0.subRight = arg_2_0.subPanelPanel:Find("right")
	arg_2_0.subPtBtn = arg_2_0.subLeft:Find("ptBtn")
	arg_2_0.subTaskBtn = arg_2_0.subLeft:Find("taskBtn")
	arg_2_0.subFireworkBtn = arg_2_0.subLeft:Find("fireworkBtn")
	arg_2_0.subSpringBtn = arg_2_0.subLeft:Find("springBtn")
	arg_2_0.ptPanel = arg_2_0.subRight:Find("ptPanel")
	arg_2_0.taskPanel = arg_2_0.subRight:Find("taskPanel")
	arg_2_0.fireworkPanel = arg_2_0.subRight:Find("fireworkPanel")
	arg_2_0.springPanel = arg_2_0.subRight:Find("springPanel")

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:UpdateMainPt()

	arg_3_0.firePools = {}

	arg_3_0:PlayFireworks()
	arg_3_0:InitStudents()
	arg_3_0:SetTips()
	arg_3_0:CloseSubPanel()

	arg_3_0.hasClonedFireworkArrows = false

	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:closeView()

		return
	end)
	onButton(arg_3_0, arg_3_0.tipBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.firework_2025_tip.tip
		})

		return
	end)
	onButton(arg_3_0, arg_3_0.ptBtn, function()
		arg_3_0:OpenSubPanel(arg_3_0.ptPanel)
		arg_3_0:SetPtPanel()

		return
	end)
	onButton(arg_3_0, arg_3_0.taskBtn, function()
		arg_3_0:OpenSubPanel(arg_3_0.taskPanel)
		arg_3_0:SetTaskPanel()

		return
	end)
	onButton(arg_3_0, arg_3_0.fireworkBtn, function()
		arg_3_0:OpenSubPanel(arg_3_0.fireworkPanel)
		arg_3_0:SetFireWorkPanel()

		return
	end)
	onButton(arg_3_0, arg_3_0.springBtn, function()
		arg_3_0:OpenSubPanel(arg_3_0.springPanel)
		arg_3_0:SetSpringPanel()

		return
	end)
	onButton(arg_3_0, arg_3_0.subPanel, function()
		arg_3_0:CloseSubPanel()
		arg_3_0:PlayFireworks()

		return
	end)
	onButton(arg_3_0, arg_3_0.ptPanel:Find("btnClose"), function()
		arg_3_0:CloseSubPanel()
		arg_3_0:PlayFireworks()

		return
	end)
	onButton(arg_3_0, arg_3_0.taskPanel:Find("btnClose"), function()
		arg_3_0:CloseSubPanel()
		arg_3_0:PlayFireworks()

		return
	end)
	onButton(arg_3_0, arg_3_0.fireworkPanel:Find("btnClose"), function()
		arg_3_0:CloseSubPanel()
		arg_3_0:PlayFireworks()

		return
	end)
	onButton(arg_3_0, arg_3_0.springPanel:Find("btnClose"), function()
		arg_3_0:CloseSubPanel()
		arg_3_0:PlayFireworks()

		return
	end)
	onButton(arg_3_0, arg_3_0.subPtBtn, function()
		arg_3_0:SetSubPanel(arg_3_0.ptPanel)
		arg_3_0:SetPtPanel()

		return
	end)
	onButton(arg_3_0, arg_3_0.subTaskBtn, function()
		arg_3_0:SetSubPanel(arg_3_0.taskPanel)
		arg_3_0:SetTaskPanel()

		return
	end)
	onButton(arg_3_0, arg_3_0.subFireworkBtn, function()
		arg_3_0:SetSubPanel(arg_3_0.fireworkPanel)
		arg_3_0:SetFireWorkPanel()

		return
	end)
	onButton(arg_3_0, arg_3_0.subSpringBtn, function()
		arg_3_0:SetSubPanel(arg_3_0.springPanel)
		arg_3_0:SetSpringPanel()

		return
	end)

	return
end

function var_0_0.InitData(arg_19_0)
	arg_19_0.ptActId = ActivityConst.FireworkAndSpring_PT_ID
	arg_19_0.taskActId = ActivityConst.FireworkAndSpring_TASK_ID
	arg_19_0.fireworkActId = ActivityConst.FireworkAndSpring_ACT_ID
	arg_19_0.springActId = ActivityConst.FireworkAndSpring_EMO_ID

	arg_19_0:UpdatePtData()
	arg_19_0:UpdateTaskData()
	arg_19_0:UpdateFireworkData()
	arg_19_0:UpdateSpringData()

	return
end

function var_0_0.UpdatePtData(arg_20_0)
	arg_20_0.ptActivity = getProxy(ActivityProxy):getActivityById(arg_20_0.ptActId)
	arg_20_0.ptData = ActivityPtData.New(arg_20_0.ptActivity)

	return
end

function var_0_0.UpdateTaskData(arg_21_0)
	arg_21_0.taskActivity = getProxy(ActivityProxy):getActivityById(arg_21_0.taskActId)
	arg_21_0.taskVOs = {}

	for iter_21_0, iter_21_1 in pairs((arg_21_0.taskActivity:getConfig("config_data"))) do
		local var_21_0 = getProxy(TaskProxy)

		table.insert(arg_21_0.taskVOs, var_21_0:getTaskVO(iter_21_1))
	end

	arg_21_0.canGetTaskVOs = {}
	arg_21_0.canGetTaskIds = {}

	arg_21_0:sort(arg_21_0.taskVOs)

	return
end

function var_0_0.sort(arg_22_0, arg_22_1)
	arg_22_0.canGetTaskAward = false

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		if iter_22_1:getTaskStatus() == 1 then
			table.insert({}, iter_22_1)
			table.insert(arg_22_0.canGetTaskVOs, iter_22_1)
			table.insert(arg_22_0.canGetTaskIds, iter_22_1.id)

			arg_22_0.canGetTaskAward = true
		end
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_1) do
		if iter_22_3:getTaskStatus() == 0 then
			table.insert({}, iter_22_3)
		end
	end

	for iter_22_4, iter_22_5 in pairs(arg_22_1) do
		if iter_22_5:getTaskStatus() == 2 then
			table.insert({}, iter_22_5)
		end
	end

	arg_22_0.taskVOs = {}

	return
end

function var_0_0.UpdateFireworkData(arg_23_0)
	arg_23_0.fireworkActivity = getProxy(ActivityProxy):getActivityById(arg_23_0.fireworkActId)
	arg_23_0.fireworkUnlockIds = arg_23_0.fireworkActivity.data1_list
	arg_23_0.fireworkGotIds = arg_23_0.fireworkActivity.data2_list
	arg_23_0.fireworkAllIds = arg_23_0.fireworkActivity:GetPicturePuzzleIds()
	arg_23_0.playerId = getProxy(PlayerProxy):getData().id
	arg_23_0.fireworkOrderIds = arg_23_0:GetFireWorkLocalData()

	return
end

function var_0_0.GetFireWorkLocalData(arg_24_0)
	for iter_24_0 = 1, #arg_24_0.fireworkAllIds do
		local var_24_0 = PlayerPrefs.GetInt("fireworks_" .. arg_24_0.fireworkActId .. "_" .. arg_24_0.playerId .. "_pos_" .. iter_24_0)

		if var_24_0 ~= 0 then
			table.insert({}, var_24_0)
		end
	end

	return {}
end

function var_0_0.SetFireWorkLocalData(arg_25_0)
	for iter_25_0 = 1, #arg_25_0.fireworkAllIds do
		local var_25_0 = arg_25_0.fireworkOrderIds[iter_25_0] or 0

		PlayerPrefs.SetInt("fireworks_" .. arg_25_0.fireworkActId .. "_" .. arg_25_0.playerId .. "_pos_" .. iter_25_0, var_25_0)
	end

	return
end

function var_0_0.UpdateSpringData(arg_26_0)
	arg_26_0.springActivity = getProxy(ActivityProxy):getActivityById(arg_26_0.springActId)
	arg_26_0.springShipIds = _.map(arg_26_0.springActivity:GetShipIds(), function(arg_27_0)
		if getProxy(BayProxy):RawGetShipById(arg_27_0) then
			return arg_27_0
		else
			return 0
		end

		return
	end)
	arg_26_0.springMaxCnt = arg_26_0.springActivity:GetSlotCount()
	arg_26_0.springSlotLockList = {}
	arg_26_0.springUnlockSlotCount = arg_26_0.springActivity:getConfig("config_client").initialCount

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.springActivity:getConfig("config_client").unlockPt) do
		if iter_26_1 <= arg_26_0.ptData.count then
			arg_26_0.springUnlockSlotCount = arg_26_0.springUnlockSlotCount + 1
		end
	end

	for iter_26_2 = 1, arg_26_0.springMaxCnt do
		arg_26_0.springSlotLockList[iter_26_2] = iter_26_2 > arg_26_0.springUnlockSlotCount
	end

	arg_26_0.energyRecoverAddition = arg_26_0.springActivity:GetEnergyRecoverAddition() * 10

	return
end

function var_0_0.OpenSubPanel(arg_28_0, arg_28_1)
	setActive(arg_28_0.subPanel, true)
	arg_28_0:SetSubPanel(arg_28_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_28_0.subPanelPanel)

	return
end

function var_0_0.CloseSubPanel(arg_29_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_29_0.subPanelPanel, arg_29_0.subPanel)
	setActive(arg_29_0.subPanel, false)

	return
end

function var_0_0.SetSubPanel(arg_30_0, arg_30_1)
	setActive(arg_30_0.ptPanel, false)
	setActive(arg_30_0.taskPanel, false)
	setActive(arg_30_0.fireworkPanel, false)
	setActive(arg_30_0.springPanel, false)
	setActive(arg_30_1, true)
	setActive(arg_30_0.subPtBtn:Find("selected"), arg_30_1 == arg_30_0.ptPanel)
	setActive(arg_30_0.subTaskBtn:Find("selected"), arg_30_1 == arg_30_0.taskPanel)
	setActive(arg_30_0.subFireworkBtn:Find("selected"), arg_30_1 == arg_30_0.fireworkPanel)
	setActive(arg_30_0.subSpringBtn:Find("selected"), arg_30_1 == arg_30_0.springPanel)

	return
end

function var_0_0.UpdateMainPt(arg_31_0)
	setText(arg_31_0.stage, "Lv." .. arg_31_0.ptData:GetCurrLevel())

	if not arg_31_0.ptData:IsMaxLevel() then
		setText(arg_31_0.pt, arg_31_0.ptData.count .. "/" .. arg_31_0.ptData:GetNextLevelTarget())
	else
		setText(arg_31_0.pt, "MAX")
	end

	return
end

function var_0_0.SetPtPanel(arg_32_0)
	setText(arg_32_0.ptPanel:Find("lvText"), arg_32_0.ptData:GetCurrLevel())

	if not arg_32_0.ptData:IsMaxLevel() then
		setText(arg_32_0.ptPanel:Find("pt"), arg_32_0.ptData.count .. "/" .. arg_32_0.ptData:GetNextLevelTarget())
		setSlider(arg_32_0.ptPanel:Find("slider"), 0, arg_32_0.ptData:GetNextLevelTarget(), arg_32_0.ptData.count)
	else
		setText(arg_32_0.ptPanel:Find("pt"), "MAX")
		setSlider(arg_32_0.ptPanel:Find("slider"), 0, 1, 1)
	end

	setText(arg_32_0.ptPanel:Find("ptScroll/Viewport/Content/tpl/get/Text"), i18n("firework_2025_get"))
	setText(arg_32_0.ptPanel:Find("ptScroll/Viewport/Content/tpl/got/Text"), i18n("firework_2025_got"))

	local var_32_0 = UIItemList.New(arg_32_0.ptPanel:Find("ptScroll/Viewport/Content"), arg_32_0.ptPanel:Find("ptScroll/Viewport/Content/tpl"))

	var_32_0:make(function(arg_33_0, arg_33_1, arg_33_2)
		if arg_33_0 == UIItemList.EventUpdate then
			setText(arg_33_2:Find("level"), i18n("firework_2025_level", arg_33_1 + 1))
			updateDrop(arg_33_2:Find("award"), (Drop.Create(arg_32_0.ptData.dropList[arg_33_1 + 1])))
			onButton(arg_32_0, arg_33_2:Find("award"), function()
				arg_32_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_33_1 = arg_32_0.ptData:GetDroptItemState(arg_33_1 + 1)

			if var_33_1 == ActivityPtData.STATE_LOCK then
				setActive(arg_33_2:Find("lock"), true)
				setActive(arg_33_2:Find("get"), false)
				setActive(arg_33_2:Find("got"), false)
			elseif var_33_1 == ActivityPtData.STATE_CAN_GET then
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
	var_32_0:align(#arg_32_0.ptData.dropList)

	local var_32_1 = rtf(arg_32_0.ptPanel:Find("ptScroll/Viewport/Content/tpl")).rect.width
	local var_32_2 = arg_32_0.ptPanel:Find("ptScroll/Viewport/Content"):GetComponent(typeof(HorizontalLayoutGroup)).spacing
	local var_32_3 = rtf(arg_32_0.ptPanel:Find("ptScroll/Viewport")).rect.width

	scrollTo(arg_32_0.ptPanel:Find("ptScroll"), arg_32_0.ptData.level * (var_32_1 + var_32_2) / (#arg_32_0.ptData.targets * (var_32_1 + var_32_2) - var_32_2 - var_32_3), 0)

	arg_32_0.importants = arg_32_0.ptActivity:getConfig("config_client").highValueItemSort
	arg_32_0.importantsPos = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.importants) do
		table.insert(arg_32_0.importantsPos, (iter_32_1 - 6 - 1) * (var_32_1 + var_32_2) / (#arg_32_0.ptData.targets * (var_32_1 + var_32_2) - var_32_2 - var_32_3))
	end

	arg_32_0:PtScrollToDo(arg_32_0.ptData.level * (var_32_1 + var_32_2) / (#arg_32_0.ptData.targets * (var_32_1 + var_32_2) - var_32_2 - var_32_3))
	onScroll(arg_32_0, arg_32_0.ptPanel:Find("ptScroll"), function(arg_35_0)
		arg_32_0:PtScrollToDo(arg_35_0.x)

		return
	end)

	if arg_32_0.ptData:CanGetAward() then
		setActive(arg_32_0.ptPanel:Find("btn_get"), true)
		onButton(arg_32_0, arg_32_0.ptPanel:Find("btn_get"), function()
			local var_36_0 = arg_32_0.ptData:GetAllAvailableAwards()
			local var_36_1 = getProxy(PlayerProxy):getRawData()
			local var_36_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
			local var_36_3, var_36_4 = Task.StaticJudgeOverflow(var_36_1.gold, var_36_1.oil, var_36_2, true, true, var_36_0)

			if var_36_3 then
				table.insert({}, function(arg_37_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_36_4,
						onYes = arg_37_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_32_0:emit(FireworkAndSpringMediator.EVENT_PT_OPERATION, {
					cmd = 4,
					activity_id = arg_32_0.ptData:GetId(),
					arg1 = arg_32_0.ptData:GetCurrTarget()
				})

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(arg_32_0.ptPanel:Find("btn_get"), false)
		removeOnButton(arg_32_0.ptPanel:Find("btn_get"))
	end

	setText(arg_32_0.ptPanel:Find("ptName"), i18n("firework_2025_pt"))

	return
end

function var_0_0.PtScrollToDo(arg_39_0, arg_39_1)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.importantsPos) do
		if arg_39_1 < iter_39_1 or iter_39_0 == #arg_39_0.importants then
			var_39_0 = arg_39_0.importants[iter_39_0]

			break
		end
	end

	updateDrop(arg_39_0.ptPanel:Find("award"), (Drop.Create(arg_39_0.ptData.dropList[var_39_0])))
	onButton(arg_39_0, arg_39_0.ptPanel:Find("award"), function()
		arg_39_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setText(arg_39_0.ptPanel:Find("awardInfo/Text"), i18n("firework_2025_level", var_39_0))
	setActive(arg_39_0.ptPanel:Find("award/got"), var_39_0 <= arg_39_0.ptData.level)

	return
end

function var_0_0.SetTaskPanel(arg_41_0)
	setText(arg_41_0.taskPanel:Find("lvText"), arg_41_0.ptData:GetCurrLevel())

	if not arg_41_0.ptData:IsMaxLevel() then
		setText(arg_41_0.taskPanel:Find("pt"), arg_41_0.ptData.count .. "/" .. arg_41_0.ptData:GetNextLevelTarget())
		setSlider(arg_41_0.taskPanel:Find("slider"), 0, arg_41_0.ptData:GetNextLevelTarget(), arg_41_0.ptData.count)
	else
		setText(arg_41_0.taskPanel:Find("pt"), "MAX")
		setSlider(arg_41_0.taskPanel:Find("slider"), 0, 1, 1)
	end

	local var_41_0 = UIItemList.New(arg_41_0.taskPanel:Find("taskScroll/Viewport/Content"), arg_41_0.taskPanel:Find("taskScroll/Viewport/Content/Tasktpl"))

	var_41_0:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventUpdate then
			local var_42_0 = arg_41_0.taskVOs[arg_42_1 + 1]

			setText(arg_42_2:Find("frame/name"), arg_41_0.taskVOs[arg_42_1 + 1]:getConfig("name"))
			setText(arg_42_2:Find("frame/desc"), arg_41_0.taskVOs[arg_42_1 + 1]:getConfig("desc"))

			local var_42_1 = arg_41_0.taskVOs[arg_42_1 + 1]:getConfig("target_num")
			local var_42_2 = math.min(arg_41_0.taskVOs[arg_42_1 + 1]:getProgress(), var_42_1)

			setText(arg_42_2:Find("frame/progress"), var_42_2 .. "/" .. var_42_1)

			arg_42_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_42_2 / var_42_1

			local var_42_3 = arg_42_2:Find("frame/awards")

			arg_41_0:updateTaskAwards(arg_41_0.taskVOs[arg_42_1 + 1]:getConfig("award_display"), var_42_3, (var_42_3:GetChild(0)))

			local var_42_4 = arg_42_2:Find("frame/go_btn")
			local var_42_5 = arg_42_2:Find("frame/get_btn")
			local var_42_6 = arg_42_2:Find("frame/got_btn")

			if arg_41_0.taskVOs[arg_42_1 + 1]:getTaskStatus() == 0 then
				setActive(var_42_4, true)
				setActive(var_42_5, false)
				setActive(var_42_6, false)
			elseif arg_41_0.taskVOs[arg_42_1 + 1]:getTaskStatus() == 1 then
				setActive(var_42_4, false)
				setActive(var_42_5, true)
				setActive(var_42_6, false)
			elseif arg_41_0.taskVOs[arg_42_1 + 1]:getTaskStatus() == 2 then
				setActive(var_42_4, false)
				setActive(var_42_5, false)
				setActive(var_42_6, true)
			end

			onButton(arg_41_0, var_42_4, function()
				arg_41_0:emit(FireworkAndSpringMediator.ON_TASK_GO, var_42_0)

				return
			end, SFX_PANEL)
			onButton(arg_41_0, var_42_5, function()
				arg_41_0:emit(FireworkAndSpringMediator.ON_TASK_SUBMIT, var_42_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_41_0:align(#arg_41_0.taskVOs)

	if arg_41_0.canGetTaskAward then
		setActive(arg_41_0.taskPanel:Find("btn_get"), true)
		onButton(arg_41_0, arg_41_0.taskPanel:Find("btn_get"), function()
			local var_45_0 = {}

			for iter_45_0, iter_45_1 in pairs(arg_41_0.canGetTaskVOs) do
				for iter_45_2, iter_45_3 in ipairs((iter_45_1:getConfig("award_display"))) do
					local var_45_2 = false

					for iter_45_4, iter_45_5 in pairs(var_45_0) do
						if iter_45_5[1] == iter_45_3[1] and iter_45_5[2] == iter_45_3[2] then
							var_45_2 = true
							iter_45_5[3] = iter_45_5[3] + iter_45_3[3]

							break
						end
					end

					if not var_45_2 then
						table.insert(var_45_0, iter_45_3)
					end
				end
			end

			local var_45_3 = getProxy(PlayerProxy):getRawData()
			local var_45_4 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
			local var_45_5, var_45_6 = Task.StaticJudgeOverflow(var_45_3.gold, var_45_3.oil, var_45_4, true, true, var_45_0)

			if var_45_5 then
				table.insert({}, function(arg_46_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_45_6,
						onYes = arg_46_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_41_0:emit(FireworkAndSpringMediator.ON_TASK_SUBMIT_ONESTEP, arg_41_0.taskActId, arg_41_0.canGetTaskIds)

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(arg_41_0.taskPanel:Find("btn_get"), false)
		removeOnButton(arg_41_0.taskPanel:Find("btn_get"))
	end

	setText(arg_41_0.taskPanel:Find("ptName"), i18n("firework_2025_pt"))

	return
end

function var_0_0.updateTaskAwards(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = _.slice(arg_48_1, 1, 3)

	for iter_48_0 = arg_48_2.childCount, #var_48_0 - 1 do
		cloneTplTo(arg_48_3, arg_48_2)
	end

	for iter_48_1 = 1, arg_48_2.childCount do
		local var_48_1 = arg_48_2:GetChild(iter_48_1 - 1)
		local var_48_2 = iter_48_1 <= #var_48_0

		setActive(var_48_1, iter_48_1 <= #var_48_0)

		if var_48_2 then
			updateDrop(var_48_1, {
				type = var_48_0[iter_48_1][1],
				id = var_48_0[iter_48_1][2],
				count = var_48_0[iter_48_1][3]
			})
			onButton(arg_48_0, var_48_1, function()
				arg_48_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.SetFireWorkPanel(arg_50_0)
	local var_50_0 = arg_50_0.fireworkPanel:Find("left_panel")
	local var_50_1 = arg_50_0.fireworkPanel:Find("right_panel")

	arg_50_0.leftUIList = UIItemList.New(var_50_0:Find("scrollrect/content"), (var_50_0:Find("scrollrect/content/item_tpl")))
	arg_50_0.rightUIList = UIItemList.New(var_50_1:Find("content"), (var_50_1:Find("content/item_tpl")))

	local var_50_2 = var_50_1:Find("arrows")

	onButton(arg_50_0, var_50_1:Find("fire_btn"), function()
		arg_50_0:CloseSubPanel()
		arg_50_0:PlayFireworks()

		return
	end)
	setText(var_50_1:Find("tip"), i18n("activity_yanhua_tip7"))
	setText(var_50_0:Find("tip"), i18n("firework_2025_tip1"))
	arg_50_0.leftUIList:make(function(arg_52_0, arg_52_1, arg_52_2)
		if arg_52_0 == UIItemList.EventUpdate then
			local var_52_0 = arg_50_0.fireworkAllIds[arg_52_1 + 1]

			GetImageSpriteFromAtlasAsync(Item.getConfigData(arg_50_0.fireworkAllIds[arg_52_1 + 1]).icon, "", (arg_52_2:Find("firework/icon")))
			setActive(arg_52_2:Find("firework/selected"), (table.contains(arg_50_0.fireworkOrderIds, arg_50_0.fireworkAllIds[arg_52_1 + 1])))

			if not table.contains(arg_50_0.fireworkUnlockIds, arg_50_0.fireworkAllIds[arg_52_1 + 1]) then
				setActive(arg_52_2:Find("firework/lock"), true)
				setActive(arg_52_2:Find("firework/get"), false)
			elseif not table.contains(arg_50_0.fireworkGotIds, arg_50_0.fireworkAllIds[arg_52_1 + 1]) then
				setActive(arg_52_2:Find("firework/lock"), false)
				setActive(arg_52_2:Find("firework/get"), true)
				onButton(arg_50_0, arg_52_2, function()
					arg_50_0:emit(FireworkAndSpringMediator.ACTIVITY_OPERATION, arg_50_0.fireworkActId, var_52_0)

					return
				end, SFX_PANEL)
			else
				setActive(arg_52_2:Find("firework/lock"), false)
				setActive(arg_52_2:Find("firework/get"), false)
				onButton(arg_50_0, arg_52_2, function()
					arg_50_0:FireworkLeftClick(var_52_0, var_0)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	arg_50_0.leftUIList:align(#arg_50_0.fireworkAllIds)

	if not arg_50_0.hasClonedFireworkArrows then
		arg_50_0.hasClonedFireworkArrows = true

		for iter_50_0 = 1, #arg_50_0.fireworkAllIds - 2 do
			cloneTplTo(var_50_2:Find("tpl"), var_50_2)
		end
	end

	arg_50_0.rightUIList:make(function(arg_55_0, arg_55_1, arg_55_2)
		if arg_55_0 == UIItemList.EventUpdate then
			local var_55_0 = arg_55_1 + 1
			local var_55_1 = arg_55_2:Find("icon")

			setActive(arg_55_2:Find("add"), arg_55_1 + 1 > #arg_50_0.fireworkOrderIds)

			if var_55_0 > #arg_50_0.fireworkOrderIds then
				setActive(var_55_1, false)
			else
				local var_55_2 = arg_50_0.fireworkOrderIds[var_55_0]

				setActive(var_55_1, true)
				GetImageSpriteFromAtlasAsync(Item.getConfigData(var_55_2).icon, "", var_55_1)
				onButton(arg_50_0, var_55_1, function()
					arg_50_0:FireworkRightClick(var_55_2)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	arg_50_0.rightUIList:align(#arg_50_0.fireworkAllIds)

	return
end

function var_0_0.FireworkLeftClick(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_2 then
		table.removebyvalue(arg_57_0.fireworkOrderIds, arg_57_1)
	else
		table.insert(arg_57_0.fireworkOrderIds, arg_57_1)
	end

	arg_57_0:SetFireWorkLocalData()
	arg_57_0.leftUIList:align(#arg_57_0.fireworkAllIds)
	arg_57_0.rightUIList:align(#arg_57_0.fireworkAllIds)

	return
end

function var_0_0.FireworkRightClick(arg_58_0, arg_58_1)
	table.removebyvalue(arg_58_0.fireworkOrderIds, arg_58_1)
	arg_58_0:SetFireWorkLocalData()
	arg_58_0.leftUIList:align(#arg_58_0.fireworkAllIds)
	arg_58_0.rightUIList:align(#arg_58_0.fireworkAllIds)

	return
end

function var_0_0.SetSpringPanel(arg_59_0)
	arg_59_0:CreateSpringUI()
	arg_59_0:UpdateSpringUI()

	return
end

function var_0_0.CreateSpringUI(arg_60_0)
	setText(arg_60_0.springPanel:Find("list/iconTpl/lock/Text"), i18n("firework_2025_unlock_tip1"))

	arg_60_0.springList = UIItemList.New(arg_60_0.springPanel:Find("list"), arg_60_0.springPanel:Find("list/iconTpl"))

	arg_60_0.springList:make(function(arg_61_0, arg_61_1, arg_61_2)
		if arg_61_0 == UIItemList.EventUpdate then
			local var_61_0 = arg_60_0.springShipIds[arg_61_1 + 1]
			local var_61_1 = arg_60_0.springSlotLockList[arg_61_1 + 1]
			local var_61_2 = arg_60_0.springShipIds[arg_61_1 + 1] and var_61_0 > 0

			setActive(arg_61_2:Find("lock"), arg_60_0.springSlotLockList[arg_61_1 + 1])
			setActive(arg_61_2:Find("add"), not var_61_1 and not var_61_2)
			setActive(arg_61_2:Find("ship"), not var_61_1 and var_61_2)

			if var_61_1 then
				setText(arg_61_2:Find("lock/taskText"), i18n("firework_2025_unlock_tip2", arg_60_0.springActivity:getConfig("config_client").unlockPt[arg_61_1 + 1 - arg_60_0.springActivity:getConfig("config_client").initialCount]))
			end

			onButton(arg_60_0, arg_61_2, function()
				if var_61_1 then
					return
				end

				local var_62_0

				if var_61_2 then
					var_62_0 = getProxy(BayProxy):getShipById(var_61_0)
				end

				arg_60_0:StopPlayFireworks()
				arg_60_0:emit(FireworkAndSpringMediator.OPEN_CHUANWU, arg_60_0.springActId, arg_61_1 + 1, var_62_0, arg_60_0.springUnlockSlotCount)

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
	setText(arg_60_0.springPanel:Find("tipText1"), i18n("firework_2025_tip2"))
	setText(arg_60_0.springPanel:Find("tipText2"), "+" .. arg_60_0.energyRecoverAddition .. "/h")

	return
end

function var_0_0.UpdateSpringUI(arg_63_0)
	arg_63_0.springList:align(arg_63_0.springMaxCnt)

	return
end

function var_0_0.UpdateSpringActivityAndUI(arg_64_0)
	arg_64_0:UpdateSpringData()
	arg_64_0:UpdateSpringUI()
	arg_64_0:clearStudents()
	arg_64_0:InitStudents()

	return
end

function var_0_0.PlayFireworks(arg_65_0)
	arg_65_0.fireworks = Clone(arg_65_0.fireworkOrderIds)

	if #arg_65_0.fireworks == 0 then
		return
	end

	eachChild(arg_65_0.fireworksTF, function(arg_66_0)
		setActive(arg_66_0, false)

		return
	end)
	setActive(arg_65_0.fireworksTF, true)
	arg_65_0:StopFireworksTimer()

	arg_65_0.fireworkIndex = 1
	arg_65_0.fireworksTimer = Timer.New(function()
		arg_65_0:PlayerOneFirework()

		return
	end, var_0_0.EffectInterval, #arg_65_0.fireworks)

	arg_65_0.fireworksTimer:Start()

	return
end

function var_0_0.PlayerOneFirework(arg_68_0)
	if arg_68_0.fireworkIndex == #arg_68_0.fireworks then
		arg_68_0:managedTween(LeanTween.delayedCall, function()
			if arg_68_0.fireworks then
				arg_68_0:StopPlayFireworks()
				arg_68_0:PlayFireworks()
			end

			return
		end, var_0_0.DelayPop, nil)
	end

	local var_68_0 = arg_68_0.fireworks[arg_68_0.fireworkIndex]
	local var_68_1 = math.random(#var_0_0.SFX_LIST)

	if arg_68_0.firePools[arg_68_0.fireworks[arg_68_0.fireworkIndex]] and #arg_68_0.firePools[var_68_0] >= var_0_0.EffectPoolCnt then
		setLocalPosition(arg_68_0.firePools[var_68_0][1], arg_68_0:GetFireworkPos())
		setActive(arg_68_0.firePools[var_68_0][1], true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_0.SFX_LIST[math.random(#var_0_0.SFX_LIST)])
		table.removebyvalue(arg_68_0.firePools[var_68_0], arg_68_0.firePools[var_68_0][1])
		table.insert(arg_68_0.firePools[var_68_0], arg_68_0.firePools[var_68_0][1])
	else
		arg_68_0.loader:GetPrefab("ui/" .. var_0_0.Id2EffectName[var_68_0], "", function(arg_70_0)
			pg.ViewUtils.SetSortingOrder(arg_70_0, 1)
			setParent(arg_70_0, arg_68_0.fireworksTF)
			setLocalPosition(arg_70_0, arg_68_0:GetFireworkPos())
			setActive(arg_70_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_0.SFX_LIST[var_68_1])

			arg_68_0.firePools[var_68_0] = arg_68_0.firePools[var_68_0] or {}

			table.insert(arg_68_0.firePools[var_68_0], arg_70_0)

			return
		end)
	end

	arg_68_0.fireworkIndex = arg_68_0.fireworkIndex + 1

	return
end

function var_0_0.GetFireworkPos(arg_71_0)
	local var_71_0 = Vector2(0, 0)

	if arg_71_0.lastPos then
		local var_71_1 = Vector2(arg_71_0.lastPos.x, arg_71_0.lastPos.y)
		local var_71_2 = math.abs(var_71_1.x - arg_71_0.lastPos.x)
		local var_71_3 = math.abs(var_71_1.y - arg_71_0.lastPos.y)

		while var_71_2 < var_0_0.FireworkRange.x / 2 and var_71_3 < var_0_0.FireworkRange.y or var_71_3 < var_0_0.FireworkRange.y / 2 and var_71_2 < var_0_0.FireworkRange.x do
			var_71_1.x = math.random(var_0_0.EffectPosLimit.limitX[1], var_0_0.EffectPosLimit.limitX[2])
			var_71_1.y = math.random(var_0_0.EffectPosLimit.limitY[1], var_0_0.EffectPosLimit.limitY[2])
			var_71_2 = math.abs(var_71_1.x - arg_71_0.lastPos.x)
			var_71_3 = math.abs(var_71_1.y - arg_71_0.lastPos.y)
		end

		var_71_0 = var_71_1
	else
		var_71_0.x = math.random(var_0_0.EffectPosLimit.limitX[1], var_0_0.EffectPosLimit.limitX[2])
		var_71_0.y = math.random(var_0_0.EffectPosLimit.limitY[1], var_0_0.EffectPosLimit.limitY[2])
	end

	arg_71_0.lastPos = var_71_0

	return var_71_0
end

function var_0_0.StopFireworksTimer(arg_72_0)
	if arg_72_0.fireworksTimer then
		arg_72_0.fireworksTimer:Stop()

		arg_72_0.fireworksTimer = nil
	end

	return
end

function var_0_0.StopPlayFireworks(arg_73_0)
	arg_73_0:StopFireworksTimer()

	arg_73_0.fireworks = nil
	arg_73_0.fireworkIndex = nil

	setActive(arg_73_0.fireworksTF, false)

	return
end

function var_0_0.getStudents(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = {}

	if not arg_74_0.springActivity then
		return {}
	end

	local var_74_1 = arg_74_0.springActivity:GetShipIds()

	for iter_74_0 = 1, arg_74_0.springMaxCnt do
		if var_74_1[iter_74_0] and var_74_1[iter_74_0] ~= 0 then
			local var_74_2 = getProxy(BayProxy):RawGetShipById(var_74_1[iter_74_0])

			if var_74_2 then
				table.insert(var_74_0, var_74_2)
			end
		end
	end

	if not arg_74_1 or not arg_74_2 then
		arg_74_1 = #var_74_0
		arg_74_2 = #var_74_0
	end

	local var_74_3 = math.random(arg_74_1, arg_74_2)

	while var_74_3 > 0 and #var_74_0 > 0 do
		local var_74_4 = math.random(1, #var_74_0)

		table.insert({}, var_74_0[var_74_4]:getPrefab())

		var_74_0[var_74_4] = var_74_0[#var_74_0]
		var_74_3 = var_74_3 - 1
	end

	return {}
end

function var_0_0.InitStudents(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = arg_75_0:getStudents(arg_75_1, arg_75_2)

	for iter_75_0, iter_75_1 in pairs(arg_75_0.graphPath.points) do
		if not iter_75_1.outRandom then
			table.insert({}, iter_75_1)
		end
	end

	arg_75_0.academyStudents = {}

	for iter_75_2, iter_75_3 in pairs(var_75_0) do
		local var_75_3

		if not arg_75_0.academyStudents[iter_75_2] then
			local var_75_1 = cloneTplTo(arg_75_0._shipTpl, arg_75_0._map)

			var_75_1.gameObject.name = iter_75_2

			local var_75_2 = arg_75_0:ChooseRandomPos({}, #{})

			var_75_3 = (#{} - 2) % #{} + 1

			local var_75_4 = SummerFeastNavigationAgent.New(var_75_1.gameObject)

			var_75_4.normalSpeed = 100

			var_75_4:attach()
			var_75_4:setPathFinder(arg_75_0.graphPath)
			var_75_4:SetPositionTable({})
			var_75_4:setCurrentIndex(var_75_2 and var_75_2.id)
			var_75_4:SetOnTransEdge(function(arg_76_0, arg_76_1, arg_76_2)
				arg_76_2 = math.max(arg_76_1, arg_76_2)
				arg_76_1 = math.min(arg_76_1, arg_76_2)

				local var_76_0 = arg_75_0.edge2area[arg_76_1 .. "_" .. arg_76_2] or arg_75_0.edge2area.default

				arg_76_0._tf:SetParent(arg_75_0[var_76_0])

				return
			end)
			var_75_4:updateStudent(iter_75_3)

			arg_75_0.academyStudents[iter_75_2] = var_75_4
		end
	end

	if #var_75_0 > 0 then
		arg_75_0.sortTimer = Timer.New(function()
			arg_75_0:sortStudents()

			return
		end, 0.2, -1)

		arg_75_0.sortTimer:Start()
		arg_75_0.sortTimer.func()
	end

	return
end

function var_0_0.ChooseRandomPos(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = math.random(1, arg_78_2)

	if not var_78_0 then
		return nil
	end

	pg.Tool.Swap(arg_78_1, var_78_0, arg_78_2)

	return arg_78_1[arg_78_2]
end

function var_0_0.SetTips(arg_79_0)
	arg_79_0:SetPtTip()
	arg_79_0:SetTaskTip()
	arg_79_0:SetFireworkTip()
	arg_79_0:SetSpringTip()

	return
end

function var_0_0.SetPtTip(arg_80_0)
	local var_80_0 = arg_80_0.ptData:CanGetAward()

	setActive(arg_80_0.ptBtn:Find("tip"), var_80_0)
	setActive(arg_80_0.subPtBtn:Find("tip"), var_80_0)

	return
end

function var_0_0.SetTaskTip(arg_81_0)
	setActive(arg_81_0.taskBtn:Find("tip"), arg_81_0.canGetTaskAward)
	setActive(arg_81_0.subTaskBtn:Find("tip"), arg_81_0.canGetTaskAward)

	return
end

function var_0_0.SetFireworkTip(arg_82_0)
	local var_82_0 = #arg_82_0.fireworkUnlockIds ~= #arg_82_0.fireworkGotIds

	setActive(arg_82_0.fireworkBtn:Find("tip"), #arg_82_0.fireworkUnlockIds ~= #arg_82_0.fireworkGotIds)
	setActive(arg_82_0.subFireworkBtn:Find("tip"), var_82_0)

	return
end

function var_0_0.SetSpringTip(arg_83_0)
	local var_83_0 = false

	for iter_83_0 = 1, arg_83_0.springUnlockSlotCount do
		if arg_83_0.springShipIds[iter_83_0] == 0 then
			var_83_0 = true

			break
		end
	end

	setActive(arg_83_0.springBtn:Find("tip"), var_83_0)
	setActive(arg_83_0.subSpringBtn:Find("tip"), var_83_0)

	return
end

function var_0_0.willExit(arg_84_0)
	arg_84_0:CloseSubPanel()
	arg_84_0:StopPlayFireworks()
	arg_84_0:clearStudents()
	var_0_0.super.willExit(arg_84_0)

	return
end

function var_0_0.IsShowMainTip(arg_85_0)
	local var_85_0 = ActivityConst.FireworkAndSpring_EMO_ID
	local var_85_1 = getProxy(ActivityProxy)
	local var_85_2 = ActivityPtData.New((var_85_1:getActivityById(ActivityConst.FireworkAndSpring_PT_ID)))
	local var_85_3 = var_85_2:CanGetAward()

	for iter_85_0, iter_85_1 in pairs((var_85_1:getActivityById(ActivityConst.FireworkAndSpring_TASK_ID):getConfig("config_data"))) do
		local var_85_4 = getProxy(TaskProxy)

		table.insert({}, var_85_4:getTaskVO(iter_85_1))
	end

	local var_85_5 = false

	for iter_85_2, iter_85_3 in pairs({}) do
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

return var_0_0
