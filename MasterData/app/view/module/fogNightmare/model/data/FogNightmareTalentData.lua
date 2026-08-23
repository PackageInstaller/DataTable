local FogNightmareTalentData = class("FogNightmareTalentData")
local FogNightmareTalentStruct = require("app.view.module.fogNightmare.model.struct.FogNightmareTalentStruct")
local var_0_2 = g.core.config.fog_talent_info
local var_0_3 = g.core.config.fog_talent_tab_info
local var_0_4 = g.core.config.fog_talent_addition_info

function FogNightmareTalentData:ctor()
	self._talentStructData = {}
	self._talentTabData = {}
	self._isSelectResetPop = false
	self._isSelectResetPopFree = false
	self._additionlevel = 0
	self._talentTabCostData = {}
	self._layerLevelData = {}
	self._layerUpgrade = 0
	self._hasUnlock = false
	self._extraRandTimes = 0
	self._additionLevelChange = false
	self._randSealDataMap = {}
	self._tabCheckedMap = {}
end

function FogNightmareTalentData:initData()
	self._talentStageData = {}
	self._tabCheckedMap = {}
	self._talentTabData = {}

	for iter_2_0 = 1, var_0_3.getLength() do
		table.insert(self._talentTabData, (var_0_3.indexOf(iter_2_0)))
	end

	table.sort(self._talentTabData, function(arg_3_0, arg_3_1)
		return arg_3_0.sort < arg_3_1.sort
	end)
end

function FogNightmareTalentData:updateData(arg_4_1)
	if arg_4_1.addition_level then
		if self._additionlevel ~= arg_4_1.addition_level and arg_4_1.isUpgrade then
			self._additionLevelChange = true
		end

		self._additionlevel = arg_4_1.addition_level
	end

	if arg_4_1.consume then
		for iter_4_0, iter_4_1 in pairs(arg_4_1.consume) do
			self._talentTabCostData[iter_4_1.tab] = iter_4_1.award
		end
	end

	if arg_4_1.nodes then
		for iter_4_2, iter_4_3 in pairs(self._layerLevelData) do
			for iter_4_4, iter_4_5 in pairs(iter_4_3) do
				self._layerLevelData[iter_4_2][iter_4_4] = 0
			end
		end

		for iter_4_6, iter_4_7 in pairs(arg_4_1.nodes) do
			self:_getTalentStruct(iter_4_7.id):updateInfo(iter_4_7.num)

			local var_4_0 = var_0_2.get(iter_4_7.id)

			self:getTalentDataByTab(var_4_0.tab)

			self._layerLevelData[var_4_0.tab][var_4_0.layer] = self._layerLevelData[var_4_0.tab][var_4_0.layer] + iter_4_7.num
		end

		for iter_4_8, iter_4_9 in pairs(self._talentStageData) do
			for iter_4_10, iter_4_11 in pairs(iter_4_9) do
				for iter_4_12, iter_4_13 in pairs(iter_4_11) do
					if iter_4_13:getCfg().layer ~= 1 and self._layerLevelData[iter_4_8][iter_4_13:getCfg().layer - 1] >= iter_4_13:getCfg().previous_layer_level then
						iter_4_13:setIsUnLock(true, true)
					end
				end
			end
		end
	end

	if arg_4_1.node_level then
		local var_4_1 = self:_getTalentStruct(arg_4_1.node_id)

		var_4_1:updateInfo(arg_4_1.node_level)
		var_4_1:setUpgrade(true)

		self._layerUpgrade = var_4_1:getCfg().layer

		local var_4_2 = var_0_2.get(arg_4_1.node_id)

		self._layerLevelData[var_4_2.tab][var_4_2.layer] = self._layerLevelData[var_4_2.tab][var_4_2.layer] + 1

		self:getTalentDataByTab(var_4_2.tab)

		if self._talentStageData[var_4_2.tab][var_4_2.layer + 1] then
			for iter_4_14, iter_4_15 in pairs(self._talentStageData[var_4_2.tab][var_4_2.layer + 1]) do
				if iter_4_15:getCfg().previous_layer_level == self._layerLevelData[var_4_2.tab][var_4_2.layer] then
					iter_4_15:setIsUnLock(true)

					self._hasUnlock = true
				end
			end
		end
	end

	self._extraRandTimes = 0

	for iter_4_16, iter_4_17 in pairs(self._talentStructData) do
		self._extraRandTimes = self._extraRandTimes + iter_4_17:getExtraRandNum()
	end
end

