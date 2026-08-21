local var_0_0 = class("GuildMission", import("...BaseVO"))

function var_0_0.CompleteData2FullData(arg_1_0)
	local var_1_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return {
		efficiency = 0,
		server_finish = true,
		event_id = arg_1_0.event_id,
		position = arg_1_0.position,
		join_number = arg_1_0.join_number,
		start_time = var_1_0,
		complete_time = var_1_0 - 10,
		shipinevent = {},
		attr_acc_list = {},
		attr_count_list = {},
		eventnodes = {},
		personship = {}
	}
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.event_id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.position = arg_2_1.position
	arg_2_0.serverFinish = arg_2_1.server_finish
	arg_2_0.myFleets = {}
	arg_2_0.myShips = {}
	arg_2_0.nodeAnimPosistion = 0
	arg_2_0.formationTime = 0
	arg_2_0.nations = {}

	for iter_2_0, iter_2_1 in ipairs((arg_2_0:getConfig("ship_camp_effect"))) do
		if not table.contains(arg_2_0.nations, iter_2_1[1]) then
			table.insert(arg_2_0.nations, iter_2_1[1])
		end
	end

	arg_2_0.shiptypes = {}

	for iter_2_2, iter_2_3 in ipairs((arg_2_0:getConfig("ship_type_effect"))) do
		table.insert(arg_2_0.shiptypes, iter_2_3[1])
	end

	arg_2_0:Flush(arg_2_1, 0)

	arg_2_0.formationTipIndex = PlayerPrefs.GetInt("guild_mission_formation_tip" .. arg_2_0.configId, 0)

	return
end

function var_0_0.Flush(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.nextRefreshTime = arg_3_2 + pg.TimeMgr.GetInstance():GetServerTime()
	arg_3_0.startTime = arg_3_1.start_time
	arg_3_0.finishTime = arg_3_1.complete_time
	arg_3_0.efficiency = arg_3_1.efficiency or 0
	arg_3_0.totalTimeCost = arg_3_0.finishTime - arg_3_0.startTime
	arg_3_0.ships = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.shipinevent) do
		table.insert(arg_3_0.ships, {
			userId = iter_3_1.user_id,
			shipId = iter_3_1.ship_id,
			configId = iter_3_1.template_id,
			skin = iter_3_1.skin
		})
	end

	local var_3_0 = arg_3_1.personship or {}

	for iter_3_2, iter_3_3 in ipairs(var_3_0) do
		({})[iter_3_3.page_id] = {}

		for iter_3_4, iter_3_5 in ipairs(iter_3_3.ship_ids) do
			table.insert(({})[iter_3_3.page_id], iter_3_5)
		end
	end

	arg_3_0:UpdateMyFleets({})

	arg_3_0.attrAccList = {}

	for iter_3_6, iter_3_7 in ipairs(arg_3_1.attr_acc_list) do
		({})[iter_3_7.key] = iter_3_7.value
	end

	for iter_3_8, iter_3_9 in ipairs((arg_3_0:getConfig("event_attr_acc_effect"))) do
		local var_3_1 = ({})[iter_3_9[1]]

		if not ({})[iter_3_9[1]] then
			var_3_1 = 0
		end

		arg_3_0.attrAccList[iter_3_9[1]] = {
			value = var_3_1,
			op = iter_3_9[2],
			goal = iter_3_9[3],
			score = iter_3_9[4]
		}
	end

	arg_3_0.attrCntList = {}

	for iter_3_10, iter_3_11 in ipairs(arg_3_1.attr_count_list) do
		({})[iter_3_11.key] = iter_3_11.value
	end

	for iter_3_12, iter_3_13 in ipairs((arg_3_0:getConfig("event_attr_count_effect"))) do
		local var_3_2 = ({})[iter_3_13[1]]

		if not ({})[iter_3_13[1]] then
			var_3_2 = 0
		end

		arg_3_0.attrCntList[iter_3_13[1]] = {
			value = var_3_2,
			total = iter_3_13[2],
			goal = iter_3_13[3],
			score = iter_3_13[4]
		}
	end

	arg_3_0.nodes = {}
	arg_3_0.nodeLogs = {}

	for iter_3_14, iter_3_15 in ipairs(arg_3_1.eventnodes) do
		local var_3_3 = GuildMissionNode.New(iter_3_15)

		table.insert(arg_3_0.nodes, var_3_3)

		local var_3_4 = var_3_3:GetLog()

		if var_3_4 then
			table.insert(arg_3_0.nodeLogs, var_3_4)
		end
	end

	return
