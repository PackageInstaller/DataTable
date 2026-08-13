local var_0_0 = {}

MetaCharacterConst = MetaCharacterConst
var_0.Meta_Type_Act_PT = 1
var_0.Meta_Type_Build = 2
var_0.Meta_Type_Pass = 3

local var_0_1 = {}

AttributeType = var_0_10002
var_0_1[1] = var_0_10002.Cannon
AttributeType = var_2
var_0_1[2] = var_2.Torpedo
AttributeType = var_2
var_0_1[3] = var_2.Air
AttributeType = var_2
var_0_1[4] = var_2.Reload
var_0.REPAIR_ATTRS = var_0_1

local var_0_2 = {}

AttributeType = var_2
var_0_2[1] = var_2.Durability
AttributeType = var_2
var_0_2[2] = var_2.Cannon
AttributeType = var_2
var_0_2[3] = var_2.Torpedo
AttributeType = var_2
var_0_2[4] = var_2.AntiAircraft
AttributeType = var_2
var_0_2[5] = var_2.Air
AttributeType = var_2
var_0_2[6] = var_2.AntiSub
AttributeType = var_2
var_0_2[7] = var_2.Expend
var_0.ENERGY_ATTRS = var_0_2
var_0.UIConfig = {}
setmetatable = var_1

var_1(var_0.UIConfig, {
	__index = function(arg_1_0, arg_1_1)
		pg = var_1_10002

		if var_1_10002.ship_strengthen_meta[arg_1_1].uiconfig then
			return var_3
		else
			return var_0.UIConfig[970701]
		end

		return
	end
})

var_0.META_ART_RESOURCE_PERFIX = "metaship/"
var_0.META_ACTIVE_LASTFIX = "_active"
var_0.META_DISACTIVE_LASTFIX = "_disactive"
var_0.META_BANNER_PERFIX = "banner_"
var_0.META_NAME_PERFIX = "name_"
var_0.META_TOAST_PERFIX = "toast_"
var_0.HX_TAG = "_hx"

function var_0.GetMetaCharacterPaintPath(arg_2_0, arg_2_1)
	HXSet = var_1_10002

	if not var_1_10002.isHx() then
		if arg_2_1 == true then
			local var_2_0 = arg_2_0 .. var_0.META_ACTIVE_LASTFIX

			return var_0.META_ART_RESOURCE_PERFIX .. var_2_0, var_2_0
		else
			local var_2_1 = arg_2_0 .. var_0.META_DISACTIVE_LASTFIX

			return var_0.META_ART_RESOURCE_PERFIX .. var_2_1, var_2_1
		end
	elseif arg_2_1 == true then
		local var_2_2 = arg_2_0 .. var_0.META_ACTIVE_LASTFIX .. var_0.HX_TAG
		local var_2_3 = var_0.META_ART_RESOURCE_PERFIX .. var_2_2

		checkABExist = var_5

		if not var_5(var_2_3) then
			var_2_2 = arg_2_0 .. var_0.META_ACTIVE_LASTFIX
			var_2_3 = var_0.META_ART_RESOURCE_PERFIX .. var_2_2
		end

		return var_2_3, var_2_2
	else
		local var_2_4 = arg_2_0 .. var_0.META_DISACTIVE_LASTFIX .. var_0.HX_TAG
		local var_2_5 = var_0.META_ART_RESOURCE_PERFIX .. var_2_4

		checkABExist = var_5

		if not var_5(var_2_5) then
			var_2_4 = arg_2_0 .. var_0.META_DISACTIVE_LASTFIX
			var_2_5 = var_0.META_ART_RESOURCE_PERFIX .. var_2_4
		end

		return var_2_5, var_2_4
	end

	return
end

function var_0.GetMetaCharacterBannerPath(arg_3_0)
	local var_3_0 = var_0.META_BANNER_PERFIX .. arg_3_0

	return var_0.META_ART_RESOURCE_PERFIX .. var_3_0, var_3_0
end

function var_0.GetMetaCharacterNamePath(arg_4_0)
	local var_4_0 = var_0.META_NAME_PERFIX .. arg_4_0

	return var_0.META_ART_RESOURCE_PERFIX .. var_4_0, var_4_0
