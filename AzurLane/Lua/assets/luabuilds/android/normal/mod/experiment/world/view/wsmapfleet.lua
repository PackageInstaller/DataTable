class = var_0_10000

local var_0_0 = "WSMapFleet"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WSMapTransform"))

var_0_1.Fields = {
	rtShadow = "userdata",
	attaches = "table",
	rtArrow = "userdata",
	rtSub = "userdata",
	selected = "boolean",
	rtDamage = "userdata",
	fleet = "table",
	spineRole = "table",
	rtRetreat = "userdata",
	rtFx = "userdata",
	timerHealth = "table",
	theme = "table",
	rtHealth = "userdata",
	moveTurnCount = "number",
	rtMoveTurn = "userdata",
	active = "boolean",
	submarineSupport = "boolean"
}
var_0_1.Listeners = {
	onUpdate = "Update"
}
var_0_1.EventUpdateSelected = "WSMapFleet.EventUpdateSelected"

function var_0_1.GetResName(arg_1_0)
	return "ship_tpl"
end

function var_0_1.Setup(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.fleet = arg_2_1

	local var_2_0 = arg_2_0.fleet
	local var_2_1 = var_3.AddListener

	WorldMapFleet = var_1_10005

	var_2_1(var_2_0, var_1_10005.EventUpdateLocation, arg_2_0.onUpdate)

	local var_2_2 = arg_2_0.fleet
	local var_2_3 = var_3.AddListener

	WorldMapFleet = var_5

	var_2_3(var_2_2, var_5.EventUpdateShipOrder, arg_2_0.onUpdate)

	local var_2_4 = arg_2_0.fleet
	local var_2_5 = var_3.AddListener

	WorldMapFleet = var_5

	var_2_5(var_2_4, var_5.EventUpdateBuff, arg_2_0.onUpdate)

	local var_2_6 = arg_2_0.fleet
	local var_2_7 = var_3.AddListener

	WorldMapFleet = var_5

	var_2_7(var_2_6, var_5.EventUpdateDamageLevel, arg_2_0.onUpdate)

	arg_2_0.theme = arg_2_2
	arg_2_0.attaches = {}

	arg_2_0:Init()

	return
end

function var_0_1.Dispose(arg_3_0)
	local var_3_0 = arg_3_0.fleet
	local var_3_1 = var_1.RemoveListener

	WorldMapFleet = var_1_10003

	var_3_1(var_3_0, var_1_10003.EventUpdateLocation, arg_3_0.onUpdate)

	local var_3_2 = arg_3_0.fleet
	local var_3_3 = var_1.RemoveListener

	WorldMapFleet = var_3

	var_3_3(var_3_2, var_3.EventUpdateShipOrder, arg_3_0.onUpdate)

	local var_3_4 = arg_3_0.fleet
	local var_3_5 = var_1.RemoveListener

	WorldMapFleet = var_3

	var_3_5(var_3_4, var_3.EventUpdateBuff, arg_3_0.onUpdate)

	local var_3_6 = arg_3_0.fleet
	local var_3_7 = var_1.RemoveListener

	WorldMapFleet = var_3

	var_3_7(var_3_6, var_3.EventUpdateDamageLevel, arg_3_0.onUpdate)
	arg_3_0:ClearAttaches()
	arg_3_0:ClearHealthTimer()
	var_0_1.super.Dispose(arg_3_0)

	return
end

function var_0_1.Init(arg_4_0)
	local var_4_0 = arg_4_0.transform

	arg_4_0.rtRetreat = var_1.Find(var_4_0, "retreat")

	local var_4_1 = arg_4_0.transform

	arg_4_0.rtArrow = var_1.Find(var_4_1, "arrow")

	local var_4_2 = arg_4_0.transform

	arg_4_0.rtFx = var_1.Find(var_4_2, "fx")

	local var_4_3 = arg_4_0.transform

	arg_4_0.rtShadow = var_1.Find(var_4_3, "shadow")

	local var_4_4 = arg_4_0.transform

	arg_4_0.rtSub = var_1.Find(var_4_4, "marks/sub")

	local var_4_5 = arg_4_0.transform

	arg_4_0.rtDamage = var_1.Find(var_4_5, "marks/damage")

	local var_4_6 = arg_4_0.transform

	arg_4_0.rtMoveTurn = var_1.Find(var_4_6, "marks/move_turn")

	local var_4_7 = arg_4_0.transform

	arg_4_0.rtHealth = var_1.Find(var_4_7, "Health")
	setActive = var_1

	var_1(arg_4_0.rtRetreat, false)

	setActive = var_1

	var_1(arg_4_0.rtArrow, false)

	setActive = var_1

	var_1(arg_4_0.rtSub, false)

	setActive = var_1

	var_1(arg_4_0.rtDamage, false)

	setActive = var_1

	var_1(arg_4_0.rtMoveTurn, false)

	setActive = var_1

	var_1(arg_4_0.rtHealth, false)

	arg_4_0.transform.name = "fleet_" .. arg_4_0.fleet.id

	local var_4_8 = arg_4_0.transform

	Vector3 = var_2
	var_4_8.localEulerAngles = var_2(-arg_4_0.theme.angle, 0, 0)

	local var_4_9 = arg_4_0.rtShadow

	Vector3 = var_2
	var_4_9.localPosition = var_2.zero

	arg_4_0:Update()

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.UpdateActive
	local var_4_12

	if not arg_4_0.active then
		var_4_12 = true
	end

	var_4_11(var_4_10, var_4_12)

	local var_4_13 = arg_4_0
	local var_4_14 = arg_4_0.UpdateSelected
	local var_4_15

	if not arg_4_0.selected then
		var_4_15 = false
	end

	var_4_14(var_4_13, var_4_15)
	arg_4_0:UpdateSubmarineSupport()

	local var_4_16 = arg_4_0
	local var_4_17 = arg_4_0.UpdateModelScale

	Vector3 = var_4_15

	var_4_17(var_4_16, var_4_15(0.4, 0.4, 1))

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_0.UpdateModelAngles

	Vector3 = var_3

	var_4_19(var_4_18, var_3.zero)

	arg_4_0.moveTurnCount = 0

	return
end

function var_0_1.LoadSpine(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.modelResAsync
	local var_5_1 = arg_5_0.fleet
	local var_5_2 = var_3.GetFlagShipVO(var_5_1)

	SpineRole = var_5_1

	local var_5_3 = var_5_1.New(var_5_2)

	var_4.Load(var_5_3, function()
		local var_6_0 = arg_5_0.modelType

		WorldConst = var_2_10001

		if var_6_0 ~= var_2_10001.ModelSpine then
			local var_6_1 = var_0

			var_0.Dispose(var_6_1)

			return
		end

		local var_6_2 = var_0

		var_0.SetRaycastTarget(var_6_2, false)

		local var_6_3 = var_0
		local var_6_4 = var_0.SetAnchoredPosition3D

		Vector3 = var_2

		var_6_4(var_6_3, var_2.zero)

		local var_6_5 = var_0
		local var_6_6 = var_0.SetLocalScale

		Vector3 = var_2

		var_6_6(var_6_5, var_2.one)

		local var_6_7 = var_0
		local var_6_8 = var_0.SetLayer

		Layer = var_2

		var_6_8(var_6_7, var_2.UI)

		local var_6_9 = var_0

		var_0.SetParent(var_6_9, arg_5_0.model)

		arg_5_0.modelComps = {
			var_0
		}
		arg_5_0.spineRole = var_0

		arg_5_1()

		return
	end, var_5_0, var_4.ORBIT_KEY_SLG)

	return
end

function var_0_1.UnloadSpine(arg_7_0)
	if arg_7_0.spineRole then
		local var_7_0 = arg_7_0.spineRole

		var_1.Dispose(var_7_0)

		arg_7_0.spineRole = nil
	end

	return
end

function var_0_1.Update(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.fleet

	if arg_8_1 ~= nil then
		WorldMapFleet = var_1_10003

		if arg_8_1 == var_1_10003.EventUpdateLocation and not arg_8_0.isMoving then
			var_1_10003 = arg_8_0.transform
			var_1_10005 = arg_8_0.theme
			var_1_10003.anchoredPosition3D = var_4.GetLinePosition(var_1_10005, var_8_0.row, var_8_0.column)
		end

		if arg_8_1 ~= nil then
			WorldMapFleet = var_1_10003

			if arg_8_1 == var_1_10003.EventUpdateLocation then
				local var_8_1 = arg_8_0

				var_1_10003 = arg_8_0.SetModelOrder
				WorldConst = var_1_10005

				var_1_10003(var_8_1, var_1_10005.LOFleet, var_8_0.row)

				underscore = var_1_10003

				var_1_10003.each(arg_8_0.attaches, function(arg_9_0)
					arg_9_0.modelOrder = arg_8_0.modelOrder

					return
				end)
			end

			if arg_8_1 ~= nil then
				WorldMapFleet = var_1_10003

				if arg_8_1 == var_1_10003.EventUpdateShipOrder then
					local var_8_2 = arg_8_0

					var_1_10003 = arg_8_0.LoadModel
					WorldConst = var_1_10005

					var_1_10003(var_8_2, var_1_10005.ModelSpine, var_8_0:GetPrefab(), nil, true, function()
						local var_10_0 = arg_8_0.model
						local var_10_1 = var_0.SetParent
						local var_10_2 = arg_8_0.transform

						var_10_1(var_10_0, var_2.Find(var_10_2, "ship"), false)

						return
					end)
				end

				if arg_8_1 ~= nil then
					WorldMapFleet = var_1_10003

					if arg_8_1 == var_1_10003.EventUpdateBuff then
						arg_8_0:UpdateAttaches()
					end

					if arg_8_1 ~= nil then
						WorldMapFleet = var_1_10003

						if arg_8_1 == var_1_10003.EventUpdateDamageLevel then
							arg_8_0:UpdateDamageLevel()
						end

						return
					end
				end
			end
		end
	end
end

function var_0_1.UpdateActive(arg_11_0, arg_11_1)
	if arg_11_0.active ~= arg_11_1 then
		arg_11_0.active = arg_11_1
		setActive = var_2

		var_2(arg_11_0.transform, arg_11_0.active)
	end

	return
end

function var_0_1.UpdateSelected(arg_12_0, arg_12_1)
	if arg_12_0.selected ~= arg_12_1 then
		arg_12_0.selected = arg_12_1
		setActive = var_2

		var_2(arg_12_0.rtArrow, arg_12_0.selected)
		arg_12_0:DispatchEvent(var_0_1.EventUpdateSelected)
	end

	return
end

function var_0_1.UpdateSubmarineSupport(arg_13_0)
	nowWorld = var_1_10001

	local var_13_0 = var_1_10001()
	local var_13_1 = var_1.IsSubmarineSupporting(var_13_0)

	setActive = var_13_0

	var_13_0(arg_13_0.rtSub, var_13_1)

	if var_13_1 then
		setGray = var_13_0

		var_13_0(arg_13_0.rtSub, not var_1:GetSubAidFlag(), false)
	end

	return
end

function var_0_1.UpdateAttaches(arg_14_0)
	local var_14_0 = arg_14_0.fleet

	for iter_14_0 = #var_1.GetBuffFxList(var_14_0) + 1, #arg_14_0.attaches do
		var_1_10008 = arg_14_0.attaches[iter_14_0]

		var_1_10006.Unload(var_1_10008)
	end

	for iter_14_1 = #arg_14_0.attaches + 1, #var_1 do
		WPool = var_1_10006

		local var_14_1 = var_1_10006

		var_1_10006 = var_1_10006.Get
		WSMapEffect = var_1_10008
		var_1_10006 = var_1_10006(var_14_1, var_1_10008)
		createNewGameObject = var_14_1
		var_1_10006.transform = var_14_1("mapEffect")
		var_1_10008 = var_1_10006.transform

		var_7.SetParent(var_1_10008, arg_14_0.rtFx, false)

		var_1_10006.modelOrder = arg_14_0.modelOrder
		table = var_7

		var_7.insert(arg_14_0.attaches, var_1_10006)
	end

	for iter_14_2 = 1, #var_1 do
		local var_14_2 = arg_14_0.attaches[iter_14_2]
		local var_14_3 = var_6.Setup

		WorldConst = var_1_10009

		var_14_3(var_14_2, var_1_10009.GetBuffEffect(var_1[iter_14_2]))
		var_6:Load()
	end

	return
end

function var_0_1.ClearAttaches(arg_15_0)
	_ = var_1_10001

	local var_15_0 = var_1_10001.map(arg_15_0.attaches, function(arg_16_0)
		return arg_16_0.transform
	end)

	WPool = var_2

	var_2:ReturnArray(arg_15_0.attaches)

	ipairs = var_2

	for iter_15_0, iter_15_1 in var_2(var_15_0) do
		Destroy = var_1_10007

		var_1_10007(iter_15_1)
	end

	arg_15_0.attaches = {}

	return
end

function var_0_1.UpdateDamageLevel(arg_17_0)
	local var_17_0 = arg_17_0.fleet.damageLevel

	setActive = var_1_10002

	var_1_10002(arg_17_0.rtDamage, var_17_0 > 0)

	local var_17_1 = 1

	WorldConst = var_3

	for iter_17_0 = var_17_1, #var_3.DamageBuffList do
		setActive = var_1_10006

		local var_17_2 = arg_17_0.rtDamage

		var_1_10006(var_7.Find(var_17_2, iter_17_0), var_17_0 == iter_17_0)
	end

	return
end

function var_0_1.PlusMoveTurn(arg_18_0)
	arg_18_0.moveTurnCount = arg_18_0.moveTurnCount + 1
	setText = var_1

	local var_18_0 = arg_18_0.rtMoveTurn

	var_1(var_2.Find(var_18_0, "Text"), arg_18_0.moveTurnCount)

	setActive = var_1

	var_1(arg_18_0.rtMoveTurn, arg_18_0.moveTurnCount > 0)

	return
end

function var_0_1.ClearMoveTurn(arg_19_0)
	arg_19_0.moveTurnCount = 0
	setActive = var_1

	var_1(arg_19_0.rtMoveTurn, false)

	return
end

function var_0_1.DisplayHealth(arg_20_0)
	arg_20_0:ClearHealthTimer()

	setActive = var_1

	var_1(arg_20_0.rtHealth, true)

	Timer = var_1
	arg_20_0.timerHealth = var_1.New(function()
		setActive = var_2_10000

		var_2_10000(arg_20_0.rtHealth, false)

		arg_20_0.timerHealth = nil

		return
	end, 2)

	local var_20_0 = arg_20_0.timerHealth

	var_1.Start(var_20_0)

	return
end

function var_0_1.ClearHealthTimer(arg_22_0)
	if arg_22_0.timerHealth then
		local var_22_0 = arg_22_0.timerHealth

		var_1.Stop(var_22_0)

		arg_22_0.timerHealth = nil
		setActive = var_1

		var_1(arg_22_0.rtHealth, false)
	end

	return
end

return var_0_1
