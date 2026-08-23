local RebornConst = require("app.view.module.reborn.const.RebornConst")
local RebornData = class("RebornData")

function RebornData:ctor()
	self:loadIgnoreKnight()
	self:initData()
end

function RebornData:initData()
	self._rebornEquipDecomposeList = {}
	self._rebornArtifactDecomposeList = {}
	self._isHasDeEquipRed = false
	self._isHasRebornKnightRed = false
	self._cfgMap = {}
	self._isTips = {}
	self._rebornEquipCanDecomposeList = {}
	self._showTabCfg = nil
end

function RebornData:setIsNotTips(arg_3_1, arg_3_2)
	self._isTips[arg_3_1] = arg_3_2
end

function RebornData:getIsNotTips(arg_4_1)
	return self._isTips[arg_4_1]
end

function RebornData:setEquipDecomposeList(arg_5_1, arg_5_2)
	if arg_5_2 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			if #self._rebornEquipDecomposeList < 5 then
				table.insert(self._rebornEquipDecomposeList, iter_5_1)
			end
		end
	else
		self._rebornEquipDecomposeList = arg_5_1
	end
end

function RebornData:getEquipDecomposeList()
	return self._rebornEquipDecomposeList
end

function RebornData:clearEquipDecomposeList()
	self._rebornEquipDecomposeList = {}
end

function RebornData:deleteEquipDeList(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._rebornEquipDecomposeList) do
		local var_8_0 = iter_8_1:getServerData()

		if var_8_0 and var_8_0.id == arg_8_1 then
			table.remove(self._rebornEquipDecomposeList, iter_8_0)
		end
	end
end

function RebornData:setArtifactDecomposeList(arg_9_1, arg_9_2)
	if arg_9_2 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			if #self._rebornArtifactDecomposeList < 5 then
				table.insert(self._rebornArtifactDecomposeList, iter_9_1)
			end
		end
	else
		self._rebornArtifactDecomposeList = arg_9_1
	end
end

function RebornData:getArtifactDecomposeList()
	return self._rebornArtifactDecomposeList
end

function RebornData:cleaArtifactDecomposeList()
	self._rebornArtifactDecomposeList = {}
end

function RebornData:deleteArtifactDeList(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self._rebornArtifactDecomposeList) do
		if iter_12_1:getCfg().id == arg_12_1 then
			table.remove(self._rebornArtifactDecomposeList, iter_12_0)
		end
	end
end

