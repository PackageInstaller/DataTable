local var_0_0 = class("TechnologyNationProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0.typeAttrTable = {}
	arg_1_0.typeOrder = {}
	arg_1_0.typeAttrOrderTable = {}
	arg_1_0.groupListInCount = {}
	arg_1_0.nationToPoint = {}
	arg_1_0.ifShowRedPoint = false
	arg_1_0.isAnyTecCampStudying = false
	arg_1_0.techList = {}

	arg_1_0:on(0, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.tech_list) do
			arg_1_0.techList[iter_2_1.group_id] = {
				completeID = iter_2_1.effect_tech_id,
				studyID = iter_2_1.study_tech_id,
				finishTime = iter_2_1.study_finish_time,
				rewardedID = iter_2_1.rewarded_tech
			}
		end

		arg_1_0:flushData()
		arg_1_0:setTimer()
		arg_1_0:initSetableAttrAddition(arg_2_0.techset_list)

		return
	end)

	if IsUnityEditor then
		local var_1_0 = {
			ShipType.FengFanM,
			ShipType.FengFanS,
			ShipType.FengFanV
		}

		for iter_1_0, iter_1_1 in ipairs(pg.fleet_tech_ship_class.all) do
			if pg.fleet_tech_ship_class[iter_1_1].nation == Nation.MOT then
				if not (function(arg_3_0)
					if #var_1_0 ~= #arg_3_0 then
						return false
					end

					local var_3_0 = {}

					for iter_3_0, iter_3_1 in ipairs(var_1_0) do
						local var_3_1 = var_3_0[iter_3_1] or 0

						var_3_0[iter_3_1] = var_3_1 + 1
					end

					for iter_3_2, iter_3_3 in ipairs(arg_3_0) do
						local var_3_2 = ({})[iter_3_3]

						if not ({})[iter_3_3] then
							var_3_2 = 0
						end

						;({})[iter_3_3] = var_3_2 + 1
					end

					for iter_3_4, iter_3_5 in pairs(var_3_0) do
						if ({})[iter_3_4] ~= iter_3_5 then
							return false
						end
					end

					return true
				end)(pg.fleet_tech_ship_template[iter_1_1].add_get_shiptype) then
					assert(false, "请检查fleet_tech_ship_class中的add_get_shiptype， ID：" .. iter_1_1)
				end

				if not (function(arg_3_0)
					if #var_1_0 ~= #arg_3_0 then
						return false
					end

					local var_3_0 = {}

					for iter_3_0, iter_3_1 in ipairs(var_1_0) do
						local var_3_1 = var_3_0[iter_3_1] or 0

						var_3_0[iter_3_1] = var_3_1 + 1
					end

					for iter_3_2, iter_3_3 in ipairs(arg_3_0) do
						local var_3_2 = ({})[iter_3_3]

						if not ({})[iter_3_3] then
							var_3_2 = 0
						end

						;({})[iter_3_3] = var_3_2 + 1
					end

					for iter_3_4, iter_3_5 in pairs(var_3_0) do
						if ({})[iter_3_4] ~= iter_3_5 then
							return false
						end
					end

					return true
				end)(pg.fleet_tech_ship_template[iter_1_1].add_level_shiptype) then
					assert(false, "请检查fleet_tech_ship_class中的add_level_shiptype， ID：" .. iter_1_1)
				end
			end
		end
	end

	return
end

function var_0_0.flushData(arg_4_0)
	arg_4_0:shipGroupFilter()
	arg_4_0:nationPointFilter()
	arg_4_0:calculateTecBuff()
	arg_4_0:refreshRedPoint()

	return
end

function var_0_0.updateTecItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if not arg_5_0.techList[arg_5_1] then
		arg_5_0.techList[arg_5_1] = {
			rewardedID = 0,
			completeID = 0,
			studyID = arg_5_3,
			finishTime = arg_5_4
		}

		return
	end

	arg_5_0.techList[arg_5_1] = {
		completeID = arg_5_2 or arg_5_0.techList[arg_5_1].completeID,
		studyID = arg_5_3,
		finishTime = arg_5_4,
		rewardedID = arg_5_5 or arg_5_0.techList[arg_5_1].rewardedID
	}

	return
end

