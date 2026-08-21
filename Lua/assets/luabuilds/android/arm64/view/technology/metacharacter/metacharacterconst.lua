MetaCharacterConst = {}

local var_0_0 = MetaCharacterConst

MetaCharacterConst.Meta_Type_Act_PT = 1
MetaCharacterConst.Meta_Type_Build = 2
MetaCharacterConst.Meta_Type_Pass = 3
MetaCharacterConst.REPAIR_ATTRS = {
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.Air,
	AttributeType.Reload
}
MetaCharacterConst.ENERGY_ATTRS = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.AntiSub,
	AttributeType.Expend
}
MetaCharacterConst.UIConfig = {}

setmetatable(MetaCharacterConst.UIConfig, {
	__index = function(arg_1_0, arg_1_1)
		if pg.ship_strengthen_meta[arg_1_1].uiconfig then
			return pg.ship_strengthen_meta[arg_1_1].uiconfig
		else
			return var_0_0.UIConfig[970701]
		end

		return
	end
})

MetaCharacterConst.META_ART_RESOURCE_PERFIX = "metaship/"
MetaCharacterConst.META_ACTIVE_LASTFIX = "_active"
MetaCharacterConst.META_DISACTIVE_LASTFIX = "_disactive"
MetaCharacterConst.META_BANNER_PERFIX = "banner_"
MetaCharacterConst.META_NAME_PERFIX = "name_"
MetaCharacterConst.META_TOAST_PERFIX = "toast_"
MetaCharacterConst.HX_TAG = "_hx"

function MetaCharacterConst.GetMetaCharacterPaintPath(arg_2_0, arg_2_1)
	if not HXSet.isHx() then
		if arg_2_1 == true then
			return var_0_0.META_ART_RESOURCE_PERFIX .. arg_2_0 .. var_0_0.META_ACTIVE_LASTFIX, arg_2_0 .. var_0_0.META_ACTIVE_LASTFIX
		else
			return var_0_0.META_ART_RESOURCE_PERFIX .. arg_2_0 .. var_0_0.META_DISACTIVE_LASTFIX, arg_2_0 .. var_0_0.META_DISACTIVE_LASTFIX
		end
	elseif arg_2_1 == true then
		local var_2_0 = arg_2_0 .. var_0_0.META_ACTIVE_LASTFIX .. var_0_0.HX_TAG
		local var_2_1 = var_0_0.META_ART_RESOURCE_PERFIX .. arg_2_0 .. var_0_0.META_ACTIVE_LASTFIX .. var_0_0.HX_TAG

		if not checkABExist(var_0_0.META_ART_RESOURCE_PERFIX .. arg_2_0 .. var_0_0.META_ACTIVE_LASTFIX .. var_0_0.HX_TAG) then
			var_2_0 = arg_2_0 .. var_0_0.META_ACTIVE_LASTFIX
			var_2_1 = var_0_0.META_ART_RESOURCE_PERFIX .. arg_2_0 .. var_0_0.META_ACTIVE_LASTFIX
		end

		return var_2_1, var_2_0
	else
		local var_2_2 = arg_2_0 .. var_0_0.META_DISACTIVE_LASTFIX .. var_0_0.HX_TAG
		local var_2_3 = var_0_0.META_ART_RESOURCE_PERFIX .. arg_2_0 .. var_0_0.META_DISACTIVE_LASTFIX .. var_0_0.HX_TAG

		if not checkABExist(var_0_0.META_ART_RESOURCE_PERFIX .. arg_2_0 .. var_0_0.META_DISACTIVE_LASTFIX .. var_0_0.HX_TAG) then
			var_2_2 = arg_2_0 .. var_0_0.META_DISACTIVE_LASTFIX
			var_2_3 = var_0_0.META_ART_RESOURCE_PERFIX .. arg_2_0 .. var_0_0.META_DISACTIVE_LASTFIX
		end

		return var_2_3, var_2_2
	end

	return
end

function MetaCharacterConst.GetMetaCharacterBannerPath(arg_3_0)
	return var_0_0.META_ART_RESOURCE_PERFIX .. var_0_0.META_BANNER_PERFIX .. arg_3_0, var_0_0.META_BANNER_PERFIX .. arg_3_0