function RebornData:isRearchMax(arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if iter_13_1.isSelet then
			var_13_0 = var_13_0 + 1
		end
	end

	if var_13_0 >= 5 then
		return true, var_13_0
	end

	return false, var_13_0
end

function RebornData:getDecomposeEquip(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if iter_14_1.isSelet then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function RebornData:getDecomposeEquipId(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table.insert(var_15_0, iter_15_1:getServerData().id)
	end

	return var_15_0
end

function RebornData:isCanUniteTokenReborn(arg_16_1)
	local var_16_0 = arg_16_1:getPos()

	if arg_16_1:getLevel() > 0 and var_16_0 == 0 then
		return true, false
	end

	if var_16_0 ~= 0 then
		return false, true
	end

	return false, false
end

function RebornData:isCanEquipReborn(arg_17_1)
	local var_17_0 = arg_17_1:getServerData()

	if (var_17_0.level > 1 or var_17_0.refining_level > 0) and var_17_0.position == 0 then
		return true, false
	end

	if var_17_0.position ~= 0 then
		return false, true
	end

	return false, false
end

function RebornData:isCanTreasureReborn(arg_18_1)
	if arg_18_1.position == 0 and (arg_18_1.level > 1 or arg_18_1.refining_level > 0) then
		return true, false
	end

	if arg_18_1.position ~= 0 then
		return false, true
	end

	return false, false
end

function RebornData:isCanDressReborn(arg_19_1)
	if arg_19_1.id ~= g.core.model.User:getDressId() and arg_19_1.level > 0 then
		return true, false
	end

	if arg_19_1.id == g.core.model.User:getDressId() then
		return false, true
	end

	return false, false
end

function RebornData:isHasknightReborn()
	for iter_20_0, iter_20_1 in ipairs((g.core.model.User.knightsData:getOwnKnightList())) do
		if self:checkCanRebornByKnight(iter_20_1) then
			return true
		end
	end

	return false
end

function RebornData:checkCanRebornByKnight(arg_21_1)
	local var_21_0 = arg_21_1:getInfo()

	if not arg_21_1:isLineup() then
		if var_21_0.level > 1 or var_21_0.advance_level > 1 or var_21_0.star_level > 1 then
			return true
		end

		for iter_21_0, iter_21_1 in ipairs(var_21_0.star_train) do
			if iter_21_1 ~= 0 then
				return true
			end
		end
	end

	return false
end

function RebornData:isHasEquipReborn()
	for iter_22_0, iter_22_1 in ipairs(g.core.model.User.equipmentData:getEquipList().noWearIndex) do
		if iter_22_1:isCanReborn() then
			return true
		end
	end

	return false
end

function RebornData:isHasTreasureReborn()
	for iter_23_0, iter_23_1 in ipairs((g.core.model.User.treasureData:getNoSwearTreasure())) do
		if iter_23_1.level > 1 or iter_23_1.refining_level > 0 or iter_23_1.glyph_level > 0 then
			return true
		end
	end

	return false
end

function RebornData:isHasDressReborn()
	for iter_24_0, iter_24_1 in ipairs((g.core.model.User.dressData:getAllHavedDress())) do
		if iter_24_1.level > 0 and iter_24_1.id ~= g.core.model.User:getDressId() then
			return true
		end
	end

	return false
end

function RebornData:isHasUniteTokenReborn()
	for iter_25_0, iter_25_1 in ipairs((g.core.model.User.uniteTokenData:getOwnTokenList())) do
		local var_25_0 = iter_25_1:getPos()

		if iter_25_1:getLevel() > 0 or iter_25_1:getRunes() > 0 then
			return true
		end
	end
end

function RebornData:isHasDecomposeEquip()
	for iter_26_0, iter_26_1 in ipairs(g.core.model.User.equipmentData:getEquipList().noWearIndex) do
		if g.core.config.equipment_info.get(iter_26_1:getServerData().base_id).is_resolve == 1 then
			return true
		end
	end

	return false
end

function RebornData:updateDecomposeEquipRed()
	self._isHasDeEquipRed = self:checkDecomposeEquipRed()
end

function RebornData:getDeEquipRed()
	self:updateDecomposeEquipRed()

	return self._isHasDeEquipRed
end

function RebornData:checkDecomposeEquipRed()
	local var_29_0 = 0

	self._rebornEquipCanDecomposeList = {}

	local var_29_2 = {
		0,
		0,
		0,
		0
	}

	for iter_29_0, iter_29_1 in ipairs((g.core.model.User.knightsData:getFormationKnights())) do
		if iter_29_0 <= 6 and iter_29_1 == 0 then
			return false
		end

		if iter_29_0 <= 6 then
			for iter_29_2 = 1, 4 do
				if g.core.model.User.equipmentData:isWornEquip((iter_29_0 - 1) * 4 + iter_29_2) then
					var_29_2[iter_29_2] = var_29_2[iter_29_2] + 1
				end

				local var_29_3 = g.core.model.User.equipmentData:getEquipDataByPos((iter_29_0 - 1) * 4 + iter_29_2)

				if var_29_3 then
					local var_29_4 = var_29_3:getCfg().quality

					if var_29_0 == 0 then
						var_29_0 = var_29_4
					elseif var_29_4 < var_29_0 then
						var_29_0 = var_29_4
					end
				end
			end
		end
	end

	local var_29_5 = false

	for iter_29_3, iter_29_4 in ipairs((g.core.model.User.equipmentData:getAllEquipList())) do
		local var_29_6 = iter_29_4:getServerData()

		if var_29_6.position == 0 then
			local var_29_7 = iter_29_4:getCfg()

			if var_29_7.quality <= var_29_0 and var_29_2[var_29_7.type] == 6 and var_29_7.quality < 6 then
				var_29_5 = true

				table.insert(self._rebornEquipCanDecomposeList, var_29_6.id)

				if #self._rebornEquipCanDecomposeList >= 5 then
					return true
				end
			end
		end
	end

	return var_29_5
end

function RebornData:getEquipListCanDecomp()
	return self._rebornEquipCanDecomposeList
end

function RebornData:updateKnightRed()
	self._isHasRebornKnightRed = self:checkHasRebornKnightRed()
end

function RebornData:getKnightRed()
	return self._isHasRebornKnightRed
end

function RebornData:checkHasRebornKnightRed()
	for iter_33_0, iter_33_1 in ipairs((g.core.model.User.knightsData:getFormationKnights())) do
		if iter_33_0 <= 6 and iter_33_1 == 0 then
			return false
		end
	end

	for iter_33_2, iter_33_3 in ipairs((g.core.model.User.knightsData:getOwnKnightList())) do
		local var_33_0 = iter_33_3:getInfo()

		if not iter_33_3:isMain() and not iter_33_3:isBackup() and self:checkCanRebornByKnight(iter_33_3) and (var_33_0.level >= 10 or var_33_0.advance_level >= 2 or var_33_0.star_level >= 2) then
			return true
		end
	end

	return false
end

function RebornData:_initCfg()
	if not self._cfgMap or not next(self._cfgMap) then
		self._cfgMap = {}

		for iter_34_0, iter_34_1 in g.core.config.reborn_info.ipairs() do
			self._cfgMap[iter_34_1.type .. "_" .. iter_34_1.reborn_type] = iter_34_1
		end
	end
end

function RebornData:getCfgByType(arg_35_1, arg_35_2)
	self:_initCfg()

	return self._cfgMap[arg_35_1 .. "_" .. arg_35_2]
end

function RebornData:getKnightRebornList()
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs((g.core.model.User.knightsData:getOwnKnightList(0))) do
		local var_36_1 = iter_36_1:getInfo()
		local var_36_2 = iter_36_1:isLineup()
		local var_36_3 = clone(iter_36_1)

		var_36_3.quality = iter_36_1:getBaseInfo().quality
		var_36_3.baseId = var_36_1.base_id

		if g.core.model.User.rebornData:checkCanRebornByKnight(iter_36_1) then
			table.insert(var_36_0, var_36_3)
		end

		if not var_36_2 then
			var_36_3.isMainRole = 0
		end
	end

	table.sort(var_36_0, function(arg_37_0, arg_37_1)
		if arg_37_0.isMain ~= arg_37_1.isMain then
			return arg_37_0.isMain < arg_37_1.isMain
		end

		if arg_37_0:getInfo().star_level ~= arg_37_1:getInfo().star_level then
			return arg_37_0:getInfo().star_level > arg_37_1:getInfo().star_level
		end

		if arg_37_0:getInfo().advance_level ~= arg_37_1:getInfo().advance_level then
			return arg_37_0:getInfo().advance_level > arg_37_1:getInfo().advance_level
		end

		if arg_37_0.level ~= arg_37_1.level then
			return arg_37_0.level > arg_37_1.level
		end

		if arg_37_0.baseId ~= arg_37_1.baseId then
			return arg_37_0.baseId > arg_37_1.baseId
		end
	end)

	return var_36_0
end

function RebornData:loadIgnoreKnight()
	self._ignoreKnightList = g.core.common.Storage:load("reborn_ignore_list.json", true) or {}
end

function RebornData:setIgnoreKnight()
	self._ignoreKnightList = {}

	for iter_39_0, iter_39_1 in ipairs((self:getKnightRebornList())) do
		self._ignoreKnightList[tostring(iter_39_1:getAdvanceId())] = true
	end

	g.core.common.Storage:save("reborn_ignore_list.json", self._ignoreKnightList, true)
end

function RebornData:clearIgnoreKnight(arg_40_1)
	if self._ignoreKnightList[tostring(arg_40_1)] then
		self._ignoreKnightList[tostring(arg_40_1)] = nil

		g.core.common.Storage:save("reborn_ignore_list.json", self._ignoreKnightList, true)
	end
end

function RebornData:getEquipRebornList(arg_41_1)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(g.core.model.User.equipmentData:getEquipList().noWearIndex) do
		local var_41_1 = clone(iter_41_1)

		var_41_1.baseId = iter_41_1:getServerData().base_id
		var_41_1.quality = iter_41_1:getCfg().quality
		var_41_1.lv = iter_41_1:getServerData().level
		var_41_1.refineLevel = iter_41_1:getServerData().refining_level
		var_41_1.resonanceLevel = iter_41_1:getResonanceLevel()

		if iter_41_1:isCanReborn(arg_41_1) then
			table.insert(var_41_0, var_41_1)
		end
	end

	table.sort(var_41_0, function(arg_42_0, arg_42_1)
		if arg_42_0.quality ~= arg_42_1.quality then
			return arg_42_0.quality > arg_42_1.quality
		end

		if arg_42_0.lv ~= arg_42_1.lv then
			return arg_42_0.lv > arg_42_1.lv
		end

		if arg_42_0.refineLevel ~= arg_42_1.refineLevel then
			return arg_42_0.refineLevel > arg_42_1.refineLevel
		end

		if arg_42_0.resonanceLevel ~= arg_42_1.resonanceLevel then
			return arg_42_0.resonanceLevel > arg_42_1.resonanceLevel
		end

		if arg_42_0.baseId ~= arg_42_1.baseId then
			return arg_42_0.baseId > arg_42_1.baseId
		end
	end)

	return var_41_0
end

function RebornData:getTreasureRebornList()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in ipairs((g.core.model.User.treasureData:getNoSwearTreasure())) do
		local var_43_1 = clone(iter_43_1)

		var_43_1.quality = g.core.config.treasure_info.get(iter_43_1.base_id).quality

		if (iter_43_1.level > 1 or iter_43_1.refining_level > 0 or iter_43_1.glyph_level > 0) and not iter_43_1.lock then
			table.insert(var_43_0, var_43_1)
		end
	end

	table.sort(var_43_0, function(arg_44_0, arg_44_1)
		if arg_44_0.quality ~= arg_44_1.quality then
			return arg_44_0.quality > arg_44_1.quality
		end

		if arg_44_0.base_id ~= arg_44_1.base_id then
			return arg_44_0.base_id > arg_44_1.base_id
		end
	end)

	return var_43_0
end

function RebornData:getTokenRebornList()
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in ipairs((g.core.model.User.uniteTokenData:getOwnTokenList())) do
		local var_45_1 = iter_45_1:getLevel()
		local var_45_2 = iter_45_1:getRunes()
		local var_45_3 = iter_45_1:getBaseId()
		local var_45_4 = clone(iter_45_1)

		var_45_4.quality = iter_45_1:getQuality()
		var_45_4.baseId = var_45_3
		var_45_4.level = var_45_1

		if var_45_1 > 1 or var_45_2 > 0 then
			table.insert(var_45_0, var_45_4)
		end
	end

	table.sort(var_45_0, function(arg_46_0, arg_46_1)
		if arg_46_0.quality ~= arg_46_1.quality then
			return arg_46_0.quality > arg_46_1.quality
		end

		if arg_46_0.level ~= arg_46_1.level then
			return arg_46_0.level > arg_46_1.level
		end
	end)

	return var_45_0
end

function RebornData:hasCanRebornKnight()
	if not next(self._ignoreKnightList) then
		return #self:getKnightRebornList() > 0
	end

	for iter_47_0, iter_47_1 in ipairs((self:getKnightRebornList())) do
		if not self._ignoreKnightList[tostring(iter_47_1:getAdvanceId())] then
			return true
		end
	end

	return false
end

function RebornData:hasCanRebornUniteToken()
	return #self:getTokenRebornList() > 0
end

function RebornData:hasCanRebornTreasure()
	return #self:getTreasureRebornList() > 0
end

function RebornData:hasCanRebornEquip()
	return #self:getEquipRebornList() > 0
end

function RebornData:hasCanRebornArtifact()
	return #self:getArtifactRebornList() > 0
end

function RebornData:hasCanRebornPet()
	return #self:getPetRebornList() > 0
end

function RebornData:getArtifactRebornList()
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in ipairs((g.core.model.User.artifactData:getOwnArtifactList())) do
		if not iter_53_1:isLineup() and iter_53_1:getLevel() > 1 then
			table.insert(var_53_0, iter_53_1)
		end
	end

	return var_53_0
end

function RebornData:getPetRebornList()
	local var_54_0 = g.core.model.User.petsData:getOwnPetArrByFilter(function(arg_55_0)
		local var_55_0, var_55_1 = arg_55_0:getBigSmallStage()
		local var_55_2 = arg_55_0:getServerData()

		return not arg_55_0:isLineup() and (var_55_0 > 0 or var_55_1 > 0 or var_55_2.level > 1 or var_55_2.exp > 0)
	end)

	table.sort(var_54_0, function(arg_56_0, arg_56_1)
		if arg_56_0:getLevel() ~= arg_56_1:getLevel() then
			return arg_56_0:getLevel() > arg_56_1:getLevel()
		end

		if arg_56_0:getQuality() ~= arg_56_1:getQuality() then
			return arg_56_0:getQuality() > arg_56_1:getQuality()
		end

		return arg_56_0:getAdvanceId() > arg_56_1:getAdvanceId()
	end)

	return var_54_0
end

function RebornData:getCustomFragRebornList()
	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs((g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.ITEM))) do
		local var_57_1 = g.core.config.item_info.get(iter_57_1.id)

		if (var_57_1.item_type ~= 2 or var_57_1.quality < g.core.const.ConstMgr.QUALITY_TYPE.UR) and (var_57_1.item_type ~= 17 or var_57_1.quality < g.core.const.ConstMgr.QUALITY_TYPE.UR) and (var_57_1.item_type ~= 76 or var_57_1.quality < g.core.const.ConstMgr.QUALITY_TYPE.UR) and (var_57_1.item_type ~= 82 or var_57_1.quality < g.core.const.ConstMgr.QUALITY_TYPE.UR) and (var_57_1.item_type ~= 98 or var_57_1.quality < g.core.const.ConstMgr.QUALITY_TYPE.UR) then
			if var_57_1.item_type == 138 and var_57_1.quality >= g.core.const.ConstMgr.QUALITY_TYPE.MR then
				table.insert(var_57_0, (g.core.common.Goods:convert({
					type = g.core.common.Goods.TYPE_ITEM,
					value = iter_57_1.id,
					size = iter_57_1.num
				})))
			end
		end
	end

	table.sort(var_57_0, function(arg_58_0, arg_58_1)
		local var_58_0 = g.core.config.item_info.get(arg_58_0.value)
		local var_58_1 = g.core.config.item_info.get(arg_58_1.value)

		if var_58_0.item_type == var_58_1.item_type then
			return var_58_0.quality > var_58_1.quality
		else
			return var_58_0.item_type < var_58_1.item_type
		end
	end)

	return var_57_0
end

function RebornData:getCustomFragRebornId(arg_59_1)
	local var_59_0 = g.core.config.item_info.get(arg_59_1)

	return g.core.config.item_info.match(function(arg_60_0)
		return arg_60_0.item_type == var_59_0.item_type and arg_60_0.quality == var_59_0.quality - 1
	end)[1].id
end

function RebornData:getRebornList()
	local var_61_0 = g.core.model.User:getLevel()

	if self._showTabCfg then
		local var_61_1 = {}

		for iter_61_0, iter_61_1 in pairs(self._showTabCfg) do
			if var_61_0 >= iter_61_1.cfg.open_level and iter_61_1.show and iter_61_1.show() then
				table.insert(var_61_1, iter_61_1)
			end
		end

		table.sort(var_61_1, function(arg_62_0, arg_62_1)
			return arg_62_0.index < arg_62_1.index
		end)

		return var_61_1
	end

	local var_61_2 = g.core.config.reborn_info
	local var_61_3 = clone(RebornConst.SERVER_TYPE_CFG_MAP)

	for iter_61_2 = 1, g.core.config.reborn_info.getLength() do
		local var_61_4 = var_61_2.indexOf(iter_61_2)

		if var_61_3[var_61_4.type] and var_61_3[var_61_4.type].type == var_61_4.reborn_type then
			var_61_3[var_61_4.type].cfg = var_61_4
		end
	end

	self._showTabCfg = var_61_3

	local var_61_5 = {}

	for iter_61_3, iter_61_4 in pairs(self._showTabCfg) do
		if var_61_0 >= iter_61_4.cfg.open_level and iter_61_4.show() then
			table.insert(var_61_5, iter_61_4)
		end
	end

	table.sort(var_61_5, function(arg_63_0, arg_63_1)
		return arg_63_0.index < arg_63_1.index
	end)

	return var_61_5
end

return RebornData
