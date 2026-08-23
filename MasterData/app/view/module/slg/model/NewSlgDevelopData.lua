local var_0_0 = g.core.model.User.newSlgData
local var_0_1 = g.core.model.User.bagData
local NewSlgDevelopData = class("NewSlgDevelopData", require("app.core.model.BaseData"))
local var_0_3 = g.core.const.ConstMgr.NewSlgConst
local var_0_4 = g.core.config.new_slg_army_info
local var_0_5 = g.core.config.new_slg_supply_info
local var_0_6 = g.core.config.new_slg_main_city_authority_info
local var_0_7 = g.core.config.new_slg_main_city_info
local var_0_8 = g.core.config.new_slg_barrack_info
local var_0_9 = g.core.common.Goods
local var_0_10 = {
	troops_num = "troops_num",
	knight_num = g.core.common.Goods.TYPE_KNIGHT,
	pet_num = g.core.common.Goods.TYPE_PET,
	artifact_num = g.core.common.Goods.TYPE_ARTIFACT,
	unite_token_num = g.core.common.Goods.TYPE_UNITETOKEN,
	succuba_num = g.core.common.Goods.TYPE_SUCCUBA
}
local var_0_11 = {
	"knight_num",
	nil,
	nil,
	"pet_num",
	nil,
	"unite_token_num",
	"artifact_num",
	nil,
	"succuba_num"
}
local var_0_12 = {
	g.core.common.Goods.TYPE_KNIGHT,
	[4] = g.core.common.Goods.TYPE_ARTIFACT,
	[6] = g.core.common.Goods.TYPE_PET,
	[7] = g.core.common.Goods.TYPE_UNITETOKEN,
	[9] = g.core.common.Goods.TYPE_SUCCUBA
}
local NewSlgEmbryoStruct = require("app.view.module.slg.model.NewSlgEmbryoStruct")
local NewSlgBarrackStruct = require("app.view.module.slg.model.NewSlgBarrackStruct")

function NewSlgDevelopData:ctor()
	NewSlgDevelopData.super.ctor(self)

	self._mainCityLevel = 1
	self._supplyLevel = 1
	self._productNum = 0
	self._supplyProductStartTime = 0
	self._supplyProductTime = 0
	self._supplyLevelStartTime = 0
	self._storageNum = 0
	self._maxProductTime = var_0_0:getNewSlgParamsValueByKey("parameter_12")
	self._minProductTime = var_0_0:getNewSlgParamsValueByKey("parameter_16")
	self._authorityInfoArrMap = {}
	self._mainCityInfoArrMap = {}
	self._barrackInfoArrMap = {}
	self._supplyInfoArrMap = {}
	self._armyInfoMap = {}
	self._troopsMaxNum = 0
	self._embryoStructMap = {}
	self._embryoStructArrMap = {}
	self._lineUpEmbryoStructMap = {}
	self._minAuthorityStructMap = {}
	self._barrackStructMap = {}
	self._numUnlockMap = {}
	self._lineUpMaxMap = {}
	self._cacheUpgradeData = {}
end

function NewSlgDevelopData:getEmbryoKey(arg_2_1, arg_2_2)
	return arg_2_1 .. "_" .. arg_2_2
end

function NewSlgDevelopData:initCfg()
	self:_initEmbryoStruct()

	for iter_3_0, iter_3_1 in ipairs(self:getMainCityInfoArrByGroup()) do
		for iter_3_2, iter_3_3 in pairs(var_0_10) do
			self._numUnlockMap[iter_3_3] = self._numUnlockMap[iter_3_3] or {}

			local var_3_0 = iter_3_1[iter_3_2]

			if iter_3_1[iter_3_2] and var_3_0 > 0 and not self._numUnlockMap[iter_3_3][var_3_0] then
				self._numUnlockMap[iter_3_3][var_3_0] = iter_3_1.level
			end
		end
	end
end

function NewSlgDevelopData:_initEmbryoStruct()
	for iter_4_0, iter_4_1 in ipairs(self:getAuthorityInfoArrByGroup()) do
		local var_4_0 = self:getEmbryoKey(iter_4_1.type, iter_4_1.advance_id)

		if not self._embryoStructMap[var_4_0] then
			self._embryoStructMap[var_4_0] = NewSlgEmbryoStruct:new()

			self._embryoStructMap[var_4_0]:setCfg(iter_4_1)
		end

		local var_4_1 = g.core.common.GlobalFunc.getEmbryoByTypeAndValue(iter_4_1.type, iter_4_1.advance_id)

		if var_4_1.embryoId == iter_4_1.cards_id then
			self._embryoStructMap[var_4_0]:setCfg(iter_4_1)
		end

		self._embryoStructMap[var_4_0]:setEmbryoStruct(var_4_1.struct)
		self:_setEmbryoRecommend(self._embryoStructMap[var_4_0])
	end
end

