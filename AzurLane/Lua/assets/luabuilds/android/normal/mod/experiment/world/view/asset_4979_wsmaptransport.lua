class = var_0_10000

local var_0_0 = "WSMapTransport"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
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
var_0_1.Listeners = {
	onArrived = "OnArrived",
	onStartTrip = "OnStartTrip"
}

function var_0_1.GetResName()
	return "world_cell_transport"
end

function var_0_1.GetName(arg_2_0, arg_2_1, arg_2_2)
	return "transport_" .. arg_2_0 .. "_" .. arg_2_1 .. "_" .. arg_2_2
end

function var_0_1.Setup(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.row = arg_3_1
	arg_3_0.column = arg_3_2
	arg_3_0.dir = arg_3_3
	arg_3_0.map = arg_3_4

	local var_3_0 = arg_3_0.wsMapPath
	local var_3_1 = var_5.AddListener

	WSMapPath = var_1_10007

	var_3_1(var_3_0, var_1_10007.EventStartTrip, arg_3_0.onStartTrip)

	local var_3_2 = arg_3_0.wsMapPath
	local var_3_3 = var_5.AddListener

	WSMapPath = var_7

	var_3_3(var_3_2, var_7.EventArrived, arg_3_0.onArrived)
	arg_3_0:Init()

	return
end

function var_0_1.Dispose(arg_4_0)
	local var_4_0 = arg_4_0.wsMapPath
	local var_4_1 = var_1.RemoveListener

	WSMapPath = var_1_10003

	var_4_1(var_4_0, var_1_10003.EventStartTrip, arg_4_0.onStartTrip)

	local var_4_2 = arg_4_0.wsMapPath
	local var_4_3 = var_1.RemoveListener

	WSMapPath = var_3

	var_4_3(var_4_2, var_3.EventArrived, arg_4_0.onArrived)
	arg_4_0:DisposeUpdateTimer()
	arg_4_0:UpdateAlpha(1)
	arg_4_0:Clear()

	return
end

function var_0_1.Init(arg_5_0)
	local var_5_0 = arg_5_0.transform

	arg_5_0.rtClick = var_1.Find(var_5_0, "click")
	arg_5_0.rtBottom = var_1:Find("bottom")
	arg_5_0.rtDanger = var_1:Find("danger")
	arg_5_0.rtForbid = var_1:Find("forbid")

	local var_5_1 = arg_5_0.row
	local var_5_2 = arg_5_0.column
	local var_5_3 = arg_5_0.dir

	var_1.name = var_0_1.GetName(var_5_1, var_5_2, var_5_3)

	local var_5_4 = 0

	WorldConst = var_6

	if var_5_3 == var_6.DirDown then
		var_5_1 = var_5_1 + 1
		var_5_4 = -90
	else
		WorldConst = var_6

		if var_5_3 == var_6.DirLeft then
			var_5_2 = var_5_2 - 1
			var_5_4 = 180
		else
			WorldConst = var_6

			if var_5_3 == var_6.DirUp then
				var_5_1 = var_5_1 - 1
				var_5_4 = 90
			else
				WorldConst = var_6

				if var_5_3 == var_6.DirRight then
					var_5_2 = var_5_2 + 1
					var_5_4 = 0
				end
			end
		end
	end

	Vector3 = var_6
	var_1.localEulerAngles = var_6(0, 0, var_5_4)

	local var_5_5 = arg_5_0.map.theme

	var_1.anchoredPosition = var_6.GetLinePosition(var_5_5, var_5_1, var_5_2)

	local var_5_6 = arg_5_0.map.theme.cellSize

	Vector3 = var_5_5
	var_1.localScale = var_5_5(var_5_6.x / var_1.sizeDelta.x, var_5_6.y / var_1.sizeDelta.y, 1)

	local var_5_7 = arg_5_0.wsMapPath

	if var_7.IsMoving(var_5_7) then
		arg_5_0:OnStartTrip()
	end

	return
end

function var_0_1.UpdateAlpha(arg_6_0, arg_6_1)
	setImageAlpha = var_1_10002

	var_1_10002(arg_6_0.rtBottom, arg_6_1)

	setImageAlpha = var_1_10002

	var_1_10002(arg_6_0.rtDanger, arg_6_1)

	setImageAlpha = var_1_10002

	var_1_10002(arg_6_0.rtForbid, arg_6_1)

	return
end

function var_0_1.OnStartTrip(arg_7_0)
	arg_7_0:StartUpdateTimer()

	return
end

function var_0_1.OnArrived(arg_8_0)
	arg_8_0:DisposeUpdateTimer()

	return
end

function var_0_1.StartUpdateTimer(arg_9_0)
	local var_9_0 = arg_9_0.wsMapPath.wsObject.class

	WSMapFleet = var_1_10003

	if var_9_0 == var_1_10003 then
		arg_9_0:DisposeUpdateTimer()

		local var_9_1 = arg_9_0.map.theme
		local var_9_2 = var_2.GetLinePosition(var_9_1, arg_9_0.row, arg_9_0.column)

		math = var_9_1

		local var_9_3 = var_9_1.min(var_2.cellSize.x + var_2.cellSpace.x, var_2.cellSize.y + var_2.cellSpace.y)
		local var_9_4 = var_1.fleet
		local var_9_5 = arg_9_0.map
		local var_9_6 = var_6.GetNormalFleets(var_9_5)

		_ = var_9_5

		local var_9_7 = var_9_5.map(var_9_6, function(arg_10_0)
			local var_10_0 = var_0
			local var_10_1 = var_1.GetLinePosition(var_10_0, arg_10_0.row, arg_10_0.column)

			Vector3 = var_10_0

			return var_10_0.Distance(var_10_1, var_9_2)
		end)

		Timer = var_8
		arg_9_0.updateTimer = var_8.New(function()
			local var_11_0 = var_9_7
			local var_11_1 = var_9_4.index

			Vector3 = var_2_10002
			var_11_0[var_11_1] = var_2_10002.Distance(var_0.transform.anchoredPosition3D, var_9_2)
			math = var_11_0

			local var_11_2 = var_11_0.max

			_ = var_11_1

			local var_11_3 = var_11_2(1 - var_11_1.min(var_9_7) / var_9_3, 0)
			local var_11_4 = arg_9_0

			var_1.UpdateAlpha(var_11_4, var_11_3)

			return
		end, 0.033, -1)

		local var_9_8 = arg_9_0.updateTimer

		var_8.Start(var_9_8)
		arg_9_0.updateTimer.func()
	end

	return
end

function var_0_1.DisposeUpdateTimer(arg_12_0)
	if arg_12_0.updateTimer then
		local var_12_0 = arg_12_0.updateTimer

		var_1.Stop(var_12_0)

		arg_12_0.updateTimer = nil
	end

	return
end

return var_0_1
