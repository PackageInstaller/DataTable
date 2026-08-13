class = var_0_10000

local var_0_0 = "FireworkAndSpringScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "FireworkAndSpringUI"
end

var_0_1.edge2area = {
	default = "_SDPlace"
}
var_0_1.EffectPoolCnt = 3
var_0_1.Id2EffectName = {
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
Vector2 = var_1
var_0_1.FireworkRange = var_1(300, 300)
var_0_1.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
var_0_1.EffectInterval = 1
var_0_1.DelayPop = 2.5
var_0_1.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function var_0_1.init(arg_2_0)
	arg_2_0:InitData()
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_0, "map")

	local var_2_1 = arg_2_0._tf

	arg_2_0._shipTpl = var_1.Find(var_2_1, "ship")

	local var_2_2 = arg_2_0._tf

	arg_2_0.fireworksTF = var_1.Find(var_2_2, "fireworks")

	local var_2_3 = arg_2_0._tf

	arg_2_0._SDPlace = var_1.Find(var_2_3, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}
	GraphPath = var_1

	local var_2_4 = var_1.New

	import = var_2_3
	arg_2_0.graphPath = var_2_4(var_2_3("GameCfg.BackHillGraphs.FireworkAndSpringGraph"))

	local var_2_5 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_5, "panel/btn_back")

	local var_2_6 = arg_2_0._tf

	arg_2_0.tipBtn = var_1.Find(var_2_6, "panel/btn_tip")

	local var_2_7 = arg_2_0._tf

	arg_2_0.ptBtn = var_1.Find(var_2_7, "panel/btn_pt")

	local var_2_8 = arg_2_0._tf

	arg_2_0.stage = var_1.Find(var_2_8, "panel/btn_pt/stage")

	local var_2_9 = arg_2_0._tf

	arg_2_0.pt = var_1.Find(var_2_9, "panel/btn_pt/pt")

	local var_2_10 = arg_2_0._tf

	arg_2_0.taskBtn = var_1.Find(var_2_10, "panel/btn_task")

	local var_2_11 = arg_2_0._tf

	arg_2_0.fireworkBtn = var_1.Find(var_2_11, "panel/btn_firework")

	local var_2_12 = arg_2_0._tf

	arg_2_0.springBtn = var_1.Find(var_2_12, "panel/btn_spring")

	local var_2_13 = arg_2_0._tf

	arg_2_0.subPanel = var_1.Find(var_2_13, "subPanel")

	local var_2_14 = arg_2_0.subPanel

	arg_2_0.subPanelPanel = var_1.Find(var_2_14, "panel")

	local var_2_15 = arg_2_0.subPanelPanel

	arg_2_0.subLeft = var_1.Find(var_2_15, "left")

	local var_2_16 = arg_2_0.subPanelPanel

	arg_2_0.subRight = var_1.Find(var_2_16, "right")

	local var_2_17 = arg_2_0.subLeft

	arg_2_0.subPtBtn = var_1.Find(var_2_17, "ptBtn")

	local var_2_18 = arg_2_0.subLeft

	arg_2_0.subTaskBtn = var_1.Find(var_2_18, "taskBtn")

	local var_2_19 = arg_2_0.subLeft

	arg_2_0.subFireworkBtn = var_1.Find(var_2_19, "fireworkBtn")

	local var_2_20 = arg_2_0.subLeft

	arg_2_0.subSpringBtn = var_1.Find(var_2_20, "springBtn")

	local var_2_21 = arg_2_0.subRight

	arg_2_0.ptPanel = var_1.Find(var_2_21, "ptPanel")

	local var_2_22 = arg_2_0.subRight

	arg_2_0.taskPanel = var_1.Find(var_2_22, "taskPanel")

	local var_2_23 = arg_2_0.subRight

	arg_2_0.fireworkPanel = var_1.Find(var_2_23, "fireworkPanel")

	local var_2_24 = arg_2_0.subRight

	arg_2_0.springPanel = var_1.Find(var_2_24, "springPanel")

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:UpdateMainPt()

	arg_3_0.firePools = {}

	arg_3_0:PlayFireworks()
	arg_3_0:InitStudents()
	arg_3_0:SetTips()
	arg_3_0:CloseSubPanel()

	arg_3_0.hasClonedFireworkArrows = false
	onButton = var_1

	var_1(arg_3_0, arg_3_0.backBtn, function()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.tipBtn, function()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.firework_2025_tip.tip

		var_5_1(var_5_0, var_5_2)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.ptBtn, function()
		local var_6_0 = arg_3_0

		var_0.OpenSubPanel(var_6_0, arg_3_0.ptPanel)

		local var_6_1 = arg_3_0

		var_0.SetPtPanel(var_6_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.taskBtn, function()
		local var_7_0 = arg_3_0

		var_0.OpenSubPanel(var_7_0, arg_3_0.taskPanel)

		local var_7_1 = arg_3_0

		var_0.SetTaskPanel(var_7_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.fireworkBtn, function()
		local var_8_0 = arg_3_0

		var_0.OpenSubPanel(var_8_0, arg_3_0.fireworkPanel)

		local var_8_1 = arg_3_0

		var_0.SetFireWorkPanel(var_8_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.springBtn, function()
		local var_9_0 = arg_3_0

		var_0.OpenSubPanel(var_9_0, arg_3_0.springPanel)

		local var_9_1 = arg_3_0

		var_0.SetSpringPanel(var_9_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.subPanel, function()
		local var_10_0 = arg_3_0

		var_0.CloseSubPanel(var_10_0)

		local var_10_1 = arg_3_0

		var_0.PlayFireworks(var_10_1)

		return
	end)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.ptPanel

	var_1(var_3_0, var_4.Find(var_3_1, "btnClose"), function()
		local var_11_0 = arg_3_0

		var_0.CloseSubPanel(var_11_0)

		local var_11_1 = arg_3_0

		var_0.PlayFireworks(var_11_1)

		return
	end)

	onButton = var_1

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.taskPanel

	var_1(var_3_2, var_4.Find(var_3_3, "btnClose"), function()
		local var_12_0 = arg_3_0

		var_0.CloseSubPanel(var_12_0)

		local var_12_1 = arg_3_0

		var_0.PlayFireworks(var_12_1)

		return
	end)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.fireworkPanel

	var_1(var_3_4, var_4.Find(var_3_5, "btnClose"), function()
		local var_13_0 = arg_3_0

		var_0.CloseSubPanel(var_13_0)

		local var_13_1 = arg_3_0

		var_0.PlayFireworks(var_13_1)

		return
	end)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.springPanel

	var_1(var_3_6, var_4.Find(var_3_7, "btnClose"), function()
		local var_14_0 = arg_3_0

		var_0.CloseSubPanel(var_14_0)

		local var_14_1 = arg_3_0

		var_0.PlayFireworks(var_14_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.subPtBtn, function()
		local var_15_0 = arg_3_0

		var_0.SetSubPanel(var_15_0, arg_3_0.ptPanel)

		local var_15_1 = arg_3_0

		var_0.SetPtPanel(var_15_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.subTaskBtn, function()
		local var_16_0 = arg_3_0

		var_0.SetSubPanel(var_16_0, arg_3_0.taskPanel)

		local var_16_1 = arg_3_0

		var_0.SetTaskPanel(var_16_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.subFireworkBtn, function()
		local var_17_0 = arg_3_0

		var_0.SetSubPanel(var_17_0, arg_3_0.fireworkPanel)

		local var_17_1 = arg_3_0

		var_0.SetFireWorkPanel(var_17_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0.subSpringBtn, function()
		local var_18_0 = arg_3_0

		var_0.SetSubPanel(var_18_0, arg_3_0.springPanel)

		local var_18_1 = arg_3_0

		var_0.SetSpringPanel(var_18_1)

		return
	end)

	return
end

function var_0_1.InitData(arg_19_0)
	ActivityConst = var_1_10001
	arg_19_0.ptActId = var_1_10001.FireworkAndSpring_PT_ID
	ActivityConst = var_1
	arg_19_0.taskActId = var_1.FireworkAndSpring_TASK_ID
	ActivityConst = var_1
	arg_19_0.fireworkActId = var_1.FireworkAndSpring_ACT_ID
	ActivityConst = var_1
	arg_19_0.springActId = var_1.FireworkAndSpring_EMO_ID

	arg_19_0:UpdatePtData()
	arg_19_0:UpdateTaskData()
	arg_19_0:UpdateFireworkData()
	arg_19_0:UpdateSpringData()

	return
end

function var_0_1.UpdatePtData(arg_20_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)

	arg_20_0.ptActivity = var_1.getActivityById(var_20_0, arg_20_0.ptActId)
	ActivityPtData = var_2
	arg_20_0.ptData = var_2.New(arg_20_0.ptActivity)

	return
end

function var_0_1.UpdateTaskData(arg_21_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)

	arg_21_0.taskActivity = var_1.getActivityById(var_21_0, arg_21_0.taskActId)
	arg_21_0.taskVOs = {}

	local var_21_1 = arg_21_0.taskActivity
	local var_21_2 = var_2.getConfig(var_21_1, "config_data")

	pairs = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10003(var_21_2) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_21_3 = arg_21_0.taskVOs

		getProxy = var_1_10011
		TaskProxy = var_1_10013
		var_1_10013 = var_1_10011(var_1_10013)

		var_1_10008(var_21_3, var_1_10011.getTaskVO(var_1_10013, iter_21_1))
	end

	arg_21_0.canGetTaskVOs = {}
	arg_21_0.canGetTaskIds = {}

	arg_21_0:sort(arg_21_0.taskVOs)

	return
end

function var_0_1.sort(arg_22_0, arg_22_1)
	local var_22_0 = {}

	arg_22_0.canGetTaskAward = false
	pairs = var_3

	for iter_22_0, iter_22_1 in var_3(arg_22_1) do
		if iter_22_1:getTaskStatus() == 1 then
			table = var_8

			var_8.insert(var_22_0, iter_22_1)

			table = var_8

			var_8.insert(arg_22_0.canGetTaskVOs, iter_22_1)

			table = var_8

			var_8.insert(arg_22_0.canGetTaskIds, iter_22_1.id)

			arg_22_0.canGetTaskAward = true
		end
	end

	pairs = var_3

	for iter_22_2, iter_22_3 in var_3(arg_22_1) do
		if iter_22_3:getTaskStatus() == 0 then
			table = var_8

			var_8.insert(var_22_0, iter_22_3)
		end
	end

	pairs = var_3

	for iter_22_4, iter_22_5 in var_3(arg_22_1) do
		if iter_22_5:getTaskStatus() == 2 then
			table = var_8

			var_8.insert(var_22_0, iter_22_5)
		end
	end

	arg_22_0.taskVOs = var_22_0

	return
end

function var_0_1.UpdateFireworkData(arg_23_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)

	arg_23_0.fireworkActivity = var_1.getActivityById(var_23_0, arg_23_0.fireworkActId)
	arg_23_0.fireworkUnlockIds = arg_23_0.fireworkActivity.data1_list
	arg_23_0.fireworkGotIds = arg_23_0.fireworkActivity.data2_list

	local var_23_1 = arg_23_0.fireworkActivity

	arg_23_0.fireworkAllIds = var_2.GetPicturePuzzleIds(var_23_1)
	getProxy = var_2
	PlayerProxy = var_23_1

	local var_23_2 = var_2(var_23_1)

	arg_23_0.playerId = var_2.getData(var_23_2).id
	arg_23_0.fireworkOrderIds = arg_23_0:GetFireWorkLocalData()

	return
end

function var_0_1.GetFireWorkLocalData(arg_24_0)
	local var_24_0 = {}

	for iter_24_0 = 1, #arg_24_0.fireworkAllIds do
		PlayerPrefs = var_1_10006

		if var_1_10006.GetInt("fireworks_" .. arg_24_0.fireworkActId .. "_" .. arg_24_0.playerId .. "_pos_" .. iter_24_0) ~= 0 then
			table = var_1_10007

			var_1_10007.insert(var_24_0, var_1_10006)
		end
	end

	return var_24_0
end

function var_0_1.SetFireWorkLocalData(arg_25_0)
	for iter_25_0 = 1, #arg_25_0.fireworkAllIds do
		local var_25_0

		if not arg_25_0.fireworkOrderIds[iter_25_0] then
			var_25_0 = 0
		end

		PlayerPrefs = var_1_10006

		var_1_10006.SetInt("fireworks_" .. arg_25_0.fireworkActId .. "_" .. arg_25_0.playerId .. "_pos_" .. iter_25_0, var_25_0)
	end

	return
end

function var_0_1.UpdateSpringData(arg_26_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_26_0 = var_1_10001(var_1_10003)

	arg_26_0.springActivity = var_1.getActivityById(var_26_0, arg_26_0.springActId)
	_ = var_2

	local var_26_1 = var_2.map
	local var_26_2 = arg_26_0.springActivity

	arg_26_0.springShipIds = var_26_1(var_4.GetShipIds(var_26_2), function(arg_27_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_27_0 = var_2_10001(var_2_10003)

		if var_1.RawGetShipById(var_27_0, arg_27_0) then
			return arg_27_0
		else
			return 0
		end

		return
	end)

	local var_26_3 = arg_26_0.springActivity

	arg_26_0.springMaxCnt = var_2.GetSlotCount(var_26_3)
	arg_26_0.springSlotLockList = {}

	local var_26_4 = arg_26_0.springActivity

	arg_26_0.springUnlockSlotCount = var_2.getConfig(var_26_4, "config_client").initialCount
	ipairs = var_2

	local var_26_5 = arg_26_0.springActivity

	for iter_26_0, iter_26_1 in var_2(var_4.getConfig(var_26_5, "config_client").unlockPt) do
		if iter_26_1 <= arg_26_0.ptData.count then
			arg_26_0.springUnlockSlotCount = arg_26_0.springUnlockSlotCount + 1
		end
	end

	for iter_26_2 = 1, arg_26_0.springMaxCnt do
		local var_26_6 = iter_26_2 > arg_26_0.springUnlockSlotCount

		arg_26_0.springSlotLockList[iter_26_2] = var_26_6
	end

	local var_26_7 = arg_26_0.springActivity

	arg_26_0.energyRecoverAddition = var_2.GetEnergyRecoverAddition(var_26_7) * 10

	return
end

function var_0_1.OpenSubPanel(arg_28_0, arg_28_1)
	setActive = var_1_10002

	var_1_10002(arg_28_0.subPanel, true)
	arg_28_0:SetSubPanel(arg_28_1)

	pg = var_2

	local var_28_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_28_0, arg_28_0.subPanelPanel)

	return
end

function var_0_1.CloseSubPanel(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_29_0, arg_29_0.subPanelPanel, arg_29_0.subPanel)

	setActive = var_1

	var_1(arg_29_0.subPanel, false)

	return
end

function var_0_1.SetSubPanel(arg_30_0, arg_30_1)
	setActive = var_1_10002

	var_1_10002(arg_30_0.ptPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_30_0.taskPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_30_0.fireworkPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_30_0.springPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_30_1, true)

	setActive = var_1_10002

	local var_30_0 = arg_30_0.subPtBtn

	var_1_10002(var_4.Find(var_30_0, "selected"), arg_30_1 == arg_30_0.ptPanel)

	setActive = var_1_10002

	local var_30_1 = arg_30_0.subTaskBtn

	var_1_10002(var_4.Find(var_30_1, "selected"), arg_30_1 == arg_30_0.taskPanel)

	setActive = var_1_10002

	local var_30_2 = arg_30_0.subFireworkBtn

	var_1_10002(var_4.Find(var_30_2, "selected"), arg_30_1 == arg_30_0.fireworkPanel)

	setActive = var_1_10002

	local var_30_3 = arg_30_0.subSpringBtn

	var_1_10002(var_4.Find(var_30_3, "selected"), arg_30_1 == arg_30_0.springPanel)

	return
end

function var_0_1.UpdateMainPt(arg_31_0)
	setText = var_1_10001

	local var_31_0 = arg_31_0.stage
	local var_31_1 = "Lv."
	local var_31_2 = arg_31_0.ptData

	var_1_10001(var_31_0, var_31_1 .. var_5.GetCurrLevel(var_31_2))

	local var_31_3 = arg_31_0.ptData

	if not var_1.IsMaxLevel(var_31_3) then
		setText = var_1

		local var_31_4 = arg_31_0.pt
		local var_31_5 = arg_31_0.ptData.count
		local var_31_6 = "/"
		local var_31_7 = arg_31_0.ptData

		var_1(var_31_4, var_31_5 .. var_31_6 .. var_6.GetNextLevelTarget(var_31_7))
	else
		setText = var_1

		var_1(arg_31_0.pt, "MAX")
	end

	return
end

function var_0_1.SetPtPanel(arg_32_0)
	setText = var_1_10001

	local var_32_0 = arg_32_0.ptPanel
	local var_32_1 = var_3.Find(var_32_0, "lvText")
	local var_32_2 = arg_32_0.ptData

	var_1_10001(var_32_1, var_4.GetCurrLevel(var_32_2))

	local var_32_3 = arg_32_0.ptData
	local var_32_6

	if not var_1.IsMaxLevel(var_32_3) then
		setText = var_1

		local var_32_4 = arg_32_0.ptPanel
		local var_32_5 = var_3.Find(var_32_4, "pt")

		var_32_6 = arg_32_0.ptData.count

		local var_32_7 = "/"

		var_1_10008 = arg_32_0.ptData

		var_1(var_32_5, var_32_6 .. var_32_7 .. var_6.GetNextLevelTarget(var_1_10008))

		setSlider = var_1

		local var_32_8 = arg_32_0.ptPanel
		local var_32_9 = var_3.Find(var_32_8, "slider")

		var_32_6 = 0

		local var_32_10 = arg_32_0.ptData

		var_1(var_32_9, var_32_6, var_5.GetNextLevelTarget(var_32_10), arg_32_0.ptData.count)
	else
		setText = var_1

		local var_32_11 = arg_32_0.ptPanel

		var_1(var_3.Find(var_32_11, "pt"), "MAX")

		setSlider = var_1

		local var_32_12 = arg_32_0.ptPanel

		var_1(var_3.Find(var_32_12, "slider"), 0, 1, 1)
	end

	setText = var_1

	local var_32_13 = arg_32_0.ptPanel
	local var_32_14 = var_3.Find(var_32_13, "ptScroll/Viewport/Content/tpl/get/Text")

	i18n = var_32_6

	var_1(var_32_14, var_32_6("firework_2025_get"))

	setText = var_1

	local var_32_15 = arg_32_0.ptPanel
	local var_32_16 = var_3.Find(var_32_15, "ptScroll/Viewport/Content/tpl/got/Text")

	i18n = var_4

	var_1(var_32_16, var_4("firework_2025_got"))

	UIItemList = var_1

	local var_32_17 = var_1.New
	local var_32_18 = arg_32_0.ptPanel
	local var_32_19 = var_3.Find(var_32_18, "ptScroll/Viewport/Content")
	local var_32_20 = arg_32_0.ptPanel
	local var_32_21 = var_32_17(var_32_19, var_4.Find(var_32_20, "ptScroll/Viewport/Content/tpl"))

	var_1.make(var_32_21, function(arg_33_0, arg_33_1, arg_33_2)
		UIItemList = var_2_10003

		if arg_33_0 == var_2_10003.EventUpdate then
			local var_33_0 = arg_32_0.ptData.dropList[arg_33_1 + 1]
			local var_33_1 = arg_32_0.ptData.targets[arg_33_1 + 1]

			setText = var_5

			local var_33_2 = arg_33_2:Find("level")

			i18n = var_2_10008

			var_5(var_33_2, var_2_10008("firework_2025_level", arg_33_1 + 1))

			Drop = var_5

			local var_33_3 = var_5.Create(var_33_0)

			updateDrop = var_2_10006

			var_2_10006(arg_33_2:Find("award"), var_33_3)

			onButton = var_2_10006

			local var_33_4 = arg_32_0
			local var_33_5 = arg_33_2
			local var_33_6 = arg_33_2.Find(var_33_5, "award")

			local function var_33_7()
				local var_34_0 = arg_32_0
				local var_34_1 = var_0.emit

				BaseUI = var_3_10003

				var_34_1(var_34_0, var_3_10003.ON_DROP, var_33_3)

				return
			end

			SFX_PANEL = var_33_5

			var_2_10006(var_33_4, var_33_6, var_33_7, var_33_5)

			local var_33_8 = arg_32_0.ptData
			local var_33_9 = var_6.GetDroptItemState(var_33_8, arg_33_1 + 1)

			ActivityPtData = var_7

			if var_33_9 == var_7.STATE_LOCK then
				setActive = var_7

				var_7(arg_33_2:Find("lock"), true)

				setActive = var_7

				var_7(arg_33_2:Find("get"), false)

				setActive = var_7

				var_7(arg_33_2:Find("got"), false)
			else
				ActivityPtData = var_7

				if var_33_9 == var_7.STATE_CAN_GET then
					setActive = var_7

					var_7(arg_33_2:Find("lock"), false)

					setActive = var_7

					var_7(arg_33_2:Find("get"), true)

					setActive = var_7

					var_7(arg_33_2:Find("got"), false)
				else
					setActive = var_7

					var_7(arg_33_2:Find("lock"), false)

					setActive = var_7

					var_7(arg_33_2:Find("get"), false)

					setActive = var_7

					var_7(arg_33_2:Find("got"), true)
				end
			end
		end

		return
	end)
	var_1:align(#arg_32_0.ptData.dropList)

	rtf = var_2

	local var_32_22 = arg_32_0.ptPanel
	local var_32_23 = var_2(var_4.Find(var_32_22, "ptScroll/Viewport/Content/tpl")).rect.width
	local var_32_24 = arg_32_0.ptPanel
	local var_32_25 = var_3.Find(var_32_24, "ptScroll/Viewport/Content")
	local var_32_26 = var_3.GetComponent

	typeof = var_6
	HorizontalLayoutGroup = var_1_10008

	local var_32_27 = var_32_26(var_32_25, var_6(var_1_10008)).spacing

	rtf = var_4

	local var_32_28 = arg_32_0.ptPanel
	local var_32_29 = var_4(var_6.Find(var_32_28, "ptScroll/Viewport")).rect.width

	scrollTo = var_32_25

	local var_32_30 = arg_32_0.ptPanel

	var_32_25(var_7.Find(var_32_30, "ptScroll"), arg_32_0.ptData.level * (var_32_23 + var_32_27) / (#arg_32_0.ptData.targets * (var_32_23 + var_32_27) - var_32_27 - var_32_29), 0)

	local var_32_31 = 6
	local var_32_32 = arg_32_0.ptActivity

	arg_32_0.importants = var_6.getConfig(var_32_32, "config_client").highValueItemSort
	arg_32_0.importantsPos = {}
	ipairs = var_6

	for iter_32_0, iter_32_1 in var_6(arg_32_0.importants) do
		table = var_1_10011

		var_1_10011.insert(arg_32_0.importantsPos, (iter_32_1 - var_32_31 - 1) * (var_32_23 + var_32_27) / (#arg_32_0.ptData.targets * (var_32_23 + var_32_27) - var_32_27 - var_32_29))
	end

	arg_32_0:PtScrollToDo(arg_32_0.ptData.level * (var_32_23 + var_32_27) / (#arg_32_0.ptData.targets * (var_32_23 + var_32_27) - var_32_27 - var_32_29))

	onScroll = var_6

	local var_32_33 = arg_32_0
	local var_32_34 = arg_32_0.ptPanel

	var_6(var_32_33, var_9.Find(var_32_34, "ptScroll"), function(arg_35_0)
		local var_35_0 = arg_32_0

		var_1.PtScrollToDo(var_35_0, arg_35_0.x)

		return
	end)

	local var_32_35 = arg_32_0.ptData
	local var_32_39

	if var_6.CanGetAward(var_32_35) then
		setActive = var_6

		local var_32_36 = arg_32_0.ptPanel

		var_6(var_8.Find(var_32_36, "btn_get"), true)

		onButton = var_6

		local var_32_37 = arg_32_0
		local var_32_38 = arg_32_0.ptPanel

		var_32_39 = var_32_39.Find(var_32_38, "btn_get")

		local function var_32_40()
			local var_36_0 = {}
			local var_36_1 = arg_32_0.ptData
			local var_36_2 = var_1.GetAllAvailableAwards(var_36_1)

			getProxy = var_2_10002
			PlayerProxy = var_2_10004

			local var_36_3 = var_2_10002(var_2_10004)
			local var_36_4 = var_2.getRawData(var_36_3)

			pg = var_2_10004

			local var_36_5 = var_2_10004.gameset.urpt_chapter_max.description[1]

			LOCK_UR_SHIP = var_36_3

			if var_36_3 then
				var_36_3 = 0
			else
				getProxy = var_36_3
				BagProxy = var_2_10007

				local var_36_6 = var_36_3(var_2_10007)

				var_36_3 = var_36_3.GetLimitCntById(var_36_6, var_36_5)
			end

			Task = var_2_10006

			local var_36_7, var_36_8 = var_2_10006.StaticJudgeOverflow(var_36_4.gold, var_36_4.oil, var_36_3, true, true, var_36_2)

			if var_36_7 then
				table = var_8

				var_8.insert(var_36_0, function(arg_37_0)
					pg = var_3_10001

					local var_37_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_37_1 = var_1.ShowMsgBox
					local var_37_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10005
					var_37_2.type = var_3_10005
					i18n = var_3_10005
					var_37_2.content = var_3_10005("award_max_warning")
					var_37_2.items = var_36_8
					var_37_2.onYes = arg_37_0

					var_37_1(var_37_0, var_37_2)

					return
				end)
			end

			seriesAsync = var_8

			var_8(var_36_0, function()
				local var_38_0 = arg_32_0.ptData
				local var_38_1 = var_0.GetCurrTarget(var_38_0)
				local var_38_2 = arg_32_0
				local var_38_3 = var_1.emit

				FireworkAndSpringMediator = var_3_10004

				local var_38_4 = var_3_10004.EVENT_PT_OPERATION
				local var_38_5 = {
					cmd = 4
				}
				local var_38_6 = arg_32_0.ptData

				var_38_5.activity_id = var_6.GetId(var_38_6)
				var_38_5.arg1 = var_38_1

				var_38_3(var_38_2, var_38_4, var_38_5)

				return
			end)

			return
		end

		SFX_PANEL = var_32_38

		var_6(var_32_37, var_32_39, var_32_40, var_32_38)
	else
		setActive = var_6

		local var_32_41 = arg_32_0.ptPanel

		var_6(var_8.Find(var_32_41, "btn_get"), false)

		removeOnButton = var_6

		local var_32_42 = arg_32_0.ptPanel

		var_6(var_8.Find(var_32_42, "btn_get"))
	end

	setText = var_6

	local var_32_43 = arg_32_0.ptPanel
	local var_32_44 = var_8.Find(var_32_43, "ptName")

	i18n = var_32_39

	var_6(var_32_44, var_32_39("firework_2025_pt"))

	return
end

function var_0_1.PtScrollToDo(arg_39_0, arg_39_1)
	local var_39_0 = 0

	ipairs = var_1_10003

	for iter_39_0, iter_39_1 in var_1_10003(arg_39_0.importantsPos) do
		if arg_39_1 < iter_39_1 or iter_39_0 == #arg_39_0.importants then
			var_39_0 = arg_39_0.importants[iter_39_0]

			break
		end
	end

	Drop = var_3

	local var_39_1 = var_3.Create(arg_39_0.ptData.dropList[var_39_0])

	updateDrop = var_4

	local var_39_2 = arg_39_0.ptPanel

	var_4(var_6.Find(var_39_2, "award"), var_39_1)

	onButton = var_4

	local var_39_3 = arg_39_0
	local var_39_4 = arg_39_0.ptPanel
	local var_39_5 = var_7.Find(var_39_4, "award")

	local function var_39_6()
		local var_40_0 = arg_39_0
		local var_40_1 = var_0.emit

		BaseUI = var_2_10003

		var_40_1(var_40_0, var_2_10003.ON_DROP, var_39_1)

		return
	end

	SFX_PANEL = var_39_4

	var_4(var_39_3, var_39_5, var_39_6, var_39_4)

	setText = var_4

	local var_39_7 = arg_39_0.ptPanel
	local var_39_8 = var_6.Find(var_39_7, "awardInfo/Text")

	i18n = var_39_5

	var_4(var_39_8, var_39_5("firework_2025_level", var_39_0))

	setActive = var_4

	local var_39_9 = arg_39_0.ptPanel

	var_4(var_6.Find(var_39_9, "award/got"), var_39_0 <= arg_39_0.ptData.level)

	return
end

function var_0_1.SetTaskPanel(arg_41_0)
	setText = var_1_10001

	local var_41_0 = arg_41_0.taskPanel
	local var_41_1 = var_3.Find(var_41_0, "lvText")
	local var_41_2 = arg_41_0.ptData

	var_1_10001(var_41_1, var_4.GetCurrLevel(var_41_2))

	local var_41_3 = arg_41_0.ptData

	if not var_1.IsMaxLevel(var_41_3) then
		setText = var_1

		local var_41_4 = arg_41_0.taskPanel
		local var_41_5 = var_3.Find(var_41_4, "pt")
		local var_41_6 = arg_41_0.ptData.count
		local var_41_7 = "/"
		local var_41_8 = arg_41_0.ptData

		var_1(var_41_5, var_41_6 .. var_41_7 .. var_6.GetNextLevelTarget(var_41_8))

		setSlider = var_1

		local var_41_9 = arg_41_0.taskPanel
		local var_41_10 = var_3.Find(var_41_9, "slider")
		local var_41_11 = 0
		local var_41_12 = arg_41_0.ptData

		var_1(var_41_10, var_41_11, var_5.GetNextLevelTarget(var_41_12), arg_41_0.ptData.count)
	else
		setText = var_1

		local var_41_13 = arg_41_0.taskPanel

		var_1(var_3.Find(var_41_13, "pt"), "MAX")

		setSlider = var_1

		local var_41_14 = arg_41_0.taskPanel

		var_1(var_3.Find(var_41_14, "slider"), 0, 1, 1)
	end

	UIItemList = var_1

	local var_41_15 = var_1.New
	local var_41_16 = arg_41_0.taskPanel
	local var_41_17 = var_3.Find(var_41_16, "taskScroll/Viewport/Content")
	local var_41_18 = arg_41_0.taskPanel
	local var_41_19 = var_41_15(var_41_17, var_4.Find(var_41_18, "taskScroll/Viewport/Content/Tasktpl"))

	var_1.make(var_41_19, function(arg_42_0, arg_42_1, arg_42_2)
		UIItemList = var_2_10003

		if arg_42_0 == var_2_10003.EventUpdate then
			local var_42_0 = arg_41_0.taskVOs[arg_42_1 + 1]

			setText = var_4

			var_4(arg_42_2:Find("frame/name"), var_42_0:getConfig("name"))

			setText = var_4

			var_4(arg_42_2:Find("frame/desc"), var_42_0:getConfig("desc"))

			local var_42_1 = var_42_0
			local var_42_2 = var_42_0.getProgress(var_42_1)
			local var_42_3 = var_42_0:getConfig("target_num")

			math = var_42_1

			local var_42_4 = var_42_1.min(var_42_2, var_42_3)

			setText = var_6

			var_6(arg_42_2:Find("frame/progress"), var_42_4 .. "/" .. var_42_3)

			local var_42_5 = arg_42_2:Find("frame/slider")
			local var_42_6 = var_6.GetComponent

			typeof = var_9
			Slider = var_11
			var_42_6(var_42_5, var_9(var_11)).value = var_42_4 / var_42_3

			local var_42_7 = arg_42_2:Find("frame/awards")
			local var_42_8 = var_7.GetChild(var_42_7, 0)
			local var_42_9 = arg_41_0

			var_9.updateTaskAwards(var_42_9, var_42_0:getConfig("award_display"), var_7, var_42_8)

			local var_42_10 = arg_42_2:Find("frame/go_btn")
			local var_42_11 = arg_42_2:Find("frame/get_btn")
			local var_42_12 = arg_42_2:Find("frame/got_btn")

			if var_42_0:getTaskStatus() == 0 then
				setActive = var_12

				var_12(var_42_10, true)

				setActive = var_12

				var_12(var_42_11, false)

				setActive = var_12

				var_12(var_42_12, false)
			elseif var_42_0:getTaskStatus() == 1 then
				setActive = var_12

				var_12(var_42_10, false)

				setActive = var_12

				var_12(var_42_11, true)

				setActive = var_12

				var_12(var_42_12, false)
			elseif var_42_0:getTaskStatus() == 2 then
				setActive = var_12

				var_12(var_42_10, false)

				setActive = var_12

				var_12(var_42_11, false)

				setActive = var_12

				var_12(var_42_12, true)
			end

			onButton = var_12

			local var_42_13 = arg_41_0
			local var_42_14 = var_42_10

			local function var_42_15()
				local var_43_0 = arg_41_0
				local var_43_1 = var_0.emit

				FireworkAndSpringMediator = var_3_10003

				var_43_1(var_43_0, var_3_10003.ON_TASK_GO, var_42_0)

				return
			end

			SFX_PANEL = var_2_10017

			var_12(var_42_13, var_42_14, var_42_15, var_2_10017)

			onButton = var_12

			local var_42_16 = arg_41_0
			local var_42_17 = var_42_11

			local function var_42_18()
				local var_44_0 = arg_41_0
				local var_44_1 = var_0.emit

				FireworkAndSpringMediator = var_3_10003

				var_44_1(var_44_0, var_3_10003.ON_TASK_SUBMIT, var_42_0)

				return
			end

			SFX_PANEL = var_2_10017

			var_12(var_42_16, var_42_17, var_42_18, var_2_10017)
		end

		return
	end)
	var_1:align(#arg_41_0.taskVOs)

	local var_41_23

	if arg_41_0.canGetTaskAward then
		setActive = var_2

		local var_41_20 = arg_41_0.taskPanel

		var_2(var_4.Find(var_41_20, "btn_get"), true)

		onButton = var_2

		local var_41_21 = arg_41_0
		local var_41_22 = arg_41_0.taskPanel

		var_41_23 = var_41_23.Find(var_41_22, "btn_get")

		local function var_41_24()
			local var_45_0 = {}
			local var_45_1 = {}

			pairs = var_2_10002

			for iter_45_0, iter_45_1 in var_2_10002(arg_41_0.canGetTaskVOs) do
				var_2_10007 = iter_45_1:getConfig("award_display")
				ipairs = var_2_10008

				for iter_45_2, iter_45_3 in var_2_10008(var_2_10007) do
					local var_45_2 = iter_45_3
					local var_45_3 = false

					pairs = var_2_10015

					for iter_45_4, iter_45_5 in var_2_10015(var_45_1) do
						if iter_45_5[1] == var_45_2[1] and iter_45_5[2] == var_45_2[2] then
							var_45_3 = true
							iter_45_5[3] = iter_45_5[3] + var_45_2[3]

							break
						end
					end

					if not var_45_3 then
						table = var_2_10015

						var_2_10015.insert(var_45_1, var_45_2)
					end
				end
			end

			getProxy = var_2
			PlayerProxy = var_4

			local var_45_4 = var_2(var_4)
			local var_45_5 = var_2.getRawData(var_45_4)

			pg = var_4

			local var_45_6 = var_4.gameset.urpt_chapter_max.description[1]

			LOCK_UR_SHIP = var_45_4

			if var_45_4 then
				var_45_4 = 0
			else
				getProxy = var_45_4
				BagProxy = var_2_10007

				local var_45_7 = var_45_4(var_2_10007)

				var_45_4 = var_45_4.GetLimitCntById(var_45_7, var_45_6)
			end

			Task = iter_45_1

			local var_45_8, var_45_9 = iter_45_1.StaticJudgeOverflow(var_45_5.gold, var_45_5.oil, var_45_4, true, true, var_45_1)

			if var_45_8 then
				table = var_8

				var_8.insert(var_45_0, function(arg_46_0)
					pg = var_3_10001

					local var_46_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_46_1 = var_1.ShowMsgBox
					local var_46_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10005
					var_46_2.type = var_3_10005
					i18n = var_3_10005
					var_46_2.content = var_3_10005("award_max_warning")
					var_46_2.items = var_45_9
					var_46_2.onYes = arg_46_0

					var_46_1(var_46_0, var_46_2)

					return
				end)
			end

			seriesAsync = var_8

			var_8(var_45_0, function()
				local var_47_0 = arg_41_0
				local var_47_1 = var_0.emit

				FireworkAndSpringMediator = var_3_10003

				var_47_1(var_47_0, var_3_10003.ON_TASK_SUBMIT_ONESTEP, arg_41_0.taskActId, arg_41_0.canGetTaskIds)

				return
			end)

			return
		end

		SFX_PANEL = var_41_22

		var_2(var_41_21, var_41_23, var_41_24, var_41_22)
	else
		setActive = var_2

		local var_41_25 = arg_41_0.taskPanel

		var_2(var_4.Find(var_41_25, "btn_get"), false)

		removeOnButton = var_2

		local var_41_26 = arg_41_0.taskPanel

		var_2(var_4.Find(var_41_26, "btn_get"))
	end

	setText = var_2

	local var_41_27 = arg_41_0.taskPanel
	local var_41_28 = var_4.Find(var_41_27, "ptName")

	i18n = var_41_23

	var_2(var_41_28, var_41_23("firework_2025_pt"))

	return
end

function var_0_1.updateTaskAwards(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	_ = var_1_10004

	local var_48_0 = var_1_10004.slice(arg_48_1, 1, 3)

	for iter_48_0 = arg_48_2.childCount, #var_48_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_48_3, arg_48_2)
	end

	local var_48_1 = arg_48_2.childCount

	for iter_48_1 = 1, var_48_1 do
		local var_48_2 = arg_48_2
		local var_48_3 = arg_48_2.GetChild(var_48_2, iter_48_1 - 1)
		local var_48_4 = iter_48_1 <= #var_48_0

		setActive = var_48_2

		var_48_2(var_48_3, var_48_4)

		if var_48_4 then
			local var_48_5 = var_48_0[iter_48_1]
			local var_48_6 = {
				type = var_48_5[1],
				id = var_48_5[2],
				count = var_48_5[3]
			}

			updateDrop = var_14

			var_14(var_48_3, var_48_6)

			onButton = var_14

			local var_48_7 = arg_48_0
			local var_48_8 = var_48_3

			local function var_48_9()
				local var_49_0 = arg_48_0
				local var_49_1 = var_0.emit

				BaseUI = var_2_10003

				var_49_1(var_49_0, var_2_10003.ON_DROP, var_48_6)

				return
			end

			SFX_PANEL = var_1_10019

			var_14(var_48_7, var_48_8, var_48_9, var_1_10019)
		end
	end

	return
end

function var_0_1.SetFireWorkPanel(arg_50_0)
	local var_50_0 = arg_50_0.fireworkPanel
	local var_50_1 = var_1.Find(var_50_0, "left_panel")
	local var_50_2 = arg_50_0.fireworkPanel
	local var_50_3 = var_2.Find(var_50_2, "right_panel")
	local var_50_4 = var_2.Find(var_50_3, "fire_btn")
	local var_50_5 = var_50_1
	local var_50_6 = var_50_1.Find(var_50_5, "scrollrect/content/item_tpl")
	local var_50_7 = var_50_1:Find("scrollrect/content")

	UIItemList = var_50_5
	arg_50_0.leftUIList = var_50_5.New(var_50_7, var_50_6)

	local var_50_8 = var_2
	local var_50_9 = var_2.Find(var_50_8, "content/item_tpl")
	local var_50_10 = var_2
	local var_50_11 = var_2.Find(var_50_10, "content")

	UIItemList = var_50_8
	arg_50_0.rightUIList = var_50_8.New(var_50_11, var_50_9)

	local var_50_12 = var_2:Find("arrows")

	onButton = var_50_10

	var_50_10(arg_50_0, var_50_4, function()
		local var_51_0 = arg_50_0

		var_0.CloseSubPanel(var_51_0)

		local var_51_1 = arg_50_0

		var_0.PlayFireworks(var_51_1)

		return
	end)

	setText = var_50_10

	local var_50_13 = var_2:Find("tip")

	i18n = var_12

	var_50_10(var_50_13, var_12("activity_yanhua_tip7"))

	setText = var_50_10

	local var_50_14 = var_50_1
	local var_50_15 = var_50_1.Find(var_50_14, "tip")

	i18n = var_12

	var_50_10(var_50_15, var_12("firework_2025_tip1"))

	local var_50_16 = arg_50_0.leftUIList

	var_9.make(var_50_16, function(arg_52_0, arg_52_1, arg_52_2)
		UIItemList = var_2_10003

		if arg_52_0 == var_2_10003.EventUpdate then
			local var_52_0 = arg_50_0.fireworkAllIds[arg_52_1 + 1]
			local var_52_1 = arg_52_2
			local var_52_2 = arg_52_2.Find(var_52_1, "firework/icon")

			GetImageSpriteFromAtlasAsync = var_2_10005
			Item = var_7

			var_2_10005(var_7.getConfigData(var_52_0).icon, "", var_52_2)

			local var_52_3 = arg_52_2
			local var_52_4 = arg_52_2.Find(var_52_3, "firework/selected")

			table = var_52_1

			local var_52_5 = var_52_1.contains(arg_50_0.fireworkOrderIds, var_52_0)

			setActive = var_52_3

			var_52_3(var_52_4, var_52_5)

			table = var_52_3

			if not var_52_3.contains(arg_50_0.fireworkUnlockIds, var_52_0) then
				setActive = var_7

				var_7(arg_52_2:Find("firework/lock"), true)

				setActive = var_7

				var_7(arg_52_2:Find("firework/get"), false)
			else
				table = var_7

				if not var_7.contains(arg_50_0.fireworkGotIds, var_52_0) then
					setActive = var_7

					var_7(arg_52_2:Find("firework/lock"), false)

					setActive = var_7

					var_7(arg_52_2:Find("firework/get"), true)

					onButton = var_7

					local var_52_6 = arg_50_0
					local var_52_7 = arg_52_2

					local function var_52_8()
						local var_53_0 = arg_50_0
						local var_53_1 = var_0.emit

						FireworkAndSpringMediator = var_3_10003

						var_53_1(var_53_0, var_3_10003.ACTIVITY_OPERATION, arg_50_0.fireworkActId, var_52_0)

						return
					end

					SFX_PANEL = var_12

					var_7(var_52_6, var_52_7, var_52_8, var_12)
				else
					setActive = var_7

					var_7(arg_52_2:Find("firework/lock"), false)

					setActive = var_7

					var_7(arg_52_2:Find("firework/get"), false)

					onButton = var_7

					local var_52_9 = arg_50_0
					local var_52_10 = arg_52_2

					local function var_52_11()
						local var_54_0 = arg_50_0

						var_0.FireworkLeftClick(var_54_0, var_52_0, var_52_5)

						return
					end

					SFX_PANEL = var_12

					var_7(var_52_9, var_52_10, var_52_11, var_12)
				end
			end
		end

		return
	end)

	local var_50_17 = arg_50_0.leftUIList

	var_9.align(var_50_17, #arg_50_0.fireworkAllIds)

	if not arg_50_0.hasClonedFireworkArrows then
		arg_50_0.hasClonedFireworkArrows = true

		for iter_50_0 = 1, #arg_50_0.fireworkAllIds - 2 do
			cloneTplTo = var_50_14

			var_50_14(var_50_12:Find("tpl"), var_50_12)
		end
	end

	local var_50_18 = arg_50_0.rightUIList

	var_9.make(var_50_18, function(arg_55_0, arg_55_1, arg_55_2)
		UIItemList = var_2_10003

		if arg_55_0 == var_2_10003.EventUpdate then
			local var_55_0 = arg_55_1 + 1
			local var_55_1 = arg_55_2
			local var_55_2 = arg_55_2.Find(var_55_1, "icon")

			setActive = var_2_10005

			var_2_10005(arg_55_2:Find("add"), var_55_0 > #arg_50_0.fireworkOrderIds)

			if #arg_50_0.fireworkOrderIds < var_55_0 then
				setActive = var_5

				var_5(var_55_2, false)
			else
				local var_55_3 = arg_50_0.fireworkOrderIds[var_55_0]

				setActive = var_55_1

				var_55_1(var_55_2, true)

				GetImageSpriteFromAtlasAsync = var_55_1
				Item = var_8

				var_55_1(var_8.getConfigData(var_55_3).icon, "", var_55_2)

				onButton = var_55_1

				local var_55_4 = arg_50_0
				local var_55_5 = var_55_2

				local function var_55_6()
					local var_56_0 = arg_50_0

					var_0.FireworkRightClick(var_56_0, var_55_3)

					return
				end

				SFX_PANEL = var_2_10011

				var_55_1(var_55_4, var_55_5, var_55_6, var_2_10011)
			end
		end

		return
	end)

	local var_50_19 = arg_50_0.rightUIList

	var_9.align(var_50_19, #arg_50_0.fireworkAllIds)

	return
end

function var_0_1.FireworkLeftClick(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_2 then
		table = var_1_10003

		var_1_10003.removebyvalue(arg_57_0.fireworkOrderIds, arg_57_1)
	else
		table = var_1_10003

		var_1_10003.insert(arg_57_0.fireworkOrderIds, arg_57_1)
	end

	arg_57_0:SetFireWorkLocalData()

	local var_57_0 = arg_57_0.leftUIList

	var_3.align(var_57_0, #arg_57_0.fireworkAllIds)

	local var_57_1 = arg_57_0.rightUIList

	var_3.align(var_57_1, #arg_57_0.fireworkAllIds)

	return
end

function var_0_1.FireworkRightClick(arg_58_0, arg_58_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_58_0.fireworkOrderIds, arg_58_1)
	arg_58_0:SetFireWorkLocalData()

	local var_58_0 = arg_58_0.leftUIList

	var_2.align(var_58_0, #arg_58_0.fireworkAllIds)

	local var_58_1 = arg_58_0.rightUIList

	var_2.align(var_58_1, #arg_58_0.fireworkAllIds)

	return
end

function var_0_1.SetSpringPanel(arg_59_0)
	arg_59_0:CreateSpringUI()
	arg_59_0:UpdateSpringUI()

	return
end

function var_0_1.CreateSpringUI(arg_60_0)
	setText = var_1_10001

	local var_60_0 = arg_60_0.springPanel
	local var_60_1 = var_3.Find(var_60_0, "list/iconTpl/lock/Text")

	i18n = var_1_10004

	var_1_10001(var_60_1, var_1_10004("firework_2025_unlock_tip1"))

	UIItemList = var_1_10001

	local var_60_2 = var_1_10001.New
	local var_60_3 = arg_60_0.springPanel
	local var_60_4 = var_3.Find(var_60_3, "list")
	local var_60_5 = arg_60_0.springPanel

	arg_60_0.springList = var_60_2(var_60_4, var_4.Find(var_60_5, "list/iconTpl"))

	local var_60_6 = arg_60_0.springList

	var_1.make(var_60_6, function(arg_61_0, arg_61_1, arg_61_2)
		UIItemList = var_2_10003

		if arg_61_0 == var_2_10003.EventUpdate then
			local var_61_0 = arg_60_0.springShipIds[arg_61_1 + 1]
			local var_61_1 = arg_60_0.springSlotLockList[arg_61_1 + 1]
			local var_61_2 = var_61_0 and var_61_0 > 0

			setActive = var_2_10006

			var_2_10006(arg_61_2:Find("lock"), var_61_1)

			setActive = var_2_10006

			var_2_10006(arg_61_2:Find("add"), not var_61_1 and not var_61_2)

			setActive = var_2_10006

			var_2_10006(arg_61_2:Find("ship"), not var_61_1 and var_61_2)

			local var_61_4

			if var_61_1 then
				setText = var_2_10006

				local var_61_3 = arg_61_2:Find("lock/taskText")

				i18n = var_9
				var_61_4 = "firework_2025_unlock_tip2"

				local var_61_5 = arg_60_0.springActivity
				local var_61_6 = var_12.getConfig(var_61_5, "config_client").unlockPt
				local var_61_7 = arg_61_1 + 1
				local var_61_8 = arg_60_0.springActivity

				var_2_10006(var_61_3, var_9(var_61_4, var_61_6[var_61_7 - var_14.getConfig(var_61_8, "config_client").initialCount]))
			end

			onButton = var_2_10006

			local var_61_9 = arg_60_0
			local var_61_10 = arg_61_2

			local function var_61_11()
				if var_61_1 then
					return
				end

				local var_62_0

				if var_61_2 then
					getProxy = var_1
					BayProxy = var_3_10003

					local var_62_1 = var_1(var_3_10003)

					var_62_0 = var_1.getShipById(var_62_1, var_61_0)
				end

				local var_62_2 = arg_60_0.springUnlockSlotCount
				local var_62_3 = arg_60_0

				var_2.StopPlayFireworks(var_62_3)

				local var_62_4 = arg_60_0
				local var_62_5 = var_2.emit

				FireworkAndSpringMediator = var_3_10005

				var_62_5(var_62_4, var_3_10005.OPEN_CHUANWU, arg_60_0.springActId, arg_61_1 + 1, var_62_0, arg_60_0.springUnlockSlotCount)

				return
			end

			SFX_PANEL = var_61_4

			var_2_10006(var_61_9, var_61_10, var_61_11, var_61_4)

			if not var_61_2 then
				return
			end

			getProxy = var_2_10006
			BayProxy = var_61_9

			local var_61_12 = var_2_10006(var_61_9)
			local var_61_13 = var_6.RawGetShipById(var_61_12, var_61_0)

			LoadSprite = var_2_10007

			local var_61_14 = var_2_10007("shipyardicon/" .. var_61_13:getPainting())

			setImageSprite = var_61_12

			var_61_12(arg_61_2:Find("ship/mask/icon"), var_61_14)

			setText = var_61_12

			var_61_12(arg_61_2:Find("ship/name/Text"), var_61_13:getName())
		end

		return
	end)

	setText = var_1

	local var_60_7 = arg_60_0.springPanel
	local var_60_8 = var_3.Find(var_60_7, "tipText1")

	i18n = var_4

	var_1(var_60_8, var_4("firework_2025_tip2"))

	setText = var_1

	local var_60_9 = arg_60_0.springPanel

	var_1(var_3.Find(var_60_9, "tipText2"), "+" .. arg_60_0.energyRecoverAddition .. "/h")

	return
end

function var_0_1.UpdateSpringUI(arg_63_0)
	local var_63_0 = arg_63_0.springList

	var_1.align(var_63_0, arg_63_0.springMaxCnt)

	return
end

function var_0_1.UpdateSpringActivityAndUI(arg_64_0)
	arg_64_0:UpdateSpringData()
	arg_64_0:UpdateSpringUI()
	arg_64_0:clearStudents()
	arg_64_0:InitStudents()

	return
end

function var_0_1.PlayFireworks(arg_65_0)
	Clone = var_1_10001
	arg_65_0.fireworks = var_1_10001(arg_65_0.fireworkOrderIds)

	if #arg_65_0.fireworks == 0 then
		return
	end

	eachChild = var_1

	var_1(arg_65_0.fireworksTF, function(arg_66_0)
		setActive = var_2_10001

		var_2_10001(arg_66_0, false)

		return
	end)

	setActive = var_1

	var_1(arg_65_0.fireworksTF, true)
	arg_65_0:StopFireworksTimer()

	arg_65_0.fireworkIndex = 1
	Timer = var_1
	arg_65_0.fireworksTimer = var_1.New(function()
		local var_67_0 = arg_65_0

		var_0.PlayerOneFirework(var_67_0)

		return
	end, var_0_1.EffectInterval, #arg_65_0.fireworks)

	local var_65_0 = arg_65_0.fireworksTimer

	var_1.Start(var_65_0)

	return
end

function var_0_1.PlayerOneFirework(arg_68_0)
	if arg_68_0.fireworkIndex == #arg_68_0.fireworks then
		local var_68_0 = arg_68_0
		local var_68_1 = arg_68_0.managedTween

		LeanTween = var_1_10004

		var_68_1(var_68_0, var_1_10004.delayedCall, function()
			if arg_68_0.fireworks then
				local var_69_0 = arg_68_0

				var_0.StopPlayFireworks(var_69_0)

				local var_69_1 = arg_68_0

				var_0.PlayFireworks(var_69_1)
			end

			return
		end, var_0_1.DelayPop, nil)
	end

	local var_68_2 = arg_68_0.fireworks[arg_68_0.fireworkIndex]

	math = var_2

	local var_68_3 = var_2.random(#var_0_1.SFX_LIST)

	if arg_68_0.firePools[var_68_2] then
		local var_68_4 = #arg_68_0.firePools[var_68_2]

		if var_0_1.EffectPoolCnt <= var_68_4 then
			local var_68_5 = arg_68_0.firePools[var_68_2][1]

			setLocalPosition = var_4

			var_4(var_68_5, arg_68_0:GetFireworkPos())

			setActive = var_4

			var_4(var_68_5, true)

			pg = var_4

			local var_68_6 = var_4.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_68_6, var_0_1.SFX_LIST[var_68_3])

			table = var_4

			var_4.removebyvalue(arg_68_0.firePools[var_68_2], var_68_5)

			table = var_4

			var_4.insert(arg_68_0.firePools[var_68_2], var_68_5)

			goto label_68_0
		end
	end

	do
		local var_68_7 = arg_68_0.loader

		var_3.GetPrefab(var_68_7, "ui/" .. var_0_1.Id2EffectName[var_68_2], "", function(arg_70_0)
			pg = var_2_10001

			var_2_10001.ViewUtils.SetSortingOrder(arg_70_0, 1)

			setParent = var_1

			var_1(arg_70_0, arg_68_0.fireworksTF)

			setLocalPosition = var_1

			local var_70_0 = arg_70_0
			local var_70_1 = arg_68_0

			var_1(var_70_0, var_4.GetFireworkPos(var_70_1))

			setActive = var_1

			var_1(arg_70_0, true)

			pg = var_1

			local var_70_2 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_70_2, var_0_1.SFX_LIST[var_68_3])

			local var_70_3

			if not arg_68_0.firePools[var_68_2] then
				var_70_3 = arg_68_0.firePools
				var_70_3[var_68_2] = {}
			end

			table = var_70_3

			var_70_3.insert(arg_68_0.firePools[var_68_2], arg_70_0)

			return
		end)
	end

	::label_68_0::

	arg_68_0.fireworkIndex = arg_68_0.fireworkIndex + 1

	return
end

function var_0_1.GetFireworkPos(arg_71_0)
	Vector2 = var_1_10001

	local var_71_0 = var_1_10001(0, 0)
	local var_71_1

	if arg_71_0.lastPos then
		Vector2 = var_71_1
		var_71_1 = var_71_1(arg_71_0.lastPos.x, arg_71_0.lastPos.y)
		math = var_3

		local var_71_2 = var_3.abs(var_71_1.x - arg_71_0.lastPos.x)

		math = var_4

		local var_71_3 = var_4.abs(var_71_1.y - arg_71_0.lastPos.y)

		while var_71_2 < var_0_1.FireworkRange.x / 2 and var_71_3 < var_0_1.FireworkRange.y or var_71_3 < var_0_1.FireworkRange.y / 2 and var_71_2 < var_0_1.FireworkRange.x do
			math = var_5
			var_71_1.x = var_5.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
			math = var_5
			var_71_1.y = var_5.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
			math = var_5
			var_71_2 = var_5.abs(var_71_1.x - arg_71_0.lastPos.x)
			math = var_5
			var_71_3 = var_5.abs(var_71_1.y - arg_71_0.lastPos.y)
		end

		var_71_0 = var_71_1
	else
		math = var_71_1
		var_71_0.x = var_71_1.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
		math = var_2
		var_71_0.y = var_2.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
	end

	arg_71_0.lastPos = var_71_0

	return var_71_0
end

function var_0_1.StopFireworksTimer(arg_72_0)
	if arg_72_0.fireworksTimer then
		local var_72_0 = arg_72_0.fireworksTimer

		var_1.Stop(var_72_0)

		arg_72_0.fireworksTimer = nil
	end

	return
end

function var_0_1.StopPlayFireworks(arg_73_0)
	arg_73_0:StopFireworksTimer()

	arg_73_0.fireworks = nil
	arg_73_0.fireworkIndex = nil
	setActive = var_1

	var_1(arg_73_0.fireworksTF, false)

	return
end

function var_0_1.getStudents(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = {}
	local var_74_1 = {}

	if not arg_74_0.springActivity then
		return var_74_0
	end

	local var_74_2 = arg_74_0.springActivity
	local var_74_3 = var_5.GetShipIds(var_74_2)

	for iter_74_0 = 1, arg_74_0.springMaxCnt do
		if var_74_3[iter_74_0] and var_74_3[iter_74_0] ~= 0 then
			getProxy = var_10
			BayProxy = var_1_10012
			var_1_10012 = var_10(var_1_10012)

			if var_10.RawGetShipById(var_1_10012, var_74_3[iter_74_0]) then
				table = var_1_10011

				var_1_10011.insert(var_74_1, var_10)
			end
		end
	end

	if not arg_74_1 or not arg_74_2 then
		arg_74_1 = #var_74_1
		arg_74_2 = #var_74_1
	end

	math = var_6

	local var_74_4 = var_6.random(arg_74_1, arg_74_2)
	local var_74_5 = #var_74_1

	while var_74_4 > 0 and 0 < var_74_5 do
		math = var_74_6

		local var_74_6 = var_74_6.random(1, var_74_5)

		table = var_74_7

		local var_74_7 = var_74_7.insert
		local var_74_8 = var_74_0
		local var_74_9 = var_74_1[var_74_6]

		var_74_7(var_74_8, var_12.getPrefab(var_74_9))

		var_74_1[var_74_6] = var_74_1[var_74_5]
		var_74_5 = var_74_5 - 1
		var_74_4 = var_74_4 - 1
	end

	return var_74_0
end

function var_0_1.InitStudents(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = arg_75_0
	local var_75_1 = arg_75_0.getStudents(var_75_0, arg_75_1, arg_75_2)
	local var_75_2 = {}

	pairs = var_75_0

	for iter_75_0, iter_75_1 in var_75_0(arg_75_0.graphPath.points) do
		if not iter_75_1.outRandom then
			table = var_10

			var_10.insert(var_75_2, iter_75_1)
		end
	end

	local var_75_3 = #var_75_2

	arg_75_0.academyStudents = {}

	local var_75_4 = {}

	pairs = var_7

	for iter_75_2, iter_75_3 in var_7(var_75_1) do
		if not arg_75_0.academyStudents[iter_75_2] then
			cloneTplTo = var_12
			var_12(arg_75_0._shipTpl, arg_75_0._map).gameObject.name = iter_75_2

			local var_75_5 = arg_75_0:ChooseRandomPos(var_75_2, var_75_3)

			var_75_3 = (var_75_3 - 2) % #var_75_2 + 1
			SummerFeastNavigationAgent = var_14

			local var_75_6 = var_14.New(var_12.gameObject)

			var_75_6.normalSpeed = 100

			var_75_6:attach()
			var_75_6:setPathFinder(arg_75_0.graphPath)
			var_75_6:SetPositionTable(var_75_4)
			var_75_6:setCurrentIndex(var_75_5 and var_75_5.id)
			var_75_6:SetOnTransEdge(function(arg_76_0, arg_76_1, arg_76_2)
				math = var_2_10003

				local var_76_0 = var_2_10003.min(arg_76_1, arg_76_2)

				math = var_2_10004
				arg_76_2 = var_2_10004.max(arg_76_1, arg_76_2)
				arg_76_1 = var_76_0

				local var_76_1 = arg_75_0
				local var_76_2

				if not arg_75_0.edge2area[arg_76_1 .. "_" .. arg_76_2] then
					var_76_2 = arg_75_0.edge2area.default
				end

				local var_76_3 = var_76_1[var_76_2]
				local var_76_4 = arg_76_0._tf

				var_4.SetParent(var_76_4, var_76_3)

				return
			end)
			var_75_6:updateStudent(iter_75_3)

			arg_75_0.academyStudents[iter_75_2] = var_75_6
		end
	end

	if #var_75_1 > 0 then
		Timer = var_7
		arg_75_0.sortTimer = var_7.New(function()
			local var_77_0 = arg_75_0

			var_0.sortStudents(var_77_0)

			return
		end, 0.2, -1)

		local var_75_7 = arg_75_0.sortTimer

		var_7.Start(var_75_7)
		arg_75_0.sortTimer.func()
	end

	return
end

function var_0_1.ChooseRandomPos(arg_78_0, arg_78_1, arg_78_2)
	math = var_1_10003

	if not var_1_10003.random(1, arg_78_2) then
		return nil
	end

	pg = var_1_10004

	var_1_10004.Tool.Swap(arg_78_1, var_3, arg_78_2)

	return arg_78_1[arg_78_2]
end

function var_0_1.SetTips(arg_79_0)
	arg_79_0:SetPtTip()
	arg_79_0:SetTaskTip()
	arg_79_0:SetFireworkTip()
	arg_79_0:SetSpringTip()

	return
end

function var_0_1.SetPtTip(arg_80_0)
	local var_80_0 = arg_80_0.ptData
	local var_80_1 = var_1.CanGetAward(var_80_0)

	setActive = var_1_10002

	local var_80_2 = arg_80_0.ptBtn

	var_1_10002(var_4.Find(var_80_2, "tip"), var_80_1)

	setActive = var_1_10002

	local var_80_3 = arg_80_0.subPtBtn

	var_1_10002(var_4.Find(var_80_3, "tip"), var_80_1)

	return
end

function var_0_1.SetTaskTip(arg_81_0)
	local var_81_0 = arg_81_0.canGetTaskAward

	setActive = var_1_10002

	local var_81_1 = arg_81_0.taskBtn

	var_1_10002(var_4.Find(var_81_1, "tip"), var_81_0)

	setActive = var_1_10002

	local var_81_2 = arg_81_0.subTaskBtn

	var_1_10002(var_4.Find(var_81_2, "tip"), var_81_0)

	return
end

function var_0_1.SetFireworkTip(arg_82_0)
	local var_82_0 = #arg_82_0.fireworkUnlockIds ~= #arg_82_0.fireworkGotIds

	setActive = var_2

	local var_82_1 = arg_82_0.fireworkBtn

	var_2(var_4.Find(var_82_1, "tip"), var_82_0)

	setActive = var_2

	local var_82_2 = arg_82_0.subFireworkBtn

	var_2(var_4.Find(var_82_2, "tip"), var_82_0)

	return
end

function var_0_1.SetSpringTip(arg_83_0)
	local var_83_0 = false

	for iter_83_0 = 1, arg_83_0.springUnlockSlotCount do
		if arg_83_0.springShipIds[iter_83_0] == 0 then
			var_83_0 = true

			break
		end
	end

	setActive = var_2

	local var_83_1 = arg_83_0.springBtn

	var_2(var_4.Find(var_83_1, "tip"), var_83_0)

	setActive = var_2

	local var_83_2 = arg_83_0.subSpringBtn

	var_2(var_4.Find(var_83_2, "tip"), var_83_0)

	return
end

function var_0_1.willExit(arg_84_0)
	arg_84_0:CloseSubPanel()
	arg_84_0:StopPlayFireworks()
	arg_84_0:clearStudents()
	var_0_1.super.willExit(arg_84_0)

	return
end

function var_0_1.IsShowMainTip(arg_85_0)
	ActivityConst = var_1_10001

	local var_85_0 = var_1_10001.FireworkAndSpring_PT_ID

	ActivityConst = var_1_10002

	local var_85_1 = var_1_10002.FireworkAndSpring_TASK_ID

	ActivityConst = var_1_10003

	local var_85_2 = var_1_10003.FireworkAndSpring_ACT_ID

	ActivityConst = var_1_10004

	local var_85_3 = var_1_10004.FireworkAndSpring_EMO_ID

	getProxy = var_1_10005
	ActivityProxy = var_1_10007

	local var_85_4 = var_1_10005(var_1_10007)
	local var_85_5 = var_5.getActivityById(var_85_4, var_85_0)

	ActivityPtData = var_1_10007

	local var_85_6 = var_1_10007.New(var_85_5)
	local var_85_7 = var_7.CanGetAward(var_85_6)
	local var_85_8 = var_5:getActivityById(var_85_1)
	local var_85_9 = {}
	local var_85_10 = var_85_8:getConfig("config_data")

	pairs = var_12

	for iter_85_0, iter_85_1 in var_12(var_85_10) do
		table = var_1_10017
		var_1_10017 = var_1_10017.insert

		local var_85_11 = var_85_9

		getProxy = var_1_10020
		TaskProxy = var_1_10022
		var_1_10022 = var_1_10020(var_1_10022)

		var_1_10017(var_85_11, var_1_10020.getTaskVO(var_1_10022, iter_85_1))
	end

	local var_85_12 = false

	pairs = var_13

	for iter_85_2, iter_85_3 in var_13(var_85_9) do
		if iter_85_3:getTaskStatus() == 1 then
			var_85_12 = true

			break
		end
	end

	local var_85_13 = var_5:getActivityById(var_85_2).data1_list
	local var_85_14 = var_13.data2_list
	local var_85_15 = #var_85_13 ~= #var_85_14
	local var_85_16 = var_5:getActivityById(var_85_3)

	_ = var_1_10018

	local var_85_17 = var_1_10018.map
	local var_85_18 = var_85_16
	local var_85_19 = var_85_17(var_85_16.GetShipIds(var_85_18), function(arg_86_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_86_0 = var_2_10001(var_2_10003)

		if var_1.RawGetShipById(var_86_0, arg_86_0) then
			return arg_86_0
		else
			return 0
		end

		return
	end)
	local var_85_20 = var_85_16:GetSlotCount()
	local var_85_21 = {}
	local var_85_22 = var_85_16:getConfig("config_client").initialCount

	ipairs = var_85_18

	for iter_85_4, iter_85_5 in var_85_18(var_85_16:getConfig("config_client").unlockPt) do
		if iter_85_5 <= var_7.count then
			var_85_22 = var_85_22 + 1
		end
	end

	for iter_85_6 = 1, var_85_20 do
		var_85_21[iter_85_6] = var_85_22 < iter_85_6
	end

	local var_85_23 = false

	for iter_85_7 = 1, var_85_22 do
		if var_85_19[iter_85_7] == 0 then
			var_85_23 = true

			break
		end
	end

	return var_85_7 or var_85_12 or var_85_15 or var_85_23
end

return var_0_1
