local var_0_0 = g.core.config.guild_war_map_info
local GuildWarUserStruct = class("GuildWarUserStruct")

function GuildWarUserStruct:ctor()
	self:setEmptyUser()
end

function GuildWarUserStruct:updateByData(arg_2_1, arg_2_2)
	self._baseData = arg_2_1
	self._user = arg_2_1.user
	self._position = arg_2_1.position
	self._hp = arg_2_1.hp or 0
	self._buildId = arg_2_2
end

function GuildWarUserStruct:setEmptyUser()
	self._user = nil
	self._position = -1
	self._hp = 0
	self._maxHp = 0
	self._buildId = -1
	self._baseData = nil
end

function GuildWarUserStruct:getBaseData()
	return self._baseData
end

function GuildWarUserStruct:setPosition(arg_5_1)
	self._position = arg_5_1
end

function GuildWarUserStruct:setCostHp(arg_6_1)
	self._hp = arg_6_1
end

function GuildWarUserStruct:setMaxHp(arg_7_1)
	self._maxHp = arg_7_1
end

function GuildWarUserStruct:getCostHp()
	return self._hp
end

function GuildWarUserStruct:getMaxHp()
	return self._maxHp
end

function GuildWarUserStruct:getPosition()
	return self._position
end

function GuildWarUserStruct:getUser()
	return self._user
end

function GuildWarUserStruct:isAlive()
	return self._maxHp > self._hp
end

function GuildWarUserStruct:getOwnBuildId()
	return self._buildId
end

function GuildWarUserStruct:getUserId()
	if self._user then
		return self._user.id
	end

	return 0
end

function GuildWarUserStruct:isMyId(arg_15_1)
	if not self._user then
		return false
	end

	return self._user.id == arg_15_1
end

local BuildStruct = class("BuildStruct")

function BuildStruct:ctor(arg_16_1)
	self._buildId = arg_16_1
	self._score = 0
	self._hp = 0
	self._cfg = var_0_0.get(arg_16_1)
	self._userHp = self._cfg.people_hp
	self._maxPeopleNum = self._cfg.people_num
	self._userDick = {}
end

function BuildStruct:updatePosition(arg_17_1)
	self._buildId = arg_17_1.build_id
	self._score = arg_17_1.score or 0
	self._hp = arg_17_1.hp or 0

	if arg_17_1.users then
		for iter_17_0, iter_17_1 in ipairs(arg_17_1.users) do
			local var_17_0 = self:getUserByPosition(iter_17_1.position)

			if var_17_0 then
				var_17_0:updateByData(iter_17_1, self._buildId)
			end
		end
	end
end

function BuildStruct:setResetBuild()
	self._userDick = {}
	self._score = 0
	self._hp = 0
end

function BuildStruct:getUserByPosition(arg_19_1)
	if arg_19_1 > self._maxPeopleNum then
		return nil
	end

	if not self._userDick[arg_19_1] then
		self._userDick[arg_19_1] = GuildWarUserStruct.new()

		self._userDick[arg_19_1]:setMaxHp(self._userHp)
		self._userDick[arg_19_1]:setPosition(arg_19_1)
	end

	return self._userDick[arg_19_1]
end

function BuildStruct:isPositionUserEmpty(arg_20_1)
	if not self._userDick[arg_20_1] then
		return true
	end

	return not checkbool(self._userDick[arg_20_1]:getUser())
end

function BuildStruct:getPositionByPlayerId(arg_21_1)
	for iter_21_0, iter_21_1 in pairs(self._userDick) do
		if iter_21_1:getUser() and iter_21_1:getUser().id == arg_21_1 then
			return iter_21_1:getPosition()
		end
	end

	return -1
end

function BuildStruct:getCfg()
	return self._cfg
end

function BuildStruct:getUsers()
	return self._userDick
end

function BuildStruct:getCostHp()
	return self._hp
end

function BuildStruct:getBuildId()
	return self._buildId
end

function BuildStruct:getCostScore()
	return self._score
end

function BuildStruct:setBuildId(arg_27_1)
	self._buildId = arg_27_1
end

function BuildStruct:setCostHp(arg_28_1)
	self._hp = arg_28_1
end

function BuildStruct:setCostScore(arg_29_1)
	self._score = arg_29_1
end

function BuildStruct:isHasUserAlive()
	for iter_30_0, iter_30_1 in pairs(self._userDick) do
		if iter_30_1:isAlive() then
			return true
		end
	end

	return false
end

function BuildStruct:isBuildAlive()
	return self:getCostHp() < self._cfg.build_hp
end

local GuildWarCityStruct = class("GuildWarCityStruct")

function GuildWarCityStruct:ctor()
	self._guildId = 0
	self._user = nil
	self._buildings = {}
end

function GuildWarCityStruct:updateData(arg_33_1)
	if not arg_33_1.buildings then
		return
	end

	self:onResetBuild()

	for iter_33_0, iter_33_1 in pairs(arg_33_1.buildings) do
		self:getBuildById(iter_33_1.build_id):updatePosition(iter_33_1)
	end
end

function GuildWarCityStruct:setGuildId(arg_34_1)
	self._guildId = arg_34_1
end

function GuildWarCityStruct:onResetBuild()
	for iter_35_0, iter_35_1 in pairs(self._buildings) do
		iter_35_1:setResetBuild()
	end
end

function GuildWarCityStruct:getBuildById(arg_36_1)
	local var_36_0 = self._buildings[arg_36_1]

	if not self._buildings[arg_36_1] then
		var_36_0 = BuildStruct.new(arg_36_1)
		self._buildings[arg_36_1] = var_36_0
	end

	return var_36_0
end

function GuildWarCityStruct:isMyGuild()
	if self._guildId > 0 then
		return g.core.model.User.guildData:getGuildId() == self._guildId
	end

	return false
end

function GuildWarCityStruct:getBuildByPlayerId(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(self._buildings) do
		for iter_38_2, iter_38_3 in pairs((iter_38_1:getUsers())) do
			if iter_38_3:isMyId(arg_38_1) then
				return iter_38_1
			end
		end
	end

	return nil
end

function GuildWarCityStruct:onSwapBuildUser(arg_39_1)
	local var_39_0 = self:getBuildById(arg_39_1.build_id):getUserByPosition(arg_39_1.build_pos)
	local var_39_1 = self:getBuildById(arg_39_1.swap_build_id):getUserByPosition(arg_39_1.swap_build_pos)
	local var_39_2 = var_39_0:getBaseData()
	local var_39_3 = var_39_1:getBaseData()

	if var_39_3 then
		var_39_0:updateByData(var_39_3, arg_39_1.swap_build_id)
	else
		var_39_0:setEmptyUser()
	end

	if var_39_2 then
		var_39_1:updateByData(var_39_2, arg_39_1.build_id)
	else
		var_39_1:setEmptyUser()
	end
end

function GuildWarCityStruct:getAllUpLineUserNum()
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in pairs(self._buildings) do
		for iter_40_2, iter_40_3 in pairs((iter_40_1:getUsers())) do
			if iter_40_3:getUser() then
				var_40_0 = var_40_0 + 1
			end
		end
	end

	return var_40_0
end

return GuildWarCityStruct
