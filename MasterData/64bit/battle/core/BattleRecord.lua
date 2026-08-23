local var_0_0 = {}

var_0_0.TYPE_DAM = 1
var_0_0.TYPE_RECOVER = 2
var_0_0.TYPE_TAKE_DAM = 3
var_0_0.TYPE_NORMAL_SKILL = 4
var_0_0.TYPE_SKILL = 5
var_0_0.TYPE_SKILL_DAM = 6

function var_0_0.init(arg_1_0)
	arg_1_0._keyList = {}
	arg_1_0._infoList = {
		{},
		{}
	}
	arg_1_0._winInfo = {}
	arg_1_0._petSkills = {}
	arg_1_0._unitePassiveCombo = {}
	arg_1_0._succubaSkills = {}
end

function var_0_0.recordArtifact(arg_2_0)
	arg_2_0._recordArtifact = true
end

function var_0_0.recordMagic(arg_3_0)
	arg_3_0._recordMagic = true
end

function var_0_0:initRecord(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._keyList = {}
	self._infoList = {
		{},
		{}
	}

	self:setRecord(1, arg_4_1, nil, arg_4_3)
	self:setRecord(2, arg_4_2, nil, arg_4_4)
end

function var_0_0:initRecordAll(arg_5_1, arg_5_2)
	self._keyList = {}
	self._infoList = {
		{},
		{}
	}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self:setRecord(1, iter_5_1, false, iter_5_0)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_2) do
		self:setRecord(2, iter_5_3, false, iter_5_2)
	end
end