function NewSlgDevelopData:_setEmbryoRecommend(arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0 = self:getMinLineUpEmbryoStructByType(arg_5_1:getType())

	if var_5_0 then
		arg_5_1:setRecommend(arg_5_1:getAuthorityNum() > var_5_0:getAuthorityNum())
	else
		arg_5_1:setRecommend(false)
	end
end

function NewSlgDevelopData:_initBarrackStruct()
	for iter_6_0, iter_6_1 in ipairs(self:getBarrackInfoArrByGroup()) do
		if not self._barrackStructMap[iter_6_1.type] then
			local var_6_0 = NewSlgBarrackStruct:new()

			var_6_0:setCfg(iter_6_1)

			self._barrackStructMap[iter_6_1.type] = var_6_0
		end
	end
end

function NewSlgDevelopData:updateDevelopData(arg_7_1)
	if not arg_7_1 then
		return
	end

	self:updateMainCityData(arg_7_1.main_city)
	self:updateBarrackData(arg_7_1.barracks)
	self:updateSupplyData(arg_7_1.supply)
end

function NewSlgDevelopData:updateMainCityData(arg_8_1)
	if not arg_8_1 then
		return
	end

	self._mainCityLevel = arg_8_1.level or 1
	self._lineUpEmbryoStructMap = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.slots or {}) do
		self:updateEmbryoLineUpData(iter_8_1)
	end

	self:setMinLineUpEmbryoStructMap()
	self:_initEmbryoStruct()
end

function NewSlgDevelopData:updateBarrackData(arg_9_1)
	if not arg_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1 or {}) do
		self:_updateBarrackStruct(iter_9_1)
	end
end

function NewSlgDevelopData:_updateBarrackStruct(arg_10_1)
	self:getBarrackStructByType(arg_10_1.tp):setCfg((var_0_8.get(var_0_0:getBarrackGroupId(), arg_10_1.tp, arg_10_1.level)))
end

function NewSlgDevelopData:updateSupplyData(arg_11_1)
	if not arg_11_1 then
		return
	end

	self._supplyLevel = arg_11_1.level or 1
	self._productNum = arg_11_1.product_num
	self._supplyProductStartTime = arg_11_1.product_start_time
	self._supplyLevelStartTime = arg_11_1.current_level_start_time
	self._storageNum = arg_11_1.storage_num

	self:updateSupplyProductTime()
end

function NewSlgDevelopData:updateUpgradeMainCityData(arg_12_1)
	self._mainCityLevel = arg_12_1.level or 1
end

function NewSlgDevelopData:updateUpgradeBarrackData(arg_13_1)
	self:_updateBarrackStruct(arg_13_1)
end

function NewSlgDevelopData:updateUpgradeSupplyData(arg_14_1)
	self:updateSupplyData(arg_14_1.supply)
end

function NewSlgDevelopData:updateEmbryoLineUpData(arg_15_1)
	if not arg_15_1 then
		return
	end

	local var_15_0 = arg_15_1.tp
	local var_15_1 = self:getEmbryoKey(arg_15_1.tp, arg_15_1.pos)
	local var_15_2 = self:getEmbryoStructByTypeAndAdvId(arg_15_1.tp, (g.core.common.GlobalFunc.getStructByTypeAndSerId(arg_15_1.tp, arg_15_1.id):getAdvanceId()))

	if var_15_2 then
		if arg_15_1.pos > 0 then
			if self._lineUpEmbryoStructMap[var_15_1] then
				self._lineUpEmbryoStructMap[var_15_1]:setPos(0)
			end

			self._lineUpEmbryoStructMap[var_15_1] = var_15_2

			var_15_2:setPos(arg_15_1.pos)
		else
			self._lineUpEmbryoStructMap[self:getEmbryoKey(var_15_0, var_15_2:getPos())] = nil

			var_15_2:setPos(0)
		end
	end

	self:setMinLineUpEmbryoStructMap()

	for iter_15_0, iter_15_1 in pairs(self._embryoStructMap) do
		self:_setEmbryoRecommend(iter_15_1)
	end
end

function NewSlgDevelopData:updateSupplyProductTime()
	self._supplyProductTime = g.core.common.ServerTime:getTime() - self._supplyProductStartTime
end

function NewSlgDevelopData:getSupplyProductTime()
	if self._supplyProductTime == 0 then
		self:updateSupplyProductTime()
	end

	return self._supplyProductTime
end

function NewSlgDevelopData:getMainCityLv()
	return self._mainCityLevel
end

function NewSlgDevelopData:getSupplyLv()
	return self._supplyLevel
end

function NewSlgDevelopData:getBarrackLvByType(arg_20_1)
	return self:getBarrackStructByType(arg_20_1):getLevel()
end

function NewSlgDevelopData:getBarrackAuthorityByType(arg_21_1)
	return self:getBarrackStructByType(arg_21_1):getAuthority()
end

function NewSlgDevelopData:getBarrackStructByType(arg_22_1)
	if not self._barrackStructMap[arg_22_1] then
		self:_initBarrackStruct()
	end

	return self._barrackStructMap[arg_22_1]
end

function NewSlgDevelopData:getBarrackStructMap()
	if not next(self._barrackStructMap) then
		self:_initBarrackStruct()
	end

	return self._barrackStructMap
end

function NewSlgDevelopData:getMainCityCfg(arg_24_1)
	return var_0_7.get(var_0_0:getMainCityGroupId(), arg_24_1 or self:getMainCityLv())
end

