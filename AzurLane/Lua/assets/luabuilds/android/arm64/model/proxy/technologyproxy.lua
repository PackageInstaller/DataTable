local var_0_0 = class("TechnologyProxy", import(".NetProxy"))

var_0_0.TECHNOLOGY_UPDATED = "TechnologyProxy:TECHNOLOGY_UPDATED"
var_0_0.BLUEPRINT_ADDED = "TechnologyProxy:BLUEPRINT_ADDED"
var_0_0.BLUEPRINT_UPDATED = "TechnologyProxy:BLUEPRINT_UPDATED"
var_0_0.REFRESH_UPDATED = "TechnologyProxy:REFRESH_UPDATED"

function var_0_0.register(arg_1_0)
	arg_1_0.tendency = {}

	arg_1_0:on(24, function(arg_2_0)
		arg_1_0:updateTechnologys(arg_2_0.refresh_list)

		arg_1_0.refreshTechnologysFlag = arg_2_0.refresh_flag

		arg_1_0:updateTecCatchup(arg_2_0.catchup)
		arg_1_0:updateTechnologyQueue(arg_2_0.queue)

		return
	end)

	arg_1_0.bluePrintData = {}
	arg_1_0.item2blueprint = {}
	arg_1_0.maxConfigVersion = 0

	_.each(pg.ship_data_blueprint.all, function(arg_3_0)
		local var_3_0 = ShipBluePrint.New({
			id = arg_3_0
		})

		arg_1_0.maxConfigVersion = math.max(arg_1_0.maxConfigVersion, var_3_0:getConfig("blueprint_version"))
		arg_1_0.bluePrintData[var_3_0.id] = var_3_0
		arg_1_0.item2blueprint[var_3_0:getItemId()] = var_3_0.id

		return
	end)
	arg_1_0:on(63100, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.blueprint_list) do
			assert(arg_1_0.bluePrintData[iter_4_1.id], "miss config ship_data_blueprint>>>>>>>>" .. iter_4_1.id)
			arg_1_0.bluePrintData[iter_4_1.id]:updateInfo(iter_4_1)
		end

		arg_1_0.coldTime = arg_4_0.cold_time or 0
		arg_1_0.pursuingTimes = arg_4_0.daily_catchup_strengthen or 0
		arg_1_0.pursuingTimesUR = arg_4_0.daily_catchup_strengthen_ur or 0

		return
	end)

	return
end

function var_0_0.timeCall(arg_5_0)
	return {
		[ProxyRegister.DayCall] = function(arg_6_0)
			arg_5_0:updateRefreshFlag(0)

			return
		end,
		[ProxyRegister.HourCall] = function(arg_7_0)
			if arg_7_0 == 4 then
				arg_5_0:resetPursuingTimes()
			end

			return
		end
	}
end

