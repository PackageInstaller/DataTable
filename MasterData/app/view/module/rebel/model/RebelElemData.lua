local var_0_0 = g.core.model.User.rebelData
local var_0_1 = g.core.const.ConstMgr.RebelConst.REBEL_TYPE
local RebelElemData = class("RebelElemData")

function RebelElemData:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._isMySelf = arg_1_2
	self._pkgRebel = arg_1_1
	self._realLevel = arg_1_3
	self._baseInfo = nil
	self._finderName = nil
	self._finderServerName = nil
	self._totalHP = 0
	self._curHP = 0

	self:_initRebelElem()
end

function RebelElemData:_initRebelElem()
	local var_2_0 = g.core.config.rebel_info.get(self._pkgRebel.base_id)

	self._baseInfo = var_2_0

	if self._isMySelf then
		self._finderName = g.core.model.User:getName()
	else
		local var_2_1 = g.core.model.User.friendData:getFriendInfoById(self._pkgRebel.uid)

		self._finderName = var_2_1 and var_2_1:getFriendName() or ""
		self._finderServerName = var_2_1 and var_2_1:getServerName() or ""
	end

	self._totalHP = 0

	local var_2_2 = g.core.config.monster_team_info.get(var_0_0:getSwitchMonsterTeamId(var_2_0.monster_team_id), 1)

	for iter_2_0 = 1, 6 do
		if var_2_2["monster_" .. iter_2_0] ~= 0 then
			local var_2_3 = g.core.config.monster_info.get(var_2_2["monster_" .. iter_2_0])

			self._totalHP = self._totalHP + (var_2_3.initial_hp + (self._realLevel - 1) * var_2_3.develop_hp)
		end
	end

	self._curHP = self._totalHP - self._pkgRebel.hp
end

function RebelElemData:isMySelf()
	return self._isMySelf
end

function RebelElemData:getBaseInfo()
	return self._baseInfo
end

function RebelElemData:getRebelPkg()
	return self._pkgRebel
end

function RebelElemData:getEndTime()
	return self._pkgRebel.ts
end

function RebelElemData:getRebelType()
	return self._baseInfo.type
end

function RebelElemData:getRebelScale(arg_8_1)
	return ((arg_8_1 or nil) and self._baseInfo.size2) / 100
end

function RebelElemData:isDefaultBoss()
	return self._baseInfo.type ~= var_0_1.DUNGEON_TRIGGER
end

function RebelElemData:getHP()
	return self._curHP, self._totalHP
end

function RebelElemData:getFinderName()
	return self._finderName
end

function RebelElemData:getServerName()
	return self._finderServerName
end

function RebelElemData:isShared()
	return self._pkgRebel.share
end

function RebelElemData:shareSucc()
	self._pkgRebel.share = true
end

function RebelElemData:getId()
	return self._pkgRebel.id
end

function RebelElemData:isInValidTime()
	if self._baseInfo.available_time > 0 then
		local var_16_0 = g.core.common.ServerTime:getWeekDay()

		if self._baseInfo.available_time == 1 then
			return var_16_0 == 0 or var_16_0 % 2 == 1
		elseif self._baseInfo.available_time == 2 then
			return var_16_0 == 0 or var_16_0 % 2 == 0
		end
	end

	return true
end

return RebelElemData
