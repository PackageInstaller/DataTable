local GuildBossMissionFleet = class("GuildBossMissionFleet", import("...BaseVO"))

function GuildBossMissionFleet:Ctor(arg_1_1)
	self.id = arg_1_1.fleet_id
	self.userShips = {}
	self.commanders = {}
	self.invalidShips = {}
	self.invalidCommanders = {}

	if arg_1_1.ships then
		self:Flush(arg_1_1)
	end

	return
end

function GuildBossMissionFleet:Flush(arg_2_1)
	self.userShips = {}
	self.invalidShips = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.ships) do
		local var_2_0 = {
			uid = iter_2_1.user_id,
			id = iter_2_1.ship_id
		}

		if self:IsValidShip(var_2_0) then
			table.insert(self.userShips, var_2_0)
		else
			table.insert(self.invalidShips, var_2_0)
		end
	end

	local var_2_1 = getProxy(CommanderProxy):getData()
	local var_2_2 = {}

	for iter_2_2, iter_2_3 in pairs(arg_2_1.commanders) do
		if var_2_1[iter_2_3.id] and iter_2_3.pos then
			var_2_2[iter_2_3.pos] = var_2_1[iter_2_3.id]
		else
			table.insert(self.invalidCommanders, iter_2_3.id)
		end
	end

	self:UpdateCommander(var_2_2)

	return
end

function GuildBossMissionFleet:GetName()
	if self:IsMainFleet() then
		return i18n("ship_formationUI_fleetName11")
	else
		return i18n("ship_formationUI_fleetName1")
	end

	return
end

function GuildBossMissionFleet:ExistMember(arg_4_1)
	local var_4_0 = getProxy(GuildProxy):getRawData()

	return var_4_0 and var_4_0:getMemberById(arg_4_1)
end

function GuildBossMissionFleet:IsValidShip(arg_5_1)
	return self:ExistMember(arg_5_1.uid) and (function(arg_6_0)
		local var_6_0 = getProxy(GuildProxy)
		local var_6_1 = getProxy(PlayerProxy):getRawData().id

		if var_6_0 == arg_6_0.uid then
			return getProxy(BayProxy):getShipById(arg_6_0.id) ~= nil
		end

		return (var_6_0:getRawData():getMemberById(arg_6_0.uid):GetAssaultFleet():ExistShip((GuildAssaultFleet.GetVirtualId(arg_6_0.uid, arg_6_0.id))))
	end)(arg_5_1) and not (function(arg_7_0)
		return pg.ShipFlagMgr.GetInstance():GetShipFlag(arg_7_0.id, "inEvent")
	end)(arg_5_1)
end

function GuildBossMissionFleet:ExistInvailShips()
	if #self.invalidShips > 0 then
		return true
	end

	if _.any(self.userShips, function(arg_9_0)
		return not self:IsValidShip(arg_9_0)
	end) then
		return true
	end

	return false
end

function GuildBossMissionFleet:ClearInvalidShip()
	self.invalidShips = {}

	for iter_10_0 = #self.userShips, 1, -1 do
		if not self:IsValidShip(self.userShips[iter_10_0]) then
			table.remove(self.userShips, iter_10_0)
		end
	end

	return
end

function GuildBossMissionFleet:GetMyShipIds()
	local var_11_0 = {}
	local var_11_1 = getProxy(PlayerProxy):getRawData().id

	for iter_11_0, iter_11_1 in ipairs(self.userShips) do
		if iter_11_1.uid == var_11_1 then
			table.insert(var_11_0, iter_11_1.id)
		end
	end

	return var_11_0
end

function GuildBossMissionFleet:GetShipIds()
	return self.userShips
end

