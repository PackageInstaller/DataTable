local var_0_0 = g.core.model.User.bountyData
local var_0_1 = g.core.const.ConstMgr.BountyConst
local BountyMonsterStruct = class("BountyMonsterStruct")

function BountyMonsterStruct:ctor(arg_1_1)
	self._units = {}
	self._isDetail = false
	self._isNew = false

	local var_1_0 = {
		id = arg_1_1.knight_id
	}

	if arg_1_1 then
		self._id = arg_1_1.id or 0
	end

	if arg_1_1 then
		self._starNum = arg_1_1.star or 0
	end

	self._expireTime = arg_1_1.expire_time
	self._shareType = arg_1_1.share_type or var_0_1.SHARE_SEL_TYPE.MINE
	self._summonUserId = arg_1_1.create_user_id
	self._killUserId = arg_1_1.kill_user_id or 0
	self._fightValue = arg_1_1.fight_value or 0

	self:initRewards()
	self:_initUnits({
		var_1_0
	})
end

function BountyMonsterStruct:_initUnits(arg_2_1)
	self._units = {}

	local KnightStruct = require("app.view.module.knight.model.KnightStruct")

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = g.core.config.knight_info.get(iter_2_1.id)
		local var_2_2 = KnightStruct.new(var_2_1.advance_id)

		var_2_2:addCfgInfo(var_2_1)
		var_2_2:onlySetInfo({
			star_level = iter_2_1.star,
			position = iter_2_1.pos,
			base_id = iter_2_1.id
		})

		self._units[#self._units + 1] = var_2_2
	end

	table.sort(self._units, function(arg_3_0, arg_3_1)
		return arg_3_0:getFormationPos() < arg_3_1:getFormationPos()
	end)
end

function BountyMonsterStruct:initRewards()
	self._rewards = {}

	local var_4_0 = var_0_0:getMonsterInfoByStarNum(self._starNum)

	if not var_4_0 then
		return
	end

	local var_4_1 = "reward_type_"

	self._rewards[var_0_1.MONSTER_REWARD_TYPE.SHARE] = {}

	for iter_4_0 = var_0_1.MONSTER_REWARD_ID.SHARE_MIN, var_0_1.MONSTER_REWARD_ID.SHARE_MAX do
		if var_4_0["reward_size_" .. iter_4_0] > 1 then
			table.insert(self._rewards[var_0_1.MONSTER_REWARD_TYPE.SHARE], {
				type = var_4_0[var_4_1 .. iter_4_0],
				value = var_4_0["reward_value_" .. iter_4_0],
				size = var_4_0["reward_size_" .. iter_4_0]
			})
		end
	end

	self._rewards[var_0_1.MONSTER_REWARD_TYPE.KILL] = {}

	for iter_4_1 = var_0_1.MONSTER_REWARD_ID.KILL_MIN, var_0_1.MONSTER_REWARD_ID.KILL_MAX do
		if var_4_0["reward_size_" .. iter_4_1] > 1 then
			table.insert(self._rewards[var_0_1.MONSTER_REWARD_TYPE.KILL], {
				type = var_4_0[var_4_1 .. iter_4_1],
				value = var_4_0["reward_value_" .. iter_4_1],
				size = var_4_0["reward_size_" .. iter_4_1]
			})
		end
	end

	self._rewards[var_0_1.MONSTER_REWARD_TYPE.EXTRA] = g.core.common.Drops:getGoodsArray(var_4_0.extra_reward)
end

function BountyMonsterStruct:getId()
	return self._id
end

function BountyMonsterStruct:getStarNum()
	return self._starNum
end

function BountyMonsterStruct:getName()
	return self:getFirstUnit():getName() or ""
end

function BountyMonsterStruct:getResInfo()
	return self:getFirstUnit():getResInfo()
end

function BountyMonsterStruct:getAdvanceId()
	return self:getFirstUnit():getAdvanceId()
end

function BountyMonsterStruct:getExpireTime()
	return self._expireTime
end

function BountyMonsterStruct:getRewardsByRewardType(arg_11_1)
	local var_11_0 = self._rewards[arg_11_1]

	if arg_11_1 == var_0_1.MONSTER_REWARD_TYPE.KILL and self:getSummonUserId() ~= g.core.model.User:getId() then
		local var_11_1 = g.core.model.User.bountyData:getHelpRate() / 1000
		local var_11_2 = {}

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			var_11_2[iter_11_0] = {
				type = iter_11_1.type,
				value = iter_11_1.value,
				size = math.floor(iter_11_1.size * var_11_1)
			}
		end

		var_11_0 = var_11_2
	end

	return var_11_0
end

function BountyMonsterStruct:setShareType(arg_12_1)
	self._shareType = arg_12_1
end

function BountyMonsterStruct:getShareType()
	return self._shareType
end

function BountyMonsterStruct:isShared()
	return self._shareType ~= var_0_1.SHARE_SEL_TYPE.MINE
end

function BountyMonsterStruct:getExtraReward()
	return self._rewards[var_0_1.MONSTER_REWARD_TYPE.EXTRA]
end

function BountyMonsterStruct:getId()
	return self._id
end

function BountyMonsterStruct:getKillUserId()
	return self._killUserId
end

function BountyMonsterStruct:getSummonUserId()
	return self._summonUserId
end

function BountyMonsterStruct:getFightValue()
	return self._fightValue
end

function BountyMonsterStruct:getUnits()
	return self._units
end

function BountyMonsterStruct:getFirstUnit()
	return (self._units[1]:isMain() or nil) and self._units[2]
end

function BountyMonsterStruct:isDetailMonster()
	return self._isDetail
end

function BountyMonsterStruct:updateMonsterDetail(arg_23_1)
	self._fightValue = arg_23_1.fight_value

	self:_initUnits(arg_23_1.unit)

	self._isDetail = true
end

function BountyMonsterStruct:setIsNew(arg_24_1)
	self._isNew = arg_24_1
end

function BountyMonsterStruct:isNew()
	return self._isNew
end

return BountyMonsterStruct
