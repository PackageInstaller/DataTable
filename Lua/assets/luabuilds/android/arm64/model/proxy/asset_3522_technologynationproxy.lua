local TechnologyNationProxy = class("TechnologyNationProxy", import(".NetProxy"))

function TechnologyNationProxy:register()
	self.typeAttrTable = {}
	self.typeOrder = {}
	self.typeAttrOrderTable = {}
	self.groupListInCount = {}
	self.nationToPoint = {}
	self.ifShowRedPoint = false
	self.isAnyTecCampStudying = false
	self.techList = {}

	self:on(0, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.tech_list) do
			self.techList[iter_2_1.group_id] = {
				completeID = iter_2_1.effect_tech_id,
				studyID = iter_2_1.study_tech_id,
				finishTime = iter_2_1.study_finish_time,
				rewardedID = iter_2_1.rewarded_tech
			}
		end

		self:flushData()
		self:setTimer()
		self:initSetableAttrAddition(arg_2_0.techset_list)

		return
	end)

	if IsUnityEditor then
		local var_1_0 = {
			ShipType.FengFanM,
			ShipType.FengFanS,
			ShipType.FengFanV
		}

		local function var_1_1(arg_3_0)
			if #var_1_0 ~= #arg_3_0 then
				return false
			end

			local var_3_0 = {}
			local var_3_1 = {}

			for iter_3_0, iter_3_1 in ipairs(var_1_0) do
				var_3_0[iter_3_1] = (var_3_0[iter_3_1] or 0) + 1
			end

			for iter_3_2, iter_3_3 in ipairs(arg_3_0) do
				var_3_1[iter_3_3] = (var_3_1[iter_3_3] or 0) + 1
			end

			for iter_3_4, iter_3_5 in pairs(var_3_0) do
				if var_3_1[iter_3_4] ~= iter_3_5 then
					return false
				end
			end

			return true
		end

		for iter_1_0, iter_1_1 in ipairs(pg.fleet_tech_ship_class.all) do
			if pg.fleet_tech_ship_class[iter_1_1].nation == Nation.MOT then
				if not var_1_1(pg.fleet_tech_ship_template[iter_1_1].add_get_shiptype) then
					assert(false, "请检查fleet_tech_ship_class中的add_get_shiptype， ID：" .. iter_1_1)
				end

				if not var_1_1(pg.fleet_tech_ship_template[iter_1_1].add_level_shiptype) then
					assert(false, "请检查fleet_tech_ship_class中的add_level_shiptype， ID：" .. iter_1_1)
				end
			end
		end
	end

	return
end

function TechnologyNationProxy:flushData()
	self:shipGroupFilter()
	self:nationPointFilter()
	self:calculateTecBuff()
	self:refreshRedPoint()

	return
end

