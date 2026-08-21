local var_0_0 = class("WSMapRight", import("...BaseEntity"))

var_0_0.Fields = {
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
var_0_0.Listeners = {
	onUpdateFleetBuff = "OnUpdateFleetBuff",
	onClearLog = "OnClearLog",
	onAppendLog = "OnAppendLog",
	onUpdateFleetLocation = "OnUpdateFleetLocation",
	onUpdateFleetDefeat = "OnUpdateFleetDefeat",
	onUpdateInfoBtnTip = "OnUpdateInfoBtnTip",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function var_0_0.Setup(arg_1_0)
	pg.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.wsCompass:Dispose()
	arg_2_0:RemoveFleetListener(arg_2_0.fleet)
	arg_2_0:RemoveMapListener()

	if arg_2_0.taskProxy then
		arg_2_0.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateTask, arg_2_0.onUpdateInfoBtnTip)

		arg_2_0.taskProxy = nil
	end

	pg.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rtCompassPanel = arg_3_0.transform:Find("compass_panel")
	arg_3_0.btnOrder = arg_3_0.rtCompassPanel:Find("btn_order")
	arg_3_0.btnScan = arg_3_0.rtCompassPanel:Find("btn_scan")
	arg_3_0.btnDefeat = arg_3_0.rtCompassPanel:Find("btn_defeat")
	arg_3_0.btnDetail = arg_3_0.rtCompassPanel:Find("btn_detail")
	arg_3_0.toggleSkipPrecombat = arg_3_0.transform:Find("btn_list/lock_fleet")

	onToggle(arg_3_0, arg_3_0.toggleSkipPrecombat, function(arg_4_0)
		PlayerPrefs.SetInt("world_skip_precombat", arg_4_0 and 1 or 0)

		return
	end, SFX_PANEL)

	arg_3_0.toggleAutoFight = arg_3_0.transform:Find("btn_list/auto_fight")
	arg_3_0.toggleAutoSwitch = arg_3_0.transform:Find("btn_list/auto_switch")
	arg_3_0.btnInventory = arg_3_0.transform:Find("btn_list/dock/inventory_button")
	arg_3_0.btnInformation = arg_3_0.transform:Find("btn_list/dock/information_button")
	arg_3_0.btnTransport = arg_3_0.transform:Find("btn_list/dock/transport_button")
	arg_3_0.btnHelp = arg_3_0.transform:Find("btn_list/dock/help_button")
	arg_3_0.btnPort = arg_3_0.transform:Find("btn_list/dock/port_button")

	setActive(arg_3_0.btnPort, false)

	arg_3_0.btnExit = arg_3_0.transform:Find("btn_list/dock/exit_button")

	setActive(arg_3_0.btnExit, false)

	arg_3_0.wsCompass = WSCompass.New()
	arg_3_0.wsCompass.tf = arg_3_0.rtCompassPanel:Find("ring/compass")
	arg_3_0.wsCompass.pool = arg_3_0.wsPool

	arg_3_0.wsCompass:Setup()

	arg_3_0.rtTipWord = arg_3_0.transform:Find("tip_word")
	arg_3_0.taskProxy = nowWorld():GetTaskProxy()

	arg_3_0.taskProxy:AddListener(WorldTaskProxy.EventUpdateTask, arg_3_0.onUpdateInfoBtnTip)

	return
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2)
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

