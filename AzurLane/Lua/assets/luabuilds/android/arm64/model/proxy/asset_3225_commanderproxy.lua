class = var_0_10000

local var_0_0 = "CommanderProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.COMMANDER_UPDATED = "CommanderProxy:COMMANDER_UPDATED"
var_0_1.COMMANDER_ADDED = "CommanderProxy:COMMANDER_ADDED"
var_0_1.COMMANDER_DELETED = "CommanderProxy:COMMANDER_DELETED"
var_0_1.RESERVE_CNT_UPDATED = "CommanderProxy:RESERVE_CNT_UPDATED"
var_0_1.COMMANDER_BOX_FINISHED = "CommanderProxy:COMMANDER_BOX_FINISHED"
var_0_1.PREFAB_FLEET_UPDATE = "CommanderProxy:PREFAB_FLEET_UPDATE"
var_0_1.MAX_WORK_COUNT = 4
var_0_1.MAX_SLOT = 10
var_0_1.MAX_PREFAB_FLEET = 3

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.boxes = {}
	arg_1_0.prefabFleet = {}
	arg_1_0.openCommanderScene = false

	for iter_1_0 = 1, var_0_1.MAX_PREFAB_FLEET do
		local var_1_0 = arg_1_0.prefabFleet

		CommnaderFleet = var_1_10006
		var_1_0[iter_1_0] = var_1_10006.New({
			id = iter_1_0
		})
	end

	pg = var_1

	local var_1_1 = var_1.gameset.commander_box_count.key_value

	for iter_1_1 = 1, var_1_1 do
		CommanderBox = var_1_10006
		var_1_10006 = var_1_10006.New({
			id = iter_1_1
		})

		arg_1_0:addBox(var_1_10006)
	end

	arg_1_0.pools = {}
	ipairs = var_2
	pg = var_4

	for iter_1_2, iter_1_3 in var_2(var_4.commander_data_create_material.all) do
		CommanderBuildPool = var_1_10007
		var_1_10007 = var_1_10007.New({
			id = iter_1_3
		})
		table = var_1_10008

		var_1_10008.insert(arg_1_0.pools, var_1_10007)
	end

	arg_1_0.boxUsageCount = 0

	arg_1_0:on(25001, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.commanders) do
			Commander = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_1)
			var_2_10009 = arg_1_0

			var_7.addCommander(var_2_10009, var_2_10006)
		end

		ipairs = var_1

		for iter_2_2, iter_2_3 in var_1(arg_2_0.box) do
			CommanderBox = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_3, iter_2_2)
			var_2_10009 = arg_1_0

			var_7.updateBox(var_2_10009, var_2_10006)
		end

		ipairs = var_1

		for iter_2_4, iter_2_5 in var_1(arg_2_0.presets) do
			local var_2_0 = iter_2_5.id
			local var_2_1 = iter_2_5.commandersid
			local var_2_2 = {}

			ipairs = var_2_10009

			for iter_2_6, iter_2_7 in var_2_10009(var_2_1) do
				local var_2_3 = arg_1_0

				if var_14.getCommanderById(var_2_3, iter_2_7.id) then
					var_2_2[iter_2_7.pos] = var_14
				end
			end

			local var_2_4 = arg_1_0.prefabFleet[var_2_0]

			var_2_10009.Update(var_2_4, {
				id = var_2_0,
				name = arg_2_0.name,
				commanders = var_2_2
			})
		end

		local var_2_5 = arg_1_0
		local var_2_6

		if not arg_2_0.usage_count then
			var_2_6 = 0
		end

		var_2_5.boxUsageCount = var_2_6
		LOCK_CATTERY = var_2_5

		if not var_2_5 then
			local var_2_7 = arg_1_0
			local var_2_8 = var_1.sendNotification

			GAME = iter_2_4

			var_2_8(var_2_7, iter_2_4.GET_COMMANDER_HOME)
		end

		return
	end)

	arg_1_0.newCommanderList = {}

	arg_1_0:on(25039, function(arg_3_0)
		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_3_0.commander_list) do
			Commander = var_2_10006
			var_2_10006 = var_2_10006.New(iter_3_1)

			local var_3_0 = arg_1_0

			var_7.addCommander(var_3_0, var_2_10006)

			table = var_7

			var_7.insert(arg_1_0.newCommanderList, var_2_10006)
		end

		return
	end)

	return
end

function var_0_1.timeCall(arg_4_0)
	local var_4_0 = {}

	ProxyRegister = var_1_10002
	var_4_0[var_1_10002.DayCall] = function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.resetBoxUseCnt(var_5_0)

		local var_5_1 = arg_4_0

		if var_1.GetCommanderHome(var_5_1) then
			var_1:ResetCatteryOP()
			var_1:ReduceClean()
		end

		return
	end

	return var_4_0