end

function var_0.GetMetaCharacterToastPath(arg_5_0)
	local var_5_0 = var_0.META_TOAST_PERFIX .. arg_5_0

	return var_0.META_ART_RESOURCE_PERFIX .. var_5_0, var_5_0
end

function var_0.GetMetaShipGroupIDByConfigID(arg_6_0)
	math = var_1_10001

	return var_1_10001.floor(arg_6_0 / 10)
end

function var_0.isMetaRepairRedTag(arg_7_0)
	if not arg_7_0 then
		return false
	end

	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)

	if not var_1.getMetaShipByGroupId(var_7_0, arg_7_0) then
		return false
	end

	if not var_1:getMetaCharacter() then
		return false
	end

	local var_7_1 = false

	ipairs = var_1_10004
	MetaCharacterConst = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10004(var_1_10005.REPAIR_ATTRS) do
		local var_7_2 = var_2:getAttrVO(iter_7_1)

		if var_9.isCanRepair(var_7_2) == true then
			break
		end
	end

	return var_7_1
end

function var_0.isMetaEnergyRedTag(arg_8_0)
	if not arg_8_0 then
		return false
	end

	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)

	if not var_1.getMetaShipByGroupId(var_8_0, arg_8_0) then
		return false
	end

	if not var_1:getMetaCharacter() then
		return false
	end

	local var_8_1 = true
	local var_8_2 = var_2:getBreakOutInfo()

	if not var_4.hasNextInfo(var_8_2) then
		var_8_1 = false
	end

	local var_8_3, var_8_4 = var_4:getLimited()

	if var_8_3 > var_1.level or var_8_4 > var_2:getCurRepairExp() then
		var_8_1 = false
	end

	local var_8_5, var_8_6 = var_4:getConsume()
	local var_8_7
	local var_8_8
	local var_8_9
	local var_8_10 = var_8_6[1].itemId
	local var_8_11 = var_8_6[1].count

	getProxy = var_12
	BagProxy = var_1_10013

	local var_8_12 = var_12(var_1_10013)

	if var_8_11 > var_12.getItemCountById(var_8_12, var_8_10) then
		var_8_1 = false
	end

	getProxy = var_12
	PlayerProxy = var_8_12

	local var_8_13 = var_12(var_8_12)

	if var_8_5 > var_12.getData(var_8_13).gold then
		var_8_1 = false
	end

	return var_8_1
end

function var_0.isMetaTacticsRedTag(arg_9_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)

	return var_1.getRedTag(var_9_0, arg_9_0)
end

function var_0.isMetaSynRedTag(arg_10_0)
	if not arg_10_0 then
		return false
	end

	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)

	if not var_1.getMetaShipByGroupId(var_10_0, arg_10_0) then
		return false
	end

	local var_10_1 = var_1

	if not var_1.getMetaCharacter(var_10_1) then
		return false
	end

	getProxy = var_10_1
	MetaCharacterProxy = var_1_10004

	local var_10_2 = var_10_1(var_1_10004)
	local var_10_3 = var_3.getMetaProgressVOByID(var_10_2, arg_10_0)

	if var_3.isPassType(var_10_3) or var_3:isBuildType() then
		return false
	end

	if not var_3:isShow() then
		return false
	end

	local var_10_4 = false

	if var_3.metaPtData then
		local var_10_5 = var_3.metaPtData

		var_10_4 = var_5.CanGetAward(var_10_5)
	end

	return var_10_4
end

function var_0.isMetaMainSceneRedTag(arg_11_0)
	if not arg_11_0 then
		return false
	end

	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)

	if var_1.getMetaShipByGroupId(var_11_0, arg_11_0) then
		return false
	end

	getProxy = var_11_0
	MetaCharacterProxy = var_3

	local var_11_1 = var_11_0(var_3)
	local var_11_2 = var_2.getMetaProgressVOByID(var_11_1, arg_11_0)

	if var_2.isPassType(var_11_2) or var_2:isBuildType() then
		return false
	end

	if not var_2:isShow() then
		return false
	end

	local var_11_3 = var_2
	local var_11_4 = var_2.getMetaProgressPTState(var_11_3)

	MetaProgress = var_11_3

	if var_11_4 ~= var_11_3.STATE_CAN_FINISH then
		MetaProgress = var_4

		if var_11_4 == var_4.STATE_CAN_AWARD then
			return true
		end

		return
	end
