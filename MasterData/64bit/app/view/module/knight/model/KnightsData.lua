local KnightsData = class("KnightsData", require("app.view.module.knight.model.KnightTable"))
local var_0_1 = g.core.config.knight_info
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = g.core.config.knight_level_info
local var_0_4 = g.core.config.knight_show_info
local var_0_5 = g.core.config.knight_advance_info
local var_0_6 = g.core.config.knight_advance_material_info
local var_0_7 = g.core.config.knight_association_info
local var_0_8 = g.core.config.material_exchange_info
local var_0_9 = g.core.config.role_quality_info
local var_0_10 = g.core.config.knight_backup_info
local var_0_11 = g.core.config.parameter_info
local var_0_12 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_13 = g.core.const.ConstMgr.CensorConst

KnightsData.COLUMN = 5

function KnightsData:ctor()
	self:initData()
end

function KnightsData:initData()
	self.super.ctor(self)

	self._knightNoAwakeMaxLv = var_0_11.get(var_0_12.KNIGHT_NOAWAKE_MAXLEVEL).parameter
	self._knightMaxLvList = {}

	for iter_2_0 = 1, var_0_3.getLength() do
		local var_2_0 = var_0_3.indexOf(iter_2_0)

		if not self._knightMaxLvList[var_2_0.id] or self._knightMaxLvList[var_2_0.id] < var_2_0.level then
			self._knightMaxLvList[var_2_0.id] = var_2_0.level
		end
	end

	self._isSweepAutoUsePowerItem = false
end

function KnightsData:getBagList(arg_3_1)
	arg_3_1 = arg_3_1 or 0

	return self:getSpList(function(arg_4_0)
		return (arg_4_0:isOwn() or arg_4_0:canCompose()) and arg_4_0:getBaseInfo().is_display == 1 and (arg_3_1 == 0 or arg_3_1 == arg_4_0:getGroup())
	end)
end

function KnightsData:getOwnerList()
	return self:getSpList(function(arg_6_0)
		return arg_6_0:isOwn() and not arg_6_0:isMain()
	end)
end

function KnightsData:getOwnerAllList(arg_7_1)
	return self:getSpList(function(arg_8_0)
		return arg_8_0:isOwn()
	end, nil, arg_7_1)
end

function KnightsData:getAllLineupAvailList(arg_9_1, arg_9_2, arg_9_3)
	arg_9_2 = arg_9_2 or 0

	return self:getLineupSpList(function(arg_10_0)
		return arg_10_0:isOwn() and (arg_9_2 == 0 or arg_9_2 == arg_10_0:getGroup())
	end, arg_9_1, arg_9_3)
end

function KnightsData:getLineupAvailList(arg_11_1, arg_11_2, arg_11_3)
	arg_11_2 = arg_11_2 or 0

	return self:getLineupSpList(function(arg_12_0)
		return arg_12_0:isOwn() and not arg_12_0:isLineup() and (not arg_12_0:isHelper() and not arg_12_0:isBackup() or arg_12_0:getBaseInfo().advance_id == arg_11_1) and (arg_11_2 == 0 or arg_11_2 == arg_12_0:getGroup())
	end, arg_11_1, arg_11_3)
end

