class = var_0_10000

local var_0_0 = "TechnologyProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.TECHNOLOGY_UPDATED = "TechnologyProxy:TECHNOLOGY_UPDATED"
var_0_1.BLUEPRINT_ADDED = "TechnologyProxy:BLUEPRINT_ADDED"
var_0_1.BLUEPRINT_UPDATED = "TechnologyProxy:BLUEPRINT_UPDATED"
var_0_1.REFRESH_UPDATED = "TechnologyProxy:REFRESH_UPDATED"

function var_0_1.register(arg_1_0)
	arg_1_0.tendency = {}

	local var_1_0 = arg_1_0

	arg_1_0.on(var_1_0, 24, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.updateTechnologys(var_2_0, arg_2_0.refresh_list)

		arg_1_0.refreshTechnologysFlag = arg_2_0.refresh_flag

		local var_2_1 = arg_1_0

		var_1.updateTecCatchup(var_2_1, arg_2_0.catchup)

		local var_2_2 = arg_1_0

		var_1.updateTechnologyQueue(var_2_2, arg_2_0.queue)

		return
	end)

	arg_1_0.bluePrintData = {}
	arg_1_0.item2blueprint = {}
	arg_1_0.maxConfigVersion = 0
	_ = var_1

	local var_1_1 = var_1.each

	pg = var_1_0

	var_1_1(var_1_0.ship_data_blueprint.all, function(arg_3_0)
		ShipBluePrint = var_2_10001

		local var_3_0 = var_2_10001.New({
			id = arg_3_0
		})
		local var_3_1 = arg_1_0

		math = var_3
		var_3_1.maxConfigVersion = var_3.max(arg_1_0.maxConfigVersion, var_3_0:getConfig("blueprint_version"))
		arg_1_0.bluePrintData[var_3_0.id] = var_3_0
		arg_1_0.item2blueprint[var_3_0:getItemId()] = var_3_0.id

		return
	end)
	arg_1_0:on(63100, function(arg_4_0)
		ipairs = var_2_10001

		for iter_4_0, iter_4_1 in var_2_10001(arg_4_0.blueprint_list) do
			local var_4_0 = arg_1_0.bluePrintData[iter_4_1.id]

			assert = var_7

			var_7(var_4_0, "miss config ship_data_blueprint>>>>>>>>" .. iter_4_1.id)
			var_4_0:updateInfo(iter_4_1)
		end

		local var_4_1 = arg_1_0
		local var_4_2

		if not arg_4_0.cold_time then
			var_4_2 = 0
		end

		var_4_1.coldTime = var_4_2

		local var_4_3 = arg_1_0
		local var_4_4

		if not arg_4_0.daily_catchup_strengthen then
			var_4_4 = 0
		end

		var_4_3.pursuingTimes = var_4_4

		local var_4_5 = arg_1_0
		local var_4_6

		if not arg_4_0.daily_catchup_strengthen_ur then
			var_4_6 = 0
		end

		var_4_5.pursuingTimesUR = var_4_6

		return
	end)

	return
end