end

function var_0.isMetaMainEntRedPoint()
	getProxy = var_1_10000
	MetaCharacterProxy = var_1_10001

	local var_12_0 = var_1_10000(var_1_10001)
	local var_12_1 = var_0.getMetaProgressVOList(var_12_0)

	ipairs = var_12_0

	for iter_12_0, iter_12_1 in var_12_0(var_12_1) do
		local var_12_2

		if not var_0.isMetaMainSceneRedTag(iter_12_1.id) then
			var_12_2 = var_0.isMetaSynRedTag(iter_12_1.id)
		end

		if var_12_2 == true then
			return true
		end
	end

	return false
end

function var_0.isMetaBannerRedPoint(arg_13_0)
	local var_13_0

	if not var_0.isMetaTacticsRedTag(arg_13_0) then
		var_13_0 = var_0.isMetaSynRedTag(arg_13_0)
	end

	getProxy = var_2
	BayProxy = var_1_10003

	local var_13_1 = var_2(var_1_10003)
	local var_13_2

	if var_2.getMetaShipByGroupId(var_13_1, arg_13_0) then
		getProxy = var_13_1
		MetaCharacterProxy = var_13_2
		var_13_2 = var_13_1(var_13_2)
		var_13_2 = var_13_1.getMetaTacticsInfoByShipID(var_13_2, var_2.id)
		var_13_1 = var_13_1.getTacticsStateForShow(var_13_2)
		MetaTacticsInfo = var_13_2
		var_13_1 = var_13_1 == var_13_2.States.LearnAble
		var_13_0 = var_13_0 or var_13_1
	else
		getProxy = var_13_1
		MetaCharacterProxy = var_13_2

		local var_13_3 = var_13_1(var_13_2)
		local var_13_4 = var_3.getMetaProgressVOByID(var_13_3, arg_13_0)

		if var_3.isPtType(var_13_4) and not var_13_0 then
			local var_13_5 = var_3.metaPtData

			var_13_0 = var_4.CanGetAward(var_13_5)
		end
	end

	return var_13_0
end

function var_0.getFinalSkillIDListByMetaGroupID(arg_14_0)
	local var_14_0

	for iter_14_0 = 1, 4 do
		local var_14_1 = arg_14_0 * 10 + iter_14_0

		pg = var_1_10007

		if var_1_10007.ship_data_template[var_14_1] then
			var_14_0 = var_14_1
		end

		break
	end

	local var_14_2 = {}

	ipairs = var_3
	pg = var_4

	for iter_14_1, iter_14_2 in var_3(var_4.ship_data_template[var_14_0].buff_list_display) do
		table = var_1_10008

		var_1_10008.insert(var_14_2, iter_14_2)
	end

	return var_14_2
end

function var_0.getTacticsSkillIDListByShipConfigID(arg_15_0)
	local var_15_0 = {}

	pg = var_1_10002

	local var_15_1 = var_1_10002.ship_data_template[arg_15_0].buff_list_display

	ipairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(var_15_1) do
		MetaCharacterConst = var_1_10009

		if var_1_10009.isMetaTaskSkillID(iter_15_1) then
			table = var_1_10009

			var_1_10009.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function var_0.getMetaSkillTacticsConfig(arg_16_0, arg_16_1)
	ipairs = var_1_10002
	pg = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10002(var_1_10003.ship_meta_skilltask.all) do
		pg = var_1_10007

		if var_1_10007.ship_meta_skilltask[iter_16_1].skill_ID == arg_16_0 and var_1_10007.level == arg_16_1 then
			return var_1_10007
		end
	end

	return
end

