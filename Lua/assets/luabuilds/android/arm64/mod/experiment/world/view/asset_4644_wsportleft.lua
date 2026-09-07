local WSPortLeft = class("WSPortLeft", import("...BaseEntity"))

WSPortLeft.Fields = {
	map = "table",
	rtFleet = "userdata",
	rtVanguard = "userdata",
	gid = "number",
	rtShip = "userdata",
	transform = "userdata",
	fleet = "table",
	rtMain = "userdata",
	rtBG = "userdata"
}
WSPortLeft.Listeners = {
	onUpdateShip = "OnUpdateShip",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function WSPortLeft:Setup()
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSPortLeft:Dispose()
	self:RemoveMapListener()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSPortLeft:Init()
	self.rtBG = self.transform:Find("bg")
	self.rtFleet = self.rtBG:Find("fleet")
	self.rtMain = self.rtFleet:Find("main")
	self.rtVanguard = self.rtFleet:Find("vanguard")
	self.rtShip = self.rtFleet:Find("shiptpl")

	setActive(self.rtShip, false)

	return
end

function WSPortLeft:UpdateMap(arg_4_1)
	if self.map ~= arg_4_1 or self.gid ~= arg_4_1.gid then
		self:RemoveMapListener()

		self.map = arg_4_1
		self.gid = arg_4_1.gid

		self:AddMapListener()
		self:OnUpdateSelectedFleet()
	end

	return
end

function WSPortLeft:AddMapListener()
	if self.map then
		self.map:AddListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSPortLeft:RemoveMapListener()
	if self.map then
		self.map:RemoveListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
		self:RemoveFleetListener(self.fleet)
	end

	return
end

function WSPortLeft:AddFleetListener(arg_7_1)
	if arg_7_1 then
		_.each(arg_7_1:GetShips(true), function(arg_8_0)
			arg_8_0:AddListener(WorldMapShip.EventHpRantChange, self.onUpdateShip)

			return
		end)
	end

	return
end

function WSPortLeft:RemoveFleetListener(arg_9_1)
	if arg_9_1 then
		_.each(arg_9_1:GetShips(true), function(arg_10_0)
			arg_10_0:RemoveListener(WorldMapShip.EventHpRantChange, self.onUpdateShip)

			return
		end)
	end

	return
end

function WSPortLeft:OnUpdateSelectedFleet()
	local var_11_0 = self.map:GetFleet()

	if self.fleet ~= var_11_0 then
		self:RemoveFleetListener(self.fleet)

		self.fleet = var_11_0

		self:AddFleetListener(self.fleet)
		self:UpdateShipList(self.rtMain, self.fleet:GetTeamShipVOs(TeamType.Main, true))
		self:UpdateShipList(self.rtVanguard, self.fleet:GetTeamShipVOs(TeamType.Vanguard, true))
	end

	return
end

function WSPortLeft:OnUpdateShip(arg_12_1, arg_12_2)
	local var_12_0 = self.map:GetFleet(arg_12_2.fleetId)

	assert(var_12_0, "can not find fleet: " .. arg_12_2.fleetId)

	local var_12_1 = var_12_0:GetFleetType()

	if var_12_1 == FleetType.Normal then
		self:UpdateShipList(self.rtMain, self.fleet:GetTeamShipVOs(TeamType.Main, true))
		self:UpdateShipList(self.rtVanguard, self.fleet:GetTeamShipVOs(TeamType.Vanguard, true))
	elseif var_12_1 == FleetType.Submarine then
		self:UpdateShipList(self.rtSubmarine, self.submarineFleet:GetTeamShipVOs(TeamType.Submarine, true))
	end

	return
end

function WSPortLeft:UpdateShipList(arg_13_1, arg_13_2)
	local var_13_0 = UIItemList.New(arg_13_1, self.rtShip)

	var_13_0:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = WorldConst.FetchWorldShip(arg_13_2[arg_14_1 + 1].id)

			updateShip(arg_14_2, arg_13_2[arg_14_1 + 1])

			local var_14_1 = findTF(arg_14_2, "HP_POP")

			setActive(var_14_1, true)
			setActive(findTF(var_14_1, "heal"), false)
			setActive(findTF(var_14_1, "normal"), false)

			local var_14_2 = findTF(arg_14_2, "blood")
			local var_14_3 = findTF(arg_14_2, "blood/fillarea/green")
			local var_14_4 = findTF(arg_14_2, "blood/fillarea/red")
			local var_14_5 = not var_14_0:IsHpSafe()

			setActive(var_14_3, not var_14_5)
			setActive(var_14_4, var_14_5)

			var_14_2:GetComponent(typeof(Slider)).fillRect = var_14_5 and var_14_4 or var_14_3

			setSlider(var_14_2, 0, 10000, var_14_0.hpRant)
			setActive(arg_14_2:Find("agony"), var_14_5)
			setActive(arg_14_2:Find("broken"), var_14_0:IsBroken())
		end

		return
	end)
	var_13_0:align(#arg_13_2)

	return
end

return WSPortLeft