function KnightsData:getLineupAvailListByParams(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_2.group or 0
	local var_13_1 = arg_13_2.profession or 0
	local var_13_2 = arg_13_2.damage or 0
	local var_13_3 = arg_13_2.element or 0

	return self:getLineupSpList(function(arg_14_0)
		local var_14_0 = arg_14_0:getBaseInfo().advance_id
		local var_14_3 = (var_13_0 == 0 or var_13_0 == arg_14_0:getGroup()) and (var_13_1 == 0 or var_13_1 == arg_14_0:getProfession()) and (var_13_2 == 0 or var_13_2 == arg_14_0:getDamage()) and (var_13_3 == 0 or var_13_3 == arg_14_0:getElement())
		local var_14_4 = arg_14_0:isPut() and arg_14_0:isDisplay() and arg_14_0:isOwn()
		local var_14_5 = arg_14_0:isLineup() or arg_14_0:isHelper() or arg_14_0:isBackup() or var_14_0 == arg_13_1

		if arg_13_4 then
			return var_14_3 and var_14_4
		else
			return var_14_3 and not var_14_5 and var_14_4
		end
	end, arg_13_1, arg_13_3)
end

function KnightsData:getOwnKnightList(arg_15_1, arg_15_2)
	return self:getSpList(function(arg_16_0)
		return arg_16_0:isOwn() and (arg_15_1 == 0 or arg_15_1 == arg_16_0:getGroup())
	end, nil, arg_15_2)
end

function KnightsData:getOwnKnightListWithOutMain(arg_17_1)
	return self:getSpList(function(arg_18_0)
		return arg_18_0:isOwn() and not arg_18_0:isMain() and (arg_17_1 == 0 or arg_17_1 == arg_18_0:getGroup())
	end)
end

function KnightsData:getKnightListByParams(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if arg_19_3 then
		assert(arg_19_2 == true, "如果可以合成则必须筛选可以拥有")
	end

	return self:getSpList(function(arg_20_0)
		local var_20_0 = arg_19_1.group or 0
		local var_20_1 = arg_19_1.profession or 0
		local var_20_2 = arg_19_1.damage or 0
		local var_20_3 = arg_19_1.element
		local var_20_4, var_20_5, var_20_6, var_20_7

		if not arg_19_1.element then
			var_20_3 = 0
			var_20_4 = var_20_1 == 0 or var_20_1 == arg_20_0:getProfession()
			var_20_5 = var_20_2 == 0 or var_20_2 == arg_20_0:getDamage()
			var_20_6 = var_20_3 == 0 or var_20_3 == arg_20_0:getElement()
			var_20_7 = arg_20_0:isPut() and arg_20_0:isDisplay()
		end

		local var_20_8 = (var_20_0 == 0 or var_20_0 == arg_20_0:getGroup()) and var_20_4 and var_20_5 and var_20_6 and var_20_7

		if arg_19_4 == false then
			var_20_8 = var_20_8 and not arg_20_0:isMain()
		end

		if arg_19_3 then
			return (arg_20_0:isOwn() == checkbool(arg_19_2) or arg_20_0:canCompose()) and var_20_8
		end

		return arg_20_0:isOwn() == checkbool(arg_19_2) and var_20_8 and not g.core.model.User.homeData:checkReverseCensorItem(var_0_13.CENSOR_TYPE.KNIGHT, (arg_20_0:getAdvanceId()))
	end)
end

function KnightsData:getLineUpList()
	return self:getSpList(function(arg_22_0)
		return arg_22_0:isOwn() and arg_22_0:isLineup()
	end)
end

function KnightsData:getKnightByPos(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs((self:getLineUpList())) do
		if arg_23_1 == iter_23_1:getFormationPos() then
			return iter_23_1
		end
	end

	return nil
end

function KnightsData:getNotLineUpList()
	return self:getSpList(function(arg_25_0)
		return arg_25_0:isOwn() and not arg_25_0:isLineup()
	end)
end

function KnightsData:getNotLineUpAndPartnerList()
	return self:getSpList(function(arg_27_0)
		return arg_27_0:isOwn() and not arg_27_0:isLineup() and not arg_27_0:isHelper()
	end)
end

function KnightsData:getIdleList()
	return self:getSpList(function(arg_29_0)
		return arg_29_0:isOwn() and not arg_29_0:isLineup() and not arg_29_0:isHelper() and not arg_29_0:isBackup()
	end)
end

function KnightsData:getBagTopList()
	return self:getSpList(function(arg_31_0)
		return arg_31_0:isOwn() and not arg_31_0:isLineup() and not arg_31_0:isHelper() or arg_31_0:canCompose()
	end)
end

function KnightsData:getNoneOwnList()
	return self:getSpList(function(arg_33_0)
		return not arg_33_0:isOwn() and not arg_33_0:isMain()
	end)
end

function KnightsData:getHasNotEnoughFragList(arg_34_1)
	arg_34_1 = arg_34_1 or 0

	return self:getSpList(function(arg_35_0)
		return arg_35_0:hasNotEnoughFrag() and (arg_34_1 == 0 or arg_34_1 == arg_35_0:getGroup())
	end, true)
end

function KnightsData:getCanOwnList(arg_36_1)
	return self:getSpList(function(arg_37_0)
		return not arg_37_0:isOwn() and not arg_37_0:canCompose() and not arg_37_0:isMain() and arg_37_0:isDisplay() and (arg_36_1 == 0 or arg_36_1 == arg_37_0:getGroup())
	end)
end

function KnightsData:getKnightByBaseId(arg_38_1)
	return self:getKnight({
		base_id = arg_38_1
	})
end

function KnightsData:getKnightBaseIdById(arg_39_1)
	if arg_39_1 == 0 then
		return 0
	end

	return self:getKnight({
		id = arg_39_1
	}):getBaseInfo().id
end

function KnightsData:getKnightFightIdBySid(arg_40_1)
	local var_40_0 = self:getKnightBaseIdById(arg_40_1)

	if var_40_0 == 0 then
		return
	end

	return var_0_2.get(var_0_1.get(var_40_0).res_id).fight_id
end

function KnightsData:getKnightById(arg_41_1)
	return self:getKnight({
		id = arg_41_1
	})
end

function KnightsData:getProfessionList(arg_42_1)
	arg_42_1 = arg_42_1 or 0

	return self:getProfessionSpList(arg_42_1)
end

function KnightsData:getKnightVoiceResInfo(arg_43_1)
	local var_43_0 = {}

	if arg_43_1.skinId and arg_43_1.skinId > 0 then
		var_43_0 = var_0_4.fetch(g.core.config.skin_info.get(arg_43_1.skinId).res)
	elseif arg_43_1.knightId and arg_43_1.knightId > 0 then
		var_43_0 = var_0_4.fetch(var_0_1.get(arg_43_1.knightId).res_id)
	end

	if not arg_43_1.ignoreGender and var_43_0 and var_43_0.toObject then
		var_43_0 = var_43_0.toObject()

		local var_43_1 = g.core.model.User:isBoy()

		for iter_43_0, iter_43_1 in pairs(var_43_0) do
			if var_43_0[iter_43_0 .. "_woman"] and var_43_0[iter_43_0 .. "_woman"] ~= "" and var_43_0[iter_43_0 .. "_woman"] ~= iter_43_1 and not var_43_1 then
				var_43_0[iter_43_0] = var_43_0[iter_43_0 .. "_woman"]
			end
		end
	end

	return var_43_0
end

function KnightsData:getKnightResInfo(arg_44_1)
	local var_44_0 = {}

	if arg_44_1.skinId and arg_44_1.skinId > 0 then
		var_44_0 = var_0_2.get(g.core.config.skin_info.get(arg_44_1.skinId).res)
	elseif arg_44_1.knightId and arg_44_1.knightId > 0 then
		var_44_0 = var_0_2.get(var_0_1.get(arg_44_1.knightId).res_id)
	end

	return var_44_0
end

function KnightsData:getKnightByFormationIndex(arg_45_1)
	local var_45_0 = self:getFormationKnights()

	if not var_45_0 or not next(var_45_0) then
		return
	end

	return (self:getKnight({
		id = var_45_0[arg_45_1]
	}))
end

function KnightsData:hasKnightByAdvanceId(arg_46_1)
	local var_46_0 = self:getKnight({
		advance_id = arg_46_1
	})

	return var_46_0 and var_46_0:isOwn() or false, var_46_0
end

function KnightsData:getRecommendMatchPercent(arg_47_1)
	local var_47_0 = 0

	for iter_47_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX do
		if g.core.config.lineup_recommend_info.hasKey("knight_id_" .. iter_47_0) then
			if arg_47_1["knight_id_" .. iter_47_0] > 0 and self:hasKnightByAdvanceId(arg_47_1["knight_id_" .. iter_47_0]) then
				var_47_0 = var_47_0 + 1
			elseif arg_47_1["replace_id_" .. iter_47_0] > 0 and self:hasKnightByAdvanceId(arg_47_1["replace_id_" .. iter_47_0]) then
				var_47_0 = var_47_0 + 0.6
			end
		end
	end

	return tonumber(string.format("%.2f", var_47_0 / g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX * 100))
end

function KnightsData:isLineUpByAdvId(arg_48_1)
	local var_48_0 = self:getKnight({
		advance_id = arg_48_1
	})

	if var_48_0 then
		return var_48_0:isOwn() and var_48_0:getInfo().position > 0
	else
		return false
	end
end

function KnightsData:isActiveAssct(arg_49_1)
	local var_49_0 = self:getKnight({
		advance_id = arg_49_1
	})

	if var_49_0 and var_49_0:isOwn() and var_49_0:getInfo().position > 0 then
		local var_49_1 = var_49_0:getInfo().position

		if var_49_1 > g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_PARTNER_MAX then
			return (g.core.model.User.formationData:isBackupUnlock(var_49_1 - g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_PARTNER_MAX))
		else
			return true
		end
	else
		return false
	end
end

function KnightsData:_checkTabCondition(arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = true

	if arg_50_2 ~= 0 then
		if arg_50_2 == 1 then
			var_50_0 = arg_50_3.quality == g.core.const.ConstMgr.QUALITY_TYPE.PURPLE
		elseif arg_50_2 == 2 then
			var_50_0 = arg_50_3.quality == g.core.const.ConstMgr.QUALITY_TYPE.ORANGE and arg_50_3.rare == 0
		elseif arg_50_2 == 3 then
			var_50_0 = arg_50_3.quality == g.core.const.ConstMgr.QUALITY_TYPE.ORANGE and arg_50_3.rare == 1
		end
	end

	return (arg_50_1 == 0 or arg_50_1 == arg_50_3.group) and var_50_0
end

function KnightsData:getKnightInfoByAdvanceId(arg_51_1)
	return self:getKnight({
		advance_id = arg_51_1
	}):getBaseInfo()
end

function KnightsData:getKnightByAdvanceId(arg_52_1)
	return (self:getKnight({
		advance_id = arg_52_1
	}))
end

function KnightsData:isPromote(arg_53_1, arg_53_2)
	if arg_53_1 <= 0 or arg_53_2 <= 0 then
		return
	end

	local var_53_0 = var_0_5.get(arg_53_1, arg_53_2).stage

	for iter_53_0 = 1, var_0_5.getLength() do
		local var_53_1 = var_0_5.indexOf(iter_53_0)

		if arg_53_1 == var_53_1.promote_code and var_53_1.promote_level - arg_53_2 == 1 then
			return var_53_0 < var_53_1.stage
		end
	end

	return false
end

function KnightsData:getTotalLevelByStage(arg_54_1, arg_54_2)
	local var_54_0 = 0

	for iter_54_0 = 1, var_0_5.getLength() do
		local var_54_1 = var_0_5.indexOf(iter_54_0)

		if arg_54_1 == var_54_1.promote_code and var_54_1.stage == arg_54_2 then
			var_54_0 = var_54_0 + 1
		end
	end

	return var_54_0
end

function KnightsData:getComposeAdvMaterial(arg_55_1, arg_55_2)
	local var_55_0 = {}

	local function var_55_3(arg_56_0, arg_56_1, arg_56_2)
		local var_56_0 = {}
		local var_56_1 = var_0_6.get(arg_56_0).compose_id

		if var_56_1 > 0 then
			local var_56_2 = var_0_8.get(var_56_1)

			table.insert(var_56_0, {
				isReel = false,
				type = var_56_2.main_part_type,
				value = var_56_2.main_part_value,
				size = var_56_2.main_part_size * arg_56_1,
				singleNum = var_56_2.main_part_size * arg_56_1 / arg_55_2,
				ownCount = g.core.model.User.bagData:getCountById(var_56_2.main_part_type, var_56_2.main_part_value)
			})

			arg_56_2 = var_56_2.fitting_part_size * arg_56_1 + arg_56_2

			table.insert(var_56_0, {
				isReel = true,
				type = var_56_2.fitting_part_type,
				value = var_56_2.fitting_part_value,
				size = var_56_2.fitting_part_size * arg_56_1 + arg_56_2,
				singleNum = (var_56_2.fitting_part_size * arg_56_1 + arg_56_2) / arg_55_2,
				ownCount = g.core.model.User.bagData:getCountById(var_56_2.fitting_part_type, var_56_2.fitting_part_value)
			})

			local var_56_3 = {
				data = var_56_0
			}
			local var_56_5 = 0
			local var_56_7 = 0

			for iter_56_0 = 1, #var_56_0 do
				local var_56_8 = math.floor(var_56_0[iter_56_0].ownCount / var_56_0[iter_56_0].singleNum)

				if iter_56_0 == 1 then
					var_56_7 = var_56_8
				end

				var_56_7 = math.min(var_56_7, var_56_8)

				if var_56_0[iter_56_0].singleNum > var_56_0[iter_56_0].ownCount then
					break
				end

				var_56_5 = var_56_5 + 1
			end

			if var_56_5 == #var_56_0 then
				var_56_3.canCompose = true
			end

			var_56_3.num = var_56_7
			var_56_3.composeId = var_56_1

			table.insert(var_55_0, var_56_3)
			var_55_3(var_56_0[1].value, var_56_0[1].size, arg_56_2)
		end
	end

	;(nil)(arg_55_1, arg_55_2, 0)

	local var_55_4 = false
	local var_55_5 = false
	local var_55_6 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_KNIGHT_ADVANCE, arg_55_1)
	local var_55_7 = 0

	for iter_55_0 = 1, #var_55_0 do
		if var_55_0[iter_55_0].canCompose then
			var_55_5 = true
		end

		var_55_7 = var_55_7 + var_55_0[iter_55_0].num + var_55_6

		if var_55_0[iter_55_0].canCompose and arg_55_2 <= var_55_7 then
			var_55_4 = true

			break
		end
	end

	return var_55_0, (not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ADV_COMPOSE) or nil) and false, var_55_5
end

function KnightsData:getComposeSortData(arg_57_1)
	local var_57_0 = clone(arg_57_1)

	table.sort(var_57_0, function(arg_58_0, arg_58_1)
		local var_58_0 = arg_58_0.composeId
		local var_58_1 = arg_58_1.composeId
		local var_58_2 = self:isCanBlitzAdvMat(arg_58_0.data[1].value)

		if var_58_2 ~= self:isCanBlitzAdvMat(arg_58_1.data[1].value) then
			return var_58_2
		end

		if var_58_0 ~= var_58_1 then
			return var_58_1 < var_58_0
		end
	end)

	return var_57_0
end

function KnightsData:getComposeMaxNum(arg_59_1)
	local var_59_0 = 0
	local var_59_1 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_KNIGHT_ADVANCE, var_0_6.indexOf((var_0_6.getLength())).id)

	for iter_59_0 = 1, #arg_59_1 do
		if arg_59_1[iter_59_0].canCompose then
			for iter_59_1 = 1, #arg_59_1[iter_59_0].data do
				if arg_59_1[iter_59_0].data[iter_59_1].isReel then
					if var_59_1 - arg_59_1[iter_59_0].num * arg_59_1[iter_59_0].data[iter_59_1].singleNum >= 0 then
						var_59_1 = var_59_1 - arg_59_1[iter_59_0].num * arg_59_1[iter_59_0].data[iter_59_1].singleNum
						var_59_0 = var_59_0 + arg_59_1[iter_59_0].num
					else
						var_59_0 = var_59_0 + arg_59_1[iter_59_0].num - math.ceil(-(var_59_1 - arg_59_1[iter_59_0].num * arg_59_1[iter_59_0].data[iter_59_1].singleNum) / arg_59_1[iter_59_0].data[iter_59_1].singleNum)

						return var_59_0
					end
				end
			end
		end
	end

	return var_59_0
end

function KnightsData:getAdvFormulaData(arg_60_1, arg_60_2)
	local var_60_0 = {}
	local var_60_1 = {}
	local var_60_3 = 0
	local var_60_5 = arg_60_2

	for iter_60_0 = 1, #arg_60_1 do
		if arg_60_1[iter_60_0].canCompose then
			local var_60_6 = arg_60_1[iter_60_0].data
			local var_60_7 = math.min(arg_60_2, arg_60_1[iter_60_0].num)

			var_60_5 = math.max(0, arg_60_2 - var_60_7)

			local var_60_8 = false

			for iter_60_1 = 1, #arg_60_1[iter_60_0].data do
				if var_60_6[iter_60_1].isReel then
					local var_60_9 = 0

					if not next(var_60_1) then
						var_60_1 = var_60_6[iter_60_1]
						var_60_9 = var_60_7 * var_60_6[iter_60_1].singleNum
					else
						var_60_9 = var_60_1.num + var_60_6[iter_60_1].singleNum * var_60_7
					end

					var_60_8 = var_60_9 <= var_60_6[iter_60_1].ownCount

					if var_60_8 then
						var_60_1.num = var_60_9
					end
				end
			end

			if var_60_8 then
				for iter_60_2 = 1, #var_60_6 do
					if not var_60_6[iter_60_2].isReel then
						var_60_6[iter_60_2].num = var_60_7 * var_60_6[iter_60_2].singleNum

						table.insert(var_60_0, var_60_6[iter_60_2])
					end
				end
			end

			var_60_3 = var_60_3 + var_60_7

			if arg_60_2 <= var_60_3 then
				table.insert(var_60_0, var_60_1)

				break
			end
		end
	end

	return var_60_0
end

function KnightsData:getFormulaAcquireState(arg_61_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ADV_COMPOSE) then
		return false
	end

	for iter_61_0 = 1, #arg_61_1 do
		local var_61_0 = g.view.entrance.ModuleGotoProxy:getSrcRoute({
			type = g.core.common.Goods.TYPE_KNIGHT_ADVANCE,
			value = arg_61_1[iter_61_0].data[1].value
		}).routes or {}

		for iter_61_1 = 1, #var_61_0 do
			if var_61_0[iter_61_1].isOpened then
				return true
			end
		end
	end

	return false
end

function KnightsData:getAdvTalentList(arg_62_1, arg_62_2)
	local var_62_0 = {}

	for iter_62_0 = 1, var_0_5.getLength() do
		local var_62_1 = var_0_5.indexOf(iter_62_0)

		if var_62_1.promote_code == arg_62_1 and not var_62_0[var_62_1.stage] and var_62_1.stage > 0 and arg_62_2["promote_talent_" .. var_62_1.stage] > 0 then
			var_62_0[var_62_1.stage] = {
				stage = var_62_1.stage,
				talentId = arg_62_2["promote_talent_" .. var_62_1.stage]
			}
		end
	end

	return var_62_0
end

function KnightsData:getMatTreeChildNode(arg_63_1)
	local var_63_0 = {}
	local var_63_1 = var_0_6.get(arg_63_1).compose_id

	if var_63_1 > 0 then
		local var_63_2 = var_0_8.get(var_63_1)

		for iter_63_0 = 1, g.core.const.MATERIAL_CONST.MAXNUM do
			if var_63_2["part_" .. iter_63_0 .. "_value"] > 0 and var_63_2["part_" .. iter_63_0 .. "_type"] == g.core.common.Goods.TYPE_KNIGHT_ADVANCE then
				table.insert(var_63_0, {
					id = var_63_2["part_" .. iter_63_0 .. "_value"],
					count = var_63_2["part_" .. iter_63_0 .. "_size"]
				})
			end
		end
	end

	return var_63_0
end

function KnightsData:isLackChildMat(arg_64_1)
	local var_64_0 = self:getMatTreeChildNode(arg_64_1)

	for iter_64_0 = 1, #var_64_0 do
		if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_KNIGHT_ADVANCE, var_64_0[iter_64_0].id) < var_64_0[iter_64_0].count then
			return true, var_0_6.get(var_64_0[iter_64_0].id).name
		end
	end

	return false