function var_0.addReMetaTransItem(arg_17_0, arg_17_1)
	if not arg_17_0.virgin and arg_17_0:isMetaShip() then
		Player = var_2

		if var_2.isMetaShipNeedToTrans(arg_17_0.configId) then
			Player = var_2

			local var_17_0 = var_2.metaShip2Res(arg_17_0.configId)

			if not arg_17_1 then
				ipairs = var_3

				for iter_17_0, iter_17_1 in var_3(var_17_0) do
					local var_17_1 = iter_17_1.type
					local var_17_2 = iter_17_1.id
					local var_17_3 = iter_17_1.count

					Drop = var_1_10011
					var_1_10011 = var_1_10011.New({
						type = var_17_1,
						id = var_17_2,
						count = var_17_3
					})
					pg = var_12

					local var_17_4 = var_12.m02
					local var_17_5 = var_12.sendNotification

					GAME = var_1_10014

					var_17_5(var_17_4, var_1_10014.ADD_ITEM, var_1_10011)
				end
			end

			local var_17_6 = var_17_0[1].type
			local var_17_7 = var_17_0[1].id
			local var_17_8 = var_17_0[1].count

			Drop = iter_17_0

			return (iter_17_0.New({
				type = var_17_6,
				id = var_17_7,
				count = var_17_8
			}))
		end
	end

	return
end