end

function var_0_0.IsFinishedByServer(arg_4_0)
	return arg_4_0.serverFinish
end

function var_0_0.GetTotalTimeCost(arg_5_0)
	return arg_5_0.totalTimeCost
end

function var_0_0.GetStartTime(arg_6_0)
	return arg_6_0.startTime
end

function var_0_0.GetRemainingTime(arg_7_0)
	return arg_7_0:GetTotalTimeCost() - (pg.TimeMgr.GetInstance():GetServerTime() - arg_7_0:GetStartTime())
end

function var_0_0.IsBoss(arg_8_0)
	return false
end

function var_0_0.UpdateNodeAnimFlagIndex(arg_9_0, arg_9_1)
	arg_9_0.nodeAnimPosistion = arg_9_1

	return
end

function var_0_0.GetNodeAnimPosistion(arg_10_0)
	return arg_10_0.nodeAnimPosistion
end

function var_0_0.GetNewestSuccessNode(arg_11_0)
	for iter_11_0 = #arg_11_0.nodes, 1, -1 do
		if arg_11_0.nodes[iter_11_0]:IsSuccess() then
			return arg_11_0.nodes[iter_11_0]
		end
	end

	return
end

function var_0_0.UpdateFormationTime(arg_12_0, arg_12_1)
	arg_12_0.formationTime = arg_12_1 or 0

	return
end

function var_0_0.CanFormation(arg_13_0)
	if table.getCount(arg_13_0.myFleets) == GuildConst.MISSION_MAX_FLEET_CNT then
		return false
	end

	if arg_13_0.formationTime == 0 then
		return true
	end

	local var_13_0 = arg_13_0:GetNextFormationTime() - pg.TimeMgr.GetInstance():GetServerTime()

	return var_13_0 <= 0, var_13_0
end

function var_0_0.GetNextFormationTime(arg_14_0)
	local var_14_0 = arg_14_0.formationTime
	local var_14_1 = GetZeroTime() - 0
	local var_14_2 = _.detect(_.map(pg.guildset.operation_member_dispatch_reset.key_args, function(arg_15_0)
		return var_14_1 + arg_15_0 * 16
	end), function(arg_16_0)
		return arg_16_0 > var_14_0
	end)

	if var_14_2 then
		if arg_14_0.formationTime < GetZeroTime() - 0 - 0 + pg.guildset.operation_member_dispatch_reset.key_args[4] * 16 then
			return pg.TimeMgr.GetInstance():GetServerTime()
		else
			return var_14_2
		end
	else
		return GetZeroTime() + pg.guildset.operation_member_dispatch_reset.key_args[1] * 16
	end

	return
end

function var_0_0.UpdateMyFleets(arg_17_0, arg_17_1)
	arg_17_0.myFleets = arg_17_1
	arg_17_0.myShips = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0.myFleets) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			table.insert(arg_17_0.myShips, iter_17_3)
		end
	end

	return
end