end

function KnightsData:isEnoughCostCompose(arg_65_1)
	local var_65_0 = var_0_6.get(arg_65_1).compose_id

	if var_65_0 > 0 then
		local var_65_1 = var_0_8.get(var_65_0)

		return g.core.model.User.bagData:getCountById(var_65_1.cost_type, var_65_1.cost_value) >= var_65_1.cost_size
	end

	return true
end

function KnightsData:getKnightAdvLevelBySid(arg_66_1)
	return math.max(self:getKnight({
		id = arg_66_1
	}):getInfo().advance_level, 1)
end

function KnightsData:getKnightAdvMatIdBySid(arg_67_1)
	return self:getKnight({
		id = arg_67_1
	}):getInfo().advance_equip_id or {}
end

function KnightsData:getCanEquipMatPosList(arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = {}
	local var_68_1 = 0
	local var_68_2 = self:getKnightAdvMatIdBySid(arg_68_3)

	if arg_68_1 <= 0 or arg_68_2 <= 0 then
		return
	end

	local var_68_3 = var_0_5.get(arg_68_1, arg_68_2)

	for iter_68_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.ADV_MAT_MAX do
		local var_68_4 = g.core.model.User.bagData:isOwnItem(g.core.common.Goods.TYPE_KNIGHT_ADVANCE, var_68_3["place_" .. iter_68_0]) and g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_KNIGHT_ADVANCE, var_68_3["place_" .. iter_68_0]) >= var_68_3["num_" .. iter_68_0]
		local var_68_5 = var_68_2[iter_68_0] > 0

		if var_68_4 and not var_68_5 then
			table.insert(var_68_0, iter_68_0)
		end

		if var_68_1 == 0 and not var_68_4 and not var_68_5 then
			var_68_1 = iter_68_0
		end
	end

	return var_68_0, var_68_1
