class = var_0_10000

local var_0_0 = "WSPortLeft"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
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
var_0_1.Listeners = {
	onUpdateShip = "OnUpdateShip",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function var_0_1.Setup(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0:RemoveMapListener()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.transform

	arg_3_0.rtBG = var_1.Find(var_3_0, "bg")

	local var_3_1 = arg_3_0.rtBG

	arg_3_0.rtFleet = var_2.Find(var_3_1, "fleet")

	local var_3_2 = arg_3_0.rtFleet

	arg_3_0.rtMain = var_2.Find(var_3_2, "main")

	local var_3_3 = arg_3_0.rtFleet

	arg_3_0.rtVanguard = var_2.Find(var_3_3, "vanguard")

	local var_3_4 = arg_3_0.rtFleet

	arg_3_0.rtShip = var_2.Find(var_3_4, "shiptpl")
	setActive = var_2

	var_2(arg_3_0.rtShip, false)

	return
end

function var_0_1.UpdateMap(arg_4_0, arg_4_1)
	if arg_4_0.map ~= arg_4_1 or arg_4_0.gid ~= arg_4_1.gid then
		arg_4_0:RemoveMapListener()

		arg_4_0.map = arg_4_1
		arg_4_0.gid = arg_4_1.gid

		arg_4_0:AddMapListener()
		arg_4_0:OnUpdateSelectedFleet()
	end

	return
end

function var_0_1.AddMapListener(arg_5_0)
	if arg_5_0.map then
		local var_5_0 = arg_5_0.map
		local var_5_1 = var_1.AddListener

		WorldMap = var_1_10004

		var_5_1(var_5_0, var_1_10004.EventUpdateFIndex, arg_5_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.RemoveMapListener(arg_6_0)
	if arg_6_0.map then
		local var_6_0 = arg_6_0.map
		local var_6_1 = var_1.RemoveListener

		WorldMap = var_1_10004

		var_6_1(var_6_0, var_1_10004.EventUpdateFIndex, arg_6_0.onUpdateSelectedFleet)
		arg_6_0:RemoveFleetListener(arg_6_0.fleet)
	end

	return
end

function var_0_1.AddFleetListener(arg_7_0, arg_7_1)
	if arg_7_1 then
		_ = var_1_10002

		var_1_10002.each(arg_7_1:GetShips(true), function(arg_8_0)
			local var_8_0 = arg_8_0
			local var_8_1 = arg_8_0.AddListener

			WorldMapShip = var_2_10004

			var_8_1(var_8_0, var_2_10004.EventHpRantChange, arg_7_0.onUpdateShip)

			return
		end)
	end

	return
end

function var_0_1.RemoveFleetListener(arg_9_0, arg_9_1)
	if arg_9_1 then
		_ = var_1_10002

		var_1_10002.each(arg_9_1:GetShips(true), function(arg_10_0)
			local var_10_0 = arg_10_0
			local var_10_1 = arg_10_0.RemoveListener

			WorldMapShip = var_2_10004

			var_10_1(var_10_0, var_2_10004.EventHpRantChange, arg_9_0.onUpdateShip)

			return
		end)
	end

	return
end

function var_0_1.OnUpdateSelectedFleet(arg_11_0)
	local var_11_0 = arg_11_0.map
	local var_11_1 = var_1.GetFleet(var_11_0)

	if arg_11_0.fleet ~= var_11_1 then
		arg_11_0:RemoveFleetListener(arg_11_0.fleet)

		arg_11_0.fleet = var_11_1

		arg_11_0:AddFleetListener(arg_11_0.fleet)

		local var_11_2 = arg_11_0
		local var_11_3 = arg_11_0.UpdateShipList
		local var_11_4 = arg_11_0.rtMain
		local var_11_5 = arg_11_0.fleet
		local var_11_6 = var_6.GetTeamShipVOs

		TeamType = var_1_10009

		var_11_3(var_11_2, var_11_4, var_11_6(var_11_5, var_1_10009.Main, true))

		local var_11_7 = arg_11_0
		local var_11_8 = arg_11_0.UpdateShipList
		local var_11_9 = arg_11_0.rtVanguard
		local var_11_10 = arg_11_0.fleet
		local var_11_11 = var_6.GetTeamShipVOs

		TeamType = var_9

		var_11_8(var_11_7, var_11_9, var_11_11(var_11_10, var_9.Vanguard, true))
	end

	return
end

function var_0_1.OnUpdateShip(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.map
	local var_12_1 = var_3.GetFleet(var_12_0, arg_12_2.fleetId)

	assert = var_1_10004

	var_1_10004(var_12_1, "can not find fleet: " .. arg_12_2.fleetId)

	local var_12_2 = var_12_1:GetFleetType()

	FleetType = var_12_0

	local var_12_4

	if var_12_2 == var_12_0.Normal then
		local var_12_3 = arg_12_0

		var_12_4 = arg_12_0.UpdateShipList

		local var_12_5 = arg_12_0.rtMain
		local var_12_6 = arg_12_0.fleet
		local var_12_7 = var_9.GetTeamShipVOs

		TeamType = var_1_10012

		var_12_4(var_12_3, var_12_5, var_12_7(var_12_6, var_1_10012.Main, true))

		local var_12_8 = arg_12_0

		var_12_4 = arg_12_0.UpdateShipList

		local var_12_9 = arg_12_0.rtVanguard
		local var_12_10 = arg_12_0.fleet
		local var_12_11 = var_9.GetTeamShipVOs

		TeamType = var_1_10012

		var_12_4(var_12_8, var_12_9, var_12_11(var_12_10, var_1_10012.Vanguard, true))
	else
		FleetType = var_12_4

		if var_12_2 == var_12_4.Submarine then
			local var_12_12 = arg_12_0
			local var_12_13 = arg_12_0.UpdateShipList
			local var_12_14 = arg_12_0.rtSubmarine
			local var_12_15 = arg_12_0.submarineFleet
			local var_12_16 = var_9.GetTeamShipVOs

			TeamType = var_1_10012

			var_12_13(var_12_12, var_12_14, var_12_16(var_12_15, var_1_10012.Submarine, true))
		end
	end

	return
end

function var_0_1.UpdateShipList(arg_13_0, arg_13_1, arg_13_2)
	UIItemList = var_1_10003

	local var_13_0 = var_1_10003.New(arg_13_1, arg_13_0.rtShip)

	var_3.make(var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_13_2[arg_14_1 + 1]

			WorldConst = var_4

			local var_14_1 = var_4.FetchWorldShip(var_14_0.id)

			updateShip = var_2_10005

			var_2_10005(arg_14_2, var_14_0)

			findTF = var_2_10005

			local var_14_2 = var_2_10005(arg_14_2, "HP_POP")

			setActive = var_6

			var_6(var_14_2, true)

			setActive = var_6
			findTF = var_8

			var_6(var_8(var_14_2, "heal"), false)

			setActive = var_6
			findTF = var_8

			var_6(var_8(var_14_2, "normal"), false)

			findTF = var_6

			local var_14_3 = var_6(arg_14_2, "blood")

			findTF = var_7

			local var_14_4 = var_7(arg_14_2, "blood/fillarea/green")

			findTF = var_8

			local var_14_5 = var_8(arg_14_2, "blood/fillarea/red")
			local var_14_6 = not var_14_1:IsHpSafe()

			setActive = var_10

			var_10(var_14_4, not var_14_6)

			setActive = var_10

			var_10(var_14_5, var_14_6)

			local var_14_7 = var_14_3
			local var_14_8 = var_14_3.GetComponent

			typeof = var_13
			Slider = var_2_10015

			local var_14_9 = var_14_8(var_14_7, var_13(var_2_10015))

			var_14_9.fillRect = var_14_6 and var_14_5 or var_14_4
			setSlider = var_14_9

			var_14_9(var_14_3, 0, 10000, var_14_1.hpRant)

			local var_14_10 = arg_14_2
			local var_14_11 = arg_14_2.Find(var_14_10, "agony")

			setActive = var_11

			var_11(var_14_11, var_14_6)

			local var_14_12 = arg_14_2:Find("broken")

			setActive = var_14_10

			var_14_10(var_14_12, var_14_1:IsBroken())
		end

		return
	end)
	var_3:align(#arg_13_2)

	return
end

return var_0_1
