local WSMapRight = class("WSMapRight", import("...BaseEntity"))

WSMapRight.Fields = {
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
WSMapRight.Listeners = {
	onUpdateFleetBuff = "OnUpdateFleetBuff",
	onClearLog = "OnClearLog",
	onAppendLog = "OnAppendLog",
	onUpdateFleetLocation = "OnUpdateFleetLocation",
	onUpdateFleetDefeat = "OnUpdateFleetDefeat",
	onUpdateInfoBtnTip = "OnUpdateInfoBtnTip",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function WSMapRight:Setup()
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSMapRight:Dispose()
	self.wsCompass:Dispose()
	self:RemoveFleetListener(self.fleet)
	self:RemoveMapListener()

	if self.taskProxy then
		self.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateTask, self.onUpdateInfoBtnTip)

		self.taskProxy = nil
	end

	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSMapRight:Init()
	self.rtCompassPanel = self.transform:Find("compass_panel")
	self.btnOrder = self.rtCompassPanel:Find("btn_order")
	self.btnScan = self.rtCompassPanel:Find("btn_scan")
	self.btnDefeat = self.rtCompassPanel:Find("btn_defeat")
	self.btnDetail = self.rtCompassPanel:Find("btn_detail")
	self.toggleSkipPrecombat = self.transform:Find("btn_list/lock_fleet")

	onToggle(self, self.toggleSkipPrecombat, function(arg_4_0)
		PlayerPrefs.SetInt("world_skip_precombat", arg_4_0 and 1 or 0)

		return
	end, SFX_PANEL)

	self.toggleAutoFight = self.transform:Find("btn_list/auto_fight")
	self.toggleAutoSwitch = self.transform:Find("btn_list/auto_switch")
	self.btnInventory = self.transform:Find("btn_list/dock/inventory_button")
	self.btnInformation = self.transform:Find("btn_list/dock/information_button")
	self.btnTransport = self.transform:Find("btn_list/dock/transport_button")
	self.btnHelp = self.transform:Find("btn_list/dock/help_button")
	self.btnPort = self.transform:Find("btn_list/dock/port_button")

	setActive(self.btnPort, false)

	self.btnExit = self.transform:Find("btn_list/dock/exit_button")

	setActive(self.btnExit, false)

	self.wsCompass = WSCompass.New()
	self.wsCompass.tf = self.rtCompassPanel:Find("ring/compass")
	self.wsCompass.pool = self.wsPool

	self.wsCompass:Setup()

	self.rtTipWord = self.transform:Find("tip_word")
	self.taskProxy = nowWorld():GetTaskProxy()

	self.taskProxy:AddListener(WorldTaskProxy.EventUpdateTask, self.onUpdateInfoBtnTip)

	return
end

function WSMapRight:Update(arg_5_1, arg_5_2)
	if self.entrance ~= arg_5_1 or self.map ~= arg_5_2 or self.gid ~= arg_5_2.gid then
		self:RemoveMapListener()

		self.entrance = arg_5_1
		self.map = arg_5_2
		self.gid = arg_5_2.gid

		self:AddMapListener()
		self:OnUpdateSelectedFleet()
		self:UpdateCompass()
		self:UpdateBtns()
		self:OnUpdateEventTips()
	end

	return
end

function WSMapRight:AddMapListener()
	if self.map then
		self.map:AddListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSMapRight:RemoveMapListener()
	if self.map then
		self.map:RemoveListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSMapRight:AddFleetListener(arg_8_1)
	if arg_8_1 then
		arg_8_1:AddListener(WorldMapFleet.EventUpdateLocation, self.onUpdateFleetLocation)
		arg_8_1:AddListener(WorldMapFleet.EventUpdateBuff, self.onUpdateFleetBuff)
		arg_8_1:AddListener(WorldMapFleet.EventUpdateDefeat, self.onUpdateFleetDefeat)
	end

	return
end

function WSMapRight:RemoveFleetListener(arg_9_1)
	if arg_9_1 then
		arg_9_1:RemoveListener(WorldMapFleet.EventUpdateLocation, self.onUpdateFleetLocation)
		arg_9_1:RemoveListener(WorldMapFleet.EventUpdateBuff, self.onUpdateFleetBuff)
		arg_9_1:RemoveListener(WorldMapFleet.EventUpdateDefeat, self.onUpdateFleetDefeat)
	end

	return
end

function WSMapRight:OnUpdateSelectedFleet(arg_10_1)
	local var_10_0 = self.map:GetFleet()

	if not arg_10_1 or self.fleet ~= var_10_0 then
		self:RemoveFleetListener(self.fleet)

		self.fleet = var_10_0

		self:AddFleetListener(self.fleet)
		self:UpdateCompassRotation(var_10_0)
		self:OnUpdateFleetLocation()
		self:OnUpdateFleetBuff()
		self:OnUpdateFleetDefeat()
	end

	return
end

function WSMapRight:OnUpdateFleetLocation()
	if not self.map.active then
		return
	end

	self:UpdateCompassMarks()

	return
end

function WSMapRight:OnUpdateFleetBuff()
	setActive(self.wsCompass.tf, #self.fleet:GetBuffsByTrap(WorldBuff.TrapCompassInterference) == 0)

	return
end

function WSMapRight:OnUpdateFleetDefeat()
	setText(self.btnDefeat:Find("Text"), math.min(self.fleet:getDefeatCount(), 99))

	return
end

function WSMapRight:UpdateCompass()
	self:UpdateCompassMarks()
	self:UpdateCompassRotation((self.map:GetFleet()))

	return
end

function WSMapRight:UpdateCompossView(arg_15_1, arg_15_2)
	self.wsCompass:UpdateByViewer(self.map, arg_15_1, arg_15_2)

	return
end

function WSMapRight:UpdateCompassRotation(arg_16_1)
	self.wsCompass:UpdateCompassRotation(arg_16_1)

	return
end

function WSMapRight:UpdateCompassMarks()
	self.wsCompass:ClearMarks()
	self.wsCompass:Update(self.entrance, self.map)

	return
end

function WSMapRight:OnUpdateEventTips()
	local var_18_0, var_18_1 = self.map:GetEventTipWord()

	if self.tipEventPri ~= var_18_1 then
		setActive(self.rtTipWord, false)

		self.tipEventPri = var_18_1
	end

	setActive(self.rtTipWord, var_18_1 > 0)

	if var_18_1 > 0 then
		setText(self.rtTipWord:Find("Text"), var_18_0)
	end

	return
end

function WSMapRight:UpdateBtns()
	local var_19_0 = self.map:GetPort()

	setActive(self.btnPort, var_19_0 and not var_19_0:IsTempPort())
	setActive(self.btnExit, self.map:canExit())

	return
end

function WSMapRight:OnUpdateInfoBtnTip()
	setActive(self.btnInformation:Find("tip"), (_.any(self.taskProxy:getTaskVOs(), function(arg_21_0)
		return arg_21_0:getState() == WorldTask.STATE_FINISHED
	end)))

	return
end

function WSMapRight:OnUpdateHelpBtnTip(arg_22_1)
	setActive(self.btnHelp:Find("imge/tip"), WorldConst.IsWorldHelpNew(nowWorld():GetProgress(), arg_22_1))

	return
end

return WSMapRight