end

function KnightsData:isCanBlitzAdvMat(arg_69_1)
	local var_69_0 = g.view.entrance.ModuleGotoProxy:getSrcRoute({
		type = g.core.common.Goods.TYPE_KNIGHT_ADVANCE,
		value = arg_69_1
	}).routes

	for iter_69_0 = 1, #var_69_0 do
		local var_69_1 = g.core.config.source_route_info.get(var_69_0[iter_69_0].route.route_id).route_value_1

		if var_69_1 > 0 and g.core.model.User.dungeonData:isStagePassed(var_69_1) then
			return true
		end
	end

	return false
end

function KnightsData:isCanChallengeAdvMat(arg_70_1)
	local var_70_0 = g.view.entrance.ModuleGotoProxy:getSrcRoute({
		type = g.core.common.Goods.TYPE_KNIGHT_ADVANCE,
		value = arg_70_1
	}).routes

	for iter_70_0 = 1, #var_70_0 do
		local var_70_1 = g.core.config.source_route_info.get(var_70_0[iter_70_0].route.route_id).route_value_1

		if var_70_1 > 0 then
			if not g.core.model.User.dungeonData:isStagePassed(var_70_1) and g.core.model.User.dungeonData:isStageUnlocked(var_70_1) then
				return true
			end
		end
	end

	return false
end

function KnightsData:getEquipMatAttr(arg_71_1, arg_71_2, arg_71_3)
	local var_71_0 = {}

	if arg_71_1 <= 0 or arg_71_2 <= 0 then
		return
	end

	local var_71_1 = var_0_5.get(arg_71_1, arg_71_2)

	for iter_71_0, iter_71_1 in ipairs(arg_71_3) do
		for iter_71_2 = 1, g.core.const.ConstMgr.KNIGHT_CONST.MAT_ATTR_NUM do
			if var_71_1["place_" .. iter_71_1 .. "_affect_type_" .. iter_71_2] > 0 then
				var_71_0[var_71_1["place_" .. iter_71_1 .. "_affect_type_" .. iter_71_2]] = var_71_0[var_71_1["place_" .. iter_71_1 .. "_affect_type_" .. iter_71_2]] and var_71_0[var_71_1["place_" .. iter_71_1 .. "_affect_type_" .. iter_71_2]] + var_71_1["place_" .. iter_71_1 .. "_affect_value_" .. iter_71_2] or var_71_1["place_" .. iter_71_1 .. "_affect_value_" .. iter_71_2]
			end
		end
	end

	return var_71_0
end

function KnightsData:getAdvStageAndLevelById(arg_72_1)
	local var_72_0, var_72_1 = self:getKnightByBaseId(arg_72_1):getAdvStageAndLevel()

	return var_72_0, var_72_1
end

function KnightsData:getLineupKnightList()
	return self:getSpList(function(arg_74_0)
		return arg_74_0:isOwn() and arg_74_0:isLineup() and not arg_74_0:isHelper()
	end)
end

function KnightsData:getMainRoleKnight()
	return self:getSpList(function(arg_76_0)
		return arg_76_0:isMain() and arg_76_0:isOwn()
	end)
end

function KnightsData:getMaxStarLevel(arg_77_1)
	local var_77_0 = 0

	for iter_77_0 = 1, var_0_1.getLength() do
		local var_77_1 = var_0_1.indexOf(iter_77_0)

		if var_77_1.advance_id == arg_77_1 and var_77_1.next_star_id == 0 then
			var_77_0 = var_77_1.star
		end
	end

	return var_77_0
end

function KnightsData:getMainKnightSex()
	return self:getMainKnight():getBaseInfo().sex
end

