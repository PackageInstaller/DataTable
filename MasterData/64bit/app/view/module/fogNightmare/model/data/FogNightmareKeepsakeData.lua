local FogNightmareKeepsakeData = class("FogNightmareKeepsakeData")
local FogNightmareKeepsakeStruct = require("app.view.module.fogNightmare.model.struct.FogNightmareKeepsakeStruct")
local FogNightmareKeepsakeSuitStruct = require("app.view.module.fogNightmare.model.struct.FogNightmareKeepsakeSuitStruct")
local var_0_3 = g.core.config.fog_seal_info
local var_0_4 = g.core.config.fog_seal_suit_info
local var_0_5 = g.core.config.fog_seal_level_info

function FogNightmareKeepsakeData:ctor()
	self._keepsakeData = {}
	self._keepsakeCfgMap = {}
	self._keepsakeSuitMap = {}
	self._checkDic = {
		knight = {},
		profession = {}
	}
	self._isSelectSkipPop = false
	self._allSuitLoaded = false
end

function FogNightmareKeepsakeData:initData()
	self._keepsakeData = {}
	self._keepsakeCfgMap = {}
	self._keepsakeStructData = {}
	self._keepsakeKnightData = {}
	self._keepsakeProfessionData = {}
	self._keepsakeBookData = {}

	for iter_2_0 = 1, var_0_3.getLength() do
		local var_2_0 = var_0_3.indexOf(iter_2_0)

		if self._keepsakeBookData[var_2_0.suit_id] then
			table.insert(self._keepsakeBookData[var_2_0.suit_id], var_2_0)
		else
			self._keepsakeBookData[var_2_0.suit_id] = {
				var_2_0
			}
		end
	end

	for iter_2_1 = 1, var_0_5.getLength() do
		local var_2_1 = var_0_5.indexOf(iter_2_1)
		local var_2_2 = var_0_3.get(var_2_1.seal_id)

		self._keepsakeCfgMap[var_2_2.type] = self._keepsakeCfgMap[var_2_2.type] or {}
		self._keepsakeCfgMap[var_2_2.type][var_2_1.seal_id] = self._keepsakeCfgMap[var_2_2.type][var_2_1.seal_id] or {}

		table.insert(self._keepsakeCfgMap[var_2_2.type][var_2_1.seal_id], var_2_1.id)
	end

	self._keepsakeSuitMap = {}
end

function FogNightmareKeepsakeData:_initAllSuitInfo()
	for iter_3_0 = 1, var_0_4.getLength() do
		self:getSuitInfo(var_0_4.indexOf(iter_3_0).id)
	end

	self._allSuitLoaded = true
end

function FogNightmareKeepsakeData:updateData(arg_4_1)
	return
end

function FogNightmareKeepsakeData:getUnlockKeepsakeBookDataList(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self._keepsakeBookData) do
		local var_5_1 = self:getKeepsakeBookDataByTabAndLevel(iter_5_0, arg_5_1)

		if #var_5_1 > 0 then
			local var_5_2 = {
				data = var_5_1,
				suitId = iter_5_0
			}

			var_5_2.name = iter_5_0 == 0 and g.core.lang:get(500232) or self:getSuitInfo(iter_5_0):getCfg().name

			table.insert(var_5_0, var_5_2)
		end
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		return arg_6_0.suitId < arg_6_1.suitId
	end)

	return var_5_0
end

function FogNightmareKeepsakeData:getKeepsakeBookDataByTabAndLevel(arg_7_1, arg_7_2)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self._keepsakeBookData[arg_7_1]) do
		if arg_7_2 >= iter_7_1.unlock_level then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function FogNightmareKeepsakeData:getKeepsakeStructsByTypeAndId(arg_8_1, arg_8_2)
	if self._keepsakeCfgMap[arg_8_1][arg_8_2] then
		for iter_8_0, iter_8_1 in ipairs(self._keepsakeCfgMap[arg_8_1][arg_8_2]) do
			self:getKeepsakeStructById(iter_8_1)
		end

		self._keepsakeCfgMap[arg_8_1][arg_8_2] = nil
	end

	return self._keepsakeData[arg_8_1][arg_8_2]
end