function FogNightmareTalentData:resetData(arg_5_1)
	if arg_5_1.ret == 1 then
		if arg_5_1.addition_level then
			self._additionlevel = arg_5_1.addition_level
		end

		self._talentTabCostData[arg_5_1.tab] = nil

		for iter_5_0, iter_5_1 in pairs(self._talentStageData[arg_5_1.tab]) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				iter_5_3:updateInfo(iter_5_3:getInitLevel())

				if iter_5_3:getCfg().layer ~= 1 then
					iter_5_3:setIsUnLock(false)
				end
			end
		end

		for iter_5_4, iter_5_5 in pairs(self._layerLevelData[arg_5_1.tab]) do
			self._layerLevelData[arg_5_1.tab][iter_5_4] = 0
		end

		self._extraRandTimes = 0

		for iter_5_6, iter_5_7 in pairs(self._talentStructData) do
			self._extraRandTimes = self._extraRandTimes + iter_5_7:getExtraRandNum()
		end
	end
end

function FogNightmareTalentData:getTalentTabData()
	return self._talentTabData
end

function FogNightmareTalentData:getTalentDataByTab(arg_7_1)
	local var_7_0 = g.core.model.User.fogNightmareData:getWeeklyBuff()

	if not self._tabCheckedMap[arg_7_1] then
		self:_createTalentStructListByTabType(arg_7_1)
	end

	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(self._talentStageData[arg_7_1]) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			local var_7_2 = false

			if iter_7_3:isSpecial() and var_7_0 and var_7_0.id == iter_7_3:getCfg().weekly_buff_id then
				var_7_2 = true
			elseif not iter_7_3:isSpecial() then
				var_7_2 = true
			end

			if var_7_2 then
				var_7_1[iter_7_0] = var_7_1[iter_7_0] or {}

				table.insert(var_7_1[iter_7_0], iter_7_3)
			end
		end
	end

	return var_7_1
end

function FogNightmareTalentData:getTalentDataByTabAndLayer(arg_8_1, arg_8_2)
	if not self._talentStageData[arg_8_1] then
		self:_createTalentStructListByTabType(arg_8_1)
	end

	return self._talentStageData[arg_8_1][arg_8_2]
end

function FogNightmareTalentData:getCurTalentStatus(arg_9_1)
	if not self._talentStageData[arg_9_1] then
		self:_createTalentStructListByTabType(arg_9_1)
	end

	local var_9_0 = self._talentStageData[arg_9_1]

	for iter_9_0 = 1, #self._talentStageData[arg_9_1] do
		for iter_9_1 = 1, #var_9_0[iter_9_0] do
			if var_9_0[iter_9_0][iter_9_1].isUnLock then
				-- block empty
			end
		end
	end
end

function FogNightmareTalentData:getTalentTabCostNumList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self._talentTabData) do
		var_10_0[iter_10_0] = {
			info = self._talentTabData[iter_10_0],
			costNum = (self._talentTabCostData[iter_10_0] or nil) and (self._talentTabCostData[iter_10_0][1] and self._talentTabCostData[iter_10_0][1].size or 0)
		}
	end

	return var_10_0
end

function FogNightmareTalentData:getTalentTabCostNumByTab(arg_11_1)
	return self._talentTabCostData[arg_11_1]
end

function FogNightmareTalentData:getIsSelectResetPop()
	return self._isSelectResetPop
end

function FogNightmareTalentData:setIsSelectResetPop(arg_13_1)
	self._isSelectResetPop = arg_13_1 == true
end

function FogNightmareTalentData:getIsSelectResetPopFree()
	return self._isSelectResetPopFree
end

function FogNightmareTalentData:setIsSelectResetPopFree(arg_15_1)
	self._isSelectResetPopFree = arg_15_1 == true
end

function FogNightmareTalentData:getAdditionLv()
	return self._additionlevel
end

function FogNightmareTalentData:getTotalAddition(arg_17_1)
	local var_17_0 = {}

	for iter_17_0 = 1, var_0_4.getLength() do
		local var_17_1 = var_0_4.indexOf(iter_17_0)

		if arg_17_1 >= var_17_1.addition_level then
			local var_17_2 = 1

			while var_0_4.hasKey("affect_type_" .. var_17_2) do
				var_17_0[var_17_1["affect_type_" .. var_17_2]] = var_17_0[var_17_1["affect_type_" .. var_17_2]] and var_17_0[var_17_1["affect_type_" .. var_17_2]] + var_17_1["affect_value_" .. var_17_2] or var_17_1["affect_value_" .. var_17_2]
				var_17_2 = var_17_2 + 1
			end
		end
	end

	local var_17_3 = {}

	for iter_17_1, iter_17_2 in pairs(var_17_0) do
		if iter_17_1 >= 0 and iter_17_2 > 0 then
			table.insert(var_17_3, {
				key = iter_17_1,
				value = iter_17_2
			})
		end
	end

	return var_17_3
end