function KnightsData:getMainKnightQualityId()
	local var_79_0 = self:getMainKnight():getBaseInfo()

	for iter_79_0 = 1, var_0_9.getLength() do
		local var_79_1 = var_0_9.indexOf(iter_79_0)

		if var_79_1.quality == var_79_0.quality and var_79_1.rare == var_79_0.rare then
			return var_79_1.id
		end
	end

	return 0
end

function KnightsData:getMainKnightQuality()
	return self:getMainKnight():getBaseInfo().quality
end

function KnightsData:getMainKnightIcon()
	return (g.core.common.Path:getKnightIconById(g.core.model.User.knightsData:getMainKnight():getResInfo().icon_id))
end

function KnightsData:getNextQualityKnightInfo(arg_82_1, arg_82_2, arg_82_3)
	for iter_82_0 = 1, var_0_1.getLength() do
		local var_82_0 = var_0_1.indexOf(iter_82_0)

		if var_82_0.advance_id == arg_82_1 and var_82_0.star == arg_82_2 and var_82_0.quality == arg_82_3 and var_82_0.type == 1 then
			return var_82_0
		end
	end
end

function KnightsData:getAttrByQuality(arg_83_1)
	local var_83_0 = self:getMainKnight():getBaseInfo()
	local var_83_1 = self:getMainKnight():getLevel()
	local var_83_2 = {}

	if arg_83_1.next_id > 0 then
		var_83_2 = self:getNextQualityKnightInfo(var_83_0.advance_id, var_83_0.star, var_0_9.get(arg_83_1.next_id).quality)
	end

	local var_83_3 = {}

	if arg_83_1.next_id > 0 then
		var_83_3[1] = var_83_2.base_hp + var_83_2.develop_hp * (var_83_1 - 1)
		var_83_3[2] = var_83_2.base_attack + var_83_2.develop_attack * (var_83_1 - 1)
		var_83_3[3] = var_83_2.base_physical_defence + var_83_2.develop_physical_defence * (var_83_1 - 1)
		var_83_3[4] = var_83_2.base_magical_defence + var_83_2.develop_magical_defence * (var_83_1 - 1)
	end

	return {
		var_83_0.base_hp + var_83_0.develop_hp * (var_83_1 - 1),
		var_83_0.base_attack + var_83_0.develop_attack * (var_83_1 - 1),
		var_83_0.base_physical_defence + var_83_0.develop_physical_defence * (var_83_1 - 1),
		var_83_0.base_magical_defence + var_83_0.develop_magical_defence * (var_83_1 - 1)
	}, var_83_3, var_83_2
end

function KnightsData:getCurAttrByQuality(arg_84_1)
	local var_84_0 = self:getMainKnight():getBaseInfo()
	local var_84_1 = self:getMainKnight():getLevel()
	local var_84_2 = {}

	if arg_84_1.quality - 1 > 0 then
		var_84_2 = self:getNextQualityKnightInfo(var_84_0.advance_id, var_84_0.star, arg_84_1.quality - 1)
	end

	local var_84_3 = {}

	if arg_84_1.quality - 1 > 0 then
		var_84_3[1] = var_84_2.base_hp + var_84_2.develop_hp * (var_84_1 - 1)
		var_84_3[2] = var_84_2.base_attack + var_84_2.develop_attack * (var_84_1 - 1)
		var_84_3[3] = var_84_2.base_physical_defence + var_84_2.develop_physical_defence * (var_84_1 - 1)
		var_84_3[4] = var_84_2.base_magical_defence + var_84_2.develop_magical_defence * (var_84_1 - 1)
	end

	return {
		var_84_0.base_hp + var_84_0.develop_hp * (var_84_1 - 1),
		var_84_0.base_attack + var_84_0.develop_attack * (var_84_1 - 1),
		var_84_0.base_physical_defence + var_84_0.develop_physical_defence * (var_84_1 - 1),
		var_84_0.base_magical_defence + var_84_0.develop_magical_defence * (var_84_1 - 1)
	}, var_84_3, var_84_2
end

function KnightsData:getLineupChooseList(arg_85_1, arg_85_2)
	return arg_85_2 and self:getLineupAvailList(arg_85_1) or self:getAllLineupAvailList(arg_85_1)
end

function KnightsData:getAllInfoByAdvId(arg_86_1)
	local var_86_0 = {}

	for iter_86_0 = 1, var_0_1.getLength() do
		local var_86_1 = var_0_1.indexOf(iter_86_0)

		if var_86_1.type ~= 3 and var_86_1.advance_id == arg_86_1 then
			table.insert(var_86_0, var_86_1)
		end
	end

	table.sort(var_86_0, function(arg_87_0, arg_87_1)
		if arg_87_0.star ~= arg_87_1.star then
			return arg_87_0.star < arg_87_1.star
		end
	end)

	return var_86_0
end

function KnightsData:getIdleKnightMaxPotential()
	local var_88_0 = 0
	local var_88_1 = self:getIdleList()

	for iter_88_0 = 1, #var_88_1 do
		local var_88_2 = var_88_1[iter_88_0]:getBaseInfo()

		if var_88_0 < var_88_2.potential then
			var_88_0 = var_88_2.potential
		end
	end

	return var_88_0
end

function KnightsData:getIdleKnightMaxQuality(arg_89_1)
	local var_89_0 = 0
	local var_89_1 = {}
	local var_89_2 = self:getIdleList()

	for iter_89_0 = 1, #var_89_2 do
		local var_89_3 = var_89_2[iter_89_0]:getBaseInfo()

		if arg_89_1 < var_89_3.quality then
			var_89_0 = var_89_3.quality
			var_89_1[var_89_3.group] = var_89_3
		end
	end

	return var_89_0, var_89_1
end

function KnightsData:getCanLevelupCount(arg_90_1)
	local var_90_0 = arg_90_1.score
	local var_90_2 = 0

	if arg_90_1.score <= 0 then
		return 0
	end

	local var_90_3 = g.core.config.knight_info.get(arg_90_1.knight.base_id)
	local var_90_4 = 0

	for iter_90_0 = 1, g.core.config.knight_level_info.getLength() do
		local var_90_5 = g.core.config.knight_level_info.indexOf(iter_90_0)

		if var_90_5.id == var_90_3.level_exp_id and var_90_5.next_exp > 0 then
			if var_90_5.level == arg_90_1.knight.level and arg_90_1.knight.exp + var_90_0 >= var_90_5.next_exp and arg_90_1.maxLevel > var_90_5.level then
				var_90_4 = 1
				var_90_0 = var_90_0 - (var_90_5.next_exp - arg_90_1.knight.exp)
				var_90_2 = g.core.config.knight_level_info.get(var_90_3.level_exp_id, var_90_5.level + 1).next_exp
			end

			if arg_90_1.knight.level < var_90_5.level and arg_90_1.maxLevel > var_90_5.level and var_90_0 >= var_90_5.next_exp then
				var_90_4 = var_90_4 + 1
				var_90_0 = var_90_0 - var_90_5.next_exp
				var_90_2 = g.core.config.knight_level_info.get(var_90_3.level_exp_id, var_90_5.level + 1).next_exp
			end
		end
	end

	return var_90_4, var_90_0, var_90_2
end

