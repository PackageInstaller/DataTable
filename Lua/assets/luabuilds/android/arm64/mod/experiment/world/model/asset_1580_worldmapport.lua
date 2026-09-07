local WorldMapPort = class("WorldMapPort", import("...BaseEntity"))

WorldMapPort.Fields = {
	config = "table",
	zeroHourTime = "number",
	goods = "table",
	taskIds = "table",
	id = "number",
	expiredTime = "number"
}
WorldMapPort.EventUpdateTaskIds = "WorldMapPort.UpdateTaskIds"
WorldMapPort.EventUpdateGoods = "WorldMapPort.EventUpdateGoods"

function WorldMapPort:Build()
	self.taskIds = {}
	self.goods = {}

	return
end

function WorldMapPort:Setup(arg_2_1)
	self.id = arg_2_1
	self.config = pg.world_port_data[self.id]

	assert(self.config, "world_port_data not exist: " .. self.id)

	return
end

function WorldMapPort:Dispose()
	self:ClearGoods()
	self:Clear()

	return
end

function WorldMapPort:IsValid()
	local var_4_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_4_1 = self.expiredTime

	if self.expiredTime then
		if var_4_0 <= self.expiredTime then
			var_4_1 = self.zeroHourTime and var_4_0 <= self.zeroHourTime
		end
	end

	return var_4_1
end

function WorldMapPort:UpdateExpiredTime(arg_5_1)
	self.expiredTime = arg_5_1
	self.zeroHourTime = pg.TimeMgr.GetInstance():GetNextTime(0, 0, 0)

	return
end

function WorldMapPort:UpdateTaskIds(arg_6_1)
	if self.taskIds ~= arg_6_1 then
		self.taskIds = arg_6_1

		self:DispatchEvent(WorldMapPort.EventUpdateTaskIds)
	end

	return
end

function WorldMapPort:UpdateGoods(arg_7_1)
	if self.goods ~= arg_7_1 then
		self.goods = arg_7_1

		nowWorld():GetAtlas():UpdatePortMark(self.id, #underscore.filter(self.goods, function(arg_8_0)
			return arg_8_0.count > 0
		end) > 0)
		self:DispatchEvent(WorldMapPort.EventUpdateGoods)
	end

	return
end

function WorldMapPort:ClearGoods()
	WPool:ReturnArray(self.goods)

	self.goods = {}

	return
end

function WorldMapPort:GetRealm()
	return self.config.port_camp
end

function WorldMapPort:IsOpen(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(self.config.open_condition) do
		if iter_11_1[1] == arg_11_1 and arg_11_2 >= iter_11_1[2] then
			return true
		end
	end

	return false
end

function WorldMapPort:IsTempPort()
	return self.config.port_camp == 0
end

return WorldMapPort
