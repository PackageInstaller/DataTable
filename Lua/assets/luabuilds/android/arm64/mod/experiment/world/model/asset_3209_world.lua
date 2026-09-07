local World = class("World", import("...BaseEntity"))

World.Fields = {
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
World.EventUpdateSubmarineSupport = "World.EventUpdateSubmarineSupport"
World.EventSwitchMap = "World.EventSwitchMap"
World.EventUpdateProgress = "World.EventUpdateProgress"
World.EventUpdateShopGoods = "World.EventUpdateShopGoods"
World.EventUpdateGlobalBuff = "World.EventUpdateGlobalBuff"
World.EventAddPortShip = "World.EventAddPortShip"
World.EventRemovePortShip = "World.EventRemovePortShip"
World.EventAchieved = "World.EventAchieved"
World.Listeners = {
	onUpdateItem = "OnUpdateItem",
	onUpdateTask = "OnUpdateTask"
}
World.TypeBase = 0
World.TypeFull = 1
World.InheritNameList = {
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

function World:Ctor(arg_4_1, arg_4_2)
	World.super.Ctor(self)

	self.type = arg_4_1

	self:InheritReset(arg_4_2)

	return
end

function World:Build()
	self.atlas = WorldAtlas.New(WorldConst.DefaultAtlas)
	self.realm = 0
	self.fleets = {}
	self.defaultFleets = {}
	self.activateTime = 0
	self.expiredTime = 0
	self.roundIndex = nil
	self.submarineSupport = nil
	self.achievements = {}
	self.achieveEntranceStar = {}

	self:InitWorldShopGoods()
	self:InitWorldColorDictionary()

	self.activateCount = 0
	self.stepCount = 0
	self.treasureCount = 0
	self.progress = 0
	self.cdTimeList = {}
	self.globalBuffDic = {}
	self.pressingAwardDic = {}
	self.lowestHP = {}
	self.gobalFlag = {}
	self.isAutoFight = false

	self:InitAutoInfos()

	self.inventoryProxy = WorldInventoryProxy.New()

	self.inventoryProxy:AddListener(WorldInventoryProxy.EventUpdateItem, self.onUpdateItem)

	self.taskProxy = WorldTaskProxy.New()

	self.taskProxy:AddListener(WorldTaskProxy.EventUpdateTask, self.onUpdateTask)

	self.baseShipIds = {}
	self.baseCmdIds = {}

	return
end

function World:Dispose(arg_6_1)
	local var_6_0 = arg_6_1 and {
		realm = self.realm,
		defaultFleets = self.defaultFleets,
		achievements = self.achievements,
		achieveEntranceStar = self.achieveEntranceStar,
		activateCount = self.activateCount,
		progress = self.progress,
		staminaMgr = self.staminaMgr,
		collectionProxy = self.collectionProxy
	} or {}

	var_6_0.worldBossProxy = self.worldBossProxy

	for iter_6_0 in pairs(World.InheritNameList) do
		if not var_6_0[iter_6_0] then
			self[iter_6_0]:Dispose()
		end
	end

	self.inventoryProxy:RemoveListener(WorldInventoryProxy.EventUpdateItem, self.onUpdateItem)
	self.inventoryProxy:Dispose()
	self.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateTask, self.onUpdateTask)
	self.taskProxy:Dispose()
	self.atlas:Dispose()
	self:Clear()

	return var_6_0
end

function World:InheritReset(arg_7_1)
	arg_7_1 = arg_7_1 or {}

	if arg_7_1.progress then
		self:UpdateProgress(arg_7_1.progress)

		arg_7_1.progress = nil
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		self[iter_7_0] = iter_7_1
	end

	for iter_7_2, iter_7_3 in pairs(World.InheritNameList) do
		if not arg_7_1[iter_7_2] then
			self[iter_7_2] = iter_7_3()
		end
	end

	return
end

function World:UsePortNShop()
	return self:IsReseted() and self.activateTime >= WorldConst.GetNShopTimeStamp()
end

function World:IsReseted()
	return self.activateCount > (self:IsActivate() and 1 or 0)
end

function World:IsActivate()
	if self.type == World.TypeBase then
		return #self.baseShipIds > 0
	else
		return tobool(self:GetActiveMap())
	end

	return
end

function World:CheckResetProgress()
	return pg.gameset.world_resetting_stage.key_value <= self.progress
end

function World:GetResetWaitingTime()
	return self.expiredTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function World:CheckReset(arg_13_1)
	return self:IsActivate() and (arg_13_1 or self:CheckResetProgress()) and self:GetResetWaitingTime() < 0
end

function World:GetAtlas()
	return self.atlas
end

function World:GetEntrance(arg_15_1)
	return self.atlas:GetEntrance(arg_15_1)
end

function World:GetActiveEntrance()
	return self.atlas:GetActiveEntrance()
end

function World:GetMap(arg_17_1)
	return self.atlas:GetMap(arg_17_1)
end

function World:GetActiveMap()
	return self.atlas:GetActiveMap()
end

function World:OnSwitchMap()
	self:ResetRound()

	if self.submarineSupport then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_5"))
		self:ResetSubmarine()
		self:UpdateSubmarineSupport(false)
	end

	self:DispatchEvent(World.EventSwitchMap)
	print("switch 2 map: " .. self:GetActiveMap().id .. ", " .. tostring(self:GetActiveMap().gid))

	return
end

function World:GetRound()
	return self.roundIndex % 2
end

function World:IncRound()
	self.roundIndex = self.roundIndex + 1

	return
end

function World:ResetRound()
	self.roundIndex = 0

	return
end

function World:UpdateProgress(arg_23_1)
	if arg_23_1 > self.progress then
		self.progress = arg_23_1

		self.atlas:UpdateProgress(self.progress, arg_23_1)
		self:DispatchEvent(World.EventUpdateProgress)
	end

	return
end

function World:GetProgress()
	return self.progress
end

function World:SetRealm(arg_25_1)
	if self.realm ~= arg_25_1 then
		self.realm = arg_25_1
	end

	return
end

function World:GetRealm()
	return 1
end

function World:CanCallSubmarineSupport()
	return self:GetSubmarineFleet()
end

function World:IsSubmarineSupporting()
	return self.submarineSupport
end

function World:UpdateSubmarineSupport(arg_29_1)
	self.submarineSupport = arg_29_1

	self:DispatchEvent(World.EventUpdateSubmarineSupport)

	return
end

function World:GetSubAidFlag()
	local var_30_0 = self:IsSubmarineSupporting()

	if var_30_0 then
		var_30_0 = self:GetSubmarineFleet():GetAmmo() > 0
	end

	return var_30_0
end

function World:ResetSubmarine()
	local var_31_0 = self:GetSubmarineFleet()

	if var_31_0 then
		var_31_0:RepairSubmarine()
	end

	return
end

function World:SetFleets(arg_32_1)
	self.fleets = arg_32_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inWorld")

	return
end

function World:GetFleets()
	return _.rest(self.fleets, 1)
end

function World:GetFleet(arg_34_1)
	return (arg_34_1 or nil) and (_.detect(self.fleets, function(arg_35_0)
		return arg_35_0.id == arg_34_1
	end) or self:GetActiveMap():GetFleet())
end

function World:GetNormalFleets()
	return _.filter(self.fleets, function(arg_37_0)
		return arg_37_0:GetFleetType() == FleetType.Normal
	end)
end

function World:GetSubmarineFleet()
	return _.detect(self.fleets, function(arg_39_0)
		return arg_39_0:GetFleetType() == FleetType.Submarine
	end)
end

function World:GetShips()
	local var_40_0 = {}

	_.each(self:GetFleets(), function(arg_41_0)
		_.each(arg_41_0:GetShips(true), function(arg_42_0)
			table.insert(var_40_0, arg_42_0)

			return
		end)

		return
	end)

	return var_40_0
end

function World:GetShipVOs()
	if self.type == World.TypeBase then
		return underscore.map(self.baseShipIds, function(arg_44_0)
			return WorldConst.FetchShipVO(arg_44_0)
		end)
	else
		return _.map(self:GetShips(), function(arg_45_0)
			return WorldConst.FetchShipVO(arg_45_0.id)
		end)
	end

	return
end

function World:GetShip(arg_46_1)
	return _.detect(self:GetShips(), function(arg_47_0)
		return arg_47_0.id == arg_46_1
	end)
end

function World:GetShipVO(arg_48_1)
	local var_48_0 = self:GetShip(arg_48_1)

	return var_48_0 and WorldConst.FetchShipVO(var_48_0.id)
end

function World:SetDefaultFleets(arg_49_1)
	self.defaultFleets = arg_49_1

	return
end

function World:GetDefaultFleets()
	return underscore.rest(self.defaultFleets, 1)
end

function World:TransDefaultFleets()
	self.defaultFleets = underscore.map(self.fleets, function(arg_52_0)
		return arg_52_0:Trans(WorldBaseFleet)
	end)

	return
end

function World:GetLevel()
	return _(self:GetFleets()):chain():map(function(arg_54_0)
		return arg_54_0:GetLevel()
	end):max():value()
end

function World:GetWorldPower()
	local var_55_0 = 0

	underscore.each(self.fleets, function(arg_56_0)
		var_55_0 = var_55_0 + arg_56_0:GetGearScoreSum()

		return
	end)

	return math.floor(0 * (1 + self:GetWorldMapBuffAverageLevel() / pg.gameset.world_strength_correct.key_value))
end

function World:GetWorldRank()
	local var_57_0 = 0

	for iter_57_0, iter_57_1 in ipairs((underscore.map(self:GetNormalFleets(), function(arg_58_0)
		return arg_58_0:GetLevelCount() / 6
	end))) do
		var_57_0 = var_57_0 + iter_57_1 * pg.gameset.world_level_correct.description[iter_57_0]
	end

	local var_57_1 = self:GetSubmarineFleet()

	if var_57_1 then
		var_57_0 = var_57_0 + var_57_1:GetLevelCount() / 3 * pg.gameset.world_level_correct.description[5]
	end

	local var_57_2 = var_57_0 * self:GetWorldMapBuffAverageLevel()
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

function World:GetBossProxy()
	return self.worldBossProxy
end

function World:GetTaskProxy()
	return self.taskProxy
end

function World:GetInventoryProxy()
	return self.inventoryProxy
end

function World:GetCollectionProxy()
	return self.collectionProxy
end

function World:VerifyFormation()
	local var_63_0 = {}

	_.each(self:GetShips(), function(arg_64_0)
		var_63_0[arg_64_0.id] = (var_63_0[arg_64_0.id] or 0) + 1

		assert(var_63_0[arg_64_0.id] <= 1, "repeated ship id: " .. arg_64_0.id)

		return
	end)

	return
end

function World:CalcRepairCost(arg_65_1)
	local var_65_0 = WorldConst.FetchShipVO(arg_65_1.id).level - self:GetLevel()

	if arg_65_1:IsBroken() then
		return (_.detect(pg.gameset.world_port_service_2_interval.description, function(arg_66_0)
			return arg_66_0[1] >= var_65_0
		end) or pg.gameset.world_port_service_2_interval.description[#pg.gameset.world_port_service_2_interval.description])[2] * pg.gameset.world_port_service_2_price.key_value
	elseif not arg_65_1:IsHpFull() then
		return (_.detect(pg.gameset.world_port_service_1_interval.description, function(arg_67_0)
			return arg_67_0[1] >= var_65_0
		end) or pg.gameset.world_port_service_1_interval.description[#pg.gameset.world_port_service_1_interval.description])[2] * (_.detect(pg.gameset.world_port_service_1_price.description, function(arg_68_0)
			return arg_68_0[1] >= arg_65_1.hpRant
		end) or pg.gameset.world_port_service_1_price.description[#pg.gameset.world_port_service_1_price.description])[2]
	end

	return 0
end

function World:GetMoveRange(arg_69_1)
	local var_69_0 = self:GetActiveMap()

	if var_69_0:CanLongMove(arg_69_1) then
		return var_69_0:GetLongMoveRange(arg_69_1)
	else
		return var_69_0:GetMoveRange(arg_69_1)
	end

	return
end

function World:IsRookie()
	return self.activateCount == 0 and self.progress <= 0
end

function World:EntranceToReplacementMapList(arg_71_1)
	local var_71_0 = {}

	for iter_71_0, iter_71_1 in ipairs(arg_71_1.config.stage_chapter) do
		if self:GetProgress() >= iter_71_1[1] and self:GetProgress() <= iter_71_1[2] then
			table.insert(var_71_0, self:GetMap(iter_71_1[3]))
		end
	end

	for iter_71_2, iter_71_3 in ipairs(arg_71_1.config.task_chapter) do
		local var_71_1 = self.taskProxy:getTaskById(iter_71_3[1])

		if var_71_1 and var_71_1:isAlive() then
			table.insert(var_71_0, self:GetMap(iter_71_3[2]))
		end
	end

	if arg_71_1.becomeSairen then
		table.insert(var_71_0, self:GetMap(arg_71_1.config.sairen_chapter[1]))
	end

	for iter_71_4, iter_71_5 in ipairs(arg_71_1.config.teasure_chapter) do
		if self.inventoryProxy:GetItemCount(iter_71_5[1]) > 0 then
			table.insert(var_71_0, self:GetMap(iter_71_5[2]))
		end
	end

	local var_71_2 = arg_71_1:GetBaseMap()

	if var_71_2.isPressing and #arg_71_1.config.complete_chapter > 0 then
		table.insert(var_71_0, self:GetMap(arg_71_1.config.complete_chapter[1]))
	end

	table.insert(var_71_0, var_71_2)

	if arg_71_1.active and not underscore.any(var_71_0, function(arg_72_0)
		return arg_72_0.active
	end) then
		table.insert(var_71_0, self:GetActiveMap())
	end

	local var_71_3 = {}

	return (underscore.filter(var_71_0, function(arg_73_0)
		if var_71_3[arg_73_0.id] then
			return false
		else
			var_71_3[arg_73_0.id] = true

			return true
		end

		return
	end))
end

function World:ReplacementMapType(arg_74_1)
	for iter_74_0, iter_74_1 in ipairs(self.config.stage_chapter) do
		if iter_74_1[3] == arg_74_1.id then
			local var_74_1 = i18n("area_zhuxian")

			return
		end
	end

	for iter_74_2, iter_74_3 in ipairs(self.config.task_chapter) do
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

	for iter_74_4, iter_74_5 in ipairs(self.config.teasure_chapter) do
		if iter_74_5[2] == arg_74_1.id then
			return "teasure_chapter", pg.world_item_data_template[iter_74_5[1]].usage_arg[1] == 1 and i18n("area_shenyuan") or i18n("area_yinmi")
		end
	end

	if self.config.sairen_chapter[1] == arg_74_1.id then
		local var_74_9 = i18n("area_yaosai")

		return
	end

	if self.config.complete_chapter[1] == arg_74_1.id then
		local var_74_11 = i18n("area_anquan")

		return
	end

	if self:GetBaseMapId() == arg_74_1.id then
		local var_74_13 = i18n("area_putong")

		return
	end

	local var_74_15 = i18n("area_unkown")
end

function World:FindTreasureEntrance(arg_75_1)
	return underscore.values(self.atlas:GetTreasureDic(arg_75_1))[1]
end

function World:TreasureMap2ItemId(arg_76_1, arg_76_2)
	for iter_76_0, iter_76_1 in ipairs(self:GetEntrance(arg_76_2).config.teasure_chapter) do
		if iter_76_1[2] == arg_76_1 then
			return iter_76_1[1]
		end
	end

	return
end

function World:CheckFleetMovable()
	local var_77_0 = self:GetActiveMap()

	return self:GetRound() == WorldConst.RoundPlayer and var_77_0:CheckFleetMovable((var_77_0:GetFleet())) and not var_77_0:CheckInteractive()
end

function World:SetAchieveSuccess(arg_78_1, arg_78_2)
	self.achieveEntranceStar[arg_78_1] = self.achieveEntranceStar[arg_78_1] or {}
	self.achieveEntranceStar[arg_78_1][arg_78_2] = true

	return
end

function World:GetMapAchieveStarDic(arg_79_1)
	return self.achieveEntranceStar[arg_79_1] or {}
end

function World:GetAchievement(arg_80_1)
	if not self.achievements[arg_80_1] then
		self.achievements[arg_80_1] = WorldAchievement.New()

		self.achievements[arg_80_1]:Setup(arg_80_1)
	end

	return self.achievements[arg_80_1]
end

function World:GetAchievements(arg_81_1)
	local var_81_0 = {}

	_.each(arg_81_1.config.normal_target, function(arg_82_0)
		table.insert(var_81_0, self:GetAchievement(arg_82_0))

		return
	end)
	_.each(arg_81_1.config.cryptic_target, function(arg_83_0)
		table.insert(var_81_0, self:GetAchievement(arg_83_0))

		return
	end)

	return var_81_0
end

function World:IsNormalAchievementAchieved(arg_84_1)
	return self:CountAchievements(arg_84_1) >= #arg_84_1.config.normal_target
end

function World:AnyUnachievedAchievement(arg_85_1)
	local var_85_0 = self:GetMapAchieveStarDic(arg_85_1.id)
	local var_85_1 = _.detect(arg_85_1:GetAchievementAwards(), function(arg_86_0)
		return not var_85_0[arg_86_0.star]
	end)

	if var_85_1 then
		local var_85_2, var_85_3 = self:CountAchievements(arg_85_1)

		return var_85_2 + var_85_3 >= var_85_1.star, var_85_1
	end

	return
end

function World:GetFinishAchievements(arg_87_1)
	arg_87_1 = arg_87_1 or self.atlas:GetAchEntranceList()

	local var_87_0 = {}
	local var_87_1 = {}

	for iter_87_0, iter_87_1 in ipairs(arg_87_1) do
		local var_87_2, var_87_3 = self:CountAchievements(iter_87_1)
		local var_87_4 = self:GetMapAchieveStarDic(iter_87_1.id)
		local var_87_5 = {}

		for iter_87_2, iter_87_3 in ipairs(iter_87_1:GetAchievementAwards()) do
			if not var_87_4[iter_87_3.star] and var_87_2 + var_87_3 >= iter_87_3.star then
				table.insert(var_87_5, iter_87_3.star)
			end
		end

		if #var_87_5 > 0 then
			table.insert(var_87_0, {
				id = iter_87_1.id,
				star_list = var_87_5
			})
			table.insert(var_87_1, iter_87_1.id)
		end
	end

	return var_87_0, var_87_1
end

function World:CountAchievements(arg_88_1)
	local var_88_0 = 0
	local var_88_1 = 0
	local var_88_2 = 0

	for iter_88_0, iter_88_1 in ipairs((arg_88_1 or nil) and ({
		arg_88_1
	} or self.atlas:GetAchEntranceList())) do
		for iter_88_2, iter_88_3 in ipairs(iter_88_1.config.normal_target) do
			var_88_0 = var_88_0 + (self.achievements[iter_88_3] and self.achievements[iter_88_3]:IsAchieved() and 1 or 0)
		end

		for iter_88_4, iter_88_5 in ipairs(iter_88_1.config.cryptic_target) do
			var_88_1 = var_88_1 + (self.achievements[iter_88_5] and self.achievements[iter_88_5]:IsAchieved() and 1 or 0)
		end

		var_88_2 = var_88_2 + #iter_88_1.config.normal_target + #iter_88_1.config.cryptic_target
	end

	return var_88_0, var_88_1, var_88_2
end

local function var_0_1()
	return {
		[TeamType.Main] = {},
		[TeamType.Vanguard] = {},
		[TeamType.Submarine] = {},
		commanders = {}
	}
end

function World:BuildFormationIds()
	local var_90_0 = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}
	local var_90_1 = {
		[FleetType.Normal] = 2,
		[FleetType.Submarine] = 0
	}

	for iter_90_0, iter_90_1 in ipairs(pg.world_stage_template.all) do
		if self:GetProgress() >= pg.world_stage_template[iter_90_1].stage_key then
			var_90_1[FleetType.Normal] = math.max(var_90_1[FleetType.Normal], pg.world_stage_template[iter_90_1].fleet_num)
		else
			break
		end
	end

	local var_90_2

	if self:IsSystemOpen(WorldConst.SystemSubmarine) then
		var_90_1[FleetType.Submarine] = 1
		var_90_2 = self:IsActivate() and self:GetFleets() or self:GetDefaultFleets()
	end

	for iter_90_2, iter_90_3 in ipairs(var_90_2) do
		local var_90_3 = iter_90_3:GetFleetType()

		if #var_90_0[var_90_3] < var_90_1[var_90_3] then
			table.insert(var_90_0[var_90_3], iter_90_3:BuildFormationIds())
		end
	end

	for iter_90_4, iter_90_5 in pairs(var_90_0) do
		for iter_90_6 = 1, var_90_1[iter_90_4] do
			iter_90_5[iter_90_6] = iter_90_5[iter_90_6] or var_0_1()
		end
	end

	local var_90_4

	for iter_90_7, iter_90_8 in pairs((self:GetTaskProxy():getTasks())) do
		if iter_90_8.config.complete_condition == WorldConst.TaskTypeFleetExpansion and iter_90_8:isAlive() then
			var_90_4 = iter_90_8.config.complete_parameter[1]

			break
		end
	end

	if var_90_4 then
		for iter_90_9 = #var_90_0[FleetType.Normal] + 1, var_90_4 do
			var_90_0[FleetType.Normal][iter_90_9] = var_0_1()
		end
	end

	local var_90_5 = 0

	for iter_90_10, iter_90_11 in pairs(var_90_0) do
		var_90_5 = var_90_5 + #iter_90_11
	end

	return (var_90_4 or nil) and (WorldConst.FleetExpansion or WorldConst.FleetRedeploy), var_90_0, var_90_5
end

function World:FormationIds2NetIds(arg_91_1)
	local var_91_0 = {}

	for iter_91_0, iter_91_1 in ipairs({
		FleetType.Normal,
		FleetType.Submarine
	}) do
		for iter_91_2, iter_91_3 in ipairs(arg_91_1[iter_91_1]) do
			local var_91_1 = {}

			for iter_91_4, iter_91_5 in ipairs({
				TeamType.Main,
				TeamType.Vanguard,
				TeamType.Submarine
			}) do
				for iter_91_6 = 1, 3 do
					if iter_91_3[iter_91_5][iter_91_6] then
						table.insert(var_91_1, iter_91_3[iter_91_5][iter_91_6])
					end
				end
			end

			if #var_91_1 > 0 then
				table.insert(var_91_0, {
					ship_id_list = var_91_1,
					commanders = Clone(iter_91_3.commanders)
				})
			end
		end
	end

	return var_91_0
end

function World:CompareRedeploy(arg_92_1)
	local var_92_0 = {
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}
	local var_92_1 = {}
	local var_92_2 = 0

	for iter_92_0, iter_92_1 in pairs(arg_92_1) do
		for iter_92_2, iter_92_3 in ipairs(iter_92_1) do
			for iter_92_4, iter_92_5 in ipairs(var_92_0) do
				for iter_92_6 = 1, 3 do
					if iter_92_3[iter_92_5][iter_92_6] and not var_92_1[iter_92_3[iter_92_5][iter_92_6]] then
						var_92_1[iter_92_3[iter_92_5][iter_92_6]] = true
						var_92_2 = var_92_2 + 1
					end
				end
			end
		end
	end

	local var_92_3 = {}
	local var_92_4 = 0

	for iter_92_7, iter_92_8 in ipairs(self:GetFleets()) do
		for iter_92_9, iter_92_10 in ipairs(var_92_0) do
			for iter_92_11, iter_92_12 in ipairs((iter_92_8:GetTeamShips(iter_92_10, true))) do
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

	for iter_92_13, iter_92_14 in pairs(var_92_3) do
		if not var_92_1[iter_92_13] then
			return true
		end
	end

	for iter_92_15, iter_92_16 in pairs(var_92_1) do
		if not var_92_3[iter_92_15] then
			return true
		end
	end

	return false
end

function World:IsSystemOpen(arg_93_1)
	local var_93_0 = self:GetRealm()

	for iter_93_0, iter_93_1 in ipairs(pg.world_stage_template.all) do
		local var_93_1 = pg.world_stage_template[iter_93_1]

		if pg.world_stage_template[iter_93_1].stage_ui[1] == arg_93_1 and (var_93_1.stage_ui[2] == 0 or var_93_1.stage_ui[2] == var_93_0) then
			return self:GetProgress() >= var_93_1.stage_key
		end
	end

	return true
end

function World:CalcCDTimeCost(arg_94_1, arg_94_2)
	return math.floor(self[1] * math.max(self[2] - math.max(pg.TimeMgr.GetInstance():GetServerTime() - arg_94_1, 0), 0) / self[2] * math.max(16 - arg_94_2, 0) / 16)
end

function World:GetReqCDTime(arg_95_1)
	return self.cdTimeList[arg_95_1] or 0
end

function World:SetReqCDTime(arg_96_1, arg_96_2)
	self.cdTimeList[arg_96_1] = arg_96_2

	return
end

function World:InitWorldShopGoods()
	self.goodDic = {}

	for iter_97_0, iter_97_1 in ipairs({
		ShopArgs.WorldShop,
		ShopArgs.WorldCollection
	}) do
		for iter_97_2, iter_97_3 in ipairs(pg.shop_template.get_id_list_by_genre[iter_97_1]) do
			self.goodDic[iter_97_3] = 0
		end
	end

	return
end

function World:UpdateWorldShopGoods(arg_98_1)
	_.each(arg_98_1, function(arg_99_0)
		assert(self.goodDic[arg_99_0.goods_id], "without this good in id " .. arg_99_0.goods_id)

		self.goodDic[arg_99_0.goods_id] = self.goodDic[arg_99_0.goods_id] + arg_99_0.count

		return
	end)
	self:DispatchEvent(World.EventUpdateShopGoods, self.goodDic)

	return
end

function World:GetWorldShopGoodsDictionary()
	return self.goodDic
end

function World:InitWorldColorDictionary()
	self.colorDic = {}

	_.each(pg.world_chapter_colormask.all, function(arg_102_0)
		self.colorDic[Color.New(pg.world_chapter_colormask[arg_102_0].color[1] / 255, pg.world_chapter_colormask[arg_102_0].color[2] / 255, pg.world_chapter_colormask[arg_102_0].color[3] / 255):ToHex()] = pg.world_chapter_colormask[arg_102_0].id

		return
	end)

	return
end

function World:ColorToEntrance(arg_103_1)
	return self.colorDic[arg_103_1:ToHex()] and self:GetEntrance(self.colorDic[arg_103_1:ToHex()])
end

function World:GetGlobalBuff(arg_104_1)
	if not self.globalBuffDic[arg_104_1] then
		local var_104_0 = WorldBuff.New()

		var_104_0:Setup({
			floor = 0,
			id = arg_104_1
		})

		self.globalBuffDic[arg_104_1] = var_104_0
	end

	return self.globalBuffDic[arg_104_1]
end

function World:AddGlobalBuff(arg_105_1, arg_105_2)
	assert(arg_105_1 and arg_105_2)
	self:GetGlobalBuff(arg_105_1):AddFloor(arg_105_2)
	self:DispatchEvent(World.EventUpdateGlobalBuff)

	return
end

function World:RemoveBuff(arg_106_1, arg_106_2)
	assert(arg_106_1)

	if arg_106_2 then
		self:GetGlobalBuff(arg_106_1):AddFloor(arg_106_2 * -1)
	else
		self.globalBuffDic[arg_106_1] = nil
	end

	self:DispatchEvent(World.EventUpdateGlobalBuff)

	return
end

function World:GetWorldMapBuffLevel()
	return _.map(pg.gameset.world_mapbuff_list.description, function(arg_108_0)
		return self:GetGlobalBuff(arg_108_0).floor
	end)
end

function World:GetWorldMapBuffAverageLevel()
	local var_109_0 = self:GetWorldMapBuffLevel()
	local var_109_1 = 0

	underscore.each(var_109_0, function(arg_110_0)
		var_109_1 = var_109_1 + arg_110_0

		return
	end)

	return 0 / #var_109_0
end

function World:GetWorldMapBuffs()
	return _.map(pg.gameset.world_mapbuff_list.description, function(arg_112_0)
		return self:GetGlobalBuff(arg_112_0)
	end)
end

function World:GetWorldMapDifficultyBuffLevel()
	return pg.gameset.world_difficult_value.description[self:GetActiveMap().config.difficulty]
end

function World:OnUpdateItem(arg_114_1, arg_114_2, arg_114_3)
	if arg_114_3:getWorldItemType() == WorldItem.UsageWorldMap and self.atlas then
		self.atlas:UpdateTreasure(arg_114_3.id)
	end

	self.taskProxy:doUpdateTaskByItem(arg_114_3)

	return
end

function World:OnUpdateTask(arg_115_1, arg_115_2, arg_115_3)
	if self.atlas then
		self.atlas:UpdateTask(arg_115_3)
	end

	return
end

function World:GetPressingAward(arg_116_1)
	return self.pressingAwardDic[arg_116_1]
end

function World:FlagMapPressingAward(arg_117_1)
	local var_117_0 = self:GetPressingAward(arg_117_1)

	if var_117_0 then
		var_117_0.flag = false
	end

	return
end

function World:IsMapPressingAwardFlag(arg_118_1)
	local var_118_0 = self:GetPressingAward(arg_118_1)

	return var_118_0 and var_118_0.flag == false
end

function World:CheckAreaUnlock(arg_119_1)
	return self.progress >= pg.world_regions_data[arg_119_1].open_stage[1]
end

function World:CheckTaskLockMap()
	local var_120_0 = self:GetActiveMap().gid

	return _.any(self.taskProxy:getTaskVOs(), function(arg_121_0)
		return arg_121_0:isAlive() and arg_121_0:IsLockMap() and _.any(arg_121_0.config.task_target_map, function(arg_122_0)
			return arg_122_0 == var_120_0
		end)
	end)
end

function World:CheckResetAward(arg_123_1)
	self.resetAward = arg_123_1

	if getProxy(PlayerProxy):getData():getResource(WorldConst.ResourceID) == pg.gameset.world_resource_max.key_value then
		self.resetLimitTip = true
	end

	return
end

function World:ClearResetAward()
	self.resetAward = nil
	self.resetLimitTip = nil

	return
end

function World:GetTargetMapPressingCount(arg_125_1)
	local var_125_0 = 0

	for iter_125_0, iter_125_1 in ipairs(arg_125_1) do
		if self:GetMap(iter_125_1).isPressing then
			var_125_0 = var_125_0 + 1
		end
	end

	return var_125_0
end

function World:ClearAllFleetDefeatEnemies()
	underscore.each(self:GetFleets(), function(arg_127_0)
		arg_127_0:ClearDefeatEnemies()

		return
	end)

	return
end

function World:GetAreaEntranceIds(arg_128_1)
	return self.atlas.areaEntranceList[arg_128_1]
end

function World:CalcOrderCost(arg_129_1)
	local var_129_0 = 0

	if arg_129_1 == WorldConst.OpReqRedeploy then
		return World.CalcCDTimeCost(pg.gameset.world_fleet_redeploy_cost.description, self:GetReqCDTime(WorldConst.OpReqRedeploy), 0)
	elseif arg_129_1 == WorldConst.OpReqMaintenance then
		return pg.gameset.world_instruction_maintenance.description[1] * math.max(16 - 0, 0) / 16
	elseif arg_129_1 == WorldConst.OpReqSub then
		local var_129_1 = self:GetSubmarineFleet()

		if var_129_1 then
			underscore.each(var_129_1:GetShips(true), function(arg_130_0)
				var_129_0 = var_129_0 + arg_130_0:GetImportWorldShipVO():GetStaminaDiscount(WorldConst.OpReqSub)

				return
			end)
		end

		return World.CalcCDTimeCost(pg.gameset.world_instruction_submarine.description, self:GetReqCDTime(WorldConst.OpReqSub), 0)
	elseif arg_129_1 == WorldConst.OpReqVision then
		return World.CalcCDTimeCost(pg.gameset.world_instruction_detect.description, self:GetReqCDTime(WorldConst.OpReqVision), 0)
	else
		assert(false, "op type error: " .. arg_129_1)
	end

	return
end

function World:GetDisplayPressingCount()
	local var_131_0 = 0

	for iter_131_0, iter_131_1 in ipairs(self.atlas.pressingMapList) do
		if self.atlas:GetMap(iter_131_1):CheckMapPressingDisplay() then
			var_131_0 = var_131_0 + 1
		end
	end

	return var_131_0
end

function World:CheckCommanderInFleet(arg_132_1)
	if self.type == World.TypeBase then
		return underscore.any(self.baseCmdIds, function(arg_133_0)
			return arg_133_0 == arg_132_1
		end)
	else
		for iter_132_0, iter_132_1 in ipairs(self.fleets) do
			if iter_132_1:HasCommander(arg_132_1) then
				return true
			end
		end

		return false
	end

	return
end

function World:CheckSkipBattle()
	return getProxy(PlayerProxy):getRawData():CheckIdentityFlag() and world_skip_battle == 1
end

function World:IsMapVisioned(arg_135_1)
	local var_135_0 = self:GetActiveMap()

	if var_135_0.id == arg_135_1 then
		local var_135_1, var_135_2 = World.ReplacementMapType(self:GetActiveEntrance(), var_135_0)

		if var_135_1 == "base_chapter" and var_135_0.isPressing then
			return true
		elseif var_135_1 == "teasure_chapter" and var_135_2 == i18n("area_yinmi") and self:GetGobalFlag("treasure_flag") then
			return true
		end
	end

	return self:IsMapPressingAwardFlag(arg_135_1)
end

function World:HasAutoFightDrops()
	return #self.autoInfos.drops > 0 or underscore.any(self.autoInfos.salvage, function(arg_137_0)
		return #arg_137_0 > 0
	end) or #self.autoInfos.buffs > 0 or #self.autoInfos.message > 0
end

function World:AddAutoInfo(arg_138_1, arg_138_2)
	if arg_138_1 == "drops" then
		self.autoInfos.drops = table.mergeArray(self.autoInfos.drops, arg_138_2)
	elseif arg_138_1 == "salvage" then
		self.autoInfos.salvage[arg_138_2.rarity] = table.mergeArray(self.autoInfos.salvage[arg_138_2.rarity], arg_138_2.drops)
	elseif arg_138_1 == "events" then
		table.insert(self.autoInfos.events, arg_138_2)
	elseif arg_138_1 == "buffs" then
		table.insert(self.autoInfos.buffs, arg_138_2)
	elseif arg_138_1 == "message" then
		table.insert(self.autoInfos.message, arg_138_2)
	else
		assert(false, "type error:" .. arg_138_1)
	end

	return
end

function World:InitAutoInfos()
	self.autoInfos = {
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

function World:TriggerAutoFight(arg_140_1)
	arg_140_1 = arg_140_1 and self:GetActiveMap():CanAutoFight()

	if tobool(arg_140_1) ~= tobool(self.isAutoFight) then
		self.isAutoFight = arg_140_1

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
		self:TriggerAutoSwitch(false)
	end

	return
end

function World:TriggerAutoSwitch(arg_141_1)
	if tobool(arg_141_1) ~= tobool(self.isAutoSwitch) then
		self.isAutoSwitch = arg_141_1

		pg.m02:sendNotification(GAME.WORLD_TRIGGER_AUTO_SWITCH)
	end

	return
end

function World:GetHistoryLowestHP(arg_142_1)
	return self.lowestHP[arg_142_1] or 10000
end

function World:SetHistoryLowestHP(arg_143_1, arg_143_2)
	self.lowestHP[arg_143_1] = arg_143_2

	return
end

local var_0_2 = {
	treasure_flag = 1
}

function World:SetGlobalFlag(arg_144_1, arg_144_2)
	self.gobalFlag[var_0_2[arg_144_1]] = arg_144_2

	return
end

function World:GetGobalFlag(arg_145_1)
	return self.gobalFlag[var_0_2[arg_145_1]]
end

return World
