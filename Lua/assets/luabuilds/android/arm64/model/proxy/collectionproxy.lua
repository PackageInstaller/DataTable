local var_0_0 = class("CollectionProxy", import(".NetProxy"))

var_0_0.AWARDS_UPDATE = "awards update"
var_0_0.GROUP_INFO_UPDATE = "group info update"
var_0_0.GROUP_EVALUATION_UPDATE = "group evaluation update"
var_0_0.TROPHY_UPDATE = "trophy update"
var_0_0.MAX_DAILY_EVA_COUNT = 1
var_0_0.KEY_17001_TIME_STAMP = "KEY_17001_TIME_STAMP"

function var_0_0.register(arg_1_0)
	arg_1_0.shipGroups = {}
	arg_1_0.awards = {}
	arg_1_0.trophy = {}
	arg_1_0.trophyGroup = {}
	arg_1_0.dailyEvaCount = 0

	arg_1_0:on(17001, function(arg_2_0)
		arg_1_0.shipGroups = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_info_list) do
			arg_1_0.shipGroups[iter_2_1.id] = ShipGroup.New(iter_2_1)
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.transform_list) do
			if arg_1_0.shipGroups[iter_2_3] then
				arg_1_0.shipGroups[iter_2_3].trans = true
			end
		end

		arg_1_0.awards = {}

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.ship_award_list) do
			table.sort(iter_2_5.award_index)

			arg_1_0.awards[iter_2_5.id] = iter_2_5.award_index[#iter_2_5.award_index]
		end

		for iter_2_6, iter_2_7 in ipairs(arg_2_0.progress_list) do
			arg_1_0.trophy[iter_2_7.id] = Trophy.New(iter_2_7)
		end

		arg_1_0:bindTrophyGroup()
		arg_1_0:bindComplexTrophy()
		arg_1_0:hiddenTrophyAutoClaim()
		arg_1_0:updateTrophy()

		return
	end)
	arg_1_0:on(17002, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.progress_list) do
			local var_3_0 = false
			local var_3_1 = iter_3_1.id

			if arg_1_0.trophy[iter_3_1.id] then
				local var_3_2 = arg_1_0.trophy[var_3_1]:canClaimed()

				arg_1_0.trophy[var_3_1]:update(iter_3_1)

				local var_3_3 = arg_1_0.trophy[var_3_1]:canClaimed()

				if not arg_1_0.trophy[var_3_1]:isHide() and var_3_2 ~= var_3_3 then
					var_3_0 = true
				end
			else
				arg_1_0.trophy[var_3_1] = Trophy.New(iter_3_1)

				if arg_1_0.trophy[var_3_1]:canClaimed() then
					var_3_0 = true
				end
			end

			if var_3_0 then
				arg_1_0:dispatchClaimRemind(var_3_1)
			end
		end

		arg_1_0:hiddenTrophyAutoClaim()
		arg_1_0:updateTrophy()

		return
	end)
	arg_1_0:on(17004, function(arg_4_0)
		arg_1_0.shipGroups[arg_4_0.ship_info.id] = ShipGroup.New(arg_4_0.ship_info)

		return
	end)

	return
end

function var_0_0.timeCall(arg_5_0)
	return {
		[ProxyRegister.DayCall] = function(arg_6_0)
			arg_5_0:resetEvaCount()

			return
		end
	}
end

function var_0_0.resetEvaCount(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.shipGroups) do
		if iter_7_1.evaluation then
			iter_7_1.evaluation.ievaCount = 0
		end
	end

	return
end

function var_0_0.updateDailyEvaCount(arg_8_0, arg_8_1)
	arg_8_0.dailyEvaCount = arg_8_1

	return
end