function TechnologyNationProxy:updateTecItem(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if not self.techList[arg_5_1] then
		self.techList[arg_5_1] = {
			rewardedID = 0,
			completeID = 0,
			studyID = arg_5_3,
			finishTime = arg_5_4
		}

		return
	end

	self.techList[arg_5_1] = {
		completeID = arg_5_2 or self.techList[arg_5_1].completeID,
		studyID = arg_5_3,
		finishTime = arg_5_4,
		rewardedID = arg_5_5 or self.techList[arg_5_1].rewardedID
	}

	return
end

function TechnologyNationProxy:updateTecItemAward(arg_6_1, arg_6_2)
	self.techList[arg_6_1].rewardedID = arg_6_2

	return
end

function TechnologyNationProxy:updateTecItemAwardOneStep()
	for iter_7_0, iter_7_1 in pairs(self.techList) do
		iter_7_1.rewardedID = iter_7_1.completeID
	end

	return
end

function TechnologyNationProxy:shipGroupFilter()
	self.groupListInCount = {}

	for iter_8_0, iter_8_1 in pairs(getProxy(CollectionProxy).shipGroups) do
		if pg.fleet_tech_ship_template[iter_8_1.id] then
			table.insert(self.groupListInCount, iter_8_1)
		end
	end

	return
end

function TechnologyNationProxy:nationPointFilter()
	local var_9_0 = {
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
	}

	if not LOCK_TEC_MOT then
		table.insert(var_9_0, Nation.MOT)
	end

	self.nationToPoint = {}
	self.nationToPointLog = {}
	self.nationToPointLog2 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		self.nationToPoint[iter_9_1] = 0
		self.nationToPointLog[iter_9_1] = {
			{},
			{},
			{}
		}
		self.nationToPointLog2[iter_9_1] = {}
	end

	for iter_9_2, iter_9_3 in ipairs(self.groupListInCount) do
		local var_9_1 = iter_9_3:getNation()

		if var_9_1 ~= tonumber(string.sub(tostring(iter_9_3.id), 1, 1)) then
			table.insert(self.nationToPointLog2[var_9_1], iter_9_3)
		end

		local var_9_2 = pg.fleet_tech_ship_template[iter_9_3.id]
		local var_9_3 = 0 + pg.fleet_tech_ship_template[iter_9_3.id].pt_get

		table.insert(self.nationToPointLog[var_9_1][1], iter_9_3.id)

		if iter_9_3.maxLV and iter_9_3.maxLV >= TechnologyConst.SHIP_LEVEL_FOR_BUFF then
			var_9_3 = var_9_3 + var_9_2.pt_level

			table.insert(self.nationToPointLog[var_9_1][2], iter_9_3.id)
		end

		if iter_9_3.star >= var_9_2.max_star then
			var_9_3 = var_9_3 + var_9_2.pt_upgrage

			table.insert(self.nationToPointLog[var_9_1][3], iter_9_3.id)
		end

		self.nationToPoint[var_9_1] = self.nationToPoint[var_9_1] + var_9_3
	end

	self.point = 0

	for iter_9_4, iter_9_5 in pairs(self.nationToPoint) do
		self.point = self.point + iter_9_5
	end

	return
end

function TechnologyNationProxy:calculateTecBuff()
	self.typeBuffList = {}
	self.typeOrder = {}

	for iter_10_0, iter_10_1 in ipairs(self.groupListInCount) do
		for iter_10_2, iter_10_3 in ipairs(pg.fleet_tech_ship_template[iter_10_1.id].add_get_shiptype) do
			if not self.typeBuffList[iter_10_3] then
				self.typeBuffList[iter_10_3] = {
					{
						pg.fleet_tech_ship_template[iter_10_1.id].add_get_attr,
						pg.fleet_tech_ship_template[iter_10_1.id].add_get_value
					}
				}
				self.typeOrder[#self.typeOrder + 1] = iter_10_3
			else
				self.typeBuffList[iter_10_3][#self.typeBuffList[iter_10_3] + 1] = {
					pg.fleet_tech_ship_template[iter_10_1.id].add_get_attr,
					pg.fleet_tech_ship_template[iter_10_1.id].add_get_value
				}
			end
		end

		if iter_10_1.maxLV >= TechnologyConst.SHIP_LEVEL_FOR_BUFF then
			for iter_10_4, iter_10_5 in ipairs(pg.fleet_tech_ship_template[iter_10_1.id].add_level_shiptype) do
				if not self.typeBuffList[iter_10_5] then
					self.typeBuffList[iter_10_5] = {
						{
							pg.fleet_tech_ship_template[iter_10_1.id].add_level_attr,
							pg.fleet_tech_ship_template[iter_10_1.id].add_level_value
						}
					}
					self.typeOrder[#self.typeOrder + 1] = iter_10_5
				else
					self.typeBuffList[iter_10_5][#self.typeBuffList[iter_10_5] + 1] = {
						pg.fleet_tech_ship_template[iter_10_1.id].add_level_attr,
						pg.fleet_tech_ship_template[iter_10_1.id].add_level_value
					}
				end
			end
		end
	end

	for iter_10_6, iter_10_7 in pairs(self.techList) do
		if iter_10_7.completeID ~= 0 then
			for iter_10_8, iter_10_9 in ipairs(pg.fleet_tech_template[iter_10_7.completeID].add) do
				for iter_10_10, iter_10_11 in ipairs(iter_10_9[1]) do
					if not self.typeBuffList[iter_10_11] then
						self.typeBuffList[iter_10_11] = {
							{
								iter_10_9[2],
								iter_10_9[3]
							}
						}
						self.typeOrder[#self.typeOrder + 1] = iter_10_11
					else
						self.typeBuffList[iter_10_11][#self.typeBuffList[iter_10_11] + 1] = {
							iter_10_9[2],
							iter_10_9[3]
						}
					end
				end
			end
		end
	end

	self.typeAttrTable = {}
	self.typeAttrOrderTable = {}

	for iter_10_12, iter_10_13 in pairs(self.typeBuffList) do
		if not self.typeAttrTable[iter_10_12] then
			self.typeAttrTable[iter_10_12] = {}
			self.typeAttrOrderTable[iter_10_12] = {}
		end

		for iter_10_14, iter_10_15 in ipairs(iter_10_13) do
			if not self.typeAttrTable[iter_10_12][iter_10_15[1]] then
				self.typeAttrTable[iter_10_12][iter_10_15[1]] = iter_10_15[2]
				self.typeAttrOrderTable[iter_10_12][#self.typeAttrOrderTable[iter_10_12] + 1] = iter_10_15[1]
			else
				self.typeAttrTable[iter_10_12][iter_10_15[1]] = self.typeAttrTable[iter_10_12][iter_10_15[1]] + iter_10_15[2]
			end
		end
	end

	table.sort(self.typeOrder, function(arg_11_0, arg_11_1)
		return arg_11_0 < arg_11_1
	end)

	for iter_10_16, iter_10_17 in pairs(self.typeAttrOrderTable) do
		table.sort(iter_10_17, function(arg_12_0, arg_12_1)
			return arg_12_0 < arg_12_1
		end)
	end

	return
end

function TechnologyNationProxy:setTimer()
	for iter_13_0, iter_13_1 in pairs(self.techList) do
		if iter_13_1.studyID ~= 0 then
			local var_13_0 = pg.TimeMgr.GetInstance():GetServerTime()
			local var_13_1 = pg.fleet_tech_group[iter_13_0].techs[(table.indexof(pg.fleet_tech_group[iter_13_0].techs, iter_13_1.completeID, 1) or 0) + 1]

			if iter_13_1.finishTime < var_13_0 then
				self:sendNotification(GAME.FINISH_CAMP_TEC, {
					tecID = iter_13_0,
					levelID = var_13_1
				})

				return
			else
				onDelayTick(function()
					self:sendNotification(GAME.FINISH_CAMP_TEC, {
						tecID = iter_13_0,
						levelID = var_13_1
					})

					return
				end, iter_13_1.finishTime - var_13_0)

				return
			end
		end
	end

	return
end

function TechnologyNationProxy:refreshRedPoint()
	self.ifShowRedPoint = false
	self.isAnyTecCampStudying = false

	for iter_15_0, iter_15_1 in pairs(self.techList) do
		if iter_15_1.studyID ~= 0 then
			if iter_15_1.finishTime < pg.TimeMgr.GetInstance():GetServerTime() then
				self.ifShowRedPoint = true

				return
			else
				self.isAnyTecCampStudying = true

				return
			end
		end
	end

	if self:isNeedRedPointTecCampUpgrade() then
		local var_15_0 = getProxy(PlayerProxy):getData().gold

		for iter_15_2, iter_15_3 in ipairs(pg.fleet_tech_group.all) do
			if not self.techList[iter_15_3] or self.techList[iter_15_3].studyID == 0 then
				local var_15_1 = self:getLevelByTecID(iter_15_3)

				if var_15_1 < #pg.fleet_tech_group[iter_15_3].techs then
					if self.nationToPoint[pg.fleet_tech_group[iter_15_3].nation[1]] >= pg.fleet_tech_template[pg.fleet_tech_group[iter_15_3].techs[var_15_1 + 1]].pt and var_15_0 >= pg.fleet_tech_template[pg.fleet_tech_group[iter_15_3].techs[var_15_1 + 1]].cost then
						self.ifShowRedPoint = true

						return
					end
				end
			end
		end
	end

	self.ifShowRedPoint = self:isAnyTecCampCanGetAward()

	return
end

function TechnologyNationProxy:isAnyTecCampCanGetAward()
	local var_16_0 = false

	if not LOCK_TEC_NATION_AWARD then
		for iter_16_0, iter_16_1 in pairs(self.techList) do
			if (table.indexof(pg.fleet_tech_group[iter_16_0].techs, iter_16_1.rewardedID, 1) or 0) < (table.indexof(pg.fleet_tech_group[iter_16_0].techs, iter_16_1.completeID, 1) or 0) then
				var_16_0 = true

				break
			end
		end
	end

	return var_16_0
end

function TechnologyNationProxy:getAnyTecCampStudying()
	return self.isAnyTecCampStudying
end

TechnologyNationProxy.Ignore_TecCamp_Upgrade_Key = "Ignore_TecCamp_Upgrade_Key"

function TechnologyNationProxy:setRedPointIgnoreTecCampUpgrade()
	PlayerPrefs.SetInt(TechnologyNationProxy.Ignore_TecCamp_Upgrade_Key, pg.TimeMgr.GetInstance():GetServerTime())

	return
end

function TechnologyNationProxy:isNeedRedPointTecCampUpgrade()
	local var_19_0 = PlayerPrefs.GetInt(TechnologyNationProxy.Ignore_TecCamp_Upgrade_Key, 0)

	if var_19_0 ~= 0 then
		return not pg.TimeMgr.GetInstance():IsSameDay(var_19_0, (pg.TimeMgr.GetInstance():GetServerTime()))
	else
		return true
	end

	return
end

function TechnologyNationProxy:GetTecList()
	return self.techList
end

function TechnologyNationProxy:GetTecItemByGroupID(arg_21_1)
	return self.techList[arg_21_1]
end

function TechnologyNationProxy:getLevelByTecID(arg_22_1)
	return not self.techList[arg_22_1] and 0 or table.indexof(pg.fleet_tech_group[arg_22_1].techs, self.techList[arg_22_1].completeID, 1) or 0
end

function TechnologyNationProxy:getGroupListInCount()
	return self.groupListInCount
end

function TechnologyNationProxy:getShowRedPointTag()
	return self.ifShowRedPoint
end

function TechnologyNationProxy:getStudyingTecItem()
	for iter_25_0, iter_25_1 in pairs(self.techList) do
		if iter_25_1.studyID ~= 0 then
			return iter_25_0
		end
	end

	return nil
end

function TechnologyNationProxy:getPoint()
	return self.point
end

function TechnologyNationProxy:getNationPointList()
	return self.nationToPoint
end

function TechnologyNationProxy:getNationPoint(arg_28_1)
	if arg_28_1 == 0 then
		local var_28_0 = 0

		for iter_28_0, iter_28_1 in pairs(self.nationToPoint) do
			var_28_0 = var_28_0 + iter_28_1
		end

		return var_28_0
	else
		return self.nationToPoint[arg_28_1]
	end

	return
end

function TechnologyNationProxy:getLeftTime()
	local var_29_0 = self.techList[self:getStudyingTecItem()]

	if var_29_0 then
		local var_29_1 = var_29_0.finishTime - pg.TimeMgr.GetInstance():GetServerTime()

		return var_29_1 > 0 and var_29_1 or 0
	else
		return 0
	end

	return
end

function TechnologyNationProxy:getTecBuff()
	if OPEN_TEC_TREE_SYSTEM then
		return self.typeAttrTable, self.typeOrder, self.typeAttrOrderTable
	end

	return
end

function TechnologyNationProxy:getShipAddition(arg_31_1, arg_31_2)
	local var_31_0 = table.indexof(TechnologyConst.TECH_NATION_ATTRS, arg_31_2)

	return ((self:getTecBuff() or {})[arg_31_1] and var_31_0 and (self:getTecBuff() or {})[arg_31_1][var_31_0] or nil) and self:getSetableAttrAdditionValueByTypeAttr(arg_31_1, var_31_0)
end

function TechnologyNationProxy:getShipMaxAddition(arg_32_1, arg_32_2)
	local var_32_0 = table.indexof(TechnologyConst.TECH_NATION_ATTRS, arg_32_2)
	local var_32_2 = (self:getTecBuff() or {})[arg_32_1]

	return ((self:getTecBuff() or {})[arg_32_1] and var_32_0 and var_32_2[var_32_0] or nil) and var_32_2[var_32_0]
end

function TechnologyNationProxy:printNationPointLog()
	for iter_33_0, iter_33_1 in pairs(self.nationToPointLog) do
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

	for iter_33_6, iter_33_7 in pairs(self.nationToPointLog2) do
		local var_33_1 = iter_33_6 .. " :"

		for iter_33_8, iter_33_9 in ipairs(iter_33_7) do
			var_33_1 = var_33_1 .. tostring(iter_33_9.id) .. " " .. tostring((iter_33_9:getNation())) .. "||"
		end

		print(var_33_1)
	end

	return
end

function TechnologyNationProxy:initSetableAttrAddition(arg_34_1)
	self.setValueTypeAttrTable = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		self.setValueTypeAttrTable[iter_34_1.ship_type] = self.setValueTypeAttrTable[iter_34_1.ship_type] or {}
		self.setValueTypeAttrTable[iter_34_1.ship_type][iter_34_1.attr_type] = iter_34_1.set_value
	end

	return
end

function TechnologyNationProxy:getSetableAttrAddition()
	return self.setValueTypeAttrTable
end

function TechnologyNationProxy:getSetableAttrAdditionValueByTypeAttr(arg_36_1, arg_36_2)
	if self.setValueTypeAttrTable[arg_36_1] and self.setValueTypeAttrTable[arg_36_1][arg_36_2] then
		return self.setValueTypeAttrTable[arg_36_1][arg_36_2]
	else
		return self.typeAttrTable[arg_36_1][arg_36_2]
	end

	return
end

return TechnologyNationProxy
