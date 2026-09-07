local WorldBuff = class("WorldBuff", import("...BaseEntity"))

WorldBuff.Fields = {
	config = "table",
	floor = "number",
	time = "number",
	id = "number",
	round = "number",
	step = "number"
}
WorldBuff.TrapCompassInterference = 1
WorldBuff.TrapVortex = 2
WorldBuff.TrapFire = 3
WorldBuff.TrapDisturbance = 4
WorldBuff.TrapCripple = 5
WorldBuff.TrapFrozen = 6

function WorldBuff:GetTemplate()
	assert(pg.world_SLGbuff_data[self], "without this buff " .. self)

	return pg.world_SLGbuff_data[self]
end

function WorldBuff:Setup(arg_2_1)
	self.id = arg_2_1.id
	self.config = WorldBuff.GetTemplate(self.id)

	assert(self.config, "world_SLGbuff_data not exist: " .. self.id)

	self.floor = math.min(arg_2_1.floor, self:GetMaxFloor())

	if arg_2_1.time ~= 0 then
		self.time = arg_2_1.time or nil
	end

	if arg_2_1.round ~= 0 then
		self.round = arg_2_1.round or nil
	end

	if arg_2_1.step ~= 0 then
		self.step = arg_2_1.step or nil
	end

	return
end

function WorldBuff:IsValid()
	local var_3_0

	if self.time then
		if self.time <= pg.TimeMgr.GetInstance():GetServerTime() then
			var_3_0 = false

			goto label_3_0
		end
	end

	::label_3_0::

	return true
end

function WorldBuff:CheckValid()
	if not self:IsValid() then
		self.floor = 0
	end

	return
end

function WorldBuff:GetMaxFloor()
	return self.config.buff_maxfloor
end

function WorldBuff:GetTrapType()
	return self.config.trap_type
end

function WorldBuff:GetTrapParams()
	return self.config.trap_parameter
end

function WorldBuff:GetLost()
	if self.step and self.round then
		return math.min(self.step, self.round)
	else
		return self.step or self.round
	end

	return
end

function WorldBuff:AddFloor(arg_9_1)
	self:CheckValid()

	self.floor = math.clamp(self.floor + arg_9_1, 0, 999)

	return
end

function WorldBuff:GetFloor()
	self:CheckValid()

	return math.min(self.floor, self:GetMaxFloor())
end

return WorldBuff