function FogNightmareKeepsakeData:getKeepsakeStructById(arg_9_1)
	local var_9_0 = self._keepsakeStructData[arg_9_1]

	if not self._keepsakeStructData[arg_9_1] then
		var_9_0 = self:_createKeepsakeStruct(arg_9_1)
		self._keepsakeStructData[arg_9_1] = var_9_0
	end

	return var_9_0
end

function FogNightmareKeepsakeData:getKeepsakeStructsBySuitId(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self._keepsakeStructData) do
		if arg_10_1 == iter_10_1:getBaseInfo().suit_id then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function FogNightmareKeepsakeData:getIsSelectSkipPop()
	return self._isSelectSkipPop
end

function FogNightmareKeepsakeData:setIsSelectSkipPop(arg_12_1)
	self._isSelectSkipPop = arg_12_1 == true
end

function FogNightmareKeepsakeData:_checkAndCreateKeepsakeKnightData(arg_13_1)
	local var_13_0 = {}

	for iter_13_0 = 1, g.core.config.fog_seal_info.getLength() do
		local var_13_1 = g.core.config.fog_seal_info.indexOf(iter_13_0)
		local var_13_2 = 1

		while g.core.config.fog_seal_info.hasKey("knight_" .. 1) do
			if var_13_1["knight_" .. 1] == arg_13_1 then
				var_13_0[var_13_1.seal_id] = true

				break
			end

			var_13_2 = var_13_2 + 1
		end
	end

	for iter_13_1 = 1, g.core.config.fog_seal_level_info.getLength() do
		local var_13_4 = g.core.config.fog_seal_level_info.indexOf(iter_13_1)

		if var_13_0[var_13_4.seal_id] then
			self:getKeepsakeStructById(var_13_4.id)
		end
	end

	self._checkDic.knight[arg_13_1] = true
end

function FogNightmareKeepsakeData:_checkAndCreateKeepsakeProfessionData(arg_14_1)
	local var_14_0 = {}

	for iter_14_0 = 1, g.core.config.fog_seal_info.getLength() do
		local var_14_1 = g.core.config.fog_seal_info.indexOf(iter_14_0)
		local var_14_2 = 1

		while g.core.config.fog_seal_info.hasKey("profession_" .. 1) do
			if var_14_1["profession_" .. 1] == arg_14_1 then
				var_14_0[var_14_1.seal_id] = true

				break
			end

			var_14_2 = var_14_2 + 1
		end
	end

	for iter_14_1 = 1, g.core.config.fog_seal_level_info.getLength() do
		local var_14_4 = g.core.config.fog_seal_level_info.indexOf(iter_14_1)

		if var_14_0[var_14_4.seal_id] then
			self:getKeepsakeStructById(var_14_4.id)
		end
	end

	self._checkDic.profession[arg_14_1] = true
end

