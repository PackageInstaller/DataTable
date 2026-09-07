local AttireFrame = class("AttireFrame", import("..BaseVO"))

AttireFrame.STATE_LOCK = 1
AttireFrame.STATE_UNLOCKABLE = 2
AttireFrame.STATE_UNLOCK = 3

function AttireFrame:attireFrameRes(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = self.attireInfo[arg_1_2]

	if arg_1_1 then
		local var_1_1 = getProxy(PlayerProxy):getRawData()

		arg_1_3 = arg_1_3 and (not HXSet.isHxPropose() or var_1_1:GetProposeShipId() == var_1_1.character)
	else
		arg_1_3 = arg_1_3 and not HXSet.isHxPropose()
	end

	if arg_1_2 == AttireConst.TYPE_ICON_FRAME and var_1_0 == 0 and arg_1_3 then
		if pg.ship_data_template[self.icon] and ShipGroup.IsMetaGroup(pg.ship_data_template[self.icon].group_type) then
			return "meta_propose"
		else
			return "propose"
		end
	elseif arg_1_2 == AttireConst.TYPE_CHAT_FRAME then
		return (arg_1_1 or nil) and (var_1_0 .. "_self" or var_1_0 .. "_other")
	else
		return var_1_0
	end

	return
end

function AttireFrame:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id

	self:updateData(arg_2_1)

	return
end

function AttireFrame:isNew()
	return self.new == true
end

function AttireFrame:clearNew()
	self.new = nil

	return
end

function AttireFrame:updateData(arg_5_1)
	self.endTime = arg_5_1.end_time or arg_5_1.time or -1
	self.new = arg_5_1.isNew

	return
end

function AttireFrame:getState()
	local var_6_0 = AttireFrame.STATE_LOCK
	local var_6_1 = self:isOwned()

	if var_6_1 then
		var_6_0 = AttireFrame.STATE_UNLOCK
	elseif not var_6_1 and self:canUnlock() then
		var_6_0 = AttireFrame.STATE_UNLOCKABLE
	end

	return var_6_0
end

function AttireFrame:canUnlock()
	return false
end

function AttireFrame:isOwned()
	return self.endTime >= 0 and not self:isExpired()
end

function AttireFrame:isExpired()
	return self:expiredType() and pg.TimeMgr.GetInstance():GetServerTime() >= self:getExpiredTime()
end

function AttireFrame:getExpiredTime()
	if self:expiredType() then
		return self.endTime
	end

	assert(false)

	return
end

function AttireFrame:updateEndTime(arg_11_1)
	self.endTime = arg_11_1

	return
end

function AttireFrame:expiredType()
	return self:getConfig("time_limit_type") == 1
end

function AttireFrame:getTimerKey()
	return self:getType() .. "_" .. self.id
end

function AttireFrame:getType()
	assert(false)

	return
end

function AttireFrame:bindConfigTable()
	assert(false)

	return
end

function AttireFrame:getDropType()
	assert(false)

	return
end

return AttireFrame