function FogNightmareTalentData:getLevelAddition()
	local var_18_0 = {}

	for iter_18_0 = 1, var_0_4.getLength() do
		table.insert(var_18_0, (var_0_4.indexOf(iter_18_0)))
	end

	return var_18_0
end

function FogNightmareTalentData:getLayerLevelByTabAndLayer(arg_19_1, arg_19_2)
	return self._layerLevelData[arg_19_1][arg_19_2]
end

function FogNightmareTalentData:getLayerUpgrade()
	return self._layerUpgrade
end

function FogNightmareTalentData:setLayerUpgrade(arg_21_1)
	self._layerUpgrade = arg_21_1
end

function FogNightmareTalentData:getHasUnlock()
	return self._hasUnlock
end

function FogNightmareTalentData:setHasUnlock(arg_23_1)
	self._hasUnlock = arg_23_1
end

function FogNightmareTalentData:getAdditionLvChange()
	return self._additionLevelChange
end

function FogNightmareTalentData:setAdditionLvChange(arg_25_1)
	self._additionLevelChange = arg_25_1
end

function FogNightmareTalentData:setRandSealDataDirectly(arg_26_1)
	self._randSealData = arg_26_1
end

function FogNightmareTalentData:setRandSealData(arg_27_1)
	self._randSealData = arg_27_1.rand_seals
end

function FogNightmareTalentData:getRandSealData(arg_28_1)
	return self._randSealData
end

function FogNightmareTalentData:setRandSealDataMap(arg_29_1)
	arg_29_1 = arg_29_1 or {}
	self._randSealDataMap = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		self._randSealDataMap[iter_29_1.floor] = iter_29_1
	end
end

function FogNightmareTalentData:updateRandSealDataMapItem(arg_30_1, arg_30_2)
	self._randSealDataMap[arg_30_1].seals = arg_30_2
end

function FogNightmareTalentData:onRemoveRandSealDataMapItem(arg_31_1)
	self._randSealDataMap[arg_31_1] = nil
end

function FogNightmareTalentData:getRandSealDataMap()
	return self._randSealDataMap
end

function FogNightmareTalentData:getExtraRandTimes()
	return self._extraRandTimes
end

function FogNightmareTalentData:getEffectByTypeValueAndIndex(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in pairs(self._talentStructData) do
		local var_34_1 = iter_34_1:getEffectByTypeValueAndIndex(arg_34_1, arg_34_2, arg_34_3)

		if var_34_1 then
			var_34_0 = var_34_0 + var_34_1
		end
	end

	return var_34_0
end

function FogNightmareTalentData:getCanUpgradeNodes()
	local var_35_0 = {}

	if not next(self._talentStructData) then
		self:getTalentDataByTab(1)
	end

	for iter_35_0, iter_35_1 in pairs(self._talentStructData) do
		if iter_35_1.isUnLock then
			table.insert(var_35_0, iter_35_1)
		end
	end

	return var_35_0
end

function FogNightmareTalentData:_createTalentStructListByTabType(arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(var_0_2.match(function(arg_37_0)
		return arg_37_0.tab == arg_36_1
	end) or {}) do
		self:_getTalentStruct(iter_36_1.talent_id)
	end

	self._tabCheckedMap[arg_36_1] = true
end

function FogNightmareTalentData:_getTalentStruct(arg_38_1)
	local var_38_0 = self._talentStructData[arg_38_1]

	if not self._talentStructData[arg_38_1] then
		var_38_0 = self:_createTalentStruct(arg_38_1)
		self._talentStructData[arg_38_1] = var_38_0

		local var_38_1 = var_38_0:getCfg()

		if self._layerLevelData[var_38_1.tab] then
			self._layerLevelData[var_38_1.tab][var_38_1.layer] = 0
		else
			self._layerLevelData[var_38_1.tab] = {}
			self._layerLevelData[var_38_1.tab][var_38_1.layer] = 0
		end
	end

	return var_38_0
end

function FogNightmareTalentData:_createTalentStruct(arg_39_1)
	local var_39_0 = var_0_2.get(arg_39_1)
	local var_39_1 = FogNightmareTalentStruct.new(var_39_0.talent_id)

	if self._talentStageData[var_39_0.tab] then
		if self._talentStageData[var_39_0.tab][var_39_0.layer] then
			table.insert(self._talentStageData[var_39_0.tab][var_39_0.layer], var_39_1)
		else
			self._talentStageData[var_39_0.tab][var_39_0.layer] = {
				var_39_1
			}
		end
	else
		self._talentStageData[var_39_0.tab] = {}
		self._talentStageData[var_39_0.tab][var_39_0.layer] = {
			var_39_1
		}
	end

	if var_39_0.layer == 1 then
		var_39_1:setIsUnLock(true, true)
	end

	return var_39_1
end

return FogNightmareTalentData