function NewSlgDevelopData:getMainCityNextCfg()
	local var_25_0 = self:getMainCityLv()

	if not self:isMainCityMaxLv() then
		var_25_0 = var_25_0 + 1
	end

	return self:getMainCityCfg(var_25_0)
end

function NewSlgDevelopData:getSupplyCfg(arg_26_1)
	return var_0_5.get(var_0_0:getSupplyGroupId(), arg_26_1 or self:getSupplyLv())
end

function NewSlgDevelopData:getSupplyNextCfg()
	local var_27_0 = self:getSupplyLv()

	if not self:isSupplyMaxLv() then
		var_27_0 = var_27_0 + 1
	end

	return self:getSupplyCfg(var_27_0)
end

function NewSlgDevelopData:getSupplyStorageLimit()
	return self:getSupplyCfg().storage_limit
end

function NewSlgDevelopData:getFarmRentLimit()
	return self:getSupplyCfg().reward_limit
end

function NewSlgDevelopData:getFarmDailyRewardLimit()
	return self:getSupplyCfg().farm_num
end

function NewSlgDevelopData:getFarmKillScoreLimit()
	return self:getSupplyCfg().farm_contribution_num
end

function NewSlgDevelopData:getCurBuildMaxLevel()
	return self:getMainCityCfg().building_level_max
end

function NewSlgDevelopData:getFarmItem()
	return {
		type = var_0_9.TYPE_ITEM,
		value = var_0_9.ITEM.TYPE_SLG_FARM_ITEM
	}
end

function NewSlgDevelopData:getArmyInitTroopsByType(arg_34_1)
	return self:getMainCityCfg().army_troops + self:getBarrackStructByType(arg_34_1):getTroopsMax()
end

function NewSlgDevelopData:getUnlockTeamNum()
	local var_35_0 = self:getMainCityLv()
	local var_35_1 = 1

	for iter_35_0, iter_35_1 in pairs((self:getTeamUnlockNumMap())) do
		if iter_35_1 <= var_35_0 and var_35_1 <= iter_35_0 then
			var_35_1 = iter_35_0
		end
	end

	return var_35_1
end

function NewSlgDevelopData:getTotalAuthority()
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in pairs(self._lineUpEmbryoStructMap or {}) do
		var_36_0 = var_36_0 + iter_36_1:getAuthorityNum()
	end

	return var_36_0 + g.core.model.User.newSlgSkillTreeData:getTotalFightValue()
end

function NewSlgDevelopData:getAuthorityByType(arg_37_1)
	local var_37_0 = 0

	for iter_37_0, iter_37_1 in pairs(self._lineUpEmbryoStructMap or {}) do
		if tonumber(string.split(iter_37_0, "_")[1]) == arg_37_1 then
			var_37_0 = var_37_0 + iter_37_1:getAuthorityNum()
		end
	end

	return var_37_0
end

function NewSlgDevelopData:setMinLineUpEmbryoStructMap()
	self._minAuthorityStructMap = {}

	for iter_38_0, iter_38_1 in pairs(self._lineUpEmbryoStructMap or {}) do
		local var_38_0 = tonumber(string.split(iter_38_0, "_")[1])

		if not self._minAuthorityStructMap[var_38_0] then
			self._minAuthorityStructMap[var_38_0] = iter_38_1
		elseif iter_38_1:getAuthorityNum() < self._minAuthorityStructMap[var_38_0]:getAuthorityNum() then
			self._minAuthorityStructMap[var_38_0] = iter_38_1
		end
	end
end

function NewSlgDevelopData:getMinLineUpEmbryoStructByType(arg_39_1)
	return self._minAuthorityStructMap[arg_39_1]
end

function NewSlgDevelopData:getNumUnlockMapByType(arg_40_1)
	return self._numUnlockMap[arg_40_1]
end

function NewSlgDevelopData:getMaxLineUpByType(arg_41_1)
	if not self._lineUpMaxMap[arg_41_1] then
		local var_41_0 = 1

		for iter_41_0, iter_41_1 in pairs(self:getNumUnlockMapByType(arg_41_1) or {}) do
			if var_41_0 < iter_41_0 then
				var_41_0 = iter_41_0
			end
		end

		self._lineUpMaxMap[arg_41_1] = var_41_0
	end

	return self._lineUpMaxMap[arg_41_1]
end

function NewSlgDevelopData:getTeamUnlockNumMap()
	return self._numUnlockMap.troops_num
end

function NewSlgDevelopData:getTeamUnlockLevelByIndex(arg_43_1)
	local var_43_0 = self:getTeamUnlockNumMap()[arg_43_1] or 0

	return var_43_0 <= self:getMainCityLv(), var_43_0
end

function NewSlgDevelopData:getAuthorityInfoArrByGroup(arg_44_1)
	local var_44_0 = arg_44_1 or var_0_0:getAuthorityGroupId()

	if not self._authorityInfoArrMap[var_44_0] then
		self._authorityInfoArrMap[var_44_0] = {}

		for iter_44_0, iter_44_1 in var_0_6.ipairs() do
			if iter_44_1.group_id == var_44_0 then
				table.insert(self._authorityInfoArrMap[var_44_0], iter_44_1)
			end
		end
	end

	return self._authorityInfoArrMap[var_44_0]
