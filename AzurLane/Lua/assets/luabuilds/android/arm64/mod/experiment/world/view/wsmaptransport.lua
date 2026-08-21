local var_0_0 = class("WSMapTransport", import("...BaseEntity"))

var_0_0.Fields = {
	map = "table",
	column = "number",
	wsMapPath = "table",
	transform = "userdata",
	dir = "number",
	rtForbid = "userdata",
	updateTimer = "table",
	row = "number",
	rtClick = "userdata",
	rtBottom = "userdata",
	rtDanger = "userdata"
}
var_0_0.Listeners = {
	onArrived = "OnArrived",
	onStartTrip = "OnStartTrip"
}

function var_0_0.GetResName()
	return "world_cell_transport"
end

function var_0_0.GetName(arg_2_0, arg_2_1, arg_2_2)
	return "transport_" .. arg_2_0 .. "_" .. arg_2_1 .. "_" .. arg_2_2
end

function var_0_0.Setup(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.row = arg_3_1
	arg_3_0.column = arg_3_2
	arg_3_0.dir = arg_3_3
	arg_3_0.map = arg_3_4

	arg_3_0.wsMapPath:AddListener(WSMapPath.EventStartTrip, arg_3_0.onStartTrip)
	arg_3_0.wsMapPath:AddListener(WSMapPath.EventArrived, arg_3_0.onArrived)
	arg_3_0:Init()

	return
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.wsMapPath:RemoveListener(WSMapPath.EventStartTrip, arg_4_0.onStartTrip)
	arg_4_0.wsMapPath:RemoveListener(WSMapPath.EventArrived, arg_4_0.onArrived)
	arg_4_0:DisposeUpdateTimer()
	arg_4_0:UpdateAlpha(1)
	arg_4_0:Clear()

	return
end

function var_0_0.Init(arg_5_0)
	arg_5_0.rtClick = arg_5_0.transform:Find("click")
	arg_5_0.rtBottom = arg_5_0.transform:Find("bottom")
	arg_5_0.rtDanger = arg_5_0.transform:Find("danger")
	arg_5_0.rtForbid = arg_5_0.transform:Find("forbid")

	local var_5_0 = arg_5_0.row
	local var_5_1 = arg_5_0.column

	arg_5_0.transform.name = var_0_0.GetName(arg_5_0.row, arg_5_0.column, arg_5_0.dir)

	local var_5_2 = 0

	if arg_5_0.dir == WorldConst.DirDown then
		var_5_0 = var_5_0 + 1
		var_5_2 = -90
	elseif arg_5_0.dir == WorldConst.DirLeft then
		var_5_1 = var_5_1 - 1
		var_5_2 = 180
	elseif arg_5_0.dir == WorldConst.DirUp then
		var_5_0 = var_5_0 - 1
		var_5_2 = 90
	elseif arg_5_0.dir == WorldConst.DirRight then
		var_5_1 = var_5_1 + 1
		var_5_2 = 0
	end

	arg_5_0.transform.localEulerAngles = Vector3(0, 0, var_5_2)
	arg_5_0.transform.anchoredPosition = arg_5_0.map.theme:GetLinePosition(var_5_0, var_5_1)
	arg_5_0.transform.localScale = Vector3(arg_5_0.map.theme.cellSize.x / arg_5_0.transform.sizeDelta.x, arg_5_0.map.theme.cellSize.y / arg_5_0.transform.sizeDelta.y, 1)

	if arg_5_0.wsMapPath:IsMoving() then
		arg_5_0:OnStartTrip()
	end

	return
end

function var_0_0.UpdateAlpha(arg_6_0, arg_6_1)
	setImageAlpha(arg_6_0.rtBottom, arg_6_1)
	setImageAlpha(arg_6_0.rtDanger, arg_6_1)
	setImageAlpha(arg_6_0.rtForbid, arg_6_1)

	return
end

function var_0_0.OnStartTrip(arg_7_0)
	arg_7_0:StartUpdateTimer()

	return
end

function var_0_0.OnArrived(arg_8_0)
	arg_8_0:DisposeUpdateTimer()

	return
end

function var_0_0.StartUpdateTimer(arg_9_0)
	local var_9_0 = arg_9_0.wsMapPath.wsObject

	if arg_9_0.wsMapPath.wsObject.class == WSMapFleet then
		arg_9_0:DisposeUpdateTimer()

		local var_9_1 = arg_9_0.map.theme:GetLinePosition(arg_9_0.row, arg_9_0.column)
		local var_9_2 = math.min(arg_9_0.map.theme.cellSize.x + arg_9_0.map.theme.cellSpace.x, arg_9_0.map.theme.cellSize.y + arg_9_0.map.theme.cellSpace.y)
		local var_9_3 = arg_9_0.wsMapPath.wsObject.fleet
		local var_9_4 = _.map(arg_9_0.map:GetNormalFleets(), function(arg_10_0)
			return Vector3.Distance(var_0:GetLinePosition(arg_10_0.row, arg_10_0.column), var_9_1)
		end)

		arg_9_0.updateTimer = Timer.New(function()
			var_9_4[var_9_3.index] = Vector3.Distance(var_9_0.transform.anchoredPosition3D, var_9_1)

			arg_9_0:UpdateAlpha((math.max(1 - _.min(var_9_4) / var_9_2, 0)))

			return
		end, 0.033, -1)

		arg_9_0.updateTimer:Start()
		arg_9_0.updateTimer.func()
	end

	return
end

function var_0_0.DisposeUpdateTimer(arg_12_0)
	if arg_12_0.updateTimer then
		arg_12_0.updateTimer:Stop()

		arg_12_0.updateTimer = nil
	end

	return
end

return var_0_0