function var_0_0.AddMapListener(arg_6_0)
	if arg_6_0.map then
		arg_6_0.map:AddListener(WorldMap.EventUpdateFIndex, arg_6_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_0.RemoveMapListener(arg_7_0)
	if arg_7_0.map then
		arg_7_0.map:RemoveListener(WorldMap.EventUpdateFIndex, arg_7_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_0.AddFleetListener(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_1:AddListener(WorldMapFleet.EventUpdateLocation, arg_8_0.onUpdateFleetLocation)
		arg_8_1:AddListener(WorldMapFleet.EventUpdateBuff, arg_8_0.onUpdateFleetBuff)
		arg_8_1:AddListener(WorldMapFleet.EventUpdateDefeat, arg_8_0.onUpdateFleetDefeat)
	end

	return
end

function var_0_0.RemoveFleetListener(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_1:RemoveListener(WorldMapFleet.EventUpdateLocation, arg_9_0.onUpdateFleetLocation)
		arg_9_1:RemoveListener(WorldMapFleet.EventUpdateBuff, arg_9_0.onUpdateFleetBuff)
		arg_9_1:RemoveListener(WorldMapFleet.EventUpdateDefeat, arg_9_0.onUpdateFleetDefeat)
	end

	return
end

function var_0_0.OnUpdateSelectedFleet(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.map:GetFleet()

	if not arg_10_1 or arg_10_0.fleet ~= var_10_0 then
		arg_10_0:RemoveFleetListener(arg_10_0.fleet)

		arg_10_0.fleet = var_10_0

		arg_10_0:AddFleetListener(arg_10_0.fleet)
		arg_10_0:UpdateCompassRotation(var_10_0)
		arg_10_0:OnUpdateFleetLocation()
		arg_10_0:OnUpdateFleetBuff()
		arg_10_0:OnUpdateFleetDefeat()
	end

	return
end

function var_0_0.OnUpdateFleetLocation(arg_11_0)
	if not arg_11_0.map.active then
		return
	end

	arg_11_0:UpdateCompassMarks()

	return
end

function var_0_0.OnUpdateFleetBuff(arg_12_0)
	setActive(arg_12_0.wsCompass.tf, #arg_12_0.fleet:GetBuffsByTrap(WorldBuff.TrapCompassInterference) == 0)

	return
end

function var_0_0.OnUpdateFleetDefeat(arg_13_0)
	setText(arg_13_0.btnDefeat:Find("Text"), math.min(arg_13_0.fleet:getDefeatCount(), 99))

	return
end

function var_0_0.UpdateCompass(arg_14_0)
	arg_14_0:UpdateCompassMarks()
	arg_14_0:UpdateCompassRotation((arg_14_0.map:GetFleet()))

	return
end

function var_0_0.UpdateCompossView(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.wsCompass:UpdateByViewer(arg_15_0.map, arg_15_1, arg_15_2)

	return
end

function var_0_0.UpdateCompassRotation(arg_16_0, arg_16_1)
	arg_16_0.wsCompass:UpdateCompassRotation(arg_16_1)

	return
end

function var_0_0.UpdateCompassMarks(arg_17_0)
	arg_17_0.wsCompass:ClearMarks()
	arg_17_0.wsCompass:Update(arg_17_0.entrance, arg_17_0.map)

	return
end

function var_0_0.OnUpdateEventTips(arg_18_0)
	local var_18_0, var_18_1 = arg_18_0.map:GetEventTipWord()

	if arg_18_0.tipEventPri ~= var_18_1 then
		setActive(arg_18_0.rtTipWord, false)

		arg_18_0.tipEventPri = var_18_1
	end

	setActive(arg_18_0.rtTipWord, var_18_1 > 0)

	if var_18_1 > 0 then
		setText(arg_18_0.rtTipWord:Find("Text"), var_18_0)
	end

	return
end

function var_0_0.UpdateBtns(arg_19_0)
	local var_19_0 = arg_19_0.map:GetPort()

	setActive(arg_19_0.btnPort, var_19_0 and not var_19_0:IsTempPort())
	setActive(arg_19_0.btnExit, arg_19_0.map:canExit())

	return
end

function var_0_0.OnUpdateInfoBtnTip(arg_20_0)
	setActive(arg_20_0.btnInformation:Find("tip"), (_.any(arg_20_0.taskProxy:getTaskVOs(), function(arg_21_0)
		return arg_21_0:getState() == WorldTask.STATE_FINISHED
	end)))

	return
end

function var_0_0.OnUpdateHelpBtnTip(arg_22_0, arg_22_1)
	setActive(arg_22_0.btnHelp:Find("imge/tip"), WorldConst.IsWorldHelpNew(nowWorld():GetProgress(), arg_22_1))

	return
end

return var_0_0