end

function var_0_1.GetNewestCommander(arg_6_0, arg_6_1, arg_6_2)
	defaultValue = var_1_10003

	local var_6_0 = var_1_10003(arg_6_2, true)

	if arg_6_1 >= #arg_6_0.newCommanderList then
		return arg_6_0.newCommanderList
	else
		local var_6_1 = {}

		for iter_6_0 = #arg_6_0.newCommanderList - arg_6_1 + 1, #arg_6_0.newCommanderList do
			table = var_1_10010

			var_1_10010.insert(var_6_1, arg_6_0.newCommanderList[iter_6_0])
		end

		return var_6_1
	end

	if var_6_0 then
		arg_6_0.newCommanderList = {}
	end

	return
end

function var_0_1.getPrefabFleetById(arg_7_0, arg_7_1)
	return arg_7_0.prefabFleet[arg_7_1]
end

function var_0_1.getPrefabFleet(arg_8_0)
	Clone = var_1_10001

	return var_1_10001(arg_8_0.prefabFleet)
end

function var_0_1.updatePrefabFleet(arg_9_0, arg_9_1)
	arg_9_0.prefabFleet[arg_9_1.id] = arg_9_1

	arg_9_0:sendNotification(var_0_1.PREFAB_FLEET_UPDATE)

	return
end

function var_0_1.updatePrefabFleetName(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.prefabFleet[arg_10_1]

	var_3.updateName(var_10_0, arg_10_2)
	arg_10_0:sendNotification(var_0_1.PREFAB_FLEET_UPDATE)

	return
end

function var_0_1.getCommanderCnt(arg_11_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_11_0.data)
end

function var_0_1.getPoolById(arg_12_0, arg_12_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_12_0:getPools(), function(arg_13_0)
		return arg_13_0.id == arg_12_1
	end)
end

function var_0_1.getPools(arg_14_0)
	return arg_14_0.pools
end

function var_0_1.getBoxUseCnt(arg_15_0)
	return arg_15_0.boxUsageCount
end

function var_0_1.updateBoxUseCnt(arg_16_0, arg_16_1)
	arg_16_0.boxUsageCount = arg_16_0.boxUsageCount + arg_16_1

	arg_16_0:sendNotification(var_0_1.RESERVE_CNT_UPDATED, arg_16_0.boxUsageCount)

	return
end

function var_0_1.resetBoxUseCnt(arg_17_0)
	arg_17_0.boxUsageCount = 0

	arg_17_0:sendNotification(var_0_1.RESERVE_CNT_UPDATED, 0)

	return
end

function var_0_1.updateBox(arg_18_0, arg_18_1)
	arg_18_0.boxes[arg_18_1.id] = arg_18_1

	return
end

function var_0_1.addBox(arg_19_0, arg_19_1)
	arg_19_0.boxes[arg_19_1.id] = arg_19_1

	return
end

function var_0_1.getBoxes(arg_20_0)
	local var_20_0 = {}

	ipairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.boxes) do
		table = var_1_10007

		var_1_10007.insert(var_20_0, iter_20_1)
	end

	return var_20_0
end

function var_0_1.getBoxById(arg_21_0, arg_21_1)
	assert = var_1_10002

	var_1_10002(arg_21_0.boxes[arg_21_1], "attemp to get a nil box" .. arg_21_1)

	return arg_21_0.boxes[arg_21_1]
end

function var_0_1.getCommanderById(arg_22_0, arg_22_1)
	if arg_22_0.data[arg_22_1] then
		return var_2:clone()
	end

	return
end

function var_0_1.RawGetCommanderById(arg_23_0, arg_23_1)
	if arg_23_0.data[arg_23_1] then
		return var_2
	end

	return
end

function var_0_1.GetSameConfigIdCommanderCount(arg_24_0, arg_24_1)
	local var_24_0 = 0

	pairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0.data) do
		if iter_24_1.configId == arg_24_1 then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function var_0_1.addCommander(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.data

	var_25_0[arg_25_1.id] = arg_25_1
	getProxy = var_25_0
	PlayerProxy = var_1_10004

	local var_25_1 = var_25_0(var_1_10004)

	if var_2.getInited(var_25_1) then
		arg_25_0:sendNotification(var_0_1.COMMANDER_ADDED, arg_25_1:clone())
	end

	return
end

function var_0_1.updateCommander(arg_26_0, arg_26_1)
	assert = var_1_10002

	var_1_10002(arg_26_0.data[arg_26_1.id], "commander can not be nil")

	assert = var_1_10002
	isa = var_4

	local var_26_0 = arg_26_1

	Commander = var_1_10007

	var_1_10002(var_4(var_26_0, var_1_10007), "commander should be and instance of Commander")

	arg_26_0.data[arg_26_1.id] = arg_26_1

	arg_26_0:sendNotification(var_0_1.COMMANDER_UPDATED, arg_26_1:clone())

	return
end

function var_0_1.removeCommanderById(arg_27_0, arg_27_1)
	arg_27_0:checkPrefabFleet(arg_27_1)

	assert = var_2

	var_2(arg_27_0.data[arg_27_1], "commander can not be nil")

	arg_27_0.data[arg_27_1] = nil

	arg_27_0:sendNotification(var_0_1.COMMANDER_DELETED, arg_27_1)

	return
end

function var_0_1.checkPrefabFleet(arg_28_0, arg_28_1)
	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.prefabFleet) do
		if iter_28_1:contains(arg_28_1) then
			iter_28_1:removeCommander(arg_28_1)
		end
	end

	return