function var_0_0.UpdateFleet(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.myFleets[arg_18_1] = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		table.insert(arg_18_0.myFleets[arg_18_1], iter_18_1)
		table.insert(arg_18_0.myShips, iter_18_1)
	end

	return
end

function var_0_0.GetFleetByIndex(arg_19_0, arg_19_1)
	return arg_19_0.myFleets[arg_19_1]
end

function var_0_0.GetMaxFleet(arg_20_0)
	return arg_20_0:GetFleetCnt() + (arg_20_0:CanFormation() and 1 or 0)
end

function var_0_0.GetFleetCnt(arg_21_0)
	return table.getCount(arg_21_0.myFleets)
end

function var_0_0.IsMaxFleetCnt(arg_22_0)
	return arg_22_0:GetFleetCnt() == GuildConst.MISSION_MAX_FLEET_CNT
end

function var_0_0.GetCanFormationIndex(arg_23_0)
	if arg_23_0:CanFormation() then
		return table.getCount(arg_23_0.myFleets) + 1
	end

	return -1
end

function var_0_0.ShouldRefresh(arg_24_0)
	local var_24_0 = pg.TimeMgr.GetInstance()

	return var_24_0:GetServerTime() > arg_24_0.nextRefreshTime
end

function var_0_0.bindConfigTable(arg_25_0)
	return pg.guild_base_event
end

function var_0_0.GetPosition(arg_26_0)
	return arg_26_0.position
end

function var_0_0.GetIcon(arg_27_0)
	return arg_27_0:getConfig("pic")
end

function var_0_0.GetSubType(arg_28_0)
	return arg_28_0:getConfig("sub_type")
end

function var_0_0.IsMain(arg_29_0)
	return arg_29_0:GetSubType() == 1
end

function var_0_0.IsFinish(arg_30_0)
	local var_30_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return arg_30_0.finishTime > 0 and var_30_0 >= arg_30_0.finishTime
end

function var_0_0.GetName(arg_31_0)
	return arg_31_0:getConfig("name")
end

function var_0_0.GetTag(arg_32_0)
	return arg_32_0:getConfig("type")
end

function var_0_0.IsActive(arg_33_0)
	return true
end

function var_0_0.IsEliteType(arg_34_0)
	return arg_34_0:getConfig("type") == 2
end

function var_0_0.GetJoinMemberCnt(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.ships) do
		if not table.contains({}, iter_35_1.userId) then
			table.insert({}, iter_35_1.userId)
		end
	end

	return #{}
end

function var_0_0.GetEfficiency(arg_36_0)
	return arg_36_0.efficiency
end

function var_0_0.GetShipsByNation(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0.ships) do
		if arg_37_1 == pg.ship_data_statistics[iter_37_1.configId].nationality then
			table.insert({}, iter_37_1)
		end
	end

	return {}
end

function var_0_0.GetNations(arg_38_0)
	return arg_38_0.nations
end

function var_0_0.GetAttrAcc(arg_39_0)
	return arg_39_0.attrAccList
end

function var_0_0.GetAttrCntAcc(arg_40_0)
	return arg_40_0.attrCntList
end

function var_0_0.GetNodes(arg_41_0)
	return arg_41_0.nodes
end

function var_0_0.GetProgress(arg_42_0)
	local var_42_0 = arg_42_0:GetTotalTimeCost()

	if var_42_0 > 0 then
		return (pg.TimeMgr.GetInstance():GetServerTime() - arg_42_0:GetStartTime()) / var_42_0
	else
		return 0
	end

	return
end

function var_0_0.GetMyFlagShip(arg_43_0)
	return arg_43_0.myShips[1]
end

function var_0_0.GetLogs(arg_44_0)
	local var_44_0 = arg_44_0:GetMyFlagShip()

	if var_44_0 then
		local var_44_1 = getProxy(BayProxy):getShipById(var_44_0)

		do return _.map(arg_44_0.nodeLogs, function(arg_45_0)
			return string.gsub(arg_45_0, "$2", "<color=#92FC63FF>" .. var_44_1:getName() .. "</color>")
		end) end
		return
	end

	return {}
end

function var_0_0.GetMyShips(arg_46_0)
	return arg_46_0.myShips
end

function var_0_0.GetBattleShipType(arg_47_0)
	return arg_47_0:getConfig("ship_type_display")
end

function var_0_0.GetAwards(arg_48_0)
	return arg_48_0:getConfig("award_list")
end

function var_0_0.CalcMyEffect(arg_49_0)
	if not arg_49_0 or #arg_49_0 == 0 then
		return 0
	end

	local var_49_0 = getProxy(BayProxy)
	local var_49_1 = 0
	local var_49_2 = 0

	for iter_49_0, iter_49_1 in ipairs(arg_49_0) do
		local var_49_3 = var_49_0:getShipById(iter_49_1)

		if var_49_3 then
			var_49_1 = var_49_3.level + var_49_1
			var_49_2 = var_49_2 + var_49_3:getShipCombatPower({})
		end
	end

	return math.floor((20 + math.pow(var_49_1, 0.7)) * (1 + var_49_2 / (var_49_2 + 12500)))
end

function var_0_0.GetMyEffect(arg_50_0)
	return var_0_0.CalcMyEffect(arg_50_0.myShips)
end

function var_0_0.GetRecommendShipTypes(arg_51_0)
	return arg_51_0.shiptypes
end

function var_0_0.GetRecommendShipNation(arg_52_0)
	return arg_52_0.nations
end

function var_0_0.GetSquadron(arg_53_0)
	return arg_53_0:getConfig("extra_squadron")
end

function var_0_0.GetSquadronDisplay(arg_54_0)
	return arg_54_0:getConfig("extra_squadron_display")
end

function var_0_0.GetSquadronTargetCnt(arg_55_0)
	return arg_55_0:getConfig("extra_squadron_num")
end

function var_0_0.GetSquadronRatio(arg_56_0)
	return arg_56_0:getConfig("extra_squedron_ratio") / 100
end

function var_0_0.GetOtherShips(arg_57_0)
	local var_57_0 = getProxy(GuildProxy):getRawData()

	for iter_57_0, iter_57_1 in pairs(arg_57_0.ships) do
		local var_57_1 = var_57_0:getMemberById(iter_57_1.userId)

		if var_57_1 then
			local var_57_2 = iter_57_1.skin

			if iter_57_1.skin == 0 then
				var_57_2 = pg.ship_data_statistics[iter_57_1.configId].skin_id
			end

			local var_57_4 = {}
			local var_57_5 = {
				id = iter_57_1.configId,
				skin = var_57_2
			}

			if var_57_1 then
				var_57_5.name = var_57_1.name or ""

				var_57_3(var_57_4, var_57_5)
			end
		end
	end

	return {}
end

function var_0_0.RecordFormationTip(arg_58_0)
	local var_58_0 = arg_58_0:GetCanFormationIndex()

	if var_58_0 > 0 then
		PlayerPrefs.SetInt("guild_mission_formation_tip" .. arg_58_0.configId, var_58_0)
	end

	return
end

function var_0_0.ShouldShowFormationTip(arg_59_0)
	return arg_59_0.formationTipIndex < arg_59_0:GetCanFormationIndex()
end

function var_0_0.FirstFleetCanFormation(arg_60_0)
	return arg_60_0:GetFleetCnt() == 0
end

function var_0_0.SameSquadron(arg_61_0, arg_61_1)
	if arg_61_0:IsEliteType() then
		return table.contains(arg_61_1.tagList, arg_61_0:getConfig("extra_squadron"))
	end

	return false
end

function var_0_0.GetEffectAttr(arg_62_0)
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

	local var_62_4 = pg.attribute_info_by_type
	local var_62_5 = pg.attribute_info_by_type[var_62_2] and var_62_4[var_62_2].name

	return var_62_5, var_62_3
end

function var_0_0.MatchAttr(arg_63_0, arg_63_1)
	if arg_63_0:IsEliteType() then
		local var_63_0, var_63_1 = arg_63_0:GetEffectAttr()
		local var_63_2 = arg_63_1.attrs[var_63_0] or 0

		if var_63_1 then
			return var_63_1 <= var_63_2
		else
			return var_63_2 > 0
		end
	end

	return false
end

function var_0_0.MatchNation(arg_64_0, arg_64_1)
	if arg_64_0:IsEliteType() then
		return table.contains(arg_64_0:GetRecommendShipNation(), arg_64_1.nation)
	end

	return false
end

function var_0_0.MatchShipType(arg_65_0, arg_65_1)
	if arg_65_0:IsEliteType() then
		return table.contains(arg_65_0:GetRecommendShipTypes(), arg_65_1.type)
	end

	return false
end

return var_0_0
