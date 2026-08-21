local var_0_0 = class("GuildBossMissionFleet", import("...BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.fleet_id
	arg_1_0.userShips = {}
	arg_1_0.commanders = {}
	arg_1_0.invalidShips = {}
	arg_1_0.invalidCommanders = {}

	if arg_1_1.ships then
		arg_1_0:Flush(arg_1_1)
	end

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	arg_2_0.userShips = {}
	arg_2_0.invalidShips = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.ships) do
		if arg_2_0:IsValidShip({
			uid = iter_2_1.user_id,
			id = iter_2_1.ship_id
		}) then
			table.insert(arg_2_0.userShips, {
				uid = iter_2_1.user_id,
				id = iter_2_1.ship_id
			})
		else
			table.insert(arg_2_0.invalidShips, {
				uid = iter_2_1.user_id,
				id = iter_2_1.ship_id
			})
		end
	end

	local var_2_0 = getProxy(CommanderProxy):getData()

	for iter_2_2, iter_2_3 in pairs(arg_2_1.commanders) do
		if var_2_0[iter_2_3.id] and iter_2_3.pos then
			({})[iter_2_3.pos] = var_2_0[iter_2_3.id]
		else
			table.insert(arg_2_0.invalidCommanders, iter_2_3.id)
		end
	end

	arg_2_0:UpdateCommander({})

	return
end

function var_0_0.GetName(arg_3_0)
	if arg_3_0:IsMainFleet() then
		return i18n("ship_formationUI_fleetName11")
	else
		return i18n("ship_formationUI_fleetName1")
	end

	return
end

function var_0_0.ExistMember(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(GuildProxy):getRawData()

	return var_4_0 and var_4_0:getMemberById(arg_4_1)
end

function var_0_0.IsValidShip(arg_5_0, arg_5_1)
	return arg_5_0:ExistMember(arg_5_1.uid) and (function(arg_6_0)
		local var_6_9000
		local var_6_0 = getProxy(GuildProxy)
		local var_6_1 = var_6_0.getRawData(var_6_9000)
		local var_6_2 = getProxy(PlayerProxy):getRawData().id

		if var_6_0 == arg_6_0.uid then
			local var_6_3 = getProxy(BayProxy)

			return var_6_3:getShipById(arg_6_0.id) ~= nil
		end

		local var_6_4 = var_6_1:getMemberById(arg_6_0.uid):GetAssaultFleet()

		return (var_6_4:ExistShip((GuildAssaultFleet.GetVirtualId(arg_6_0.uid, arg_6_0.id))))
	end)(arg_5_1) and not (function(arg_7_0)
		return pg.ShipFlagMgr.GetInstance():GetShipFlag(arg_7_0.id, "inEvent")
	end)(arg_5_1)
end

function var_0_0.ExistInvailShips(arg_8_0)
	if #arg_8_0.invalidShips > 0 then
		return true
	end

	if _.any(arg_8_0.userShips, function(arg_9_0)
		return not arg_8_0:IsValidShip(arg_9_0)
	end) then
		return true
	end

	return false
end

function var_0_0.ClearInvalidShip(arg_10_0)
	arg_10_0.invalidShips = {}

	for iter_10_0 = #arg_10_0.userShips, 1, -1 do
		if not arg_10_0:IsValidShip(arg_10_0.userShips[iter_10_0]) then
			table.remove(arg_10_0.userShips, iter_10_0)
		end
	end

	return
end

function var_0_0.GetMyShipIds(arg_11_0)
	local var_11_0 = getProxy(PlayerProxy):getRawData().id

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.userShips) do
		if iter_11_1.uid == var_11_0 then
			table.insert({}, iter_11_1.id)
		end
	end

	return {}
end

function var_0_0.GetShipIds(arg_12_0)
	return arg_12_0.userShips
end

function var_0_0.GetShips(arg_13_0)
	local var_13_0 = getProxy(PlayerProxy):getData()
	local var_13_1 = getProxy(GuildProxy):getData()
	local var_13_2 = getProxy(BayProxy)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.userShips) do
		if var_13_0.id == iter_13_1.uid then
			local var_13_3 = var_13_2:getShipById(iter_13_1.id)

			if var_13_3 then
				var_13_3.id = GuildAssaultFleet.GetVirtualId(var_13_0.id, var_13_3.id)

				table.insert({}, {
					member = var_13_0,
					ship = GuildBossMissionShip.New(var_13_3)
				})
			end
		else
			local var_13_4 = var_13_1:getMemberById(iter_13_1.uid)
			local var_13_5 = var_13_4 and var_13_4:GetAssaultFleet()
			local var_13_6 = var_13_5 and var_13_5:GetShipByRealId(iter_13_1.uid, iter_13_1.id)

			if var_13_6 then
				table.insert({}, {
					member = var_13_4,
					ship = GuildBossMissionShip.New(var_13_6)
				})
			end
		end
	end

	return {}