end

function NewSlgDevelopData:getMainCityInfoArrByGroup(arg_45_1)
	local var_45_0 = arg_45_1 or var_0_0:getSlgInfo().main_city_group

	if not self._mainCityInfoArrMap[var_45_0] then
		self._mainCityInfoArrMap[var_45_0] = {}

		for iter_45_0, iter_45_1 in var_0_7.ipairs() do
			if iter_45_1.group_id == var_45_0 then
				table.insert(self._mainCityInfoArrMap[var_45_0], iter_45_1)
			end

			if var_45_0 == var_0_0:getSlgInfo().main_city_group and iter_45_1.troops_num > self._troopsMaxNum then
				self._troopsMaxNum = iter_45_1.troops_num
			end
		end
	end

	return self._mainCityInfoArrMap[var_45_0]
end

function NewSlgDevelopData:getBarrackInfoArrByGroup(arg_46_1)
	local var_46_0 = arg_46_1 or var_0_0:getBarrackGroupId()

	if not self._barrackInfoArrMap[var_46_0] then
		self._barrackInfoArrMap[var_46_0] = {}

		for iter_46_0, iter_46_1 in var_0_8.ipairs() do
			if iter_46_1.group_id == var_46_0 then
				table.insert(self._barrackInfoArrMap[var_46_0], iter_46_1)
			end
		end
	end

	return self._barrackInfoArrMap[var_46_0]
end

function NewSlgDevelopData:getSupplyInfoArrByGroup(arg_47_1)
	local var_47_0 = arg_47_1 or var_0_0:getSupplyGroupId()

	if not self._supplyInfoArrMap[var_47_0] then
		self._supplyInfoArrMap[var_47_0] = {}

		for iter_47_0, iter_47_1 in var_0_5.ipairs() do
			if iter_47_1.group_id == var_47_0 then
				table.insert(self._supplyInfoArrMap[var_47_0], iter_47_1)
			end
		end
	end

	return self._supplyInfoArrMap[var_47_0]
end

function NewSlgDevelopData:getArmyInfoByType(arg_48_1)
	if not self._armyInfoMap[arg_48_1] then
		for iter_48_0, iter_48_1 in var_0_4.ipairs() do
			self._armyInfoMap[iter_48_1.army_type] = iter_48_1
		end
	end

	return self._armyInfoMap[arg_48_1]
end

function NewSlgDevelopData:getEmbryoStructArrByType(arg_49_1)
	if not self._embryoStructArrMap[arg_49_1] then
		for iter_49_0, iter_49_1 in pairs(self._embryoStructMap) do
			local var_49_0 = iter_49_1:getType()

			self._embryoStructArrMap[var_49_0] = self._embryoStructArrMap[var_49_0] or {}

			table.insert(self._embryoStructArrMap[var_49_0], iter_49_1)
		end
	end

	return self._embryoStructArrMap[arg_49_1] or {}
end

function NewSlgDevelopData:getLineUpEmbryoStructMap()
	return self._lineUpEmbryoStructMap
end

function NewSlgDevelopData:getLineUpEmbryoStructByTypeAndPos(arg_51_1, arg_51_2)
	return self._lineUpEmbryoStructMap[self:getEmbryoKey(arg_51_1, arg_51_2)]
end

function NewSlgDevelopData:getEmbryoStructByTypeAndAdvId(arg_52_1, arg_52_2)
	return self._embryoStructMap[self:getEmbryoKey(arg_52_1, arg_52_2)]
end

function NewSlgDevelopData:getMainCityUpgradeMaterials()
	local var_53_0 = {}

	for iter_53_0, iter_53_1, iter_53_2 in self:getMainCityCfg().gmatch({
		"upgrade_type_%d+",
		"upgrade_value_%d+",
		"upgrade_size_%d+"
	}) do
		if iter_53_2[1] and iter_53_2[1] ~= 0 then
			table.insert(var_53_0, {
				colorIndex = 1,
				showGreen = true,
				title = "",
				type = iter_53_2[1],
				value = iter_53_2[2],
				size = iter_53_2[3]
			})
		end
	end

	return var_53_0
end

function NewSlgDevelopData:getSupplyUpgradeMaterials()
	local var_54_0 = {}

	for iter_54_0, iter_54_1, iter_54_2 in self:getSupplyCfg().gmatch({
		"upgrade_type_%d+",
		"upgrade_value_%d+",
		"upgrade_size_%d+"
	}) do
		if iter_54_2[1] and iter_54_2[1] ~= 0 then
			table.insert(var_54_0, {
				colorIndex = 1,
				showGreen = true,
				title = "",
				type = iter_54_2[1],
				value = iter_54_2[2],
				size = iter_54_2[3]
			})
		end
	end

	return var_54_0
end

