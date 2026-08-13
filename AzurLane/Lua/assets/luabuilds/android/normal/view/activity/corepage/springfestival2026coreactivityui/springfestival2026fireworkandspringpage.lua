class = var_0_10000

local var_0_0 = "SpringFestival2026FireworkAndSpringPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityBackHillTemplate"))

var_0_1.edge2area = {
	default = "_SDPlace"
}
var_0_1.EffectPoolCnt = 3
var_0_1.Id2EffectName = {
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

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0._map = var_1.Find(var_1_0, "BG/map")

	local var_1_1 = arg_1_0._tf

	arg_1_0._shipTpl = var_1.Find(var_1_1, "BG/ship")

	local var_1_2 = arg_1_0._tf

	arg_1_0.fireworksTF = var_1.Find(var_1_2, "BG/fireworks")

	local var_1_3 = arg_1_0._tf

	arg_1_0._SDPlace = var_1.Find(var_1_3, "BG/SDPlace")
	arg_1_0.containers = {
		arg_1_0._SDPlace
	}
	GraphPath = var_1

	local var_1_4 = var_1.New

	import = var_2
	arg_1_0.graphPath = var_1_4(var_2("GameCfg.BackHillGraphs.FireworkAndSpringGraph"))

	local var_1_5 = arg_1_0._tf

	arg_1_0.backBtn = var_1.Find(var_1_5, "BG/panel/btn_back")

	local var_1_6 = arg_1_0._tf

	arg_1_0.tipBtn = var_1.Find(var_1_6, "BG/panel/btn_tip")

	local var_1_7 = arg_1_0._tf

	arg_1_0.ptBtn = var_1.Find(var_1_7, "BG/panel/btn_pt")

	local var_1_8 = arg_1_0._tf

	arg_1_0.stage = var_1.Find(var_1_8, "BG/panel/btn_pt/stage")

	local var_1_9 = arg_1_0._tf

	arg_1_0.pt = var_1.Find(var_1_9, "BG/panel/btn_pt/pt")

	local var_1_10 = arg_1_0._tf

	arg_1_0.taskBtn = var_1.Find(var_1_10, "BG/panel/btn_task")

	local var_1_11 = arg_1_0._tf

	arg_1_0.fireworkBtn = var_1.Find(var_1_11, "BG/panel/btn_firework")

	local var_1_12 = arg_1_0._tf

	arg_1_0.springBtn = var_1.Find(var_1_12, "BG/panel/btn_spring")

	local var_1_13 = arg_1_0._tf

	arg_1_0.subPanel = var_1.Find(var_1_13, "BG/subPanel")

	local var_1_14 = arg_1_0.subPanel

	arg_1_0.subPanelPanel = var_1.Find(var_1_14, "panel")

	local var_1_15 = arg_1_0.subPanelPanel

	arg_1_0.subLeft = var_1.Find(var_1_15, "left")

	local var_1_16 = arg_1_0.subPanelPanel

	arg_1_0.subRight = var_1.Find(var_1_16, "right")

	local var_1_17 = arg_1_0.subLeft

	arg_1_0.subPtBtn = var_1.Find(var_1_17, "ptBtn")

	local var_1_18 = arg_1_0.subLeft

	arg_1_0.subTaskBtn = var_1.Find(var_1_18, "taskBtn")

	local var_1_19 = arg_1_0.subLeft

	arg_1_0.subFireworkBtn = var_1.Find(var_1_19, "fireworkBtn")

	local var_1_20 = arg_1_0.subLeft

	arg_1_0.subSpringBtn = var_1.Find(var_1_20, "springBtn")

	local var_1_21 = arg_1_0.subRight

	arg_1_0.ptPanel = var_1.Find(var_1_21, "ptPanel")

	local var_1_22 = arg_1_0.subRight

	arg_1_0.taskPanel = var_1.Find(var_1_22, "taskPanel")

	local var_1_23 = arg_1_0.subRight

	arg_1_0.fireworkPanel = var_1.Find(var_1_23, "fireworkPanel")

	local var_1_24 = arg_1_0.subRight

	arg_1_0.springPanel = var_1.Find(var_1_24, "springPanel")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	arg_2_0:InitData()
	arg_2_0:UpdateMainPt()

	arg_2_0.firePools = {}

	arg_2_0:PlayFireworks()
	arg_2_0:InitStudents()
	arg_2_0:SetTips()
	arg_2_0:CloseSubPanel()

	arg_2_0.hasClonedFireworkArrows = false
	onButton = var_1

	var_1(arg_2_0, arg_2_0.backBtn, function()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.tipBtn, function()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_4_2.type = var_2_10003
		pg = var_2_10003
		var_4_2.helps = var_2_10003.gametip.firework_2025_tip.tip

		var_4_1(var_4_0, var_4_2)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.ptBtn, function()
		local var_5_0 = arg_2_0

		var_0.OpenSubPanel(var_5_0, arg_2_0.ptPanel)

		local var_5_1 = arg_2_0

		var_0.SetPtPanel(var_5_1)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.taskBtn, function()
		local var_6_0 = arg_2_0

		var_0.OpenSubPanel(var_6_0, arg_2_0.taskPanel)

		local var_6_1 = arg_2_0

		var_0.SetTaskPanel(var_6_1)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.fireworkBtn, function()
		local var_7_0 = arg_2_0

		var_0.OpenSubPanel(var_7_0, arg_2_0.fireworkPanel)

		local var_7_1 = arg_2_0

		var_0.SetFireWorkPanel(var_7_1)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.springBtn, function()
		local var_8_0 = arg_2_0

		var_0.OpenSubPanel(var_8_0, arg_2_0.springPanel)

		local var_8_1 = arg_2_0

		var_0.SetSpringPanel(var_8_1)

		return
	end)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.ptPanel

	var_1(var_2_0, var_3.Find(var_2_1, "btnClose"), function()
		local var_9_0 = arg_2_0

		var_0.CloseSubPanel(var_9_0)

		local var_9_1 = arg_2_0

		var_0.PlayFireworks(var_9_1)

		return
	end)

	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.taskPanel

	var_1(var_2_2, var_3.Find(var_2_3, "btnClose"), function()
		local var_10_0 = arg_2_0

		var_0.CloseSubPanel(var_10_0)

		local var_10_1 = arg_2_0

		var_0.PlayFireworks(var_10_1)

		return
	end)

	onButton = var_1

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.fireworkPanel

	var_1(var_2_4, var_3.Find(var_2_5, "btnClose"), function()
		local var_11_0 = arg_2_0

		var_0.CloseSubPanel(var_11_0)

		local var_11_1 = arg_2_0

		var_0.PlayFireworks(var_11_1)

		return
	end)

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.springPanel

	var_1(var_2_6, var_3.Find(var_2_7, "btnClose"), function()
		local var_12_0 = arg_2_0

		var_0.CloseSubPanel(var_12_0)

		local var_12_1 = arg_2_0

		var_0.PlayFireworks(var_12_1)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.subPtBtn, function()
		local var_13_0 = arg_2_0

		var_0.SetSubPanel(var_13_0, arg_2_0.ptPanel)

		local var_13_1 = arg_2_0

		var_0.SetPtPanel(var_13_1)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.subTaskBtn, function()
		local var_14_0 = arg_2_0

		var_0.SetSubPanel(var_14_0, arg_2_0.taskPanel)

		local var_14_1 = arg_2_0

		var_0.SetTaskPanel(var_14_1)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.subFireworkBtn, function()
		local var_15_0 = arg_2_0

		var_0.SetSubPanel(var_15_0, arg_2_0.fireworkPanel)

		local var_15_1 = arg_2_0

		var_0.SetFireWorkPanel(var_15_1)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.subSpringBtn, function()
		local var_16_0 = arg_2_0

		var_0.SetSubPanel(var_16_0, arg_2_0.springPanel)

		local var_16_1 = arg_2_0

		var_0.SetSpringPanel(var_16_1)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_17_0)
	arg_17_0:UpdateTaskData()
	arg_17_0:UpdatePtData()
	arg_17_0:UpdateMainPt()
	arg_17_0:SetTaskPanel()
	arg_17_0:UpdateSpringData()
	arg_17_0:SetPtPanel()
	arg_17_0:SetTips()
	arg_17_0:UpdateFireworkData()
	arg_17_0:SetFireWorkPanel()

	isActive = var_1

	if var_1(arg_17_0.springPanel) then
		arg_17_0:UpdateSpringActivityAndUI()
	end

	return
end

function var_0_1.InitData(arg_18_0)
	ActivityConst = var_1_10001
	arg_18_0.ptActId = var_1_10001.HorseYearSpringFestival2026_ID_1
	ActivityConst = var_1
	arg_18_0.taskActId = var_1.HorseYearSpringFestival2026_ID_2
	ActivityConst = var_1
	arg_18_0.fireworkActId = var_1.HorseYearSpringFestival2026_ID_4
	ActivityConst = var_1
	arg_18_0.springActId = var_1.HorseYearSpringFestival2026_ID_3

	arg_18_0:UpdatePtData()
	arg_18_0:UpdateTaskData()
	arg_18_0:UpdateFireworkData()
	arg_18_0:UpdateSpringData()

	return
end

function var_0_1.UpdatePtData(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)

	arg_19_0.ptActivity = var_1.getActivityById(var_19_0, arg_19_0.ptActId)
	ActivityPtData = var_2
	arg_19_0.ptData = var_2.New(arg_19_0.ptActivity)

	return
end

function var_0_1.UpdateTaskData(arg_20_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)

	arg_20_0.taskActivity = var_1.getActivityById(var_20_0, arg_20_0.taskActId)
	arg_20_0.taskVOs = {}

	local var_20_1 = arg_20_0.taskActivity
	local var_20_2 = var_2.getConfig(var_20_1, "config_data")

	pairs = var_20_1

	for iter_20_0, iter_20_1 in var_20_1(var_20_2) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_20_3 = arg_20_0.taskVOs

		getProxy = var_1_10010
		TaskProxy = var_1_10011
		var_1_10011 = var_1_10010(var_1_10011)

		var_1_10008(var_20_3, var_1_10010.getTaskVO(var_1_10011, iter_20_1))
	end

	arg_20_0.canGetTaskVOs = {}
	arg_20_0.canGetTaskIds = {}

	arg_20_0:sort(arg_20_0.taskVOs)

	return
end

function var_0_1.sort(arg_21_0, arg_21_1)
	local var_21_0 = {}

	arg_21_0.canGetTaskAward = false
	pairs = var_3

	for iter_21_0, iter_21_1 in var_3(arg_21_1) do
		if iter_21_1:getTaskStatus() == 1 then
			table = var_8

			var_8.insert(var_21_0, iter_21_1)

			table = var_8

			var_8.insert(arg_21_0.canGetTaskVOs, iter_21_1)

			table = var_8

			var_8.insert(arg_21_0.canGetTaskIds, iter_21_1.id)

			arg_21_0.canGetTaskAward = true
		end
	end

	pairs = var_3

	for iter_21_2, iter_21_3 in var_3(arg_21_1) do
		if iter_21_3:getTaskStatus() == 0 then
			table = var_8

			var_8.insert(var_21_0, iter_21_3)
		end
	end

	pairs = var_3

	for iter_21_4, iter_21_5 in var_3(arg_21_1) do
		if iter_21_5:getTaskStatus() == 2 then
			table = var_8

			var_8.insert(var_21_0, iter_21_5)
		end
	end

	arg_21_0.taskVOs = var_21_0

	return
end

function var_0_1.UpdateFireworkData(arg_22_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_22_0 = var_1_10001(var_1_10002)

	arg_22_0.fireworkActivity = var_1.getActivityById(var_22_0, arg_22_0.fireworkActId)
	arg_22_0.fireworkUnlockIds = arg_22_0.fireworkActivity.data1_list
	arg_22_0.fireworkGotIds = arg_22_0.fireworkActivity.data2_list

	local var_22_1 = arg_22_0.fireworkActivity

	arg_22_0.fireworkAllIds = var_2.GetPicturePuzzleIds(var_22_1)
	getProxy = var_2
	PlayerProxy = var_22_1

	local var_22_2 = var_2(var_22_1)

	arg_22_0.playerId = var_2.getData(var_22_2).id
	arg_22_0.fireworkOrderIds = arg_22_0:GetFireWorkLocalData()

	return
end

function var_0_1.GetFireWorkLocalData(arg_23_0)
	local var_23_0 = {}

	for iter_23_0 = 1, #arg_23_0.fireworkAllIds do
		PlayerPrefs = var_1_10006

		if var_1_10006.GetInt("fireworks_" .. arg_23_0.fireworkActId .. "_" .. arg_23_0.playerId .. "_pos_" .. iter_23_0) ~= 0 then
			table = var_7

			var_7.insert(var_23_0, var_1_10006)
		end
	end

	return var_23_0
end

function var_0_1.SetFireWorkLocalData(arg_24_0)
	for iter_24_0 = 1, #arg_24_0.fireworkAllIds do
		local var_24_0

		if not arg_24_0.fireworkOrderIds[iter_24_0] then
			var_24_0 = 0
		end

		PlayerPrefs = var_1_10006

		var_1_10006.SetInt("fireworks_" .. arg_24_0.fireworkActId .. "_" .. arg_24_0.playerId .. "_pos_" .. iter_24_0, var_24_0)
	end

	return
end

function var_0_1.UpdateSpringData(arg_25_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_25_0 = var_1_10001(var_1_10002)

	arg_25_0.springActivity = var_1.getActivityById(var_25_0, arg_25_0.springActId)
	_ = var_2

	local var_25_1 = var_2.map
	local var_25_2 = arg_25_0.springActivity

	arg_25_0.springShipIds = var_25_1(var_3.GetShipIds(var_25_2), function(arg_26_0)
		getProxy = var_2_10001
		BayProxy = var_2_10002

		local var_26_0 = var_2_10001(var_2_10002)

		if var_1.RawGetShipById(var_26_0, arg_26_0) then
			return arg_26_0
		else
			return 0
		end

		return
	end)

	local var_25_3 = arg_25_0.springActivity

	arg_25_0.springMaxCnt = var_2.GetSlotCount(var_25_3)
	arg_25_0.springSlotLockList = {}

	local var_25_4 = arg_25_0.springActivity

	arg_25_0.springUnlockSlotCount = var_2.getConfig(var_25_4, "config_client").initialCount
	ipairs = var_2

	local var_25_5 = arg_25_0.springActivity

	for iter_25_0, iter_25_1 in var_2(var_3.getConfig(var_25_5, "config_client").unlockPt) do
		if iter_25_1 <= arg_25_0.ptData.count then
			arg_25_0.springUnlockSlotCount = arg_25_0.springUnlockSlotCount + 1
		end
	end

	for iter_25_2 = 1, arg_25_0.springMaxCnt do
		local var_25_6 = iter_25_2 > arg_25_0.springUnlockSlotCount

		arg_25_0.springSlotLockList[iter_25_2] = var_25_6
	end

	local var_25_7 = arg_25_0.springActivity

	arg_25_0.energyRecoverAddition = var_2.GetEnergyRecoverAddition(var_25_7) * 10

	return
end

function var_0_1.OpenSubPanel(arg_27_0, arg_27_1)
	setActive = var_1_10002

	var_1_10002(arg_27_0.subPanel, true)
	arg_27_0:SetSubPanel(arg_27_1)

	return
end

function var_0_1.CloseSubPanel(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0.subPanel, false)

	return
end

function var_0_1.SetSubPanel(arg_29_0, arg_29_1)
	setActive = var_1_10002

	var_1_10002(arg_29_0.ptPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_29_0.taskPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_29_0.fireworkPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_29_0.springPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_29_1, true)

	setActive = var_1_10002

	local var_29_0 = arg_29_0.subPtBtn

	var_1_10002(var_3.Find(var_29_0, "selected"), arg_29_1 == arg_29_0.ptPanel)

	setActive = var_1_10002

	local var_29_1 = arg_29_0.subTaskBtn

	var_1_10002(var_3.Find(var_29_1, "selected"), arg_29_1 == arg_29_0.taskPanel)

	setActive = var_1_10002

	local var_29_2 = arg_29_0.subFireworkBtn

	var_1_10002(var_3.Find(var_29_2, "selected"), arg_29_1 == arg_29_0.fireworkPanel)

	setActive = var_1_10002

	local var_29_3 = arg_29_0.subSpringBtn

	var_1_10002(var_3.Find(var_29_3, "selected"), arg_29_1 == arg_29_0.springPanel)

	return
end

function var_0_1.UpdateMainPt(arg_30_0)
	setText = var_1_10001

	local var_30_0 = arg_30_0.stage
	local var_30_1 = "Lv."
	local var_30_2 = arg_30_0.ptData

	var_1_10001(var_30_0, var_30_1 .. var_4.GetCurrLevel(var_30_2))

	local var_30_3 = arg_30_0.ptData

	if not var_1.IsMaxLevel(var_30_3) then
		setText = var_1

		local var_30_4 = arg_30_0.pt
		local var_30_5 = arg_30_0.ptData.count
		local var_30_6 = "/"
		local var_30_7 = arg_30_0.ptData

		var_1(var_30_4, var_30_5 .. var_30_6 .. var_5.GetNextLevelTarget(var_30_7))
	else
		setText = var_1

		var_1(arg_30_0.pt, "MAX")
	end

	return
end

function var_0_1.SetPtPanel(arg_31_0)
	setText = var_1_10001

	local var_31_0 = arg_31_0.ptPanel
	local var_31_1 = var_2.Find(var_31_0, "lvText")
	local var_31_2 = arg_31_0.ptData

	var_1_10001(var_31_1, var_3.GetCurrLevel(var_31_2))

	local var_31_3 = arg_31_0.ptData

	if not var_1.IsMaxLevel(var_31_3) then
		setText = var_1

		local var_31_4 = arg_31_0.ptPanel
		local var_31_5 = var_2.Find(var_31_4, "pt")
		local var_31_6 = arg_31_0.ptData.count
		local var_31_7 = "/"

		var_1_10006 = arg_31_0.ptData

		var_1(var_31_5, var_31_6 .. var_31_7 .. var_5.GetNextLevelTarget(var_1_10006))

		setSlider = var_1

		local var_31_8 = arg_31_0.ptPanel
		local var_31_9 = var_2.Find(var_31_8, "slider")
		local var_31_10 = 0
		local var_31_11 = arg_31_0.ptData

		var_1(var_31_9, var_31_10, var_4.GetNextLevelTarget(var_31_11), arg_31_0.ptData.count)
	else
		setText = var_1

		local var_31_12 = arg_31_0.ptPanel

		var_1(var_2.Find(var_31_12, "pt"), "MAX")

		setSlider = var_1

		local var_31_13 = arg_31_0.ptPanel

		var_1(var_2.Find(var_31_13, "slider"), 0, 1, 1)
	end

	setText = var_1

	local var_31_14 = arg_31_0.ptPanel
	local var_31_15 = var_2.Find(var_31_14, "ptScroll/Viewport/Content/tpl/get/Text")

	i18n = var_31_14

	var_1(var_31_15, var_31_14("firework_2025_get"))

	setText = var_1

	local var_31_16 = arg_31_0.ptPanel
	local var_31_17 = var_2.Find(var_31_16, "ptScroll/Viewport/Content/tpl/got/Text")

	i18n = var_31_16

	var_1(var_31_17, var_31_16("firework_2025_got"))

	UIItemList = var_1

	local var_31_18 = var_1.New
	local var_31_19 = arg_31_0.ptPanel
	local var_31_20 = var_2.Find(var_31_19, "ptScroll/Viewport/Content")
	local var_31_21 = arg_31_0.ptPanel
	local var_31_22 = var_31_18(var_31_20, var_3.Find(var_31_21, "ptScroll/Viewport/Content/tpl"))

	var_1.make(var_31_22, function(arg_32_0, arg_32_1, arg_32_2)
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventUpdate then
			local var_32_0 = arg_31_0.ptData.dropList[arg_32_1 + 1]
			local var_32_1 = arg_31_0.ptData.targets[arg_32_1 + 1]

			setText = var_5

			local var_32_2 = arg_32_2
			local var_32_3 = arg_32_2.Find(var_32_2, "level")

			i18n = var_32_2

			var_5(var_32_3, var_32_2("firework_2025_level", arg_32_1 + 1))

			Drop = var_5

			local var_32_4 = var_5.Create(var_32_0)

			updateDrop = var_6

			var_6(arg_32_2:Find("award"), var_32_4)

			onButton = var_6

			local var_32_5 = arg_31_0
			local var_32_6 = arg_32_2:Find("award")

			local function var_32_7()
				local var_33_0 = arg_31_0
				local var_33_1 = var_0.emit

				BaseUI = var_3_10002

				var_33_1(var_33_0, var_3_10002.ON_DROP, var_32_4)

				return
			end

			SFX_PANEL = var_10

			var_6(var_32_5, var_32_6, var_32_7, var_10)

			local var_32_8 = arg_31_0.ptData
			local var_32_9 = var_6.GetDroptItemState(var_32_8, arg_32_1 + 1)

			ActivityPtData = var_32_8

			if var_32_9 == var_32_8.STATE_LOCK then
				setActive = var_7

				var_7(arg_32_2:Find("lock"), true)

				setActive = var_7

				var_7(arg_32_2:Find("get"), false)

				setActive = var_7

				var_7(arg_32_2:Find("got"), false)
			else
				ActivityPtData = var_7

				if var_32_9 == var_7.STATE_CAN_GET then
					setActive = var_7

					var_7(arg_32_2:Find("lock"), false)

					setActive = var_7

					var_7(arg_32_2:Find("get"), true)

					setActive = var_7

					var_7(arg_32_2:Find("got"), false)
				else
					setActive = var_7

					var_7(arg_32_2:Find("lock"), false)

					setActive = var_7

					var_7(arg_32_2:Find("get"), false)

					setActive = var_7

					var_7(arg_32_2:Find("got"), true)
				end
			end
		end

		return
	end)
	var_1:align(#arg_31_0.ptData.dropList)

	rtf = var_2

	local var_31_23 = arg_31_0.ptPanel
	local var_31_24 = var_2(var_3.Find(var_31_23, "ptScroll/Viewport/Content/tpl")).rect.width
	local var_31_25 = arg_31_0.ptPanel
	local var_31_26 = var_3.Find(var_31_25, "ptScroll/Viewport/Content")
	local var_31_27 = var_3.GetComponent

	typeof = var_5
	HorizontalLayoutGroup = var_1_10006

	local var_31_28 = var_31_27(var_31_26, var_5(var_1_10006)).spacing

	rtf = var_31_26

	local var_31_29 = arg_31_0.ptPanel
	local var_31_30 = var_31_26(var_5.Find(var_31_29, "ptScroll/Viewport")).rect.width

	scrollTo = var_5

	local var_31_31 = arg_31_0.ptPanel

	var_5(var_6.Find(var_31_31, "ptScroll"), arg_31_0.ptData.level * (var_31_24 + var_31_28) / (#arg_31_0.ptData.targets * (var_31_24 + var_31_28) - var_31_28 - var_31_30), 0)

	local var_31_32 = 6
	local var_31_33 = arg_31_0.ptActivity

	arg_31_0.importants = var_6.getConfig(var_31_33, "config_client").highValueItemSort
	arg_31_0.importantsPos = {}
	ipairs = var_6

	for iter_31_0, iter_31_1 in var_6(arg_31_0.importants) do
		table = var_1_10011

		var_1_10011.insert(arg_31_0.importantsPos, (iter_31_1 - var_31_32 - 1) * (var_31_24 + var_31_28) / (#arg_31_0.ptData.targets * (var_31_24 + var_31_28) - var_31_28 - var_31_30))
	end

	arg_31_0:PtScrollToDo(arg_31_0.ptData.level * (var_31_24 + var_31_28) / (#arg_31_0.ptData.targets * (var_31_24 + var_31_28) - var_31_28 - var_31_30))

	onScroll = var_6

	local var_31_34 = arg_31_0
	local var_31_35 = arg_31_0.ptPanel

	var_6(var_31_34, var_8.Find(var_31_35, "ptScroll"), function(arg_34_0)
		local var_34_0 = arg_31_0

		var_1.PtScrollToDo(var_34_0, arg_34_0.x)

		return
	end)

	local var_31_36 = arg_31_0.ptData

	if var_6.CanGetAward(var_31_36) then
		setActive = var_6

		local var_31_37 = arg_31_0.ptPanel

		var_6(var_7.Find(var_31_37, "btn_get"), true)

		onButton = var_6

		local var_31_38 = arg_31_0
		local var_31_39 = arg_31_0.ptPanel
		local var_31_40 = var_8.Find(var_31_39, "btn_get")

		local function var_31_41()
			local var_35_0 = {}
			local var_35_1 = arg_31_0.ptData
			local var_35_2 = var_1.GetAllAvailableAwards(var_35_1)

			getProxy = var_35_1
			PlayerProxy = var_2_10003

			local var_35_3 = var_35_1(var_2_10003)
			local var_35_4 = var_2.getRawData(var_35_3)

			pg = var_35_3

			local var_35_5 = var_35_3.gameset.urpt_chapter_max.description[1]

			LOCK_UR_SHIP = var_2_10005

			if var_2_10005 then
				var_2_10005 = 0
			else
				getProxy = var_2_10005
				BagProxy = var_2_10006
				var_2_10006 = var_2_10005(var_2_10006)
				var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_35_5)
			end

			Task = var_2_10006

			local var_35_6, var_35_7 = var_2_10006.StaticJudgeOverflow(var_35_4.gold, var_35_4.oil, var_2_10005, true, true, var_35_2)

			if var_35_6 then
				table = var_8

				var_8.insert(var_35_0, function(arg_36_0)
					pg = var_3_10001

					local var_36_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_36_1 = var_1.ShowMsgBox
					local var_36_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10004
					var_36_2.type = var_3_10004
					i18n = var_3_10004
					var_36_2.content = var_3_10004("award_max_warning")
					var_36_2.items = var_35_7
					var_36_2.onYes = arg_36_0

					var_36_1(var_36_0, var_36_2)

					return
				end)
			end

			seriesAsync = var_8

			var_8(var_35_0, function()
				local var_37_0 = arg_31_0.ptData
				local var_37_1 = var_0.GetCurrTarget(var_37_0)
				local var_37_2 = arg_31_0
				local var_37_3 = var_1.emit

				ActivityMediator = var_3_10003

				local var_37_4 = var_3_10003.EVENT_PT_OPERATION
				local var_37_5 = {
					cmd = 4
				}
				local var_37_6 = arg_31_0.ptData

				var_37_5.activity_id = var_5.GetId(var_37_6)
				var_37_5.arg1 = var_37_1

				var_37_3(var_37_2, var_37_4, var_37_5)

				return
			end)

			return
		end

		SFX_PANEL = var_10

		var_6(var_31_38, var_31_40, var_31_41, var_10)
	else
		setActive = var_6

		local var_31_42 = arg_31_0.ptPanel

		var_6(var_7.Find(var_31_42, "btn_get"), false)

		removeOnButton = var_6

		local var_31_43 = arg_31_0.ptPanel

		var_6(var_7.Find(var_31_43, "btn_get"))
	end

	setText = var_6

	local var_31_44 = arg_31_0.ptPanel
	local var_31_45 = var_7.Find(var_31_44, "ptName")

	i18n = var_31_44

	var_6(var_31_45, var_31_44("firework_2025_pt"))

	return
end

function var_0_1.PtScrollToDo(arg_38_0, arg_38_1)
	local var_38_0 = 0

	ipairs = var_1_10003

	for iter_38_0, iter_38_1 in var_1_10003(arg_38_0.importantsPos) do
		if arg_38_1 < iter_38_1 or iter_38_0 == #arg_38_0.importants then
			var_38_0 = arg_38_0.importants[iter_38_0]

			break
		end
	end

	Drop = var_3

	local var_38_1 = var_3.Create(arg_38_0.ptData.dropList[var_38_0])

	updateDrop = var_4

	local var_38_2 = arg_38_0.ptPanel

	var_4(var_5.Find(var_38_2, "award"), var_38_1)

	onButton = var_4

	local var_38_3 = arg_38_0
	local var_38_4 = arg_38_0.ptPanel
	local var_38_5 = var_6.Find(var_38_4, "award")

	local function var_38_6()
		local var_39_0 = arg_38_0
		local var_39_1 = var_0.emit

		BaseUI = var_2_10002

		var_39_1(var_39_0, var_2_10002.ON_DROP, var_38_1)

		return
	end

	SFX_PANEL = var_8

	var_4(var_38_3, var_38_5, var_38_6, var_8)

	setText = var_4

	local var_38_7 = arg_38_0.ptPanel
	local var_38_8 = var_5.Find(var_38_7, "awardInfo/Text")

	i18n = var_38_7

	var_4(var_38_8, var_38_7("firework_2025_level", var_38_0))

	setActive = var_4

	local var_38_9 = arg_38_0.ptPanel

	var_4(var_5.Find(var_38_9, "award/got"), var_38_0 <= arg_38_0.ptData.level)

	return
end

function var_0_1.SetTaskPanel(arg_40_0)
	setText = var_1_10001

	local var_40_0 = arg_40_0.taskPanel
	local var_40_1 = var_2.Find(var_40_0, "lvText")
	local var_40_2 = arg_40_0.ptData

	var_1_10001(var_40_1, var_3.GetCurrLevel(var_40_2))

	local var_40_3 = arg_40_0.ptData

	if not var_1.IsMaxLevel(var_40_3) then
		setText = var_1

		local var_40_4 = arg_40_0.taskPanel
		local var_40_5 = var_2.Find(var_40_4, "pt")
		local var_40_6 = arg_40_0.ptData.count
		local var_40_7 = "/"
		local var_40_8 = arg_40_0.ptData

		var_1(var_40_5, var_40_6 .. var_40_7 .. var_5.GetNextLevelTarget(var_40_8))

		setSlider = var_1

		local var_40_9 = arg_40_0.taskPanel
		local var_40_10 = var_2.Find(var_40_9, "slider")
		local var_40_11 = 0
		local var_40_12 = arg_40_0.ptData

		var_1(var_40_10, var_40_11, var_4.GetNextLevelTarget(var_40_12), arg_40_0.ptData.count)
	else
		setText = var_1

		local var_40_13 = arg_40_0.taskPanel

		var_1(var_2.Find(var_40_13, "pt"), "MAX")

		setSlider = var_1

		local var_40_14 = arg_40_0.taskPanel

		var_1(var_2.Find(var_40_14, "slider"), 0, 1, 1)
	end

	UIItemList = var_1

	local var_40_15 = var_1.New
	local var_40_16 = arg_40_0.taskPanel
	local var_40_17 = var_2.Find(var_40_16, "taskScroll/Viewport/Content")
	local var_40_18 = arg_40_0.taskPanel
	local var_40_19 = var_40_15(var_40_17, var_3.Find(var_40_18, "taskScroll/Viewport/Content/Tasktpl"))

	var_1.make(var_40_19, function(arg_41_0, arg_41_1, arg_41_2)
		UIItemList = var_2_10003

		if arg_41_0 == var_2_10003.EventUpdate then
			local var_41_0 = arg_40_0.taskVOs[arg_41_1 + 1]

			setText = var_4

			var_4(arg_41_2:Find("frame/name"), var_41_0:getConfig("name"))

			setText = var_4

			var_4(arg_41_2:Find("frame/desc"), var_41_0:getConfig("desc"))

			local var_41_1 = var_41_0:getProgress()
			local var_41_2 = var_41_0
			local var_41_3 = var_41_0.getConfig(var_41_2, "target_num")

			math = var_41_2

			local var_41_4 = var_41_2.min(var_41_1, var_41_3)

			setText = var_6

			var_6(arg_41_2:Find("frame/progress"), var_41_4 .. "/" .. var_41_3)

			local var_41_5 = arg_41_2:Find("frame/slider")
			local var_41_6 = var_6.GetComponent

			typeof = var_8
			Slider = var_9
			var_41_6(var_41_5, var_8(var_9)).value = var_41_4 / var_41_3

			local var_41_7 = arg_41_2:Find("frame/awards")
			local var_41_8 = var_7.GetChild(var_41_7, 0)
			local var_41_9 = arg_40_0

			var_9.updateTaskAwards(var_41_9, var_41_0:getConfig("award_display"), var_7, var_41_8)

			local var_41_10 = arg_41_2:Find("frame/go_btn")
			local var_41_11 = arg_41_2:Find("frame/get_btn")
			local var_41_12 = arg_41_2:Find("frame/got_btn")

			if var_41_0:getTaskStatus() == 0 then
				setActive = var_12

				var_12(var_41_10, true)

				setActive = var_12

				var_12(var_41_11, false)

				setActive = var_12

				var_12(var_41_12, false)
			elseif var_41_0:getTaskStatus() == 1 then
				setActive = var_12

				var_12(var_41_10, false)

				setActive = var_12

				var_12(var_41_11, true)

				setActive = var_12

				var_12(var_41_12, false)
			elseif var_41_0:getTaskStatus() == 2 then
				setActive = var_12

				var_12(var_41_10, false)

				setActive = var_12

				var_12(var_41_11, false)

				setActive = var_12

				var_12(var_41_12, true)
			end

			onButton = var_12

			local var_41_13 = arg_40_0
			local var_41_14 = var_41_10

			local function var_41_15()
				local var_42_0 = arg_40_0
				local var_42_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_42_1(var_42_0, var_3_10002.ON_TASK_GO, var_41_0)

				return
			end

			SFX_PANEL = var_2_10016

			var_12(var_41_13, var_41_14, var_41_15, var_2_10016)

			onButton = var_12

			local var_41_16 = arg_40_0
			local var_41_17 = var_41_11

			local function var_41_18()
				local var_43_0 = arg_40_0
				local var_43_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_43_1(var_43_0, var_3_10002.ON_TASK_SUBMIT, var_41_0)

				return
			end

			SFX_PANEL = var_2_10016

			var_12(var_41_16, var_41_17, var_41_18, var_2_10016)
		end

		return
	end)
	var_1:align(#arg_40_0.taskVOs)

	if arg_40_0.canGetTaskAward then
		setActive = var_2

		local var_40_20 = arg_40_0.taskPanel

		var_2(var_3.Find(var_40_20, "btn_get"), true)

		onButton = var_2

		local var_40_21 = arg_40_0
		local var_40_22 = arg_40_0.taskPanel
		local var_40_23 = var_4.Find(var_40_22, "btn_get")

		local function var_40_24()
			local var_44_0 = {}
			local var_44_1 = {}

			pairs = var_2_10002

			for iter_44_0, iter_44_1 in var_2_10002(arg_40_0.canGetTaskVOs) do
				local var_44_2 = iter_44_1
				local var_44_3 = iter_44_1.getConfig(var_44_2, "award_display")

				ipairs = var_44_2

				for iter_44_2, iter_44_3 in var_44_2(var_44_3) do
					local var_44_4 = iter_44_3
					local var_44_5 = false

					pairs = var_2_10015

					for iter_44_4, iter_44_5 in var_2_10015(var_44_1) do
						if iter_44_5[1] == var_44_4[1] and iter_44_5[2] == var_44_4[2] then
							var_44_5 = true
							iter_44_5[3] = iter_44_5[3] + var_44_4[3]

							break
						end
					end

					if not var_44_5 then
						table = var_2_10015

						var_2_10015.insert(var_44_1, var_44_4)
					end
				end
			end

			getProxy = var_2
			PlayerProxy = var_3

			local var_44_6 = var_2(var_3)
			local var_44_7 = var_2.getRawData(var_44_6)

			pg = var_44_6

			local var_44_8 = var_44_6.gameset.urpt_chapter_max.description[1]

			LOCK_UR_SHIP = iter_44_0

			if iter_44_0 then
				iter_44_0 = 0
			else
				getProxy = iter_44_0
				BagProxy = iter_44_1
				iter_44_1 = iter_44_0(iter_44_1)
				iter_44_0 = iter_44_0.GetLimitCntById(iter_44_1, var_44_8)
			end

			Task = iter_44_1

			local var_44_9, var_44_10 = iter_44_1.StaticJudgeOverflow(var_44_7.gold, var_44_7.oil, iter_44_0, true, true, var_44_1)

			if var_44_9 then
				table = var_8

				var_8.insert(var_44_0, function(arg_45_0)
					pg = var_3_10001

					local var_45_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_45_1 = var_1.ShowMsgBox
					local var_45_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10004
					var_45_2.type = var_3_10004
					i18n = var_3_10004
					var_45_2.content = var_3_10004("award_max_warning")
					var_45_2.items = var_44_10
					var_45_2.onYes = arg_45_0

					var_45_1(var_45_0, var_45_2)

					return
				end)
			end

			seriesAsync = var_8

			var_8(var_44_0, function()
				local var_46_0 = arg_40_0
				local var_46_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_46_1(var_46_0, var_3_10002.ON_ACTIVITY_TASK_LIST_SUBMIT, {
					activityId = arg_40_0.taskActId,
					ids = arg_40_0.canGetTaskIds
				})

				return
			end)

			return
		end

		SFX_PANEL = var_6

		var_2(var_40_21, var_40_23, var_40_24, var_6)
	else
		setActive = var_2

		local var_40_25 = arg_40_0.taskPanel

		var_2(var_3.Find(var_40_25, "btn_get"), false)

		removeOnButton = var_2

		local var_40_26 = arg_40_0.taskPanel

		var_2(var_3.Find(var_40_26, "btn_get"))
	end

	setText = var_2

	local var_40_27 = arg_40_0.taskPanel
	local var_40_28 = var_3.Find(var_40_27, "ptName")

	i18n = var_40_27

	var_2(var_40_28, var_40_27("firework_2025_pt"))

	return
end

function var_0_1.updateTaskAwards(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	_ = var_1_10004

	local var_47_0 = var_1_10004.slice(arg_47_1, 1, 3)

	for iter_47_0 = arg_47_2.childCount, #var_47_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_47_3, arg_47_2)
	end

	local var_47_1 = arg_47_2.childCount

	for iter_47_1 = 1, var_47_1 do
		local var_47_2 = arg_47_2:GetChild(iter_47_1 - 1)
		local var_47_3 = iter_47_1 <= #var_47_0

		setActive = var_12

		var_12(var_47_2, var_47_3)

		if var_47_3 then
			local var_47_4 = var_47_0[iter_47_1]
			local var_47_5 = {
				type = var_47_4[1],
				id = var_47_4[2],
				count = var_47_4[3]
			}

			updateDrop = var_14

			var_14(var_47_2, var_47_5)

			onButton = var_14

			local var_47_6 = arg_47_0
			local var_47_7 = var_47_2

			local function var_47_8()
				local var_48_0 = arg_47_0
				local var_48_1 = var_0.emit

				BaseUI = var_2_10002

				var_48_1(var_48_0, var_2_10002.ON_DROP, var_47_5)

				return
			end

			SFX_PANEL = var_1_10018

			var_14(var_47_6, var_47_7, var_47_8, var_1_10018)
		end
	end

	return
end

function var_0_1.SetFireWorkPanel(arg_49_0)
	local var_49_0 = arg_49_0.fireworkPanel
	local var_49_1 = var_1.Find(var_49_0, "left_panel")
	local var_49_2 = arg_49_0.fireworkPanel
	local var_49_3 = var_2.Find(var_49_2, "right_panel")
	local var_49_4 = var_2.Find(var_49_3, "fire_btn")
	local var_49_5 = var_49_1:Find("scrollrect/content/item_tpl")
	local var_49_6 = var_49_1
	local var_49_7 = var_49_1.Find(var_49_6, "scrollrect/content")

	UIItemList = var_49_6
	arg_49_0.leftUIList = var_49_6.New(var_49_7, var_49_5)

	local var_49_8 = var_2:Find("content/item_tpl")
	local var_49_9 = var_2
	local var_49_10 = var_2.Find(var_49_9, "content")

	UIItemList = var_49_9
	arg_49_0.rightUIList = var_49_9.New(var_49_10, var_49_8)

	local var_49_11 = var_2
	local var_49_12 = var_2.Find(var_49_11, "arrows")

	onButton = var_49_11

	var_49_11(arg_49_0, var_49_4, function()
		local var_50_0 = arg_49_0

		var_0.CloseSubPanel(var_50_0)

		local var_50_1 = arg_49_0

		var_0.PlayFireworks(var_50_1)

		return
	end)

	setText = var_49_11

	local var_49_13 = var_2
	local var_49_14 = var_2.Find(var_49_13, "tip")

	i18n = var_49_13

	var_49_11(var_49_14, var_49_13("activity_yanhua_tip7"))

	setText = var_49_11

	local var_49_15 = var_49_1
	local var_49_16 = var_49_1.Find(var_49_15, "tip")

	i18n = var_49_15

	var_49_11(var_49_16, var_49_15("firework_2025_tip1"))

	local var_49_17 = arg_49_0.leftUIList

	var_9.make(var_49_17, function(arg_51_0, arg_51_1, arg_51_2)
		UIItemList = var_2_10003

		if arg_51_0 == var_2_10003.EventUpdate then
			local var_51_0 = arg_49_0.fireworkAllIds[arg_51_1 + 1]
			local var_51_1 = arg_51_2
			local var_51_2 = arg_51_2.Find(var_51_1, "firework/icon")

			GetImageSpriteFromAtlasAsync = var_51_1
			Item = var_6

			var_51_1(var_6.getConfigData(var_51_0).icon, "", var_51_2)

			local var_51_3 = arg_51_2
			local var_51_4 = arg_51_2.Find(var_51_3, "firework/selected")

			table = var_51_3

			local var_51_5 = var_51_3.contains(arg_49_0.fireworkOrderIds, var_51_0)

			setActive = var_7

			var_7(var_51_4, var_51_5)

			table = var_7

			if not var_7.contains(arg_49_0.fireworkUnlockIds, var_51_0) then
				setActive = var_7

				var_7(arg_51_2:Find("firework/lock"), true)

				setActive = var_7

				var_7(arg_51_2:Find("firework/get"), false)
			else
				table = var_7

				if not var_7.contains(arg_49_0.fireworkGotIds, var_51_0) then
					setActive = var_7

					var_7(arg_51_2:Find("firework/lock"), false)

					setActive = var_7

					var_7(arg_51_2:Find("firework/get"), true)

					onButton = var_7

					local var_51_6 = arg_49_0
					local var_51_7 = arg_51_2

					local function var_51_8()
						local var_52_0 = arg_49_0
						local var_52_1 = var_0.emit

						ActivityMediator = var_3_10002

						local var_52_2 = var_3_10002.EVENT_OPERATION
						local var_52_3 = {
							arg_49_0.fireworkActId
						}

						PuzzleActivity = var_4
						var_52_3[2] = var_4.CMD_ACTIVATE
						var_52_3[3] = var_51_0

						var_52_1(var_52_0, var_52_2, var_52_3)

						return
					end

					SFX_PANEL = var_2_10011

					var_7(var_51_6, var_51_7, var_51_8, var_2_10011)
				else
					setActive = var_7

					var_7(arg_51_2:Find("firework/lock"), false)

					setActive = var_7

					var_7(arg_51_2:Find("firework/get"), false)

					onButton = var_7

					local var_51_9 = arg_49_0
					local var_51_10 = arg_51_2

					local function var_51_11()
						local var_53_0 = arg_49_0

						var_0.FireworkLeftClick(var_53_0, var_51_0, var_51_5)

						return
					end

					SFX_PANEL = var_2_10011

					var_7(var_51_9, var_51_10, var_51_11, var_2_10011)
				end
			end
		end

		return
	end)

	local var_49_18 = arg_49_0.leftUIList

	var_9.align(var_49_18, #arg_49_0.fireworkAllIds)

	if not arg_49_0.hasClonedFireworkArrows then
		arg_49_0.hasClonedFireworkArrows = true

		for iter_49_0 = 1, #arg_49_0.fireworkAllIds - 2 do
			cloneTplTo = var_1_10013

			var_1_10013(var_49_12:Find("tpl"), var_49_12)
		end
	end

	local var_49_19 = arg_49_0.rightUIList

	var_9.make(var_49_19, function(arg_54_0, arg_54_1, arg_54_2)
		UIItemList = var_2_10003

		if arg_54_0 == var_2_10003.EventUpdate then
			local var_54_0 = arg_54_1 + 1
			local var_54_1 = arg_54_2
			local var_54_2 = arg_54_2.Find(var_54_1, "icon")

			setActive = var_54_1

			var_54_1(arg_54_2:Find("add"), var_54_0 > #arg_49_0.fireworkOrderIds)

			if #arg_49_0.fireworkOrderIds < var_54_0 then
				setActive = var_5

				var_5(var_54_2, false)
			else
				local var_54_3 = arg_49_0.fireworkOrderIds[var_54_0]

				setActive = var_6

				var_6(var_54_2, true)

				GetImageSpriteFromAtlasAsync = var_6
				Item = var_7

				var_6(var_7.getConfigData(var_54_3).icon, "", var_54_2)

				onButton = var_6

				local var_54_4 = arg_49_0
				local var_54_5 = var_54_2

				local function var_54_6()
					local var_55_0 = arg_49_0

					var_0.FireworkRightClick(var_55_0, var_54_3)

					return
				end

				SFX_PANEL = var_2_10010

				var_6(var_54_4, var_54_5, var_54_6, var_2_10010)
			end
		end

		return
	end)

	local var_49_20 = arg_49_0.rightUIList

	var_9.align(var_49_20, #arg_49_0.fireworkAllIds)

	return
end

function var_0_1.FireworkLeftClick(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_2 then
		table = var_1_10003

		var_1_10003.removebyvalue(arg_56_0.fireworkOrderIds, arg_56_1)
	else
		table = var_1_10003

		var_1_10003.insert(arg_56_0.fireworkOrderIds, arg_56_1)
	end

	arg_56_0:SetFireWorkLocalData()

	local var_56_0 = arg_56_0.leftUIList

	var_3.align(var_56_0, #arg_56_0.fireworkAllIds)

	local var_56_1 = arg_56_0.rightUIList

	var_3.align(var_56_1, #arg_56_0.fireworkAllIds)

	return
end

function var_0_1.FireworkRightClick(arg_57_0, arg_57_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_57_0.fireworkOrderIds, arg_57_1)
	arg_57_0:SetFireWorkLocalData()

	local var_57_0 = arg_57_0.leftUIList

	var_2.align(var_57_0, #arg_57_0.fireworkAllIds)

	local var_57_1 = arg_57_0.rightUIList

	var_2.align(var_57_1, #arg_57_0.fireworkAllIds)

	return
end

function var_0_1.SetSpringPanel(arg_58_0)
	arg_58_0:CreateSpringUI()
	arg_58_0:UpdateSpringUI()

	return
end

function var_0_1.CreateSpringUI(arg_59_0)
	setText = var_1_10001

	local var_59_0 = arg_59_0.springPanel
	local var_59_1 = var_2.Find(var_59_0, "list/iconTpl/lock/Text")

	i18n = var_59_0

	var_1_10001(var_59_1, var_59_0("firework_2025_unlock_tip1"))

	UIItemList = var_1_10001

	local var_59_2 = var_1_10001.New
	local var_59_3 = arg_59_0.springPanel
	local var_59_4 = var_2.Find(var_59_3, "list")
	local var_59_5 = arg_59_0.springPanel

	arg_59_0.springList = var_59_2(var_59_4, var_3.Find(var_59_5, "list/iconTpl"))

	local var_59_6 = arg_59_0.springList

	var_1.make(var_59_6, function(arg_60_0, arg_60_1, arg_60_2)
		UIItemList = var_2_10003

		if arg_60_0 == var_2_10003.EventUpdate then
			local var_60_0 = arg_59_0.springShipIds[arg_60_1 + 1]
			local var_60_1 = arg_59_0.springSlotLockList[arg_60_1 + 1]
			local var_60_2 = var_60_0 and var_60_0 > 0

			setActive = var_2_10006

			var_2_10006(arg_60_2:Find("lock"), var_60_1)

			setActive = var_2_10006

			var_2_10006(arg_60_2:Find("add"), not var_60_1 and not var_60_2)

			setActive = var_2_10006

			var_2_10006(arg_60_2:Find("ship"), not var_60_1 and var_60_2)

			if var_60_1 then
				setText = var_2_10006

				local var_60_3 = arg_60_2
				local var_60_4 = arg_60_2.Find(var_60_3, "lock/taskText")

				i18n = var_60_3

				local var_60_5 = "firework_2025_unlock_tip2"
				local var_60_6 = arg_59_0.springActivity

				var_2_10010 = var_2_10010.getConfig(var_60_6, "config_client").unlockPt

				local var_60_7 = arg_60_1 + 1
				local var_60_8 = arg_59_0.springActivity

				var_2_10006(var_60_4, var_60_3(var_60_5, var_2_10010[var_60_7 - var_12.getConfig(var_60_8, "config_client").initialCount]))
			end

			onButton = var_2_10006

			local var_60_9 = arg_59_0
			local var_60_10 = arg_60_2

			local function var_60_11()
				if var_60_1 then
					return
				end

				local var_61_0

				if var_60_2 then
					getProxy = var_1
					BayProxy = var_3_10002

					local var_61_1 = var_1(var_3_10002)

					var_61_0 = var_1.getShipById(var_61_1, var_60_0)
				end

				local var_61_2 = arg_59_0.springUnlockSlotCount
				local var_61_3 = arg_59_0

				var_2.StopPlayFireworks(var_61_3)

				local var_61_4 = arg_59_0
				local var_61_5 = var_2.emit

				CoreActivityMainMediator = var_3_10004

				var_61_5(var_61_4, var_3_10004.OPEN_CHUANWU, arg_59_0.springActId, arg_60_1 + 1, var_61_0, arg_59_0.springUnlockSlotCount)

				return
			end

			SFX_PANEL = var_2_10010

			var_2_10006(var_60_9, var_60_10, var_60_11, var_2_10010)

			if not var_60_2 then
				return
			end

			getProxy = var_2_10006
			BayProxy = var_60_9

			local var_60_12 = var_2_10006(var_60_9)
			local var_60_13 = var_6.RawGetShipById(var_60_12, var_60_0)

			LoadSprite = var_60_12

			local var_60_14 = var_60_12("shipyardicon/" .. var_60_13:getPainting())

			setImageSprite = var_8

			var_8(arg_60_2:Find("ship/mask/icon"), var_60_14)

			setScrollText = var_8

			var_8(arg_60_2:Find("ship/name/Text"), var_60_13:getName())
		end

		return
	end)

	setText = var_1

	local var_59_7 = arg_59_0.springPanel
	local var_59_8 = var_2.Find(var_59_7, "tipText1")

	i18n = var_59_7

	var_1(var_59_8, var_59_7("firework_2025_tip2"))

	setText = var_1

	local var_59_9 = arg_59_0.springPanel

	var_1(var_2.Find(var_59_9, "tipText2"), "+" .. arg_59_0.energyRecoverAddition .. "/h")

	return
end

function var_0_1.UpdateSpringUI(arg_62_0)
	local var_62_0 = arg_62_0.springList

	var_1.align(var_62_0, arg_62_0.springMaxCnt)

	return
end

function var_0_1.UpdateSpringActivityAndUI(arg_63_0)
	arg_63_0:UpdateSpringData()
	arg_63_0:UpdateSpringUI()
	arg_63_0:clearStudents()
	arg_63_0:InitStudents()

	return
end

function var_0_1.PlayFireworks(arg_64_0)
	Clone = var_1_10001
	arg_64_0.fireworks = var_1_10001(arg_64_0.fireworkOrderIds)

	if #arg_64_0.fireworks == 0 then
		return
	end

	eachChild = var_1

	var_1(arg_64_0.fireworksTF, function(arg_65_0)
		setActive = var_2_10001

		var_2_10001(arg_65_0, false)

		return
	end)

	setActive = var_1

	var_1(arg_64_0.fireworksTF, true)
	arg_64_0:StopFireworksTimer()

	arg_64_0.fireworkIndex = 1
	Timer = var_1
	arg_64_0.fireworksTimer = var_1.New(function()
		local var_66_0 = arg_64_0

		var_0.PlayerOneFirework(var_66_0)

		return
	end, var_0_1.EffectInterval, #arg_64_0.fireworks)

	local var_64_0 = arg_64_0.fireworksTimer

	var_1.Start(var_64_0)

	return
end

function var_0_1.PlayerOneFirework(arg_67_0)
	if arg_67_0.fireworkIndex == #arg_67_0.fireworks then
		local var_67_0 = arg_67_0
		local var_67_1 = arg_67_0.managedTween

		LeanTween = var_1_10003

		var_67_1(var_67_0, var_1_10003.delayedCall, function()
			if arg_67_0.fireworks then
				local var_68_0 = arg_67_0

				var_0.StopPlayFireworks(var_68_0)

				local var_68_1 = arg_67_0

				var_0.PlayFireworks(var_68_1)
			end

			return
		end, var_0_1.DelayPop, nil)
	end

	local var_67_2 = arg_67_0.fireworks[arg_67_0.fireworkIndex]

	math = var_2

	local var_67_3 = var_2.random(#var_0_1.SFX_LIST)

	if arg_67_0.firePools[var_67_2] then
		local var_67_4 = #arg_67_0.firePools[var_67_2]

		if var_0_1.EffectPoolCnt <= var_67_4 then
			local var_67_5 = arg_67_0.firePools[var_67_2][1]

			setLocalPosition = var_4

			var_4(var_67_5, arg_67_0:GetFireworkPos())

			setActive = var_4

			var_4(var_67_5, true)

			pg = var_4

			local var_67_6 = var_4.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_67_6, var_0_1.SFX_LIST[var_67_3])

			table = var_4

			var_4.removebyvalue(arg_67_0.firePools[var_67_2], var_67_5)

			table = var_4

			var_4.insert(arg_67_0.firePools[var_67_2], var_67_5)

			goto label_67_0
		end
	end

	do
		local var_67_7 = arg_67_0.loader

		var_3.GetPrefab(var_67_7, "ui/" .. var_0_1.Id2EffectName[var_67_2], "", function(arg_69_0)
			pg = var_2_10001

			var_2_10001.ViewUtils.SetSortingOrder(arg_69_0, 1)

			setParent = var_1

			var_1(arg_69_0, arg_67_0.fireworksTF)

			setLocalPosition = var_1

			local var_69_0 = arg_69_0
			local var_69_1 = arg_67_0

			var_1(var_69_0, var_3.GetFireworkPos(var_69_1))

			setActive = var_1

			var_1(arg_69_0, true)

			pg = var_1

			local var_69_2 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_69_2, var_0_1.SFX_LIST[var_67_3])

			local var_69_3

			if not arg_67_0.firePools[var_67_2] then
				var_69_3 = arg_67_0.firePools
				var_69_3[var_67_2] = {}
			end

			table = var_69_3

			var_69_3.insert(arg_67_0.firePools[var_67_2], arg_69_0)

			return
		end)
	end

	::label_67_0::

	arg_67_0.fireworkIndex = arg_67_0.fireworkIndex + 1

	return
end

function var_0_1.GetFireworkPos(arg_70_0)
	Vector2 = var_1_10001

	local var_70_0 = var_1_10001(0, 0)
	local var_70_1

	if arg_70_0.lastPos then
		Vector2 = var_70_1
		var_70_1 = var_70_1(arg_70_0.lastPos.x, arg_70_0.lastPos.y)
		math = var_3

		local var_70_2 = var_3.abs(var_70_1.x - arg_70_0.lastPos.x)

		math = var_4

		local var_70_3 = var_4.abs(var_70_1.y - arg_70_0.lastPos.y)

		while var_70_2 < var_0_1.FireworkRange.x / 2 and var_70_3 < var_0_1.FireworkRange.y or var_70_3 < var_0_1.FireworkRange.y / 2 and var_70_2 < var_0_1.FireworkRange.x do
			math = var_5
			var_70_1.x = var_5.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
			math = var_5
			var_70_1.y = var_5.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
			math = var_5
			var_70_2 = var_5.abs(var_70_1.x - arg_70_0.lastPos.x)
			math = var_5
			var_70_3 = var_5.abs(var_70_1.y - arg_70_0.lastPos.y)
		end

		var_70_0 = var_70_1
	else
		math = var_70_1
		var_70_0.x = var_70_1.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
		math = var_2
		var_70_0.y = var_2.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
	end

	arg_70_0.lastPos = var_70_0

	return var_70_0
end

function var_0_1.StopFireworksTimer(arg_71_0)
	if arg_71_0.fireworksTimer then
		local var_71_0 = arg_71_0.fireworksTimer

		var_1.Stop(var_71_0)

		arg_71_0.fireworksTimer = nil
	end

	return
end

function var_0_1.StopPlayFireworks(arg_72_0)
	arg_72_0:StopFireworksTimer()

	arg_72_0.fireworks = nil
	arg_72_0.fireworkIndex = nil
	setActive = var_1

	var_1(arg_72_0.fireworksTF, false)

	return
end

function var_0_1.getStudents(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = {}
	local var_73_1 = {}

	if not arg_73_0.springActivity then
		return var_73_0
	end

	local var_73_2 = arg_73_0.springActivity
	local var_73_3 = var_5.GetShipIds(var_73_2)

	for iter_73_0 = 1, arg_73_0.springMaxCnt do
		if var_73_3[iter_73_0] and var_73_3[iter_73_0] ~= 0 then
			getProxy = var_10
			BayProxy = var_1_10011
			var_1_10011 = var_10(var_1_10011)

			if var_10.RawGetShipById(var_1_10011, var_73_3[iter_73_0]) then
				table = var_1_10011

				var_1_10011.insert(var_73_1, var_10)
			end
		end
	end

	if not arg_73_1 or not arg_73_2 then
		arg_73_1 = #var_73_1
		arg_73_2 = #var_73_1
	end

	math = var_6

	local var_73_4 = var_6.random(arg_73_1, arg_73_2)
	local var_73_5 = #var_73_1

	while var_73_4 > 0 and 0 < var_73_5 do
		math = var_73_6

		local var_73_6 = var_73_6.random(1, var_73_5)

		table = var_9

		local var_73_7 = var_9.insert
		local var_73_8 = var_73_0
		local var_73_9 = var_73_1[var_73_6]

		var_73_7(var_73_8, var_11.getPrefab(var_73_9))

		var_73_1[var_73_6] = var_73_1[var_73_5]
		var_73_5 = var_73_5 - 1
		var_73_4 = var_73_4 - 1
	end

	return var_73_0
end

function var_0_1.InitStudents(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_0:getStudents(arg_74_1, arg_74_2)
	local var_74_1 = {}

	pairs = var_5

	for iter_74_0, iter_74_1 in var_5(arg_74_0.graphPath.points) do
		if not iter_74_1.outRandom then
			table = var_10

			var_10.insert(var_74_1, iter_74_1)
		end
	end

	local var_74_2 = #var_74_1

	arg_74_0.academyStudents = {}

	local var_74_3 = {}

	pairs = var_7

	for iter_74_2, iter_74_3 in var_7(var_74_0) do
		if not arg_74_0.academyStudents[iter_74_2] then
			cloneTplTo = var_12
			var_12(arg_74_0._shipTpl, arg_74_0._map).gameObject.name = iter_74_2

			local var_74_4 = arg_74_0:ChooseRandomPos(var_74_1, var_74_2)

			var_74_2 = (var_74_2 - 2) % #var_74_1 + 1
			SummerFeastNavigationAgent = var_14

			local var_74_5 = var_14.New(var_12.gameObject)

			var_74_5.normalSpeed = 100

			var_74_5:attach()
			var_74_5:setPathFinder(arg_74_0.graphPath)
			var_74_5:SetPositionTable(var_74_3)
			var_74_5:setCurrentIndex(var_74_4 and var_74_4.id)
			var_74_5:SetOnTransEdge(function(arg_75_0, arg_75_1, arg_75_2)
				math = var_2_10003

				local var_75_0 = var_2_10003.min(arg_75_1, arg_75_2)

				math = var_4
				arg_75_2 = var_4.max(arg_75_1, arg_75_2)
				arg_75_1 = var_75_0

				local var_75_1 = arg_74_0
				local var_75_2

				if not arg_74_0.edge2area[arg_75_1 .. "_" .. arg_75_2] then
					var_75_2 = arg_74_0.edge2area.default
				end

				local var_75_3 = var_75_1[var_75_2]
				local var_75_4 = arg_75_0._tf

				var_4.SetParent(var_75_4, var_75_3)

				return
			end)
			var_74_5:updateStudent(iter_74_3)

			arg_74_0.academyStudents[iter_74_2] = var_74_5
		end
	end

	if #var_74_0 > 0 then
		Timer = var_7
		arg_74_0.sortTimer = var_7.New(function()
			local var_76_0 = arg_74_0

			var_0.sortStudents(var_76_0)

			return
		end, 0.2, -1)

		local var_74_6 = arg_74_0.sortTimer

		var_7.Start(var_74_6)
		arg_74_0.sortTimer.func()
	end

	return
end

function var_0_1.ChooseRandomPos(arg_77_0, arg_77_1, arg_77_2)
	math = var_1_10003

	if not var_1_10003.random(1, arg_77_2) then
		return nil
	end

	pg = var_4

	var_4.Tool.Swap(arg_77_1, var_3, arg_77_2)

	return arg_77_1[arg_77_2]
end

function var_0_1.SetTips(arg_78_0)
	arg_78_0:SetPtTip()
	arg_78_0:SetTaskTip()
	arg_78_0:SetFireworkTip()
	arg_78_0:SetSpringTip()

	return
end

function var_0_1.SetPtTip(arg_79_0)
	local var_79_0 = arg_79_0.ptData
	local var_79_1 = var_1.CanGetAward(var_79_0)

	setActive = var_79_0

	local var_79_2 = arg_79_0.ptBtn

	var_79_0(var_3.Find(var_79_2, "tip"), var_79_1)

	setActive = var_79_0

	local var_79_3 = arg_79_0.subPtBtn

	var_79_0(var_3.Find(var_79_3, "tip"), var_79_1)

	return
end

function var_0_1.SetTaskTip(arg_80_0)
	local var_80_0 = arg_80_0.canGetTaskAward

	setActive = var_1_10002

	local var_80_1 = arg_80_0.taskBtn

	var_1_10002(var_3.Find(var_80_1, "tip"), var_80_0)

	setActive = var_1_10002

	local var_80_2 = arg_80_0.subTaskBtn

	var_1_10002(var_3.Find(var_80_2, "tip"), var_80_0)

	return
end

function var_0_1.SetFireworkTip(arg_81_0)
	local var_81_0 = #arg_81_0.fireworkUnlockIds ~= #arg_81_0.fireworkGotIds

	setActive = var_2

	local var_81_1 = arg_81_0.fireworkBtn

	var_2(var_3.Find(var_81_1, "tip"), var_81_0)

	setActive = var_2

	local var_81_2 = arg_81_0.subFireworkBtn

	var_2(var_3.Find(var_81_2, "tip"), var_81_0)

	return
end

function var_0_1.SetSpringTip(arg_82_0)
	local var_82_0 = false

	for iter_82_0 = 1, arg_82_0.springUnlockSlotCount do
		if arg_82_0.springShipIds[iter_82_0] == 0 then
			var_82_0 = true

			break
		end
	end

	setActive = var_2

	local var_82_1 = arg_82_0.springBtn

	var_2(var_3.Find(var_82_1, "tip"), var_82_0)

	setActive = var_2

	local var_82_2 = arg_82_0.subSpringBtn

	var_2(var_3.Find(var_82_2, "tip"), var_82_0)

	return
end

function var_0_1.OnDestroy(arg_83_0)
	arg_83_0:CloseSubPanel()
	arg_83_0:StopPlayFireworks()
	arg_83_0:clearStudents()
	var_0_1.super.OnDestroy(arg_83_0)

	return
end

return var_0_1