function KnightsData:getBagShowList(arg_91_1)
	local var_91_0 = {}
	local var_91_1 = self:getBagList(arg_91_1)
	local var_91_2 = self:getHasNotEnoughFragList(arg_91_1)
	local var_91_3 = math.ceil(#var_91_1 / 5)

	for iter_91_0 = 1, var_91_3 do
		local var_91_4 = {}

		for iter_91_1 = 1, 5 do
			if var_91_1[(iter_91_0 - 1) * 5 + iter_91_1] then
				table.insert(var_91_4, var_91_1[(iter_91_0 - 1) * 5 + iter_91_1])
			end
		end

		table.insert(var_91_0, var_91_4)
	end

	for iter_91_2 = 1, math.ceil(#var_91_2 / 5) do
		local var_91_5 = {}

		for iter_91_3 = 1, 5 do
			if var_91_2[(iter_91_2 - 1) * 5 + iter_91_3] then
				table.insert(var_91_5, var_91_2[(iter_91_2 - 1) * 5 + iter_91_3])
			end
		end

		table.insert(var_91_0, var_91_5)
	end

	return var_91_0, var_91_3
end

function KnightsData:getMainKnightSkillData()
	local var_92_0 = g.core.model.User:getDressId()
	local var_92_1 = self:getMainKnight():getBaseInfo()
	local var_92_2 = {}

	if var_92_0 == 0 then
		var_92_2[1] = {
			id = var_92_1.common_id
		}
		var_92_2[2] = {
			id = var_92_1.active_skill_id,
			level = var_92_1.star
		}
	else
		local var_92_3 = g.core.config.dress_info.get(var_92_0)
		local var_92_4 = var_92_1.sex == 0 and "female_" or "male_"

		var_92_2[1] = {
			id = var_92_3[(var_92_1.sex == 0 and "female_" or "male_") .. "common_id"]
		}

		local var_92_5 = g.core.model.User.dressData:getDressLevelById(var_92_0)
		local var_92_6 = {}

		for iter_92_0 = 1, 4 do
			table.insert(var_92_6, var_92_3["enhance_level_" .. iter_92_0])
		end

		table.sort(var_92_6, function(arg_93_0, arg_93_1)
			return arg_93_0 < arg_93_1
		end)

		for iter_92_1, iter_92_2 in pairs(var_92_6) do
			if iter_92_2 <= var_92_5 then
				var_92_2[2] = {
					id = var_92_3[var_92_4 .. "active_skill_id_" .. iter_92_1],
					level = iter_92_1 - 1
				}
			else
				break
			end
		end
	end

	return var_92_2
end

function KnightsData:getKnightBackupAttr(arg_94_1)
	local var_94_0
	local var_94_1 = {}

	for iter_94_0 = 1, var_0_10.getLength() do
		local var_94_2 = var_0_10.indexOf(iter_94_0)

		if var_94_2.quality == arg_94_1.quality and var_94_2.star == arg_94_1.star then
			var_94_0 = var_94_2

			break
		end
	end

	if var_94_0 then
		for iter_94_1 = 1, 4 do
			local var_94_3, var_94_4 = g.core.lang:getAttr(var_94_0["basic_type_" .. iter_94_1], var_94_0["basic_value_" .. iter_94_1] + var_94_0["basic_growth_" .. iter_94_1] * arg_94_1.level)

			if var_94_0["basic_type_" .. iter_94_1] > 0 then
				table.insert(var_94_1, {
					name = var_94_3,
					value = var_94_4,
					type = var_94_0["basic_type_" .. iter_94_1],
					valueInt = var_94_0["basic_value_" .. iter_94_1] + var_94_0["basic_growth_" .. iter_94_1] * arg_94_1.level
				})
			end
		end
	end

	return var_94_1
end

function KnightsData:getBackupIndexList()
	local var_95_0 = {}

	for iter_95_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.BACKUP_TOTAL do
		if g.core.model.User.formationData:isBackupShow(iter_95_0) then
			table.insert(var_95_0, iter_95_0)
		end
	end

	return var_95_0
end

function KnightsData:getBackupTotalAttr()
	local var_96_0 = {}
	local var_96_1 = {}
	local var_96_2 = g.core.model.User.knightsData:getFormationKnights()

	for iter_96_0 = g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_PARTNER_MAX + 1, g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_BACKUP_MAX do
		if var_96_2[iter_96_0] > 0 then
			local var_96_3 = g.core.model.User.knightsData:getKnight({
				id = var_96_2[iter_96_0]
			})
			local var_96_4 = var_96_3:getBaseInfo()
			local var_96_5 = self:getKnightBackupAttr({
				quality = var_96_4.quality,
				star = var_96_4.star,
				level = var_96_3:getInfo().level
			})

			for iter_96_1 = 1, #var_96_5 do
				var_96_0[var_96_5[iter_96_1].type] = not var_96_0[var_96_5[iter_96_1].type] and var_96_5[iter_96_1].valueInt or var_96_0[var_96_5[iter_96_1].type] + var_96_5[iter_96_1].valueInt
			end
		end
	end

	for iter_96_2, iter_96_3 in pairs(var_96_0) do
		local var_96_6, var_96_7 = g.core.lang:getAttr(iter_96_2, iter_96_3)

		table.insert(var_96_1, {
			name = var_96_6,
			value = var_96_7,
			type = iter_96_2
		})
	end

	table.sort(var_96_1, function(arg_97_0, arg_97_1)
		if arg_97_0.type == 2 ~= (arg_97_1.type == 2) then
			return arg_97_0.type == 2
		end

		if arg_97_0.type ~= arg_97_1.type then
			return arg_97_0.type < arg_97_1.type
		end
	end)

	return var_96_1
end

function KnightsData:getInfoListByAdvId(arg_98_1, arg_98_2)
	local var_98_0 = {}
	local var_98_1 = self:getKnight({
		advance_id = arg_98_1
	}):getQuality()

	for iter_98_0 = 1, var_0_1.getLength() do
		local var_98_2 = var_0_1.indexOf(iter_98_0)

		if (arg_98_2 or var_98_2.put == 1) and var_98_2.advance_id == arg_98_1 and var_98_2.quality == var_98_1 and var_98_2.type ~= 3 and var_98_2.put == 1 then
			var_98_0[var_98_2.star] = var_98_2
		end
	end

	return var_98_0
end

function KnightsData:getKnightGroupMapByQuality(arg_99_1)
	local var_99_0

	if not arg_99_1 then
		arg_99_1 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DEFAULT
		var_99_0 = {}
	end

	for iter_99_0, iter_99_1 in ipairs((self:getLineupKnightList())) do
		local var_99_1 = iter_99_1:getGroup()

		if arg_99_1 <= iter_99_1:getQuality() then
			var_99_0[var_99_1] = var_99_0[var_99_1] or 0
			var_99_0[var_99_1] = var_99_0[var_99_1] + 1
		end
	end

	return var_99_0
end

function KnightsData:getTrainAttr(arg_100_1)
	local var_100_0 = ""
	local var_100_1 = 0

	for iter_100_0 = 1, 4 do
		if arg_100_1["affect_type_" .. iter_100_0] > 0 then
			local var_100_2, var_100_3 = g.core.lang:getAttr(arg_100_1["affect_type_" .. iter_100_0], arg_100_1["affect_value_" .. iter_100_0])

			var_100_1 = var_100_3
			var_100_0 = var_100_0 == "" and var_100_2 or var_100_0 .. "、" .. var_100_2
		end
	end

	return var_100_0, var_100_1
end

function KnightsData:isShowDevBubble()
	local var_101_0 = g.core.model.User:getLevel()

	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.DEVELOP_BUBBLE_OPEN).parameter <= var_101_0 and var_101_0 <= g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.DEVELOP_BUBBLE_CLOSE).parameter
end

