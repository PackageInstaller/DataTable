class = var_0_10000

local var_0_0 = "CollectionProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.AWARDS_UPDATE = "awards update"
var_0_1.GROUP_INFO_UPDATE = "group info update"
var_0_1.GROUP_EVALUATION_UPDATE = "group evaluation update"
var_0_1.TROPHY_UPDATE = "trophy update"
var_0_1.MAX_DAILY_EVA_COUNT = 1
var_0_1.KEY_17001_TIME_STAMP = "KEY_17001_TIME_STAMP"

function var_0_1.register(arg_1_0)
	arg_1_0.shipGroups = {}
	arg_1_0.awards = {}
	arg_1_0.trophy = {}
	arg_1_0.trophyGroup = {}
	arg_1_0.dailyEvaCount = 0

	arg_1_0:on(17001, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_2_0.shipGroups = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.ship_info_list) do
			var_2_10006 = arg_1_0.shipGroups

			local var_2_1 = iter_2_1.id

			ShipGroup = var_2_10008
			var_2_10006[var_2_1] = var_2_10008.New(iter_2_1)
		end

		ipairs = var_1

		for iter_2_2, iter_2_3 in var_1(arg_2_0.transform_list) do
			if arg_1_0.shipGroups[iter_2_3] then
				var_2_10006 = arg_1_0.shipGroups[iter_2_3]
				var_2_10006.trans = true
			end
		end

		local var_2_2 = arg_1_0

		var_2_2.awards = {}
		ipairs = var_2_2

		for iter_2_4, iter_2_5 in var_2_2(arg_2_0.ship_award_list) do
			table = var_2_10006

			var_2_10006.sort(iter_2_5.award_index)

			var_2_10006 = arg_1_0.awards
			var_2_10006[iter_2_5.id] = iter_2_5.award_index[#iter_2_5.award_index]
		end

		ipairs = var_1

		for iter_2_6, iter_2_7 in var_1(arg_2_0.progress_list) do
			local var_2_3 = arg_1_0.trophy
			local var_2_4 = iter_2_7.id

			Trophy = var_2_10008
			var_2_3[var_2_4] = var_2_10008.New(iter_2_7)
		end

		local var_2_5 = arg_1_0

		var_1.bindTrophyGroup(var_2_5)

		local var_2_6 = arg_1_0

		var_1.bindComplexTrophy(var_2_6)

		local var_2_7 = arg_1_0

		var_1.hiddenTrophyAutoClaim(var_2_7)

		local var_2_8 = arg_1_0

		var_1.updateTrophy(var_2_8)

		return
	end)
	arg_1_0:on(17002, function(arg_3_0)
		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_3_0.progress_list) do
			local var_3_0 = false
			local var_3_1 = iter_3_1.id

			if arg_1_0.trophy[var_3_1] then
				local var_3_2 = arg_1_0.trophy[var_3_1]

				var_2_10009 = var_8.canClaimed(var_3_2)

				var_8:update(iter_3_1)

				local var_3_3 = var_8:canClaimed()

				if not var_8:isHide() and var_2_10009 ~= var_3_3 then
					var_3_0 = true
				end
			else
				local var_3_4 = arg_1_0.trophy

				Trophy = var_2_10009
				var_3_4[var_3_1] = var_2_10009.New(iter_3_1)
				var_2_10009 = arg_1_0.trophy[var_3_1]

				if var_8.canClaimed(var_2_10009) then
					var_3_0 = true
				end
			end

			if var_3_0 then
				var_2_10009 = arg_1_0

				var_8.dispatchClaimRemind(var_2_10009, var_3_1)
			end
		end

		local var_3_5 = arg_1_0

		var_1.hiddenTrophyAutoClaim(var_3_5)

		local var_3_6 = arg_1_0

		var_1.updateTrophy(var_3_6)

		return
	end)
	arg_1_0:on(17004, function(arg_4_0)
		local var_4_0 = arg_4_0.ship_info
		local var_4_1 = arg_1_0.shipGroups
		local var_4_2 = var_4_0.id

		ShipGroup = var_2_10004
		var_4_1[var_4_2] = var_2_10004.New(var_4_0)

		return
	end)

	return
end

