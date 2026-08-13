class = var_0_10000

local var_0_0 = "World"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	isAutoFight = "boolean",
	stepCount = "number",
	cdTimeList = "table",
	type = "number",
	resetAward = "table",
	realm = "number",
	progress = "number",
	resetLimitTip = "boolean",
	roundIndex = "number",
	lowestHP = "table",
	treasureCount = "number",
	activateCount = "number",
	activateTime = "number",
	achievements = "table",
	baseShipIds = "table",
	collectionProxy = "table",
	goodDic = "table",
	achieveEntranceStar = "table",
	baseCmdIds = "table",
	colorDic = "table",
	gobalFlag = "table",
	forceLock = "boolean",
	inventoryProxy = "table",
	atlas = "table",
	worldBossProxy = "table",
	staminaMgr = "table",
	globalBuffDic = "table",
	taskProxy = "table",
	autoInfos = "table",
	defaultFleets = "table",
	fleets = "table",
	isAutoSwitch = "boolean",
	expiredTime = "number",
	pressingAwardDic = "table",
	submarineSupport = "boolean"
}
var_0_1.EventUpdateSubmarineSupport = "World.EventUpdateSubmarineSupport"
var_0_1.EventSwitchMap = "World.EventSwitchMap"
var_0_1.EventUpdateProgress = "World.EventUpdateProgress"
var_0_1.EventUpdateShopGoods = "World.EventUpdateShopGoods"
var_0_1.EventUpdateGlobalBuff = "World.EventUpdateGlobalBuff"
var_0_1.EventAddPortShip = "World.EventAddPortShip"
var_0_1.EventRemovePortShip = "World.EventRemovePortShip"
var_0_1.EventAchieved = "World.EventAchieved"
var_0_1.Listeners = {
	onUpdateItem = "OnUpdateItem",
	onUpdateTask = "OnUpdateTask"
}
var_0_1.TypeBase = 0
var_0_1.TypeFull = 1
var_0_1.InheritNameList = {
	staminaMgr = function()
		WorldStaminaManager = var_1_10000

		return var_1_10000.New()
	end,
	collectionProxy = function()
		WorldCollectionProxy = var_1_10000

		return var_1_10000.New()
	end,
	worldBossProxy = function()
		WorldBossProxy = var_1_10000

		return var_1_10000.New()
	end
}