end

function MetaCharacterConst.GetMetaCharacterNamePath(arg_4_0)
	return var_0_0.META_ART_RESOURCE_PERFIX .. var_0_0.META_NAME_PERFIX .. arg_4_0, var_0_0.META_NAME_PERFIX .. arg_4_0
end

function MetaCharacterConst.GetMetaCharacterToastPath(arg_5_0)
	return var_0_0.META_ART_RESOURCE_PERFIX .. var_0_0.META_TOAST_PERFIX .. arg_5_0, var_0_0.META_TOAST_PERFIX .. arg_5_0
end

function MetaCharacterConst.GetMetaShipGroupIDByConfigID(arg_6_0)
	return math.floor(arg_6_0 / 10)
end

function MetaCharacterConst.isMetaRepairRedTag(arg_7_0)
	if not arg_7_0 then
		return false
	end

	local var_7_0 = getProxy(BayProxy):getMetaShipByGroupId(arg_7_0)

	if not var_7_0 then
		return false
	end

	local var_7_1 = var_7_0:getMetaCharacter()

	if not var_7_1 then
		return false
	end

	local var_7_2 = false

	for iter_7_0, iter_7_1 in ipairs(MetaCharacterConst.REPAIR_ATTRS) do
		var_7_2 = var_7_1:getAttrVO(iter_7_1):isCanRepair()

		if var_7_2 == true then
			break
		end
	end

	return var_7_2
end

function MetaCharacterConst.isMetaEnergyRedTag(arg_8_0)
	if not arg_8_0 then
		return false
	end

	local var_8_0 = getProxy(BayProxy):getMetaShipByGroupId(arg_8_0)

	if not var_8_0 then
		return false
	end

	local var_8_1 = var_8_0:getMetaCharacter()

	if not var_8_1 then
		return false
	end

	local var_8_2 = true
	local var_8_3 = var_8_1:getBreakOutInfo()

	if not var_8_3:hasNextInfo() then
		var_8_2 = false
	end

	local var_8_4, var_8_5 = var_8_3:getLimited()

	if var_8_4 > var_8_0.level or var_8_5 > var_8_1:getCurRepairExp() then
		var_8_2 = false
	end

	local var_8_6, var_8_7 = var_8_3:getConsume()

	if var_8_7[1].count > getProxy(BagProxy):getItemCountById(var_8_7[1].itemId) then
		var_8_2 = false
	end

	local var_8_11 = getProxy(PlayerProxy)

	if var_8_6 > var_8_11:getData().gold then
		var_8_2 = false
	end

	return var_8_2
end

function MetaCharacterConst.isMetaTacticsRedTag(arg_9_0)
	return getProxy(MetaCharacterProxy):getRedTag(arg_9_0)
end

function MetaCharacterConst.isMetaSynRedTag(arg_10_0)
	if not arg_10_0 then
		return false
	end

	local var_10_0 = getProxy(BayProxy):getMetaShipByGroupId(arg_10_0)

	if not var_10_0 then
		return false
	end

	if not var_10_0:getMetaCharacter() then
		return false
	end

	local var_10_1 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_10_0)

	if var_10_1:isPassType() or var_10_1:isBuildType() then
		return false
	end

	if not var_10_1:isShow() then
		return false
	end

	local var_10_2 = false

	if var_10_1.metaPtData then
		var_10_2 = var_10_1.metaPtData:CanGetAward()
	end

	return var_10_2
end

function MetaCharacterConst.isMetaMainSceneRedTag(arg_11_0)
	if not arg_11_0 then
		return false
	end

	local var_11_0 = getProxy(BayProxy)

	if var_11_0:getMetaShipByGroupId(arg_11_0) then
		return false
	end

	local var_11_1 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_11_0)

	if var_11_1:isPassType() or var_11_1:isBuildType() then
		return false
	end

	if not var_11_1:isShow() then
		return false
	end

	local var_11_2 = var_11_1:getMetaProgressPTState()

	if var_11_2 == MetaProgress.STATE_CAN_FINISH or var_11_2 == MetaProgress.STATE_CAN_AWARD then
		return true
	end

	return