function var_0_0.updateTecItemAward(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.techList[arg_6_1].rewardedID = arg_6_2

	return
end

function var_0_0.updateTecItemAwardOneStep(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.techList) do
		iter_7_1.rewardedID = iter_7_1.completeID
	end

	return
end

function var_0_0.shipGroupFilter(arg_8_0)
	arg_8_0.groupListInCount = {}

	for iter_8_0, iter_8_1 in pairs(getProxy(CollectionProxy).shipGroups) do
		if pg.fleet_tech_ship_template[iter_8_1.id] then
			table.insert(arg_8_0.groupListInCount, iter_8_1)
		end
	end

	return
end

function var_0_0.nationPointFilter(arg_9_0)
	if not LOCK_TEC_MOT then
		table.insert({
			Nation.US,
			Nation.EN,
			Nation.JP,
			Nation.DE,
			Nation.CN,
			Nation.ITA,
			Nation.SN,
			Nation.FF,
			Nation.MNF,
			Nation.FR,
			Nation.NL,
			Nation.LDP,
			Nation.META
		}, Nation.MOT)
	end

	arg_9_0.nationToPoint = {}
	arg_9_0.nationToPointLog = {}
	arg_9_0.nationToPointLog2 = {}

	for iter_9_0, iter_9_1 in ipairs({
		Nation.US,
		Nation.EN,
		Nation.JP,
		Nation.DE,
		Nation.CN,
		Nation.ITA,
		Nation.SN,
		Nation.FF,
		Nation.MNF,
		Nation.FR,
		Nation.NL,
		Nation.LDP,
		Nation.META
	}) do
		arg_9_0.nationToPoint[iter_9_1] = 0
		arg_9_0.nationToPointLog[iter_9_1] = {
			{},
			{},
			{}
		}
		arg_9_0.nationToPointLog2[iter_9_1] = {}
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.groupListInCount) do
		local var_9_0 = iter_9_3:getNation()

		if var_9_0 ~= tonumber(string.sub(tostring(iter_9_3.id), 1, 1)) then
			table.insert(arg_9_0.nationToPointLog2[var_9_0], iter_9_3)
		end

		local var_9_1 = pg.fleet_tech_ship_template[iter_9_3.id]
		local var_9_2 = 0 + pg.fleet_tech_ship_template[iter_9_3.id].pt_get

		table.insert(arg_9_0.nationToPointLog[var_9_0][1], iter_9_3.id)

		if iter_9_3.maxLV and iter_9_3.maxLV >= TechnologyConst.SHIP_LEVEL_FOR_BUFF then
			var_9_2 = var_9_2 + var_9_1.pt_level

			table.insert(arg_9_0.nationToPointLog[var_9_0][2], iter_9_3.id)
		end

		if iter_9_3.star >= var_9_1.max_star then
			var_9_2 = var_9_2 + var_9_1.pt_upgrage

			table.insert(arg_9_0.nationToPointLog[var_9_0][3], iter_9_3.id)
		end

		arg_9_0.nationToPoint[var_9_0] = arg_9_0.nationToPoint[var_9_0] + var_9_2
	end

	arg_9_0.point = 0

	for iter_9_4, iter_9_5 in pairs(arg_9_0.nationToPoint) do
		arg_9_0.point = arg_9_0.point + iter_9_5
	end

	return
end