function FogNightmareKeepsakeData:getNormalKeepsakeStructsByKnightIdAndLv(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = {}
	local var_15_1 = {}

	if arg_15_1 and not self._checkDic.knight[arg_15_1] then
		self:_checkAndCreateKeepsakeKnightData(arg_15_1)
	end

	if self._keepsakeKnightData[arg_15_1] then
		for iter_15_0, iter_15_1 in pairs(self._keepsakeKnightData[arg_15_1]) do
			if iter_15_0 == arg_15_2 then
				for iter_15_2, iter_15_3 in ipairs(iter_15_1) do
					if iter_15_3:getBaseInfo().type == 1 then
						table.insert(var_15_0, iter_15_3)

						var_15_1[iter_15_3:getCfg().id] = true
					end
				end
			end
		end
	end

	if arg_15_3 and not self._checkDic.profession[arg_15_3] then
		self:_checkAndCreateKeepsakeProfessionData(arg_15_3)
	end

	if self._keepsakeProfessionData[arg_15_3] then
		for iter_15_4, iter_15_5 in pairs(self._keepsakeProfessionData[arg_15_3]) do
			if iter_15_4 == arg_15_2 then
				for iter_15_6, iter_15_7 in ipairs(iter_15_5) do
					if iter_15_7:getBaseInfo().type == 1 and not var_15_1[iter_15_7:getCfg().id] then
						table.insert(var_15_0, iter_15_7)
					end
				end
			end
		end
	end

	return var_15_0
end

function FogNightmareKeepsakeData:clearSuitMap()
	for iter_16_0, iter_16_1 in pairs(self._keepsakeSuitMap) do
		iter_16_1:removeAllKeepsake()
	end
end

function FogNightmareKeepsakeData:getSuitInfo(arg_17_1)
	if not arg_17_1 then
		if not self._allSuitLoaded then
			self:_initAllSuitInfo()
		end

		return self._keepsakeSuitMap
	elseif arg_17_1 ~= 0 then
		local var_17_0 = self._keepsakeSuitMap[arg_17_1]

		if not self._keepsakeSuitMap[arg_17_1] then
			var_17_0 = self:_createKeepsakeSuitStruct(arg_17_1)
			self._keepsakeSuitMap[arg_17_1] = var_17_0
		end

		return var_17_0
	end
end

function FogNightmareKeepsakeData:addKeepsakeToSuit(arg_18_1)
	local var_18_0 = arg_18_1:getBaseInfo().suit_id

	if var_18_0 > 0 then
		self:getSuitInfo(var_18_0):addActiveKeepsake(arg_18_1)
	end
end

function FogNightmareKeepsakeData:removeKeepsakeFromSuit(arg_19_1)
	local var_19_0 = arg_19_1:getBaseInfo().suit_id

	if var_19_0 > 0 then
		self:getSuitInfo(var_19_0):removeActiveKeepsake(arg_19_1)
	end
end

function FogNightmareKeepsakeData:_createKeepsakeStruct(arg_20_1)
	local var_20_0 = var_0_5.get(arg_20_1)
	local var_20_1 = FogNightmareKeepsakeStruct.new(var_20_0.id)
	local var_20_2 = var_0_3.get(var_20_0.seal_id)

	if self._keepsakeData[var_20_2.type] then
		if self._keepsakeData[var_20_2.type][var_20_0.seal_id] then
			table.insert(self._keepsakeData[var_20_2.type][var_20_0.seal_id], var_20_1)
		else
			self._keepsakeData[var_20_2.type][var_20_0.seal_id] = {
				var_20_1
			}
		end
	else
		self._keepsakeData[var_20_2.type] = {}
		self._keepsakeData[var_20_2.type][var_20_0.seal_id] = {
			var_20_1
		}
	end

	local var_20_3 = 1

	while var_0_3.hasKey("knight_" .. var_20_3) do
		if var_20_2["knight_" .. var_20_3] > 0 then
			if self._keepsakeKnightData[var_20_2["knight_" .. var_20_3]] then
				if self._keepsakeKnightData[var_20_2["knight_" .. var_20_3]][var_20_0.level] then
					table.insert(self._keepsakeKnightData[var_20_2["knight_" .. var_20_3]][var_20_0.level], var_20_1)
				else
					self._keepsakeKnightData[var_20_2["knight_" .. var_20_3]][var_20_0.level] = {
						var_20_1
					}
				end
			else
				self._keepsakeKnightData[var_20_2["knight_" .. var_20_3]] = {}
				self._keepsakeKnightData[var_20_2["knight_" .. var_20_3]][var_20_0.level] = {
					var_20_1
				}
			end
		end

		var_20_3 = var_20_3 + 1
	end

	local var_20_4 = 1

	while var_0_3.hasKey("profession_" .. var_20_4) do
		if var_20_2["profession_" .. var_20_4] > 0 then
			if self._keepsakeProfessionData[var_20_2["profession_" .. var_20_4]] then
				if self._keepsakeProfessionData[var_20_2["profession_" .. var_20_4]][var_20_0.level] then
					table.insert(self._keepsakeProfessionData[var_20_2["profession_" .. var_20_4]][var_20_0.level], var_20_1)
				else
					self._keepsakeProfessionData[var_20_2["profession_" .. var_20_4]][var_20_0.level] = {
						var_20_1
					}
				end
			else
				self._keepsakeProfessionData[var_20_2["profession_" .. var_20_4]] = {}
				self._keepsakeProfessionData[var_20_2["profession_" .. var_20_4]][var_20_0.level] = {
					var_20_1
				}
			end
		end

		var_20_4 = var_20_4 + 1
	end

	return var_20_1
end

function FogNightmareKeepsakeData:_createKeepsakeSuitStruct(arg_21_1)
	return (FogNightmareKeepsakeSuitStruct.new((var_0_4.get(arg_21_1))))
end

return FogNightmareKeepsakeData
