local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.redCliffData
local var_0_2 = g.core.const.ConstMgr.RedCliffConst
local RedCliffPlayerStruct = class("RedCliffPlayerStruct")

function RedCliffPlayerStruct:ctor()
	self._score = 0
	self._rank = 0
	self._componentId = 0
	self._restHp = 100
	self._protectTime = 0
	self._coolTime = 0
	self._deadTime = 0
	self._user = nil
	self._userId = 0
end

function RedCliffPlayerStruct:resInfo(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._score = arg_2_1.score or 0
	self._rank = arg_2_1.rank or 0
	self._restHp = arg_2_1.rest_hp / 10 or 100

	self:setCoolTime(arg_2_1.cool_time)
	self:setProtectTime(arg_2_1.protect_time)
	self:setDeadTime(arg_2_1.revive_time)
	self:setComponentId(arg_2_1.component_id)

	self._user = arg_2_1.user
	self._userId = arg_2_1.user_id
end

function RedCliffPlayerStruct:setComponentId(arg_3_1)
	self._componentId = arg_3_1 and arg_3_1 > 0 and arg_3_1 or var_0_1:getRandomRebornId()
end

function RedCliffPlayerStruct:getComponentId()
	return self._componentId
end

function RedCliffPlayerStruct:isOccupy()
	local var_5_0 = var_0_1:getEditorStructByComponentId(self._componentId):getEditorType()

	return var_5_0 == var_0_2.EDITOR_TYPE.SMALL or var_5_0 == var_0_2.EDITOR_TYPE.MIDDLE or var_5_0 == var_0_2.EDITOR_TYPE.BIG
end

function RedCliffPlayerStruct:isProtect()
	return self._protectTime - var_0_0:getTime() > 0
end

function RedCliffPlayerStruct:setProtectTime(arg_7_1)
	arg_7_1 = arg_7_1 or 0
	self._protectTime = arg_7_1
end

function RedCliffPlayerStruct:getProtectEndTime()
	return self._protectTime
end

function RedCliffPlayerStruct:isCool()
	return self._coolTime - var_0_0:getTime() > 0
end

function RedCliffPlayerStruct:setCoolTime(arg_10_1)
	arg_10_1 = arg_10_1 or 0
	self._coolTime = arg_10_1
end

function RedCliffPlayerStruct:getCoolEndTime()
	return self._coolTime
end

function RedCliffPlayerStruct:isDead()
	return self._deadTime - var_0_0:getTime() > 0
end

function RedCliffPlayerStruct:setDeadTime(arg_13_1)
	arg_13_1 = arg_13_1 or 0
	self._deadTime = arg_13_1
end

function RedCliffPlayerStruct:getDeadEndTime()
	return self._deadTime
end

function RedCliffPlayerStruct:isSelf()
	return self._user.id == g.core.model.User:getId()
end

function RedCliffPlayerStruct:reduceHp()
	local var_16_0 = var_0_1:getEditorStructByComponentId(self._componentId)

	if var_16_0 then
		local var_16_1 = var_16_0:getHpLimit()

		if var_16_1 > self._restHp then
			var_16_1 = self._restHp
		end

		self._restHp = self._restHp - var_16_0:getReduceHp()
		self._restHp = math.max(var_16_1, self._restHp)
	end
end

function RedCliffPlayerStruct:resetRestHp()
	self._restHp = 100
end

function RedCliffPlayerStruct:getRestHp()
	return self._restHp
end

function RedCliffPlayerStruct:setScore(arg_19_1)
	self._score = arg_19_1 or 0
end

function RedCliffPlayerStruct:getScore()
	return self._score
end

function RedCliffPlayerStruct:setRank(arg_21_1)
	self._rank = arg_21_1 or 0
end

function RedCliffPlayerStruct:getRank()
	return self._rank
end

function RedCliffPlayerStruct:getOccupyComponentId()
	return self._componentId
end

function RedCliffPlayerStruct:getUser()
	return self._user
end

function RedCliffPlayerStruct:getUserId()
	return (self._user or nil) and (self._user.id or 0)
end

function RedCliffPlayerStruct:getUserName()
	return (self._user or nil) and (self._user.name or "")
end

return RedCliffPlayerStruct
