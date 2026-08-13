class = var_0_10000

local var_0_0 = "TechnologyNationProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.typeAttrTable = {}
	arg_1_0.typeOrder = {}
	arg_1_0.typeAttrOrderTable = {}
	arg_1_0.groupListInCount = {}
	arg_1_0.nationToPoint = {}
	arg_1_0.ifShowRedPoint = false
	arg_1_0.isAnyTecCampStudying = false
	arg_1_0.techList = {}

	local var_1_0 = arg_1_0

	arg_1_0.on(var_1_0, 0, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.tech_list) do
			arg_1_0.techList[iter_2_1.group_id] = {
				completeID = iter_2_1.effect_tech_id,
				studyID = iter_2_1.study_tech_id,
				finishTime = iter_2_1.study_finish_time,
				rewardedID = iter_2_1.rewarded_tech
			}
		end

		local var_2_0 = arg_1_0

		var_1.flushData(var_2_0)

		local var_2_1 = arg_1_0

		var_1.setTimer(var_2_1)

		local var_2_2 = arg_1_0

		var_1.initSetableAttrAddition(var_2_2, arg_2_0.techset_list)

		return
	end)

	IsUnityEditor = var_1

	if var_1 then
		local var_1_1 = {}

		ShipType = var_1_0
		var_1_1[1] = var_1_0.FengFanM
		ShipType = var_2
		var_1_1[2] = var_2.FengFanS
		ShipType = var_2
		var_1_1[3] = var_2.FengFanV

		local function var_1_2(arg_3_0)
			if #var_1_1 ~= #arg_3_0 then
				return false
			end

			local var_3_0 = {}
			local var_3_1 = {}

			ipairs = var_2_10003

			for iter_3_0, iter_3_1 in var_2_10003(var_1_1) do
				local var_3_2

				if not var_3_0[iter_3_1] then
					var_3_2 = 0
				end

				var_3_0[iter_3_1] = var_3_2 + 1
			end

			ipairs = var_3

			for iter_3_2, iter_3_3 in var_3(arg_3_0) do
				local var_3_3

				if not var_3_1[iter_3_3] then
					var_3_3 = 0
				end

				var_3_1[iter_3_3] = var_3_3 + 1
			end

			pairs = var_3

			for iter_3_4, iter_3_5 in var_3(var_3_0) do
				if var_3_1[iter_3_4] ~= iter_3_5 then
					return false
				end
			end

			return true
		end

		ipairs = var_3
		pg = var_4

		for iter_1_0, iter_1_1 in var_3(var_4.fleet_tech_ship_class.all) do
			pg = var_1_10008

			local var_1_3 = var_1_10008.fleet_tech_ship_class[iter_1_1].nation

			Nation = var_1_10010

			if var_1_3 == var_1_10010.MOT then
				pg = var_1_10010

				local var_1_4 = var_1_10010.fleet_tech_ship_template[iter_1_1].add_get_shiptype
				local var_1_5 = var_1_10010.add_level_shiptype

				if not var_1_2(var_1_4) then
					assert = var_13

					var_13(false, "请检查fleet_tech_ship_class中的add_get_shiptype， ID：" .. iter_1_1)
				end

				if not var_1_2(var_1_5) then
					assert = var_13

					var_13(false, "请检查fleet_tech_ship_class中的add_level_shiptype， ID：" .. iter_1_1)
				end
			end
		end
	end

	return
end

function var_0_1.flushData(arg_4_0)
	arg_4_0:shipGroupFilter()
	arg_4_0:nationPointFilter()
	arg_4_0:calculateTecBuff()
	arg_4_0:refreshRedPoint()

	return
end

function var_0_1.updateTecItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
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