function var_0.isMetaTaskSkillID(arg_18_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10001(var_1_10002.ship_meta_skilltask.all) do
		pg = var_1_10006

		if var_1_10006.ship_meta_skilltask[iter_18_1].skill_ID == arg_18_0 then
			return true
		end
	end

	return false
end

function var_0.isMetaInArchive(arg_19_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)
	local var_19_1 = var_1.getMetaProgressVOByID(var_19_0, arg_19_0)

	if var_2.isPtType(var_19_1) and var_2:isInArchive() then
		return true
	else
		return false
	end

	return
end

function var_0.getRepairAbleMetaProgressVOList()
	local var_20_0 = {}

	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002

	local var_20_1 = var_1_10001(var_1_10002)
	local var_20_2 = var_1.getMetaProgressVOList(var_20_1)

	ipairs = var_20_1

	for iter_20_0, iter_20_1 in var_20_1(var_20_2) do
		if iter_20_1.metaShipVO and var_8:getMetaCharacter() and var_9:getRepairRate() < 1 then
			table = var_11

			var_11.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function var_0.getTacticsAbleMetaProgressVOList()
	local var_21_0 = {}

	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002

	local var_21_1 = var_1_10001(var_1_10002)
	local var_21_2 = var_1.getMetaProgressVOList(var_21_1)

	ipairs = var_21_1

	for iter_21_0, iter_21_1 in var_21_1(var_21_2) do
		if iter_21_1.metaShipVO then
			local var_21_3 = var_8

			if not var_8.isAllMetaSkillLevelMax(var_21_3) then
				table = var_21_3

				var_21_3.insert(var_21_0, iter_21_1)
			end
		end
	end

	return var_21_0
end

function var_0.getEnergyAbleMetaProgressVOList()
	local var_22_0 = {}

	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002

	local var_22_1 = var_1_10001(var_1_10002)
	local var_22_2 = var_1.getMetaProgressVOList(var_22_1)

	ipairs = var_22_1

	for iter_22_0, iter_22_1 in var_22_1(var_22_2) do
		if iter_22_1.metaShipVO then
			local var_22_3 = var_8

			if not var_8.isMaxStar(var_22_3) then
				table = var_22_3

				var_22_3.insert(var_22_0, iter_22_1)
			end
		end
	end

	return var_22_0
end

function var_0.filteMetaByType(arg_23_0, arg_23_1)
	if arg_23_1 then
		ShipIndexConst = var_1_10002

		if arg_23_1 == var_1_10002.TypeAll then
			return true
		end

		local function var_23_0(arg_24_0)
			local var_24_0

			for iter_24_0 = 1, 4 do
				local var_24_1 = arg_24_0 * 10 + iter_24_0

				pg = var_2_10007

				if var_2_10007.ship_data_template[var_24_1] then
					var_24_0 = var_24_1
				end

				break
			end

			pg = var_2

			return var_2.ship_data_statistics[var_24_0].type
		end

		local function var_23_1(arg_25_0)
			ShipType = var_2_10001

			return var_2_10001.GetTeamFromShipType(arg_25_0)
		end

		local var_23_2 = 2

		ShipIndexCfg = var_1_10005

		for iter_23_0 = var_23_2, #var_1_10005.type do
			bit = var_1_10008
			var_1_10008 = var_1_10008.lshift(1, iter_23_0 - 2)
			bit = var_9

			if var_9.band(var_1_10008, arg_23_1) > 0 then
				local var_23_5

				if iter_23_0 < 4 then
					local var_23_3 = var_23_0(arg_23_0.id)
					local var_23_4 = var_23_1(var_23_3)

					ShipIndexCfg = var_23_5
					var_23_5 = var_23_5.type[iter_23_0].shipTypes
					ShipIndexCfg = var_1_10012
					var_1_10012 = var_1_10012.type[iter_23_0].types
					table = var_1_10013

					if var_1_10013.contains(var_23_5, var_23_3) then
						return true
					end

					table = var_1_10013

					if var_1_10013.contains(var_1_10012, var_23_4) then
						return true
					end
				else
					local var_23_6 = var_23_0(arg_23_0.id)

					ShipIndexCfg = var_10

					local var_23_7 = var_10.type[iter_23_0].types

					table = var_23_5

					if var_23_5.contains(var_23_7, var_23_6) then
						return true
					end
				end
			end
		end

		return false
	end
end

function var_0.filteMetaByRarity(arg_26_0, arg_26_1)
	if arg_26_1 then
		ShipIndexConst = var_1_10002

		if arg_26_1 == var_1_10002.RarityAll then
			return true
		end

		local function var_26_0(arg_27_0)
			local var_27_0

			for iter_27_0 = 1, 4 do
				local var_27_1 = arg_27_0 * 10 + iter_27_0

				pg = var_2_10007

				if var_2_10007.ship_data_template[var_27_1] then
					var_27_0 = var_27_1
				end

				break
			end

			pg = var_2

			return var_2.ship_data_statistics[var_27_0].rarity
		end

		local var_26_1 = 2

		ShipIndexCfg = var_1_10004

		for iter_26_0 = var_26_1, #var_1_10004.rarity do
			bit = var_1_10007
			var_1_10007 = var_1_10007.lshift(1, iter_26_0 - 2)
			bit = var_8

			local var_26_2 = var_8.band(var_1_10007, arg_26_1)

			if 0 < var_26_2 then
				ShipIndexCfg = var_26_2

				local var_26_3 = var_26_2.rarity[iter_26_0].types

				table = var_9

				if var_9.contains(var_26_3, var_26_0(arg_26_0.id)) then
					return true
				end
			end
		end

		return false
	end
end

function var_0.filteMetaExtra(arg_28_0, arg_28_1)
	if arg_28_1 then
		ShipIndexConst = var_1_10002

		if arg_28_1 == var_1_10002.MetaExtraAll then
			return true
		end

		ShipIndexConst = var_1_10002

		if var_1_10002.MetaExtraRepair == arg_28_1 then
			return var_0.filteMetaRepairAble(arg_28_0)
		else
			ShipIndexConst = var_2

			if var_2.MetaExtraTactics == arg_28_1 then
				return var_0.filteMetaTacticsAble(arg_28_0)
			else
				ShipIndexConst = var_2

				if var_2.MetaExtraEnergy == arg_28_1 then
					return var_0.filteMetaEnergyAble(arg_28_0)
				else
					return false
				end
			end
		end

		return
	end
end

function var_0.filteMetaRepairAble(arg_29_0)
	if arg_29_0.metaShipVO and var_1:getMetaCharacter() and var_2:getRepairRate() < 1 then
		return true
	end

	return false
end

function var_0.filteMetaTacticsAble(arg_30_0)
	if arg_30_0.metaShipVO and not var_1:isAllMetaSkillLevelMax() then
		return true
	end

	return false
end

function var_0.filteMetaEnergyAble(arg_31_0)
	if arg_31_0.metaShipVO and not var_1:isMaxStar() then
		return true
	end

	return false
end

function var_0.filteMetaSynAble(arg_32_0)
	if arg_32_0:isPtType() then
		return not arg_32_0:IsGotAllAwards()
	else
		return false
	end

	return
end

return var_0
