local SpireMonsterStruct = class("SpireMonsterStruct")

function SpireMonsterStruct:ctor()
	self._embryoTab = {
		knight_id = {},
		artifact_id = {},
		unite_token = {},
		pet = {}
	}
	self._cfg = nil
	self._useMonster = false
	self._owner = nil
end

function SpireMonsterStruct:updateMonsterInfoById(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_3 then
		self:_updateMonsterByMonsterTab(arg_2_1)
	else
		self:_updateMonsterByMassiveTab(arg_2_1)
	end

	self._owner = arg_2_2
end

function SpireMonsterStruct:_updateMonsterByMassiveTab(arg_3_1)
	self._useMonster = false
	self._cfg = g.core.config.massive_monster_team_info.get(arg_3_1)

	for iter_3_0, iter_3_1 in pairs(self._embryoTab) do
		local var_3_0 = {}
		local var_3_1 = 1
		local var_3_2 = {
			iter_3_0
		}

		var_3_2[2] = 1

		local var_3_3 = table.concat(var_3_2, "_")

		while g.core.config.massive_monster_team_info.hasKey(var_3_3) do
			if self._cfg[var_3_3] ~= 0 then
				var_3_0[#var_3_0 + 1] = self._cfg[var_3_3]
			end

			var_3_1 = var_3_1 + 1
			var_3_3 = table.concat({
				iter_3_0,
				var_3_1
			}, "_")
		end

		self._embryoTab[iter_3_0] = var_3_0
	end
end

function SpireMonsterStruct:_updateMonsterByMonsterTab(arg_4_1)
	self._useMonster = true
	self._cfg = g.core.config.monster_team_info.get(arg_4_1, 1)

	local var_4_0 = {}
	local var_4_1 = 1
	local var_4_2 = {
		"monster"
	}

	var_4_2[2] = 1

	local var_4_3 = table.concat(var_4_2, "_")

	while g.core.config.monster_team_info.hasKey(var_4_3) do
		if self._cfg[var_4_3] ~= 0 then
			var_4_0[#var_4_0 + 1] = self._cfg[var_4_3]
		end

		var_4_1 = var_4_1 + 1
		var_4_3 = table.concat({
			"monster",
			var_4_1
		}, "_")
	end

	self._embryoTab.knight_id = var_4_0

	local var_4_4 = {}
	local var_4_5 = 1
	local var_4_6 = {
		"unite_token"
	}

	var_4_6[2] = 1

	local var_4_7 = table.concat(var_4_6, "_")

	while g.core.config.monster_team_info.hasKey(var_4_7) do
		if self._cfg[var_4_7] ~= 0 then
			var_4_4[#var_4_4 + 1] = self._cfg[var_4_7]
		end

		var_4_5 = var_4_5 + 1
		var_4_7 = table.concat({
			"unite_token",
			var_4_5
		}, "_")
	end

	self._embryoTab.unite_token = var_4_4

	local var_4_8 = {}
	local var_4_9 = 1
	local var_4_10 = {
		"pet"
	}

	var_4_10[2] = 1

	local var_4_11 = table.concat(var_4_10, "_")

	while g.core.config.monster_team_info.hasKey(var_4_11) do
		if self._cfg[var_4_11] ~= 0 then
			var_4_8[#var_4_8 + 1] = self._cfg[var_4_11]
		end

		var_4_9 = var_4_9 + 1
		var_4_11 = table.concat({
			"pet",
			var_4_9
		}, "_")
	end

	self._embryoTab.pet = var_4_8
end

function SpireMonsterStruct:getShowKnightInfo()
	local var_5_0 = self._useMonster and g.core.config.monster_info.get(self._embryoTab.knight_id[1]) or g.core.config.knight_info.get(self._embryoTab.knight_id[1])

	return var_5_0, (g.core.config.knight_base_info.get(var_5_0.advance_id))
end

function SpireMonsterStruct:getShowKnightId()
	return g.core.config.knight_base_info.get((self._useMonster and g.core.config.monster_info.get(self._embryoTab.knight_id[1]) or g.core.config.knight_info.get(self._embryoTab.knight_id[1])).advance_id).fight_id
end

function SpireMonsterStruct:getShowKnightName()
	return (self._useMonster and g.core.config.monster_info.get(self._embryoTab.knight_id[1]) or g.core.config.knight_info.get(self._embryoTab.knight_id[1])).name
end

function SpireMonsterStruct:getShowSkillList()
	local var_8_0 = self._useMonster and g.core.config.monster_info or g.core.config.knight_info
	local var_8_1 = var_8_0.get(self._embryoTab.knight_id[1])
	local var_8_2 = {}

	if var_8_1.common_id ~= 0 then
		table.insert(var_8_2, {
			isPassive = false,
			isForceStyle = true,
			star = 0,
			skillId = var_8_1.common_id
		})
	end

	if var_8_1.active_skill_id ~= 0 then
		table.insert(var_8_2, {
			isPassive = false,
			isForceStyle = true,
			star = 0,
			skillId = var_8_1.active_skill_id
		})
	end

	local var_8_3 = 1
	local var_8_4 = {
		"passive_skill"
	}

	var_8_4[2] = 1

	local var_8_5 = table.concat(var_8_4, "_")

	while var_8_0.hasKey(var_8_5) do
		if var_8_1[var_8_5] ~= 0 then
			table.insert(var_8_2, {
				isPassive = true,
				isForceStyle = true,
				star = 0,
				skillId = var_8_1[var_8_5]
			})
		end

		var_8_3 = var_8_3 + 1
		var_8_5 = table.concat({
			"passive_skill",
			var_8_3
		}, "_")
	end

	if var_8_1.energy_skill_id ~= 0 then
		table.insert(var_8_2, {
			isPassive = false,
			isForceStyle = true,
			star = 0,
			skillId = var_8_1.energy_skill_id
		})
	end

	return var_8_2
end

function SpireMonsterStruct:getEmbryoList(arg_9_1)
	return self._embryoTab[arg_9_1]
end

function SpireMonsterStruct:clearOwnerRef()
	if self._owner then
		self._owner:clearMonsterRef()
	end
end

return SpireMonsterStruct
