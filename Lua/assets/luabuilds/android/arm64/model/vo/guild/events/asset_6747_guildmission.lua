local GuildMission = class("GuildMission", import("...BaseVO"))

function GuildMission:CompleteData2FullData()
	local var_1_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return {
		efficiency = 0,
		server_finish = true,
		event_id = self.event_id,
		position = self.position,
		join_number = self.join_number,
		start_time = var_1_0,
		complete_time = var_1_0 - 10,
		shipinevent = {},
		attr_acc_list = {},
		attr_count_list = {},
		eventnodes = {},
		personship = {}
	}
end

function GuildMission:Ctor(arg_2_1)
	self.id = arg_2_1.event_id
	self.configId = self.id
	self.position = arg_2_1.position
	self.serverFinish = arg_2_1.server_finish
	self.myFleets = {}
	self.myShips = {}
	self.nodeAnimPosistion = 0
	self.formationTime = 0
	self.nations = {}

	for iter_2_0, iter_2_1 in ipairs((self:getConfig("ship_camp_effect"))) do
		if not table.contains(self.nations, iter_2_1[1]) then
			table.insert(self.nations, iter_2_1[1])
		end
	end

	self.shiptypes = {}

	for iter_2_2, iter_2_3 in ipairs((self:getConfig("ship_type_effect"))) do
		table.insert(self.shiptypes, iter_2_3[1])
	end

	self:Flush(arg_2_1, 0)

	self.formationTipIndex = PlayerPrefs.GetInt("guild_mission_formation_tip" .. self.configId, 0)

	return
end

function GuildMission:Flush(arg_3_1, arg_3_2)
	self.nextRefreshTime = arg_3_2 + pg.TimeMgr.GetInstance():GetServerTime()
	self.startTime = arg_3_1.start_time
	self.finishTime = arg_3_1.complete_time
	self.efficiency = arg_3_1.efficiency or 0
	self.totalTimeCost = self.finishTime - self.startTime
	self.ships = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.shipinevent) do
		table.insert(self.ships, {
			userId = iter_3_1.user_id,
			shipId = iter_3_1.ship_id,
			configId = iter_3_1.template_id,
			skin = iter_3_1.skin
		})
	end

	local var_3_0 = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.personship or {}) do
		var_3_0[iter_3_3.page_id] = {}

		for iter_3_4, iter_3_5 in ipairs(iter_3_3.ship_ids) do
			table.insert(var_3_0[iter_3_3.page_id], iter_3_5)
		end
	end

	self:UpdateMyFleets(var_3_0)

	self.attrAccList = {}

	local var_3_1 = {}

	for iter_3_6, iter_3_7 in ipairs(arg_3_1.attr_acc_list) do
		var_3_1[iter_3_7.key] = iter_3_7.value
	end

	for iter_3_8, iter_3_9 in ipairs((self:getConfig("event_attr_acc_effect"))) do
		local var_3_2 = var_3_1[iter_3_9[1]] or 0

		self.attrAccList[iter_3_9[1]] = {
			value = var_3_2,
			op = iter_3_9[2],
			goal = iter_3_9[3],
			score = iter_3_9[4]
		}
	end

	self.attrCntList = {}

	local var_3_3 = {}

	for iter_3_10, iter_3_11 in ipairs(arg_3_1.attr_count_list) do
		var_3_3[iter_3_11.key] = iter_3_11.value
	end

	for iter_3_12, iter_3_13 in ipairs((self:getConfig("event_attr_count_effect"))) do
		local var_3_4 = var_3_3[iter_3_13[1]] or 0

		self.attrCntList[iter_3_13[1]] = {
			value = var_3_4,
			total = iter_3_13[2],
			goal = iter_3_13[3],
			score = iter_3_13[4]
		}
	end

	self.nodes = {}
	self.nodeLogs = {}

	for iter_3_14, iter_3_15 in ipairs(arg_3_1.eventnodes) do
		local var_3_5 = GuildMissionNode.New(iter_3_15)

		table.insert(self.nodes, var_3_5)

		local var_3_6 = var_3_5:GetLog()

		if var_3_6 then
			table.insert(self.nodeLogs, var_3_6)
		end
	end

	return
end

function GuildMission:IsFinishedByServer()
	return self.serverFinish
end

function GuildMission:GetTotalTimeCost()
	return self.totalTimeCost
end

function GuildMission:GetStartTime()
	return self.startTime
end

function GuildMission:GetRemainingTime()
	return self:GetTotalTimeCost() - (pg.TimeMgr.GetInstance():GetServerTime() - self:GetStartTime())
end

function GuildMission:IsBoss()
	return false
end

function GuildMission:UpdateNodeAnimFlagIndex(arg_9_1)
	self.nodeAnimPosistion = arg_9_1

	return
end