end

function var_0_0.GetDownloadResShips(arg_14_0)
	local var_14_0 = getProxy(PlayerProxy):getRawData()

	for iter_14_0, iter_14_1 in pairs((arg_14_0:GetShips())) do
		if iter_14_1.member.id ~= var_14_0.id then
			table.insert({}, iter_14_1.ship:getPainting())
		end
	end

	return {}
end

function var_0_0.GetTeamTypeShips(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0:GetShips()) do
		if iter_15_1.ship:getTeamType() == arg_15_1 then
			table.insert({}, iter_15_1.ship)
		end
	end

	return {}
end

function var_0_0.ExistSubShip(arg_16_0)
	return #arg_16_0:GetTeamTypeShips(TeamType.Submarine) > 0
end

function var_0_0.RemoveAll(arg_17_0)
	arg_17_0.userShips = {}

	return
end

function var_0_0.IsMainFleet(arg_18_0)
	return arg_18_0.id == 1
end

function var_0_0.ExistUserShip(arg_19_0, arg_19_1)
	return _.any(arg_19_0.userShips, function(arg_20_0)
		return arg_20_0.uid == arg_19_1
	end)
end

function var_0_0.ContainShip(arg_21_0, arg_21_1, arg_21_2)
	return _.any(arg_21_0.userShips, function(arg_22_0)
		return arg_22_0.uid == arg_21_1 and arg_22_0.id == arg_21_2
	end)
end

function var_0_0.RemoveUserShip(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.userShips) do
		if iter_23_1.uid == arg_23_1 and iter_23_1.id == arg_23_2 then
			table.remove(arg_23_0.userShips, iter_23_0)

			return iter_23_0
		end
	end

	return
end