function KnightsData:isShowBlitzBubble()
	local var_102_0 = g.core.model.User:getLevel()

	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.BLITZ_BUBBLE_OPEN).parameter <= var_102_0 and var_102_0 <= g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.BLITZ_BUBBLE_CLOSE).parameter
end

function KnightsData:getKnightByQualityAcquire(arg_103_1)
	local var_103_0 = self:getSpList(function(arg_104_0)
		return arg_104_0:isOwn() and arg_104_0:isLineup() and not arg_104_0:isMain()
	end)

	for iter_103_0 = 1, #var_103_0 do
		if var_103_0[iter_103_0]:getQuality() == arg_103_1 then
			return var_103_0[iter_103_0]
		end
	end

	local var_103_1 = self:getSpList(function(arg_105_0)
		return arg_105_0:isOwn() and arg_105_0:isBackup() and not arg_105_0:isMain()
	end)

	for iter_103_1 = 1, #var_103_1 do
		if var_103_1[iter_103_1]:getQuality() == arg_103_1 then
			return var_103_1[iter_103_1]
		end
	end

	local var_103_2 = self:getOwnerList()

	for iter_103_2 = 1, #var_103_2 do
		if var_103_2[iter_103_2]:getQuality() == arg_103_1 then
			return var_103_2[iter_103_2]
		end
	end

	return var_103_2[1]
end

function KnightsData:getAllFullStarKnights(arg_106_1)
	local var_106_0 = self:getOwnerAllList()
	local var_106_1 = {}

	for iter_106_0 = 1, #var_106_0 do
		local var_106_2 = var_106_0[iter_106_0]:getBaseInfo().advance_id

		if var_106_0[iter_106_0]:getBaseInfo().next_star_id == 0 and (arg_106_1 or nil) and arg_106_1 <= var_106_0[iter_106_0]:getQuality() then
			table.insert(var_106_1, var_106_0[iter_106_0]:getBaseInfo())
		end
	end

	return var_106_1
end

function KnightsData:getFullKnightFragmentList()
	local var_107_0 = g.core.model.User.fragmentsData:getKnightFragmentListByType(g.core.common.Goods.TYPE_KNIGHT)
	local var_107_1 = {}

	for iter_107_0, iter_107_1 in ipairs((self:getAllFullStarKnights())) do
		for iter_107_2, iter_107_3 in ipairs(var_107_0) do
			if iter_107_3.id == iter_107_1.fragment_id then
				table.insert(var_107_1, iter_107_3)
			end
		end
	end

	return var_107_1
end

function KnightsData:checkOpenSell()
	return (g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_FRAG_SELL))
end

function KnightsData:isShowSellTips()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_FRAG_SELL) then
		local var_109_0 = 0

		for iter_109_0, iter_109_1 in ipairs(self:getFullKnightFragmentList()) do
			var_109_0 = var_109_0 + iter_109_1.num
		end

		return var_109_0 >= g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.KNIGHT_FRAGMENTS_SELL).parameter
	end

	return false
end

function KnightsData:isHasOtherKnightAwakeExcept(arg_110_1)
	for iter_110_0, iter_110_1 in ipairs((self:getOwnKnightList())) do
		if iter_110_1:isAwaking() and not math.uint64_equal(iter_110_1:getServerId(), arg_110_1) then
			return true, iter_110_1
		end
	end

	return false
end

function KnightsData:getKnightListPendantActived()
	return self:getSpList(function(arg_112_0)
		return arg_112_0:isOwn() and arg_112_0:isPendantActive()
	end)
end

function KnightsData:getKnightCannotAwakeMaxLevel()
	return self._knightNoAwakeMaxLv
end

function KnightsData:getKnightMaxLvByLevelExpId(arg_114_1)
	return self._knightMaxLvList[arg_114_1] or self._knightNoAwakeMaxLv
end

function KnightsData:userCanAwake()
	local var_115_0 = self:getMainKnight()
	local var_115_1 = g.core.common.Storage:load("user_awake.json", true) or {}

	return var_115_0:isCanAwake() and not ((var_115_1 or nil) and (var_115_1.isClicked or false))
end

function KnightsData:setUserClicked()
	local var_116_0 = g.core.model.User:getId()

	g.core.common.Storage:save("user_awake.json", {
		isClicked = true
	}, true)
end

function KnightsData:setPendantClicked(arg_117_1)
	local var_117_0 = g.core.common.Storage:load("user_pendant.json", true) or {}

	var_117_0["user_" .. arg_117_1:getServerId()] = true

	g.core.common.Storage:save("user_pendant.json", var_117_0)
end

function KnightsData:getPendantClicked(arg_118_1)
	return (g.core.common.Storage:load("user_pendant.json", true) or {})["user_" .. arg_118_1:getServerId()]
end

function KnightsData:setAutoUsePowerItem(arg_119_1)
	self._isSweepAutoUsePowerItem = arg_119_1
end

function KnightsData:getAutoUsePowerItem()
	return self._isSweepAutoUsePowerItem
end

function KnightsData:isNewKnight(arg_121_1)
	local var_121_0 = self:getKnightByAdvanceId(arg_121_1.advId)

	if var_121_0 then
		return var_121_0:getIsNewKnight()
	else
		return false
	end
end

function KnightsData:canKnightLevelUpFive(arg_122_1)
	if arg_122_1.advId and arg_122_1.advId > 0 then
		local var_122_0 = self:getKnightByAdvanceId(arg_122_1.advId)

		if var_122_0 then
			return var_122_0:canLevelUpFive()
		end
	end

	return false
end

function KnightsData:isHasMrKnightSoulUp(arg_123_1)
	if arg_123_1.advId and arg_123_1.advId > 0 then
		return self:getKnightByAdvanceId(arg_123_1.advId):canSoulUpLevel()
	end

	return false
end

function KnightsData:isHasMrKnightSupportActive(arg_124_1)
	if arg_124_1.advId and arg_124_1.advId > 0 then
		local var_124_0 = self:getKnightByAdvanceId(arg_124_1.advId)

		if not var_124_0:isOwn() then
			return false
		end

		for iter_124_0, iter_124_1 in ipairs((var_124_0:getSpSupportKnights())) do
			if self:getKnightByAdvanceId(iter_124_1[1].knightAdvId):isOwn() and not var_124_0:isSpSupportActive(iter_124_1[1].knightAdvId) then
				return true
			end
		end
	end

	return false
end

function KnightsData:isHasMrKnightSupportSkillUp(arg_125_1)
	if arg_125_1.advId and arg_125_1.advId > 0 then
		local var_125_0 = self:getKnightByAdvanceId(arg_125_1.advId)

		if not var_125_0:isOwn() then
			return false
		end

		return var_125_0:isCanUpgradeSpSupport()
	end

	return false
end

function KnightsData:hasKnightCanLevelUpFive()
	for iter_126_0, iter_126_1 in pairs((self:getLineUpList())) do
		if iter_126_1:canLevelUpFive() then
			return true
		end
	end

	return false
end

function KnightsData:hasKnightCanAdvance()
	for iter_127_0, iter_127_1 in pairs((self:getLineUpList())) do
		if iter_127_1:canAdvance() then
			return true
		end
	end

	return false
end

function KnightsData:canKnightAdvance(arg_128_1)
	if arg_128_1.advId and arg_128_1.advId > 0 then
		local var_128_0 = self:getKnightByAdvanceId(arg_128_1.advId)

		if var_128_0 then
			return var_128_0:canAdvance()
		end
	end

	return false