function var_0_0.setVersion(arg_8_0, arg_8_1)
	PlayerPrefs.SetInt("technology_version", arg_8_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.getVersion(arg_9_0)
	if not PlayerPrefs.HasKey("technology_version") then
		arg_9_0:setVersion(1)

		return 1
	else
		return PlayerPrefs.GetInt("technology_version")
	end

	return
end

function var_0_0.getConfigMaxVersion(arg_10_0)
	return arg_10_0.maxConfigVersion
end

function var_0_0.setTendency(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.tendency[arg_11_1] = arg_11_2

	return
end

function var_0_0.getTendency(arg_12_0, arg_12_1)
	return arg_12_0.tendency[arg_12_1]
end

function var_0_0.updateBlueprintStates(arg_13_0)
	local var_13_0 = arg_13_0.bluePrintData or {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		iter_13_1:updateState()
	end

	return
end

function var_0_0.getColdTime(arg_14_0)
	return arg_14_0.coldTime
end

function var_0_0.updateColdTime(arg_15_0)
	arg_15_0.coldTime = pg.TimeMgr.GetInstance():GetServerTime() + 0

	return
end

function var_0_0.updateRefreshFlag(arg_16_0, arg_16_1)
	arg_16_0.refreshTechnologysFlag = arg_16_1

	arg_16_0:sendNotification(var_0_0.REFRESH_UPDATED, arg_16_0.refreshTechnologysFlag)

	return
end

function var_0_0.updateTechnologys(arg_17_0, arg_17_1)
	arg_17_0.data = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		arg_17_0.tendency[iter_17_1.id] = iter_17_1.target

		for iter_17_2, iter_17_3 in ipairs(iter_17_1.technologys) do
			arg_17_0.data[iter_17_3.id] = Technology.New({
				id = iter_17_3.id,
				time = iter_17_3.time,
				pool_id = iter_17_1.id
			})
		end
	end

	return
end

function var_0_0.updateTecCatchup(arg_18_0, arg_18_1)
	arg_18_0.curCatchupTecID = arg_18_1.version
	arg_18_0.curCatchupGroupID = arg_18_1.target
	arg_18_0.catchupData = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.pursuings) do
		local var_18_0 = TechnologyCatchup.New(iter_18_1)

		arg_18_0.catchupData[var_18_0.id] = var_18_0
	end

	arg_18_0.curCatchupPrintsNum = arg_18_0:getCurCatchNum()

	print("初始下发的科研追赶信息", arg_18_0.curCatchupTecID, arg_18_0.curCatchupGroupID, arg_18_0.curCatchupPrintsNum)

	return
end

function var_0_0.updateTechnologyQueue(arg_19_0, arg_19_1)
	arg_19_0.queue = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		table.insert(arg_19_0.queue, Technology.New({
			queue = true,
			id = iter_19_1.id,
			time = iter_19_1.time
		}))
	end

	table.sort(arg_19_0.queue, function(arg_20_0, arg_20_1)
		return arg_20_0.time < arg_20_1.time
	end)

	return
end

function var_0_0.moveTechnologyToQueue(arg_21_0, arg_21_1)
	arg_21_0.data[arg_21_1].inQueue = true

	table.insert(arg_21_0.queue, arg_21_0.data[arg_21_1])

	arg_21_0.data[arg_21_1] = nil

	return
end

function var_0_0.removeFirstQueueTechnology(arg_22_0)
	assert(#arg_22_0.queue > 0)
	table.remove(arg_22_0.queue, 1)

	return
end

function var_0_0.getActivateTechnology(arg_23_0)
	local var_23_0 = arg_23_0.data or {}

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if iter_23_1:isActivate() then
			return Clone(iter_23_1)
		end
	end

	return
end

function var_0_0.getTechnologyById(arg_24_0, arg_24_1)
	assert(arg_24_0.data[arg_24_1], "technology should exist>>" .. arg_24_1)

	return arg_24_0.data[arg_24_1]:clone()
end

function var_0_0.updateTechnology(arg_25_0, arg_25_1)
	assert(arg_25_0.data[arg_25_1.id], "technology should exist>>" .. arg_25_1.id)
	assert(isa(arg_25_1, Technology), "technology should be instance of Technology")

	arg_25_0.data[arg_25_1.id] = arg_25_1

	arg_25_0:sendNotification(var_0_0.TECHNOLOGY_UPDATED, arg_25_1:clone())

	return
end

function var_0_0.getTechnologys(arg_26_0)
	return underscore.values(arg_26_0.data)
end

function var_0_0.getPlanningTechnologys(arg_27_0)
	return table.mergeArray(arg_27_0.queue, {
		arg_27_0:getActivateTechnology()
	})
end

function var_0_0.getBluePrints(arg_28_0)
	return Clone(arg_28_0.bluePrintData)
end

function var_0_0.getBluePrintById(arg_29_0, arg_29_1)
	return Clone(arg_29_0.bluePrintData[arg_29_1])
end

function var_0_0.getRawBluePrintById(arg_30_0, arg_30_1)
	return arg_30_0.bluePrintData[arg_30_1]
end

function var_0_0.addBluePrint(arg_31_0, arg_31_1)
	assert(isa(arg_31_1, ShipBluePrint), "bluePrint should be instance of ShipBluePrint")
	assert(arg_31_0.bluePrintData[arg_31_1.id] == nil, "use function updateBluePrint instead")

	arg_31_0.bluePrintData[arg_31_1.id] = arg_31_1

	arg_31_0:sendNotification(var_0_0.BLUEPRINT_ADDED, arg_31_1:clone())

	return
end

function var_0_0.updateBluePrint(arg_32_0, arg_32_1)
	assert(isa(arg_32_1, ShipBluePrint), "bluePrint should be instance of ShipBluePrint")
	assert(arg_32_0.bluePrintData[arg_32_1.id], "use function addBluePrint instead")

	arg_32_0.bluePrintData[arg_32_1.id] = arg_32_1

	arg_32_0:sendNotification(var_0_0.BLUEPRINT_UPDATED, arg_32_1:clone())

	return
end

function var_0_0.getBuildingBluePrint(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.bluePrintData) do
		if iter_33_1:isDeving() or iter_33_1:isFinished() then
			return iter_33_1
		end
	end

	return
end

function var_0_0.getAllBluePrintShipIds(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.bluePrintData) do
		if iter_34_1:isFetched() then
			table.insert({}, iter_34_1.shipId)
		end
	end

	return {}
end

function var_0_0.GetBlueprint4Item(arg_35_0, arg_35_1)
	return arg_35_0.item2blueprint[arg_35_1]
end

function var_0_0.updatePhantomQuestProgress(arg_36_0, arg_36_1, arg_36_2)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.bluePrintData) do
		if iter_36_1:isFetched() and arg_36_2[iter_36_1.shipId] then
			iter_36_1:setPhantomQuestProgress(arg_36_1, arg_36_2[iter_36_1.shipId])
		end
	end

	return
end

function var_0_0.getCatchupData(arg_37_0, arg_37_1)
	arg_37_0.catchupData[arg_37_1] = arg_37_0.catchupData[arg_37_1] or TechnologyCatchup.New({
		version = arg_37_1
	})

	return arg_37_0.catchupData[arg_37_1]
end

function var_0_0.updateCatchupData(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_0.catchupData[arg_38_1]:addTargetNum(arg_38_2, arg_38_3)

	return
end

function var_0_0.getCurCatchNum(arg_39_0)
	if arg_39_0.curCatchupTecID ~= 0 and arg_39_0.curCatchupGroupID ~= 0 then
		return arg_39_0.catchupData[arg_39_0.curCatchupTecID]:getTargetNum(arg_39_0.curCatchupGroupID)
	else
		return 0
	end

	return
end

function var_0_0.getCatchupState(arg_40_0, arg_40_1)
	if not arg_40_0.catchupData[arg_40_1] then
		return TechnologyCatchup.STATE_UNSELECT
	end

	return arg_40_0.catchupData[arg_40_1]:getState()
end

function var_0_0.updateCatchupStates(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0.catchupData) do
		iter_41_1:updateState()
	end

	return
end

function var_0_0.isOpenTargetCatchup(arg_42_0)
	return pg.technology_catchup_template ~= nil and #pg.technology_catchup_template.all > 0
end

function var_0_0.getNewestCatchupTecID(arg_43_0)
	return math.max(unpack(pg.technology_catchup_template.all))
end

function var_0_0.isOnCatchup(arg_44_0)
	return arg_44_0.curCatchupTecID ~= 0 and arg_44_0.curCatchupGroupID ~= 0
end

function var_0_0.getBluePrintVOByGroupID(arg_45_0, arg_45_1)
	return arg_45_0.bluePrintData[arg_45_1]
end

function var_0_0.getCurCatchupTecInfo(arg_46_0)
	return {
		tecID = arg_46_0.curCatchupTecID,
		groupID = arg_46_0.curCatchupGroupID,
		printNum = arg_46_0.curCatchupPrintsNum
	}
end

function var_0_0.setCurCatchupTecInfo(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0.curCatchupTecID = arg_47_1
	arg_47_0.curCatchupGroupID = arg_47_2
	arg_47_0.curCatchupPrintsNum = arg_47_0:getCurCatchNum()

	arg_47_0:updateCatchupStates()
	print("设置后的科研追赶信息", arg_47_0.curCatchupTecID, arg_47_0.curCatchupGroupID, arg_47_0.curCatchupPrintsNum)

	return
end

function var_0_0.addCatupPrintsNum(arg_48_0, arg_48_1)
	arg_48_0:updateCatchupData(arg_48_0.curCatchupTecID, arg_48_0.curCatchupGroupID, arg_48_1)

	arg_48_0.curCatchupPrintsNum = arg_48_0:getCurCatchNum()

	print("增加科研图纸", arg_48_1, arg_48_0.curCatchupPrintsNum)

	return
end

function var_0_0.IsShowTip(arg_49_0)
	local var_49_0, var_49_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getData().level, "TechnologyMediator")
	local var_49_2 = OPEN_TEC_TREE_SYSTEM and getProxy(TechnologyNationProxy):getShowRedPointTag()

	return var_49_2 or (SelectTechnologyMediator.onBlueprintNotify() or SelectTechnologyMediator.onTechnologyNotify()) and var_49_0
end

function var_0_0.addPursuingTimes(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_2 then
		arg_50_0.pursuingTimesUR = arg_50_0.pursuingTimesUR + arg_50_1
	else
		arg_50_0.pursuingTimes = arg_50_0.pursuingTimes + arg_50_1
	end

	return
end

function var_0_0.resetPursuingTimes(arg_51_0)
	arg_51_0.pursuingTimes = 0
	arg_51_0.pursuingTimesUR = 0

	arg_51_0:sendNotification(GAME.PURSUING_RESET_DONE)

	return
end

function var_0_0.getPursuingTimes(arg_52_0, arg_52_1)
	if arg_52_1 then
		return arg_52_0.pursuingTimesUR
	else
		return arg_52_0.pursuingTimes
	end

	return
end

function var_0_0.calcMaxPursuingCount(arg_53_0, arg_53_1)
	local var_53_0 = pg.gameset[arg_53_1:isRarityUR() and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr"].description
	local var_53_1 = getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResGold)
	local var_53_2 = 0

	for iter_53_0 = arg_53_0:getPursuingTimes(arg_53_1:isRarityUR()) + 1, var_53_0[#var_53_0][1] - 1 do
		local var_53_4 = arg_53_1:getPursuingPrice((function(arg_54_0)
			local var_54_0 = #var_53_0

			while arg_54_0 < var_53_0[var_54_0][1] do
				var_54_0 = var_54_0 - 1
			end

			return var_53_0[var_54_0][2]
		end)(iter_53_0))

		if var_53_1 < var_53_4 then
			return var_53_2
		else
			var_53_1 = var_53_1 - var_53_4
			var_53_2 = var_53_2 + 1
		end
	end

	return var_53_2 + math.floor(var_53_1 / arg_53_1:getPursuingPrice())
end

function var_0_0.calcPursuingCost(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = pg.gameset[arg_55_1:isRarityUR() and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr"].description
	local var_55_1 = 0

	for iter_55_0 = arg_55_0:getPursuingTimes(arg_55_1:isRarityUR()) + 1, var_55_0[#var_55_0][1] - 1 do
		local var_55_3 = arg_55_1:getPursuingPrice((function(arg_56_0)
			local var_56_0 = #var_55_0

			while arg_56_0 < var_55_0[var_56_0][1] do
				var_56_0 = var_56_0 - 1
			end

			return var_55_0[var_56_0][2]
		end)(iter_55_0))

		if arg_55_2 == 0 then
			return var_55_1
		else
			var_55_1 = var_55_1 + var_55_3
			arg_55_2 = arg_55_2 - 1
		end
	end

	return var_55_1 + arg_55_2 * arg_55_1:getPursuingPrice()
end

function var_0_0.getPursuingDiscount(arg_57_0, arg_57_1)
	local var_57_0 = getGameset(arg_57_1 and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr")[2]
	local var_57_1 = #var_57_0

	while arg_57_0 < var_57_0[var_57_1][1] do
		var_57_1 = var_57_1 - 1
	end

	return var_57_0[var_57_1][2]
end

function var_0_0.getItemCanUnlockBluePrint(arg_58_0, arg_58_1)
	if not arg_58_0.unlockItemDic then
		arg_58_0.unlockItemDic = {}

		for iter_58_0, iter_58_1 in ipairs(pg.ship_data_blueprint.all) do
			for iter_58_2, iter_58_3 in ipairs(arg_58_0.bluePrintData[iter_58_1]:getConfig("gain_item_id")) do
				arg_58_0.unlockItemDic[iter_58_3] = arg_58_0.unlockItemDic[iter_58_3] or {}

				table.insert(arg_58_0.unlockItemDic[iter_58_3], iter_58_1)
			end
		end
	end

	return arg_58_0.unlockItemDic[arg_58_1]
end

function var_0_0.CheckPursuingCostTip(arg_59_0, arg_59_1)
	if var_0_0.getPursuingDiscount(arg_59_0.pursuingTimes + 1, false) > 0 and var_0_0.getPursuingDiscount(arg_59_0.pursuingTimesUR + 1, true) > 0 then
		return false
	end

	local var_59_0 = {}

	if arg_59_1 then
		for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
			var_59_0[iter_59_1] = true
		end
	else
		for iter_59_2 = 1, arg_59_0.maxConfigVersion do
			var_59_0[iter_59_2] = true
		end
	end

	for iter_59_3, iter_59_4 in pairs(arg_59_0.bluePrintData) do
		if var_59_0[iter_59_4:getConfig("blueprint_version")] and iter_59_4:isPursuingCostTip() then
			return true
		end
	end

	return false
end

return var_0_0
