local WorldMapAttachment = class("WorldMapAttachment", import("...BaseEntity"))

WorldMapAttachment.Fields = {
	config = "table",
	dataop = "number",
	buffList = "table",
	type = "number",
	row = "number",
	data = "number",
	column = "number",
	flag = "number",
	effects = "table",
	triggered = "boolean",
	hp = "number",
	finishMark = "number",
	id = "number",
	lurk = "boolean"
}
WorldMapAttachment.EventUpdateFlag = "WorldMapAttachment.EventUpdateFlag"
WorldMapAttachment.EventUpdateData = "WorldMapAttachment.EventUpdateData"
WorldMapAttachment.EventUpdateLurk = "WorldMapAttachment.EventUpdateLurk"
WorldMapAttachment.TypeBox = 2
WorldMapAttachment.TypeEnemy = 6
WorldMapAttachment.TypeBoss = 8
WorldMapAttachment.TypeArtifact = 10
WorldMapAttachment.TypeEnemyAI = 12
WorldMapAttachment.TypeFleet = 13
WorldMapAttachment.TypeTransportFleet = 17
WorldMapAttachment.TypeEvent = 22
WorldMapAttachment.TypeTrap = 23
WorldMapAttachment.TypePort = -1
WorldMapAttachment.SortOrder = {
	[WorldMapAttachment.TypeArtifact] = -99,
	[WorldMapAttachment.TypeTrap] = -1,
	[WorldMapAttachment.TypePort] = 0,
	[WorldMapAttachment.TypeEvent] = 1,
	[WorldMapAttachment.TypeBox] = 2,
	[WorldMapAttachment.TypeEnemy] = 3,
	[WorldMapAttachment.TypeEnemyAI] = 4,
	[WorldMapAttachment.TypeBoss] = 5,
	[WorldMapAttachment.TypeTransportFleet] = 6
}

function WorldMapAttachment:IsEnemyType()
	return self == WorldMapAttachment.TypeEnemy or self == WorldMapAttachment.TypeEnemyAI or self == WorldMapAttachment.TypeBoss
end

function WorldMapAttachment:IsHPEnemyType()
	return self == WorldMapAttachment.TypeEnemyAI or self == WorldMapAttachment.TypeBoss
end

function WorldMapAttachment:IsFakeType()
	return self == WorldMapAttachment.TypePort
end

function WorldMapAttachment:IsInteractiveType()
	return WorldMapAttachment.IsEnemyType(self) or self == WorldMapAttachment.TypeEvent or self == WorldMapAttachment.TypeBox
end

function WorldMapAttachment:MakeFakePort(arg_5_1, arg_5_2)
	local var_5_0 = WPool:Get(WorldMapAttachment)

	var_5_0:Setup({
		item_data = 0,
		item_flag = 0,
		pos = {
			row = self,
			column = arg_5_1
		},
		item_type = WorldMapAttachment.TypePort,
		item_id = arg_5_2,
		buff_list = {},
		effect_list = {}
	})

	return var_5_0
end

function WorldMapAttachment:IsClientType()
	return self > 1000
end

