local var_0_0 = class("WSCarryItem", import(".WSMapTransform"))

var_0_0.Fields = {
	wsMapPath = "table",
	carryItem = "table",
	followList = "table",
	theme = "table",
	fleet = "table",
	active = "boolean"
}
var_0_0.Listeners = {
	onUpdate = "Update",
	onMoveEnd = "OnMoveEnd"
}

function var_0_0.GetResName(arg_1_0)
	return "event_tpl"
end

function var_0_0.Setup(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.fleet = arg_2_1

	arg_2_0.fleet:AddListener(WorldMapFleet.EventUpdateLocation, arg_2_0.onUpdate)

	arg_2_0.carryItem = arg_2_2

	arg_2_0.carryItem:AddListener(WorldCarryItem.EventUpdateOffset, arg_2_0.onUpdate)

	arg_2_0.theme = arg_2_3

	arg_2_0:Init()

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.fleet:RemoveListener(WorldMapFleet.EventUpdateLocation, arg_3_0.onUpdate)
	arg_3_0.carryItem:RemoveListener(WorldCarryItem.EventUpdateOffset, arg_3_0.onUpdate)

	if arg_3_0.wsMapPath then
		arg_3_0.wsMapPath:RemoveListener(WSMapPath.EventArrived, arg_3_0.onMoveEnd)
		arg_3_0.wsMapPath:Dispose()
	end

	var_0_0.super.Dispose(arg_3_0)

	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.transform.name = "carry_item_" .. arg_4_0.carryItem.id
	arg_4_0.transform.localEulerAngles = Vector3(-arg_4_0.theme.angle, 0, 0)

	arg_4_0:Update()

	local var_4_0 = arg_4_0.active or true

	arg_4_0:UpdateActive(var_4_0)
	arg_4_0:UpdateModelScale(arg_4_0.carryItem:GetScale())

	return
end

function var_0_0.Update(arg_5_0, arg_5_1)
	local var_5_1 = arg_5_0.carryItem
	local var_5_2, var_5_3 = arg_5_0:GetLocation()

	if not arg_5_0.isMoving and (arg_5_1 == nil or arg_5_1 == WorldMapFleet.EventUpdateLocation or arg_5_1 == WorldCarryItem.EventUpdateOffset) then
		arg_5_0.transform.anchoredPosition3D = arg_5_0.theme:GetLinePosition(var_5_2, var_5_3)
	end

	if arg_5_1 == nil or arg_5_1 == WorldMapFleet.EventUpdateLocation or arg_5_1 == WorldCarryItem.EventUpdateOffset then
		arg_5_0:SetModelOrder(WorldConst.LOFleet, var_5_2)
	end

	if arg_5_1 == nil then
		local var_5_4 = var_5_1:IsAvatar()
		local var_5_5 = arg_5_0.transform:Find("icon")

		setActive(arg_5_0.transform:Find("char"), var_5_4)
		setActive(arg_5_0.transform:Find("icon"), not var_5_4)

		if var_5_4 then
			arg_5_0:LoadModel(WorldConst.ModelSpine, var_5_1.config.icon, nil, true, function()
				arg_5_0.model:SetParent(var_0:Find("ship"), false)

				return
			end)
		else
			arg_5_0:LoadModel(WorldConst.ModelPrefab, WorldConst.ResBoxPrefab .. var_5_1.config.icon, var_5_1.config.icon, true, function()
				arg_5_0.model:SetParent(var_5_5, false)

				return
			end)
		end

		setActive(arg_5_0.transform:Find("buffs"), false)
		setActive(arg_5_0.transform:Find("map_buff"), false)
	end

	return
end

function var_0_0.UpdateActive(arg_8_0, arg_8_1)
	if arg_8_0.active ~= arg_8_1 then
		arg_8_0.active = arg_8_1

		setActive(arg_8_0.transform, arg_8_0.active)
	end

	return
end

function var_0_0.FollowPath(arg_9_0, arg_9_1)
	if not arg_9_0.wsMapPath then
		arg_9_0.wsMapPath = WSMapPath.New()

		arg_9_0.wsMapPath:Setup(arg_9_0.theme)
		arg_9_0.wsMapPath:AddListener(WSMapPath.EventArrived, arg_9_0.onMoveEnd)
	end

	arg_9_0.followList = arg_9_0.followList or {}

	table.insert(arg_9_0.followList, function()
		local var_10_0, var_10_1 = arg_9_0:GetLocation()

		arg_9_0.wsMapPath:UpdateObject(arg_9_0)
		arg_9_0.wsMapPath:UpdateAction(WorldConst.ActionMove)
		arg_9_0.wsMapPath:UpdateDirType(WorldConst.DirType2)
		arg_9_0.wsMapPath:StartMove({
			row = var_10_0,
			column = var_10_1
		}, arg_9_1)

		return
	end)

	if not arg_9_0.isMoving then
		arg_9_0:OnMoveEnd()
	end

	return arg_9_0.wsMapPath
end

function var_0_0.OnMoveEnd(arg_11_0, arg_11_1)
	if #arg_11_0.followList > 0 then
		table.remove(arg_11_0.followList, 1)()
	end

	return
end

function var_0_0.GetLocation(arg_12_0)
	return arg_12_0.fleet.row + arg_12_0.carryItem.offsetRow, arg_12_0.fleet.column + arg_12_0.carryItem.offsetColumn
end

return var_0_0