function NewSlgDevelopData:getMainCityUpgradeShowData()
	local var_55_0 = self:getMainCityCfg()
	local var_55_1 = self:getMainCityNextCfg()
	local var_55_2 = {
		{
			name = g.core.lang:get(428848),
			curNum = var_55_0.army_troops,
			nextNum = var_55_1.army_troops
		},
		{
			name = g.core.lang:get(428850),
			curNum = var_55_0.building_level_max,
			nextNum = var_55_1.building_level_max
		},
		{
			name = g.core.lang:get(428849),
			curNum = var_55_0.troops_num,
			nextNum = var_55_1.troops_num
		}
	}
	local var_55_3 = {}

	if g.core.model.User.newSlgData:getSName() == "S1" then
		for iter_55_0, iter_55_1 in pairs(var_0_11) do
			table.insert(var_55_3, {
				name = g.core.lang:get(429543, {
					embryo = g.core.common.GlobalFunc.getEmbryoNameByType(var_0_10[iter_55_1])
				}),
				curNum = var_55_0[iter_55_1],
				nextNum = var_55_1[iter_55_1]
			})
		end
	else
		local var_55_4 = {
			name = g.core.lang:get(429742)
		}

		var_55_4.curNum = g.core.model.User.newSlgSkillTreeData:getMainLvCitySkillUnlockNum(self._mainCityLevel)
		var_55_4.nextNum = g.core.model.User.newSlgSkillTreeData:getMainLvCitySkillUnlockNum(self._mainCityLevel + 1)

		table.insert(var_55_3, var_55_4)
	end

	return {
		baseArr = var_55_2,
		lineUpArr = var_55_3
	}
end

function NewSlgDevelopData:getSupplyUpgradeShowData()
	local var_56_0 = self:getSupplyCfg()
	local var_56_1 = self:getSupplyNextCfg()
	local var_56_2 = {
		{
			name = g.core.lang:get(429523),
			curNum = self:getSupplyEfficientByProduction(var_56_0.production_rate, true).desc,
			nextNum = self:getSupplyEfficientByProduction(var_56_1.production_rate, true).desc
		},
		{
			name = g.core.lang:get(429524),
			curNum = var_56_0.storage_limit,
			nextNum = var_56_1.storage_limit
		}
	}

	if g.core.model.User.newSlgData:getSName() == "S2" then
		table.insert(var_56_2, {
			name = g.core.lang:get(429720),
			curNum = var_56_0.farm_num,
			nextNum = var_56_1.farm_num
		})
		table.insert(var_56_2, {
			name = g.core.lang:get(429721),
			curNum = var_56_0.farm_contribution_num,
			nextNum = var_56_1.farm_contribution_num
		})
	end

	return var_56_2
end

function NewSlgDevelopData:getSupplyEfficientByProduction(arg_57_1, arg_57_2)
	local var_57_0 = var_0_0:getNewSlgParamsValueByKey("parameter_10")
	local var_57_1 = {
		value = 60001,
		type = g.core.common.Goods.TYPE_ITEM,
		size = arg_57_1
	}

	if not arg_57_2 then
		var_0_0:getAndUpdateItemNumAfterAddition(var_57_1, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.OBTAIN_SUPPLY_AWARD)
	end

	arg_57_1 = var_57_1.size

	local var_57_2 = ""
	local var_57_3

	if var_57_0 < 3600 then
		var_57_0 = var_57_0 / 60
		var_57_2 = g.core.lang:get(1180)
	elseif var_57_0 >= 3600 then
		var_57_0 = var_57_0 / 3600
		var_57_2 = g.core.lang:get(1182)
		var_57_3 = {}
	end

	var_57_3.efficient = math.ceil(arg_57_1 / var_57_0)
	var_57_3.num1 = arg_57_1
	var_57_3.num2 = var_57_0
	var_57_3.desc = g.core.lang:get(428977, {
		num1 = arg_57_1,
		num2 = var_57_0 .. var_57_2
	})

	return var_57_3
end

function NewSlgDevelopData:getSupplyProductionItem()
	return {
		type = var_0_9.TYPE_ITEM,
		value = var_0_9.ITEM.TYPE_SLG_SUPPLY_PRODUCTION_ITEM
	}
end

function NewSlgDevelopData:getSupplyCallItem()
	return {
		type = var_0_9.TYPE_ITEM,
		value = var_0_9.ITEM.TYPE_SLG_SUPPLY_CALL_ITEM
	}
end

function NewSlgDevelopData:getSupplyProductNum()
	local var_60_0 = var_0_0:getNewSlgParamsValueByKey("parameter_10")
	local var_60_1 = var_0_0:getNewSlgParamsValueByKey("parameter_12")
	local var_60_2 = 0

	if var_60_1 < self._supplyLevelStartTime - self._supplyProductStartTime then
		var_60_2 = self._productNum + self._storageNum
	else
		local var_60_3 = math.min(g.core.common.ServerTime:getTime() - self._supplyLevelStartTime, var_60_1 - (self._supplyLevelStartTime - self._supplyProductStartTime))
		local var_60_4 = {
			value = 60001,
			type = g.core.common.Goods.TYPE_ITEM,
			size = self:getSupplyCfg().production_rate
		}

		var_0_0:getAndUpdateItemNumAfterAddition(var_60_4, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.OBTAIN_SUPPLY_AWARD)

		var_60_2 = self._productNum + self._storageNum + var_60_3 * var_60_4.size
	end

	return math.floor(var_60_2 / var_60_0)
end