function var_0_1.updateTecItemAward(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.techList[arg_6_1].rewardedID = arg_6_2

	return
end

function var_0_1.updateTecItemAwardOneStep(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.techList) do
		iter_7_1.rewardedID = iter_7_1.completeID
	end

	return
end

function var_0_1.shipGroupFilter(arg_8_0)
	arg_8_0.groupListInCount = {}
	getProxy = var_1
	CollectionProxy = var_1_10002

	local var_8_0 = var_1(var_1_10002).shipGroups

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(var_8_0) do
		pg = var_1_10007

		if var_1_10007.fleet_tech_ship_template[iter_8_1.id] then
			table = var_1_10007

			var_1_10007.insert(arg_8_0.groupListInCount, iter_8_1)
		end
	end

	return
end

function var_0_1.nationPointFilter(arg_9_0)
	local var_9_0 = {}

	Nation = var_1_10002
	var_9_0[1] = var_1_10002.US
	Nation = var_2
	var_9_0[2] = var_2.EN
	Nation = var_2
	var_9_0[3] = var_2.JP
	Nation = var_2
	var_9_0[4] = var_2.DE
	Nation = var_2
	var_9_0[5] = var_2.CN
	Nation = var_2
	var_9_0[6] = var_2.ITA
	Nation = var_2
	var_9_0[7] = var_2.SN
	Nation = var_2
	var_9_0[8] = var_2.FF
	Nation = var_2
	var_9_0[9] = var_2.MNF
	Nation = var_2
	var_9_0[10] = var_2.FR
	Nation = var_2
	var_9_0[11] = var_2.NL
	Nation = var_2
	var_9_0[12] = var_2.LDP
	Nation = var_2
	var_9_0[13] = var_2.META
	LOCK_TEC_MOT = var_2

	if not var_2 then
		table = var_2

		local var_9_1 = var_2.insert
		local var_9_2 = var_9_0

		Nation = var_1_10004

		var_9_1(var_9_2, var_1_10004.MOT)
	end

	arg_9_0.nationToPoint = {}
	arg_9_0.nationToPointLog = {}
	arg_9_0.nationToPointLog2 = {}
	ipairs = var_2

	for iter_9_0, iter_9_1 in var_2(var_9_0) do
		arg_9_0.nationToPoint[iter_9_1] = 0
		arg_9_0.nationToPointLog[iter_9_1] = {
			{},
			{},
			{}
		}
		arg_9_0.nationToPointLog2[iter_9_1] = {}
	end

	ipairs = var_2

	for iter_9_2, iter_9_3 in var_2(arg_9_0.groupListInCount) do
		local var_9_3 = iter_9_3:getNation()
		local var_9_4 = iter_9_3.id

		tonumber = var_1_10009
		string = var_1_10010
		var_1_10010 = var_1_10010.sub
		tostring = var_1_10011

		if var_9_3 ~= var_1_10009(var_1_10010(var_1_10011(var_9_4), 1, 1)) then
			table = var_1_10009

			var_1_10009.insert(arg_9_0.nationToPointLog2[var_9_3], iter_9_3)
		end

		pg = var_1_10009
		var_1_10009 = var_1_10009.fleet_tech_ship_template[var_9_4]
		var_1_10010 = 0 + var_1_10009.pt_get
		table = var_1_10011

		var_1_10011.insert(arg_9_0.nationToPointLog[var_9_3][1], var_9_4)

		if iter_9_3.maxLV then
			var_1_10011 = iter_9_3.maxLV
			TechnologyConst = var_12

			if var_1_10011 >= var_12.SHIP_LEVEL_FOR_BUFF then
				var_1_10010 = var_1_10010 + var_1_10009.pt_level
				table = var_1_10011

				var_1_10011.insert(arg_9_0.nationToPointLog[var_9_3][2], var_9_4)
			end
		end

		if iter_9_3.star >= var_1_10009.max_star then
			var_1_10010 = var_1_10010 + var_1_10009.pt_upgrage
			table = var_1_10011

			var_1_10011.insert(arg_9_0.nationToPointLog[var_9_3][3], var_9_4)
		end

		var_1_10011 = arg_9_0.nationToPoint
		var_1_10011[var_9_3] = arg_9_0.nationToPoint[var_9_3] + var_1_10010
	end

	arg_9_0.point = 0
	pairs = var_2

	for iter_9_4, iter_9_5 in var_2(arg_9_0.nationToPoint) do
		arg_9_0.point = arg_9_0.point + iter_9_5
	end

	return
end

function var_0_1.calculateTecBuff(arg_10_0)
	arg_10_0.typeBuffList = {}
	arg_10_0.typeOrder = {}
	ipairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0.groupListInCount) do
		var_1_10006 = iter_10_1.id
		pg = var_1_10007
		var_1_10007 = var_1_10007.fleet_tech_ship_template[var_1_10006].add_get_shiptype
		pg = var_1_10008
		var_1_10008 = var_1_10008.fleet_tech_ship_template[var_1_10006].add_get_attr
		pg = var_1_10009
		var_1_10009 = var_1_10009.fleet_tech_ship_template[var_1_10006].add_get_value
		ipairs = var_1_10010

		for iter_10_2, iter_10_3 in var_1_10010(var_1_10007) do
			if not arg_10_0.typeBuffList[iter_10_3] then
				var_1_10015 = arg_10_0.typeBuffList
				var_1_10015[iter_10_3] = {
					{
						var_1_10008,
						var_1_10009
					}
				}
				var_1_10015 = arg_10_0.typeOrder
				var_1_10015[#arg_10_0.typeOrder + 1] = iter_10_3
			else
				var_1_10015 = arg_10_0.typeBuffList[iter_10_3]
				var_1_10015[#arg_10_0.typeBuffList[iter_10_3] + 1] = {
					var_1_10008,
					var_1_10009
				}
			end
		end

		var_1_10010 = iter_10_1.maxLV
		TechnologyConst = var_11

		if var_11.SHIP_LEVEL_FOR_BUFF <= var_1_10010 then
			pg = var_1_10010
			var_1_10010 = var_1_10010.fleet_tech_ship_template[var_1_10006].add_level_shiptype
			pg = var_11

			local var_10_0 = var_11.fleet_tech_ship_template[var_1_10006].add_level_attr

			pg = var_12

			local var_10_1 = var_12.fleet_tech_ship_template[var_1_10006].add_level_value

			ipairs = iter_10_2

			for iter_10_4, iter_10_5 in iter_10_2(var_1_10010) do
				if not arg_10_0.typeBuffList[iter_10_5] then
					arg_10_0.typeBuffList[iter_10_5] = {
						{
							var_10_0,
							var_10_1
						}
					}
					arg_10_0.typeOrder[#arg_10_0.typeOrder + 1] = iter_10_5
				else
					arg_10_0.typeBuffList[iter_10_5][#arg_10_0.typeBuffList[iter_10_5] + 1] = {
						var_10_0,
						var_10_1
					}
				end
			end
		end
	end

	pairs = var_1

	for iter_10_6, iter_10_7 in var_1(arg_10_0.techList) do
		if iter_10_7.completeID ~= 0 then
			pg = var_1_10006
			var_1_10006 = var_1_10006.fleet_tech_template[iter_10_7.completeID].add
			ipairs = var_7

			for iter_10_8, iter_10_9 in var_7(var_1_10006) do
				local var_10_2 = iter_10_9[1]
				local var_10_3 = iter_10_9[2]
				local var_10_4 = iter_10_9[3]

				ipairs = var_1_10015

				for iter_10_10, iter_10_11 in var_1_10015(var_10_2) do
					if not arg_10_0.typeBuffList[iter_10_11] then
						arg_10_0.typeBuffList[iter_10_11] = {
							{
								var_10_3,
								var_10_4
							}
						}
						arg_10_0.typeOrder[#arg_10_0.typeOrder + 1] = iter_10_11
					else
						arg_10_0.typeBuffList[iter_10_11][#arg_10_0.typeBuffList[iter_10_11] + 1] = {
							var_10_3,
							var_10_4
						}
					end
				end
			end
		end
	end

	arg_10_0.typeAttrTable = {}
	arg_10_0.typeAttrOrderTable = {}
	pairs = var_1

	for iter_10_12, iter_10_13 in var_1(arg_10_0.typeBuffList) do
		if not arg_10_0.typeAttrTable[iter_10_12] then
			var_1_10006 = arg_10_0.typeAttrTable
			var_1_10006[iter_10_12] = {}
			var_1_10006 = arg_10_0.typeAttrOrderTable
			var_1_10006[iter_10_12] = {}
		end

		ipairs = var_1_10006

		for iter_10_14, iter_10_15 in var_1_10006(iter_10_13) do
			local var_10_5 = iter_10_15[1]
			local var_10_6 = iter_10_15[2]

			if not arg_10_0.typeAttrTable[iter_10_12][var_10_5] then
				arg_10_0.typeAttrTable[iter_10_12][var_10_5] = var_10_6
				arg_10_0.typeAttrOrderTable[iter_10_12][#arg_10_0.typeAttrOrderTable[iter_10_12] + 1] = var_10_5
			else
				arg_10_0.typeAttrTable[iter_10_12][var_10_5] = arg_10_0.typeAttrTable[iter_10_12][var_10_5] + var_10_6
			end
		end
	end

	table = var_1

	var_1.sort(arg_10_0.typeOrder, function(arg_11_0, arg_11_1)
		return arg_11_0 < arg_11_1
	end)

	pairs = var_1

	for iter_10_16, iter_10_17 in var_1(arg_10_0.typeAttrOrderTable) do
		table = var_1_10006

		var_1_10006.sort(iter_10_17, function(arg_12_0, arg_12_1)
			return arg_12_0 < arg_12_1
		end)
	end

	return
end

function var_0_1.setTimer(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.techList) do
		if iter_13_1.studyID ~= 0 then
			local var_13_0 = iter_13_1.finishTime

			pg = var_1_10007

			local var_13_1 = var_1_10007.TimeMgr.GetInstance()

			var_1_10007 = var_1_10007.GetServerTime(var_13_1)
			table = var_13_1

			local var_13_2 = var_13_1.indexof

			pg = var_1_10009

			local var_13_3

			if not var_13_2(var_1_10009.fleet_tech_group[iter_13_0].techs, iter_13_1.completeID, 1) then
				var_13_3 = 0
			end

			pg = var_1_10009
			var_1_10009 = var_1_10009.fleet_tech_group[iter_13_0].techs[var_13_3 + 1]

			local var_13_5

			if var_13_0 < var_1_10007 then
				local var_13_4 = arg_13_0

				var_13_5 = arg_13_0.sendNotification
				GAME = var_1_10012

				var_13_5(var_13_4, var_1_10012.FINISH_CAMP_TEC, {
					tecID = iter_13_0,
					levelID = var_1_10009
				})

				return
			else
				onDelayTick = var_13_5

				var_13_5(function()
					local var_14_0 = arg_13_0
					local var_14_1 = var_0.sendNotification

					GAME = var_2_10002

					var_14_1(var_14_0, var_2_10002.FINISH_CAMP_TEC, {
						tecID = iter_13_0,
						levelID = var_1_10009
					})

					return
				end, var_13_0 - var_1_10007)

				return
			end
		end
	end

	return
end

function var_0_1.refreshRedPoint(arg_15_0)
	arg_15_0.ifShowRedPoint = false
	arg_15_0.isAnyTecCampStudying = false
	pairs = var_1

	for iter_15_0, iter_15_1 in var_1(arg_15_0.techList) do
		if iter_15_1.studyID ~= 0 then
			local var_15_0 = iter_15_1.finishTime

			pg = var_1_10007

			local var_15_1 = var_1_10007.TimeMgr.GetInstance()

			if var_15_0 < var_1_10007.GetServerTime(var_15_1) then
				arg_15_0.ifShowRedPoint = true

				return
			else
				arg_15_0.isAnyTecCampStudying = true

				return
			end
		end
	end

	local var_15_2 = arg_15_0

	if arg_15_0.isNeedRedPointTecCampUpgrade(var_15_2) then
		getProxy = var_1
		PlayerProxy = var_15_2

		local var_15_3 = var_1(var_15_2)
		local var_15_4 = var_1.getData(var_15_3).gold

		ipairs = var_15_3
		pg = var_3

		for iter_15_2, iter_15_3 in var_15_3(var_3.fleet_tech_group.all) do
			if not arg_15_0.techList[iter_15_3] or arg_15_0.techList[iter_15_3].studyID == 0 then
				local var_15_5 = arg_15_0
				local var_15_6 = arg_15_0.getLevelByTecID(var_15_5, iter_15_3)

				pg = var_15_5

				if var_15_6 < #var_15_5.fleet_tech_group[iter_15_3].techs then
					pg = var_8

					local var_15_7 = var_8.fleet_tech_group[iter_15_3].nation[1]

					pg = var_9

					local var_15_8 = var_9.fleet_tech_group[iter_15_3].techs[var_15_6 + 1]
					local var_15_9 = arg_15_0.nationToPoint[var_15_7]

					pg = var_1_10011

					local var_15_10 = var_1_10011.fleet_tech_template[var_15_8].pt <= var_15_9

					pg = var_1_10011
					var_1_10011 = var_1_10011.fleet_tech_template[var_15_8].cost <= var_15_4

					if var_15_10 and var_1_10011 then
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

function var_0_1.isAnyTecCampCanGetAward(arg_16_0)
	local var_16_0 = false

	LOCK_TEC_NATION_AWARD = var_1_10002

	if not var_1_10002 then
		pairs = var_1_10002

		for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.techList) do
			pg = var_1_10007
			var_1_10007 = var_1_10007.fleet_tech_group[iter_16_0]

			local var_16_1 = iter_16_1.rewardedID
			local var_16_2 = iter_16_1.completeID

			table = var_1_10010

			if not var_1_10010.indexof(var_1_10007.techs, var_16_1, 1) then
				var_1_10010 = 0
			end

			table = var_11

			local var_16_3

			if not var_11.indexof(var_1_10007.techs, var_16_2, 1) then
				var_16_3 = 0
			end

			if var_1_10010 < var_16_3 then
				var_16_0 = true

				break
			end
		end
	end

	return var_16_0
end

function var_0_1.getAnyTecCampStudying(arg_17_0)
	return arg_17_0.isAnyTecCampStudying
end

var_0_1.Ignore_TecCamp_Upgrade_Key = "Ignore_TecCamp_Upgrade_Key"

function var_0_1.setRedPointIgnoreTecCampUpgrade(arg_18_0)
	PlayerPrefs = var_1_10001

	local var_18_0 = var_1_10001.SetInt
	local var_18_1 = var_0_1.Ignore_TecCamp_Upgrade_Key

	pg = var_1_10003

	local var_18_2 = var_1_10003.TimeMgr.GetInstance()

	var_18_0(var_18_1, var_3.GetServerTime(var_18_2))

	return
end

function var_0_1.isNeedRedPointTecCampUpgrade(arg_19_0)
	PlayerPrefs = var_1_10001

	if var_1_10001.GetInt(var_0_1.Ignore_TecCamp_Upgrade_Key, 0) ~= 0 then
		pg = var_2

		local var_19_0 = var_2.TimeMgr.GetInstance()
		local var_19_1 = var_2.GetServerTime(var_19_0)

		pg = var_19_0

		local var_19_2 = var_19_0.TimeMgr.GetInstance()

		return not var_3.IsSameDay(var_19_2, var_1, var_19_1)
	else
		return true
	end

	return
end

function var_0_1.GetTecList(arg_20_0)
	return arg_20_0.techList
end

function var_0_1.GetTecItemByGroupID(arg_21_0, arg_21_1)
	return arg_21_0.techList[arg_21_1]
end

function var_0_1.getLevelByTecID(arg_22_0, arg_22_1)
	local var_22_0

	if not arg_22_0.techList[arg_22_1] then
		var_22_0 = 0
	else
		table = var_3

		local var_22_1 = var_3.indexof

		pg = var_1_10004
		var_22_0 = var_22_1(var_1_10004.fleet_tech_group[arg_22_1].techs, arg_22_0.techList[arg_22_1].completeID, 1) or 0
	end

	return var_22_0
end

function var_0_1.getGroupListInCount(arg_23_0)
	return arg_23_0.groupListInCount
end

function var_0_1.getShowRedPointTag(arg_24_0)
	return arg_24_0.ifShowRedPoint
end

function var_0_1.getStudyingTecItem(arg_25_0)
	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.techList) do
		if iter_25_1.studyID ~= 0 then
			return iter_25_0
		end
	end

	return nil
end

function var_0_1.getPoint(arg_26_0)
	return arg_26_0.point
end

function var_0_1.getNationPointList(arg_27_0)
	return arg_27_0.nationToPoint
end

function var_0_1.getNationPoint(arg_28_0, arg_28_1)
	if arg_28_1 == 0 then
		local var_28_0 = 0

		pairs = var_1_10003

		for iter_28_0, iter_28_1 in var_1_10003(arg_28_0.nationToPoint) do
			var_28_0 = var_28_0 + iter_28_1
		end

		return var_28_0
	else
		return arg_28_0.nationToPoint[arg_28_1]
	end

	return
end

function var_0_1.getLeftTime(arg_29_0)
	local var_29_0 = arg_29_0.techList
	local var_29_1 = arg_29_0

	if var_29_0[arg_29_0.getStudyingTecItem(var_29_1)] then
		local var_29_2 = var_1.finishTime

		pg = var_29_1

		local var_29_3 = var_29_1.TimeMgr.GetInstance()

		return var_29_2 - var_3.GetServerTime(var_29_3) > 0 and var_4 or 0
	else
		return 0
	end

	return
end

function var_0_1.getTecBuff(arg_30_0)
	OPEN_TEC_TREE_SYSTEM = var_1_10001

	if var_1_10001 then
		return arg_30_0.typeAttrTable, arg_30_0.typeOrder, arg_30_0.typeAttrOrderTable
	end

	return
end

function var_0_1.getShipAddition(arg_31_0, arg_31_1, arg_31_2)
	table = var_1_10003

	local var_31_0 = var_1_10003.indexof

	TechnologyConst = var_1_10004

	local var_31_1 = var_31_0(var_1_10004.TECH_NATION_ATTRS, arg_31_2)
	local var_31_2 = 0
	local var_31_3

	if not arg_31_0:getTecBuff() then
		var_31_3 = {}
	end

	if var_31_3[arg_31_1] and var_31_1 and var_6[var_31_1] then
		var_31_2 = arg_31_0:getSetableAttrAdditionValueByTypeAttr(arg_31_1, var_31_1)
	end

	return var_31_2
end

function var_0_1.getShipMaxAddition(arg_32_0, arg_32_1, arg_32_2)
	table = var_1_10003

	local var_32_0 = var_1_10003.indexof

	TechnologyConst = var_1_10004

	local var_32_1 = var_32_0(var_1_10004.TECH_NATION_ATTRS, arg_32_2)
	local var_32_2 = 0
	local var_32_3

	if not arg_32_0:getTecBuff() then
		var_32_3 = {}
	end

	if var_32_3[arg_32_1] and var_32_1 and var_6[var_32_1] then
		var_32_2 = var_6[var_32_1]
	end

	return var_32_2
end

function var_0_1.printNationPointLog(arg_33_0)
	pairs = var_1_10001

	for iter_33_0, iter_33_1 in var_1_10001(arg_33_0.nationToPointLog) do
		print = var_1_10006

		var_1_10006("----------------" .. iter_33_0 .. "----------------")

		ipairs = var_1_10006

		for iter_33_2, iter_33_3 in var_1_10006(iter_33_1) do
			local var_33_0 = iter_33_2 .. "    :"

			ipairs = var_12

			for iter_33_4, iter_33_5 in var_12(iter_33_3) do
				var_33_0 = var_33_0 .. "  " .. iter_33_5
			end

			print = var_12

			var_12(var_33_0)
		end
	end

	print = var_1

	var_1("----------------Filte----------------")

	pairs = var_1

	for iter_33_6, iter_33_7 in var_1(arg_33_0.nationToPointLog2) do
		local var_33_1 = iter_33_6 .. " :"

		ipairs = var_7

		for iter_33_8, iter_33_9 in var_7(iter_33_7) do
			local var_33_2 = iter_33_9.id
			local var_33_3 = iter_33_9:getNation()
			local var_33_4 = var_33_1

			tostring = iter_33_4
			iter_33_4 = iter_33_4(var_33_2)

			local var_33_5 = " "

			tostring = var_1_10017
			var_33_1 = var_33_4 .. iter_33_4 .. var_33_5 .. var_1_10017(var_33_3) .. "||"
		end

		print = var_7

		var_7(var_33_1)
	end

	return
end

function var_0_1.initSetableAttrAddition(arg_34_0, arg_34_1)
	arg_34_0.setValueTypeAttrTable = {}
	ipairs = var_2

	for iter_34_0, iter_34_1 in var_2(arg_34_1) do
		local var_34_0 = iter_34_1.ship_type
		local var_34_1 = iter_34_1.attr_type
		local var_34_2 = iter_34_1.set_value

		if not arg_34_0.setValueTypeAttrTable[var_34_0] then
			arg_34_0.setValueTypeAttrTable[var_34_0] = {}
		end

		arg_34_0.setValueTypeAttrTable[var_34_0][var_34_1] = var_34_2
	end

	return
end

function var_0_1.getSetableAttrAddition(arg_35_0)
	return arg_35_0.setValueTypeAttrTable
end

function var_0_1.getSetableAttrAdditionValueByTypeAttr(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0.setValueTypeAttrTable[arg_36_1] and arg_36_0.setValueTypeAttrTable[arg_36_1][arg_36_2] then
		return arg_36_0.setValueTypeAttrTable[arg_36_1][arg_36_2]
	else
		return arg_36_0.typeAttrTable[arg_36_1][arg_36_2]
	end

	return
end

return var_0_1