function var_0_1.timeCall(arg_5_0)
	local var_5_0 = {}

	ProxyRegister = var_1_10002
	var_5_0[var_1_10002.DayCall] = function(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.resetEvaCount(var_6_0)

		return
	end

	return var_5_0
end

function var_0_1.resetEvaCount(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.shipGroups) do
		if iter_7_1.evaluation then
			var_6.ievaCount = 0
		end
	end

	return
end

function var_0_1.updateDailyEvaCount(arg_8_0, arg_8_1)
	arg_8_0.dailyEvaCount = arg_8_1

	return
end

function var_0_1.updateAward(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.awards[arg_9_1] = arg_9_2

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.sendNotification
	local var_9_2 = var_0_1.AWARDS_UPDATE

	Clone = var_1_10006

	var_9_1(var_9_0, var_9_2, var_1_10006(arg_9_0.awards))

	return
end

function var_0_1.getShipGroup(arg_10_0, arg_10_1)
	Clone = var_1_10002

	return var_1_10002(arg_10_0.shipGroups[arg_10_1])
end

function var_0_1.updateShipGroup(arg_11_0, arg_11_1)
	assert = var_1_10002

	var_1_10002(arg_11_1, "update ship group: group cannot be nil.")

	local var_11_0 = arg_11_0.shipGroups
	local var_11_1 = arg_11_1.id

	Clone = var_4
	var_11_0[var_11_1] = var_4(arg_11_1)

	return
end

function var_0_1.getGroups(arg_12_0)
	Clone = var_1_10001

	return var_1_10001(arg_12_0.shipGroups)
end

function var_0_1.RawgetGroups(arg_13_0)
	return arg_13_0.shipGroups
end

function var_0_1.getAwards(arg_14_0)
	Clone = var_1_10001

	return var_1_10001(arg_14_0.awards)
end

function var_0_1.hasFinish(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.storeup_data_template

	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(var_15_0.all) do
		Favorite = var_1_10007

		local var_15_1 = var_1_10007.New({
			id = iter_15_1
		})

		if var_1_10007.canGetRes(var_15_1, arg_15_0.shipGroups, arg_15_0.awards) then
			return true
		end
	end

	return false
end

function var_0_1.getCollectionRate(arg_16_0)
	local var_16_0 = arg_16_0:getCollectionCount()
	local var_16_1 = arg_16_0
	local var_16_2 = arg_16_0.getCollectionTotal(var_16_1)

	string = var_16_1

	return var_16_1.format("%0.3f", var_16_0 / var_16_2), var_16_0, var_16_2
end

function var_0_1.getCollectionCount(arg_17_0)
	_ = var_1_10001

	local var_17_0 = var_1_10001.reduce

	_ = var_1_10002

	return var_17_0(var_1_10002.values(arg_17_0.shipGroups), 0, function(arg_18_0, arg_18_1)
		Nation = var_2_10002

		return arg_18_0 + (var_2_10002.IsLinkType(arg_18_1:getNation()) and 0 or arg_18_1.trans and 2 or 1)
	end)
end

function var_0_1.getCollectionTotal(arg_19_0)
	_ = var_1_10001

	local var_19_0 = var_1_10001.reduce

	pg = var_1_10002

	local var_19_1 = var_19_0(var_1_10002.ship_data_group.all, 0, function(arg_20_0, arg_20_1)
		pg = var_2_10002

		local var_20_0 = var_2_10002.ship_data_group[arg_20_1].group_type

		ShipGroup = var_2_10003

		local var_20_1 = var_2_10003.getDefaultShipConfig(var_20_0)

		Nation = var_4

		return arg_20_0 + (var_4.IsLinkType(var_20_1.nationality) and 0 or 1)
	end)

	pg = var_2

	return var_19_1 + #var_2.ship_data_trans.all
end

function var_0_1.getLinkCollectionCount(arg_21_0)
	_ = var_1_10001

	local var_21_0 = var_1_10001.reduce

	_ = var_1_10002

	return var_21_0(var_1_10002.values(arg_21_0.shipGroups), 0, function(arg_22_0, arg_22_1)
		Nation = var_2_10002

		return arg_22_0 + (var_2_10002.IsLinkType(arg_22_1:getNation()) and 1 or 0)
	end)
end

function var_0_1.flushCollection(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getShipGroup(arg_23_1.groupId)
	local var_23_1
	local var_23_2

	if not var_23_0 then
		ShipGroup = var_23_2
		var_23_0 = var_23_2.New({
			heart_flag = 0,
			heart_count = 0,
			lv_max = 1,
			id = arg_23_1.groupId,
			star = arg_23_1:getStar(),
			marry_flag = arg_23_1.propose and 1 or 0,
			intimacy_max = arg_23_1.intimacy
		})
		OPEN_TEC_TREE_SYSTEM = var_23_2

		if var_23_2 then
			table = var_23_2
			var_23_2 = var_23_2.indexof
			pg = var_1_10005

			if var_23_2(var_1_10005.fleet_tech_ship_template.all, arg_23_1.groupId, 1) then
				var_23_1 = true
			end
		end
	else
		OPEN_TEC_TREE_SYSTEM = var_23_2

		if var_23_2 then
			table = var_23_2
			var_23_2 = var_23_2.indexof
			pg = var_1_10005

			if var_23_2(var_1_10005.fleet_tech_ship_template.all, arg_23_1.groupId, 1) then
				var_23_2 = var_23_0.star

				local var_23_3 = arg_23_1

				if var_23_2 < arg_23_1.getStar(var_23_3) then
					local var_23_4 = arg_23_1

					var_23_2 = arg_23_1.getStar(var_23_4)
					pg = var_23_4

					if var_23_2 == var_23_4.fleet_tech_ship_template[arg_23_1.groupId].max_star then
						var_23_1 = true
						pg = var_23_2
						var_23_2 = var_23_2.fleet_tech_ship_template[arg_23_1.groupId].pt_upgrage
						pg = var_5
						var_23_3 = var_5.ToastMgr.GetInstance()

						local var_23_5 = var_5.ShowToast

						pg = var_7

						var_23_5(var_23_3, var_7.ToastMgr.TYPE_TECPOINT, {
							point = var_23_2
						})
					end
				end

				if var_23_0.maxLV < arg_23_1.level then
					var_23_2 = arg_23_1.level
					TechnologyConst = var_5

					if var_23_2 == var_5.SHIP_LEVEL_FOR_BUFF then
						var_23_1 = true
						pg = var_23_2
						var_23_2 = var_23_2.fleet_tech_ship_template[arg_23_1.groupId].pt_level
						ShipType = var_5

						local var_23_6 = var_5.FilterOverQuZhuType

						pg = var_23_3

						local var_23_7 = var_23_6(var_23_3.fleet_tech_ship_template[arg_23_1.groupId].add_level_shiptype)

						pg = var_6

						local var_23_8 = var_6.fleet_tech_ship_template[arg_23_1.groupId].add_level_attr

						pg = var_7

						local var_23_9 = var_7.fleet_tech_ship_template[arg_23_1.groupId].add_level_value

						pg = var_8

						local var_23_10 = var_8.ToastMgr.GetInstance()
						local var_23_11 = var_8.ShowToast

						pg = var_1_10010

						var_23_11(var_23_10, var_1_10010.ToastMgr.TYPE_TECPOINT, {
							point = var_23_2,
							typeList = var_23_7,
							attr = var_23_8,
							value = var_23_9
						})
					end
				end
			end
		end

		math = var_23_2
		var_23_0.star = var_23_2.max(var_23_0.star, arg_23_1:getStar())
		math = var_4
		var_23_0.maxIntimacy = var_4.max(var_23_0.maxIntimacy, arg_23_1.intimacy)
		math = var_4
		var_23_0.married = var_4.max(var_23_0.married, arg_23_1.propose and 1 or 0)
		math = var_4
		var_23_0.maxLV = var_4.max(var_23_0.maxLV, arg_23_1.level)
	end

	local var_23_12 = arg_23_0

	arg_23_0.updateShipGroup(var_23_12, var_23_0)

	if var_23_1 then
		getProxy = var_4
		TechnologyNationProxy = var_23_12

		local var_23_13 = var_4(var_23_12)

		var_4.flushData(var_23_13)
	end

	return
end

function var_0_1.updateTrophyClaim(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.trophy[arg_24_1]

	var_3.updateTimeStamp(var_24_0, arg_24_2)

	return
end

function var_0_1.unlockNewTrophy(arg_25_0, arg_25_1)
	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_1) do
		arg_25_0.trophy[iter_25_1.id] = iter_25_1
	end

	arg_25_0:bindTrophyGroup()
	arg_25_0:bindComplexTrophy()
	arg_25_0:hiddenTrophyAutoClaim()

	return
end

function var_0_1.getTrophyGroup(arg_26_0)
	Clone = var_1_10001

	return var_1_10001(arg_26_0.trophyGroup)
end

function var_0_1.getTrophys(arg_27_0)
	Clone = var_1_10001

	local var_27_0 = var_1_10001(arg_27_0.trophy)

	pairs = var_2

	for iter_27_0, iter_27_1 in var_2(arg_27_0.trophy) do
		iter_27_1:clearNew()
	end

	return var_27_0
end

function var_0_1.GetTrophyById(arg_28_0, arg_28_1)
	return arg_28_0.trophy[arg_28_1]
end

function var_0_1.hiddenTrophyAutoClaim(arg_29_0)
	pairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.trophy) do
		local var_29_0 = iter_29_1
		local var_29_1 = iter_29_1.getHideType(var_29_0)

		Trophy = var_29_0

		if var_29_1 ~= var_29_0.ALWAYS_SHOW then
			local var_29_2 = iter_29_1
			local var_29_3 = iter_29_1.getHideType(var_29_2)

			Trophy = var_29_2

			if var_29_3 ~= var_29_2.COMING_SOON and iter_29_1:canClaimed() and not iter_29_1:isClaimed() then
				local var_29_4 = arg_29_0
				local var_29_5 = arg_29_0.sendNotification

				GAME = var_1_10008

				var_29_5(var_29_4, var_1_10008.TROPHY_CLAIM, {
					trophyID = iter_29_0
				})
			end
		end
	end

	return
end

function var_0_1.unclaimTrophyCount(arg_30_0)
	local var_30_0 = 0

	pairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(arg_30_0.trophy) do
		local var_30_1 = iter_30_1
		local var_30_2 = iter_30_1.getHideType(var_30_1)

		Trophy = var_30_1

		if var_30_2 == var_30_1.ALWAYS_SHOW and iter_30_1:canClaimed() and not iter_30_1:isClaimed() then
			var_30_0 = var_30_0 + 1
		end
	end

	return var_30_0
end

function var_0_1.updateTrophy(arg_31_0)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.sendNotification
	local var_31_2 = var_0_1.TROPHY_UPDATE

	Clone = var_1_10004

	var_31_1(var_31_0, var_31_2, var_1_10004(arg_31_0.trophy))

	return
end

function var_0_1.dispatchClaimRemind(arg_32_0, arg_32_1)
	pg = var_1_10002

	local var_32_0 = var_1_10002.ToastMgr.GetInstance()
	local var_32_1 = var_2.ShowToast

	pg = var_1_10004

	var_32_1(var_32_0, var_1_10004.ToastMgr.TYPE_TROPHY, {
		id = arg_32_1
	})

	return
end

function var_0_1.bindComplexTrophy(arg_33_0)
	pairs = var_1_10001

	for iter_33_0, iter_33_1 in var_1_10001(arg_33_0.trophyGroup) do
		local var_33_0 = iter_33_1
		local var_33_1 = iter_33_1.getTrophyList(var_33_0)

		pairs = var_33_0

		for iter_33_2, iter_33_3 in var_33_0(var_33_1) do
			if iter_33_3:isComplexTrophy() then
				ipairs = var_12

				for iter_33_4, iter_33_5 in var_12(iter_33_3:getTargetID()) do
					local var_33_2

					if not arg_33_0.trophy[iter_33_5] then
						Trophy = var_33_2
						var_33_2 = var_33_2.generateDummyTrophy(iter_33_5)
					end

					iter_33_3:bindTrophys(var_33_2)
				end
			end
		end
	end

	return
end

function var_0_1.bindTrophyGroup(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.medal_template

	ipairs = var_1_10002

	for iter_34_0, iter_34_1 in var_1_10002(var_34_0.all) do
		local var_34_1 = var_34_0[iter_34_1].hide

		Trophy = var_1_10009

		if var_34_1 == var_1_10009.ALWAYS_SHOW then
			math = var_34_1

			local var_34_2 = var_34_1.floor(iter_34_1 / 10)

			if not arg_34_0.trophyGroup[var_34_2] then
				var_1_10009 = arg_34_0.trophyGroup
				TrophyGroup = var_1_10010
				var_1_10009[var_34_2] = var_1_10010.New(var_34_2)
			end

			var_1_10009 = arg_34_0.trophyGroup[var_34_2]

			if arg_34_0.trophy[iter_34_1] then
				var_1_10009:addTrophy(arg_34_0.trophy[iter_34_1])
			else
				var_1_10009:addDummyTrophy(iter_34_1)
			end
		end
	end

	pairs = var_2

	for iter_34_2, iter_34_3 in var_2(arg_34_0.trophyGroup) do
		iter_34_3:sortGroup()
	end

	table = var_2

	var_2.sort(arg_34_0.trophyGroup, function(arg_35_0, arg_35_1)
		return arg_35_0:getGroupID() < arg_35_1:getGroupID()
	end)

	return
end

return var_0_1
