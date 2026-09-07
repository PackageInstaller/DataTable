local CommanderBox = class("CommanderBox", import("..BaseVO"))

CommanderBox.STATE_EMPTY = -1
CommanderBox.STATE_WAITING = 0
CommanderBox.STATE_STARTING = 1
CommanderBox.STATE_FINISHED = 2

function CommanderBox:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1.id
	self.index = arg_1_2 or 99
	self.configId = self.id
	self.finishTime = arg_1_1.finish_time or 0
	self.beginTime = arg_1_1.begin_time or 0

	local var_1_0 = arg_1_1.poolId or 0

	if var_1_0 and var_1_0 > 0 then
		self.pool = getProxy(CommanderProxy):getPoolById(var_1_0)
	end

	return
end

function CommanderBox:getPool()
	return self.pool
end

function CommanderBox:getFinishTime()
	return self.finishTime
end

function CommanderBox:ReduceFinishTime(arg_4_1)
	self.finishTime = math.max(self.beginTime, self.finishTime - arg_4_1)

	return
end

function CommanderBox:costTime()
	local var_5_0 = self:getState()

	if var_5_0 == CommanderBox.STATE_STARTING or var_5_0 == CommanderBox.STATE_FINISHED then
		return self.finishTime - self.beginTime
	else
		return 0
	end

	return
end

function CommanderBox:getState()
	local var_6_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if self.finishTime == 0 then
		return CommanderBox.STATE_EMPTY
	elseif var_6_0 >= self.finishTime then
		return CommanderBox.STATE_FINISHED
	elseif self.finishTime > 0 and var_6_0 < self.beginTime then
		return CommanderBox.STATE_WAITING
	elseif self.finishTime > 0 and var_6_0 < self.finishTime then
		return CommanderBox.STATE_STARTING
	end

	return
end

function CommanderBox:finish()
	self.finishTime = 0
	self.beginTime = 0

	return
end

function CommanderBox:getPrefab()
	self.rarity2Str = self.rarity2Str or {
		"",
		"SR",
		"SSR"
	}

	if self.pool then
		local var_8_0 = self.rarity2Str[self.pool:getRarity()]
		local var_8_1 = self:getState()

		if var_8_1 == CommanderBox.STATE_WAITING then
			return var_8_0 .. "NekoBox1"
		elseif var_8_1 == CommanderBox.STATE_STARTING then
			return var_8_0 .. "NekoBox2"
		elseif var_8_1 == CommanderBox.STATE_FINISHED then
			return var_8_0 .. "NekoBox3"
		end
	else
		return nil
	end

	return
end

function CommanderBox:getFetchPrefab()
	self.rarity2Str = self.rarity2Str or {
		"",
		"SR",
		"SSR"
	}

	assert(self.pool)

	return self.rarity2Str[self.pool:getRarity()] .. "NekoBox4"
end

function CommanderBox:IsSsr()
	return self.pool:getRarity() == 3
end

function CommanderBox:IsSr()
	return self.pool:getRarity() == 2
end

function CommanderBox:IsR()
	return self.pool:getRarity() == 1
end

return CommanderBox