function var_0_0:setRecord(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_2.monster_team_id and arg_6_2.monster_team_id > 0 or false

	for iter_6_0 = 1, #arg_6_2.units do
		local var_6_1 = arg_6_2.units[iter_6_0]
		local var_6_2 = ((arg_6_4 or nil) and (arg_6_4 .. "_" or "1_")) .. "knight_" .. arg_6_1 .. "_" .. var_6_1.id .. "_" .. var_6_1.pos
		local var_6_3 = {}

		var_6_3.type = 1
		var_6_3.id = var_6_1.id
		var_6_3.dam = 0
		var_6_3.recover = 0
		var_6_3.take_dam = 0
		var_6_3.seq = arg_6_4

		if not var_6_0 then
			var_6_3.avartar_id = loadCfg("core.config.cfg.knight_info").get(var_6_1.id).type == 1 and (arg_6_2.user and (arg_6_2.user.dress_id or 0) or 0) or var_6_1.skin or 0
		end

		self._keyList[var_6_2] = var_6_3
		self._infoList[arg_6_1][#self._infoList[arg_6_1] + 1] = var_6_3
	end

	if arg_6_3 then
		return
	end

	if arg_6_2.succubas then
		for iter_6_1 = 1, #arg_6_2.succubas do
			local var_6_4 = arg_6_2.succubas[iter_6_1].id
			local var_6_5 = {}

			var_6_5.type = 6
			var_6_5.id = var_6_4
			var_6_5.dam = 0
			var_6_5.recover = 0
			var_6_5.take_dam = 0
			var_6_5.seq = arg_6_4
			self._keyList[((arg_6_4 or nil) and (arg_6_4 .. "_" or "1_")) .. "succuba_" .. arg_6_1 .. "_" .. var_6_4] = var_6_5
			self._infoList[arg_6_1][#self._infoList[arg_6_1] + 1] = var_6_5

			local var_6_6 = loadCfg("core.config.cfg.succuba_info").get(var_6_4)

			if var_6_6.passive_skill_1 > 0 then
				self._succubaSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_6.passive_skill_1).passive_skill_value] = var_6_4
			end

			if var_6_6.passive_skill_2 > 0 then
				self._succubaSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_6.passive_skill_2).passive_skill_value] = var_6_4
			end

			if var_6_6.passive_skill_3 > 0 then
				self._succubaSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_6.passive_skill_3).passive_skill_value] = var_6_4
			end

			if var_6_6.skill_id > 0 then
				self._succubaSkills[var_6_6.skill_id] = var_6_4
			end
		end
	end

	if self._recordArtifact then
		for iter_6_2 = 1, #arg_6_2.units do
			local var_6_7 = arg_6_2.units[iter_6_2].artifactId

			if arg_6_2.units[iter_6_2].artifactId and var_6_7 > 0 then
				local var_6_9 = {}

				var_6_9.type = 4
				var_6_9.id = var_6_7
				var_6_9.dam = 0
				var_6_9.recover = 0
				var_6_9.take_dam = 0
				var_6_9.seq = arg_6_4
				self._keyList[((arg_6_4 or nil) and (arg_6_4 .. "_" or "1_")) .. "artifact_" .. arg_6_1 .. "_" .. var_6_7] = var_6_9
				self._infoList[arg_6_1][#self._infoList[arg_6_1] + 1] = var_6_9
			end
		end
	end

	if self._recordMagic then
		for iter_6_3 = 1, #arg_6_2.units do
			local var_6_10 = arg_6_2.units[iter_6_3].magic_id

			if arg_6_2.units[iter_6_3].magic_id and var_6_10 > 0 then
				local var_6_12 = {}

				var_6_12.type = 5
				var_6_12.id = var_6_10
				var_6_12.dam = 0
				var_6_12.recover = 0
				var_6_12.take_dam = 0
				var_6_12.seq = arg_6_4
				self._keyList[((arg_6_4 or nil) and (arg_6_4 .. "_" or "1_")) .. "magic_" .. arg_6_1 .. "_" .. var_6_10] = var_6_12
				self._infoList[arg_6_1][#self._infoList[arg_6_1] + 1] = var_6_12
			end
		end
	end

	if arg_6_2.combo.tokens then
		for iter_6_4 = 1, #arg_6_2.combo.tokens do
			local var_6_13 = arg_6_2.combo.tokens[iter_6_4]
			local var_6_14 = {}

			var_6_14.type = 2
			var_6_14.id = var_6_13
			var_6_14.dam = 0
			var_6_14.recover = 0
			var_6_14.take_dam = 0
			var_6_14.seq = arg_6_4
			self._keyList[((arg_6_4 or nil) and (arg_6_4 .. "_" or "1_")) .. "unite_" .. arg_6_1 .. "_" .. var_6_13] = var_6_14
			self._infoList[arg_6_1][#self._infoList[arg_6_1] + 1] = var_6_14

			local var_6_15 = loadCfg("core.config.cfg.unite_token_info").get(var_6_13).passive_skill_id

			if var_6_15 > 0 then
				self._unitePassiveCombo[loadCfg("core.config.cfg.passive_skill_info").get(var_6_15).passive_skill_value] = var_6_13
			end
		end
	end

	if arg_6_2.pets then
		for iter_6_5 = 1, #arg_6_2.pets do
			local var_6_16 = arg_6_2.pets[iter_6_5]
			local var_6_17 = {}

			var_6_17.type = 3
			var_6_17.id = var_6_16
			var_6_17.dam = 0
			var_6_17.recover = 0
			var_6_17.take_dam = 0
			var_6_17.seq = arg_6_4
			self._keyList[((arg_6_4 or nil) and (arg_6_4 .. "_" or "1_")) .. "pet_" .. arg_6_1 .. "_" .. var_6_16] = var_6_17
			self._infoList[arg_6_1][#self._infoList[arg_6_1] + 1] = var_6_17

			local var_6_18 = loadCfg("core.config.cfg.pet_info").get(var_6_16)

			if var_6_18.passive_skill_1 > 0 then
				self._petSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_18.passive_skill_1).passive_skill_value .. "_" .. arg_6_1] = var_6_16
			end

			if var_6_18.passive_skill_2 > 0 then
				self._petSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_18.passive_skill_2).passive_skill_value .. "_" .. arg_6_1] = var_6_16
			end

			if var_6_18.passive_skill_3 > 0 then
				self._petSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_18.passive_skill_3).passive_skill_value .. "_" .. arg_6_1] = var_6_16
			end

			if var_6_18.link_passive_skill_1 > 0 then
				self._petSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_18.link_passive_skill_1).passive_skill_value .. "_" .. arg_6_1] = var_6_16
			end

			if var_6_18.link_passive_skill_2 > 0 then
				self._petSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_18.link_passive_skill_2).passive_skill_value .. "_" .. arg_6_1] = var_6_16
			end

			if var_6_18.link_passive_skill_3 > 0 then
				self._petSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_18.link_passive_skill_3).passive_skill_value .. "_" .. arg_6_1] = var_6_16
			end

			if arg_6_2.pet_advance_base_ids then
				local var_6_19 = #arg_6_2.pet_advance_base_ids or 0

				if var_6_19 > 0 then
					for iter_6_6 = 1, var_6_19 do
						local var_6_20 = loadCfg("core.config.cfg.pet_advance_info").get(arg_6_2.pet_advance_base_ids[iter_6_6])

						if var_6_18.advance_id == var_6_20.advance_id then
							if var_6_20.skill_1 > 0 then
								self._petSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_20.skill_1).passive_skill_value .. "_" .. arg_6_1] = var_6_16
							end

							if var_6_20.skill_2 > 0 then
								self._petSkills[loadCfg("core.config.cfg.passive_skill_info").get(var_6_20.skill_2).passive_skill_value .. "_" .. arg_6_1] = var_6_16
							end

							break
						end
					end
				end
			end
		end
	end
