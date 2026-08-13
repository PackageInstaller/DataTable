class = var_0_10000

local var_0_0 = "GuildBossMissionFleet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
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

function var_0_1.Flush(arg_2_0, arg_2_1)
	arg_2_0.userShips = {}
	arg_2_0.invalidShips = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.ships) do
		local var_2_0 = {
			uid = iter_2_1.user_id,
			id = iter_2_1.ship_id
		}

		var_1_10010 = arg_2_0

		if arg_2_0.IsValidShip(var_1_10010, var_2_0) then
			table = var_8

			var_8.insert(arg_2_0.userShips, var_2_0)
		else
			table = var_8

			var_8.insert(arg_2_0.invalidShips, var_2_0)
		end
	end

	getProxy = var_2
	CommanderProxy = var_4

	local var_2_1 = var_2(var_4)
	local var_2_2 = var_2.getData(var_2_1)
	local var_2_3 = {}

	pairs = var_2_1

	for iter_2_2, iter_2_3 in var_2_1(arg_2_1.commanders) do
		if var_2_2[iter_2_3.id] and iter_2_3.pos then
			var_2_3[iter_2_3.pos] = var_9
		else
			table = var_1_10010

			var_1_10010.insert(arg_2_0.invalidCommanders, iter_2_3.id)
		end
	end

	arg_2_0:UpdateCommander(var_2_3)

	return
end

function var_0_1.GetName(arg_3_0)
	if arg_3_0:IsMainFleet() then
		i18n = var_1

		return var_1("ship_formationUI_fleetName11")
	else
		i18n = var_1

		return var_1("ship_formationUI_fleetName1")
	end

	return
end

function var_0_1.ExistMember(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)

	return var_2.getRawData(var_4_0) and var_2:getMemberById(arg_4_1)
end

function var_0_1.IsValidShip(arg_5_0, arg_5_1)
	local function var_5_0(arg_6_0)
		getProxy = var_2_10001
		GuildProxy = var_2_10003

		local var_6_0 = var_2_10001(var_2_10003)
		local var_6_1 = var_1.getRawData(var_6_0)

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_6_2 = var_2_10002(var_2_10004)

		if var_2.getRawData(var_6_2).id == arg_6_0.uid then
			getProxy = var_3
			BayProxy = var_2_10005

			local var_6_3 = var_3(var_2_10005)

			return var_3.getShipById(var_6_3, arg_6_0.id) ~= nil
		end

		local var_6_4 = var_6_1
		local var_6_5 = var_6_1.getMemberById(var_6_4, arg_6_0.uid)
		local var_6_6 = var_3.GetAssaultFleet(var_6_5)

		GuildAssaultFleet = var_6_4

		local var_6_7 = var_6_4.GetVirtualId(arg_6_0.uid, arg_6_0.id)

		return (var_6_6:ExistShip(var_6_7))
	end

	local function var_5_1(arg_7_0)
		pg = var_2_10001

		local var_7_0 = var_2_10001.ShipFlagMgr.GetInstance()

		return var_1.GetShipFlag(var_7_0, arg_7_0.id, "inEvent")
	end

	local var_5_2

	if arg_5_0:ExistMember(arg_5_1.uid) and var_5_0(arg_5_1) then
		var_5_2 = not var_5_1(arg_5_1)
	end

	return var_5_2
end

function var_0_1.ExistInvailShips(arg_8_0)
	if #arg_8_0.invalidShips > 0 then
		return true
	end

	_ = var_1

	if var_1.any(arg_8_0.userShips, function(arg_9_0)
		local var_9_0 = arg_8_0

		return not var_1.IsValidShip(var_9_0, arg_9_0)
	end) then
		return true
	end

	return false
end

function var_0_1.ClearInvalidShip(arg_10_0)
	arg_10_0.invalidShips = {}

	for iter_10_0 = #arg_10_0.userShips, 1, -1 do
		local var_10_0 = arg_10_0.userShips[iter_10_0]

		if not arg_10_0:IsValidShip(var_10_0) then
			table = var_6

			var_6.remove(arg_10_0.userShips, iter_10_0)
		end
	end

	return
end

function var_0_1.GetMyShipIds(arg_11_0)
	local var_11_0 = {}

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_11_1 = var_1_10002(var_1_10004)
	local var_11_2 = var_2.getRawData(var_11_1).id

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.userShips) do
		if iter_11_1.uid == var_11_2 then
			table = var_8

			var_8.insert(var_11_0, iter_11_1.id)
		end
	end

	return var_11_0
end

function var_0_1.GetShipIds(arg_12_0)
	return arg_12_0.userShips
end