function GuildBossMissionFleet:GetShips()
	local var_13_0 = getProxy(PlayerProxy):getData()
	local var_13_1 = getProxy(GuildProxy):getData()
	local var_13_2 = getProxy(BayProxy)
	local var_13_3 = {}

	for iter_13_0, iter_13_1 in ipairs(self.userShips) do
		if var_13_0.id == iter_13_1.uid then
			local var_13_4 = var_13_2:getShipById(iter_13_1.id)

			if var_13_4 then
				var_13_4.id = GuildAssaultFleet.GetVirtualId(var_13_0.id, var_13_4.id)

				table.insert(var_13_3, {
					member = var_13_0,
					ship = GuildBossMissionShip.New(var_13_4)
				})
			end
		else
			local var_13_5 = var_13_1:getMemberById(iter_13_1.uid)
			local var_13_6 = var_13_5 and var_13_5:GetAssaultFleet()
			local var_13_7 = var_13_6 and var_13_6:GetShipByRealId(iter_13_1.uid, iter_13_1.id)

			if var_13_7 then
				table.insert(var_13_3, {
					member = var_13_5,
					ship = GuildBossMissionShip.New(var_13_7)
				})
			end
		end
	end

	return var_13_3
end

function GuildBossMissionFleet:GetDownloadResShips()
	local var_14_0 = getProxy(PlayerProxy):getRawData()
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs((self:GetShips())) do
		if iter_14_1.member.id ~= var_14_0.id then
			table.insert(var_14_1, iter_14_1.ship:getPainting())
		end
	end

	return var_14_1
end

function GuildBossMissionFleet:GetTeamTypeShips(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self:GetShips()) do
		if iter_15_1.ship:getTeamType() == arg_15_1 then
			table.insert(var_15_0, iter_15_1.ship)
		end
	end

	return var_15_0
end

function GuildBossMissionFleet:ExistSubShip()
	return #self:GetTeamTypeShips(TeamType.Submarine) > 0
end

function GuildBossMissionFleet:RemoveAll()
	self.userShips = {}

	return
end

function GuildBossMissionFleet:IsMainFleet()
	return self.id == 1
end

function GuildBossMissionFleet:ExistUserShip(arg_19_1)
	return _.any(self.userShips, function(arg_20_0)
		return arg_20_0.uid == arg_19_1
	end)
end

function GuildBossMissionFleet:ContainShip(arg_21_1, arg_21_2)
	return _.any(self.userShips, function(arg_22_0)
		return arg_22_0.uid == arg_21_1 and arg_22_0.id == arg_21_2
	end)
end