function var_0_1.Ctor(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.Ctor(arg_4_0)

	arg_4_0.type = arg_4_1

	arg_4_0:InheritReset(arg_4_2)

	return
end

function var_0_1.Build(arg_5_0)
	WorldAtlas = var_1_10001

	local var_5_0 = var_1_10001.New

	WorldConst = var_1_10003
	arg_5_0.atlas = var_5_0(var_1_10003.DefaultAtlas)
	arg_5_0.realm = 0
	arg_5_0.fleets = {}
	arg_5_0.defaultFleets = {}
	arg_5_0.activateTime = 0
	arg_5_0.expiredTime = 0
	arg_5_0.roundIndex = nil
	arg_5_0.submarineSupport = nil
	arg_5_0.achievements = {}
	arg_5_0.achieveEntranceStar = {}

	arg_5_0:InitWorldShopGoods()
	arg_5_0:InitWorldColorDictionary()

	arg_5_0.activateCount = 0
	arg_5_0.stepCount = 0
	arg_5_0.treasureCount = 0
	arg_5_0.progress = 0
	arg_5_0.cdTimeList = {}
	arg_5_0.globalBuffDic = {}
	arg_5_0.pressingAwardDic = {}
	arg_5_0.lowestHP = {}
	arg_5_0.gobalFlag = {}
	arg_5_0.isAutoFight = false

	arg_5_0:InitAutoInfos()

	WorldInventoryProxy = var_1
	arg_5_0.inventoryProxy = var_1.New()

	local var_5_1 = arg_5_0.inventoryProxy
	local var_5_2 = var_1.AddListener

	WorldInventoryProxy = var_1_10004

	var_5_2(var_5_1, var_1_10004.EventUpdateItem, arg_5_0.onUpdateItem)

	WorldTaskProxy = var_5_2
	arg_5_0.taskProxy = var_5_2.New()

	local var_5_3 = arg_5_0.taskProxy
	local var_5_4 = var_1.AddListener

	WorldTaskProxy = var_4

	var_5_4(var_5_3, var_4.EventUpdateTask, arg_5_0.onUpdateTask)

	arg_5_0.baseShipIds = {}
	arg_5_0.baseCmdIds = {}

	return
end

function var_0_1.Dispose(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_1 or not {
		realm = arg_6_0.realm,
		defaultFleets = arg_6_0.defaultFleets,
		achievements = arg_6_0.achievements,
		achieveEntranceStar = arg_6_0.achieveEntranceStar,
		activateCount = arg_6_0.activateCount,
		progress = arg_6_0.progress,
		staminaMgr = arg_6_0.staminaMgr,
		collectionProxy = arg_6_0.collectionProxy
	} then
		var_6_0 = {}
	end

	var_6_0.worldBossProxy = arg_6_0.worldBossProxy
	pairs = var_3

	for iter_6_0 in var_3(var_0_1.InheritNameList) do
		if not var_6_0[iter_6_0] then
			local var_6_1 = arg_6_0[iter_6_0]

			var_7.Dispose(var_6_1)
		end
	end

	local var_6_2 = arg_6_0.inventoryProxy
	local var_6_3 = var_3.RemoveListener

	WorldInventoryProxy = iter_6_0

	var_6_3(var_6_2, iter_6_0.EventUpdateItem, arg_6_0.onUpdateItem)

	local var_6_4 = arg_6_0.inventoryProxy

	var_3.Dispose(var_6_4)

	local var_6_5 = arg_6_0.taskProxy
	local var_6_6 = var_3.RemoveListener

	WorldTaskProxy = var_6

	var_6_6(var_6_5, var_6.EventUpdateTask, arg_6_0.onUpdateTask)

	local var_6_7 = arg_6_0.taskProxy

	var_3.Dispose(var_6_7)

	local var_6_8 = arg_6_0.atlas

	var_3.Dispose(var_6_8)
	arg_6_0:Clear()

	return var_6_0
end

function var_0_1.InheritReset(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	if arg_7_1.progress then
		arg_7_0:UpdateProgress(arg_7_1.progress)

		arg_7_1.progress = nil
	end

	pairs = var_2

	for iter_7_0, iter_7_1 in var_2(arg_7_1) do
		arg_7_0[iter_7_0] = iter_7_1
	end

	pairs = var_2

	for iter_7_2, iter_7_3 in var_2(var_0_1.InheritNameList) do
		if not arg_7_1[iter_7_2] then
			arg_7_0[iter_7_2] = iter_7_3()
		end
	end

	return
end

function var_0_1.UsePortNShop(arg_8_0)
	local var_8_0

	if arg_8_0:IsReseted() then
		var_8_0 = arg_8_0.activateTime
		WorldConst = var_1_10002
		var_8_0 = var_8_0 >= var_1_10002.GetNShopTimeStamp()
	end

	return var_8_0
end

function var_0_1.IsReseted(arg_9_0)
	return arg_9_0.activateCount > (arg_9_0:IsActivate() and 1 or 0)
end

function var_0_1.IsActivate(arg_10_0)
	local var_10_0 = arg_10_0.type

	World = var_1_10002

	if var_10_0 == var_1_10002.TypeBase then
		var_10_0 = #arg_10_0.baseShipIds > 0

		return var_10_0
	else
		tobool = var_10_0

		return var_10_0(arg_10_0:GetActiveMap())
	end

	return
end

function var_0_1.CheckResetProgress(arg_11_0)
	pg = var_1_10001

	return var_1_10001.gameset.world_resetting_stage.key_value <= arg_11_0.progress
end

function var_0_1.GetResetWaitingTime(arg_12_0)
	local var_12_0 = arg_12_0.expiredTime

	pg = var_1_10002

	local var_12_1 = var_1_10002.TimeMgr.GetInstance()

	return var_12_0 - var_2.GetServerTime(var_12_1)
end

function var_0_1.CheckReset(arg_13_0, arg_13_1)
	local var_13_0

	if arg_13_0:IsActivate() and (arg_13_1 or arg_13_0:CheckResetProgress()) then
		var_13_0 = arg_13_0:GetResetWaitingTime() < 0
	end

	return var_13_0
end

function var_0_1.GetAtlas(arg_14_0)
	return arg_14_0.atlas
end

function var_0_1.GetEntrance(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.atlas

	return var_2.GetEntrance(var_15_0, arg_15_1)
end

function var_0_1.GetActiveEntrance(arg_16_0)
	local var_16_0 = arg_16_0.atlas

	return var_1.GetActiveEntrance(var_16_0)
end

function var_0_1.GetMap(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.atlas

	return var_2.GetMap(var_17_0, arg_17_1)
end

function var_0_1.GetActiveMap(arg_18_0)
	local var_18_0 = arg_18_0.atlas

	return var_1.GetActiveMap(var_18_0)
end

function var_0_1.OnSwitchMap(arg_19_0)
	arg_19_0:ResetRound()

	if arg_19_0.submarineSupport then
		pg = var_1

		local var_19_0 = var_1.TipsMgr.GetInstance()
		local var_19_1 = var_1.ShowTips

		i18n = var_1_10004

		var_19_1(var_19_0, var_1_10004("world_instruction_submarine_5"))
		arg_19_0:ResetSubmarine()
		arg_19_0:UpdateSubmarineSupport(false)
	end

	arg_19_0:DispatchEvent(var_0_1.EventSwitchMap)

	print = var_1

	local var_19_2 = "switch 2 map: "
	local var_19_3 = arg_19_0
	local var_19_4 = arg_19_0.GetActiveMap(var_19_3).id
	local var_19_5 = ", "

	tostring = var_19_3

	var_1(var_19_2 .. var_19_4 .. var_19_5 .. var_19_3(arg_19_0:GetActiveMap().gid))

	return
end

function var_0_1.GetRound(arg_20_0)
	return arg_20_0.roundIndex % 2
end

function var_0_1.IncRound(arg_21_0)
	arg_21_0.roundIndex = arg_21_0.roundIndex + 1

	return
end

function var_0_1.ResetRound(arg_22_0)
	arg_22_0.roundIndex = 0

	return
end

function var_0_1.UpdateProgress(arg_23_0, arg_23_1)
	if arg_23_1 > arg_23_0.progress then
		local var_23_0 = arg_23_0.progress

		arg_23_0.progress = arg_23_1

		local var_23_1 = arg_23_0.atlas

		var_3.UpdateProgress(var_23_1, var_23_0, arg_23_1)
		arg_23_0:DispatchEvent(var_0_1.EventUpdateProgress)
	end

	return
end

function var_0_1.GetProgress(arg_24_0)
	return arg_24_0.progress
end

function var_0_1.SetRealm(arg_25_0, arg_25_1)
	if arg_25_0.realm ~= arg_25_1 then
		arg_25_0.realm = arg_25_1
	end

	return
end

function var_0_1.GetRealm(arg_26_0)
	return 1
end

function var_0_1.CanCallSubmarineSupport(arg_27_0)
	return arg_27_0:GetSubmarineFleet()
end

function var_0_1.IsSubmarineSupporting(arg_28_0)
	return arg_28_0.submarineSupport
end

function var_0_1.UpdateSubmarineSupport(arg_29_0, arg_29_1)
	arg_29_0.submarineSupport = arg_29_1

	arg_29_0:DispatchEvent(var_0_1.EventUpdateSubmarineSupport)

	return
end

function var_0_1.GetSubAidFlag(arg_30_0)
	local var_30_1

	if arg_30_0:IsSubmarineSupporting() then
		local var_30_0 = arg_30_0:GetSubmarineFleet()

		var_30_1 = var_1.GetAmmo(var_30_0) > 0
	end

	return var_30_1
end

function var_0_1.ResetSubmarine(arg_31_0)
	if arg_31_0:GetSubmarineFleet() then
		var_1:RepairSubmarine()
	end

	return
end

function var_0_1.SetFleets(arg_32_0, arg_32_1)
	arg_32_0.fleets = arg_32_1
	pg = var_1_10002

	local var_32_0 = var_1_10002.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_32_0, "inWorld")

	return
end

function var_0_1.GetFleets(arg_33_0)
	_ = var_1_10001

	return var_1_10001.rest(arg_33_0.fleets, 1)
end

function var_0_1.GetFleet(arg_34_0, arg_34_1)
	if arg_34_1 then
		_ = var_1_10002

		local var_34_1

		if not var_1_10002.detect(arg_34_0.fleets, function(arg_35_0)
			return arg_35_0.id == arg_34_1
		end) then
			local var_34_0 = arg_34_0:GetActiveMap()

			var_34_1 = var_2.GetFleet(var_34_0)
		end

		return var_34_1
	end
end

function var_0_1.GetNormalFleets(arg_36_0)
	_ = var_1_10001

	return var_1_10001.filter(arg_36_0.fleets, function(arg_37_0)
		local var_37_0 = arg_37_0:GetFleetType()

		FleetType = var_2_10002

		return var_37_0 == var_2_10002.Normal
	end)
end

function var_0_1.GetSubmarineFleet(arg_38_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_38_0.fleets, function(arg_39_0)
		local var_39_0 = arg_39_0:GetFleetType()

		FleetType = var_2_10002

		return var_39_0 == var_2_10002.Submarine
	end)
end

function var_0_1.GetShips(arg_40_0)
	local var_40_0 = {}

	_ = var_1_10002

	var_1_10002.each(arg_40_0:GetFleets(), function(arg_41_0)
		_ = var_2_10001

		var_2_10001.each(arg_41_0:GetShips(true), function(arg_42_0)
			table = var_3_10001

			var_3_10001.insert(var_40_0, arg_42_0)

			return
		end)

		return
	end)

	return var_40_0
end

function var_0_1.GetShipVOs(arg_43_0)
	local var_43_0 = arg_43_0.type

	World = var_1_10002

	if var_43_0 == var_1_10002.TypeBase then
		underscore = var_43_0

		return var_43_0.map(arg_43_0.baseShipIds, function(arg_44_0)
			WorldConst = var_2_10001

			return var_2_10001.FetchShipVO(arg_44_0)
		end)
	else
		_ = var_43_0

		return var_43_0.map(arg_43_0:GetShips(), function(arg_45_0)
			WorldConst = var_2_10001

			return var_2_10001.FetchShipVO(arg_45_0.id)
		end)
	end

	return
end

function var_0_1.GetShip(arg_46_0, arg_46_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_46_0:GetShips(), function(arg_47_0)
		return arg_47_0.id == arg_46_1
	end)
end

function var_0_1.GetShipVO(arg_48_0, arg_48_1)
	if arg_48_0:GetShip(arg_48_1) then
		::label_48_0::

		WorldConst = var_1_10003
		var_1_10003 = var_1_10003.FetchShipVO(var_2.id)
	end

	return var_1_10003
end

function var_0_1.SetDefaultFleets(arg_49_0, arg_49_1)
	arg_49_0.defaultFleets = arg_49_1

	return
end

function var_0_1.GetDefaultFleets(arg_50_0)
	underscore = var_1_10001

	return var_1_10001.rest(arg_50_0.defaultFleets, 1)
end

function var_0_1.TransDefaultFleets(arg_51_0)
	underscore = var_1_10001
	arg_51_0.defaultFleets = var_1_10001.map(arg_51_0.fleets, function(arg_52_0)
		local var_52_0 = arg_52_0
		local var_52_1 = arg_52_0.Trans

		WorldBaseFleet = var_2_10004

		return var_52_1(var_52_0, var_2_10004)
	end)

	return
end

function var_0_1.GetLevel(arg_53_0)
	_ = var_1_10001

	local var_53_0 = var_1_10001(arg_53_0:GetFleets())
	local var_53_1 = var_1.chain(var_53_0)
	local var_53_2 = var_1.map(var_53_1, function(arg_54_0)
		return arg_54_0:GetLevel()
	end)
	local var_53_3 = var_1.max(var_53_2)

	return var_1.value(var_53_3)
end

function var_0_1.GetWorldPower(arg_55_0)
	local var_55_0 = 0

	underscore = var_1_10002

	var_1_10002.each(arg_55_0.fleets, function(arg_56_0)
		var_55_0 = var_55_0 + arg_56_0:GetGearScoreSum()

		return
	end)

	math = var_2

	local var_55_1 = var_2.floor
	local var_55_2 = arg_55_0:GetWorldMapBuffAverageLevel()

	pg = var_5

	return var_55_1(var_55_0 * (1 + var_55_2 / var_5.gameset.world_strength_correct.key_value))
end

function var_0_1.GetWorldRank(arg_57_0)
	local var_57_0 = 0

	underscore = var_1_10002

	local var_57_1 = var_1_10002.map(arg_57_0:GetNormalFleets(), function(arg_58_0)
		return arg_58_0:GetLevelCount() / 6
	end)

	pg = var_1_10003

	local var_57_2 = var_1_10003.gameset.world_level_correct.description

	ipairs = var_4

	for iter_57_0, iter_57_1 in var_4(var_57_1) do
		var_57_0 = var_57_0 + iter_57_1 * var_57_2[iter_57_0]
	end

	local var_57_3 = arg_57_0

	if arg_57_0.GetSubmarineFleet(var_57_3) then
		var_57_0 = var_57_0 + var_4:GetLevelCount() / 3 * var_57_2[5]
	end

	local var_57_4 = arg_57_0
	local var_57_5 = var_57_0 * arg_57_0.GetWorldMapBuffAverageLevel(var_57_4)
	local var_57_6

	pg = var_57_3

	local var_57_7 = var_57_3.gameset.world_suggest_level.description

	ipairs = var_57_4

	for iter_57_2, iter_57_3 in var_57_4(var_57_7) do
		if var_57_5 < iter_57_3 then
			break
		else
			var_57_6 = iter_57_2
		end
	end

	return var_57_6
end

function var_0_1.GetBossProxy(arg_59_0)
	return arg_59_0.worldBossProxy
end

function var_0_1.GetTaskProxy(arg_60_0)
	return arg_60_0.taskProxy
end

function var_0_1.GetInventoryProxy(arg_61_0)
	return arg_61_0.inventoryProxy
end

function var_0_1.GetCollectionProxy(arg_62_0)
	return arg_62_0.collectionProxy
end

function var_0_1.VerifyFormation(arg_63_0)
	local var_63_0 = {}

	_ = var_1_10002

	var_1_10002.each(arg_63_0:GetShips(), function(arg_64_0)
		local var_64_0 = var_63_0
		local var_64_1 = arg_64_0.id
		local var_64_2

		if not var_63_0[arg_64_0.id] then
			var_64_2 = 0
		end

		var_64_0[var_64_1] = var_64_2 + 1
		assert = var_64_0

		var_64_0(var_63_0[arg_64_0.id] <= 1, "repeated ship id: " .. arg_64_0.id)

		return
	end)

	return
end

function var_0_1.CalcRepairCost(arg_65_0, arg_65_1)
	WorldConst = var_1_10002

	local var_65_0 = var_1_10002.FetchShipVO(arg_65_1.id).level - arg_65_0:GetLevel()

	if arg_65_1:IsBroken() then
		pg = var_4

		local var_65_1 = var_4.gameset.world_port_service_2_interval.description

		_ = var_1_10005

		if not var_1_10005.detect(var_65_1, function(arg_66_0)
			return arg_66_0[1] >= var_65_0
		end) then
			var_1_10005 = var_65_1[#var_65_1]
		end

		local var_65_2 = var_1_10005[2]

		pg = var_7

		return var_65_2 * var_7.gameset.world_port_service_2_price.key_value
	else
		local var_65_3 = arg_65_1

		if not arg_65_1.IsHpFull(var_65_3) then
			pg = var_4

			local var_65_4 = var_4.gameset.world_port_service_1_interval.description

			pg = var_1_10005

			local var_65_5 = var_1_10005.gameset.world_port_service_1_price.description

			_ = var_65_3

			local var_65_6

			if not var_65_3.detect(var_65_4, function(arg_67_0)
				return arg_67_0[1] >= var_65_0
			end) then
				var_65_6 = var_65_4[#var_65_4]
			end

			local var_65_7 = var_65_6[2]

			_ = var_8

			local var_65_8

			if not var_8.detect(var_65_5, function(arg_68_0)
				return arg_68_0[1] >= arg_65_1.hpRant
			end) then
				var_65_8 = var_65_5[#var_65_5]
			end

			return var_65_7 * var_65_8[2]
		end
	end

	return 0
end

function var_0_1.GetMoveRange(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0:GetActiveMap()

	if var_2.CanLongMove(var_69_0, arg_69_1) then
		return var_2:GetLongMoveRange(arg_69_1)
	else
		return var_2:GetMoveRange(arg_69_1)
	end

	return
end

function var_0_1.IsRookie(arg_70_0)
	return arg_70_0.activateCount == 0 and arg_70_0.progress <= 0
end

function var_0_1.EntranceToReplacementMapList(arg_71_0, arg_71_1)
	local var_71_0 = {}

	ipairs = var_1_10003

	for iter_71_0, iter_71_1 in var_1_10003(arg_71_1.config.stage_chapter) do
		if arg_71_0:GetProgress() >= iter_71_1[1] and arg_71_0:GetProgress() <= iter_71_1[2] then
			table = var_8

			var_8.insert(var_71_0, arg_71_0:GetMap(iter_71_1[3]))
		end
	end

	ipairs = var_3

	for iter_71_2, iter_71_3 in var_3(arg_71_1.config.task_chapter) do
		local var_71_1 = arg_71_0.taskProxy

		if var_8.getTaskById(var_71_1, iter_71_3[1]) and var_8:isAlive() then
			table = var_9

			var_9.insert(var_71_0, arg_71_0:GetMap(iter_71_3[2]))
		end
	end

	if arg_71_1.becomeSairen then
		table = var_3

		var_3.insert(var_71_0, arg_71_0:GetMap(arg_71_1.config.sairen_chapter[1]))
	end

	ipairs = var_3

	for iter_71_4, iter_71_5 in var_3(arg_71_1.config.teasure_chapter) do
		local var_71_2 = arg_71_0.inventoryProxy

		if var_8.GetItemCount(var_71_2, iter_71_5[1]) > 0 then
			table = var_8

			var_8.insert(var_71_0, arg_71_0:GetMap(iter_71_5[2]))
		end
	end

	local var_71_3 = arg_71_1
	local var_71_4

	if arg_71_1.GetBaseMap(var_71_3).isPressing then
		var_71_4 = #arg_71_1.config.complete_chapter

		if 0 < var_71_4 then
			table = var_71_4

			var_71_4.insert(var_71_0, arg_71_0:GetMap(arg_71_1.config.complete_chapter[1]))
		end
	end

	table = var_71_4

	var_71_4.insert(var_71_0, var_3)

	if arg_71_1.active then
		underscore = var_4

		if not var_4.any(var_71_0, function(arg_72_0)
			return arg_72_0.active
		end) then
			table = var_4

			var_4.insert(var_71_0, arg_71_0:GetActiveMap())
		end
	end

	local var_71_5 = {}

	underscore = var_71_3

	return (var_71_3.filter(var_71_0, function(arg_73_0)
		if var_71_5[arg_73_0.id] then
			return false
		else
			var_71_5[arg_73_0.id] = true

			return true
		end

		return
	end))
end

function var_0_1.ReplacementMapType(arg_74_0, arg_74_1)
	ipairs = var_1_10002

	for iter_74_0, iter_74_1 in var_1_10002(arg_74_0.config.stage_chapter) do
		if iter_74_1[3] == arg_74_1.id then
			local var_74_0 = "stage_chapter"

			i18n = var_8

			local var_74_1 = var_8("area_zhuxian")

			return
		end
	end

	ipairs = var_2

	for iter_74_2, iter_74_3 in var_2(arg_74_0.config.task_chapter) do
		if iter_74_3[2] == arg_74_1.id then
			pg = var_7

			if var_7.world_task_data[iter_74_3[1]].type == 0 then
				local var_74_2 = "task_chapter"

				i18n = var_1_10009
				var_1_10009 = var_1_10009("area_zhuxian")

				return
			elseif var_7 == 6 then
				local var_74_3 = "task_chapter"

				i18n = var_1_10009
				var_1_10009 = var_1_10009("area_dangan")

				return
			else
				local var_74_4 = "task_chapter"

				i18n = var_1_10009
				var_1_10009 = var_1_10009("area_renwu")

				return
			end
		end
	end

	ipairs = var_2

	for iter_74_4, iter_74_5 in var_2(arg_74_0.config.teasure_chapter) do
		if iter_74_5[2] == arg_74_1.id then
			pg = var_7

			local var_74_5 = var_7.world_item_data_template[iter_74_5[1]].usage_arg[1] == 1
			local var_74_6 = "teasure_chapter"

			if var_74_5 then
				i18n = var_1_10010

				if not var_1_10010("area_shenyuan") then
					i18n = var_1_10010
					var_1_10010 = var_1_10010("area_yinmi")
				end

				return var_74_6, var_1_10010
			end
		end
	end

	if arg_74_0.config.sairen_chapter[1] == arg_74_1.id then
		local var_74_7 = "sairen_chapter"

		i18n = var_3

		local var_74_8 = var_3("area_yaosai")

		return
	end

	if arg_74_0.config.complete_chapter[1] == arg_74_1.id then
		local var_74_9 = "complete_chapter"

		i18n = var_3

		local var_74_10 = var_3("area_anquan")

		return
	end

	local var_74_12

	if arg_74_0:GetBaseMapId() == arg_74_1.id then
		local var_74_11 = "base_chapter"

		i18n = var_74_12
		var_74_12 = var_74_12("area_putong")

		return
	end

	local var_74_13 = "test_chapter"

	i18n = var_74_12

	local var_74_14 = var_74_12("area_unkown")
end

function var_0_1.FindTreasureEntrance(arg_75_0, arg_75_1)
	underscore = var_1_10002

	local var_75_0 = var_1_10002.values
	local var_75_1 = arg_75_0.atlas

	return var_75_0(var_4.GetTreasureDic(var_75_1, arg_75_1))[1]
end

function var_0_1.TreasureMap2ItemId(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0 = arg_76_0:GetEntrance(arg_76_2)

	ipairs = var_1_10004

	for iter_76_0, iter_76_1 in var_1_10004(var_76_0.config.teasure_chapter) do
		if iter_76_1[2] == arg_76_1 then
			return iter_76_1[1]
		end
	end

	return
end

function var_0_1.CheckFleetMovable(arg_77_0)
	local var_77_0 = arg_77_0:GetActiveMap()
	local var_77_1 = var_1.GetFleet(var_77_0)
	local var_77_2 = arg_77_0:GetRound()

	WorldConst = var_77_0

	local var_77_3

	if var_77_2 == var_77_0.RoundPlayer then
		if var_1:CheckFleetMovable(var_77_1) then
			var_77_3 = not var_1:CheckInteractive()
		end
	else
		var_77_3 = false
	end

	if false then
		var_77_3 = true
	end

	return var_77_3
end

function var_0_1.SetAchieveSuccess(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = arg_78_0.achieveEntranceStar
	local var_78_1

	if not arg_78_0.achieveEntranceStar[arg_78_1] then
		var_78_1 = {}
	end

	var_78_0[arg_78_1] = var_78_1
	arg_78_0.achieveEntranceStar[arg_78_1][arg_78_2] = true

	return
end

function var_0_1.GetMapAchieveStarDic(arg_79_0, arg_79_1)
	local var_79_0

	if not arg_79_0.achieveEntranceStar[arg_79_1] then
		var_79_0 = {}
	end

	return var_79_0
end

function var_0_1.GetAchievement(arg_80_0, arg_80_1)
	if not arg_80_0.achievements[arg_80_1] then
		local var_80_0 = arg_80_0.achievements

		WorldAchievement = var_1_10003
		var_80_0[arg_80_1] = var_1_10003.New()

		local var_80_1 = arg_80_0.achievements[arg_80_1]

		var_2.Setup(var_80_1, arg_80_1)
	end

	return arg_80_0.achievements[arg_80_1]
end

function var_0_1.GetAchievements(arg_81_0, arg_81_1)
	local var_81_0 = {}

	_ = var_1_10003

	var_1_10003.each(arg_81_1.config.normal_target, function(arg_82_0)
		table = var_2_10001

		local var_82_0 = var_2_10001.insert
		local var_82_1 = var_81_0
		local var_82_2 = arg_81_0

		var_82_0(var_82_1, var_4.GetAchievement(var_82_2, arg_82_0))

		return
	end)

	_ = var_3

	var_3.each(arg_81_1.config.cryptic_target, function(arg_83_0)
		table = var_2_10001

		local var_83_0 = var_2_10001.insert
		local var_83_1 = var_81_0
		local var_83_2 = arg_81_0

		var_83_0(var_83_1, var_4.GetAchievement(var_83_2, arg_83_0))

		return
	end)

	return var_81_0
end

function var_0_1.IsNormalAchievementAchieved(arg_84_0, arg_84_1)
	return arg_84_0:CountAchievements(arg_84_1) >= #arg_84_1.config.normal_target
end

function var_0_1.AnyUnachievedAchievement(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_0:GetMapAchieveStarDic(arg_85_1.id)

	_ = var_1_10003

	if var_1_10003.detect(arg_85_1:GetAchievementAwards(), function(arg_86_0)
		return not var_85_0[arg_86_0.star]
	end) then
		local var_85_1, var_85_2 = arg_85_0:CountAchievements(arg_85_1)

		return var_85_1 + var_85_2 >= var_3.star, var_3
	end

	return
end

function var_0_1.GetFinishAchievements(arg_87_0, arg_87_1)
	if not arg_87_1 then
		var_1_10004 = arg_87_0.atlas
		arg_87_1 = var_2.GetAchEntranceList(var_1_10004)
	end

	local var_87_0 = {}
	local var_87_1 = {}

	ipairs = var_1_10004

	for iter_87_0, iter_87_1 in var_1_10004(arg_87_1) do
		local var_87_2, var_87_3 = arg_87_0:CountAchievements(iter_87_1)
		local var_87_4 = arg_87_0
		local var_87_5 = arg_87_0.GetMapAchieveStarDic(var_87_4, iter_87_1.id)
		local var_87_6 = {}

		ipairs = var_87_4

		for iter_87_2, iter_87_3 in var_87_4(iter_87_1:GetAchievementAwards()) do
			if not var_87_5[iter_87_3.star] and var_87_2 + var_87_3 >= iter_87_3.star then
				table = var_18

				var_18.insert(var_87_6, iter_87_3.star)
			end
		end

		if #var_87_6 > 0 then
			table = var_13

			var_13.insert(var_87_0, {
				id = iter_87_1.id,
				star_list = var_87_6
			})

			table = var_13

			var_13.insert(var_87_1, iter_87_1.id)
		end
	end

	return var_87_0, var_87_1
end

function var_0_1.CountAchievements(arg_88_0, arg_88_1)
	local var_88_0 = 0
	local var_88_1 = 0
	local var_88_2 = 0
	local var_88_4

	if not arg_88_1 or not {
		arg_88_1
	} then
		local var_88_3 = arg_88_0.atlas

		var_88_4 = var_5.GetAchEntranceList(var_88_3)
	end

	ipairs = var_1_10006

	for iter_88_0, iter_88_1 in var_1_10006(var_88_4) do
		ipairs = var_1_10011

		for iter_88_2, iter_88_3 in var_1_10011(iter_88_1.config.normal_target) do
			local var_88_6

			if arg_88_0.achievements[iter_88_3] then
				local var_88_5 = arg_88_0.achievements[iter_88_3]

				if var_16.IsAchieved(var_88_5) then
					var_88_6 = 1

					goto label_88_0
				end
			end

			var_88_6 = 0

			::label_88_0::

			var_88_0 = var_88_0 + var_88_6
		end

		ipairs = var_1_10011

		for iter_88_4, iter_88_5 in var_1_10011(iter_88_1.config.cryptic_target) do
			local var_88_8

			if arg_88_0.achievements[iter_88_5] then
				local var_88_7 = arg_88_0.achievements[iter_88_5]

				if var_16.IsAchieved(var_88_7) then
					var_88_8 = 1

					goto label_88_1
				end
			end

			var_88_8 = 0

			::label_88_1::

			var_88_1 = var_88_1 + var_88_8
		end

		var_88_2 = var_88_2 + #iter_88_1.config.normal_target + #iter_88_1.config.cryptic_target
	end

	return var_88_0, var_88_1, var_88_2
end

local function var_0_2()
	local var_89_0 = {}

	TeamType = var_1_10001
	var_89_0[var_1_10001.Main] = {}
	TeamType = var_1
	var_89_0[var_1.Vanguard] = {}
	TeamType = var_1
	var_89_0[var_1.Submarine] = {}
	var_89_0.commanders = {}

	return var_89_0
end

function var_0_1.BuildFormationIds(arg_90_0)
	local var_90_0 = {}

	FleetType = var_1_10002
	var_90_0[var_1_10002.Normal] = {}
	FleetType = var_2
	var_90_0[var_2.Submarine] = {}

	local var_90_1 = {}

	FleetType = var_3
	var_90_1[var_3.Normal] = 2
	FleetType = var_3
	var_90_1[var_3.Submarine] = 0
	ipairs = var_3
	pg = var_1_10005

	for iter_90_0, iter_90_1 in var_3(var_1_10005.world_stage_template.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.world_stage_template[iter_90_1]
		iter_90_6 = arg_90_0

		local var_90_2 = arg_90_0.GetProgress(iter_90_6)

		if var_1_10008.stage_key <= var_90_2 then
			FleetType = var_90_2

			local var_90_3 = var_90_2.Normal

			math = var_10

			local var_90_4 = var_10.max

			FleetType = var_1_10012
			var_90_1[var_90_3] = var_90_4(var_90_1[var_1_10012.Normal], var_1_10008.fleet_num)
		else
			break
		end
	end

	local var_90_5 = arg_90_0
	local var_90_6 = arg_90_0.IsSystemOpen

	WorldConst = iter_90_0

	if var_90_6(var_90_5, iter_90_0.SystemSubmarine) then
		FleetType = var_3
		var_90_1[var_3.Submarine] = 1
	end

	ipairs = var_3

	local var_90_7

	if not arg_90_0:IsActivate() or not arg_90_0:GetFleets() then
		var_90_7 = arg_90_0:GetDefaultFleets()
	end

	for iter_90_2, iter_90_3 in var_3(var_90_7) do
		if #var_90_0[iter_90_3:GetFleetType()] < var_90_1[var_8] then
			table = var_9

			var_9.insert(var_90_0[var_8], iter_90_3:BuildFormationIds())
		end
	end

	pairs = var_3

	for iter_90_4, iter_90_5 in var_3(var_90_0) do
		for iter_90_6 = 1, var_90_1[iter_90_4] do
			local var_90_8

			if not iter_90_5[iter_90_6] then
				var_90_8 = var_0_2()
			end

			iter_90_5[iter_90_6] = var_90_8
		end
	end

	local var_90_9
	local var_90_10 = arg_90_0:GetTaskProxy()
	local var_90_11 = var_4.getTasks(var_90_10)

	pairs = var_5

	for iter_90_7, iter_90_8 in var_5(var_90_11) do
		local var_90_12 = iter_90_8.config.complete_condition

		WorldConst = iter_90_6

		if var_90_12 == iter_90_6.TaskTypeFleetExpansion and iter_90_8:isAlive() then
			var_90_9 = iter_90_8.config.complete_parameter[1]

			break
		end
	end

	if var_90_9 then
		FleetType = var_5

		for iter_90_9 = #var_90_0[var_5.Normal] + 1, var_90_9 do
			FleetType = iter_90_8
			iter_90_8 = var_90_0[iter_90_8.Normal]
			iter_90_8[iter_90_9] = var_0_2()
		end
	end

	local var_90_13 = 0

	pairs = var_6

	for iter_90_10, iter_90_11 in var_6(var_90_0) do
		var_90_13 = var_90_13 + #iter_90_11
	end

	if var_90_9 then
		WorldConst = var_90_14

		local var_90_14

		if not var_90_14.FleetExpansion then
			WorldConst = var_90_14
			var_90_14 = var_90_14.FleetRedeploy
		end

		return var_90_14, var_90_0, var_90_13
	end
end

function var_0_1.FormationIds2NetIds(arg_91_0, arg_91_1)
	local var_91_0 = {}

	ipairs = var_1_10003

	local var_91_1 = {}

	FleetType = var_1_10006
	var_91_1[1] = var_1_10006.Normal
	FleetType = var_6
	var_91_1[2] = var_6.Submarine

	for iter_91_0, iter_91_1 in var_1_10003(var_91_1) do
		ipairs = var_1_10008

		for iter_91_2, iter_91_3 in var_1_10008(arg_91_1[iter_91_1]) do
			local var_91_2 = {}

			ipairs = var_1_10014

			local var_91_3 = {}

			TeamType = iter_91_4
			var_91_3[1] = iter_91_4.Main
			TeamType = iter_91_4
			var_91_3[2] = iter_91_4.Vanguard
			TeamType = iter_91_4
			var_91_3[3] = iter_91_4.Submarine

			for iter_91_4, iter_91_5 in var_1_10014(var_91_3) do
				for iter_91_6 = 1, 3 do
					if iter_91_3[iter_91_5][iter_91_6] then
						table = var_23

						var_23.insert(var_91_2, iter_91_3[iter_91_5][iter_91_6])
					end
				end
			end

			if #var_91_2 > 0 then
				table = var_1_10014
				var_1_10014 = var_1_10014.insert

				local var_91_4 = var_91_0

				iter_91_4 = {
					ship_id_list = var_91_2
				}
				Clone = iter_91_5
				iter_91_4.commanders = iter_91_5(iter_91_3.commanders)

				var_1_10014(var_91_4, iter_91_4)
			end
		end
	end

	return var_91_0
end

function var_0_1.CompareRedeploy(arg_92_0, arg_92_1)
	local var_92_0 = {}

	TeamType = var_1_10003
	var_92_0[1] = var_1_10003.Main
	TeamType = var_3
	var_92_0[2] = var_3.Vanguard
	TeamType = var_3
	var_92_0[3] = var_3.Submarine

	local var_92_1 = {}
	local var_92_2 = 0

	pairs = var_1_10005

	for iter_92_0, iter_92_1 in var_1_10005(arg_92_1) do
		ipairs = var_1_10010

		for iter_92_2, iter_92_3 in var_1_10010(iter_92_1) do
			ipairs = var_1_10015

			for iter_92_4, iter_92_5 in var_1_10015(var_92_0) do
				for iter_92_6 = 1, 3 do
					if iter_92_3[iter_92_5][iter_92_6] and not var_92_1[var_24] then
						var_92_1[var_24] = true
						var_92_2 = var_92_2 + 1
					end
				end
			end
		end
	end

	local var_92_3 = {}
	local var_92_4 = 0

	ipairs = var_7

	for iter_92_7, iter_92_8 in var_7(arg_92_0:GetFleets()) do
		ipairs = var_1_10012

		for iter_92_9, iter_92_10 in var_1_10012(var_92_0) do
			local var_92_5 = iter_92_8:GetTeamShips(iter_92_10, true)

			ipairs = iter_92_4

			for iter_92_11, iter_92_12 in iter_92_4(var_92_5) do
				if not var_92_3[iter_92_12.id] then
					var_92_3[iter_92_12.id] = true
					var_92_4 = var_92_4 + 1
				end
			end
		end
	end

	if var_92_4 ~= var_92_2 then
		return true
	end

	pairs = var_7

	for iter_92_13, iter_92_14 in var_7(var_92_3) do
		if not var_92_1[iter_92_13] then
			return true
		end
	end

	pairs = var_7

	for iter_92_15, iter_92_16 in var_7(var_92_1) do
		if not var_92_3[iter_92_15] then
			return true
		end
	end

	return false
end

function var_0_1.IsSystemOpen(arg_93_0, arg_93_1)
	local var_93_0 = arg_93_0:GetRealm()

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_93_0, iter_93_1 in var_1_10003(var_1_10005.world_stage_template.all) do
		pg = var_1_10008

		if var_1_10008.world_stage_template[iter_93_1].stage_ui[1] == arg_93_1 and (var_1_10008.stage_ui[2] == 0 or var_1_10008.stage_ui[2] == var_93_0) then
			return arg_93_0:GetProgress() >= var_1_10008.stage_key
		end
	end

	return true
end

function var_0_1.CalcCDTimeCost(arg_94_0, arg_94_1, arg_94_2)
	math = var_1_10003

	local var_94_0 = var_1_10003.max

	pg = var_1_10005

	local var_94_1 = var_1_10005.TimeMgr.GetInstance()
	local var_94_2 = var_94_0(var_5.GetServerTime(var_94_1) - arg_94_1, 0)

	math = var_1_10004

	local var_94_3 = var_1_10004.floor
	local var_94_4 = arg_94_0[1]

	math = var_94_1

	local var_94_5 = var_94_4 * var_94_1.max(arg_94_0[2] - var_94_2, 0) / arg_94_0[2]

	math = var_7

	return var_94_3(var_94_5 * var_7.max(16 - arg_94_2, 0) / 16)
end

function var_0_1.GetReqCDTime(arg_95_0, arg_95_1)
	local var_95_0

	if not arg_95_0.cdTimeList[arg_95_1] then
		var_95_0 = 0
	end

	return var_95_0
end

function var_0_1.SetReqCDTime(arg_96_0, arg_96_1, arg_96_2)
	arg_96_0.cdTimeList[arg_96_1] = arg_96_2

	return
end

function var_0_1.InitWorldShopGoods(arg_97_0)
	arg_97_0.goodDic = {}
	ipairs = var_1

	local var_97_0 = {}

	ShopArgs = var_1_10004
	var_97_0[1] = var_1_10004.WorldShop
	ShopArgs = var_4
	var_97_0[2] = var_4.WorldCollection

	for iter_97_0, iter_97_1 in var_1(var_97_0) do
		ipairs = var_1_10006
		pg = var_1_10008

		for iter_97_2, iter_97_3 in var_1_10006(var_1_10008.shop_template.get_id_list_by_genre[iter_97_1]) do
			arg_97_0.goodDic[iter_97_3] = 0
		end
	end

	return
end

function var_0_1.UpdateWorldShopGoods(arg_98_0, arg_98_1)
	_ = var_1_10002

	var_1_10002.each(arg_98_1, function(arg_99_0)
		assert = var_2_10001

		var_2_10001(arg_98_0.goodDic[arg_99_0.goods_id], "without this good in id " .. arg_99_0.goods_id)

		arg_98_0.goodDic[arg_99_0.goods_id] = arg_98_0.goodDic[arg_99_0.goods_id] + arg_99_0.count

		return
	end)
	arg_98_0:DispatchEvent(var_0_1.EventUpdateShopGoods, arg_98_0.goodDic)

	return
end

function var_0_1.GetWorldShopGoodsDictionary(arg_100_0)
	return arg_100_0.goodDic
end

function var_0_1.InitWorldColorDictionary(arg_101_0)
	arg_101_0.colorDic = {}
	_ = var_1

	local var_101_0 = var_1.each

	pg = var_1_10003

	var_101_0(var_1_10003.world_chapter_colormask.all, function(arg_102_0)
		pg = var_2_10001

		local var_102_0 = var_2_10001.world_chapter_colormask[arg_102_0]

		Color = var_2_10002

		local var_102_1 = var_2_10002.New(var_102_0.color[1] / 255, var_102_0.color[2] / 255, var_102_0.color[3] / 255)

		arg_101_0.colorDic[var_102_1:ToHex()] = var_102_0.id

		return
	end)

	return
end

function var_0_1.ColorToEntrance(arg_103_0, arg_103_1)
	local var_103_0

	if arg_103_0.colorDic[arg_103_1:ToHex()] then
		var_103_0 = arg_103_0:GetEntrance(arg_103_0.colorDic[arg_103_1:ToHex()])
	end

	return var_103_0
end

function var_0_1.GetGlobalBuff(arg_104_0, arg_104_1)
	if not arg_104_0.globalBuffDic[arg_104_1] then
		WorldBuff = var_2

		local var_104_0 = var_2.New()

		var_2.Setup(var_104_0, {
			floor = 0,
			id = arg_104_1
		})

		arg_104_0.globalBuffDic[arg_104_1] = var_2
	end

	return arg_104_0.globalBuffDic[arg_104_1]
end

function var_0_1.AddGlobalBuff(arg_105_0, arg_105_1, arg_105_2)
	assert = var_1_10003

	var_1_10003(arg_105_1 and arg_105_2)

	local var_105_0 = arg_105_0:GetGlobalBuff(arg_105_1)

	var_3.AddFloor(var_105_0, arg_105_2)
	arg_105_0:DispatchEvent(var_0_1.EventUpdateGlobalBuff)

	return
end

function var_0_1.RemoveBuff(arg_106_0, arg_106_1, arg_106_2)
	assert = var_1_10003

	var_1_10003(arg_106_1)

	local var_106_0 = arg_106_0:GetGlobalBuff(arg_106_1)

	if arg_106_2 then
		var_106_0:AddFloor(arg_106_2 * -1)
	else
		arg_106_0.globalBuffDic[arg_106_1] = nil
	end

	arg_106_0:DispatchEvent(var_0_1.EventUpdateGlobalBuff)

	return
end

function var_0_1.GetWorldMapBuffLevel(arg_107_0)
	pg = var_1_10001

	local var_107_0 = var_1_10001.gameset.world_mapbuff_list.description

	_ = var_1_10002

	return var_1_10002.map(var_107_0, function(arg_108_0)
		local var_108_0 = arg_107_0

		return var_1.GetGlobalBuff(var_108_0, arg_108_0).floor
	end)
end

function var_0_1.GetWorldMapBuffAverageLevel(arg_109_0)
	local var_109_0 = arg_109_0
	local var_109_1 = arg_109_0.GetWorldMapBuffLevel(var_109_0)
	local var_109_2 = 0

	underscore = var_109_0

	var_109_0.each(var_109_1, function(arg_110_0)
		var_109_2 = var_109_2 + arg_110_0

		return
	end)

	return var_109_2 / #var_109_1
end

function var_0_1.GetWorldMapBuffs(arg_111_0)
	pg = var_1_10001

	local var_111_0 = var_1_10001.gameset.world_mapbuff_list.description

	_ = var_1_10002

	return var_1_10002.map(var_111_0, function(arg_112_0)
		local var_112_0 = arg_111_0

		return var_1.GetGlobalBuff(var_112_0, arg_112_0)
	end)
end

function var_0_1.GetWorldMapDifficultyBuffLevel(arg_113_0)
	local var_113_0 = arg_113_0:GetActiveMap().config.difficulty

	pg = var_1_10002

	return var_1_10002.gameset.world_difficult_value.description[var_113_0]
end

function var_0_1.OnUpdateItem(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	local var_114_0 = arg_114_3:getWorldItemType()

	WorldItem = var_1_10005

	if var_114_0 == var_1_10005.UsageWorldMap and arg_114_0.atlas then
		local var_114_1 = arg_114_0.atlas

		var_5.UpdateTreasure(var_114_1, arg_114_3.id)
	end

	local var_114_2 = arg_114_0.taskProxy

	var_5.doUpdateTaskByItem(var_114_2, arg_114_3)

	return
end

function var_0_1.OnUpdateTask(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	if arg_115_0.atlas then
		local var_115_0 = arg_115_0.atlas

		var_4.UpdateTask(var_115_0, arg_115_3)
	end

	return
end

function var_0_1.GetPressingAward(arg_116_0, arg_116_1)
	return arg_116_0.pressingAwardDic[arg_116_1]
end

function var_0_1.FlagMapPressingAward(arg_117_0, arg_117_1)
	if arg_117_0:GetPressingAward(arg_117_1) then
		var_2.flag = false
	end

	return
end

function var_0_1.IsMapPressingAwardFlag(arg_118_0, arg_118_1)
	return arg_118_0:GetPressingAward(arg_118_1) and var_2.flag == false
end

function var_0_1.CheckAreaUnlock(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_0.progress

	pg = var_1_10003

	return var_119_0 >= var_1_10003.world_regions_data[arg_119_1].open_stage[1]
end

function var_0_1.CheckTaskLockMap(arg_120_0)
	local var_120_0 = arg_120_0.taskProxy
	local var_120_1 = var_1.getTaskVOs(var_120_0)
	local var_120_2 = arg_120_0:GetActiveMap().gid

	_ = var_120_0

	return var_120_0.any(var_120_1, function(arg_121_0)
		local var_121_0 = arg_121_0.config.task_target_map
		local var_121_1

		if arg_121_0:isAlive() and arg_121_0:IsLockMap() then
			_ = var_121_1
			var_121_1 = var_121_1.any(var_121_0, function(arg_122_0)
				return arg_122_0 == var_120_2
			end)
		end

		return var_121_1
	end)
end

function var_0_1.CheckResetAward(arg_123_0, arg_123_1)
	arg_123_0.resetAward = arg_123_1
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_123_0 = var_1_10002(var_1_10004)
	local var_123_1 = var_2.getData(var_123_0)
	local var_123_2 = var_2.getResource

	WorldConst = var_1_10005

	local var_123_3 = var_123_2(var_123_1, var_1_10005.ResourceID)

	pg = var_1_10003

	if var_123_3 == var_1_10003.gameset.world_resource_max.key_value then
		arg_123_0.resetLimitTip = true
	end

	return
end

function var_0_1.ClearResetAward(arg_124_0)
	arg_124_0.resetAward = nil
	arg_124_0.resetLimitTip = nil

	return
end

function var_0_1.GetTargetMapPressingCount(arg_125_0, arg_125_1)
	local var_125_0 = 0

	ipairs = var_1_10003

	for iter_125_0, iter_125_1 in var_1_10003(arg_125_1) do
		if arg_125_0:GetMap(iter_125_1).isPressing then
			var_125_0 = var_125_0 + 1
		end
	end

	return var_125_0
end

function var_0_1.ClearAllFleetDefeatEnemies(arg_126_0)
	underscore = var_1_10001

	var_1_10001.each(arg_126_0:GetFleets(), function(arg_127_0)
		arg_127_0:ClearDefeatEnemies()

		return
	end)

	return
end

function var_0_1.GetAreaEntranceIds(arg_128_0, arg_128_1)
	return arg_128_0.atlas.areaEntranceList[arg_128_1]
end

function var_0_1.CalcOrderCost(arg_129_0, arg_129_1)
	local var_129_0 = 0

	WorldConst = var_1_10003

	local var_129_1

	if arg_129_1 == var_1_10003.OpReqRedeploy then
		World = var_129_1
		var_129_1 = var_129_1.CalcCDTimeCost
		pg = var_1_10005
		var_1_10005 = var_1_10005.gameset.world_fleet_redeploy_cost.description

		local var_129_2 = arg_129_0

		var_1_10006 = arg_129_0.GetReqCDTime
		WorldConst = var_1_10009

		return var_129_1(var_1_10005, var_1_10006(var_129_2, var_1_10009.OpReqRedeploy), var_129_0)
	else
		WorldConst = var_129_1

		local var_129_3

		if arg_129_1 == var_129_1.OpReqMaintenance then
			pg = var_129_3
			var_129_3 = var_129_3.gameset.world_instruction_maintenance.description[1]
			math = var_1_10004

			return var_129_3 * var_1_10004.max(16 - var_129_0, 0) / 16
		else
			WorldConst = var_129_3

			if arg_129_1 == var_129_3.OpReqSub then
				var_1_10005 = arg_129_0

				if arg_129_0.GetSubmarineFleet(var_1_10005) then
					underscore = var_1_10004

					var_1_10004.each(var_3:GetShips(true), function(arg_130_0)
						local var_130_0 = var_129_0
						local var_130_1 = arg_130_0:GetImportWorldShipVO()
						local var_130_2 = var_2.GetStaminaDiscount

						WorldConst = var_2_10005
						var_129_0 = var_130_0 + var_130_2(var_130_1, var_2_10005.OpReqSub)

						return
					end)
				end

				World = var_1_10004

				local var_129_4 = var_1_10004.CalcCDTimeCost

				pg = var_1_10006

				local var_129_5 = var_1_10006.gameset.world_instruction_submarine.description

				var_1_10009 = arg_129_0

				local var_129_6 = arg_129_0.GetReqCDTime

				WorldConst = var_1_10010

				return var_129_4(var_129_5, var_129_6(var_1_10009, var_1_10010.OpReqSub), var_129_0)
			else
				WorldConst = var_3

				local var_129_7

				if arg_129_1 == var_3.OpReqVision then
					World = var_129_7
					var_129_7 = var_129_7.CalcCDTimeCost
					pg = var_1_10005

					local var_129_8 = var_1_10005.gameset.world_instruction_detect.description
					local var_129_9 = arg_129_0
					local var_129_10 = arg_129_0.GetReqCDTime

					WorldConst = var_1_10009

					return var_129_7(var_129_8, var_129_10(var_129_9, var_1_10009.OpReqVision), var_129_0)
				else
					assert = var_129_7

					var_129_7(false, "op type error: " .. arg_129_1)
				end
			end
		end
	end

	return
end

function var_0_1.GetDisplayPressingCount(arg_131_0)
	local var_131_0 = 0

	ipairs = var_1_10002

	for iter_131_0, iter_131_1 in var_1_10002(arg_131_0.atlas.pressingMapList) do
		local var_131_1 = arg_131_0.atlas
		local var_131_2 = var_7.GetMap(var_131_1, iter_131_1)

		if var_7.CheckMapPressingDisplay(var_131_2) then
			var_131_0 = var_131_0 + 1
		end
	end

	return var_131_0
end

function var_0_1.CheckCommanderInFleet(arg_132_0, arg_132_1)
	local var_132_0 = arg_132_0.type

	World = var_1_10003

	if var_132_0 == var_1_10003.TypeBase then
		underscore = var_132_0

		return var_132_0.any(arg_132_0.baseCmdIds, function(arg_133_0)
			return arg_133_0 == arg_132_1
		end)
	else
		ipairs = var_132_0

		for iter_132_0, iter_132_1 in var_132_0(arg_132_0.fleets) do
			if iter_132_1:HasCommander(arg_132_1) then
				return true
			end
		end

		return false
	end

	return
end

function var_0_1.CheckSkipBattle(arg_134_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_134_0 = var_1_10001(var_1_10003)
	local var_134_1 = var_1.getRawData(var_134_0)
	local var_134_2

	if var_1.CheckIdentityFlag(var_134_1) then
		world_skip_battle = var_134_2
		var_134_2 = var_134_2 == 1
	end

	return var_134_2
end

function var_0_1.IsMapVisioned(arg_135_0, arg_135_1)
	if arg_135_0:GetActiveMap().id == arg_135_1 then
		local var_135_0 = arg_135_0:GetActiveEntrance()
		local var_135_1, var_135_2 = var_0_1.ReplacementMapType(var_135_0, var_2)

		if var_135_1 == "base_chapter" and var_2.isPressing then
			return true
		elseif var_135_1 == "teasure_chapter" then
			i18n = var_6

			if var_135_2 == var_6("area_yinmi") and arg_135_0:GetGobalFlag("treasure_flag") then
				return true
			end
		end
	end

	return arg_135_0:IsMapPressingAwardFlag(arg_135_1)
end

function var_0_1.HasAutoFightDrops(arg_136_0)
	if not (#arg_136_0.autoInfos.drops > 0) then
		underscore = var_2

		local var_136_0

		if not var_2.any(var_1.salvage, function(arg_137_0)
			return #arg_137_0 > 0
		end) then
			if not (#var_1.buffs > 0) and not (#var_1.message > 0) then
				var_136_0 = false

				goto label_136_0
			end

			var_136_0 = true
		end

		::label_136_0::

		return var_136_0
	end
end

function var_0_1.AddAutoInfo(arg_138_0, arg_138_1, arg_138_2)
	if arg_138_1 == "drops" then
		var_1_10003 = arg_138_0.autoInfos
		table = var_1_10004
		var_1_10003.drops = var_1_10004.mergeArray(arg_138_0.autoInfos.drops, arg_138_2)
	elseif arg_138_1 == "salvage" then
		var_1_10003 = arg_138_0.autoInfos.salvage

		local var_138_0 = arg_138_2.rarity

		table = var_1_10005
		var_1_10003[var_138_0] = var_1_10005.mergeArray(arg_138_0.autoInfos.salvage[arg_138_2.rarity], arg_138_2.drops)
	elseif arg_138_1 == "events" then
		table = var_1_10003

		var_1_10003.insert(arg_138_0.autoInfos.events, arg_138_2)
	elseif arg_138_1 == "buffs" then
		table = var_1_10003

		var_1_10003.insert(arg_138_0.autoInfos.buffs, arg_138_2)
	elseif arg_138_1 == "message" then
		table = var_1_10003

		var_1_10003.insert(arg_138_0.autoInfos.message, arg_138_2)
	else
		assert = var_1_10003

		var_1_10003(false, "type error:" .. arg_138_1)
	end

	return
end

function var_0_1.InitAutoInfos(arg_139_0)
	arg_139_0.autoInfos = {
		drops = {},
		salvage = {
			{},
			{},
			{}
		},
		buffs = {},
		message = {}
	}

	return
end

function var_0_1.TriggerAutoFight(arg_140_0, arg_140_1)
	if arg_140_1 then
		local var_140_0 = arg_140_0:GetActiveMap()

		arg_140_1 = var_1_10002.CanAutoFight(var_140_0)
	end

	tobool = var_1_10002

	local var_140_1 = var_1_10002(arg_140_1)

	tobool = var_1_10003

	if var_140_1 ~= var_1_10003(arg_140_0.isAutoFight) then
		arg_140_0.isAutoFight = arg_140_1
		pg = var_140_1

		local var_140_2 = var_140_1.BrightnessMgr.GetInstance()

		var_2.SetScreenNeverSleep(var_140_2, arg_140_1)

		local var_140_3

		if arg_140_1 then
			LOCK_BATTERY_SAVEMODE = var_140_3

			if not var_140_3 then
				PlayerPrefs = var_140_3
				var_140_3 = var_140_3.GetInt
				AUTOFIGHT_BATTERY_SAVEMODE = var_140_2

				if var_140_3(var_140_2, 0) == 1 then
					pg = var_140_3

					local var_140_4 = var_140_3.BrightnessMgr.GetInstance()

					if var_140_3.IsPermissionGranted(var_140_4) then
						pg = var_140_3

						local var_140_5 = var_140_3.BrightnessMgr.GetInstance()

						var_140_3.EnterManualMode(var_140_5)

						PlayerPrefs = var_140_3
						var_140_3 = var_140_3.GetInt
						AUTOFIGHT_DOWN_FRAME = var_140_5

						if var_140_3(var_140_5, 0) == 1 then
							getProxy = var_140_3
							SettingsProxy = var_140_5

							local var_140_6 = var_140_3(var_140_5)

							var_140_3.RecordFrameRate(var_140_6)

							Application = var_140_3
							var_140_3.targetFrameRate = 30
						end
					end
				end
			end
		else
			LOCK_BATTERY_SAVEMODE = var_140_3

			if not var_140_3 then
				pg = var_140_3

				local var_140_7 = var_140_3.BrightnessMgr.GetInstance()

				var_140_3.ExitManualMode(var_140_7)

				getProxy = var_140_3
				SettingsProxy = var_140_7

				local var_140_8 = var_140_3(var_140_7)

				var_140_3.RestoreFrameRate(var_140_8)
			end
		end

		pg = var_140_3

		local var_140_9 = var_140_3.m02
		local var_140_10 = var_2.sendNotification

		GAME = var_5

		var_140_10(var_140_9, var_5.WORLD_TRIGGER_AUTO_FIGHT)
	end

	if not arg_140_1 then
		arg_140_0:TriggerAutoSwitch(false)
	end

	return
end

function var_0_1.TriggerAutoSwitch(arg_141_0, arg_141_1)
	tobool = var_1_10002

	local var_141_0 = var_1_10002(arg_141_1)

	tobool = var_1_10003

	if var_141_0 ~= var_1_10003(arg_141_0.isAutoSwitch) then
		arg_141_0.isAutoSwitch = arg_141_1
		pg = var_141_0

		local var_141_1 = var_141_0.m02
		local var_141_2 = var_2.sendNotification

		GAME = var_5

		var_141_2(var_141_1, var_5.WORLD_TRIGGER_AUTO_SWITCH)
	end

	return
end

function var_0_1.GetHistoryLowestHP(arg_142_0, arg_142_1)
	local var_142_0

	if not arg_142_0.lowestHP[arg_142_1] then
		var_142_0 = 10000
	end

	return var_142_0
end

function var_0_1.SetHistoryLowestHP(arg_143_0, arg_143_1, arg_143_2)
	arg_143_0.lowestHP[arg_143_1] = arg_143_2

	return
end

local var_0_3 = {
	treasure_flag = 1
}

function var_0_1.SetGlobalFlag(arg_144_0, arg_144_1, arg_144_2)
	arg_144_0.gobalFlag[var_0_3[arg_144_1]] = arg_144_2

	return
end

function var_0_1.GetGobalFlag(arg_145_0, arg_145_1)
	return arg_145_0.gobalFlag[var_0_3[arg_145_1]]
end

return var_0_1