function var_0_1.GetShips(arg_13_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getData(var_13_0)

	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_13_2 = var_1_10002(var_1_10004)
	local var_13_3 = var_2.getData(var_13_2)

	getProxy = var_13_0
	BayProxy = var_1_10005

	local var_13_4 = var_13_0(var_1_10005)
	local var_13_5 = {}

	ipairs = var_1_10005

	for iter_13_0, iter_13_1 in var_1_10005(arg_13_0.userShips) do
		if var_13_1.id == iter_13_1.uid then
			local var_13_6 = var_13_4

			if var_13_4.getShipById(var_13_6, iter_13_1.id) then
				GuildAssaultFleet = var_11
				var_10.id = var_11.GetVirtualId(var_13_1.id, var_10.id)
				GuildBossMissionShip = var_11

				local var_13_7 = var_11.New(var_10)

				table = var_13_6

				var_13_6.insert(var_13_5, {
					member = var_13_1,
					ship = var_13_7
				})
			end
		else
			local var_13_8, var_13_9

			if var_13_3:getMemberById(iter_13_1.uid) then
				::label_13_0::

				var_13_8 = var_10
				var_13_9 = var_10.GetAssaultFleet(var_13_8)
			end

			local var_13_10

			if var_13_9 then
				::label_13_1::

				var_1_10014 = var_13_9
				var_13_10 = var_13_9.GetShipByRealId(var_1_10014, iter_13_1.uid, iter_13_1.id)
			end

			if var_13_10 then
				GuildBossMissionShip = var_13_8

				local var_13_11 = var_13_8.New(var_13_10)

				table = var_1_10014

				var_1_10014.insert(var_13_5, {
					member = var_10,
					ship = var_13_11
				})
			end
		end
	end

	return var_13_5
end

function var_0_1.GetDownloadResShips(arg_14_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)
	local var_14_1 = var_1.getRawData(var_14_0)
	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.GetShips(var_14_2)
	local var_14_4 = {}

	pairs = var_14_2

	for iter_14_0, iter_14_1 in var_14_2(var_14_3) do
		if iter_14_1.member.id ~= var_14_1.id then
			table = var_9

			local var_14_5 = var_9.insert
			local var_14_6 = var_14_4
			local var_14_7 = iter_14_1.ship

			var_14_5(var_14_6, var_12.getPainting(var_14_7))
		end
	end

	return var_14_4
end

function var_0_1.GetTeamTypeShips(arg_15_0, arg_15_1)
	local var_15_0 = {}

	ipairs = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10003(arg_15_0:GetShips()) do
		local var_15_1 = iter_15_1.ship

		if var_8.getTeamType(var_15_1) == arg_15_1 then
			table = var_9

			var_9.insert(var_15_0, var_8)
		end
	end

	return var_15_0
end

function var_0_1.ExistSubShip(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetTeamTypeShips

	TeamType = var_1_10004

	return #var_16_1(var_16_0, var_1_10004.Submarine) > 0
end

function var_0_1.RemoveAll(arg_17_0)
	arg_17_0.userShips = {}

	return
end

function var_0_1.IsMainFleet(arg_18_0)
	return arg_18_0.id == 1
end

function var_0_1.ExistUserShip(arg_19_0, arg_19_1)
	_ = var_1_10002

	return var_1_10002.any(arg_19_0.userShips, function(arg_20_0)
		return arg_20_0.uid == arg_19_1
	end)
end

function var_0_1.ContainShip(arg_21_0, arg_21_1, arg_21_2)
	_ = var_1_10003

	return var_1_10003.any(arg_21_0.userShips, function(arg_22_0)
		return arg_22_0.uid == arg_21_1 and arg_22_0.id == arg_21_2
	end)
end

function var_0_1.RemoveUserShip(arg_23_0, arg_23_1, arg_23_2)
	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(arg_23_0.userShips) do
		if iter_23_1.uid == arg_23_1 and iter_23_1.id == arg_23_2 then
			table = var_8

			var_8.remove(arg_23_0.userShips, iter_23_0)

			return iter_23_0
		end
	end

	return
end

function var_0_1.AddUserShip(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_3 then
		table = var_1_10004

		var_1_10004.insert(arg_24_0.userShips, arg_24_3, {
			uid = arg_24_1,
			id = arg_24_2
		})
	else
		table = var_1_10004

		var_1_10004.insert(arg_24_0.userShips, {
			uid = arg_24_1,
			id = arg_24_2
		})
	end

	return
end

function var_0_1.GetOtherMemberShipCnt(arg_25_0, arg_25_1)
	local var_25_0 = 0

	ipairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_0.userShips) do
		if iter_25_1.uid ~= arg_25_1 then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function var_0_1.ExistSameKindShip(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetShips()

	pairs = var_1_10003

	for iter_26_0, iter_26_1 in var_1_10003(var_26_0) do
		local var_26_1 = iter_26_1.ship

		if var_8.isSameKind(var_26_1, arg_26_1) then
			return true
		end
	end

	return false
end

function var_0_1.IsLegal(arg_27_0)
	local var_27_0 = arg_27_0:GetShips()
	local var_27_1 = 0
	local var_27_2 = 0
	local var_27_3 = 0
	local var_27_4 = 0
	local var_27_5 = 0
	local var_27_6 = 0

	getProxy = var_1_10008
	PlayerProxy = var_1_10010

	local var_27_7 = var_1_10008(var_1_10010)
	local var_27_8 = var_8.getRawData(var_27_7).id

	ipairs = var_1_10009

	for iter_27_0, iter_27_1 in var_1_10009(var_27_0) do
		if iter_27_1 then
			local var_27_9 = iter_27_1.ship

			var_1_10014 = var_1_10014.getTeamType(var_27_9)
			TeamType = var_1_10015

			if var_1_10014 == var_1_10015.Main then
				var_27_1 = var_27_1 + 1

				if iter_27_1.member.id == var_27_8 then
					var_27_4 = var_27_4 + 1
				end

				goto label_27_0
			end
		end

		if iter_27_1 then
			local var_27_10 = iter_27_1.ship

			var_1_10014 = var_1_10014.getTeamType(var_27_10)
			TeamType = var_1_10015

			if var_1_10014 == var_1_10015.Vanguard then
				var_27_2 = var_27_2 + 1

				if iter_27_1.member.id == var_27_8 then
					var_27_5 = var_27_5 + 1
				end

				goto label_27_0
			end
		end

		if iter_27_1 then
			local var_27_11 = iter_27_1.ship

			var_1_10014 = var_1_10014.getTeamType(var_27_11)
			TeamType = var_1_10015

			if var_1_10014 == var_1_10015.Submarine then
				var_27_3 = var_27_3 + 1

				if iter_27_1.member.id == var_27_8 then
					var_27_6 = var_27_6 + 1
				end
			end
		end

		::label_27_0::

		GuildAssaultFleet = var_1_10014
		var_1_10014 = var_1_10014.GetRealId(iter_27_1.ship.id)
		pg = var_1_10015

		local var_27_12 = var_1_10015.ShipFlagMgr.GetInstance()

		if var_1_10015.GetShipFlag(var_27_12, var_1_10014, "inEvent") then
			var_1_10015 = false
			i18n = var_16

			local var_27_13 = "guild_boss_formation_exist_event_ship"
			local var_27_14 = iter_27_1.ship
			local var_27_15 = var_16(var_27_13, var_19.getConfig(var_27_14, "name"))

			return
		end
	end

	if var_27_1 > 3 or var_27_2 > 3 or var_27_3 > 3 then
		local var_27_16 = false

		i18n = var_10

		local var_27_17 = var_10("guild_boss_fleet_cnt_invalid")

		return
	end

	local var_27_18 = var_27_5 > 0 and var_27_4 > 0
	local var_27_19

	if 0 < var_27_1 and 0 < var_27_2 and not var_27_18 then
		i18n = var_11
		var_27_19 = var_11("guild_boss_formation_not_exist_self_ship")
	else
		i18n = var_11
		var_27_19 = var_11("guild_fleet_is_legal")
	end

	if arg_27_0:IsMainFleet() then
		return var_27_1 > 0 and var_27_2 > 0 and var_27_18, var_27_19
	else
		return true
	end

	return
end

function var_0_1.ResortShips(arg_28_0, arg_28_1)
	local function var_28_0(arg_29_0)
		GuildAssaultFleet = var_2_10001

		local var_29_0 = var_2_10001.GetVirtualId(arg_29_0.uid, arg_29_0.id)

		ipairs = var_2_10002

		for iter_29_0, iter_29_1 in var_2_10002(arg_28_1) do
			if var_29_0 == iter_29_1.shipId then
				return iter_29_0
			end
		end

		return 0
	end

	table = var_1_10003

	var_1_10003.sort(arg_28_0.userShips, function(arg_30_0, arg_30_1)
		return var_28_0(arg_30_0) < var_28_0(arg_30_1)
	end)

	return
end

function var_0_1.UpdateCommander(arg_31_0, arg_31_1)
	arg_31_0.commanders = arg_31_1
	arg_31_0.skills = {}

	arg_31_0:updateCommanderSkills()

	return
end

function var_0_1.ClearCommanders(arg_32_0)
	pairs = var_1_10001

	for iter_32_0, iter_32_1 in var_1_10001(arg_32_0.commanders) do
		arg_32_0:RemoveCommander(iter_32_0)
	end

	return
end

function var_0_1.getCommanders(arg_33_0)
	return arg_33_0.commanders
end

function var_0_1.AddCommander(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.commanders[arg_34_1] = arg_34_2
	arg_34_0.skills = {}

	arg_34_0:updateCommanderSkills()

	return
end

function var_0_1.RemoveCommander(arg_35_0, arg_35_1)
	arg_35_0.commanders[arg_35_1] = nil
	arg_35_0.skills = {}

	arg_35_0:updateCommanderSkills()

	return
end

function var_0_1.GetCommanderPos(arg_36_0, arg_36_1)
	pairs = var_1_10002

	for iter_36_0, iter_36_1 in var_1_10002(arg_36_0.commanders) do
		if iter_36_1.id == arg_36_1 then
			return iter_36_0
		end
	end

	return false
end

function var_0_1.updateCommanderSkills(arg_37_0)
	local var_37_0 = #arg_37_0.skills

	while var_37_0 > 0 do
		local var_37_1 = arg_37_0.skills[var_37_0]
		local var_37_2 = arg_37_0

		if not arg_37_0.findCommanderBySkillId(var_37_2, var_37_1.id) then
			local var_37_3 = var_37_1:GetSystem()

			FleetSkill = var_37_2

			if var_37_3 == var_37_2.SystemCommanderNeko then
				table = var_37_3

				var_37_3.remove(arg_37_0.skills, var_37_0)
			end
		end

		var_37_0 = var_37_0 - 1
	end

	local var_37_4 = arg_37_0:getCommanders()

	pairs = var_1_10003

	for iter_37_0, iter_37_1 in var_1_10003(var_37_4) do
		ipairs = var_1_10008

		for iter_37_2, iter_37_3 in var_1_10008(iter_37_1:getSkills()) do
			ipairs = var_1_10013

			for iter_37_4, iter_37_5 in var_1_10013(iter_37_3:getTacticSkill()) do
				table = var_1_10018
				var_1_10018 = var_1_10018.insert

				local var_37_5 = arg_37_0.skills

				FleetSkill = var_1_10021
				var_1_10021 = var_1_10021.New
				FleetSkill = var_1_10023

				var_1_10018(var_37_5, var_1_10021(var_1_10023.SystemCommanderNeko, iter_37_5))
			end
		end
	end

	return
end

function var_0_1.findSkills(arg_38_0, arg_38_1)
	_ = var_1_10002

	return var_1_10002.filter(arg_38_0:getSkills(), function(arg_39_0)
		return arg_39_0:GetType() == arg_38_1
	end)
end

function var_0_1.findCommanderBySkillId(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getCommanders()

	pairs = var_1_10003

	for iter_40_0, iter_40_1 in var_1_10003(var_40_0) do
		_ = var_1_10008

		if var_1_10008.any(iter_40_1:getSkills(), function(arg_41_0)
			_ = var_2_10001

			return var_2_10001.any(arg_41_0:getTacticSkill(), function(arg_42_0)
				return arg_42_0 == arg_40_1
			end)
		end) then
			return iter_40_1
		end
	end

	return
end

function var_0_1.getSkills(arg_43_0)
	local var_43_0

	if not arg_43_0.skills then
		var_43_0 = {}
	end

	return var_43_0
end

function var_0_1.getFleetType(arg_44_0)
	local var_44_0 = arg_44_0.id

	GuildBossMission = var_1_10002

	if var_44_0 == var_1_10002.MAIN_FLEET_ID then
		FleetType = var_44_0

		return var_44_0.Normal
	else
		var_44_0 = arg_44_0.id
		GuildBossMission = var_2

		if var_44_0 == var_2.SUB_FLEET_ID then
			FleetType = var_44_0

			return var_44_0.Submarine
		end
	end

	assert = var_44_0

	var_44_0(false, arg_44_0.id)

	return
end

function var_0_1.BuildBattleBuffList(arg_45_0)
	local var_45_0 = {}

	FleetSkill = var_1_10002

	local var_45_1 = var_1_10002.GuildBossTriggerSkill
	local var_45_2 = arg_45_0

	FleetSkill = var_1_10005

	local var_45_3, var_45_4 = var_45_1(var_45_2, var_1_10005.TypeBattleBuff)

	if var_45_3 then
		local var_45_5 = #var_45_3

		if 0 < var_45_5 then
			local var_45_6 = {}

			ipairs = var_5

			for iter_45_0, iter_45_1 in var_5(var_45_3) do
				var_1_10010 = var_45_4[iter_45_0]

				local var_45_7

				if not var_45_6[arg_45_0:findCommanderBySkillId(var_1_10010.id)] then
					var_45_7 = {}
				end

				var_45_6[var_1_10011] = var_45_7
				table = var_45_7

				var_45_7.insert(var_45_6[var_1_10011], iter_45_1)
			end

			pairs = var_5

			for iter_45_2, iter_45_3 in var_5(var_45_6) do
				table = var_1_10010

				var_1_10010.insert(var_45_0, {
					iter_45_2,
					iter_45_3
				})
			end
		end
	end

	local var_45_8 = arg_45_0:getCommanders()

	pairs = var_5

	for iter_45_4, iter_45_5 in var_5(var_45_8) do
		local var_45_9 = iter_45_5:getTalents()

		ipairs = var_1_10011

		for iter_45_6, iter_45_7 in var_1_10011(var_45_9) do
			local var_45_10 = #iter_45_7:getBuffsAddition()

			if 0 < var_45_10 then
				local var_45_11

				ipairs = var_18

				for iter_45_8, iter_45_9 in var_18(var_45_0) do
					if iter_45_9[1] == iter_45_5 then
						var_45_11 = iter_45_9[2]

						break
					end
				end

				if not var_45_11 then
					var_45_11 = {}
					table = var_18

					var_18.insert(var_45_0, {
						iter_45_5,
						var_45_11
					})
				end

				ipairs = var_18

				for iter_45_10, iter_45_11 in var_18(var_16) do
					table = var_1_10023

					var_1_10023.insert(var_45_11, iter_45_11)
				end
			end
		end
	end

	return var_45_0
end

function var_0_1.ExistCommander(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:getCommanders()

	pairs = var_1_10003

	for iter_46_0, iter_46_1 in var_1_10003(var_46_0) do
		if iter_46_1.id == arg_46_1 then
			return true
		end
	end

	return false
end

function var_0_1.ExistInvalidCommanders(arg_47_0)
	local var_47_0 = #arg_47_0.invalidCommanders

	if 0 < var_47_0 then
		return true
	end

	local var_47_1 = arg_47_0
	local var_47_2 = arg_47_0.getCommanders(var_47_1)

	getProxy = var_2
	CommanderProxy = var_1_10004

	local var_47_3 = var_2(var_1_10004)

	pairs = var_47_1

	for iter_47_0, iter_47_1 in var_47_1(var_47_2) do
		if not var_47_3:getCommanderById(iter_47_1.id) then
			return true
		end
	end

	return false
end

function var_0_1.RemoveInvalidCommanders(arg_48_0)
	local var_48_0 = arg_48_0
	local var_48_1 = arg_48_0.getCommanders(var_48_0)

	getProxy = var_1_10002
	CommanderProxy = var_1_10004

	local var_48_2 = var_1_10002(var_1_10004)

	pairs = var_48_0

	for iter_48_0, iter_48_1 in var_48_0(var_48_1) do
		if not var_48_2:getCommanderById(iter_48_1.id) then
			arg_48_0:RemoveCommander(iter_48_0)
		end
	end

	arg_48_0.invalidCommanders = {}

	return
end

function var_0_1.getCommandersAddition(arg_49_0)
	local var_49_0 = {}

	pairs = var_1_10002
	CommanderConst = var_1_10004

	for iter_49_0, iter_49_1 in var_1_10002(var_1_10004.PROPERTIES) do
		local var_49_1 = 0

		pairs = var_1_10008

		for iter_49_2, iter_49_3 in var_1_10008(arg_49_0:getCommanders()) do
			var_49_1 = var_49_1 + iter_49_3:getAbilitysAddition()[iter_49_1]
		end

		if 0 < var_49_1 then
			table = var_1_10008

			var_1_10008.insert(var_49_0, {
				attrName = iter_49_1,
				value = var_49_1
			})
		end
	end

	return var_49_0
end

function var_0_1.getCommandersTalentDesc(arg_50_0)
	local var_50_0 = {}

	pairs = var_1_10002

	for iter_50_0, iter_50_1 in var_1_10002(arg_50_0:getCommanders()) do
		local var_50_1 = iter_50_1:getTalentsDesc()

		pairs = var_1_10008

		for iter_50_2, iter_50_3 in var_1_10008(var_50_1) do
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

function var_0_1.ExistAnyCommander(arg_51_0)
	local var_51_0 = arg_51_0:getCommanders()

	table = var_1_10002

	return var_1_10002.getCount(var_51_0) ~= 0
end

return var_0_1