function var_0_0.calculateTecBuff(arg_10_0)
	arg_10_0.typeBuffList = {}
	arg_10_0.typeOrder = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.groupListInCount) do
		for iter_10_2, iter_10_3 in ipairs(pg.fleet_tech_ship_template[iter_10_1.id].add_get_shiptype) do
			if not arg_10_0.typeBuffList[iter_10_3] then
				arg_10_0.typeBuffList[iter_10_3] = {
					{
						pg.fleet_tech_ship_template[iter_10_1.id].add_get_attr,
						pg.fleet_tech_ship_template[iter_10_1.id].add_get_value
					}
				}
				arg_10_0.typeOrder[#arg_10_0.typeOrder + 1] = iter_10_3
			else
				arg_10_0.typeBuffList[iter_10_3][#arg_10_0.typeBuffList[iter_10_3] + 1] = {
					pg.fleet_tech_ship_template[iter_10_1.id].add_get_attr,
					pg.fleet_tech_ship_template[iter_10_1.id].add_get_value
				}
			end
		end

		if iter_10_1.maxLV >= TechnologyConst.SHIP_LEVEL_FOR_BUFF then
			for iter_10_4, iter_10_5 in ipairs(pg.fleet_tech_ship_template[iter_10_1.id].add_level_shiptype) do
				if not arg_10_0.typeBuffList[iter_10_5] then
					arg_10_0.typeBuffList[iter_10_5] = {
						{
							pg.fleet_tech_ship_template[iter_10_1.id].add_level_attr,
							pg.fleet_tech_ship_template[iter_10_1.id].add_level_value
						}
					}
					arg_10_0.typeOrder[#arg_10_0.typeOrder + 1] = iter_10_5
				else
					arg_10_0.typeBuffList[iter_10_5][#arg_10_0.typeBuffList[iter_10_5] + 1] = {
						pg.fleet_tech_ship_template[iter_10_1.id].add_level_attr,
						pg.fleet_tech_ship_template[iter_10_1.id].add_level_value
					}
				end
			end
		end
	end

	for iter_10_6, iter_10_7 in pairs(arg_10_0.techList) do
		if iter_10_7.completeID ~= 0 then
			for iter_10_8, iter_10_9 in ipairs(pg.fleet_tech_template[iter_10_7.completeID].add) do
				for iter_10_10, iter_10_11 in ipairs(iter_10_9[1]) do
					if not arg_10_0.typeBuffList[iter_10_11] then
						arg_10_0.typeBuffList[iter_10_11] = {
							{
								iter_10_9[2],
								iter_10_9[3]
							}
						}
						arg_10_0.typeOrder[#arg_10_0.typeOrder + 1] = iter_10_11
					else
						arg_10_0.typeBuffList[iter_10_11][#arg_10_0.typeBuffList[iter_10_11] + 1] = {
							iter_10_9[2],
							iter_10_9[3]
						}
					end
				end
			end
		end
	end

	arg_10_0.typeAttrTable = {}
	arg_10_0.typeAttrOrderTable = {}

	for iter_10_12, iter_10_13 in pairs(arg_10_0.typeBuffList) do
		if not arg_10_0.typeAttrTable[iter_10_12] then
			arg_10_0.typeAttrTable[iter_10_12] = {}
			arg_10_0.typeAttrOrderTable[iter_10_12] = {}
		end

		for iter_10_14, iter_10_15 in ipairs(iter_10_13) do
			if not arg_10_0.typeAttrTable[iter_10_12][iter_10_15[1]] then
				arg_10_0.typeAttrTable[iter_10_12][iter_10_15[1]] = iter_10_15[2]
				arg_10_0.typeAttrOrderTable[iter_10_12][#arg_10_0.typeAttrOrderTable[iter_10_12] + 1] = iter_10_15[1]
			else
				arg_10_0.typeAttrTable[iter_10_12][iter_10_15[1]] = arg_10_0.typeAttrTable[iter_10_12][iter_10_15[1]] + iter_10_15[2]
			end
		end
	end

	table.sort(arg_10_0.typeOrder, function(arg_11_0, arg_11_1)
		return arg_11_0 < arg_11_1
	end)

	for iter_10_16, iter_10_17 in pairs(arg_10_0.typeAttrOrderTable) do
		table.sort(iter_10_17, function(arg_12_0, arg_12_1)
			return arg_12_0 < arg_12_1
		end)
	end

	return
end

function var_0_0.setTimer(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.techList) do
		if iter_13_1.studyID ~= 0 then
			local var_13_0 = pg.TimeMgr.GetInstance():GetServerTime()
			local var_13_1 = table.indexof(pg.fleet_tech_group[iter_13_0].techs, iter_13_1.completeID, 1) or 0
			local var_13_2 = pg.fleet_tech_group[iter_13_0].techs[var_13_1 + 1]

			if iter_13_1.finishTime < var_13_0 then
				arg_13_0:sendNotification(GAME.FINISH_CAMP_TEC, {
					tecID = iter_13_0,
					levelID = var_13_2
				})

				return
			else
				onDelayTick(function()
					arg_13_0:sendNotification(GAME.FINISH_CAMP_TEC, {
						tecID = iter_13_0,
						levelID = var_13_2
					})

					return
				end, iter_13_1.finishTime - var_13_0)

				return
			end
		end
	end

	return
end

function var_0_0.refreshRedPoint(arg_15_0)
	arg_15_0.ifShowRedPoint = false
	arg_15_0.isAnyTecCampStudying = false

	for iter_15_0, iter_15_1 in pairs(arg_15_0.techList) do
		if iter_15_1.studyID ~= 0 then
			local var_15_0 = pg.TimeMgr.GetInstance()

			if iter_15_1.finishTime < var_15_0:GetServerTime() then
				arg_15_0.ifShowRedPoint = true

				return
			else
				arg_15_0.isAnyTecCampStudying = true

				return
			end
		end
	end

	if arg_15_0:isNeedRedPointTecCampUpgrade() then
		local var_15_1 = getProxy(PlayerProxy):getData().gold

		for iter_15_2, iter_15_3 in ipairs(pg.fleet_tech_group.all) do
			if not arg_15_0.techList[iter_15_3] or arg_15_0.techList[iter_15_3].studyID == 0 then
				local var_15_2 = arg_15_0:getLevelByTecID(iter_15_3)

				if var_15_2 < #pg.fleet_tech_group[iter_15_3].techs then
					local var_15_3 = var_15_1 >= pg.fleet_tech_template[pg.fleet_tech_group[iter_15_3].techs[var_15_2 + 1]].cost

					if arg_15_0.nationToPoint[pg.fleet_tech_group[iter_15_3].nation[1]] >= pg.fleet_tech_template[pg.fleet_tech_group[iter_15_3].techs[var_15_2 + 1]].pt and var_15_3 then
						arg_15_0.ifShowRedPoint = true

						return
					end
				end
			end
		end
	end

	arg_15_0.ifShowRedPoint = arg_15_0:isAnyTecCampCanGetAward()

	return
end

function var_0_0.isAnyTecCampCanGetAward(arg_16_0)
	local var_16_0 = false

	if not LOCK_TEC_NATION_AWARD then
		for iter_16_0, iter_16_1 in pairs(arg_16_0.techList) do
			local var_16_1 = table.indexof(pg.fleet_tech_group[iter_16_0].techs, iter_16_1.rewardedID, 1) or 0
			local var_16_2 = table.indexof(pg.fleet_tech_group[iter_16_0].techs, iter_16_1.completeID, 1) or 0

			if var_16_1 < var_16_2 then
				var_16_0 = true

				break
			end
		end
	end

	return var_16_0
end

function var_0_0.getAnyTecCampStudying(arg_17_0)
	return arg_17_0.isAnyTecCampStudying
end

var_0_0.Ignore_TecCamp_Upgrade_Key = "Ignore_TecCamp_Upgrade_Key"

function var_0_0.setRedPointIgnoreTecCampUpgrade(arg_18_0)
	PlayerPrefs.SetInt(var_0_0.Ignore_TecCamp_Upgrade_Key, pg.TimeMgr.GetInstance():GetServerTime())

	return
end

function var_0_0.isNeedRedPointTecCampUpgrade(arg_19_0)
	local var_19_0 = PlayerPrefs.GetInt(var_0_0.Ignore_TecCamp_Upgrade_Key, 0)

	if var_19_0 ~= 0 then
		return not pg.TimeMgr.GetInstance():IsSameDay(var_19_0, (pg.TimeMgr.GetInstance():GetServerTime()))
	else
		return true
	end

	return
end

function var_0_0.GetTecList(arg_20_0)
	return arg_20_0.techList
end

function var_0_0.GetTecItemByGroupID(arg_21_0, arg_21_1)
	return arg_21_0.techList[arg_21_1]
end

function var_0_0.getLevelByTecID(arg_22_0, arg_22_1)
	return not arg_22_0.techList[arg_22_1] and 0 or table.indexof(pg.fleet_tech_group[arg_22_1].techs, arg_22_0.techList[arg_22_1].completeID, 1) or 0
end

function var_0_0.getGroupListInCount(arg_23_0)
	return arg_23_0.groupListInCount
end

function var_0_0.getShowRedPointTag(arg_24_0)
	return arg_24_0.ifShowRedPoint
end

function var_0_0.getStudyingTecItem(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.techList) do
		if iter_25_1.studyID ~= 0 then
			return iter_25_0
		end
	end

	return nil
end

function var_0_0.getPoint(arg_26_0)
	return arg_26_0.point
end

function var_0_0.getNationPointList(arg_27_0)
	return arg_27_0.nationToPoint
end

function var_0_0.getNationPoint(arg_28_0, arg_28_1)
	if arg_28_1 == 0 then
		local var_28_0 = 0

		for iter_28_0, iter_28_1 in pairs(arg_28_0.nationToPoint) do
			var_28_0 = var_28_0 + iter_28_1
		end

		return var_28_0
	else
		return arg_28_0.nationToPoint[arg_28_1]
	end

	return
end

function var_0_0.getLeftTime(arg_29_0)
	local var_29_0 = arg_29_0.techList[arg_29_0:getStudyingTecItem()]

	if var_29_0 then
		local var_29_1 = var_29_0.finishTime - pg.TimeMgr.GetInstance():GetServerTime()

		return var_29_1 > 0 and var_29_1 or 0
	else
		return 0
	end

	return
end

function var_0_0.getTecBuff(arg_30_0)
	if OPEN_TEC_TREE_SYSTEM then
		return arg_30_0.typeAttrTable, arg_30_0.typeOrder, arg_30_0.typeAttrOrderTable
	end

	return
end

function var_0_0.getShipAddition(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = table.indexof(TechnologyConst.TECH_NATION_ATTRS, arg_31_2)
	local var_31_1 = 0
	local var_31_2 = arg_31_0:getTecBuff() or {}
	local var_31_3 = var_31_2[arg_31_1]

	if var_31_2[arg_31_1] and var_31_0 and var_31_3[var_31_0] then
		var_31_1 = arg_31_0:getSetableAttrAdditionValueByTypeAttr(arg_31_1, var_31_0)
	end

	return var_31_1
end

function var_0_0.getShipMaxAddition(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = table.indexof(TechnologyConst.TECH_NATION_ATTRS, arg_32_2)
	local var_32_1 = 0
	local var_32_2 = arg_32_0:getTecBuff() or {}
	local var_32_3 = var_32_2[arg_32_1]

	if var_32_2[arg_32_1] and var_32_0 and var_32_3[var_32_0] then
		var_32_1 = var_32_3[var_32_0]
	end

	return var_32_1
end

function var_0_0.printNationPointLog(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.nationToPointLog) do
		print("----------------" .. iter_33_0 .. "----------------")

		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			local var_33_0 = iter_33_2 .. "    :"

			for iter_33_4, iter_33_5 in ipairs(iter_33_3) do
				var_33_0 = var_33_0 .. "  " .. iter_33_5
			end

			print(var_33_0)
		end
	end

	print("----------------Filte----------------")

	for iter_33_6, iter_33_7 in pairs(arg_33_0.nationToPointLog2) do
		local var_33_1 = iter_33_6 .. " :"

		for iter_33_8, iter_33_9 in ipairs(iter_33_7) do
			var_33_1 = var_33_1 .. tostring(iter_33_9.id) .. " " .. tostring((iter_33_9:getNation())) .. "||"
		end

		print(var_33_1)
	end

	return
end

function var_0_0.initSetableAttrAddition(arg_34_0, arg_34_1)
	arg_34_0.setValueTypeAttrTable = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		arg_34_0.setValueTypeAttrTable[iter_34_1.ship_type] = arg_34_0.setValueTypeAttrTable[iter_34_1.ship_type] or {}
		arg_34_0.setValueTypeAttrTable[iter_34_1.ship_type][iter_34_1.attr_type] = iter_34_1.set_value
	end

	return
end

function var_0_0.getSetableAttrAddition(arg_35_0)
	return arg_35_0.setValueTypeAttrTable
end

function var_0_0.getSetableAttrAdditionValueByTypeAttr(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0.setValueTypeAttrTable[arg_36_1] and arg_36_0.setValueTypeAttrTable[arg_36_1][arg_36_2] then
		return arg_36_0.setValueTypeAttrTable[arg_36_1][arg_36_2]
	else
		return arg_36_0.typeAttrTable[arg_36_1][arg_36_2]
	end

	return
end

return var_0_0
