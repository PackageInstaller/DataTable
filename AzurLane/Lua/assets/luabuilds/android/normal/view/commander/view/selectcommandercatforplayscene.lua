class = var_0_10000

local var_0_0 = "SelectCommanderCatForPlayScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CommanderCatScene"))

function var_0_1.emit(arg_1_0, ...)
	unpack = var_1_10001

	if var_1_10001({
		...
	}) == var_0_1.ON_BACK then
		var_0_1.super.emit(arg_1_0, var_0_1.ON_CLOSE)
	else
		var_0_1.super.emit(arg_1_0, ...)
	end

	return
end

function var_0_1.didEnter(arg_2_0)
	local var_2_0 = arg_2_0.contextData.activeCommander

	arg_2_0.contextData.mode = var_0_1.MODE_SELECT
	arg_2_0.contextData.maxCount = 10

	local var_2_1 = arg_2_0.contextData

	CommanderCatScene = var_3
	var_2_1.fleetType = var_3.FLEET_TYPE_COMMON
	arg_2_0.contextData.activeGroupId = var_2_0.groupId

	local var_2_2 = arg_2_0.contextData

	var_2_2.ignoredIds = {}
	table = var_2_2

	var_2_2.insert(arg_2_0.contextData.ignoredIds, var_2_0.id)
	arg_2_0:CollectIgnoredIdsForPlay(arg_2_0.contextData.ignoredIds)

	function arg_2_0.contextData.onCommander(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_2_0

		return var_4.IsLegalForPlay(var_3_0, var_2_0, arg_3_0, arg_3_1, arg_3_2)
	end

	var_0_1.super.didEnter(arg_2_0)

	return
end

function var_0_1.RegisterEvent(arg_4_0)
	var_0_1.super.RegisterEvent(arg_4_0)

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.bind

	CommanderCatDockPage = var_1_10003

	var_4_1(var_4_0, var_1_10003.ON_SORT, function(arg_5_0)
		onNextTick = var_2_10001

		var_2_10001(function()
			local var_6_0 = arg_4_0.pages

			CommanderCatScene = var_3_10001

			if var_6_0[var_3_10001.PAGE_DOCK] and var_0:GetLoaded() then
				Clone = var_1

				local var_6_1 = var_1(var_0.sortData)

				if arg_4_0.contextData.OnSort then
					arg_4_0.contextData.OnSort(var_6_1)
				end
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.CollectIgnoredIdsForPlay(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	CommanderProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)
	local var_7_1 = var_2.getRawData(var_7_0)

	pairs = var_7_0

	for iter_7_0, iter_7_1 in var_7_0(var_7_1) do
		if iter_7_1:isLocked() then
			table = var_8

			var_8.insert(arg_7_1, iter_7_1.id)
		end
	end

	getProxy = var_3
	ChapterProxy = var_4

	local var_7_2 = var_3(var_4)

	if var_3.getActiveChapter(var_7_2) then
		_ = var_7_2

		var_7_2.each(var_3.fleets, function(arg_8_0)
			local var_8_0 = arg_8_0
			local var_8_1 = arg_8_0.getCommanders(var_8_0)

			pairs = var_8_0

			for iter_8_0, iter_8_1 in var_8_0(var_8_1) do
				table = var_2_10007

				var_2_10007.insert(arg_7_1, iter_8_1.id)
			end

			return
		end)
	end

	return
end

function var_0_1.IsLegalForPlay(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	nowWorld = var_1_10005

	local var_9_0 = var_1_10005()

	if var_5.CheckCommanderInFleet(var_9_0, arg_9_2.id) then
		local var_9_1 = false

		i18n = var_9_0

		local var_9_2 = var_9_0("commander_is_in_bigworld")

		return
	end

	local var_9_3 = arg_9_1
	local var_9_4

	if arg_9_1.isMaxLevel(var_9_3) then
		var_9_3 = arg_9_1

		if not arg_9_1.isSameGroup(var_9_3, arg_9_2.groupId) then
			var_9_4 = false
			i18n = var_9_3
			var_9_3 = var_9_3("commander_select_matiral_erro")

			return
		end
	end

	getProxy = var_9_4
	CommanderProxy = var_9_3

	local var_9_5 = var_9_4(var_9_3)

	if var_5.IsHome(var_9_5, arg_9_2.id) then
		local var_9_6 = false

		i18n = var_9_5

		local var_9_7 = var_9_5("cat_sleep_notplay")

		return
	end

	if not arg_9_0:CheckFormation(arg_9_2, arg_9_4, arg_9_3) then
		return false, nil
	end

	if not arg_9_0:CheckGuild(arg_9_2, arg_9_4, arg_9_3) then
		return false, nil
	end

	if not arg_9_0:CheckExtra(arg_9_2, arg_9_4, arg_9_3) then
		return false, nil
	end

	if not arg_9_0:CheckFullExp(arg_9_1, arg_9_2) then
		local var_9_8 = arg_9_1

		if not arg_9_1.isSameGroup(var_9_8, arg_9_2.groupId) then
			local var_9_9 = false

			i18n = var_9_8

			local var_9_10 = var_9_8("commander_exp_limit")

			return
		end
	end

	return true
end

function var_0_1.SimulateAddCommanderExp(arg_10_0, arg_10_1, arg_10_2)
	Clone = var_1_10003

	local var_10_0 = var_1_10003(arg_10_1)

	var_3.addExp(var_10_0, arg_10_2)

	return var_3, arg_10_1
end

function var_0_1.CheckFullExp(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = arg_11_0.pages

	CommanderCatScene = var_1_10005

	if var_11_1[var_1_10005.PAGE_DOCK] and var_4.selectedList then
		var_11_0 = var_4.selectedList
	end

	CommanderCatUtil = var_5

	local var_11_2, var_11_3 = var_5.GetSkillExpAndCommanderExp(arg_11_1, var_11_0)
	local var_11_4 = arg_11_0:SimulateAddCommanderExp(arg_11_1, var_11_2)

	if var_7.isMaxLevel(var_11_4) then
		return false
	end

	return true
end

function var_0_1.CheckFormation(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	getProxy = var_1_10004
	FleetProxy = var_1_10005

	local var_12_0 = var_1_10004(var_1_10005)
	local var_12_1 = var_4.getCommanders(var_12_0)

	_ = var_12_0

	if not var_12_0.detect(var_12_1, function(arg_13_0)
		return arg_12_1.id == arg_13_0.commanderId
	end) then
		return true
	end

	local var_12_2 = arg_12_0.contextData.msgBox
	local var_12_3 = var_7.ExecuteAction
	local var_12_4 = "Show"
	local var_12_5 = {}

	i18n = var_1_10011
	var_12_5.content = var_1_10011("commander_material_is_in_fleet_tip")

	function var_12_5.onYes()
		pg = var_2_10000

		local var_14_0 = var_2_10000.m02
		local var_14_1 = var_0.sendNotification

		GAME = var_2_10002

		var_14_1(var_14_0, var_2_10002.COOMMANDER_EQUIP_TO_FLEET, {
			commanderId = 0,
			fleetId = var_0.fleetId,
			pos = var_0.pos,
			callback = function()
				local var_15_0 = var_0

				var_12_1 = var_0.getCommanders(var_15_0)

				if arg_12_2 then
					arg_12_2()
				end

				return
			end
		})

		return
	end

	var_12_5.onNo = arg_12_3
	var_12_5.onClose = arg_12_3

	var_12_3(var_12_2, var_12_4, var_12_5)

	return false
end

function var_0_1.CheckGuild(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	getProxy = var_1_10004
	GuildProxy = var_1_10005

	local var_16_0 = var_1_10004(var_1_10005)

	if not var_4.getRawData(var_16_0) or not var_4:ExistCommander(arg_16_1.id) then
		return true
	end

	local var_16_1 = arg_16_0.contextData.msgBox
	local var_16_2 = var_5.ExecuteAction
	local var_16_3 = "Show"
	local var_16_4 = {}

	i18n = var_1_10009
	var_16_4.content = var_1_10009("commander_is_in_guild")

	function var_16_4.onYes()
		local var_17_0 = var_0

		if not var_0.GetActiveEvent(var_17_0) then
			return
		end

		if not var_0:GetBossMission() or not var_1:IsActive() then
			return
		end

		local var_17_1 = var_1

		if not var_1.GetFleetCommanderId(var_17_1, arg_16_1.id) then
			return
		end

		Clone = var_17_1

		local var_17_2 = var_17_1(var_2)

		if not var_3.GetCommanderPos(var_17_2, arg_16_1.id) then
			return
		end

		var_3:RemoveCommander(var_4)

		pg = var_5

		local var_17_3 = var_5.m02
		local var_17_4 = var_5.sendNotification

		GAME = var_7

		var_17_4(var_17_3, var_7.GUILD_UPDATE_BOSS_FORMATION, {
			force = true,
			editFleet = {
				[var_3.id] = var_3
			},
			callback = arg_16_2
		})

		return
	end

	var_16_4.onNo = arg_16_3
	var_16_4.onClose = arg_16_3

	var_16_2(var_16_1, var_16_3, var_16_4)

	return false
end

function var_0_1.CheckExtra(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	getProxy = var_1_10004
	FleetProxy = var_1_10005

	local var_18_0 = var_1_10004(var_1_10005)
	local var_18_1 = var_4.getCommanders(var_18_0)
	local var_18_2 = var_4
	local var_18_3 = var_4.GetExtraCommanders(var_18_2)

	_ = var_18_2

	if not var_18_2.detect(var_18_3, function(arg_19_0)
		return arg_18_1.id == arg_19_0.commanderId
	end) then
		return true
	end

	local var_18_4 = arg_18_0.contextData.msgBox
	local var_18_5 = var_8.ExecuteAction
	local var_18_6 = "Show"
	local var_18_7 = {}

	i18n = var_1_10012
	var_18_7.content = var_1_10012("commander_material_is_in_fleet_tip")

	function var_18_7.onYes()
		pg = var_2_10000

		local var_20_0 = var_2_10000.m02
		local var_20_1 = var_0.sendNotification

		GAME = var_2_10002

		var_20_1(var_20_0, var_2_10002.COOMMANDER_EQUIP_TO_FLEET, {
			commanderId = 0,
			fleetId = var_0.fleetId,
			pos = var_0.pos,
			callback = function()
				local var_21_0 = var_0

				var_18_1 = var_0.getCommanders(var_21_0)

				if arg_18_2 then
					arg_18_2()
				end

				return
			end
		})

		return
	end

	var_18_7.onNo = arg_18_3
	var_18_7.onClose = arg_18_3

	var_18_5(var_18_4, var_18_6, var_18_7)

	return false
end

return var_0_1