function NewSlgDevelopData:getSupplyProductionArr()
	local var_61_0 = var_0_0:getNewSlgParamsValueByKey("parameter_14")
	local var_61_1 = self:getSupplyProductionItem()
	local var_61_2 = {}
	local var_61_3 = self:getSupplyProductNum()

	while var_61_0 < var_61_3 do
		var_61_3 = var_61_3 - var_61_0

		table.insert(var_61_2, {
			type = var_61_1.type,
			value = var_61_1.value,
			size = var_61_0
		})
	end

	if var_61_3 > 0 then
		table.insert(var_61_2, 1, {
			type = var_61_1.type,
			value = var_61_1.value,
			size = var_61_3
		})
	end

	return var_61_2
end

function NewSlgDevelopData:getSupplyProductStartTime()
	return self._supplyProductStartTime
end

function NewSlgDevelopData:getSupplyLevelStartTime()
	return self._supplyLevelStartTime
end

function NewSlgDevelopData:getEmbryoTypeMap()
	return var_0_12
end

function NewSlgDevelopData:isMainCityMaxLv()
	return self:getMainCityCfg().next_level == 0
end

function NewSlgDevelopData:isSupplyMaxLv()
	return self:getSupplyCfg().next_level == 0
end

function NewSlgDevelopData:checkEmbryoUnlockByType(arg_67_1)
	return self:checkPosUnlockByTypeAndPos(arg_67_1, 1)
end

function NewSlgDevelopData:checkPosUnlockByTypeAndPos(arg_68_1, arg_68_2)
	local var_68_0 = self:getNumUnlockMapByType(arg_68_1)
	local var_68_1 = self:getMaxLineUpByType(arg_68_1)

	if var_68_1 < arg_68_2 then
		return false, 0
	end

	local var_68_2

	::label_68_0::

	if not var_68_0[arg_68_2] and arg_68_2 < var_68_1 then
		repeat
			arg_68_2 = arg_68_2 + 1

			goto label_68_0
		until true

		var_68_2 = var_68_0[arg_68_2] <= self:getMainCityLv()
	end

	return var_68_2, var_68_0[arg_68_2]
end

function NewSlgDevelopData:checkPosCanLineUpByTypeAndPos(arg_69_1, arg_69_2)
	local var_69_0, var_69_1 = self:checkPosUnlockByTypeAndPos(arg_69_1, arg_69_2)

	if not var_69_0 then
		return false
	end

	return not self:getLineUpEmbryoStructByTypeAndPos(arg_69_1, arg_69_2)
end

function NewSlgDevelopData:checkCanLineUpFirstPosByType(arg_70_1)
	for iter_70_0 = 1, self:getMaxLineUpByType(arg_70_1) do
		if self:checkPosCanLineUpByTypeAndPos(arg_70_1, iter_70_0) then
			return true, iter_70_0
		end
	end

	return false, 0
end

function NewSlgDevelopData:checkMainCityUpgradeNeedLv()
	local var_71_0 = self:getMainCityCfg().barrack_level_limit

	for iter_71_0, iter_71_1 in pairs(self:getBarrackStructMap()) do
		if var_71_0 > iter_71_1:getLevel() then
			return false, var_71_0
		end
	end

	return true, 0
end

function NewSlgDevelopData:checkMainCityUpgradeNeedMaterials()
	for iter_72_0, iter_72_1 in ipairs(self:getMainCityUpgradeMaterials() or {}) do
		if var_0_1:getOwnNum(iter_72_1.type, iter_72_1.value) < iter_72_1.size then
			return false, iter_72_1
		end
	end

	return true
end

function NewSlgDevelopData:checkMainCityCanUpgrade()
	if self:isMainCityMaxLv() then
		return false
	end

	return self:checkMainCityUpgradeNeedLv() and self:checkMainCityUpgradeNeedMaterials()
end

function NewSlgDevelopData:checkSupplyUpgradeNeedLv()
	local var_74_0 = self:getSupplyCfg().main_city_limit

	return var_74_0 <= self:getMainCityLv(), var_74_0
end

function NewSlgDevelopData:checkSupplyUpgradeNeedMaterials()
	for iter_75_0, iter_75_1 in ipairs(self:getSupplyUpgradeMaterials() or {}) do
		if var_0_1:getOwnNum(iter_75_1.type, iter_75_1.value) < iter_75_1.size then
			return false, iter_75_1
		end
	end

	return true
end

function NewSlgDevelopData:checkSupplyCanUpgrade()
	if self:isSupplyMaxLv() then
		return false
	end

	return self:checkSupplyUpgradeNeedLv() and self:checkSupplyUpgradeNeedMaterials()
end

function NewSlgDevelopData:checkSupplyCanCall()
	local var_77_0 = self:getSupplyCallItem()

	return var_0_1:getOwnNum(var_77_0.type, var_77_0.value) > 0 and not self:checkSupplyStorageLimit()
end

function NewSlgDevelopData:checkSupplyStorageLimit()
	local var_78_0 = self:getSupplyProductionItem()

	return var_0_1:getOwnNum(var_78_0.type, var_78_0.value) >= self:getSupplyStorageLimit()
end

function NewSlgDevelopData:checkSupplyProductLimit()
	return g.core.common.ServerTime:getTime() - self:getSupplyProductStartTime() >= self._maxProductTime