end

function MetaCharacterConst.isMetaMainEntRedPoint()
	for iter_12_0, iter_12_1 in ipairs((getProxy(MetaCharacterProxy):getMetaProgressVOList())) do
		local var_12_0 = var_0_0.isMetaMainSceneRedTag(iter_12_1.id) or var_0_0.isMetaSynRedTag(iter_12_1.id)

		if var_12_0 == true then
			return true
		end
	end

	return false
end

function MetaCharacterConst.isMetaBannerRedPoint(arg_13_0)
	local var_13_0 = var_0_0.isMetaTacticsRedTag(arg_13_0) or var_0_0.isMetaSynRedTag(arg_13_0)
	local var_13_1 = getProxy(BayProxy):getMetaShipByGroupId(arg_13_0)

	if var_13_1 then
		local var_13_2 = getProxy(MetaCharacterProxy):getMetaTacticsInfoByShipID(var_13_1.id):getTacticsStateForShow() == MetaTacticsInfo.States.LearnAble

		var_13_0 = var_13_0 or var_13_2
	else
		local var_13_3 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_13_0)

		if var_13_3:isPtType() then
			var_13_0 = var_13_0 or var_13_3.metaPtData:CanGetAward()
		end
	end

	return var_13_0
end

function MetaCharacterConst.getFinalSkillIDListByMetaGroupID(arg_14_0)
	local var_14_0

	for iter_14_0 = 1, 4 do
		if pg.ship_data_template[arg_14_0 * 10 + iter_14_0] then
			var_14_0 = arg_14_0 * 10 + iter_14_0
		end

		break
	end

	local var_14_1 = {}

	for iter_14_1, iter_14_2 in ipairs(pg.ship_data_template[var_14_0].buff_list_display) do
		table.insert(var_14_1, iter_14_2)
	end

	return var_14_1
end