function var_0_0.updateAward(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.awards[arg_9_1] = arg_9_2

	arg_9_0:sendNotification(var_0_0.AWARDS_UPDATE, Clone(arg_9_0.awards))

	return
end

function var_0_0.getShipGroup(arg_10_0, arg_10_1)
	return Clone(arg_10_0.shipGroups[arg_10_1])
end

function var_0_0.updateShipGroup(arg_11_0, arg_11_1)
	assert(arg_11_1, "update ship group: group cannot be nil.")

	arg_11_0.shipGroups[arg_11_1.id] = Clone(arg_11_1)

	return
end

function var_0_0.getGroups(arg_12_0)
	return Clone(arg_12_0.shipGroups)
end

function var_0_0.RawgetGroups(arg_13_0)
	return arg_13_0.shipGroups
end

function var_0_0.getAwards(arg_14_0)
	return Clone(arg_14_0.awards)
end

function var_0_0.hasFinish(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(pg.storeup_data_template.all) do
		local var_15_0 = Favorite.New({
			id = iter_15_1
		})

		if var_15_0:canGetRes(arg_15_0.shipGroups, arg_15_0.awards) then
			return true
		end
	end

	return false
end

function var_0_0.getCollectionRate(arg_16_0)
	local var_16_0 = arg_16_0:getCollectionCount()
	local var_16_1 = arg_16_0:getCollectionTotal()

	return string.format("%0.3f", var_16_0 / var_16_1), var_16_0, var_16_1
end

function var_0_0.getCollectionCount(arg_17_0)
	return _.reduce(_.values(arg_17_0.shipGroups), 0, function(arg_18_0, arg_18_1)
		return arg_18_0 + (Nation.IsLinkType(arg_18_1:getNation()) and 0 or arg_18_1.trans and 2 or 1)
	end)
end

function var_0_0.getCollectionTotal(arg_19_0)
	return _.reduce(pg.ship_data_group.all, 0, function(arg_20_0, arg_20_1)
		return arg_20_0 + (Nation.IsLinkType(ShipGroup.getDefaultShipConfig(pg.ship_data_group[arg_20_1].group_type).nationality) and 0 or 1)
	end) + #pg.ship_data_trans.all
end

function var_0_0.getLinkCollectionCount(arg_21_0)
	return _.reduce(_.values(arg_21_0.shipGroups), 0, function(arg_22_0, arg_22_1)
		return arg_22_0 + (Nation.IsLinkType(arg_22_1:getNation()) and 1 or 0)
	end)
end

function var_0_0.flushCollection(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getShipGroup(arg_23_1.groupId)
	local var_23_1

	if not var_23_0 then
		var_23_0 = ShipGroup.New({
			heart_flag = 0,
			heart_count = 0,
			lv_max = 1,
			id = arg_23_1.groupId,
			star = arg_23_1:getStar(),
			marry_flag = arg_23_1.propose and 1 or 0,
			intimacy_max = arg_23_1.intimacy
		})

		if OPEN_TEC_TREE_SYSTEM and table.indexof(pg.fleet_tech_ship_template.all, arg_23_1.groupId, 1) then
			var_23_1 = true
		end
	else
		if OPEN_TEC_TREE_SYSTEM and table.indexof(pg.fleet_tech_ship_template.all, arg_23_1.groupId, 1) then
			if var_23_0.star < arg_23_1:getStar() and arg_23_1:getStar() == pg.fleet_tech_ship_template[arg_23_1.groupId].max_star then
				var_23_1 = true

				pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_TECPOINT, {
					point = pg.fleet_tech_ship_template[arg_23_1.groupId].pt_upgrage
				})
			end

			if var_23_0.maxLV < arg_23_1.level and arg_23_1.level == TechnologyConst.SHIP_LEVEL_FOR_BUFF then
				var_23_1 = true

				pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_TECPOINT, {
					point = pg.fleet_tech_ship_template[arg_23_1.groupId].pt_level,
					typeList = ShipType.FilterOverQuZhuType(pg.fleet_tech_ship_template[arg_23_1.groupId].add_level_shiptype),
					attr = pg.fleet_tech_ship_template[arg_23_1.groupId].add_level_attr,
					value = pg.fleet_tech_ship_template[arg_23_1.groupId].add_level_value
				})
			end
		end

		var_23_0.star = math.max(var_23_0.star, arg_23_1:getStar())
		var_23_0.maxIntimacy = math.max(var_23_0.maxIntimacy, arg_23_1.intimacy)
		var_23_0.married = math.max(var_23_0.married, arg_23_1.propose and 1 or 0)
		var_23_0.maxLV = math.max(var_23_0.maxLV, arg_23_1.level)
	end

	arg_23_0:updateShipGroup(var_23_0)

	if var_23_1 then
		getProxy(TechnologyNationProxy):flushData()
	end

	return
end

function var_0_0.updateTrophyClaim(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.trophy[arg_24_1]:updateTimeStamp(arg_24_2)

	return
end

function var_0_0.unlockNewTrophy(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		arg_25_0.trophy[iter_25_1.id] = iter_25_1
	end

	arg_25_0:bindTrophyGroup()
	arg_25_0:bindComplexTrophy()
	arg_25_0:hiddenTrophyAutoClaim()

	return
end

function var_0_0.getTrophyGroup(arg_26_0)
	return Clone(arg_26_0.trophyGroup)
end

function var_0_0.getTrophys(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.trophy) do
		iter_27_1:clearNew()
	end

	return (Clone(arg_27_0.trophy))
end

function var_0_0.GetTrophyById(arg_28_0, arg_28_1)
	return arg_28_0.trophy[arg_28_1]
end

function var_0_0.hiddenTrophyAutoClaim(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.trophy) do
		if iter_29_1:getHideType() ~= Trophy.ALWAYS_SHOW and iter_29_1:getHideType() ~= Trophy.COMING_SOON and iter_29_1:canClaimed() and not iter_29_1:isClaimed() then
			arg_29_0:sendNotification(GAME.TROPHY_CLAIM, {
				trophyID = iter_29_0
			})
		end
	end

	return
end

function var_0_0.unclaimTrophyCount(arg_30_0)
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in pairs(arg_30_0.trophy) do
		if iter_30_1:getHideType() == Trophy.ALWAYS_SHOW and iter_30_1:canClaimed() and not iter_30_1:isClaimed() then
			var_30_0 = var_30_0 + 1
		end
	end

	return var_30_0
end

function var_0_0.updateTrophy(arg_31_0)
	arg_31_0:sendNotification(var_0_0.TROPHY_UPDATE, Clone(arg_31_0.trophy))

	return
end

function var_0_0.dispatchClaimRemind(arg_32_0, arg_32_1)
	pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_TROPHY, {
		id = arg_32_1
	})

	return
end

function var_0_0.bindComplexTrophy(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.trophyGroup) do
		for iter_33_2, iter_33_3 in pairs((iter_33_1:getTrophyList())) do
			if iter_33_3:isComplexTrophy() then
				for iter_33_4, iter_33_5 in ipairs(iter_33_3:getTargetID()) do
					local var_33_0 = arg_33_0.trophy[iter_33_5] or Trophy.generateDummyTrophy(iter_33_5)

					iter_33_3:bindTrophys(var_33_0)
				end
			end
		end
	end

	return
end

function var_0_0.bindTrophyGroup(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(pg.medal_template.all) do
		if pg.medal_template[iter_34_1].hide == Trophy.ALWAYS_SHOW then
			local var_34_0 = math.floor(iter_34_1 / 10)

			arg_34_0.trophyGroup[var_34_0] = arg_34_0.trophyGroup[var_34_0] or TrophyGroup.New(var_34_0)

			if arg_34_0.trophy[iter_34_1] then
				var_34_1:addTrophy(arg_34_0.trophy[iter_34_1])
			else
				var_34_1:addDummyTrophy(iter_34_1)
			end
		end
	end

	for iter_34_2, iter_34_3 in pairs(arg_34_0.trophyGroup) do
		iter_34_3:sortGroup()
	end

	table.sort(arg_34_0.trophyGroup, function(arg_35_0, arg_35_1)
		return arg_35_0:getGroupID() < arg_35_1:getGroupID()
	end)

	return
end

return var_0_0