end

function NewSlgDevelopData:checkSupplyCanAwards()
	return self:getSupplyProductTime() >= self._minProductTime
end

function NewSlgDevelopData:checkEmbryoMinCanChange(arg_81_1)
	local var_81_0 = arg_81_1:getType()
	local var_81_1 = self:getMinLineUpEmbryoStructByType(var_81_0)

	if var_81_1 and var_81_1 == arg_81_1 then
		for iter_81_0, iter_81_1 in ipairs(self:getEmbryoStructArrByType(var_81_0)) do
			if iter_81_1 and iter_81_1:isOwn() and not iter_81_1:isLineUp() and iter_81_1:isRecommend() then
				return true
			end
		end
	end

	return false
end

function NewSlgDevelopData:checkEmbryoLineUpByType(arg_82_1)
	if not self:checkEmbryoUnlockByType(arg_82_1) then
		return false
	end

	local var_82_0 = {}

	for iter_82_0, iter_82_1 in ipairs(self:getEmbryoStructArrByType(arg_82_1)) do
		if iter_82_1 and iter_82_1:isOwn() and not iter_82_1:isLineUp() then
			table.insert(var_82_0, iter_82_1)
		end
	end

	if not self:getMinLineUpEmbryoStructByType(arg_82_1) or self:checkCanLineUpFirstPosByType(arg_82_1) then
		return #var_82_0 > 0
	end

	for iter_82_2, iter_82_3 in ipairs(var_82_0 or {}) do
		if iter_82_3:isRecommend() then
			return true
		end
	end

	return false
end

function NewSlgDevelopData:checkHaveEmbryoCanLineUp(arg_83_1)
	local var_83_0 = {}

	for iter_83_0, iter_83_1 in ipairs(self:getEmbryoStructArrByType(arg_83_1)) do
		if iter_83_1 and iter_83_1:isOwn() and not iter_83_1:isLineUp() then
			table.insert(var_83_0, iter_83_1)
		end
	end

	return #var_83_0 > 0
end

function NewSlgDevelopData:getBuildNameByType(arg_84_1, arg_84_2)
	if arg_84_1 == var_0_3.SLG_BUILD_TYPE.COMMAND then
		return g.core.lang:get(429501)
	elseif arg_84_1 == var_0_3.SLG_BUILD_TYPE.SUPPLY then
		return g.core.lang:get(429505)
	elseif arg_84_2 == var_0_3.ARMY_TYPE.QI then
		return g.core.lang:get(429502)
	elseif arg_84_2 == var_0_3.ARMY_TYPE.DUN then
		return g.core.lang:get(429504)
	else
		return g.core.lang:get(429503)
	end
end

function NewSlgDevelopData:getSupplyAwardState()
	if not self:checkSupplyCanAwards() then
		return var_0_3.SLG_DEVELOP_PRODUCT_AWARD_STATE.NO_AWARD
	end

	local var_85_0 = self:getSupplyStorageLimit()
	local var_85_1 = self:getSupplyProductionItem()
	local var_85_2 = var_0_1:getOwnNum(var_85_1.type, var_85_1.value)

	if var_85_0 <= var_85_2 then
		return var_0_3.SLG_DEVELOP_PRODUCT_AWARD_STATE.STORAGE_FULL
	end

	if var_85_0 < var_85_2 + self:getSupplyProductNum() then
		return var_0_3.SLG_DEVELOP_PRODUCT_AWARD_STATE.STORAGE_LIMIT
	end

	return var_0_3.SLG_DEVELOP_PRODUCT_AWARD_STATE.CAN_AWARD
end

function NewSlgDevelopData:getSupplyCallState()
	local var_86_0 = self:getSupplyCallItem()
	local var_86_1 = var_0_1:getOwnNum(var_86_0.type, var_86_0.value)

	if var_86_1 <= 0 then
		return var_0_3.SLG_DEVELOP_PRODUCT_CALL_STATE.NO_CALL_ITEM, 0
	end

	local var_86_2 = self:getSupplyStorageLimit()
	local var_86_3 = self:getSupplyProductionItem()
	local var_86_4 = var_0_1:getOwnNum(var_86_3.type, var_86_3.value)
	local var_86_5

	if var_86_2 <= var_86_4 then
		do return var_0_3.SLG_DEVELOP_PRODUCT_CALL_STATE.STORAGE_FULL, 0 end

		var_86_5 = {
			value = 60001,
			type = g.core.common.Goods.TYPE_ITEM
		}
	end

	var_86_5.size = self:getSupplyCfg().production_rate

	var_0_0:getAndUpdateItemNumAfterAddition(var_86_5, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.OBTAIN_SUPPLY_AWARD)

	local var_86_6 = math.min(math.ceil((var_86_2 - var_86_4) / (var_86_5.size * 3600 / var_0_0:getNewSlgParamsValueByKey("parameter_10"))), var_86_1)

	if var_86_2 < var_86_5.size * var_86_6 + var_86_4 then
		return var_0_3.SLG_DEVELOP_PRODUCT_CALL_STATE.STORAGE_LIMIT, var_86_6
	end

	return var_0_3.SLG_DEVELOP_PRODUCT_CALL_STATE.CAN_CALL, var_86_6
