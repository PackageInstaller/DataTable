local Cattery = class("Cattery", import("...BaseVO"))

Cattery.STATE_LOCK = 1
Cattery.STATE_EMPTY = 2
Cattery.STATE_OCCUPATION = 3
Cattery.OP_CLEAR = 1
Cattery.OP_FEED = 2
Cattery.OP_PLAY = 4

function Cattery:Ctor(arg_1_1, arg_1_2)
	self.home = arg_1_1
	self.id = arg_1_2.id
	self.op = arg_1_2.op_flag or 0
	self.expSettlementTime = arg_1_2.exp_time
	self.commanderId = arg_1_2.commander_id or 0
	self.style = arg_1_2.style or 1
	self.opClean = bit.band(self.op, Cattery.OP_CLEAR) > 0
	self.opFeed = bit.band(self.op, Cattery.OP_FEED) > 0
	self.opPlay = bit.band(self.op, Cattery.OP_PLAY) > 0
	self.cacheExp = arg_1_2.cache_exp or 0

	return
end

function Cattery:AddCommander(arg_2_1, arg_2_2)
	self.commanderId = arg_2_1
	self.expSettlementTime = arg_2_2

	self:ClearCacheExp()

	return
end

function Cattery:ReplaceCommander(arg_3_1)
	self.commanderId = arg_3_1

	self:ClearCacheExp()

	return
end

function Cattery:RemoveCommander()
	self.commanderId = 0

	self:ClearCacheExp()

	return
end

function Cattery:ExistCommander()
	local var_5_0

	if self.commanderId ~= 0 then
		if getProxy(CommanderProxy):RawGetCommanderById(self.commanderId) == nil then
			var_5_0 = false

			goto label_5_0
		end
	end

	::label_5_0::

	return true
end

function Cattery:GetCommanderId()
	return self.commanderId
end

function Cattery:GetCommander()
	if self:ExistCommander() then
		return getProxy(CommanderProxy):getCommanderById(self.commanderId)
	end

	return
end

function Cattery:CommanderCanClean()
	if self:ExistCommander() then
		return self:GetCommander():ExistCleanFlag()
	end

	return false
end

function Cattery:CommanderCanFeed()
	if self:ExistCommander() then
		return self:GetCommander():ExitFeedFlag()
	end

	return false
end

function Cattery:CommanderCanPlay()
	if self:ExistCommander() then
		return self:GetCommander():ExitPlayFlag()
	end

	return false
end

function Cattery:CommanderCanOP(arg_11_1)
	if arg_11_1 == 1 then
		return self:CommanderCanClean()
	elseif arg_11_1 == 2 then
		return self:CommanderCanFeed()
	elseif arg_11_1 == 3 then
		return self:CommanderCanPlay()
	end

	return
end

function Cattery:GetStyle()
	return self.style
end

function Cattery:_GetStyle_()
	return CatteryStyle.New({
		own = true,
		id = self.style
	})
end

function Cattery:UpdateStyle(arg_14_1)
	self.style = arg_14_1

	return
end

function Cattery:IsDirty()
	return self.opClean == true
end

function Cattery:GetOP()
	return self.op
end

function Cattery:ExistCleanOP()
	return self.opClean
end

function Cattery:ClearCleanOP()
	self.opClean = false

	return
end

function Cattery:ExiseFeedOP()
	return self.opFeed
end

function Cattery:ClearFeedOP()
	self.opFeed = false

	return
end

function Cattery:ExistPlayOP()
	return self.opPlay
end

function Cattery:ClearPlayOP()
	self.opPlay = false

	return
end

function Cattery:ExistOP(arg_23_1)
	if arg_23_1 == 1 then
		return self:ExistCleanOP()
	elseif arg_23_1 == 2 then
		return self:ExiseFeedOP()
	elseif arg_23_1 == 3 then
		return self:ExistPlayOP()
	end

	return
end

function Cattery:ClearOP(arg_24_1)
	if arg_24_1 == 1 then
		self:ClearCleanOP()
	elseif arg_24_1 == 2 then
		self:ClearFeedOP()
	elseif arg_24_1 == 3 then
		self:ClearPlayOP()
	end

	return
end

function Cattery:ResetOP()
	self.opPlay = true
	self.opFeed = true
	self.opClean = true

	return
end

function Cattery:ResetCleanOP()
	self.opClean = true

	return
end

function Cattery:ResetFeedOP()
	self.opFeed = true

	return
end

function Cattery:ResetPlayOP()
	self.opPlay = true

	return
end

function Cattery:IsLocked()
	if self.home:GetMaxCatteryCnt() >= self.id then
		return false
	end

	return true
end

function Cattery:GetState()
	if self:IsLocked() then
		return Cattery.STATE_LOCK
	end

	if self:ExistCommander() then
		return Cattery.STATE_OCCUPATION
	end

	return Cattery.STATE_EMPTY
end

function Cattery:GetCalcExpTime()
	return self.expSettlementTime
end

function Cattery:UpdateCalcExpTime(arg_32_1)
	self.expSettlementTime = arg_32_1

	return
end

function Cattery:CanUse()
	return self:GetState() ~= Cattery.STATE_LOCK
end

function Cattery:GetCacheExp()
	return self.cacheExp
end

function Cattery:ClearCacheExp()
	self.cacheExp = 0

	return
end

function Cattery:UpdateCacheExp(arg_36_1)
	self.cacheExp = self.cacheExp + arg_36_1

	return
end

function Cattery:ExistCacheExp()
	return self.cacheExp > 0
end

function Cattery:GetCacheExpTime()
	if self:ExistCacheExp() then
		return (math.ceil(self:GetCacheExp() / (self.home:getConfig("exp_number") / 16)))
	else
		return 0
	end

	return
end

return Cattery