function GuildMission:GetNodeAnimPosistion()
	return self.nodeAnimPosistion
end

function GuildMission:GetNewestSuccessNode()
	for iter_11_0 = #self.nodes, 1, -1 do
		if self.nodes[iter_11_0]:IsSuccess() then
			return self.nodes[iter_11_0]
		end
	end

	return
end

function GuildMission:UpdateFormationTime(arg_12_1)
	self.formationTime = arg_12_1 or 0

	return
end

function GuildMission:CanFormation()
	if table.getCount(self.myFleets) == GuildConst.MISSION_MAX_FLEET_CNT then
		return false
	end

	if self.formationTime == 0 then
		return true
	end

	local var_13_0 = self:GetNextFormationTime() - pg.TimeMgr.GetInstance():GetServerTime()

	return var_13_0 <= 0, var_13_0
end

function GuildMission:GetNextFormationTime()
	local var_14_0 = self.formationTime
	local var_14_1 = GetZeroTime() - 0
	local var_14_2 = _.detect(_.map(pg.guildset.operation_member_dispatch_reset.key_args, function(arg_15_0)
		return var_14_1 + arg_15_0 * 16
	end), function(arg_16_0)
		return arg_16_0 > var_14_0
	end)

	if var_14_2 then
		if self.formationTime < var_14_1 - 0 + pg.guildset.operation_member_dispatch_reset.key_args[4] * 16 then
			return pg.TimeMgr.GetInstance():GetServerTime()
		else
			return var_14_2
		end
	else
		return GetZeroTime() + pg.guildset.operation_member_dispatch_reset.key_args[1] * 16
	end

	return
end

function GuildMission:UpdateMyFleets(arg_17_1)
	self.myFleets = arg_17_1
	self.myShips = {}

	for iter_17_0, iter_17_1 in pairs(self.myFleets) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			table.insert(self.myShips, iter_17_3)
		end
	end

	return
end

function GuildMission:UpdateFleet(arg_18_1, arg_18_2)
	self.myFleets[arg_18_1] = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		table.insert(self.myFleets[arg_18_1], iter_18_1)
		table.insert(self.myShips, iter_18_1)
	end

	return
end

function GuildMission:GetFleetByIndex(arg_19_1)
	return self.myFleets[arg_19_1]
end

function GuildMission:GetMaxFleet()
	return self:GetFleetCnt() + (self:CanFormation() and 1 or 0)
end

function GuildMission:GetFleetCnt()
	return table.getCount(self.myFleets)
end

function GuildMission:IsMaxFleetCnt()
	return self:GetFleetCnt() == GuildConst.MISSION_MAX_FLEET_CNT
end

function GuildMission:GetCanFormationIndex()
	if self:CanFormation() then
		return table.getCount(self.myFleets) + 1
	end

	return -1
end

function GuildMission:ShouldRefresh()
	return pg.TimeMgr.GetInstance():GetServerTime() > self.nextRefreshTime
end

function GuildMission:bindConfigTable()
	return pg.guild_base_event
end

function GuildMission:GetPosition()
	return self.position
end

function GuildMission:GetIcon()
	return self:getConfig("pic")
end

function GuildMission:GetSubType()
	return self:getConfig("sub_type")
end

function GuildMission:IsMain()
	return self:GetSubType() == 1
end

function GuildMission:IsFinish()
	return self.finishTime > 0 and pg.TimeMgr.GetInstance():GetServerTime() >= self.finishTime
end

function GuildMission:GetName()
	return self:getConfig("name")
end

function GuildMission:GetTag()
	return self:getConfig("type")
end

function GuildMission:IsActive()
	return true
end

function GuildMission:IsEliteType()
	return self:getConfig("type") == 2
end

function GuildMission:GetJoinMemberCnt()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(self.ships) do
		if not table.contains(var_35_0, iter_35_1.userId) then
			table.insert(var_35_0, iter_35_1.userId)
		end
	end

	return #var_35_0
end

function GuildMission:GetEfficiency()
	return self.efficiency
end