end

function var_0_1.haveFinishedBox(arg_29_0)
	pairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.boxes) do
		local var_29_0 = iter_29_1:getState()

		CommanderBox = var_1_10007

		if var_29_0 == var_1_10007.STATE_FINISHED then
			return true
		end
	end

	return false
end

function var_0_1.IsFinishAllBox(arg_30_0)
	local var_30_0 = 0
	local var_30_1 = 0
	local var_30_2 = 0

	pairs = var_1_10004

	for iter_30_0, iter_30_1 in var_1_10004(arg_30_0.boxes) do
		local var_30_3 = iter_30_1:getState()

		CommanderBox = var_1_10010

		if var_30_3 == var_1_10010.STATE_FINISHED then
			var_30_0 = var_30_0 + 1
		else
			CommanderBox = var_1_10010

			if var_30_3 == var_1_10010.STATE_EMPTY then
				var_30_1 = var_30_1 + 1
			end
		end

		var_30_2 = var_30_2 + 1
	end

	return var_30_0 > 0 and var_30_0 + var_30_1 == var_30_2
end

function var_0_1.onRemove(arg_31_0)
	arg_31_0:RemoveCalcExpTimer()
	var_0_1.super.onRemove(arg_31_0)

	arg_31_0.openCommanderScene = false

	return
end

function var_0_1.AddCommanderHome(arg_32_0, arg_32_1)
	arg_32_0.commanderHome = arg_32_1
	pg = var_1_10002

	local var_32_0 = var_1_10002.TimeMgr.GetInstance()
	local var_32_1 = var_2.GetServerTime(var_32_0)

	GetNextHour = var_1_10003

	local var_32_2 = var_1_10003(1) - var_32_1

	arg_32_0:StartCalcExpTimer(var_32_2)

	return
end

function var_0_1.GetCommanderHome(arg_33_0)
	return arg_33_0.commanderHome
end

function var_0_1.StartCalcExpTimer(arg_34_0, arg_34_1)
	arg_34_0:RemoveCalcExpTimer()

	Timer = var_2
	arg_34_0.calcExpTimer = var_2.New(function()
		local var_35_0 = arg_34_0

		var_0.RemoveCalcExpTimer(var_35_0)

		local var_35_1 = arg_34_0
		local var_35_2 = var_0.sendNotification

		GAME = var_2_10003

		var_35_2(var_35_1, var_2_10003.CALC_CATTERY_EXP, {
			isPeriod = arg_34_1 == 16
		})

		local var_35_3 = arg_34_0

		var_0.StartCalcExpTimer(var_35_3, 3600)

		return
	end, arg_34_1, 1)

	local var_34_0 = arg_34_0.calcExpTimer

	var_2.Start(var_34_0)

	return
end

function var_0_1.RemoveCalcExpTimer(arg_36_0)
	if arg_36_0.calcExpTimer then
		local var_36_0 = arg_36_0.calcExpTimer

		var_1.Stop(var_36_0)

		arg_36_0.calcExpTimer = nil
	end

	return
end

function var_0_1.AnyCatteryExistOP(arg_37_0)
	if arg_37_0:GetCommanderHome() then
		return var_1:AnyCatteryExistOP()
	end

	return false
end

function var_0_1.AnyCatteryCanUse(arg_38_0)
	if arg_38_0:GetCommanderHome() then
		return var_1:AnyCatteryCanUse()
	end

	return false
end

function var_0_1.IsHome(arg_39_0, arg_39_1)
	if arg_39_0:GetCommanderHome() then
		return var_2:CommanderInHome(arg_39_1)
	end

	return false
end

function var_0_1.UpdateOpenCommanderScene(arg_40_0, arg_40_1)
	arg_40_0.openCommanderScene = arg_40_1

	return
end

function var_0_1.InCommanderScene(arg_41_0)
	return arg_41_0.openCommanderScene
end