function GuildBossMissionFleet:RemoveUserShip(arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in ipairs(self.userShips) do
		if iter_23_1.uid == arg_23_1 and iter_23_1.id == arg_23_2 then
			table.remove(self.userShips, iter_23_0)

			return iter_23_0
		end
	end

	return
end

function GuildBossMissionFleet:AddUserShip(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_3 then
		table.insert(self.userShips, arg_24_3, {
			uid = arg_24_1,
			id = arg_24_2
		})
	else
		table.insert(self.userShips, {
			uid = arg_24_1,
			id = arg_24_2
		})
	end

	return
end

function GuildBossMissionFleet:GetOtherMemberShipCnt(arg_25_1)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(self.userShips) do
		if iter_25_1.uid ~= arg_25_1 then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function GuildBossMissionFleet:ExistSameKindShip(arg_26_1)
	for iter_26_0, iter_26_1 in pairs((self:GetShips())) do
		if iter_26_1.ship:isSameKind(arg_26_1) then
			return true
		end
	end

	return false
end

function GuildBossMissionFleet:IsLegal()
	local var_27_0 = 0
	local var_27_1 = 0
	local var_27_2 = 0
	local var_27_3 = 0
	local var_27_4 = 0
	local var_27_5 = getProxy(PlayerProxy):getRawData().id

	for iter_27_0, iter_27_1 in ipairs((self:GetShips())) do
		if iter_27_1 and iter_27_1.ship:getTeamType() == TeamType.Main then
			var_27_0 = var_27_0 + 1

			if iter_27_1.member.id == var_27_5 then
				var_27_3 = var_27_3 + 1
			end
		elseif iter_27_1 and iter_27_1.ship:getTeamType() == TeamType.Vanguard then
			var_27_1 = var_27_1 + 1

			if iter_27_1.member.id == var_27_5 then
				var_27_4 = var_27_4 + 1
			end
		elseif iter_27_1 and iter_27_1.ship:getTeamType() == TeamType.Submarine then
			var_27_2 = var_27_2 + 1

			local var_27_6

			if iter_27_1.member.id == var_27_5 then
				var_27_6 = pg.ShipFlagMgr.GetInstance()
			end
		end

		if var_27_6:GetShipFlag(GuildAssaultFleet.GetRealId(iter_27_1.ship.id), "inEvent") then
			local var_27_8 = i18n("guild_boss_formation_exist_event_ship", iter_27_1.ship:getConfig("name"))

			return
		end
	end

	if var_27_0 > 3 or var_27_1 > 3 or var_27_2 > 3 then
		local var_27_10 = i18n("guild_boss_fleet_cnt_invalid")

		return
	end

	local var_27_11 = var_27_4 > 0 and var_27_3 > 0

	if self:IsMainFleet() then
		return var_27_0 > 0 and var_27_1 > 0 and var_27_11, var_27_0 > 0 and var_27_1 > 0 and not var_27_11 and i18n("guild_boss_formation_not_exist_self_ship") or i18n("guild_fleet_is_legal")
	else
		return true
	end

	return
end

function GuildBossMissionFleet:ResortShips(arg_28_1)
	local function var_28_0(arg_29_0)
		local var_29_0 = GuildAssaultFleet.GetVirtualId(arg_29_0.uid, arg_29_0.id)

		for iter_29_0, iter_29_1 in ipairs(arg_28_1) do
			if var_29_0 == iter_29_1.shipId then
				return iter_29_0
			end
		end

		return 0
	end

	table.sort(self.userShips, function(arg_30_0, arg_30_1)
		return var_28_0(arg_30_0) < var_28_0(arg_30_1)
	end)

	return
end

function GuildBossMissionFleet:UpdateCommander(arg_31_1)
	self.commanders = arg_31_1
	self.skills = {}

	self:updateCommanderSkills()

	return
end

function GuildBossMissionFleet:ClearCommanders()
	for iter_32_0, iter_32_1 in pairs(self.commanders) do
		self:RemoveCommander(iter_32_0)
	end

	return
end

function GuildBossMissionFleet:getCommanders()
	return self.commanders
end

function GuildBossMissionFleet:AddCommander(arg_34_1, arg_34_2)
	self.commanders[arg_34_1] = arg_34_2
	self.skills = {}

	self:updateCommanderSkills()

	return
end

function GuildBossMissionFleet:RemoveCommander(arg_35_1)
	self.commanders[arg_35_1] = nil
	self.skills = {}

	self:updateCommanderSkills()

	return
end

function GuildBossMissionFleet:GetCommanderPos(arg_36_1)
	for iter_36_0, iter_36_1 in pairs(self.commanders) do
		if iter_36_1.id == arg_36_1 then
			return iter_36_0
		end
	end

	return false
end

function GuildBossMissionFleet:updateCommanderSkills()
	while #self.skills > 0 do
		if not self:findCommanderBySkillId(self.skills[#self.skills].id) and self.skills[#self.skills]:GetSystem() == FleetSkill.SystemCommanderNeko then
			table.remove(self.skills, #self.skills)
		end
	end

	for iter_37_0, iter_37_1 in pairs((self:getCommanders())) do
		for iter_37_2, iter_37_3 in ipairs(iter_37_1:getSkills()) do
			for iter_37_4, iter_37_5 in ipairs(iter_37_3:getTacticSkill()) do
				table.insert(self.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, iter_37_5))
			end
		end
	end

	return
end

function GuildBossMissionFleet:findSkills(arg_38_1)
	return _.filter(self:getSkills(), function(arg_39_0)
		return arg_39_0:GetType() == arg_38_1
	end)
end

function GuildBossMissionFleet:findCommanderBySkillId(arg_40_1)
	for iter_40_0, iter_40_1 in pairs((self:getCommanders())) do
		if _.any(iter_40_1:getSkills(), function(arg_41_0)
			return _.any(arg_41_0:getTacticSkill(), function(arg_42_0)
				return arg_42_0 == arg_40_1
			end)
		end) then
			return iter_40_1
		end
	end

	return
end

function GuildBossMissionFleet:getSkills()
	return self.skills or {}
end

function GuildBossMissionFleet:getFleetType()
	if self.id == GuildBossMission.MAIN_FLEET_ID then
		return FleetType.Normal
	elseif self.id == GuildBossMission.SUB_FLEET_ID then
		return FleetType.Submarine
	end

	assert(false, self.id)

	return
end

function GuildBossMissionFleet:BuildBattleBuffList()
	local var_45_0 = {}
	local var_45_1, var_45_2 = FleetSkill.GuildBossTriggerSkill(self, FleetSkill.TypeBattleBuff)

	if var_45_1 and #var_45_1 > 0 then
		local var_45_3 = {}

		for iter_45_0, iter_45_1 in ipairs(var_45_1) do
			local var_45_4 = self:findCommanderBySkillId(var_45_2[iter_45_0].id)

			var_45_3[var_45_4] = var_45_3[var_45_4] or {}

			table.insert(var_45_3[var_45_4], iter_45_1)
		end

		for iter_45_2, iter_45_3 in pairs(var_45_3) do
			table.insert(var_45_0, {
				iter_45_2,
				iter_45_3
			})
		end
	end

	for iter_45_4, iter_45_5 in pairs((self:getCommanders())) do
		for iter_45_6, iter_45_7 in ipairs((iter_45_5:getTalents())) do
			local var_45_5 = iter_45_7:getBuffsAddition()

			if #var_45_5 > 0 then
				local var_45_6

				for iter_45_8, iter_45_9 in ipairs(var_45_0) do
					if iter_45_9[1] == iter_45_5 then
						var_45_6 = iter_45_9[2]

						break
					end
				end

				if not var_45_6 then
					var_45_6 = {}

					table.insert(var_45_0, {
						iter_45_5,
						var_45_6
					})
				end

				for iter_45_10, iter_45_11 in ipairs(var_45_5) do
					table.insert(var_45_6, iter_45_11)
				end
			end
		end
	end

	return var_45_0
end

function GuildBossMissionFleet:ExistCommander(arg_46_1)
	for iter_46_0, iter_46_1 in pairs((self:getCommanders())) do
		if iter_46_1.id == arg_46_1 then
			return true
		end
	end

	return false
end

function GuildBossMissionFleet:ExistInvalidCommanders()
	local var_47_0

	if #self.invalidCommanders > 0 then
		do return true end

		var_47_0 = getProxy(CommanderProxy)
	end

	for iter_47_0, iter_47_1 in pairs((self:getCommanders())) do
		if not var_47_0:getCommanderById(iter_47_1.id) then
			return true
		end
	end

	return false
end

function GuildBossMissionFleet:RemoveInvalidCommanders()
	local var_48_0 = getProxy(CommanderProxy)

	for iter_48_0, iter_48_1 in pairs((self:getCommanders())) do
		if not var_48_0:getCommanderById(iter_48_1.id) then
			self:RemoveCommander(iter_48_0)
		end
	end

	self.invalidCommanders = {}

	return
end

function GuildBossMissionFleet:getCommandersAddition()
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in pairs(CommanderConst.PROPERTIES) do
		local var_49_1 = 0

		for iter_49_2, iter_49_3 in pairs(self:getCommanders()) do
			var_49_1 = var_49_1 + iter_49_3:getAbilitysAddition()[iter_49_1]
		end

		if var_49_1 > 0 then
			table.insert(var_49_0, {
				attrName = iter_49_1,
				value = var_49_1
			})
		end
	end

	return var_49_0
end

function GuildBossMissionFleet:getCommandersTalentDesc()
	local var_50_0 = {}

	for iter_50_0, iter_50_1 in pairs(self:getCommanders()) do
		for iter_50_2, iter_50_3 in pairs((iter_50_1:getTalentsDesc())) do
			if var_50_0[iter_50_2] then
				var_50_0[iter_50_2].value = var_50_0[iter_50_2].value + iter_50_3.value
			else
				var_50_0[iter_50_2] = {
					name = iter_50_2,
					value = iter_50_3.value,
					type = iter_50_3.type
				}
			end
		end
	end

	return var_50_0
end

function GuildBossMissionFleet:ExistAnyCommander()
	return table.getCount((self:getCommanders())) ~= 0
end

return GuildBossMissionFleet