function GuildMission:GetShipsByNation(arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs(self.ships) do
		if arg_37_1 == pg.ship_data_statistics[iter_37_1.configId].nationality then
			table.insert(var_37_0, iter_37_1)
		end
	end

	return var_37_0
end

function GuildMission:GetNations()
	return self.nations
end

function GuildMission:GetAttrAcc()
	return self.attrAccList
end

function GuildMission:GetAttrCntAcc()
	return self.attrCntList
end

function GuildMission:GetNodes()
	return self.nodes
end

function GuildMission:GetProgress()
	local var_42_0 = self:GetTotalTimeCost()

	if var_42_0 > 0 then
		return (pg.TimeMgr.GetInstance():GetServerTime() - self:GetStartTime()) / var_42_0
	else
		return 0
	end

	return
end

function GuildMission:GetMyFlagShip()
	return self.myShips[1]
end

function GuildMission:GetLogs()
	local var_44_0 = self:GetMyFlagShip()

	if var_44_0 then
		local var_44_1 = getProxy(BayProxy):getShipById(var_44_0)

		do return _.map(self.nodeLogs, function(arg_45_0)
			return string.gsub(arg_45_0, "$2", "<color=#92FC63FF>" .. var_44_1:getName() .. "</color>")
		end) end
		return
	end

	return {}
end

function GuildMission:GetMyShips()
	return self.myShips
end

function GuildMission:GetBattleShipType()
	return self:getConfig("ship_type_display")
end

function GuildMission:GetAwards()
	return self:getConfig("award_list")
end

function GuildMission:CalcMyEffect()
	if not self or #self == 0 then
		return 0
	end

	local var_49_0 = getProxy(BayProxy)
	local var_49_1 = 0
	local var_49_2 = 0

	for iter_49_0, iter_49_1 in ipairs(self) do
		local var_49_3 = var_49_0:getShipById(iter_49_1)

		if var_49_3 then
			var_49_1 = var_49_3.level + var_49_1
			var_49_2 = var_49_2 + var_49_3:getShipCombatPower({})
		end
	end

	return math.floor((20 + math.pow(var_49_1, 0.7)) * (1 + var_49_2 / (var_49_2 + 12500)))
end

function GuildMission:GetMyEffect()
	return GuildMission.CalcMyEffect(self.myShips)
end

function GuildMission:GetRecommendShipTypes()
	return self.shiptypes
end

function GuildMission:GetRecommendShipNation()
	return self.nations
end

function GuildMission:GetSquadron()
	return self:getConfig("extra_squadron")
end

function GuildMission:GetSquadronDisplay()
	return self:getConfig("extra_squadron_display")
end

function GuildMission:GetSquadronTargetCnt()
	return self:getConfig("extra_squadron_num")
end

function GuildMission:GetSquadronRatio()
	return self:getConfig("extra_squedron_ratio") / 100
end

function GuildMission:GetOtherShips()
	local var_57_0 = getProxy(GuildProxy):getRawData()
	local var_57_1 = {}

	for iter_57_0, iter_57_1 in pairs(self.ships) do
		local var_57_2 = var_57_0:getMemberById(iter_57_1.userId)

		if var_57_2 then
			local var_57_4 = {
				id = iter_57_1.configId,
				skin = (iter_57_1.skin == 0 or nil) and pg.ship_data_statistics[iter_57_1.configId].skin_id
			}

			if var_57_2 then
				var_57_4.name = var_57_2.name or ""
			end

			table.insert(var_57_1, var_57_4)
		end
	end

	return var_57_1
end

function GuildMission:RecordFormationTip()
	local var_58_0 = self:GetCanFormationIndex()

	if var_58_0 > 0 then
		PlayerPrefs.SetInt("guild_mission_formation_tip" .. self.configId, var_58_0)
	end

	return
end

function GuildMission:ShouldShowFormationTip()
	return self.formationTipIndex < self:GetCanFormationIndex()
end

function GuildMission:FirstFleetCanFormation()
	return self:GetFleetCnt() == 0
end

function GuildMission:SameSquadron(arg_61_1)
	if self:IsEliteType() then
		return table.contains(arg_61_1.tagList, self:getConfig("extra_squadron"))
	end

	return false
end

function GuildMission:GetEffectAttr()
	local var_62_0 = self:getConfig("event_attr_count_effect")
	local var_62_1 = self:getConfig("event_attr_acc_effect")
	local var_62_2
	local var_62_3

	if #var_62_0 > 0 then
		var_62_2 = var_62_0[1][1]
		var_62_3 = var_62_0[1][2]
	end

	if #var_62_1 > 0 then
		var_62_2 = var_62_1[1][1]
	end

	return pg.attribute_info_by_type[var_62_2] and pg.attribute_info_by_type[var_62_2].name, var_62_3
end

function GuildMission:MatchAttr(arg_63_1)
	if self:IsEliteType() then
		local var_63_0, var_63_1 = self:GetEffectAttr()
		local var_63_2 = arg_63_1.attrs[var_63_0] or 0

		if var_63_1 then
			return var_63_1 <= var_63_2
		else
			return var_63_2 > 0
		end
	end

	return false
end

function GuildMission:MatchNation(arg_64_1)
	if self:IsEliteType() then
		return table.contains(self:GetRecommendShipNation(), arg_64_1.nation)
	end

	return false
end

function GuildMission:MatchShipType(arg_65_1)
	if self:IsEliteType() then
		return table.contains(self:GetRecommendShipTypes(), arg_65_1.type)
	end

	return false
end

return GuildMission
