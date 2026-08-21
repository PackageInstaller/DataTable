local var_0_0 = class("World", import("...BaseEntity"))

var_0_0.Fields = {
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
var_0_0.EventUpdateSubmarineSupport = "World.EventUpdateSubmarineSupport"
var_0_0.EventSwitchMap = "World.EventSwitchMap"
var_0_0.EventUpdateProgress = "World.EventUpdateProgress"
var_0_0.EventUpdateShopGoods = "World.EventUpdateShopGoods"
var_0_0.EventUpdateGlobalBuff = "World.EventUpdateGlobalBuff"
var_0_0.EventAddPortShip = "World.EventAddPortShip"
var_0_0.EventRemovePortShip = "World.EventRemovePortShip"
var_0_0.EventAchieved = "World.EventAchieved"
var_0_0.Listeners = {
	onUpdateItem = "OnUpdateItem",
	onUpdateTask = "OnUpdateTask"
}
var_0_0.TypeBase = 0
var_0_0.TypeFull = 1
var_0_0.InheritNameList = {
	staminaMgr = function()
		return WorldStaminaManager.New()
	end,
	collectionProxy = function()
		return WorldCollectionProxy.New()
	end,
	worldBossProxy = function()
		return WorldBossProxy.New()
	end
}

function var_0_0.Ctor(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super.Ctor(arg_4_0)

	arg_4_0.type = arg_4_1

	arg_4_0:InheritReset(arg_4_2)

	return
end

function var_0_0.Build(arg_5_0)
	arg_5_0.atlas = WorldAtlas.New(WorldConst.DefaultAtlas)
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

	arg_5_0.inventoryProxy = WorldInventoryProxy.New()

	arg_5_0.inventoryProxy:AddListener(WorldInventoryProxy.EventUpdateItem, arg_5_0.onUpdateItem)

	arg_5_0.taskProxy = WorldTaskProxy.New()

	arg_5_0.taskProxy:AddListener(WorldTaskProxy.EventUpdateTask, arg_5_0.onUpdateTask)

	arg_5_0.baseShipIds = {}
	arg_5_0.baseCmdIds = {}

	return
end

function var_0_0.Dispose(arg_6_0, arg_6_1)
	if arg_6_1 then
		local var_6_0 = {
			realm = arg_6_0.realm,
			defaultFleets = arg_6_0.defaultFleets,
			achievements = arg_6_0.achievements,
			achieveEntranceStar = arg_6_0.achieveEntranceStar,
			activateCount = arg_6_0.activateCount,
			progress = arg_6_0.progress,
			staminaMgr = arg_6_0.staminaMgr,
			collectionProxy = arg_6_0.collectionProxy
		}

		if not {
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

		for iter_6_0 in pairs(var_0_0.InheritNameList) do
			if not var_6_0[iter_6_0] then
				arg_6_0[iter_6_0]:Dispose()
			end
		end

		arg_6_0.inventoryProxy:RemoveListener(WorldInventoryProxy.EventUpdateItem, arg_6_0.onUpdateItem)
		arg_6_0.inventoryProxy:Dispose()
		arg_6_0.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateTask, arg_6_0.onUpdateTask)
		arg_6_0.taskProxy:Dispose()
		arg_6_0.atlas:Dispose()
		arg_6_0:Clear()

		return var_6_0
	end
end

function var_0_0.InheritReset(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	if arg_7_1.progress then
		arg_7_0:UpdateProgress(arg_7_1.progress)

		arg_7_1.progress = nil
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		arg_7_0[iter_7_0] = iter_7_1
	end

	for iter_7_2, iter_7_3 in pairs(var_0_0.InheritNameList) do
		if not arg_7_1[iter_7_2] then
			arg_7_0[iter_7_2] = iter_7_3()
		end
	end

	return
end

function var_0_0.UsePortNShop(arg_8_0)
	return arg_8_0:IsReseted() and arg_8_0.activateTime >= WorldConst.GetNShopTimeStamp()
end

function var_0_0.IsReseted(arg_9_0)
	return arg_9_0.activateCount > (arg_9_0:IsActivate() and 1 or 0)
end

function var_0_0.IsActivate(arg_10_0)
	if arg_10_0.type == World.TypeBase then
		return #arg_10_0.baseShipIds > 0
	else
		return tobool(arg_10_0:GetActiveMap())
	end

	return
end

function var_0_0.CheckResetProgress(arg_11_0)
	return pg.gameset.world_resetting_stage.key_value <= arg_11_0.progress
end

function var_0_0.GetResetWaitingTime(arg_12_0)
	return arg_12_0.expiredTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.CheckReset(arg_13_0, arg_13_1)
	return arg_13_0:IsActivate() and (arg_13_1 or arg_13_0:CheckResetProgress()) and arg_13_0:GetResetWaitingTime() < 0
end

function var_0_0.GetAtlas(arg_14_0)
	return arg_14_0.atlas
end

function var_0_0.GetEntrance(arg_15_0, arg_15_1)
	return arg_15_0.atlas:GetEntrance(arg_15_1)
end

function var_0_0.GetActiveEntrance(arg_16_0)
	return arg_16_0.atlas:GetActiveEntrance()
end

function var_0_0.GetMap(arg_17_0, arg_17_1)
	return arg_17_0.atlas:GetMap(arg_17_1)
end

function var_0_0.GetActiveMap(arg_18_0)
	return arg_18_0.atlas:GetActiveMap()
end

function var_0_0.OnSwitchMap(arg_19_0)
	arg_19_0:ResetRound()

	if arg_19_0.submarineSupport then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_5"))
		arg_19_0:ResetSubmarine()
		arg_19_0:UpdateSubmarineSupport(false)
	end

	arg_19_0:DispatchEvent(var_0_0.EventSwitchMap)
	print("switch 2 map: " .. arg_19_0:GetActiveMap().id .. ", " .. tostring(arg_19_0:GetActiveMap().gid))

	return
end

function var_0_0.GetRound(arg_20_0)
	return arg_20_0.roundIndex % 2
end

function var_0_0.IncRound(arg_21_0)
	arg_21_0.roundIndex = arg_21_0.roundIndex + 1

	return
end

function var_0_0.ResetRound(arg_22_0)
	arg_22_0.roundIndex = 0

	return
end

function var_0_0.UpdateProgress(arg_23_0, arg_23_1)
	if arg_23_1 > arg_23_0.progress then
		arg_23_0.progress = arg_23_1

		arg_23_0.atlas:UpdateProgress(arg_23_0.progress, arg_23_1)
		arg_23_0:DispatchEvent(var_0_0.EventUpdateProgress)
	end

	return
end

function var_0_0.GetProgress(arg_24_0)
	return arg_24_0.progress
end

function var_0_0.SetRealm(arg_25_0, arg_25_1)
	if arg_25_0.realm ~= arg_25_1 then
		arg_25_0.realm = arg_25_1
	end

	return
end

function var_0_0.GetRealm(arg_26_0)
	return 1
end

function var_0_0.CanCallSubmarineSupport(arg_27_0)
	return arg_27_0:GetSubmarineFleet()
end

function var_0_0.IsSubmarineSupporting(arg_28_0)
	return arg_28_0.submarineSupport
end

function var_0_0.UpdateSubmarineSupport(arg_29_0, arg_29_1)
	arg_29_0.submarineSupport = arg_29_1

	arg_29_0:DispatchEvent(var_0_0.EventUpdateSubmarineSupport)

	return
end

function var_0_0.GetSubAidFlag(arg_30_0)
	local var_30_0 = arg_30_0:IsSubmarineSupporting()

	if var_30_0 then
		var_30_0 = arg_30_0:GetSubmarineFleet():GetAmmo() > 0
	end

	return var_30_0
end

function var_0_0.ResetSubmarine(arg_31_0)
	local var_31_0 = arg_31_0:GetSubmarineFleet()

	if var_31_0 then
		var_31_0:RepairSubmarine()
	end

	return
end

function var_0_0.SetFleets(arg_32_0, arg_32_1)
	arg_32_0.fleets = arg_32_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inWorld")

	return
end

function var_0_0.GetFleets(arg_33_0)
	return _.rest(arg_33_0.fleets, 1)
end

function var_0_0.GetFleet(arg_34_0, arg_34_1)
	if arg_34_1 then
		return _.detect(arg_34_0.fleets, function(arg_35_0)
			return arg_35_0.id == arg_34_1
		end) or arg_34_0:GetActiveMap():GetFleet()
	end
end

function var_0_0.GetNormalFleets(arg_36_0)
	return _.filter(arg_36_0.fleets, function(arg_37_0)
		return arg_37_0:GetFleetType() == FleetType.Normal
	end)
end

function var_0_0.GetSubmarineFleet(arg_38_0)
	return _.detect(arg_38_0.fleets, function(arg_39_0)
		return arg_39_0:GetFleetType() == FleetType.Submarine
	end)
end

function var_0_0.GetShips(arg_40_0)
	local var_40_0 = {}

	_.each(arg_40_0:GetFleets(), function(arg_41_0)
		_.each(arg_41_0:GetShips(true), function(arg_42_0)
			table.insert(var_40_0, arg_42_0)

			return
		end)

		return
	end)

	return {}
end

function var_0_0.GetShipVOs(arg_43_0)
	if arg_43_0.type == World.TypeBase then
		return underscore.map(arg_43_0.baseShipIds, function(arg_44_0)
			return WorldConst.FetchShipVO(arg_44_0)
		end)
	else
		return _.map(arg_43_0:GetShips(), function(arg_45_0)
			return WorldConst.FetchShipVO(arg_45_0.id)
		end)
	end

	return
end

function var_0_0.GetShip(arg_46_0, arg_46_1)
	return _.detect(arg_46_0:GetShips(), function(arg_47_0)
		return arg_47_0.id == arg_46_1
	end)
end

function var_0_0.GetShipVO(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0:GetShip(arg_48_1)

	return var_48_0 and WorldConst.FetchShipVO(var_48_0.id)
end

function var_0_0.SetDefaultFleets(arg_49_0, arg_49_1)
	arg_49_0.defaultFleets = arg_49_1

	return
end

function var_0_0.GetDefaultFleets(arg_50_0)
	return underscore.rest(arg_50_0.defaultFleets, 1)
end

function var_0_0.TransDefaultFleets(arg_51_0)
	arg_51_0.defaultFleets = underscore.map(arg_51_0.fleets, function(arg_52_0)
		return arg_52_0:Trans(WorldBaseFleet)
	end)

	return
end

function var_0_0.GetLevel(arg_53_0)
	return _(arg_53_0:GetFleets()):chain():map(function(arg_54_0)
		return arg_54_0:GetLevel()
	end):max():value()
end

function var_0_0.GetWorldPower(arg_55_0)
	local var_55_0 = 0

	underscore.each(arg_55_0.fleets, function(arg_56_0)
		var_55_0 = var_55_0 + arg_56_0:GetGearScoreSum()

		return
	end)

	return math.floor(0 * (1 + arg_55_0:GetWorldMapBuffAverageLevel() / pg.gameset.world_strength_correct.key_value))
end

function var_0_0.GetWorldRank(arg_57_0)
	local var_57_0 = 0

	for iter_57_0, iter_57_1 in ipairs((underscore.map(arg_57_0:GetNormalFleets(), function(arg_58_0)
		return arg_58_0:GetLevelCount() / 6
	end))) do
		var_57_0 = var_57_0 + iter_57_1 * pg.gameset.world_level_correct.description[iter_57_0]
	end

	local var_57_1 = arg_57_0:GetSubmarineFleet()

	if var_57_1 then
		var_57_0 = var_57_0 + var_57_1:GetLevelCount() / 3 * pg.gameset.world_level_correct.description[5]
	end

	local var_57_2 = var_57_0 * arg_57_0:GetWorldMapBuffAverageLevel()
	local var_57_3

	for iter_57_2, iter_57_3 in ipairs(pg.gameset.world_suggest_level.description) do
		if var_57_2 < iter_57_3 then
			break
		else
			var_57_3 = iter_57_2
		end
	end

	return var_57_3
end

function var_0_0.GetBossProxy(arg_59_0)
	return arg_59_0.worldBossProxy
end

function var_0_0.GetTaskProxy(arg_60_0)
	return arg_60_0.taskProxy
end

function var_0_0.GetInventoryProxy(arg_61_0)
	return arg_61_0.inventoryProxy
end

function var_0_0.GetCollectionProxy(arg_62_0)
	return arg_62_0.collectionProxy
end

function var_0_0.VerifyFormation(arg_63_0)
	local var_63_0 = {}

	_.each(arg_63_0:GetShips(), function(arg_64_0)
		local var_64_0 = var_63_0[arg_64_0.id] or 0

		var_63_0[arg_64_0.id] = var_64_0 + 1

		assert(var_63_0[arg_64_0.id] <= 1, "repeated ship id: " .. arg_64_0.id)

		return
	end)

	return
end

function var_0_0.CalcRepairCost(arg_65_0, arg_65_1)
	local var_65_0 = WorldConst.FetchShipVO(arg_65_1.id).level - arg_65_0:GetLevel()

	if arg_65_1:IsBroken() then
		local var_65_1 = _.detect(pg.gameset.world_port_service_2_interval.description, function(arg_66_0)
			return arg_66_0[1] >= var_65_0
		end) or pg.gameset.world_port_service_2_interval.description[#pg.gameset.world_port_service_2_interval.description]

		return var_65_1[2] * pg.gameset.world_port_service_2_price.key_value
	elseif not arg_65_1:IsHpFull() then
		local var_65_2 = _.detect(pg.gameset.world_port_service_1_interval.description, function(arg_67_0)
			return arg_67_0[1] >= var_65_0
		end) or pg.gameset.world_port_service_1_interval.description[#pg.gameset.world_port_service_1_interval.description]
		local var_65_3 = _.detect(pg.gameset.world_port_service_1_price.description, function(arg_68_0)
			return arg_68_0[1] >= arg_65_1.hpRant
		end) or pg.gameset.world_port_service_1_price.description[#pg.gameset.world_port_service_1_price.description]

		return var_65_2[2] * var_65_3[2]
	end

	return 0
end

function var_0_0.GetMoveRange(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0:GetActiveMap()

	if var_69_0:CanLongMove(arg_69_1) then
		return var_69_0:GetLongMoveRange(arg_69_1)
	else
		return var_69_0:GetMoveRange(arg_69_1)
	end

	return
end

function var_0_0.IsRookie(arg_70_0)
	return arg_70_0.activateCount == 0 and arg_70_0.progress <= 0
end

function var_0_0.EntranceToReplacementMapList(arg_71_0, arg_71_1)
	for iter_71_0, iter_71_1 in ipairs(arg_71_1.config.stage_chapter) do
		if arg_71_0:GetProgress() >= iter_71_1[1] and arg_71_0:GetProgress() <= iter_71_1[2] then
			table.insert({}, arg_71_0:GetMap(iter_71_1[3]))
		end
	end

	for iter_71_2, iter_71_3 in ipairs(arg_71_1.config.task_chapter) do
		local var_71_0 = arg_71_0.taskProxy:getTaskById(iter_71_3[1])

		if var_71_0 and var_71_0:isAlive() then
			table.insert({}, arg_71_0:GetMap(iter_71_3[2]))
		end
	end

	if arg_71_1.becomeSairen then
		table.insert({}, arg_71_0:GetMap(arg_71_1.config.sairen_chapter[1]))
	end

	for iter_71_4, iter_71_5 in ipairs(arg_71_1.config.teasure_chapter) do
		if arg_71_0.inventoryProxy:GetItemCount(iter_71_5[1]) > 0 then
			table.insert({}, arg_71_0:GetMap(iter_71_5[2]))
		end
	end

	local var_71_1 = arg_71_1:GetBaseMap()

	if var_71_1.isPressing and #arg_71_1.config.complete_chapter > 0 then
		table.insert({}, arg_71_0:GetMap(arg_71_1.config.complete_chapter[1]))
	end

	table.insert({}, var_71_1)

	if arg_71_1.active and not underscore.any({}, function(arg_72_0)
		return arg_72_0.active
	end) then
		table.insert({}, arg_71_0:GetActiveMap())
	end

	local var_71_2 = {}

	return (underscore.filter({}, function(arg_73_0)
		if var_71_2[arg_73_0.id] then
			return false
		else
			var_71_2[arg_73_0.id] = true

			return true
		end

		return
	end))
end

function var_0_0.ReplacementMapType(arg_74_0, arg_74_1)
	for iter_74_0, iter_74_1 in ipairs(arg_74_0.config.stage_chapter) do
		if iter_74_1[3] == arg_74_1.id then
			local var_74_1 = i18n("area_zhuxian")

			return
		end
	end

	for iter_74_2, iter_74_3 in ipairs(arg_74_0.config.task_chapter) do
		if iter_74_3[2] == arg_74_1.id then
			if pg.world_task_data[iter_74_3[1]].type == 0 then
				local var_74_3 = i18n("area_zhuxian")

				return
			elseif pg.world_task_data[iter_74_3[1]].type == 6 then
				local var_74_5 = i18n("area_dangan")

				return
			else
				local var_74_7 = i18n("area_renwu")

				return
			end
		end
	end

	for iter_74_4, iter_74_5 in ipairs(arg_74_0.config.teasure_chapter) do
		if iter_74_5[2] == arg_74_1.id then
			local var_74_8 = pg.world_item_data_template[iter_74_5[1]].usage_arg[1] == 1 and i18n("area_shenyuan") or i18n("area_yinmi")

			return "teasure_chapter", var_74_8
		end
	end

	if arg_74_0.config.sairen_chapter[1] == arg_74_1.id then
		local var_74_10 = i18n("area_yaosai")

		return
	end

	if arg_74_0.config.complete_chapter[1] == arg_74_1.id then
		local var_74_12 = i18n("area_anquan")

		return
	end

	if arg_74_0:GetBaseMapId() == arg_74_1.id then
		local var_74_14 = i18n("area_putong")

		return
	end

	local var_74_16 = i18n("area_unkown")
end

function var_0_0.FindTreasureEntrance(arg_75_0, arg_75_1)
	return underscore.values(arg_75_0.atlas:GetTreasureDic(arg_75_1))[1]
end

function var_0_0.TreasureMap2ItemId(arg_76_0, arg_76_1, arg_76_2)
	for iter_76_0, iter_76_1 in ipairs(arg_76_0:GetEntrance(arg_76_2).config.teasure_chapter) do
		if iter_76_1[2] == arg_76_1 then
			return iter_76_1[1]
		end
	end

	return
end

function var_0_0.CheckFleetMovable(arg_77_0)
	local var_77_0 = arg_77_0:GetActiveMap()
	local var_77_1 = var_77_0:GetFleet()

	return arg_77_0:GetRound() == WorldConst.RoundPlayer and var_77_0:CheckFleetMovable(var_77_1) and not var_77_0:CheckInteractive()
end

function var_0_0.SetAchieveSuccess(arg_78_0, arg_78_1, arg_78_2)
	arg_78_0.achieveEntranceStar[arg_78_1] = arg_78_0.achieveEntranceStar[arg_78_1] or {}
	arg_78_0.achieveEntranceStar[arg_78_1][arg_78_2] = true

	return
end

function var_0_0.GetMapAchieveStarDic(arg_79_0, arg_79_1)
	return arg_79_0.achieveEntranceStar[arg_79_1] or {}
end

function var_0_0.GetAchievement(arg_80_0, arg_80_1)
	if not arg_80_0.achievements[arg_80_1] then
		arg_80_0.achievements[arg_80_1] = WorldAchievement.New()

		arg_80_0.achievements[arg_80_1]:Setup(arg_80_1)
	end

	return arg_80_0.achievements[arg_80_1]
end

function var_0_0.GetAchievements(arg_81_0, arg_81_1)
	local var_81_0 = {}

	_.each(arg_81_1.config.normal_target, function(arg_82_0)
		table.insert(var_81_0, arg_81_0:GetAchievement(arg_82_0))

		return
	end)
	_.each(arg_81_1.config.cryptic_target, function(arg_83_0)
		table.insert(var_81_0, arg_81_0:GetAchievement(arg_83_0))

		return
	end)

	return {}
end

function var_0_0.IsNormalAchievementAchieved(arg_84_0, arg_84_1)
	return arg_84_0:CountAchievements(arg_84_1) >= #arg_84_1.config.normal_target
end

function var_0_0.AnyUnachievedAchievement(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_0:GetMapAchieveStarDic(arg_85_1.id)
	local var_85_1 = _.detect(arg_85_1:GetAchievementAwards(), function(arg_86_0)
		return not var_85_0[arg_86_0.star]
	end)

	if var_85_1 then
		local var_85_2, var_85_3 = arg_85_0:CountAchievements(arg_85_1)

		return var_85_2 + var_85_3 >= var_85_1.star, var_85_1
	end

	return
end

function var_0_0.GetFinishAchievements(arg_87_0, arg_87_1)
	arg_87_1 = arg_87_1 or arg_87_0.atlas:GetAchEntranceList()

	local var_87_0 = {}

	for iter_87_0, iter_87_1 in ipairs(arg_87_1) do
		local var_87_1, var_87_2 = arg_87_0:CountAchievements(iter_87_1)
		local var_87_3 = arg_87_0:GetMapAchieveStarDic(iter_87_1.id)

		for iter_87_2, iter_87_3 in ipairs(iter_87_1:GetAchievementAwards()) do
			if not var_87_3[iter_87_3.star] and var_87_1 + var_87_2 >= iter_87_3.star then
				table.insert({}, iter_87_3.star)
			end
		end

		if #{} > 0 then
			table.insert(var_87_0, {
				id = iter_87_1.id,
				star_list = {}
			})
			table.insert({}, iter_87_1.id)
		end
	end

	return var_87_0, {}
end

function var_0_0.CountAchievements(arg_88_0, arg_88_1)
	local var_88_0 = 0
	local var_88_1 = 0
	local var_88_2 = 0

	if arg_88_1 then
		local var_88_3 = {
			arg_88_1
		}

		if not {
			arg_88_1
		} then
			var_88_3 = arg_88_0.atlas:GetAchEntranceList()
		end

		for iter_88_0, iter_88_1 in ipairs(var_88_3) do
			for iter_88_2, iter_88_3 in ipairs(iter_88_1.config.normal_target) do
				var_88_0 = var_88_0 + (arg_88_0.achievements[iter_88_3] and arg_88_0.achievements[iter_88_3]:IsAchieved() and 1 or 0)
			end

			for iter_88_4, iter_88_5 in ipairs(iter_88_1.config.cryptic_target) do
				var_88_1 = var_88_1 + (arg_88_0.achievements[iter_88_5] and arg_88_0.achievements[iter_88_5]:IsAchieved() and 1 or 0)
			end

			var_88_2 = var_88_2 + #iter_88_1.config.normal_target + #iter_88_1.config.cryptic_target
		end

		return var_88_0, var_88_1, var_88_2
	end
end

local function var_0_1()
	return {
		[TeamType.Main] = {},
		[TeamType.Vanguard] = {},
		[TeamType.Submarine] = {},
		commanders = {}
	}
end

function var_0_0.BuildFormationIds(arg_90_0)
	local var_90_0 = {
		[FleetType.Normal] = 2,
		[FleetType.Submarine] = 0
	}

	for iter_90_0, iter_90_1 in ipairs(pg.world_stage_template.all) do
		if arg_90_0:GetProgress() >= pg.world_stage_template[iter_90_1].stage_key then
			var_90_0[FleetType.Normal] = math.max(var_90_0[FleetType.Normal], pg.world_stage_template[iter_90_1].fleet_num)
		else
			break
		end
	end

	local var_90_1

	if arg_90_0:IsSystemOpen(WorldConst.SystemSubmarine) then
		var_90_0[FleetType.Submarine] = 1
		var_90_1 = arg_90_0:IsActivate() and arg_90_0:GetFleets() or arg_90_0:GetDefaultFleets()
	end

	for iter_90_2, iter_90_3 in ipairs(var_90_1) do
		local var_90_2 = iter_90_3:GetFleetType()

		if #({
			[FleetType.Normal] = {},
			[FleetType.Submarine] = {}
		})[var_90_2] < var_90_0[var_90_2] then
			table.insert(({
				[FleetType.Normal] = {},
				[FleetType.Submarine] = {}
			})[var_90_2], iter_90_3:BuildFormationIds())
		end
	end

	for iter_90_4, iter_90_5 in pairs({
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}) do
		for iter_90_6 = 1, var_90_0[iter_90_4] do
			iter_90_5[iter_90_6] = iter_90_5[iter_90_6] or var_0_1()
		end
	end

	local var_90_3

	for iter_90_7, iter_90_8 in pairs((arg_90_0:GetTaskProxy():getTasks())) do
		if iter_90_8.config.complete_condition == WorldConst.TaskTypeFleetExpansion and iter_90_8:isAlive() then
			var_90_3 = iter_90_8.config.complete_parameter[1]

			break
		end
	end

	if var_90_3 then
		for iter_90_9 = #({
			[FleetType.Normal] = {},
			[FleetType.Submarine] = {}
		})[FleetType.Normal] + 1, var_90_3 do
			({
				[FleetType.Normal] = {},
				[FleetType.Submarine] = {}
			})[FleetType.Normal][iter_90_9] = var_0_1()
		end
	end

	local var_90_4 = 0

	for iter_90_10, iter_90_11 in pairs({
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}) do
		var_90_4 = var_90_4 + #iter_90_11
	end

	if var_90_3 then
		local var_90_5 = WorldConst.FleetExpansion or WorldConst.FleetRedeploy

		return var_90_5, {
			[FleetType.Normal] = {},
			[FleetType.Submarine] = {}
		}, var_90_4
	end
end

function var_0_0.FormationIds2NetIds(arg_91_0, arg_91_1)
	for iter_91_0, iter_91_1 in ipairs({
		FleetType.Normal,
		FleetType.Submarine
	}) do
		for iter_91_2, iter_91_3 in ipairs(arg_91_1[iter_91_1]) do
			for iter_91_4, iter_91_5 in ipairs({
				TeamType.Main,
				TeamType.Vanguard,
				TeamType.Submarine
			}) do
				for iter_91_6 = 1, 3 do
					if iter_91_3[iter_91_5][iter_91_6] then
						table.insert({}, iter_91_3[iter_91_5][iter_91_6])
					end
				end
			end

			if #{} > 0 then
				table.insert({}, {
					ship_id_list = {},
					commanders = Clone(iter_91_3.commanders)
				})
			end
		end
	end

	return {}
end

function var_0_0.CompareRedeploy(arg_92_0, arg_92_1)
	local var_92_0 = 0

	for iter_92_0, iter_92_1 in pairs(arg_92_1) do
		for iter_92_2, iter_92_3 in ipairs(iter_92_1) do
			for iter_92_4, iter_92_5 in ipairs({
				TeamType.Main,
				TeamType.Vanguard,
				TeamType.Submarine
			}) do
				for iter_92_6 = 1, 3 do
					if iter_92_3[iter_92_5][iter_92_6] and not ({})[iter_92_3[iter_92_5][iter_92_6]] then
						({})[iter_92_3[iter_92_5][iter_92_6]] = true
						var_92_0 = var_92_0 + 1
					end
				end
			end
		end
	end

	local var_92_1 = 0

	for iter_92_7, iter_92_8 in ipairs(arg_92_0:GetFleets()) do
		for iter_92_9, iter_92_10 in ipairs({
			TeamType.Main,
			TeamType.Vanguard,
			TeamType.Submarine
		}) do
			for iter_92_11, iter_92_12 in ipairs((iter_92_8:GetTeamShips(iter_92_10, true))) do
				if not ({})[iter_92_12.id] then
					({})[iter_92_12.id] = true
					var_92_1 = var_92_1 + 1
				end
			end
		end
	end

	if var_92_1 ~= var_92_0 then
		return true
	end

	for iter_92_13, iter_92_14 in pairs({}) do
		if not ({})[iter_92_13] then
			return true
		end
	end

	for iter_92_15, iter_92_16 in pairs({}) do
		if not ({})[iter_92_15] then
			return true
		end
	end

	return false
end

function var_0_0.IsSystemOpen(arg_93_0, arg_93_1)
	local var_93_0 = arg_93_0:GetRealm()

	for iter_93_0, iter_93_1 in ipairs(pg.world_stage_template.all) do
		local var_93_1 = pg.world_stage_template[iter_93_1]

		if pg.world_stage_template[iter_93_1].stage_ui[1] == arg_93_1 and (var_93_1.stage_ui[2] == 0 or var_93_1.stage_ui[2] == var_93_0) then
			return arg_93_0:GetProgress() >= var_93_1.stage_key
		end
	end

	return true
end

function var_0_0.CalcCDTimeCost(arg_94_0, arg_94_1, arg_94_2)
	return math.floor(arg_94_0[1] * math.max(arg_94_0[2] - math.max(pg.TimeMgr.GetInstance():GetServerTime() - arg_94_1, 0), 0) / arg_94_0[2] * math.max(16 - arg_94_2, 0) / 16)
end

function var_0_0.GetReqCDTime(arg_95_0, arg_95_1)
	return arg_95_0.cdTimeList[arg_95_1] or 0
end

function var_0_0.SetReqCDTime(arg_96_0, arg_96_1, arg_96_2)
	arg_96_0.cdTimeList[arg_96_1] = arg_96_2

	return
end

function var_0_0.InitWorldShopGoods(arg_97_0)
	arg_97_0.goodDic = {}

	for iter_97_0, iter_97_1 in ipairs({
		ShopArgs.WorldShop,
		ShopArgs.WorldCollection
	}) do
		for iter_97_2, iter_97_3 in ipairs(pg.shop_template.get_id_list_by_genre[iter_97_1]) do
			arg_97_0.goodDic[iter_97_3] = 0
		end
	end

	return
end

function var_0_0.UpdateWorldShopGoods(arg_98_0, arg_98_1)
	_.each(arg_98_1, function(arg_99_0)
		assert(arg_98_0.goodDic[arg_99_0.goods_id], "without this good in id " .. arg_99_0.goods_id)

		arg_98_0.goodDic[arg_99_0.goods_id] = arg_98_0.goodDic[arg_99_0.goods_id] + arg_99_0.count

		return
	end)
	arg_98_0:DispatchEvent(var_0_0.EventUpdateShopGoods, arg_98_0.goodDic)

	return
end

function var_0_0.GetWorldShopGoodsDictionary(arg_100_0)
	return arg_100_0.goodDic
end

function var_0_0.InitWorldColorDictionary(arg_101_0)
	arg_101_0.colorDic = {}

	_.each(pg.world_chapter_colormask.all, function(arg_102_0)
		arg_101_0.colorDic[Color.New(pg.world_chapter_colormask[arg_102_0].color[1] / 255, pg.world_chapter_colormask[arg_102_0].color[2] / 255, pg.world_chapter_colormask[arg_102_0].color[3] / 255):ToHex()] = pg.world_chapter_colormask[arg_102_0].id

		return
	end)

	return
end

function var_0_0.ColorToEntrance(arg_103_0, arg_103_1)
	return arg_103_0.colorDic[arg_103_1:ToHex()] and arg_103_0:GetEntrance(arg_103_0.colorDic[arg_103_1:ToHex()])
end

function var_0_0.GetGlobalBuff(arg_104_0, arg_104_1)
	if not arg_104_0.globalBuffDic[arg_104_1] then
		local var_104_0 = WorldBuff.New()

		var_104_0:Setup({
			floor = 0,
			id = arg_104_1
		})

		arg_104_0.globalBuffDic[arg_104_1] = var_104_0
	end

	return arg_104_0.globalBuffDic[arg_104_1]
end

function var_0_0.AddGlobalBuff(arg_105_0, arg_105_1, arg_105_2)
	assert(arg_105_1 and arg_105_2)
	arg_105_0:GetGlobalBuff(arg_105_1):AddFloor(arg_105_2)
	arg_105_0:DispatchEvent(var_0_0.EventUpdateGlobalBuff)

	return
end

function var_0_0.RemoveBuff(arg_106_0, arg_106_1, arg_106_2)
	assert(arg_106_1)

	if arg_106_2 then
		arg_106_0:GetGlobalBuff(arg_106_1):AddFloor(arg_106_2 * -1)
	else
		arg_106_0.globalBuffDic[arg_106_1] = nil
	end

	arg_106_0:DispatchEvent(var_0_0.EventUpdateGlobalBuff)

	return
end

function var_0_0.GetWorldMapBuffLevel(arg_107_0)
	return _.map(pg.gameset.world_mapbuff_list.description, function(arg_108_0)
		return arg_107_0:GetGlobalBuff(arg_108_0).floor
	end)
end

function var_0_0.GetWorldMapBuffAverageLevel(arg_109_0)
	local var_109_0 = arg_109_0:GetWorldMapBuffLevel()
	local var_109_1 = 0

	underscore.each(var_109_0, function(arg_110_0)
		var_109_1 = var_109_1 + arg_110_0

		return
	end)

	return 0 / #var_109_0
end

function var_0_0.GetWorldMapBuffs(arg_111_0)
	return _.map(pg.gameset.world_mapbuff_list.description, function(arg_112_0)
		return arg_111_0:GetGlobalBuff(arg_112_0)
	end)
end

function var_0_0.GetWorldMapDifficultyBuffLevel(arg_113_0)
	return pg.gameset.world_difficult_value.description[arg_113_0:GetActiveMap().config.difficulty]
end

function var_0_0.OnUpdateItem(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	if arg_114_3:getWorldItemType() == WorldItem.UsageWorldMap and arg_114_0.atlas then
		arg_114_0.atlas:UpdateTreasure(arg_114_3.id)
	end

	arg_114_0.taskProxy:doUpdateTaskByItem(arg_114_3)

	return
end

function var_0_0.OnUpdateTask(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	if arg_115_0.atlas then
		arg_115_0.atlas:UpdateTask(arg_115_3)
	end

	return
end

function var_0_0.GetPressingAward(arg_116_0, arg_116_1)
	return arg_116_0.pressingAwardDic[arg_116_1]
end

function var_0_0.FlagMapPressingAward(arg_117_0, arg_117_1)
	local var_117_0 = arg_117_0:GetPressingAward(arg_117_1)

	if var_117_0 then
		var_117_0.flag = false
	end

	return
end

function var_0_0.IsMapPressingAwardFlag(arg_118_0, arg_118_1)
	local var_118_0 = arg_118_0:GetPressingAward(arg_118_1)

	return var_118_0 and var_118_0.flag == false
end

function var_0_0.CheckAreaUnlock(arg_119_0, arg_119_1)
	return arg_119_0.progress >= pg.world_regions_data[arg_119_1].open_stage[1]
end

function var_0_0.CheckTaskLockMap(arg_120_0)
	local var_120_0 = arg_120_0:GetActiveMap().gid

	return _.any(arg_120_0.taskProxy:getTaskVOs(), function(arg_121_0)
		return arg_121_0:isAlive() and arg_121_0:IsLockMap() and _.any(arg_121_0.config.task_target_map, function(arg_122_0)
			return arg_122_0 == var_120_0
		end)
	end)
end

function var_0_0.CheckResetAward(arg_123_0, arg_123_1)
	arg_123_0.resetAward = arg_123_1

	if getProxy(PlayerProxy):getData():getResource(WorldConst.ResourceID) == pg.gameset.world_resource_max.key_value then
		arg_123_0.resetLimitTip = true
	end

	return
end

function var_0_0.ClearResetAward(arg_124_0)
	arg_124_0.resetAward = nil
	arg_124_0.resetLimitTip = nil

	return
end

function var_0_0.GetTargetMapPressingCount(arg_125_0, arg_125_1)
	local var_125_0 = 0

	for iter_125_0, iter_125_1 in ipairs(arg_125_1) do
		if arg_125_0:GetMap(iter_125_1).isPressing then
			var_125_0 = var_125_0 + 1
		end
	end

	return var_125_0
end

function var_0_0.ClearAllFleetDefeatEnemies(arg_126_0)
	underscore.each(arg_126_0:GetFleets(), function(arg_127_0)
		arg_127_0:ClearDefeatEnemies()

		return
	end)

	return
end

function var_0_0.GetAreaEntranceIds(arg_128_0, arg_128_1)
	return arg_128_0.atlas.areaEntranceList[arg_128_1]
end

function var_0_0.CalcOrderCost(arg_129_0, arg_129_1)
	local var_129_0 = 0

	if arg_129_1 == WorldConst.OpReqRedeploy then
		return World.CalcCDTimeCost(pg.gameset.world_fleet_redeploy_cost.description, arg_129_0:GetReqCDTime(WorldConst.OpReqRedeploy), 0)
	elseif arg_129_1 == WorldConst.OpReqMaintenance then
		return pg.gameset.world_instruction_maintenance.description[1] * math.max(16 - 0, 0) / 16
	elseif arg_129_1 == WorldConst.OpReqSub then
		local var_129_1 = arg_129_0:GetSubmarineFleet()

		if var_129_1 then
			underscore.each(var_129_1:GetShips(true), function(arg_130_0)
				var_129_0 = var_129_0 + arg_130_0:GetImportWorldShipVO():GetStaminaDiscount(WorldConst.OpReqSub)

				return
			end)
		end

		return World.CalcCDTimeCost(pg.gameset.world_instruction_submarine.description, arg_129_0:GetReqCDTime(WorldConst.OpReqSub), 0)
	elseif arg_129_1 == WorldConst.OpReqVision then
		return World.CalcCDTimeCost(pg.gameset.world_instruction_detect.description, arg_129_0:GetReqCDTime(WorldConst.OpReqVision), 0)
	else
		assert(false, "op type error: " .. arg_129_1)
	end

	return
end

function var_0_0.GetDisplayPressingCount(arg_131_0)
	local var_131_0 = 0

	for iter_131_0, iter_131_1 in ipairs(arg_131_0.atlas.pressingMapList) do
		local var_131_1 = arg_131_0.atlas:GetMap(iter_131_1)

		if var_131_1:CheckMapPressingDisplay() then
			var_131_0 = var_131_0 + 1
		end
	end

	return var_131_0
end

function var_0_0.CheckCommanderInFleet(arg_132_0, arg_132_1)
	if arg_132_0.type == World.TypeBase then
		return underscore.any(arg_132_0.baseCmdIds, function(arg_133_0)
			return arg_133_0 == arg_132_1
		end)
	else
		for iter_132_0, iter_132_1 in ipairs(arg_132_0.fleets) do
			if iter_132_1:HasCommander(arg_132_1) then
				return true
			end
		end

		return false
	end

	return
end

function var_0_0.CheckSkipBattle(arg_134_0)
	return getProxy(PlayerProxy):getRawData():CheckIdentityFlag() and world_skip_battle == 1
end

function var_0_0.IsMapVisioned(arg_135_0, arg_135_1)
	local var_135_0 = arg_135_0:GetActiveMap()

	if var_135_0.id == arg_135_1 then
		local var_135_1, var_135_2 = var_0_0.ReplacementMapType(arg_135_0:GetActiveEntrance(), var_135_0)

		if var_135_1 == "base_chapter" and var_135_0.isPressing then
			return true
		elseif var_135_1 == "teasure_chapter" and var_135_2 == i18n("area_yinmi") and arg_135_0:GetGobalFlag("treasure_flag") then
			return true
		end
	end

	return arg_135_0:IsMapPressingAwardFlag(arg_135_1)
end

function var_0_0.HasAutoFightDrops(arg_136_0)
	return #arg_136_0.autoInfos.drops > 0 or underscore.any(arg_136_0.autoInfos.salvage, function(arg_137_0)
		return #arg_137_0 > 0
	end) or #arg_136_0.autoInfos.buffs > 0 or #arg_136_0.autoInfos.message > 0
end

function var_0_0.AddAutoInfo(arg_138_0, arg_138_1, arg_138_2)
	if arg_138_1 == "drops" then
		arg_138_0.autoInfos.drops = table.mergeArray(arg_138_0.autoInfos.drops, arg_138_2)
	elseif arg_138_1 == "salvage" then
		arg_138_0.autoInfos.salvage[arg_138_2.rarity] = table.mergeArray(arg_138_0.autoInfos.salvage[arg_138_2.rarity], arg_138_2.drops)
	elseif arg_138_1 == "events" then
		table.insert(arg_138_0.autoInfos.events, arg_138_2)
	elseif arg_138_1 == "buffs" then
		table.insert(arg_138_0.autoInfos.buffs, arg_138_2)
	elseif arg_138_1 == "message" then
		table.insert(arg_138_0.autoInfos.message, arg_138_2)
	else
		assert(false, "type error:" .. arg_138_1)
	end

	return
end

function var_0_0.InitAutoInfos(arg_139_0)
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

function var_0_0.TriggerAutoFight(arg_140_0, arg_140_1)
	arg_140_1 = arg_140_1 and arg_140_0:GetActiveMap():CanAutoFight()

	if tobool(arg_140_1) ~= tobool(arg_140_0.isAutoFight) then
		arg_140_0.isAutoFight = arg_140_1

		pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(arg_140_1)

		if arg_140_1 then
			if not LOCK_BATTERY_SAVEMODE and PlayerPrefs.GetInt(AUTOFIGHT_BATTERY_SAVEMODE, 0) == 1 then
				if pg.BrightnessMgr.GetInstance():IsPermissionGranted() then
					pg.BrightnessMgr.GetInstance():EnterManualMode()

					if PlayerPrefs.GetInt(AUTOFIGHT_DOWN_FRAME, 0) == 1 then
						getProxy(SettingsProxy):RecordFrameRate()

						Application.targetFrameRate = 30
					end
				end
			end
		elseif not LOCK_BATTERY_SAVEMODE then
			pg.BrightnessMgr.GetInstance():ExitManualMode()
			getProxy(SettingsProxy):RestoreFrameRate()
		end

		pg.m02:sendNotification(GAME.WORLD_TRIGGER_AUTO_FIGHT)
	end

	if not arg_140_1 then
		arg_140_0:TriggerAutoSwitch(false)
	end

	return
end

function var_0_0.TriggerAutoSwitch(arg_141_0, arg_141_1)
	if tobool(arg_141_1) ~= tobool(arg_141_0.isAutoSwitch) then
		arg_141_0.isAutoSwitch = arg_141_1

		pg.m02:sendNotification(GAME.WORLD_TRIGGER_AUTO_SWITCH)
	end

	return
end

function var_0_0.GetHistoryLowestHP(arg_142_0, arg_142_1)
	return arg_142_0.lowestHP[arg_142_1] or 10000
end

function var_0_0.SetHistoryLowestHP(arg_143_0, arg_143_1, arg_143_2)
	arg_143_0.lowestHP[arg_143_1] = arg_143_2

	return
end

local var_0_2 = {
	treasure_flag = 1
}

function var_0_0.SetGlobalFlag(arg_144_0, arg_144_1, arg_144_2)
	arg_144_0.gobalFlag[var_0_2[arg_144_1]] = arg_144_2

	return
end

function var_0_0.GetGobalFlag(arg_145_0, arg_145_1)
	return arg_145_0.gobalFlag[var_0_2[arg_145_1]]
end

return var_0_0
