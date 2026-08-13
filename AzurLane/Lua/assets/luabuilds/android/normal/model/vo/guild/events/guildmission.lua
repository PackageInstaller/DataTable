class = var_0_10000

local var_0_0 = "GuildMission"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseVO"))

function var_0_1.CompleteData2FullData(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.TimeMgr.GetInstance()
	local var_1_1 = var_1.GetServerTime(var_1_0)

	return {
		efficiency = 0,
		server_finish = true,
		event_id = arg_1_0.event_id,
		position = arg_1_0.position,
		join_number = arg_1_0.join_number,
		start_time = var_1_1,
		complete_time = var_1_1 - 10,
		shipinevent = {},
		attr_acc_list = {},
		attr_count_list = {},
		eventnodes = {},
		personship = {}
	}
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.event_id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.position = arg_2_1.position
	arg_2_0.serverFinish = arg_2_1.server_finish
	arg_2_0.myFleets = {}
	arg_2_0.myShips = {}
	arg_2_0.nodeAnimPosistion = 0
	arg_2_0.formationTime = 0
	arg_2_0.nations = {}

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.getConfig(var_2_0, "ship_camp_effect")

	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
		table = var_1_10008

		if not var_1_10008.contains(arg_2_0.nations, iter_2_1[1]) then
			table = var_1_10008

			var_1_10008.insert(arg_2_0.nations, iter_2_1[1])
		end
	end

	arg_2_0.shiptypes = {}

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.getConfig(var_2_2, "ship_type_effect")

	ipairs = var_2_2

	for iter_2_2, iter_2_3 in var_2_2(var_2_3) do
		table = var_1_10009

		var_1_10009.insert(arg_2_0.shiptypes, iter_2_3[1])
	end

	arg_2_0:Flush(arg_2_1, 0)

	PlayerPrefs = var_4
	arg_2_0.formationTipIndex = var_4.GetInt("guild_mission_formation_tip" .. arg_2_0.configId, 0)

	return
end

function var_0_1.Flush(arg_3_0, arg_3_1, arg_3_2)
	pg = var_1_10003

	local var_3_0 = var_1_10003.TimeMgr.GetInstance()

	arg_3_0.nextRefreshTime = arg_3_2 + var_3.GetServerTime(var_3_0)
	arg_3_0.startTime = arg_3_1.start_time
	arg_3_0.finishTime = arg_3_1.complete_time

	local var_3_1

	if not arg_3_1.efficiency then
		var_3_1 = 0
	end

	arg_3_0.efficiency = var_3_1
	arg_3_0.totalTimeCost = arg_3_0.finishTime - arg_3_0.startTime
	arg_3_0.ships = {}
	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(arg_3_1.shipinevent) do
		local var_3_2 = {
			userId = iter_3_1.user_id,
			shipId = iter_3_1.ship_id,
			configId = iter_3_1.template_id,
			skin = iter_3_1.skin
		}

		table = var_9

		var_9.insert(arg_3_0.ships, var_3_2)
	end

	local var_3_3 = {}

	ipairs = var_4

	local var_3_4

	if not arg_3_1.personship then
		var_3_4 = {}
	end

	for iter_3_2, iter_3_3 in var_4(var_3_4) do
		var_3_3[iter_3_3.page_id] = {}
		ipairs = var_9

		for iter_3_4, iter_3_5 in var_9(iter_3_3.ship_ids) do
			table = var_1_10014

			var_1_10014.insert(var_3_3[iter_3_3.page_id], iter_3_5)
		end
	end

	local var_3_5 = arg_3_0

	arg_3_0.UpdateMyFleets(var_3_5, var_3_3)

	arg_3_0.attrAccList = {}

	local var_3_6 = {}

	ipairs = var_3_5

	for iter_3_6, iter_3_7 in var_3_5(arg_3_1.attr_acc_list) do
		var_3_6[iter_3_7.key] = iter_3_7.value
	end

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.getConfig(var_3_7, "event_attr_acc_effect")

	ipairs = var_3_7

	for iter_3_8, iter_3_9 in var_3_7(var_3_8) do
		local var_3_9

		if not var_3_6[iter_3_9[1]] then
			var_3_9 = 0
		end

		arg_3_0.attrAccList[iter_3_9[1]] = {
			value = var_3_9,
			op = iter_3_9[2],
			goal = iter_3_9[3],
			score = iter_3_9[4]
		}
	end

	arg_3_0.attrCntList = {}

	local var_3_10 = {}

	ipairs = var_7

	for iter_3_10, iter_3_11 in var_7(arg_3_1.attr_count_list) do
		var_3_10[iter_3_11.key] = iter_3_11.value
	end

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.getConfig(var_3_11, "event_attr_count_effect")

	ipairs = var_3_11

	for iter_3_12, iter_3_13 in var_3_11(var_3_12) do
		if not var_3_10[iter_3_13[1]] then
			iter_3_5 = 0
		end

		arg_3_0.attrCntList[iter_3_13[1]] = {
			value = iter_3_5,
			total = iter_3_13[2],
			goal = iter_3_13[3],
			score = iter_3_13[4]
		}
	end

	arg_3_0.nodes = {}
	arg_3_0.nodeLogs = {}
	ipairs = var_8

	for iter_3_14, iter_3_15 in var_8(arg_3_1.eventnodes) do
		GuildMissionNode = iter_3_5
		iter_3_5 = iter_3_5.New(iter_3_15)
		table = var_14

		var_14.insert(arg_3_0.nodes, iter_3_5)

		local var_3_13 = iter_3_5

		if iter_3_5.GetLog(var_3_13) then
			table = var_3_13

			var_3_13.insert(arg_3_0.nodeLogs, var_14)
		end
	end

	return
end

function var_0_1.IsFinishedByServer(arg_4_0)
	return arg_4_0.serverFinish
end

function var_0_1.GetTotalTimeCost(arg_5_0)
	return arg_5_0.totalTimeCost
end

function var_0_1.GetStartTime(arg_6_0)
	return arg_6_0.startTime
end

function var_0_1.GetRemainingTime(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.GetTotalTimeCost(var_7_0)

	pg = var_7_0

	local var_7_2 = var_7_0.TimeMgr.GetInstance()

	return var_7_1 - (var_2.GetServerTime(var_7_2) - arg_7_0:GetStartTime())
end

function var_0_1.IsBoss(arg_8_0)
	return false
end

function var_0_1.UpdateNodeAnimFlagIndex(arg_9_0, arg_9_1)
	arg_9_0.nodeAnimPosistion = arg_9_1

	return
end

function var_0_1.GetNodeAnimPosistion(arg_10_0)
	return arg_10_0.nodeAnimPosistion
end

function var_0_1.GetNewestSuccessNode(arg_11_0)
	for iter_11_0 = #arg_11_0.nodes, 1, -1 do
		local var_11_0 = arg_11_0.nodes[iter_11_0]

		if var_5.IsSuccess(var_11_0) then
			return var_5
		end
	end

	return
end

function var_0_1.UpdateFormationTime(arg_12_0, arg_12_1)
	arg_12_0.formationTime = arg_12_1 or 0

	return
end

function var_0_1.CanFormation(arg_13_0)
	table = var_1_10001

	local var_13_0 = var_1_10001.getCount(arg_13_0.myFleets)

	GuildConst = var_2

	if var_13_0 == var_2.MISSION_MAX_FLEET_CNT then
		return false
	end

	if arg_13_0.formationTime == 0 then
		return true
	end

	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0.GetNextFormationTime(var_13_1)

	pg = var_13_1

	local var_13_3 = var_13_1.TimeMgr.GetInstance()

	return var_13_2 - var_2.GetServerTime(var_13_3) <= 0, var_2
end

function var_0_1.GetNextFormationTime(arg_14_0)
	local var_14_0 = arg_14_0.formationTime

	GetZeroTime = var_1_10002

	local var_14_1 = var_1_10002()

	GetZeroTime = var_1_10003

	local var_14_2 = var_1_10003() - 0

	pg = var_1_10004

	local var_14_3 = var_1_10004.guildset.operation_member_dispatch_reset.key_args

	_ = var_1_10005

	local var_14_4 = var_1_10005.map(var_14_3, function(arg_15_0)
		return var_14_2 + arg_15_0 * 16
	end)

	_ = var_6

	if var_6.detect(var_14_4, function(arg_16_0)
		return arg_16_0 > var_14_0
	end) then
		if var_14_0 < var_14_2 - 0 + var_14_3[4] * 16 then
			pg = var_8

			local var_14_5 = var_8.TimeMgr.GetInstance()

			return var_8.GetServerTime(var_14_5)
		else
			return var_6
		end
	else
		return var_14_1 + var_14_3[1] * 16
	end

	return
end

function var_0_1.UpdateMyFleets(arg_17_0, arg_17_1)
	arg_17_0.myFleets = arg_17_1
	arg_17_0.myShips = {}
	pairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_0.myFleets) do
		ipairs = var_1_10007

		for iter_17_2, iter_17_3 in var_1_10007(iter_17_1) do
			table = var_1_10012

			var_1_10012.insert(arg_17_0.myShips, iter_17_3)
		end
	end

	return
end

function var_0_1.UpdateFleet(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.myFleets

	var_18_0[arg_18_1] = {}
	ipairs = var_18_0

	for iter_18_0, iter_18_1 in var_18_0(arg_18_2) do
		table = var_1_10008

		var_1_10008.insert(arg_18_0.myFleets[arg_18_1], iter_18_1)

		table = var_1_10008

		var_1_10008.insert(arg_18_0.myShips, iter_18_1)
	end

	return
end

function var_0_1.GetFleetByIndex(arg_19_0, arg_19_1)
	return arg_19_0.myFleets[arg_19_1]
end

function var_0_1.GetMaxFleet(arg_20_0)
	return arg_20_0:GetFleetCnt() + (arg_20_0:CanFormation() and 1 or 0)
end

function var_0_1.GetFleetCnt(arg_21_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_21_0.myFleets)
end

function var_0_1.IsMaxFleetCnt(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.GetFleetCnt(var_22_0)

	GuildConst = var_22_0

	return var_22_1 == var_22_0.MISSION_MAX_FLEET_CNT
end

function var_0_1.GetCanFormationIndex(arg_23_0)
	if arg_23_0:CanFormation() then
		table = var_1

		return var_1.getCount(arg_23_0.myFleets) + 1
	end

	return -1
end

function var_0_1.ShouldRefresh(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_24_0) > arg_24_0.nextRefreshTime
end

function var_0_1.bindConfigTable(arg_25_0)
	pg = var_1_10001

	return var_1_10001.guild_base_event
end

function var_0_1.GetPosition(arg_26_0)
	return arg_26_0.position
end

function var_0_1.GetIcon(arg_27_0)
	return arg_27_0:getConfig("pic")
end

function var_0_1.GetSubType(arg_28_0)
	return arg_28_0:getConfig("sub_type")
end

function var_0_1.IsMain(arg_29_0)
	return arg_29_0:GetSubType() == 1
end

function var_0_1.IsFinish(arg_30_0)
	pg = var_1_10001

	local var_30_0 = var_1_10001.TimeMgr.GetInstance()
	local var_30_1 = var_1.GetServerTime(var_30_0)

	return arg_30_0.finishTime > 0 and var_30_1 >= arg_30_0.finishTime
end

function var_0_1.GetName(arg_31_0)
	return arg_31_0:getConfig("name")
end

function var_0_1.GetTag(arg_32_0)
	return arg_32_0:getConfig("type")
end

function var_0_1.IsActive(arg_33_0)
	return true
end

function var_0_1.IsEliteType(arg_34_0)
	return arg_34_0:getConfig("type") == 2
end

function var_0_1.GetJoinMemberCnt(arg_35_0)
	local var_35_0 = {}

	ipairs = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10002(arg_35_0.ships) do
		table = var_1_10007

		if not var_1_10007.contains(var_35_0, iter_35_1.userId) then
			table = var_1_10007

			var_1_10007.insert(var_35_0, iter_35_1.userId)
		end
	end

	return #var_35_0
end

function var_0_1.GetEfficiency(arg_36_0)
	return arg_36_0.efficiency
end

function var_0_1.GetShipsByNation(arg_37_0, arg_37_1)
	local var_37_0 = {}

	ipairs = var_1_10003

	for iter_37_0, iter_37_1 in var_1_10003(arg_37_0.ships) do
		pg = var_1_10008

		if arg_37_1 == var_1_10008.ship_data_statistics[iter_37_1.configId].nationality then
			table = var_9

			var_9.insert(var_37_0, iter_37_1)
		end
	end

	return var_37_0
end

function var_0_1.GetNations(arg_38_0)
	return arg_38_0.nations
end

function var_0_1.GetAttrAcc(arg_39_0)
	return arg_39_0.attrAccList
end

function var_0_1.GetAttrCntAcc(arg_40_0)
	return arg_40_0.attrCntList
end

function var_0_1.GetNodes(arg_41_0)
	return arg_41_0.nodes
end

function var_0_1.GetProgress(arg_42_0)
	if arg_42_0:GetTotalTimeCost() > 0 then
		local var_42_0 = arg_42_0
		local var_42_1 = arg_42_0.GetStartTime(var_42_0)

		pg = var_42_0

		local var_42_2 = var_42_0.TimeMgr.GetInstance()

		return (var_3.GetServerTime(var_42_2) - var_42_1) / var_1
	else
		return 0
	end

	return
end

function var_0_1.GetMyFlagShip(arg_43_0)
	return arg_43_0.myShips[1]
end

function var_0_1.GetLogs(arg_44_0)
	local var_44_0 = arg_44_0

	if arg_44_0.GetMyFlagShip(var_44_0) then
		getProxy = var_44_0
		BayProxy = var_1_10003

		local var_44_1 = var_44_0(var_1_10003)
		local var_44_2 = var_2.getShipById(var_44_1, var_1)

		_ = var_44_1

		do return var_44_1.map(arg_44_0.nodeLogs, function(arg_45_0)
			string = var_2_10001

			local var_45_0 = var_2_10001.gsub
			local var_45_1 = arg_45_0
			local var_45_2 = "$2"
			local var_45_3 = "<color=#92FC63FF>"
			local var_45_4 = var_44_2

			return var_45_0(var_45_1, var_45_2, var_45_3 .. var_5.getName(var_45_4) .. "</color>")
		end) end
		return
	end

	return {}
end

function var_0_1.GetMyShips(arg_46_0)
	return arg_46_0.myShips
end

function var_0_1.GetBattleShipType(arg_47_0)
	return arg_47_0:getConfig("ship_type_display")
end

function var_0_1.GetAwards(arg_48_0)
	return arg_48_0:getConfig("award_list")
end

function var_0_1.CalcMyEffect(arg_49_0)
	if not arg_49_0 or #arg_49_0 == 0 then
		return 0
	end

	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_49_0 = var_1_10001(var_1_10002)
	local var_49_1 = 0
	local var_49_2 = 0

	ipairs = var_1_10004

	for iter_49_0, iter_49_1 in var_1_10004(arg_49_0) do
		if var_49_0:getShipById(iter_49_1) then
			var_49_1 = var_9.level + var_49_1
			var_49_2 = var_49_2 + var_9:getShipCombatPower({})
		end
	end

	math = var_4

	local var_49_3 = var_4.floor

	math = var_5

	return var_49_3((20 + var_5.pow(var_49_1, 0.7)) * (1 + var_49_2 / (var_49_2 + 12500)))
end

function var_0_1.GetMyEffect(arg_50_0)
	return var_0_1.CalcMyEffect(arg_50_0.myShips)
end

function var_0_1.GetRecommendShipTypes(arg_51_0)
	return arg_51_0.shiptypes
end

function var_0_1.GetRecommendShipNation(arg_52_0)
	return arg_52_0.nations
end

function var_0_1.GetSquadron(arg_53_0)
	return arg_53_0:getConfig("extra_squadron")
end

function var_0_1.GetSquadronDisplay(arg_54_0)
	return arg_54_0:getConfig("extra_squadron_display")
end

function var_0_1.GetSquadronTargetCnt(arg_55_0)
	return arg_55_0:getConfig("extra_squadron_num")
end

function var_0_1.GetSquadronRatio(arg_56_0)
	return arg_56_0:getConfig("extra_squedron_ratio") / 100
end

function var_0_1.GetOtherShips(arg_57_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_57_0 = var_1_10001(var_1_10002)
	local var_57_1 = var_1.getRawData(var_57_0)
	local var_57_2 = {}

	pairs = var_1_10003

	for iter_57_0, iter_57_1 in var_1_10003(arg_57_0.ships) do
		if var_57_1:getMemberById(iter_57_1.userId) then
			local var_57_3

			if iter_57_1.skin == 0 then
				pg = var_10
				var_57_3 = var_10.ship_data_statistics[iter_57_1.configId].skin_id
			end

			table = var_10

			local var_57_4 = var_10.insert
			local var_57_5 = var_57_2
			local var_57_6 = {
				id = iter_57_1.configId,
				skin = var_57_3
			}
			local var_57_7

			if not var_8 or not var_8.name then
				var_57_7 = ""
			end

			var_57_6.name = var_57_7

			var_57_4(var_57_5, var_57_6)
		end
	end

	return var_57_2
end

function var_0_1.RecordFormationTip(arg_58_0)
	local var_58_0 = arg_58_0:GetCanFormationIndex()

	if 0 < var_58_0 then
		PlayerPrefs = var_2

		var_2.SetInt("guild_mission_formation_tip" .. arg_58_0.configId, var_58_0)
	end

	return
end

function var_0_1.ShouldShowFormationTip(arg_59_0)
	return arg_59_0.formationTipIndex < arg_59_0:GetCanFormationIndex()
end

function var_0_1.FirstFleetCanFormation(arg_60_0)
	return arg_60_0:GetFleetCnt() == 0
end

function var_0_1.SameSquadron(arg_61_0, arg_61_1)
	if arg_61_0:IsEliteType() then
		table = var_2

		return var_2.contains(arg_61_1.tagList, arg_61_0:getConfig("extra_squadron"))
	end

	return false
end

function var_0_1.GetEffectAttr(arg_62_0)
	local var_62_0 = arg_62_0:getConfig("event_attr_count_effect")
	local var_62_1 = arg_62_0:getConfig("event_attr_acc_effect")
	local var_62_2
	local var_62_3

	if #var_62_0 > 0 then
		var_62_2 = var_62_0[1][1]
		var_62_3 = var_62_0[1][2]
	end

	if #var_62_1 > 0 then
		var_62_2 = var_62_1[1][1]
	end

	pg = var_5

	local var_62_4

	if var_5.attribute_info_by_type[var_62_2] then
		var_62_4 = var_5[var_62_2].name
	end

	return var_62_4, var_62_3
end

function var_0_1.MatchAttr(arg_63_0, arg_63_1)
	if arg_63_0:IsEliteType() then
		local var_63_0, var_63_1 = arg_63_0:GetEffectAttr()
		local var_63_2

		if not arg_63_1.attrs[var_63_0] then
			var_63_2 = 0
		end

		if var_63_1 then
			return var_63_1 <= var_63_2
		else
			return var_63_2 > 0
		end
	end

	return false
end

function var_0_1.MatchNation(arg_64_0, arg_64_1)
	if arg_64_0:IsEliteType() then
		local var_64_0 = arg_64_0
		local var_64_1 = arg_64_0.GetRecommendShipNation(var_64_0)

		table = var_64_0

		return var_64_0.contains(var_64_1, arg_64_1.nation)
	end

	return false
end

function var_0_1.MatchShipType(arg_65_0, arg_65_1)
	if arg_65_0:IsEliteType() then
		local var_65_0 = arg_65_0
		local var_65_1 = arg_65_0.GetRecommendShipTypes(var_65_0)

		table = var_65_0

		return var_65_0.contains(var_65_1, arg_65_1.type)
	end

	return false
end

return var_0_1