WorldMapAttachment.EffectEventStory = 2
WorldMapAttachment.EffectEventTeleport = 3
WorldMapAttachment.EffectEventDrop = 7
WorldMapAttachment.EffectEventShipBuff = 8
WorldMapAttachment.EffectEventGuide = 13
WorldMapAttachment.EffectEventDropTreasure = 14
WorldMapAttachment.EffectEventBlink1 = 16
WorldMapAttachment.EffectEventBlink2 = 17
WorldMapAttachment.EffectEventAchieveCarry = 18
WorldMapAttachment.EffectEventConsumeCarry = 19
WorldMapAttachment.EffectEventTeleportEvent = 20
WorldMapAttachment.EffectEventConsumeItem = 24
WorldMapAttachment.EffectEventStoryOption = 27
WorldMapAttachment.EffectEventFleetShipHP = 30
WorldMapAttachment.EffectEventProgress = 32
WorldMapAttachment.EffectEventTeleportBack = 37
WorldMapAttachment.EffectEventDeleteTask = 40
WorldMapAttachment.EffectEventGlobalBuff = 44
WorldMapAttachment.EffectEventMapClearFlag = 45
WorldMapAttachment.EffectEventBrokenClean = 48
WorldMapAttachment.EffectEventCatSalvage = 49
WorldMapAttachment.EffectEventAddWorldBossFreeCount = 50
WorldMapAttachment.EffectSideText = 52
WorldMapAttachment.EffectEventFOV = 1001
WorldMapAttachment.EffectEventCameraMove = 1002
WorldMapAttachment.EffectEventShakePlane = 1003
WorldMapAttachment.EffectEventFlash = 1004
WorldMapAttachment.EffectEventHelp = 1005
WorldMapAttachment.EffectEventShowMapMark = 1006
WorldMapAttachment.EffectEventReturn2World = 1007
WorldMapAttachment.EffectEventStoryOptionClient = 1009
WorldMapAttachment.EffectEventShowPort = 1010
WorldMapAttachment.EffectEventSound = 1011
WorldMapAttachment.EffectEventHelpLayer = 1012
WorldMapAttachment.EffectEventMsgbox = 1013
WorldMapAttachment.EffectEventStoryBattle = 1014
WorldMapAttachment.CompassTypeNone = 0
WorldMapAttachment.CompassTypeBattle = 1
WorldMapAttachment.CompassTypeExploration = 2
WorldMapAttachment.CompassTypeTask = 3
WorldMapAttachment.CompassTypeBoss = 4
WorldMapAttachment.CompassTypeGuidePost = 5
WorldMapAttachment.CompassTypeTaskTrack = 6
WorldMapAttachment.CompassTypePort = 7
WorldMapAttachment.CompassTypeSalvage = 8
WorldMapAttachment.CompassTypeFile = 9
WorldMapAttachment.SpEventHaibao = 1
WorldMapAttachment.SpEventFufen = 2
WorldMapAttachment.SpEventEnemy = 3
WorldMapAttachment.SpEventConsumeItem = 4

