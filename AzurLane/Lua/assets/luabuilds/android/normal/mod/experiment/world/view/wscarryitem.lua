class = var_0_10000

local var_0_0 = "WSCarryItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WSMapTransform"))

var_0_1.Fields = {
	wsMapPath = "table",
	carryItem = "table",
	followList = "table",
	theme = "table",
	fleet = "table",
	active = "boolean"
}
var_0_1.Listeners = {
	onUpdate = "Update",
	onMoveEnd = "OnMoveEnd"
}

function var_0_1.GetResName(arg_1_0)
	return "event_tpl"
end

function var_0_1.Setup(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.fleet = arg_2_1

	local var_2_0 = arg_2_0.fleet
	local var_2_1 = var_4.AddListener

	WorldMapFleet = var_1_10006

	var_2_1(var_2_0, var_1_10006.EventUpdateLocation, arg_2_0.onUpdate)

	arg_2_0.carryItem = arg_2_2

	local var_2_2 = arg_2_0.carryItem
	local var_2_3 = var_4.AddListener

	WorldCarryItem = var_6

	var_2_3(var_2_2, var_6.EventUpdateOffset, arg_2_0.onUpdate)

	arg_2_0.theme = arg_2_3

	arg_2_0:Init()

	return
end

function var_0_1.Dispose(arg_3_0)
	local var_3_0 = arg_3_0.fleet
	local var_3_1 = var_1.RemoveListener

	WorldMapFleet = var_1_10003

	var_3_1(var_3_0, var_1_10003.EventUpdateLocation, arg_3_0.onUpdate)

	local var_3_2 = arg_3_0.carryItem
	local var_3_3 = var_1.RemoveListener

	WorldCarryItem = var_3

	var_3_3(var_3_2, var_3.EventUpdateOffset, arg_3_0.onUpdate)

	if arg_3_0.wsMapPath then
		local var_3_4 = arg_3_0.wsMapPath
		local var_3_5 = var_1.RemoveListener

		WSMapPath = var_3

		var_3_5(var_3_4, var_3.EventArrived, arg_3_0.onMoveEnd)

		local var_3_6 = arg_3_0.wsMapPath

		var_1.Dispose(var_3_6)
	end

	var_0_1.super.Dispose(arg_3_0)

	return
end

function var_0_1.Init(arg_4_0)
	local var_4_0 = arg_4_0.transform

	var_4_0.name = "carry_item_" .. arg_4_0.carryItem.id
	Vector3 = var_2
	var_4_0.localEulerAngles = var_2(-arg_4_0.theme.angle, 0, 0)

	arg_4_0:Update()

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.UpdateActive
	local var_4_3

	if not arg_4_0.active then
		var_4_3 = true
	end

	var_4_2(var_4_1, var_4_3)

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.UpdateModelScale
	local var_4_6 = arg_4_0.carryItem

	var_4_5(var_4_4, var_4.GetScale(var_4_6))

	return
end

function var_0_1.Update(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.transform
	local var_5_1 = arg_5_0.fleet
	local var_5_2 = arg_5_0.carryItem
	local var_5_3, var_5_4 = arg_5_0:GetLocation()

	if not arg_5_0.isMoving then
		if arg_5_1 ~= nil then
			WorldMapFleet = var_7

			if arg_5_1 ~= var_7.EventUpdateLocation then
				WorldCarryItem = var_7

				if arg_5_1 == var_7.EventUpdateOffset then
					local var_5_5 = arg_5_0.theme

					var_5_0.anchoredPosition3D = var_7.GetLinePosition(var_5_5, var_5_3, var_5_4)
				end

				if arg_5_1 ~= nil then
					WorldMapFleet = var_7

					if arg_5_1 ~= var_7.EventUpdateLocation then
						WorldCarryItem = var_7

						if arg_5_1 == var_7.EventUpdateOffset then
							local var_5_6 = arg_5_0
							local var_5_7 = arg_5_0.SetModelOrder

							WorldConst = var_1_10009

							var_5_7(var_5_6, var_1_10009.LOFleet, var_5_3)
						end

						if arg_5_1 == nil then
							local var_5_8 = var_5_2:IsAvatar()
							local var_5_9 = var_5_0:Find("char")
							local var_5_10 = var_5_0
							local var_5_11 = var_5_0.Find(var_5_10, "icon")

							setActive = var_5_10

							var_5_10(var_5_9, var_5_8)

							setActive = var_5_10

							var_5_10(var_5_11, not var_5_8)

							if var_5_8 then
								local var_5_12 = arg_5_0

								var_5_10 = arg_5_0.LoadModel
								WorldConst = var_12

								var_5_10(var_5_12, var_12.ModelSpine, var_5_2.config.icon, nil, true, function()
									local var_6_0 = arg_5_0.model
									local var_6_1 = var_0.SetParent
									local var_6_2 = var_5_9

									var_6_1(var_6_0, var_2.Find(var_6_2, "ship"), false)

									return
								end)
							else
								local var_5_13 = arg_5_0

								var_5_10 = arg_5_0.LoadModel
								WorldConst = var_12

								local var_5_14 = var_12.ModelPrefab

								WorldConst = var_1_10013

								var_5_10(var_5_13, var_5_14, var_1_10013.ResBoxPrefab .. var_5_2.config.icon, var_5_2.config.icon, true, function()
									local var_7_0 = arg_5_0.model

									var_0.SetParent(var_7_0, var_5_11, false)

									return
								end)
							end

							setActive = var_5_10

							var_5_10(var_5_0:Find("buffs"), false)

							setActive = var_5_10

							var_5_10(var_5_0:Find("map_buff"), false)
						end

						return
					end
				end
			end
		end
	end
end

function var_0_1.UpdateActive(arg_8_0, arg_8_1)
	if arg_8_0.active ~= arg_8_1 then
		arg_8_0.active = arg_8_1
		setActive = var_2

		var_2(arg_8_0.transform, arg_8_0.active)
	end

	return
end

function var_0_1.FollowPath(arg_9_0, arg_9_1)
	if not arg_9_0.wsMapPath then
		WSMapPath = var_2
		arg_9_0.wsMapPath = var_2.New()

		local var_9_0 = arg_9_0.wsMapPath

		var_2.Setup(var_9_0, arg_9_0.theme)

		local var_9_1 = arg_9_0.wsMapPath
		local var_9_2 = var_2.AddListener

		WSMapPath = var_4

		var_9_2(var_9_1, var_4.EventArrived, arg_9_0.onMoveEnd)
	end

	local var_9_3

	if not arg_9_0.followList then
		var_9_3 = {}
	end

	arg_9_0.followList = var_9_3
	table = var_9_3

	var_9_3.insert(arg_9_0.followList, function()
		local var_10_0 = arg_9_0
		local var_10_1, var_10_2 = var_0.GetLocation(var_10_0)
		local var_10_3 = {
			row = var_10_1,
			column = var_10_2
		}
		local var_10_4 = arg_9_0.wsMapPath

		var_3.UpdateObject(var_10_4, arg_9_0)

		local var_10_5 = arg_9_0.wsMapPath
		local var_10_6 = var_3.UpdateAction

		WorldConst = var_5

		var_10_6(var_10_5, var_5.ActionMove)

		local var_10_7 = arg_9_0.wsMapPath
		local var_10_8 = var_3.UpdateDirType

		WorldConst = var_5

		var_10_8(var_10_7, var_5.DirType2)

		local var_10_9 = arg_9_0.wsMapPath

		var_3.StartMove(var_10_9, var_10_3, arg_9_1)

		return
	end)

	if not arg_9_0.isMoving then
		arg_9_0:OnMoveEnd()
	end

	return arg_9_0.wsMapPath
end

function var_0_1.OnMoveEnd(arg_11_0, arg_11_1)
	if #arg_11_0.followList > 0 then
		table = var_2

		var_2.remove(arg_11_0.followList, 1)()
	end

	return
end

function var_0_1.GetLocation(arg_12_0)
	return arg_12_0.fleet.row + arg_12_0.carryItem.offsetRow, arg_12_0.fleet.column + arg_12_0.carryItem.offsetColumn
end

return var_0_1
