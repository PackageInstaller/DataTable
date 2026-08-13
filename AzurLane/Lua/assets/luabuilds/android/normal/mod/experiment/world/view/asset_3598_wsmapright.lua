class = var_0_10000

local var_0_0 = "WSMapRight"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	map = "table",
	btnPort = "userdata",
	btnInventory = "userdata",
	btnHelp = "userdata",
	rtTipWord = "userdata",
	btnDetail = "userdata",
	tipEventPri = "number",
	btnScan = "userdata",
	toggleSkipPrecombat = "userdata",
	world = "table",
	btnInformation = "userdata",
	toggleAutoFight = "userdata",
	toggleAutoSwitch = "userdata",
	entrance = "table",
	btnTransport = "userdata",
	gid = "number",
	fleet = "table",
	btnDefeat = "userdata",
	btnExit = "userdata",
	transform = "userdata",
	wsCompass = "table",
	btnOrder = "userdata",
	taskProxy = "table",
	rtCompassPanel = "userdata",
	wsTimer = "table",
	wsPool = "table"
}
var_0_1.Listeners = {
	onUpdateFleetBuff = "OnUpdateFleetBuff",
	onClearLog = "OnClearLog",
	onAppendLog = "OnAppendLog",
	onUpdateFleetLocation = "OnUpdateFleetLocation",
	onUpdateFleetDefeat = "OnUpdateFleetDefeat",
	onUpdateInfoBtnTip = "OnUpdateInfoBtnTip",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function var_0_1.Setup(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	local var_2_0 = arg_2_0.wsCompass

	var_1.Dispose(var_2_0)
	arg_2_0:RemoveFleetListener(arg_2_0.fleet)
	arg_2_0:RemoveMapListener()

	local var_2_2

	if arg_2_0.taskProxy then
		local var_2_1 = arg_2_0.taskProxy

		var_2_2 = var_2_2.RemoveListener
		WorldTaskProxy = var_3

		var_2_2(var_2_1, var_3.EventUpdateTask, arg_2_0.onUpdateInfoBtnTip)

		arg_2_0.taskProxy = nil
	end

	pg = var_2_2

	var_2_2.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.transform

	arg_3_0.rtCompassPanel = var_1.Find(var_3_0, "compass_panel")

	local var_3_1 = arg_3_0.rtCompassPanel

	arg_3_0.btnOrder = var_2.Find(var_3_1, "btn_order")

	local var_3_2 = arg_3_0.rtCompassPanel

	arg_3_0.btnScan = var_2.Find(var_3_2, "btn_scan")

	local var_3_3 = arg_3_0.rtCompassPanel

	arg_3_0.btnDefeat = var_2.Find(var_3_3, "btn_defeat")

	local var_3_4 = arg_3_0.rtCompassPanel

	arg_3_0.btnDetail = var_2.Find(var_3_4, "btn_detail")
	arg_3_0.toggleSkipPrecombat = var_1:Find("btn_list/lock_fleet")
	onToggle = var_2

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.toggleSkipPrecombat

	local function var_3_7(arg_4_0)
		PlayerPrefs = var_2_10001

		var_2_10001.SetInt("world_skip_precombat", arg_4_0 and 1 or 0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_5, var_3_6, var_3_7, var_1_10006)

	arg_3_0.toggleAutoFight = var_1:Find("btn_list/auto_fight")
	arg_3_0.toggleAutoSwitch = var_1:Find("btn_list/auto_switch")
	arg_3_0.btnInventory = var_1:Find("btn_list/dock/inventory_button")
	arg_3_0.btnInformation = var_1:Find("btn_list/dock/information_button")
	arg_3_0.btnTransport = var_1:Find("btn_list/dock/transport_button")
	arg_3_0.btnHelp = var_1:Find("btn_list/dock/help_button")
	arg_3_0.btnPort = var_1:Find("btn_list/dock/port_button")
	setActive = var_2

	var_2(arg_3_0.btnPort, false)

	arg_3_0.btnExit = var_1:Find("btn_list/dock/exit_button")
	setActive = var_2

	var_2(arg_3_0.btnExit, false)

	WSCompass = var_2
	arg_3_0.wsCompass = var_2.New()

	local var_3_8 = arg_3_0.wsCompass
	local var_3_9 = arg_3_0.rtCompassPanel

	var_3_8.tf = var_3.Find(var_3_9, "ring/compass")
	arg_3_0.wsCompass.pool = arg_3_0.wsPool

	local var_3_10 = arg_3_0.wsCompass

	var_2.Setup(var_3_10)

	arg_3_0.rtTipWord = var_1:Find("tip_word")
	nowWorld = var_2

	local var_3_11 = var_2()

	arg_3_0.taskProxy = var_2.GetTaskProxy(var_3_11)

	local var_3_12 = arg_3_0.taskProxy
	local var_3_13 = var_2.AddListener

	WorldTaskProxy = var_4

	var_3_13(var_3_12, var_4.EventUpdateTask, arg_3_0.onUpdateInfoBtnTip)

	return
end

function var_0_1.Update(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.entrance ~= arg_5_1 or arg_5_0.map ~= arg_5_2 or arg_5_0.gid ~= arg_5_2.gid then
		arg_5_0:RemoveMapListener()

		arg_5_0.entrance = arg_5_1
		arg_5_0.map = arg_5_2
		arg_5_0.gid = arg_5_2.gid

		arg_5_0:AddMapListener()
		arg_5_0:OnUpdateSelectedFleet()
		arg_5_0:UpdateCompass()
		arg_5_0:UpdateBtns()
		arg_5_0:OnUpdateEventTips()
	end

	return
end

function var_0_1.AddMapListener(arg_6_0)
	if arg_6_0.map then
		local var_6_0 = arg_6_0.map
		local var_6_1 = var_1.AddListener

		WorldMap = var_1_10003

		var_6_1(var_6_0, var_1_10003.EventUpdateFIndex, arg_6_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.RemoveMapListener(arg_7_0)
	if arg_7_0.map then
		local var_7_0 = arg_7_0.map
		local var_7_1 = var_1.RemoveListener

		WorldMap = var_1_10003

		var_7_1(var_7_0, var_1_10003.EventUpdateFIndex, arg_7_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.AddFleetListener(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = arg_8_1
		local var_8_1 = arg_8_1.AddListener

		WorldMapFleet = var_1_10004

		var_8_1(var_8_0, var_1_10004.EventUpdateLocation, arg_8_0.onUpdateFleetLocation)

		local var_8_2 = arg_8_1
		local var_8_3 = arg_8_1.AddListener

		WorldMapFleet = var_4

		var_8_3(var_8_2, var_4.EventUpdateBuff, arg_8_0.onUpdateFleetBuff)

		local var_8_4 = arg_8_1
		local var_8_5 = arg_8_1.AddListener

		WorldMapFleet = var_4

		var_8_5(var_8_4, var_4.EventUpdateDefeat, arg_8_0.onUpdateFleetDefeat)
	end

	return
end

function var_0_1.RemoveFleetListener(arg_9_0, arg_9_1)
	if arg_9_1 then
		local var_9_0 = arg_9_1
		local var_9_1 = arg_9_1.RemoveListener

		WorldMapFleet = var_1_10004

		var_9_1(var_9_0, var_1_10004.EventUpdateLocation, arg_9_0.onUpdateFleetLocation)

		local var_9_2 = arg_9_1
		local var_9_3 = arg_9_1.RemoveListener

		WorldMapFleet = var_4

		var_9_3(var_9_2, var_4.EventUpdateBuff, arg_9_0.onUpdateFleetBuff)

		local var_9_4 = arg_9_1
		local var_9_5 = arg_9_1.RemoveListener

		WorldMapFleet = var_4

		var_9_5(var_9_4, var_4.EventUpdateDefeat, arg_9_0.onUpdateFleetDefeat)
	end

	return
end

function var_0_1.OnUpdateSelectedFleet(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.map
	local var_10_1 = var_2.GetFleet(var_10_0)

	if not arg_10_1 or arg_10_0.fleet ~= var_10_1 then
		arg_10_0:RemoveFleetListener(arg_10_0.fleet)

		arg_10_0.fleet = var_10_1

		arg_10_0:AddFleetListener(arg_10_0.fleet)
		arg_10_0:UpdateCompassRotation(var_10_1)
		arg_10_0:OnUpdateFleetLocation()
		arg_10_0:OnUpdateFleetBuff()
		arg_10_0:OnUpdateFleetDefeat()
	end

	return
end

function var_0_1.OnUpdateFleetLocation(arg_11_0)
	if not arg_11_0.map.active then
		return
	end

	arg_11_0:UpdateCompassMarks()

	return
end

function var_0_1.OnUpdateFleetBuff(arg_12_0)
	setActive = var_1_10001

	local var_12_0 = arg_12_0.wsCompass.tf
	local var_12_1 = arg_12_0.fleet
	local var_12_2 = var_3.GetBuffsByTrap

	WorldBuff = var_1_10005

	var_1_10001(var_12_0, #var_12_2(var_12_1, var_1_10005.TrapCompassInterference) == 0)

	return
end

function var_0_1.OnUpdateFleetDefeat(arg_13_0)
	setText = var_1_10001

	local var_13_0 = arg_13_0.btnDefeat
	local var_13_1 = var_2.Find(var_13_0, "Text")

	math = var_13_0

	local var_13_2 = var_13_0.min
	local var_13_3 = arg_13_0.fleet

	var_1_10001(var_13_1, var_13_2(var_4.getDefeatCount(var_13_3), 99))

	return
end

function var_0_1.UpdateCompass(arg_14_0)
	local var_14_0 = arg_14_0.map
	local var_14_1 = var_1.GetFleet(var_14_0)

	arg_14_0:UpdateCompassMarks()
	arg_14_0:UpdateCompassRotation(var_14_1)

	return
end

function var_0_1.UpdateCompossView(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.map
	local var_15_1 = arg_15_0.wsCompass

	var_4.UpdateByViewer(var_15_1, var_15_0, arg_15_1, arg_15_2)

	return
end

function var_0_1.UpdateCompassRotation(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.wsCompass

	var_2.UpdateCompassRotation(var_16_0, arg_16_1)

	return
end

function var_0_1.UpdateCompassMarks(arg_17_0)
	local var_17_0 = arg_17_0.wsCompass

	var_1.ClearMarks(var_17_0)

	local var_17_1 = arg_17_0.wsCompass

	var_1.Update(var_17_1, arg_17_0.entrance, arg_17_0.map)

	return
end

function var_0_1.OnUpdateEventTips(arg_18_0)
	local var_18_0 = arg_18_0.map
	local var_18_1, var_18_2 = var_1.GetEventTipWord(var_18_0)

	if arg_18_0.tipEventPri ~= var_18_2 then
		setActive = var_3

		var_3(arg_18_0.rtTipWord, false)

		arg_18_0.tipEventPri = var_18_2
	end

	setActive = var_3

	var_3(arg_18_0.rtTipWord, var_18_2 > 0)

	if 0 < var_18_2 then
		setText = var_3

		local var_18_3 = arg_18_0.rtTipWord

		var_3(var_4.Find(var_18_3, "Text"), var_18_1)
	end

	return
end

function var_0_1.UpdateBtns(arg_19_0)
	local var_19_0 = arg_19_0.map
	local var_19_1 = var_1.GetPort(var_19_0)

	setActive = var_19_0

	var_19_0(arg_19_0.btnPort, var_19_1 and not var_19_1:IsTempPort())

	setActive = var_19_0

	local var_19_2 = arg_19_0.btnExit
	local var_19_3 = arg_19_0.map

	var_19_0(var_19_2, var_4.canExit(var_19_3))

	return
end

function var_0_1.OnUpdateInfoBtnTip(arg_20_0)
	_ = var_1_10001

	local var_20_0 = var_1_10001.any
	local var_20_1 = arg_20_0.taskProxy
	local var_20_2 = var_20_0(var_2.getTaskVOs(var_20_1), function(arg_21_0)
		local var_21_0 = arg_21_0
		local var_21_1 = arg_21_0.getState(var_21_0)

		WorldTask = var_21_0

		return var_21_1 == var_21_0.STATE_FINISHED
	end)

	setActive = var_2

	local var_20_3 = arg_20_0.btnInformation

	var_2(var_3.Find(var_20_3, "tip"), var_20_2)

	return
end

function var_0_1.OnUpdateHelpBtnTip(arg_22_0, arg_22_1)
	nowWorld = var_1_10002

	local var_22_0 = var_1_10002()
	local var_22_1 = var_2.GetProgress(var_22_0)

	setActive = var_22_0

	local var_22_2 = arg_22_0.btnHelp
	local var_22_3 = var_4.Find(var_22_2, "imge/tip")

	WorldConst = var_22_2

	var_22_0(var_22_3, var_22_2.IsWorldHelpNew(var_22_1, arg_22_1))

	return
end

return var_0_1
