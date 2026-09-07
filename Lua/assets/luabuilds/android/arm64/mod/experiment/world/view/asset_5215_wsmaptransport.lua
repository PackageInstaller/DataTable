local WSMapTransport = class("WSMapTransport", import("...BaseEntity"))

WSMapTransport.Fields = {
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
WSMapTransport.Listeners = {
	onArrived = "OnArrived",
	onStartTrip = "OnStartTrip"
}

function WSMapTransport.GetResName()
	return "world_cell_transport"
end

function WSMapTransport:GetName(arg_2_1, arg_2_2)
	return "transport_" .. self .. "_" .. arg_2_1 .. "_" .. arg_2_2
end

function WSMapTransport:Setup(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.row = arg_3_1
	self.column = arg_3_2
	self.dir = arg_3_3
	self.map = arg_3_4

	self.wsMapPath:AddListener(WSMapPath.EventStartTrip, self.onStartTrip)
	self.wsMapPath:AddListener(WSMapPath.EventArrived, self.onArrived)
	self:Init()

	return
end

function WSMapTransport:Dispose()
	self.wsMapPath:RemoveListener(WSMapPath.EventStartTrip, self.onStartTrip)
	self.wsMapPath:RemoveListener(WSMapPath.EventArrived, self.onArrived)
	self:DisposeUpdateTimer()
	self:UpdateAlpha(1)
	self:Clear()

	return
end

function WSMapTransport:Init()
	self.rtClick = self.transform:Find("click")
	self.rtBottom = self.transform:Find("bottom")
	self.rtDanger = self.transform:Find("danger")
	self.rtForbid = self.transform:Find("forbid")

	local var_5_0 = self.row
	local var_5_1 = self.column

	self.transform.name = WSMapTransport.GetName(self.row, self.column, self.dir)

	local var_5_2 = 0

	if self.dir == WorldConst.DirDown then
		var_5_0 = var_5_0 + 1
		var_5_2 = -90
	elseif self.dir == WorldConst.DirLeft then
		var_5_1 = var_5_1 - 1
		var_5_2 = 180
	elseif self.dir == WorldConst.DirUp then
		var_5_0 = var_5_0 - 1
		var_5_2 = 90
	elseif self.dir == WorldConst.DirRight then
		var_5_1 = var_5_1 + 1
		var_5_2 = 0
	end

	self.transform.localEulerAngles = Vector3(0, 0, var_5_2)
	self.transform.anchoredPosition = self.map.theme:GetLinePosition(var_5_0, var_5_1)
	self.transform.localScale = Vector3(self.map.theme.cellSize.x / self.transform.sizeDelta.x, self.map.theme.cellSize.y / self.transform.sizeDelta.y, 1)

	if self.wsMapPath:IsMoving() then
		self:OnStartTrip()
	end

	return
end

function WSMapTransport:UpdateAlpha(arg_6_1)
	setImageAlpha(self.rtBottom, arg_6_1)
	setImageAlpha(self.rtDanger, arg_6_1)
	setImageAlpha(self.rtForbid, arg_6_1)

	return
end

function WSMapTransport:OnStartTrip()
	self:StartUpdateTimer()

	return
end

function WSMapTransport:OnArrived()
	self:DisposeUpdateTimer()

	return
end

function WSMapTransport:StartUpdateTimer()
	local var_9_0 = self.wsMapPath.wsObject

	if self.wsMapPath.wsObject.class == WSMapFleet then
		self:DisposeUpdateTimer()

		local var_9_1 = self.map.theme
		local var_9_2 = self.map.theme:GetLinePosition(self.row, self.column)
		local var_9_3 = math.min(self.map.theme.cellSize.x + self.map.theme.cellSpace.x, self.map.theme.cellSize.y + self.map.theme.cellSpace.y)
		local var_9_4 = self.wsMapPath.wsObject.fleet
		local var_9_5 = _.map(self.map:GetNormalFleets(), function(arg_10_0)
			return Vector3.Distance(var_9_1:GetLinePosition(arg_10_0.row, arg_10_0.column), var_9_2)
		end)

		self.updateTimer = Timer.New(function()
			var_9_5[var_9_4.index] = Vector3.Distance(var_9_0.transform.anchoredPosition3D, var_9_2)

			self:UpdateAlpha((math.max(1 - _.min(var_9_5) / var_9_3, 0)))

			return
		end, 0.033, -1)

		self.updateTimer:Start()
		self.updateTimer.func()
	end

	return
end

function WSMapTransport:DisposeUpdateTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	return
end

return WSMapTransport