end

function var_0_0:addRecord(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = arg_7_2 == var_0_0.TYPE_TAKE_DAM and self:getInfoByVictim(arg_7_1, arg_7_5) or self:getInfoByAttacker(arg_7_1, arg_7_4, arg_7_5)

	if var_7_0 then
		if arg_7_2 == var_0_0.TYPE_DAM then
			var_7_0.dam = var_7_0.dam + arg_7_3
		elseif arg_7_2 == var_0_0.TYPE_RECOVER then
			var_7_0.recover = var_7_0.recover + arg_7_3
		elseif arg_7_2 == var_0_0.TYPE_TAKE_DAM then
			var_7_0.take_dam = var_7_0.take_dam + arg_7_3
		elseif arg_7_2 == var_0_0.TYPE_NORMAL_SKILL then
			var_7_0.normal_skill_num = var_7_0.normal_skill_num or 0
			var_7_0.normal_skill_num = var_7_0.normal_skill_num + arg_7_3
		elseif arg_7_2 == var_0_0.TYPE_SKILL then
			var_7_0.skill_num = var_7_0.skill_num or 0
			var_7_0.skill_num = var_7_0.skill_num + arg_7_3
		elseif arg_7_2 == var_0_0.TYPE_SKILL_DAM then
			var_7_0.skill_dam = var_7_0.skill_dam or 0
			var_7_0.skill_dam = var_7_0.skill_dam + arg_7_3
		end
	end
end

function var_0_0:getInfoByAttacker(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1.isPlayer then
		if arg_8_1.isPet then
			if not self._petSkills[arg_8_1.skillId .. "_" .. arg_8_1.identity] then
				return
			end

			local var_8_0 = (arg_8_3 .. "_") .. "pet_" .. arg_8_1.identity .. "_" .. self._petSkills[arg_8_1.skillId .. "_" .. arg_8_1.identity]

			if self._keyList[(arg_8_3 .. "_") .. "pet_" .. arg_8_1.identity .. "_" .. self._petSkills[arg_8_1.skillId .. "_" .. arg_8_1.identity]] then
				return self._keyList[var_8_0]
			else
				local var_8_1 = {}

				var_8_1.type = 3
				var_8_1.id = self._petSkills[arg_8_1.skillId .. "_" .. arg_8_1.identity]
				var_8_1.dam = 0
				var_8_1.recover = 0
				var_8_1.take_dam = 0
				self._keyList[var_8_0] = var_8_1
				self._infoList[arg_8_1.identity][#self._infoList[arg_8_1.identity] + 1] = var_8_1

				return var_8_1
			end
		elseif arg_8_1.isSpaceTime then
			-- block empty
		elseif arg_8_1.isSummon then
			if arg_8_1.originInfo.id then
				if self._keyList[(arg_8_3 .. "_") .. "knight_" .. arg_8_1.identity .. "_" .. arg_8_1.originInfo.id .. "_" .. arg_8_1.originInfo.pos] then
					return self._keyList[(arg_8_3 .. "_") .. "knight_" .. arg_8_1.identity .. "_" .. arg_8_1.originInfo.id .. "_" .. arg_8_1.originInfo.pos]
				end
			end
		elseif arg_8_1.isSuccuba then
			if not self._succubaSkills[arg_8_1.skillId] then
				return
			end

			if self._keyList[(arg_8_3 .. "_") .. "succuba_" .. arg_8_1.identity .. "_" .. self._succubaSkills[arg_8_1.skillId]] then
				return self._keyList[(arg_8_3 .. "_") .. "succuba_" .. arg_8_1.identity .. "_" .. self._succubaSkills[arg_8_1.skillId]]
			end
		elseif arg_8_1.isElemental then
			if self._keyList[(arg_8_3 .. "_") .. "elemental_" .. arg_8_1.identity .. "_" .. arg_8_1.skillId] then
				return self._keyList[(arg_8_3 .. "_") .. "elemental_" .. arg_8_1.identity .. "_" .. arg_8_1.skillId]
			else
				local var_8_2 = {}

				var_8_2.type = 7
				var_8_2.id = arg_8_1.skillId
				var_8_2.dam = 0
				var_8_2.recover = 0
				var_8_2.take_dam = 0
				self._keyList[(arg_8_3 .. "_") .. "elemental_" .. arg_8_1.identity .. "_" .. arg_8_1.skillId] = var_8_2
				self._infoList[arg_8_1.identity][#self._infoList[arg_8_1.identity] + 1] = var_8_2

				return var_8_2
			end
		else
			local var_8_3 = arg_8_1.id or self._unitePassiveCombo[arg_8_1.skillId]

			if not var_8_3 then
				return
			end

			local var_8_4 = (arg_8_3 .. "_") .. "unite_" .. arg_8_1.identity .. "_" .. var_8_3

			if self._keyList[(arg_8_3 .. "_") .. "unite_" .. arg_8_1.identity .. "_" .. var_8_3] then
				return self._keyList[var_8_4]
			else
				local var_8_5 = {}

				var_8_5.type = 2
				var_8_5.id = var_8_3
				var_8_5.dam = 0
				var_8_5.recover = 0
				var_8_5.take_dam = 0
				self._keyList[var_8_4] = var_8_5
				self._infoList[arg_8_1.identity][#self._infoList[arg_8_1.identity] + 1] = var_8_5

				return var_8_5
			end
		end
	else
		if self._recordArtifact and arg_8_2 then
			local var_8_6 = loadCfg("core.config.cfg.skill_info").get(arg_8_2)

			if var_8_6 and var_8_6.skill_type == 4 then
				if arg_8_1.baseData.artifactId and arg_8_1.baseData.artifactId > 0 then
					if self._keyList[(arg_8_3 .. "_") .. "artifact_" .. arg_8_1.identity .. "_" .. arg_8_1.baseData.artifactId] then
						return self._keyList[(arg_8_3 .. "_") .. "artifact_" .. arg_8_1.identity .. "_" .. arg_8_1.baseData.artifactId]
					end
				end
			end
		end

		if self._recordMagic and arg_8_2 then
			local var_8_7 = loadCfg("core.config.cfg.skill_info").get(arg_8_2)

			if var_8_7 and var_8_7.skill_type == 18 then
				if arg_8_1.baseData.magic_id and arg_8_1.baseData.magic_id > 0 then
					if self._keyList[(arg_8_3 .. "_") .. "magic_" .. arg_8_1.identity .. "_" .. arg_8_1.baseData.magic_id] then
						return self._keyList[(arg_8_3 .. "_") .. "magic_" .. arg_8_1.identity .. "_" .. arg_8_1.baseData.magic_id]
					end
				end
			end
		end

		local var_8_8 = (arg_8_3 .. "_") .. "knight_" .. arg_8_1.identity .. "_" .. arg_8_1.originInfo.id .. "_" .. arg_8_1.originInfo.pos

		if self._keyList[(arg_8_3 .. "_") .. "knight_" .. arg_8_1.identity .. "_" .. arg_8_1.originInfo.id .. "_" .. arg_8_1.originInfo.pos] then
			return self._keyList[var_8_8]
		else
			local var_8_9 = {}

			var_8_9.type = 1
			var_8_9.id = arg_8_1.originInfo.id
			var_8_9.dam = 0
			var_8_9.recover = 0
			var_8_9.take_dam = 0

			if not arg_8_1.isMonster then
				var_8_9.avartar_id = loadCfg("core.config.cfg.knight_info").get(arg_8_1.originInfo.id).type == 1 and (arg_8_1.user and (arg_8_1.user.avata_id or 0) or 0) or arg_8_1.baseData.skin or 0
			end

			self._keyList[var_8_8] = var_8_9
			self._infoList[arg_8_1.identity][#self._infoList[arg_8_1.identity] + 1] = var_8_9

			return var_8_9
		end
	end
end

function var_0_0:getInfoByVictim(arg_9_1, arg_9_2)
	if not arg_9_1.isPlayer then
		if self._keyList[arg_9_2 .. "_" .. "knight_" .. arg_9_1.identity .. "_" .. arg_9_1.originInfo.id .. "_" .. arg_9_1.originInfo.pos] then
			return self._keyList[arg_9_2 .. "_" .. "knight_" .. arg_9_1.identity .. "_" .. arg_9_1.originInfo.id .. "_" .. arg_9_1.originInfo.pos]
		else
			local var_9_0 = {}

			var_9_0.type = 1
			var_9_0.id = arg_9_1.originInfo.id
			var_9_0.dam = 0
			var_9_0.recover = 0
			var_9_0.take_dam = 0

			if not arg_9_1.isMonster then
				var_9_0.avartar_id = loadCfg("core.config.cfg.knight_info").get(arg_9_1.originInfo.id).type == 1 and (arg_9_1.user and (arg_9_1.user.avata_id or 0) or 0) or arg_9_1.baseData.skin or 0
			end

			self._keyList[arg_9_2 .. "_" .. "knight_" .. arg_9_1.identity .. "_" .. arg_9_1.originInfo.id .. "_" .. arg_9_1.originInfo.pos] = var_9_0
			self._infoList[arg_9_1.identity][#self._infoList[arg_9_1.identity] + 1] = var_9_0

			return var_9_0
		end
	end
end

function var_0_0:getRecord()
	return self._infoList
end

function var_0_0:getRecordNormal()
	local var_11_0 = clone(self._infoList)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			iter_11_3.normal_skill_num = nil
			iter_11_3.skill_num = nil
			iter_11_3.skill_dam = nil
		end
	end

	return var_11_0
end

function var_0_0:setWinInfo(arg_12_1, arg_12_2, arg_12_3)
	self._winInfo.is_win = arg_12_1 == 1
	self._winInfo.own_name = arg_12_2
	self._winInfo.enemy_name = arg_12_3
end

function var_0_0:getWinInfo()
	return self._winInfo
end

function var_0_0:getAttackerDamage()
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(self._infoList[1]) do
		var_14_0 = var_14_0 + iter_14_1.dam
	end

	return var_14_0
end

function var_0_0:storeRecord()
	if clone then
		self._storeRecord = clone(self._infoList)
	end
end

function var_0_0:getStoredRecord()
	return self._storeRecord
end

function var_0_0.resetCheckRecord(arg_17_0)
	arg_17_0._checkRecord = {}
end

function var_0_0:addCheckRecord(arg_18_1)
	self._checkRecord = self._checkRecord or {}
	self._checkRecord[#self._checkRecord + 1] = arg_18_1
end

function var_0_0:getCheckRecord()
	return self._checkRecord
end

return var_0_0