end

function KnightsData:hasKnightCanStarUp()
	for iter_129_0, iter_129_1 in pairs((self:getLineUpList())) do
		if iter_129_1:canStarUp() then
			return true
		end
	end

	return false
end

function KnightsData:canKnightStarUp(arg_130_1)
	if arg_130_1.advId then
		if arg_130_1.advId > 0 then
			local var_130_0 = self:getKnightByAdvanceId(arg_130_1.advId)

			if var_130_0 then
				return var_130_0:canStarUp()
			end
		else
			return false
		end
	end

	return false
end

function KnightsData:hasKnightCanStarUpInOwner()
	for iter_131_0, iter_131_1 in pairs((self:getOwnerList())) do
		if iter_131_1:canStarUp() then
			return true
		end
	end

	return false
end

function KnightsData:hasCanComposeKnight()
	return #self:getSpList(function(arg_133_0)
		return arg_133_0:canCompose()
	end) > 0
end

function KnightsData:getCanSellKnightFragDataList()
	local var_134_0 = {}

	for iter_134_0, iter_134_1 in ipairs((self:getFullKnightFragmentList())) do
		local var_134_1 = g.core.config.fragment_info.get(iter_134_1.id)

		table.insert(var_134_0, {
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = iter_134_1.id,
			size = iter_134_1.num,
			quality = var_134_1.quality,
			priceType = var_134_1.price_type,
			priceValue = var_134_1.price_value,
			priceSize = var_134_1.price_size
		})
	end

	table.sort(var_134_0, function(arg_135_0, arg_135_1)
		if arg_135_0.quality ~= arg_135_1.quality then
			return arg_135_0.quality < arg_135_1.quality
		end

		return arg_135_0.value < arg_135_1.value
	end)

	return var_134_0
end

function KnightsData:getLineUpAndHelperKnightList()
	local var_136_0 = {}
	local var_136_1 = self:getSpList(function(arg_137_0)
		return arg_137_0:isOwn() and (arg_137_0:isLineup() or arg_137_0:isHelper())
	end)

	for iter_136_0 = 1, #var_136_1 do
		var_136_0[var_136_1[iter_136_0]:getAdvanceId()] = true
	end

	return var_136_0
end

function KnightsData:isLastAssistKnight(arg_138_1, arg_138_2)
	local var_138_0 = self:getLineUpAndHelperKnightList()
	local var_138_1 = true

	for iter_138_0 = 1, #arg_138_1 do
		if arg_138_1[iter_138_0] ~= arg_138_2 and not var_138_0[arg_138_1[iter_138_0]] then
			var_138_1 = false

			break
		end
	end

	return var_138_1
end

function KnightsData:getAssListAndActiveCountByKnight(arg_139_1)
	local var_139_0 = {}

	if arg_139_1 then
		local var_139_1 = arg_139_1:getBaseInfo()

		for iter_139_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.ASSCT_MAX do
			if var_139_1["association_" .. iter_139_0] > 0 then
				if arg_139_1:getInfo() then
					local var_139_4 = var_0_7.get(var_139_1["association_" .. iter_139_0])
					local var_139_5 = {}

					for iter_139_1 = 1, g.core.const.ConstMgr.KNIGHT_CONST.ASS_COND_MAX do
						if var_139_4["value_" .. iter_139_1] > 0 then
							table.insert(var_139_5, var_139_4["value_" .. iter_139_1])
						end
					end

					for iter_139_2 = 1, g.core.const.ConstMgr.KNIGHT_CONST.ASS_COND_MAX do
						if var_139_4["value_" .. iter_139_2] > 0 and self:isLastAssistKnight(var_139_5, var_139_4["value_" .. iter_139_2]) and var_139_4.type == g.core.const.ConstMgr.KNIGHT_CONST.ASS_TYPE.KNIGHT and not self:isActiveAssct(var_139_4["value_" .. iter_139_2]) then
							table.insert(var_139_0, {
								knightId = var_139_4["value_" .. iter_139_2]
							})
						end
					end
				end
			end
		end
	end

	return var_139_0, 0
end

function KnightsData:getAssistList()
	return (self:getSpList(function(arg_141_0)
		return arg_141_0:isOwn() and arg_141_0:isHelper()
	end))
end

function KnightsData:getCanLineUpPartner()
	local var_142_0 = 0

	for iter_142_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.SHOW_PARTNER_NUM do
		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["KNIGHT_PARTNER_" .. iter_142_0]) then
			var_142_0 = var_142_0 + 1
		end
	end

	return var_142_0
end

function KnightsData:hasAssistRedPoint(arg_143_1)
	local var_143_0 = arg_143_1.pos or 0

	if var_143_0 == 666 then
		return false
	end

	if g.core.model.User.knightsData:getLineupKnightCount() ~= g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX then
		return false
	end

	local var_143_1 = self:getAssistList()

	if self:getCanLineUpPartner() <= #var_143_1 then
		return false
	end

	for iter_143_0 = 1, #var_143_1 do
		if var_143_1[iter_143_0]:getFormationPos() == var_143_0 + g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX then
			return false
		end
	end

	if var_143_0 ~= 999 and var_143_0 ~= 0 and not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["KNIGHT_PARTNER_" .. var_143_0]) then
		return false
	end

	local var_143_2 = self:getIdleList()
	local var_143_3 = {}
	local var_143_4 = self:getLineUpList()

	for iter_143_1 = 1, #var_143_4 do
		local var_143_5 = self:getAssListAndActiveCountByKnight(var_143_4[iter_143_1])

		for iter_143_2 = 1, #var_143_5 do
			var_143_3[var_143_5[iter_143_2].knightId] = true
		end
	end

	for iter_143_3, iter_143_4 in pairs(var_143_3) do
		for iter_143_5 = 1, #var_143_2 do
			if var_143_2[iter_143_5]:getAdvanceId() == iter_143_3 then
				return true
			end
		end
	end

	return false
end

function KnightsData:getAllPutKnight()
	return self:getSpList(function(arg_145_0)
		return not arg_145_0:isMain() and arg_145_0:isPut()
	end)
end

function KnightsData:getAssistantTalent(arg_146_1)
	local var_146_0 = {}
	local var_146_1 = g.core.config.talent_skill_info
	local var_146_2 = arg_146_1:getAdvanceId()

	while var_146_2 and var_146_2 ~= 0 do
		local var_146_3 = var_0_1.get(var_146_2)

		if var_146_3.star_talent_extra and var_146_3.star_talent_extra ~= 0 then
			table.insert(var_146_0, {
				star = var_146_3.star,
				talentSkillCfg = var_146_1.get(var_146_3.star_talent_extra),
				isActive = arg_146_1:getStarLv() >= var_146_3.star
			})
		end

		var_146_2 = var_146_3.next_star_id
	end

	return var_146_0
end

function KnightsData:getMaxAssistantTalent(arg_147_1)
	local var_147_0 = self:getAssistantTalent(arg_147_1)

	return var_147_0[#var_147_0]
end

function KnightsData:getCurStarActiveTalent(arg_148_1)
	local var_148_0 = arg_148_1:getBaseInfo()

	if var_148_0.star_talent_extra and var_148_0.star_talent_extra ~= 0 then
		return {
			star = var_148_0.star,
			talentSkillCfg = g.core.config.talent_skill_info.get(var_148_0.star_talent_extra)
		}
	end

	return nil
end

return KnightsData