function var_0_1.timeCall(arg_5_0)
	local var_5_0 = {}

	ProxyRegister = var_1_10002
	var_5_0[var_1_10002.DayCall] = function(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.updateRefreshFlag(var_6_0, 0)

		return
	end
	ProxyRegister = var_2
	var_5_0[var_2.HourCall] = function(arg_7_0)
		if arg_7_0 == 4 then
			local var_7_0 = arg_5_0

			var_1.resetPursuingTimes(var_7_0)
		end

		return
	end

	return var_5_0
end

function var_0_1.setVersion(arg_8_0, arg_8_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("technology_version", arg_8_1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.getVersion(arg_9_0)
	PlayerPrefs = var_1_10001

	if not var_1_10001.HasKey("technology_version") then
		arg_9_0:setVersion(1)

		return 1
	else
		PlayerPrefs = var_1

		return var_1.GetInt("technology_version")
	end

	return
end

function var_0_1.getConfigMaxVersion(arg_10_0)
	return arg_10_0.maxConfigVersion
end

function var_0_1.setTendency(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.tendency[arg_11_1] = arg_11_2

	return
end

function var_0_1.getTendency(arg_12_0, arg_12_1)
	return arg_12_0.tendency[arg_12_1]
end

function var_0_1.updateBlueprintStates(arg_13_0)
	pairs = var_1_10001

	local var_13_0

	if not arg_13_0.bluePrintData then
		var_13_0 = {}
	end

	for iter_13_0, iter_13_1 in var_1_10001(var_13_0) do
		iter_13_1:updateState()
	end

	return
end

function var_0_1.getColdTime(arg_14_0)
	return arg_14_0.coldTime
end

function var_0_1.updateColdTime(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.TimeMgr.GetInstance()

	arg_15_0.coldTime = var_1.GetServerTime(var_15_0) + 0

	return
end

function var_0_1.updateRefreshFlag(arg_16_0, arg_16_1)
	arg_16_0.refreshTechnologysFlag = arg_16_1

	arg_16_0:sendNotification(var_0_1.REFRESH_UPDATED, arg_16_0.refreshTechnologysFlag)

	return
end

function var_0_1.updateTechnologys(arg_17_0, arg_17_1)
	arg_17_0.data = {}
	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_1) do
		local var_17_0 = arg_17_0.tendency

		var_17_0[iter_17_1.id] = iter_17_1.target
		ipairs = var_17_0

		for iter_17_2, iter_17_3 in var_17_0(iter_17_1.technologys) do
			local var_17_1 = arg_17_0.data
			local var_17_2 = iter_17_3.id

			Technology = var_1_10014
			var_17_1[var_17_2] = var_1_10014.New({
				id = iter_17_3.id,
				time = iter_17_3.time,
				pool_id = iter_17_1.id
			})
		end
	end

	return
end

function var_0_1.updateTecCatchup(arg_18_0, arg_18_1)
	arg_18_0.curCatchupTecID = arg_18_1.version
	arg_18_0.curCatchupGroupID = arg_18_1.target
	arg_18_0.catchupData = {}
	ipairs = var_2

	for iter_18_0, iter_18_1 in var_2(arg_18_1.pursuings) do
		TechnologyCatchup = var_1_10007
		var_1_10007 = var_1_10007.New(iter_18_1)
		arg_18_0.catchupData[var_1_10007.id] = var_1_10007
	end

	arg_18_0.curCatchupPrintsNum = arg_18_0:getCurCatchNum()
	print = var_2

	var_2("初始下发的科研追赶信息", arg_18_0.curCatchupTecID, arg_18_0.curCatchupGroupID, arg_18_0.curCatchupPrintsNum)

	return
end

function var_0_1.updateTechnologyQueue(arg_19_0, arg_19_1)
	arg_19_0.queue = {}
	ipairs = var_2

	for iter_19_0, iter_19_1 in var_2(arg_19_1) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_19_0 = arg_19_0.queue

		Technology = var_1_10010

		var_1_10007(var_19_0, var_1_10010.New({
			queue = true,
			id = iter_19_1.id,
			time = iter_19_1.time
		}))
	end

	table = var_2

	var_2.sort(arg_19_0.queue, function(arg_20_0, arg_20_1)
		return arg_20_0.time < arg_20_1.time
	end)

	return
end

function var_0_1.moveTechnologyToQueue(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.data[arg_21_1]

	var_21_0.inQueue = true
	table = var_3

	var_3.insert(arg_21_0.queue, var_21_0)

	arg_21_0.data[arg_21_1] = nil

	return
end

function var_0_1.removeFirstQueueTechnology(arg_22_0)
	assert = var_1_10001

	var_1_10001(#arg_22_0.queue > 0)

	table = var_1_10001

	var_1_10001.remove(arg_22_0.queue, 1)

	return
end

function var_0_1.getActivateTechnology(arg_23_0)
	pairs = var_1_10001

	local var_23_0

	if not arg_23_0.data then
		var_23_0 = {}
	end

	for iter_23_0, iter_23_1 in var_1_10001(var_23_0) do
		if iter_23_1:isActivate() then
			Clone = var_6

			return var_6(iter_23_1)
		end
	end

	return
end

function var_0_1.getTechnologyById(arg_24_0, arg_24_1)
	assert = var_1_10002

	var_1_10002(arg_24_0.data[arg_24_1], "technology should exist>>" .. arg_24_1)

	local var_24_0 = arg_24_0.data[arg_24_1]

	return var_2.clone(var_24_0)
end

function var_0_1.updateTechnology(arg_25_0, arg_25_1)
	assert = var_1_10002

	var_1_10002(arg_25_0.data[arg_25_1.id], "technology should exist>>" .. arg_25_1.id)

	assert = var_1_10002
	isa = var_4

	local var_25_0 = arg_25_1

	Technology = var_1_10007

	var_1_10002(var_4(var_25_0, var_1_10007), "technology should be instance of Technology")

	arg_25_0.data[arg_25_1.id] = arg_25_1

	arg_25_0:sendNotification(var_0_1.TECHNOLOGY_UPDATED, arg_25_1:clone())

	return
end

function var_0_1.getTechnologys(arg_26_0)
	underscore = var_1_10001

	return var_1_10001.values(arg_26_0.data)
end

function var_0_1.getPlanningTechnologys(arg_27_0)
	table = var_1_10001

	return var_1_10001.mergeArray(arg_27_0.queue, {
		arg_27_0:getActivateTechnology()
	})
end

function var_0_1.getBluePrints(arg_28_0)
	Clone = var_1_10001

	return var_1_10001(arg_28_0.bluePrintData)
end

function var_0_1.getBluePrintById(arg_29_0, arg_29_1)
	Clone = var_1_10002

	return var_1_10002(arg_29_0.bluePrintData[arg_29_1])
end

function var_0_1.getRawBluePrintById(arg_30_0, arg_30_1)
	return arg_30_0.bluePrintData[arg_30_1]
end

function var_0_1.addBluePrint(arg_31_0, arg_31_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_31_0 = arg_31_1

	ShipBluePrint = var_1_10007

	var_1_10002(var_1_10004(var_31_0, var_1_10007), "bluePrint should be instance of ShipBluePrint")

	assert = var_1_10002

	var_1_10002(arg_31_0.bluePrintData[arg_31_1.id] == nil, "use function updateBluePrint instead")

	arg_31_0.bluePrintData[arg_31_1.id] = arg_31_1

	arg_31_0:sendNotification(var_0_1.BLUEPRINT_ADDED, arg_31_1:clone())

	return
end

function var_0_1.updateBluePrint(arg_32_0, arg_32_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_32_0 = arg_32_1

	ShipBluePrint = var_1_10007

	var_1_10002(var_1_10004(var_32_0, var_1_10007), "bluePrint should be instance of ShipBluePrint")

	assert = var_1_10002

	var_1_10002(arg_32_0.bluePrintData[arg_32_1.id], "use function addBluePrint instead")

	arg_32_0.bluePrintData[arg_32_1.id] = arg_32_1

	arg_32_0:sendNotification(var_0_1.BLUEPRINT_UPDATED, arg_32_1:clone())

	return
end

function var_0_1.getBuildingBluePrint(arg_33_0)
	pairs = var_1_10001

	for iter_33_0, iter_33_1 in var_1_10001(arg_33_0.bluePrintData) do
		if iter_33_1:isDeving() or iter_33_1:isFinished() then
			return iter_33_1
		end
	end

	return
end

function var_0_1.getAllBluePrintShipIds(arg_34_0)
	local var_34_0 = {}

	pairs = var_1_10002

	for iter_34_0, iter_34_1 in var_1_10002(arg_34_0.bluePrintData) do
		if iter_34_1:isFetched() then
			table = var_7

			var_7.insert(var_34_0, iter_34_1.shipId)
		end
	end

	return var_34_0
end

function var_0_1.GetBlueprint4Item(arg_35_0, arg_35_1)
	return arg_35_0.item2blueprint[arg_35_1]
end

function var_0_1.updatePhantomQuestProgress(arg_36_0, arg_36_1, arg_36_2)
	pairs = var_1_10003

	for iter_36_0, iter_36_1 in var_1_10003(arg_36_0.bluePrintData) do
		if iter_36_1:isFetched() and arg_36_2[iter_36_1.shipId] then
			iter_36_1:setPhantomQuestProgress(arg_36_1, arg_36_2[iter_36_1.shipId])
		end
	end

	return
end

function var_0_1.getCatchupData(arg_37_0, arg_37_1)
	if not arg_37_0.catchupData[arg_37_1] then
		TechnologyCatchup = var_2

		local var_37_0 = var_2.New({
			version = arg_37_1
		})

		arg_37_0.catchupData[arg_37_1] = var_37_0
	end

	return arg_37_0.catchupData[arg_37_1]
end

function var_0_1.updateCatchupData(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_0.catchupData[arg_38_1]

	var_4.addTargetNum(var_38_0, arg_38_2, arg_38_3)

	return
end

function var_0_1.getCurCatchNum(arg_39_0)
	if arg_39_0.curCatchupTecID ~= 0 and arg_39_0.curCatchupGroupID ~= 0 then
		local var_39_0 = arg_39_0.catchupData[arg_39_0.curCatchupTecID]

		return var_1.getTargetNum(var_39_0, arg_39_0.curCatchupGroupID)
	else
		return 0
	end

	return
end

function var_0_1.getCatchupState(arg_40_0, arg_40_1)
	if not arg_40_0.catchupData[arg_40_1] then
		TechnologyCatchup = var_2

		return var_2.STATE_UNSELECT
	end

	local var_40_0 = arg_40_0.catchupData[arg_40_1]

	return var_2.getState(var_40_0)
end

function var_0_1.updateCatchupStates(arg_41_0)
	pairs = var_1_10001

	for iter_41_0, iter_41_1 in var_1_10001(arg_41_0.catchupData) do
		iter_41_1:updateState()
	end

	return
end

function var_0_1.isOpenTargetCatchup(arg_42_0)
	pg = var_1_10001

	if var_1_10001.technology_catchup_template ~= nil then
		pg = var_1

		local var_42_0

		if not (#var_1.technology_catchup_template.all > 0) then
			var_42_0 = false
		else
			var_42_0 = true
		end

		return var_42_0
	end
end

function var_0_1.getNewestCatchupTecID(arg_43_0)
	math = var_1_10001

	local var_43_0 = var_1_10001.max

	unpack = var_1_10003
	pg = var_1_10005

	return var_43_0(var_1_10003(var_1_10005.technology_catchup_template.all))
end

function var_0_1.isOnCatchup(arg_44_0)
	return arg_44_0.curCatchupTecID ~= 0 and arg_44_0.curCatchupGroupID ~= 0
end

function var_0_1.getBluePrintVOByGroupID(arg_45_0, arg_45_1)
	return arg_45_0.bluePrintData[arg_45_1]
end

function var_0_1.getCurCatchupTecInfo(arg_46_0)
	return {
		tecID = arg_46_0.curCatchupTecID,
		groupID = arg_46_0.curCatchupGroupID,
		printNum = arg_46_0.curCatchupPrintsNum
	}
end

function var_0_1.setCurCatchupTecInfo(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0.curCatchupTecID = arg_47_1
	arg_47_0.curCatchupGroupID = arg_47_2
	arg_47_0.curCatchupPrintsNum = arg_47_0:getCurCatchNum()

	arg_47_0:updateCatchupStates()

	print = var_3

	var_3("设置后的科研追赶信息", arg_47_0.curCatchupTecID, arg_47_0.curCatchupGroupID, arg_47_0.curCatchupPrintsNum)

	return
end

function var_0_1.addCatupPrintsNum(arg_48_0, arg_48_1)
	arg_48_0:updateCatchupData(arg_48_0.curCatchupTecID, arg_48_0.curCatchupGroupID, arg_48_1)

	arg_48_0.curCatchupPrintsNum = arg_48_0:getCurCatchNum()
	print = var_2

	var_2("增加科研图纸", arg_48_1, arg_48_0.curCatchupPrintsNum)

	return
end

function var_0_1.IsShowTip(arg_49_0)
	SelectTechnologyMediator = var_1_10001

	local var_49_0 = var_1_10001.onTechnologyNotify()

	SelectTechnologyMediator = var_1_10002

	local var_49_1 = var_1_10002.onBlueprintNotify()

	pg = var_1_10003

	local var_49_2 = var_1_10003.SystemOpenMgr.GetInstance()
	local var_49_3 = var_3.isOpenSystem

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_49_4 = var_1_10006(var_1_10008)
	local var_49_5, var_49_6 = var_49_3(var_49_2, var_6.getData(var_49_4).level, "TechnologyMediator")

	OPEN_TEC_TREE_SYSTEM = var_49_2

	if var_49_2 then
		getProxy = var_49_2
		TechnologyNationProxy = var_7

		local var_49_7 = var_49_2(var_7)

		var_49_2 = var_49_2.getShowRedPointTag(var_49_7)
	end

	return var_49_2 or (var_49_1 or var_49_0) and var_49_5
end

function var_0_1.addPursuingTimes(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_2 then
		arg_50_0.pursuingTimesUR = arg_50_0.pursuingTimesUR + arg_50_1
	else
		arg_50_0.pursuingTimes = arg_50_0.pursuingTimes + arg_50_1
	end

	return
end

function var_0_1.resetPursuingTimes(arg_51_0)
	arg_51_0.pursuingTimes = 0
	arg_51_0.pursuingTimesUR = 0

	local var_51_0 = arg_51_0
	local var_51_1 = arg_51_0.sendNotification

	GAME = var_1_10004

	var_51_1(var_51_0, var_1_10004.PURSUING_RESET_DONE)

	return
end

function var_0_1.getPursuingTimes(arg_52_0, arg_52_1)
	if arg_52_1 then
		return arg_52_0.pursuingTimesUR
	else
		return arg_52_0.pursuingTimes
	end

	return
end

function var_0_1.calcMaxPursuingCount(arg_53_0, arg_53_1)
	pg = var_1_10002

	local var_53_0 = var_1_10002.gameset
	local var_53_1 = arg_53_1
	local var_53_2 = var_53_0[arg_53_1.isRarityUR(var_53_1) and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr"].description

	getProxy = var_3
	PlayerProxy = var_53_1

	local var_53_3 = var_3(var_53_1)
	local var_53_4 = var_3.getRawData(var_53_3)
	local var_53_5 = var_3.getResource

	PlayerConst = var_1_10006

	local var_53_6 = var_53_5(var_53_4, var_1_10006.ResGold)
	local var_53_7 = 0

	local function var_53_8(arg_54_0)
		local var_54_0 = #var_53_2

		while arg_54_0 < var_53_2[var_54_0][1] do
			var_54_0 = var_54_0 - 1
		end

		return var_53_2[var_54_0][2]
	end

	local var_53_9

	for iter_53_0 = arg_53_0:getPursuingTimes(arg_53_1:isRarityUR()) + 1, var_53_2[#var_53_2][1] - 1 do
		if var_53_6 < arg_53_1:getPursuingPrice(var_53_8(iter_53_0)) then
			return var_53_7
		else
			var_53_6 = var_53_6 - var_6
			var_53_7 = var_53_7 + 1
		end
	end

	math = var_7

	return var_53_7 + var_7.floor(var_53_6 / arg_53_1:getPursuingPrice())
end

function var_0_1.calcPursuingCost(arg_55_0, arg_55_1, arg_55_2)
	pg = var_1_10003

	local var_55_0 = var_1_10003.gameset[arg_55_1:isRarityUR() and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr"].description
	local var_55_1 = 0

	local function var_55_2(arg_56_0)
		local var_56_0 = #var_55_0

		while arg_56_0 < var_55_0[var_56_0][1] do
			var_56_0 = var_56_0 - 1
		end

		return var_55_0[var_56_0][2]
	end

	local var_55_3

	for iter_55_0 = arg_55_0:getPursuingTimes(arg_55_1:isRarityUR()) + 1, var_55_0[#var_55_0][1] - 1 do
		local var_55_4 = arg_55_1:getPursuingPrice(var_55_2(iter_55_0))

		if arg_55_2 == 0 then
			return var_55_1
		else
			var_55_1 = var_55_1 + var_55_4
			arg_55_2 = arg_55_2 - 1
		end
	end

	return var_55_1 + arg_55_2 * arg_55_1:getPursuingPrice()
end

function var_0_1.getPursuingDiscount(arg_57_0, arg_57_1)
	getGameset = var_1_10002

	local var_57_0 = #var_1_10002(arg_57_1 and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr")[2]

	while arg_57_0 < var_2[var_57_0][1] do
		var_57_0 = var_57_0 - 1
	end

	return var_2[var_57_0][2]
end

function var_0_1.getItemCanUnlockBluePrint(arg_58_0, arg_58_1)
	if not arg_58_0.unlockItemDic then
		arg_58_0.unlockItemDic = {}
		ipairs = var_2
		pg = var_1_10004

		for iter_58_0, iter_58_1 in var_2(var_1_10004.ship_data_blueprint.all) do
			local var_58_0 = arg_58_0.bluePrintData[iter_58_1]

			ipairs = var_1_10008

			for iter_58_2, iter_58_3 in var_1_10008(var_58_0:getConfig("gain_item_id")) do
				local var_58_1 = arg_58_0.unlockItemDic
				local var_58_2

				if not arg_58_0.unlockItemDic[iter_58_3] then
					var_58_2 = {}
				end

				var_58_1[iter_58_3] = var_58_2
				table = var_58_1

				var_58_1.insert(arg_58_0.unlockItemDic[iter_58_3], iter_58_1)
			end
		end
	end

	return arg_58_0.unlockItemDic[arg_58_1]
end

function var_0_1.CheckPursuingCostTip(arg_59_0, arg_59_1)
	local var_59_0 = var_0_1.getPursuingDiscount(arg_59_0.pursuingTimes + 1, false)

	if 0 < var_59_0 then
		local var_59_1 = var_0_1.getPursuingDiscount(arg_59_0.pursuingTimesUR + 1, true)

		if 0 < var_59_1 then
			return false
		end
	end

	local var_59_2 = {}

	if arg_59_1 then
		ipairs = var_3

		for iter_59_0, iter_59_1 in var_3(arg_59_1) do
			var_59_2[iter_59_1] = true
		end
	else
		for iter_59_2 = 1, arg_59_0.maxConfigVersion do
			var_59_2[iter_59_2] = true
		end
	end

	pairs = var_3

	for iter_59_3, iter_59_4 in var_3(arg_59_0.bluePrintData) do
		if var_59_2[iter_59_4:getConfig("blueprint_version")] and iter_59_4:isPursuingCostTip() then
			return true
		end
	end

	return false
end

return var_0_1