end

function NewSlgDevelopData:getMainCityRealUpgradeShowData()
	local var_87_0 = self:getMainCityUpgradeShowData()
	local var_87_1

	if self:isMainCityMaxLv() then
		do return var_87_0 end

		var_87_1 = {}
	end

	for iter_87_0, iter_87_1 in ipairs(var_87_0.baseArr) do
		if iter_87_1.curNum < iter_87_1.nextNum then
			table.insert(var_87_1, iter_87_1)
		end
	end

	local var_87_2 = {}

	for iter_87_2, iter_87_3 in ipairs(var_87_0.lineUpArr) do
		if iter_87_3.curNum < iter_87_3.nextNum then
			table.insert(var_87_2, iter_87_3)
		end
	end

	return {
		baseArr = var_87_1,
		lineUpArr = var_87_2
	}
end

function NewSlgDevelopData:cacheUpgradeData(arg_88_1, arg_88_2)
	self._cacheUpgradeData = {}
	self._cacheUpgradeData[arg_88_1] = arg_88_2
end

function NewSlgDevelopData:getCachedUpgradeData(arg_89_1)
	return self._cacheUpgradeData[arg_89_1] or {}
end

function NewSlgDevelopData:getMainCityUpgradeState()
	if self:isMainCityMaxLv() then
		return var_0_3.SLG_DEVELOP_COMMAND_UPGRADE_STATE.MAX_LEVEL, 0
	end

	local var_90_0, var_90_1 = self:checkMainCityUpgradeNeedLv()

	if not var_90_0 then
		return var_0_3.SLG_DEVELOP_COMMAND_UPGRADE_STATE.BARRACK, var_90_1
	end

	if not self:checkMainCityUpgradeNeedMaterials() then
		return var_0_3.SLG_DEVELOP_COMMAND_UPGRADE_STATE.COST, 0
	end

	return var_0_3.SLG_DEVELOP_COMMAND_UPGRADE_STATE.CAN_UPGRADE, 0
end

function NewSlgDevelopData:getSupplyUpgradeState()
	if self:isSupplyMaxLv() then
		return var_0_3.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.MAX_LEVEL, 0
	end

	local var_91_0, var_91_1 = self:checkSupplyUpgradeNeedLv()

	if not var_91_0 then
		return var_0_3.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.COMMAND, var_91_1
	end

	if not self:checkSupplyUpgradeNeedMaterials() then
		return var_0_3.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.COST, 0
	end

	return var_0_3.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.CAN_UPGRADE, 0
end

function NewSlgDevelopData:getMaxSupplyProductTime()
	return self._maxProductTime
end

function NewSlgDevelopData:getFilteredEmbryoStructArrByType(arg_93_1, arg_93_2)
	local var_93_0 = {}

	for iter_93_0, iter_93_1 in ipairs(self:getEmbryoStructArrByType(arg_93_1)) do
		if not arg_93_2 or arg_93_2(iter_93_1) then
			table.insert(var_93_0, iter_93_1)
		end
	end

	return var_93_0
end

function NewSlgDevelopData:getCanCallNum()
	local var_94_0, var_94_1 = self:getSupplyCallState()

	return var_94_1
end

function NewSlgDevelopData:getSupplyProductDuration()
	return g.core.common.ServerTime:getTime() - self:getSupplyProductStartTime()
end

function NewSlgDevelopData:checkHasBarrackCanUpgrade(arg_96_1)
	if arg_96_1 and arg_96_1.armyType then
		return self:getBarrackStructByType(arg_96_1.armyType):checkCanUpgrade()
	else
		for iter_96_0, iter_96_1 in pairs(var_0_3.ARMY_TYPE) do
			local var_96_0 = self:getBarrackStructByType(iter_96_1)

			if var_96_0 and var_96_0:checkCanUpgrade() then
				return true
			end
		end
	end

	return false
end

function NewSlgDevelopData:checkEmbryoLineUpWithCustomData(arg_97_1)
	if arg_97_1 and arg_97_1.embryoType then
		return self:checkEmbryoLineUpByType(arg_97_1.embryoType)
	else
		for iter_97_0, iter_97_1 in pairs(var_0_12) do
			if self:checkEmbryoLineUpByType(iter_97_1) then
				return true
			end
		end
	end

	return false
end

function NewSlgDevelopData:checkUpgradeCfgValid()
	for iter_98_0, iter_98_1 in var_0_7.ipairs() do
		local var_98_0 = iter_98_1.level

		if iter_98_1.barrack_level_limit > 1 then
			local var_98_1 = var_0_8.get(iter_98_1.group_id, 1, iter_98_1.barrack_level_limit - 1)
			local var_98_2, var_98_3, var_98_4

			if var_98_1.main_city_limit == 0 then
				do return end

				var_98_2 = assert
				var_98_3 = var_98_1.main_city_limit <= var_98_0
				var_98_4 = var_98_0
			end

			var_98_2(var_98_3, string.format("main city level %d need barrack level %d", var_98_0, var_98_1.main_city_limit))
		end
	end
end

function NewSlgDevelopData:getMaxTroopNum()
	return self._troopsMaxNum
end

return NewSlgDevelopData