function MetaCharacterConst.getTacticsSkillIDListByShipConfigID(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(pg.ship_data_template[arg_15_0].buff_list_display) do
		if MetaCharacterConst.isMetaTaskSkillID(iter_15_1) then
			table.insert({}, iter_15_1)
		end
	end

	return {}
end

function MetaCharacterConst.getMetaSkillTacticsConfig(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(pg.ship_meta_skilltask.all) do
		if pg.ship_meta_skilltask[iter_16_1].skill_ID == arg_16_0 and pg.ship_meta_skilltask[iter_16_1].level == arg_16_1 then
			return pg.ship_meta_skilltask[iter_16_1]
		end
	end

	return
end

function MetaCharacterConst.addReMetaTransItem(arg_17_0, arg_17_1)
	if not arg_17_0.virgin and arg_17_0:isMetaShip() and Player.isMetaShipNeedToTrans(arg_17_0.configId) then
		local var_17_0 = Player.metaShip2Res(arg_17_0.configId)

		if not arg_17_1 then
			for iter_17_0, iter_17_1 in ipairs(var_17_0) do
				pg.m02:sendNotification(GAME.ADD_ITEM, (Drop.New({
					type = iter_17_1.type,
					id = iter_17_1.id,
					count = iter_17_1.count
				})))
			end
		end

		;({}).type = var_17_0[1].type
		;({}).id = var_17_0[1].id
		;({}).count = var_17_0[1].count

		return (Drop.New({}))
	end

	return
end

function MetaCharacterConst.isMetaTaskSkillID(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(pg.ship_meta_skilltask.all) do
		if pg.ship_meta_skilltask[iter_18_1].skill_ID == arg_18_0 then
			return true
		end
	end

	return false
end

function MetaCharacterConst.isMetaInArchive(arg_19_0)
	local var_19_0 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_19_0)

	if var_19_0:isPtType() and var_19_0:isInArchive() then
		return true
	else
		return false
	end

	return
end

function MetaCharacterConst.getRepairAbleMetaProgressVOList()
	for iter_20_0, iter_20_1 in ipairs((getProxy(MetaCharacterProxy):getMetaProgressVOList())) do
		if iter_20_1.metaShipVO then
			local var_20_0 = iter_20_1.metaShipVO:getMetaCharacter()

			if var_20_0 and var_20_0:getRepairRate() < 1 then
				table.insert({}, iter_20_1)
			end
		end
	end

	return {}
end

function MetaCharacterConst.getTacticsAbleMetaProgressVOList()
	for iter_21_0, iter_21_1 in ipairs((getProxy(MetaCharacterProxy):getMetaProgressVOList())) do
		if iter_21_1.metaShipVO and not iter_21_1.metaShipVO:isAllMetaSkillLevelMax() then
			table.insert({}, iter_21_1)
		end
	end

	return {}
end

function MetaCharacterConst.getEnergyAbleMetaProgressVOList()
	for iter_22_0, iter_22_1 in ipairs((getProxy(MetaCharacterProxy):getMetaProgressVOList())) do
		if iter_22_1.metaShipVO and not iter_22_1.metaShipVO:isMaxStar() then
			table.insert({}, iter_22_1)
		end
	end

	return {}
end

function MetaCharacterConst.filteMetaByType(arg_23_0, arg_23_1)
	if not arg_23_1 or arg_23_1 == ShipIndexConst.TypeAll then
		return true
	end

	for iter_23_0 = 2, #ShipIndexCfg.type do
		if bit.band(bit.lshift(1, iter_23_0 - 2), arg_23_1) > 0 then
			if iter_23_0 < 4 then
				local var_23_1 = var_23_0(arg_23_0.id)
				local var_23_2 = (function(arg_25_0)
					return ShipType.GetTeamFromShipType(arg_25_0)
				end)(var_23_1)

				if table.contains(ShipIndexCfg.type[iter_23_0].shipTypes, var_23_1) then
					return true
				end

				if table.contains(ShipIndexCfg.type[iter_23_0].types, var_23_2) then
					return true
				end
			elseif table.contains(ShipIndexCfg.type[iter_23_0].types, (var_23_0(arg_23_0.id))) then
				return true
			end
		end
	end

	return false
end

function MetaCharacterConst.filteMetaByRarity(arg_26_0, arg_26_1)
	if not arg_26_1 or arg_26_1 == ShipIndexConst.RarityAll then
		return true
	end

	for iter_26_0 = 2, #ShipIndexCfg.rarity do
		if bit.band(bit.lshift(1, iter_26_0 - 2), arg_26_1) > 0 and table.contains(ShipIndexCfg.rarity[iter_26_0].types, var_26_0(arg_26_0.id)) then
			return true
		end
	end

	return false
end

function MetaCharacterConst.filteMetaExtra(arg_28_0, arg_28_1)
	if not arg_28_1 or arg_28_1 == ShipIndexConst.MetaExtraAll then
		return true
	end

	if ShipIndexConst.MetaExtraRepair == arg_28_1 then
		return var_0_0.filteMetaRepairAble(arg_28_0)
	elseif ShipIndexConst.MetaExtraTactics == arg_28_1 then
		return var_0_0.filteMetaTacticsAble(arg_28_0)
	elseif ShipIndexConst.MetaExtraEnergy == arg_28_1 then
		return var_0_0.filteMetaEnergyAble(arg_28_0)
	else
		return false
	end

	return
end

function MetaCharacterConst.filteMetaRepairAble(arg_29_0)
	if arg_29_0.metaShipVO then
		local var_29_0 = arg_29_0.metaShipVO:getMetaCharacter()

		if var_29_0 and var_29_0:getRepairRate() < 1 then
			return true
		end
	end

	return false
end

function MetaCharacterConst.filteMetaTacticsAble(arg_30_0)
	if arg_30_0.metaShipVO and not arg_30_0.metaShipVO:isAllMetaSkillLevelMax() then
		return true
	end

	return false
end

function MetaCharacterConst.filteMetaEnergyAble(arg_31_0)
	if arg_31_0.metaShipVO and not arg_31_0.metaShipVO:isMaxStar() then
		return true
	end

	return false
end

function MetaCharacterConst.filteMetaSynAble(arg_32_0)
	if arg_32_0:isPtType() then
		return not arg_32_0:IsGotAllAwards()
	else
		return false
	end

	return
end

return MetaCharacterConst