function var_0_0.AddUserShip(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_3 then
		table.insert(arg_24_0.userShips, arg_24_3, {
			uid = arg_24_1,
			id = arg_24_2
		})
	else
		table.insert(arg_24_0.userShips, {
			uid = arg_24_1,
			id = arg_24_2
		})
	end

	return
end

function var_0_0.GetOtherMemberShipCnt(arg_25_0, arg_25_1)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.userShips) do
		if iter_25_1.uid ~= arg_25_1 then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function var_0_0.ExistSameKindShip(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs((arg_26_0:GetShips())) do
		if iter_26_1.ship:isSameKind(arg_26_1) then
			return true
		end
	end

	return false
end

function var_0_0.IsLegal(arg_27_0)
	local var_27_0 = 0
	local var_27_1 = 0
	local var_27_2 = 0
	local var_27_3 = 0
	local var_27_4 = 0
	local var_27_5 = getProxy(PlayerProxy):getRawData().id

	for iter_27_0, iter_27_1 in ipairs((arg_27_0:GetShips())) do
		local var_27_6, var_27_7

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

			if iter_27_1.member.id == var_27_5 then
				var_27_6 = pg.ShipFlagMgr.GetInstance()
				var_27_7 = var_27_6
			end
		end

		if var_27_6:GetShipFlag(GuildAssaultFleet.GetRealId(iter_27_1.ship.id), "inEvent") then
			local var_27_9 = i18n("guild_boss_formation_exist_event_ship", iter_27_1.ship:getConfig("name"))

			return
		end
	end

	if var_27_0 > 3 or var_27_1 > 3 or var_27_2 > 3 then
		local var_27_11 = i18n("guild_boss_fleet_cnt_invalid")

		return
	end

	local var_27_12 = var_27_4 > 0 and var_27_3 > 0
	local var_27_13 = var_27_0 > 0 and var_27_1 > 0 and not var_27_12 and i18n("guild_boss_formation_not_exist_self_ship") or i18n("guild_fleet_is_legal")

	if arg_27_0:IsMainFleet() then
		return var_27_0 > 0 and var_27_1 > 0 and var_27_12, var_27_13
	else
		return true
	end

	return
end

function var_0_0.ResortShips(arg_28_0, arg_28_1)
	local function var_28_0(arg_29_0)
		local var_29_0 = GuildAssaultFleet.GetVirtualId(arg_29_0.uid, arg_29_0.id)

		for iter_29_0, iter_29_1 in ipairs(arg_28_1) do
			if var_29_0 == iter_29_1.shipId then
				return iter_29_0
			end
		end

		return 0
	end

	table.sort(arg_28_0.userShips, function(arg_30_0, arg_30_1)
		return var_28_0(arg_30_0) < var_28_0(arg_30_1)
	end)

	return
end

function var_0_0.UpdateCommander(arg_31_0, arg_31_1)
	arg_31_0.commanders = arg_31_1
	arg_31_0.skills = {}

	arg_31_0:updateCommanderSkills()

	return
end

function var_0_0.ClearCommanders(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.commanders) do
		arg_32_0:RemoveCommander(iter_32_0)
	end

	return
end

function var_0_0.getCommanders(arg_33_0)
	return arg_33_0.commanders
end

function var_0_0.AddCommander(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.commanders[arg_34_1] = arg_34_2
	arg_34_0.skills = {}

	arg_34_0:updateCommanderSkills()

	return
end

function var_0_0.RemoveCommander(arg_35_0, arg_35_1)
	arg_35_0.commanders[arg_35_1] = nil
	arg_35_0.skills = {}

	arg_35_0:updateCommanderSkills()

	return
end

function var_0_0.GetCommanderPos(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.commanders) do
		if iter_36_1.id == arg_36_1 then
			return iter_36_0
		end
	end

	return false
end

function var_0_0.updateCommanderSkills(arg_37_0)
	while #arg_37_0.skills > 0 do
		if not arg_37_0:findCommanderBySkillId(arg_37_0.skills[#arg_37_0.skills].id) and arg_37_0.skills[#arg_37_0.skills]:GetSystem() == FleetSkill.SystemCommanderNeko then
			table.remove(arg_37_0.skills, #arg_37_0.skills)
		end
	end

	for iter_37_0, iter_37_1 in pairs((arg_37_0:getCommanders())) do
		for iter_37_2, iter_37_3 in ipairs(iter_37_1:getSkills()) do
			for iter_37_4, iter_37_5 in ipairs(iter_37_3:getTacticSkill()) do
				table.insert(arg_37_0.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, iter_37_5))
			end
		end
	end

	return
end

function var_0_0.findSkills(arg_38_0, arg_38_1)
	return _.filter(arg_38_0:getSkills(), function(arg_39_0)
		return arg_39_0:GetType() == arg_38_1
	end)
end

function var_0_0.findCommanderBySkillId(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in pairs((arg_40_0:getCommanders())) do
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

function var_0_0.getSkills(arg_43_0)
	return arg_43_0.skills or {}
end

function var_0_0.getFleetType(arg_44_0)
	if arg_44_0.id == GuildBossMission.MAIN_FLEET_ID then
		return FleetType.Normal
	elseif arg_44_0.id == GuildBossMission.SUB_FLEET_ID then
		return FleetType.Submarine
	end

	assert(false, arg_44_0.id)

	return
end

function var_0_0.BuildBattleBuffList(arg_45_0)
	local var_45_0, var_45_1 = FleetSkill.GuildBossTriggerSkill(arg_45_0, FleetSkill.TypeBattleBuff)

	if var_45_0 and #var_45_0 > 0 then
		for iter_45_0, iter_45_1 in ipairs(var_45_0) do
			local var_45_2 = arg_45_0:findCommanderBySkillId(var_45_1[iter_45_0].id)
			local var_45_3 = ({})[var_45_2]

			if not ({})[var_45_2] then
				var_45_3 = {}
			end

			;({})[var_45_2] = var_45_3

			table.insert(({})[var_45_2], iter_45_1)
		end

		for iter_45_2, iter_45_3 in pairs({}) do
			table.insert({}, {
				iter_45_2,
				iter_45_3
			})
		end
	end

	for iter_45_4, iter_45_5 in pairs((arg_45_0:getCommanders())) do
		for iter_45_6, iter_45_7 in ipairs((iter_45_5:getTalents())) do
			local var_45_4 = iter_45_7:getBuffsAddition()

			if #var_45_4 > 0 then
				local var_45_5

				for iter_45_8, iter_45_9 in ipairs({}) do
					if iter_45_9[1] == iter_45_5 then
						var_45_5 = iter_45_9[2]

						break
					end
				end

				if not var_45_5 then
					var_45_5 = {}

					table.insert({}, {
						iter_45_5,
						{}
					})
				end

				for iter_45_10, iter_45_11 in ipairs(var_45_4) do
					table.insert(var_45_5, iter_45_11)
				end
			end
		end
	end

	return {}
end

function var_0_0.ExistCommander(arg_46_0, arg_46_1)
	for iter_46_0, iter_46_1 in pairs((arg_46_0:getCommanders())) do
		if iter_46_1.id == arg_46_1 then
			return true
		end
	end

	return false
end

function var_0_0.ExistInvalidCommanders(arg_47_0)
	local var_47_0

	if #arg_47_0.invalidCommanders > 0 then
		do return true end

		var_47_0 = getProxy(CommanderProxy)
	end

	for iter_47_0, iter_47_1 in pairs((arg_47_0:getCommanders())) do
		if not var_47_0:getCommanderById(iter_47_1.id) then
			return true
		end
	end

	return false
end

function var_0_0.RemoveInvalidCommanders(arg_48_0)
	local var_48_0 = getProxy(CommanderProxy)

	for iter_48_0, iter_48_1 in pairs((arg_48_0:getCommanders())) do
		if not var_48_0:getCommanderById(iter_48_1.id) then
			arg_48_0:RemoveCommander(iter_48_0)
		end
	end

	arg_48_0.invalidCommanders = {}

	return
end

function var_0_0.getCommandersAddition(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(CommanderConst.PROPERTIES) do
		local var_49_0 = 0

		for iter_49_2, iter_49_3 in pairs(arg_49_0:getCommanders()) do
			var_49_0 = var_49_0 + iter_49_3:getAbilitysAddition()[iter_49_1]
		end

		if var_49_0 > 0 then
			table.insert({}, {
				attrName = iter_49_1,
				value = var_49_0
			})
		end
	end

	return {}
end

function var_0_0.getCommandersTalentDesc(arg_50_0)
	for iter_50_0, iter_50_1 in pairs(arg_50_0:getCommanders()) do
		for iter_50_2, iter_50_3 in pairs((iter_50_1:getTalentsDesc())) do
			if ({})[iter_50_2] then
				({})[iter_50_2].value = ({})[iter_50_2].value + iter_50_3.value
			else
				({})[iter_50_2] = {
					name = iter_50_2,
					value = iter_50_3.value,
					type = iter_50_3.type
				}
			end
		end
	end

	return {}
end

function var_0_0.ExistAnyCommander(arg_51_0)
	return table.getCount((arg_51_0:getCommanders())) ~= 0
end

return var_0_0