function var_0_1.AnyPoolIsWaiting(arg_42_0)
	local var_42_0 = 0

	pairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.boxes) do
		local var_42_1 = iter_42_1:getState()

		CommanderBox = var_1_10008

		if var_42_1 ~= var_1_10008.STATE_WAITING then
			CommanderBox = var_1_10008

			if var_42_1 == var_1_10008.STATE_STARTING then
				return false
			end

			CommanderBox = var_1_10008

			if var_42_1 == var_1_10008.STATE_FINISHED then
				var_42_0 = var_42_0 + 1
			end
		end
	end

	return var_42_0 > 0
end

function var_0_1.ShouldTipBox(arg_43_0)
	local function var_43_0()
		local var_44_0 = 0

		pairs = var_2_10001

		for iter_44_0, iter_44_1 in var_2_10001(arg_43_0.pools) do
			var_44_0 = var_44_0 + iter_44_1:getItemCount()
		end

		return var_44_0 > 0
	end

	local function var_43_1()
		pairs = var_2_10000

		for iter_45_0, iter_45_1 in var_2_10000(arg_43_0.boxes) do
			local var_45_0 = iter_45_1:getState()

			CommanderBox = var_2_10006

			if var_45_0 == var_2_10006.STATE_EMPTY then
				return true
			end
		end

		return false
	end

	if var_43_0() then
		if var_43_1() then
			return true
		else
			return arg_43_0:IsFinishAllBox()
		end
	else
		return arg_43_0:IsFinishAllBox()
	end

	return
end

function var_0_1.CalcQuickItemUsageCnt(arg_46_0)
	Item = var_1_10001

	local var_46_0 = var_1_10001.COMMANDER_QUICKLY_TOOL_ID

	Item = var_1_10002

	local var_46_1 = var_1_10002.getConfigData(var_46_0).usage_arg[1]

	local function var_46_2(arg_47_0, arg_47_1)
		local var_47_0 = arg_47_1 - arg_47_0

		math = var_2_10003

		return var_2_10003.ceil(var_47_0 / var_46_1)
	end

	getProxy = var_4
	BagProxy = var_1_10006

	local var_46_3 = var_4(var_1_10006)
	local var_46_4 = var_4.getItemCountById(var_46_3, var_46_0)
	local var_46_5 = 0
	local var_46_6 = 0
	local var_46_7 = 0
	local var_46_8 = {}
	local var_46_9 = {}

	pairs = var_1_10010

	for iter_46_0, iter_46_1 in var_1_10010(arg_46_0.boxes) do
		table = var_1_10015

		var_1_10015.insert(var_46_9, iter_46_1)
	end

	table = var_10

	var_10.sort(var_46_9, function(arg_48_0, arg_48_1)
		if arg_48_0.state == arg_48_1.state then
			return arg_48_0.index < arg_48_1.index
		else
			return var_3 < var_2
		end

		return
	end)

	ipairs = var_10

	for iter_46_2, iter_46_3 in var_10(var_46_9) do
		local var_46_10 = var_46_7
		local var_46_11 = iter_46_3:getState()

		CommanderBox = var_1_10017

		if var_46_11 == var_1_10017.STATE_WAITING then
			var_46_5 = var_46_5 + 1
			var_46_7 = var_46_7 + 1
			table = var_1_10017

			var_1_10017.insert(var_46_8, iter_46_3)

			var_46_6 = var_46_6 + var_46_2(iter_46_3.beginTime, iter_46_3.finishTime)
		else
			CommanderBox = var_1_10017

			if var_46_11 == var_1_10017.STATE_STARTING then
				var_46_5 = var_46_5 + 1
				var_46_7 = var_46_7 + 1
				table = var_1_10017

				var_1_10017.insert(var_46_8, iter_46_3)

				pg = var_1_10017

				local var_46_12 = var_1_10017.TimeMgr.GetInstance()

				var_1_10017 = var_1_10017.GetServerTime(var_46_12)
				var_46_6 = var_46_6 + var_46_2(var_1_10017, iter_46_3.finishTime)
			end
		end

		if var_46_6 == var_46_4 then
			break
		elseif var_46_4 < var_46_6 then
			var_46_6 = var_46_4
			var_46_7 = var_46_7 - 1
			table = var_1_10017

			var_1_10017.remove(var_46_8, #var_46_8)

			break
		end
	end

	local var_46_13 = {
		0,
		0,
		0
	}

	ipairs = var_11

	for iter_46_4, iter_46_5 in var_11(var_46_8) do
		local var_46_14 = iter_46_5.pool

		var_46_13[var_16] = var_46_13[var_16.getRarity(var_46_14)] + 1
	end

	return var_46_6, var_46_5, var_46_7, var_46_13
end

return var_0_1