function WorldMapAttachment:DebugPrint()
	if self.type == WorldMapAttachment.TypeEvent then
		local var_7_0 = {}
		local var_7_1 = {}
		local var_7_2 = 1
		local var_7_3 = 1

		while var_7_3 <= #pg.world_event_data[self.id].effect do
			local var_7_4 = pg.world_event_data[self.id].effect[#pg.world_event_data[self.id].effect - var_7_3 + 1]

			if self.effects[#self.effects - var_7_2 + 1] == pg.world_event_data[self.id].effect[#pg.world_event_data[self.id].effect - var_7_3 + 1] then
				table.insert(var_7_1, 1, self.effects[#self.effects - var_7_2 + 1])

				var_7_3 = var_7_3 + 1
				var_7_2 = var_7_2 + 1
			elseif not self.effects[#self.effects - var_7_2 + 1] then
				table.insert(var_7_1, 1, setColorStr(var_7_4, COLOR_GREEN))

				var_7_3 = var_7_3 + 1
			else
				local var_7_5 = pg.world_effect_data[var_7_4].effect_type

				if pg.world_effect_data[var_7_4].effect_type == 27 or var_7_5 == 35 or var_7_5 == 36 or var_7_5 == 53 then
					table.insert(var_7_1, 1, setColorStr(self.effects[#self.effects - var_7_2 + 1], COLOR_BLUE))

					var_7_2 = var_7_2 + 1
				else
					table.insert(var_7_1, 1, setColorStr(self.effects[#self.effects - var_7_2 + 1], COLOR_RED))

					var_7_3 = var_7_3 + 1
					var_7_2 = var_7_2 + 1
				end
			end
		end

		local var_7_6 = "" .. table.concat(var_7_1, ", ")

		for iter_7_0, iter_7_1 in ipairs(self.config.event_op) do
			if iter_7_0 <= #self.config.event_op - self.dataop then
				table.insert(var_7_0, setColorStr(iter_7_1, COLOR_GREEN))
			else
				table.insert(var_7_0, iter_7_1)
			end
		end

		return string.format("事件  [id: %d]  [%s]  [位置: %d, %d]  [flag: %s]  [data: %d]  [感染值：%s]  [自动优先级：%s] \n     [effect: %s] \n     [effect_op: %s] \n     [buff: %s]", self.id, self.config.name, self.row, self.column, self.flag, self.data, setColorStr(self.config.infection_value, COLOR_RED), setColorStr(self.config.auto_pri, COLOR_YELLOW), var_7_6, table.concat(var_7_0, ", "), table.concat(self.buffList, ", "))
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		return string.format("敌人  [id: %s]  [%s]  [类型 %s]  [位置: %s, %s]  [flag: %s]  [data: %s]  [buff: %s]", self.id, self.config.name, self.type, self.row, self.column, tostring(self.flag), tostring(self.data), table.concat(self.buffList, ", "))
	elseif self.type == WorldMapAttachment.TypeTrap then
		return string.format("陷阱  [id: %s]  [%s]  [位置: %s, %s]  [flag: %s]  [data: %s]", self.id, self.config.name, self.row, self.column, tostring(self.flag), tostring(self.data))
	elseif self.type == WorldMapAttachment.TypeFleet then
		return string.format("舰队  [id: %s]  [%s]  [位置: %s, %s]  [flag: %s]  [data: %s]", self.id, "我方舰队", self.row, self.column, tostring(self.flag), tostring(self.data))
	elseif self.type == WorldMapAttachment.TypeArtifact then
		return string.format("场景物件  [id: %s]  [位置: %s, %s]  [flag: %s]  [data: %s]  [buff: %s]", self.id, self.row, self.column, tostring(self.flag), tostring(self.data), table.concat(self.buffList, ", "))
	end

	return
end

function WorldMapAttachment:Setup(arg_8_1)
	self.row = arg_8_1.pos.row
	self.column = arg_8_1.pos.column
	self.type = arg_8_1.item_type
	self.id = arg_8_1.item_id
	self.flag = arg_8_1.item_flag
	self.data = arg_8_1.item_data
	self.effects = underscore.rest(arg_8_1.effect_list, 1)
	self.buffList = underscore.rest(arg_8_1.buff_list, 1)
	self.hp = arg_8_1.boss_hp

	self:InitConfig()
	self:InitData()

	return
end

function WorldMapAttachment:InitConfig()
	if self.type == WorldMapAttachment.TypeBox then
		self.config = pg.box_data_template[self.id]

		assert(self.config, "box_data_template not exist: " .. self.id)
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		self.config = pg.expedition_data_template[self.id]

		assert(self.config, "expedition_data_template not exist: " .. self.id)
	elseif self.type == WorldMapAttachment.TypeEvent then
		self.config = pg.world_event_data[self.id]

		assert(self.config, "world_event_data not exist: " .. self.id)
	elseif self.type == WorldMapAttachment.TypePort then
		self.config = pg.world_port_data[self.id]

		assert(self.config, "world_port_data not exist: " .. self.id)
	elseif self.type == WorldMapAttachment.TypeTransportFleet then
		self.config = pg.friendly_data_template[self.id]

		assert(self.config, "friendly_data_template not exist: " .. self.id)
	elseif self.type == WorldMapAttachment.TypeTrap then
		self.config = pg.world_trap_data[self.id]

		assert(self.config, "world_trap_data not exist: " .. self.id)
	elseif self.type == WorldMapAttachment.TypeArtifact then
		self.config = pg.world_event_data[self.id]

		assert(self.config, "with out this atrifact: " .. self.id)
	end

	return
end

function WorldMapAttachment:InitData()
	if self.type == WorldMapAttachment.TypeEvent then
		self.dataop = #self.config.event_op
	end

	return
end

function WorldMapAttachment:IsAlive()
	if self.type == WorldMapAttachment.TypeEvent then
		return true
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		return self.flag ~= 1 and self.data ~= 0
	elseif self.type == WorldMapAttachment.TypeTransportFleet then
		return self:GetHP() > 0
	elseif self.type == WorldMapAttachment.TypeArtifact then
		return false
	end

	return self.flag ~= 1
end

function WorldMapAttachment:IsVisible()
	local var_12_0 = not self.lurk

	if self.type == WorldMapAttachment.TypeEvent then
		var_12_0 = var_12_0 and self.config.discover_type == 2
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		var_12_0 = var_12_0 and self:IsAlive()
	end

	return var_12_0
end

function WorldMapAttachment:IsFloating()
	return self.type == WorldMapAttachment.TypeEvent and self.config.icontype == 1 or self.type == WorldMapAttachment.TypeBox
end

function WorldMapAttachment:UpdateFlag(arg_14_1)
	if self.flag ~= arg_14_1 then
		self.flag = arg_14_1

		self:DispatchEvent(WorldMapAttachment.EventUpdateFlag)
	end

	return
end

function WorldMapAttachment:UpdateData(arg_15_1, arg_15_2)
	self.data = arg_15_1

	if self.type == WorldMapAttachment.TypeEvent then
		self.effects = underscore.rest(arg_15_2, 1)
	end

	self:DispatchEvent(WorldMapAttachment.EventUpdateData)

	return
end

function WorldMapAttachment:UpdateLurk(arg_16_1)
	if self.lurk ~= arg_16_1 then
		self.lurk = arg_16_1

		self:DispatchEvent(WorldMapAttachment.EventUpdateLurk)
	end

	return
end

function WorldMapAttachment:UpdateDataOp(arg_17_1)
	self.dataop = arg_17_1

	return
end

function WorldMapAttachment:GetEventEffect()
	assert(self.type == WorldMapAttachment.TypeEvent, string.format("type error:%d", self.type))

	return self.effects[1] and pg.world_effect_data[self.effects[1]]
end

function WorldMapAttachment:GetEventEffects()
	assert(self.type == WorldMapAttachment.TypeEvent, string.format("type error:%d", self.type))

	return _.map(self.effects, function(arg_20_0)
		return pg.world_effect_data[arg_20_0]
	end)
end

function WorldMapAttachment:RemainOpEffect()
	return self.dataop > 0
end

function WorldMapAttachment:GetOpEffect()
	local var_22_0 = self.config.event_op[#self.config.event_op - self.dataop + 1]

	assert(pg.world_effect_data[var_22_0], "world_effect_data not exist: " .. var_22_0)

	return pg.world_effect_data[var_22_0]
end

function WorldMapAttachment:GetBattleStageId()
	assert(WorldMapAttachment.IsEnemyType(self.type))

	return self.id
end

function WorldMapAttachment:GetLimitDamageLevel()
	return pg.world_expedition_data[self:GetBattleStageId()].morale_limit
end

function WorldMapAttachment:ShouldMarkAsLurk()
	return self.type == WorldMapAttachment.TypeEvent and self.config.visuality == 1 and self.config.discover_type == 2
end

function WorldMapAttachment:CanLeave()
	if WorldMapAttachment.IsEnemyType(self.type) then
		return false
	elseif self.type == WorldMapAttachment.TypeEvent or self.type == WorldMapAttachment.TypeTrap then
		return WorldConst.GetObstacleConfig(self.config.obstacle, "leave")
	else
		return true
	end

	return
end

function WorldMapAttachment:CanArrive()
	if self.type == WorldMapAttachment.TypeEvent or self.type == WorldMapAttachment.TypeTrap then
		return WorldConst.GetObstacleConfig(self.config.obstacle, "arrive")
	else
		return true
	end

	return
end

function WorldMapAttachment:CanPass()
	if WorldMapAttachment.IsEnemyType(self.type) then
		return false
	elseif self.type == WorldMapAttachment.TypeEvent or self.type == WorldMapAttachment.TypeTrap then
		return WorldConst.GetObstacleConfig(self.config.obstacle, "pass")
	else
		return true
	end

	return
end

function WorldMapAttachment:IsAvatar()
	if self.type == WorldMapAttachment.TypeEvent then
		if self:GetReplaceDisplayEnemyConfig() then
			return false
		end

		return math.floor(self.config.enemyicon / 2) == 1
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		return self.config.icon_type == 2
	end

	return false
end

function WorldMapAttachment:IsSign()
	if self.type == WorldMapAttachment.TypeEvent then
		return self.config.is_guide == 1
	end

	return false
end

function WorldMapAttachment:IsBoss()
	return WorldMapAttachment.IsEnemyType(self.type) and WorldConst.EnemySize[self.config.type] == 99
end

function WorldMapAttachment:GetBuffList()
	return underscore.map(self.buffList, function(arg_33_0)
		local var_33_0 = WorldBuff.New()

		var_33_0:Setup({
			floor = 1,
			id = arg_33_0
		})

		return var_33_0
	end)
end

function WorldMapAttachment:UpdateBuffList(arg_34_1)
	local var_34_0 = self:GetWeaknessBuffId()

	self.buffList = arg_34_1

	if var_34_0 ~= self:GetWeaknessBuffId() then
		return var_34_0 and {
			anim = "WorldWeaknessUpgradeWindow",
			hp = self:GetMaxHP()
		} or {
			anim = "WorldWeaknessDiscoverWindow",
			hp = self:GetMaxHP()
		}
	end

	return
end

function WorldMapAttachment:GetWeaknessBuffId()
	if not WorldMapAttachment.IsEnemyType(self.type) then
		return
	end

	local var_35_0 = {}

	underscore.each(underscore.flatten(pg.world_expedition_data[self:GetBattleStageId()].weak_list), function(arg_36_0)
		var_35_0[arg_36_0] = true

		return
	end)

	for iter_35_0, iter_35_1 in ipairs(self.buffList) do
		if var_35_0[iter_35_1] then
			return iter_35_1
		end
	end

	return
end

function WorldMapAttachment:GetBattleLuaBuffs()
	local var_37_0 = {}

	underscore.each(self:GetBuffList(), function(arg_38_0)
		if arg_38_0.config.lua_id > 0 then
			table.insert(var_37_0, arg_38_0.config.lua_id)
		end

		return
	end)

	return var_37_0
end

function WorldMapAttachment:GetCompassType()
	if self.type == WorldMapAttachment.TypeEvent then
		return self.config.compass_index
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		if self:IsBoss() then
			return WorldMapAttachment.CompassTypeBoss
		else
			return WorldMapAttachment.CompassTypeBattle
		end
	elseif self.type == WorldMapAttachment.TypeBox then
		return WorldMapAttachment.CompassTypeExploration
	elseif self.type == WorldMapAttachment.TypePort then
		return WorldMapAttachment.CompassTypePort
	end

	return
end

function WorldMapAttachment:GetSpEventType()
	if self.type == WorldMapAttachment.TypeEvent then
		return self.config.special_enemy
	end

	return
end

function WorldMapAttachment:GetDeviation()
	if self.type ~= WorldMapAttachment.TypeEvent then
		if self.type == WorldMapAttachment.TypeArtifact then
			return Vector2(self.config.deviation[1], self.config.deviation[2])
		end
	end

	return Vector2.zero
end

function WorldMapAttachment:GetScale(arg_42_1)
	local var_42_0 = 1

	if self.type == WorldMapAttachment.TypeEvent then
		if self.config.scale == 0 then
			return Vector3.one
		else
			var_42_0 = self.config.scale / 100
		end
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		var_42_0 = 0.4 * self.config.scale / 100
	elseif self.type == WorldMapAttachment.TypeTrap and self.id == 200 then
		arg_42_1 = arg_42_1 or self.data
		var_42_0 = var_42_0 * (arg_42_1 + arg_42_1 - 1)
	end

	return Vector3(var_42_0, var_42_0, var_42_0)
end

function WorldMapAttachment:GetModelOrder()
	if self.type == WorldMapAttachment.TypeTrap then
		return WorldConst.LOEffectC
	end

	return WorldConst.LOCell
end

function WorldMapAttachment:GetMillor()
	if self.type == WorldMapAttachment.TypeEvent then
		return self.config.enemyicon % 2 == 1
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		return true
	end

	return false
end

function WorldMapAttachment:GetDirType()
	if self:GetSpEventType() == WorldMapAttachment.SpEventFufen then
		return WorldConst.DirType4
	else
		return WorldConst.DirType2
	end

	return
end

function WorldMapAttachment:GetReplaceDisplayEnemyConfig()
	assert(self.type == WorldMapAttachment.TypeEvent)

	return pg.expedition_data_template[self.config.expedition_icon]
end

function WorldMapAttachment:GetDebugName()
	if self.type == WorldMapAttachment.TypeEvent then
		return "event_" .. self.id
	elseif self.type == WorldMapAttachment.TypeBox then
		return "box_" .. self.id
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		return "enemy_" .. self.id
	elseif self.type == WorldMapAttachment.TypeTransportFleet then
		return "transport_" .. self.id
	elseif self.type == WorldMapAttachment.TypeTrap then
		return "trap_" .. self.id
	elseif self.type == WorldMapAttachment.TypePort then
		return "port_" .. self.id
	end

	return
end

function WorldMapAttachment:IsTriggered()
	return self.triggered
end

function WorldMapAttachment:IsScannerAttachment()
	return WorldMapAttachment.IsEnemyType(self.type) and 4 or self.type == WorldMapAttachment.TypeTrap and 3 or self.type == WorldMapAttachment.TypeEvent and self.config.is_scanevent > 0 and 2 or self.type == WorldMapAttachment.TypePort and 1
end

function WorldMapAttachment:SetHP(arg_50_1)
	if WorldMapAttachment.IsHPEnemyType(self.type) then
		local var_50_0 = self.hp

		if self:IsPeriodEnemy() then
			local var_50_1 = nowWorld()

			var_50_0 = math.min(var_50_0, var_50_1:GetHistoryLowestHP(self.id))

			var_50_1:SetHistoryLowestHP(self.id, arg_50_1)
		end

		local var_50_2 = {}

		for iter_50_0, iter_50_1 in ipairs(pg.world_expedition_data[self:GetBattleStageId()].phase_story) do
			if var_50_0 > iter_50_1[1] and arg_50_1 <= iter_50_1[1] then
				table.insert(var_50_2, {
					hp = iter_50_1[1],
					story = iter_50_1[2]
				})
			end
		end

		self.hp = arg_50_1

		return var_50_2
	else
		return {}
	end

	return
end

function WorldMapAttachment:GetHP()
	if self.type == WorldMapAttachment.TypeTransportFleet then
		return self.data
	elseif WorldMapAttachment.IsHPEnemyType(self.type) then
		return self.hp
	end

	return
end

function WorldMapAttachment:GetMaxHP()
	if self.type == WorldMapAttachment.TypeTransportFleet then
		return self.config.hp
	elseif WorldMapAttachment.IsHPEnemyType(self.type) then
		return 10000
	end

	return
end

function WorldMapAttachment:GetArtifaceInfo()
	assert(self.type == WorldMapAttachment.TypeArtifact, "type error from id: " .. self.id)
	assert(math.floor(self.config.enemyicon / 2) == 2, "enemyicon error from id: " .. self.id)

	return {
		self.row,
		self.column,
		self.config.icon
	}
end

function WorldMapAttachment:GetVisionRadius()
	if self.type == WorldMapAttachment.TypeEvent then
		return self.config.event_sight
	else
		return -1
	end

	return
end

function WorldMapAttachment:GetRadiationBuffs()
	if self.type == WorldMapAttachment.TypeEvent then
		return self.config.map_buff
	else
		return {}
	end

	return
end

function WorldMapAttachment:IsAttachmentFinish()
	return self.finishMark == self.data
end

function WorldMapAttachment:GetEventAutoPri()
	assert(self.type == WorldMapAttachment.TypeEvent, "type error from id: " .. self.id)

	return self.config.auto_pri
end

function WorldMapAttachment:IsPeriodEnemy()
	assert(WorldMapAttachment.IsHPEnemyType(self.type), string.format("enemy %d type %d error", self.id, self.type))

	return pg.world_expedition_data[self.id] and pg.world_expedition_data[self.id].phase_limit == 1
end

return WorldMapAttachment
