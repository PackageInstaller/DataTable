local WorldConst = class("WorldConst")

WorldConst.Debug = false

function WorldConst.Print(...)
	if WorldConst.Debug then
		warning(...)
	end

	return
end

function WorldConst:DebugPrintAttachmentCell(arg_2_1)
	if not WorldConst.Debug then
		return
	end

	warning(self)

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		warning(iter_2_0, #iter_2_1.attachmentList)

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.attachmentList) do
			warning(iter_2_3:DebugPrint())
		end
	end

	return
end

WorldConst.DefaultAtlas = 1

function WorldConst:GetProgressAtlas()
	return WorldConst.DefaultAtlas
end

WorldConst.MaxRow = 30
WorldConst.MaxColumn = 30
WorldConst.LineCross = 2
WorldConst.ActionIdle = "normal"
WorldConst.ActionMove = "move"
WorldConst.ActionDrag = "tuozhuai"
WorldConst.ActionYun = "yun"
WorldConst.ActionVanish = "vanish"
WorldConst.ActionAppear = "appear"
WorldConst.AutoFightLoopCountLimit = 25
WorldConst.EnemySize = {
	[0] = 2,
	3,
	1,
	2,
	3,
	1,
	2,
	3,
	1,
	2,
	3,
	3,
	99,
	99,
	[nil] = 1
}
WorldConst.ResourceID = 3002
WorldConst.SwitchPlainingItemId = 120
WorldConst.ReqName = {
	[0] = "OpReqBox",
	nil,
	nil,
	nil,
	nil,
	nil,
	"OpReqRound",
	"OpReqSub",
	"OpReqEvent",
	nil,
	"OpReqDiscover",
	"OpReqTransport",
	"OpReqRetreat",
	nil,
	nil,
	nil,
	"OpReqTask",
	nil,
	"OpReqMaintenance",
	"OpReqVision",
	nil,
	"OpReqRedeploy",
	nil,
	"OpReqPressingMap",
	"OpReqJumpOut",
	"OpReqEnterPort",
	"OpReqCatSalvage",
	"OpReqSwitchFleet",
	99,
	"OpReqSkipBattle",
	[nil] = "OpReqMoveFleet"
}

for iter_0_0, iter_0_1 in pairs(WorldConst.ReqName) do
	WorldConst[iter_0_1] = iter_0_0
end

WorldConst.OpActionFleetMove = -100
WorldConst.OpActionAttachmentMove = -101
WorldConst.OpActionAttachmentAnim = -102
WorldConst.OpActionNextRound = -103
WorldConst.OpActionEventOp = -104
WorldConst.OpActionMoveStep = -105
WorldConst.OpActionUpdate = -106
WorldConst.OpActionFleetAnim = -107
WorldConst.OpActionEventEffect = -108
WorldConst.OpActionTaskGoto = -109
WorldConst.OpActionCameraMove = -110
WorldConst.OpActionTrapGravityAnim = -111
WorldConst.RoundPlayer = 0
WorldConst.RoundElse = 1
WorldConst.DirNone = 0
WorldConst.DirUp = 1
WorldConst.DirRight = 2
WorldConst.DirDown = 3
WorldConst.DirLeft = 4

function WorldConst:DirToLine()
	if self == WorldConst.DirNone then
		return {
			row = 0,
			column = 0
		}
	elseif self == WorldConst.DirUp then
		return {
			row = -1,
			column = 0
		}
	elseif self == WorldConst.DirRight then
		return {
			row = 0,
			column = 1
		}
	elseif self == WorldConst.DirDown then
		return {
			row = 1,
			column = 0
		}
	elseif self == WorldConst.DirLeft then
		return {
			row = 0,
			column = -1
		}
	else
		assert(false, "without this dir " .. self)
	end

	return
end

WorldConst.DefaultMapOffset = Vector3(0, -1000, -1000)

function WorldConst:InFOVRange(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_4 = arg_5_4 or WorldConst.GetFOVRadius()

	return (self - arg_5_2) * (self - arg_5_2) + (arg_5_1 - arg_5_3) * (arg_5_1 - arg_5_3) <= arg_5_4 * arg_5_4
end

function WorldConst.GetFOVRadius()
	return pg.gameset.world_move_initial_view.key_value
end

function WorldConst:IsRookieMap()
	return _.any(pg.gameset.world_guide_map_list.description, function(arg_8_0)
		return self == arg_8_0
	end)
end

function WorldConst:GetRealmRookieId()
	assert(self and self > 0)

	return unpack(pg.gameset.world_default_entrance.description[self])
end

function WorldConst:ParseConfigDir(arg_10_1)
	if self == -1 then
		return WorldConst.DirUp
	elseif self == 1 then
		return WorldConst.DirDown
	elseif arg_10_1 == -1 then
		return WorldConst.DirLeft
	elseif arg_10_1 == 1 then
		return WorldConst.DirRight
	end

	assert(false)

	return
end

function WorldConst:Pos2FogRes(arg_11_1)
	self = self % 3
	arg_11_1 = arg_11_1 % 3

	return "miwu0" .. self * 3 + arg_11_1 + 1
end

WorldConst.TerrainStreamRes = {
	"yangliu_shang",
	"yangliu_you",
	"yangliu_xia",
	"yangliu_zuo"
}
WorldConst.TerrainWindRes = {
	"longjuanfeng_shang",
	"longjuanfeng_you",
	"longjuanfeng_xia",
	"longjuanfeng_zuo"
}
WorldConst.TerrainPoisonRes = {
	"poison01",
	"poison02"
}

function WorldConst:GetTerrainEffectRes(arg_12_1, arg_12_2)
	if self == WorldMapCell.TerrainStream then
		return "world/object/" .. WorldConst.TerrainStreamRes[arg_12_1], WorldConst.TerrainStreamRes[arg_12_1]
	elseif self == WorldMapCell.TerrainWind then
		return "world/object/" .. WorldConst.TerrainWindRes[arg_12_1], WorldConst.TerrainWindRes[arg_12_1]
	elseif self == WorldMapCell.TerrainIce then
		return "world/object/ice", "ice"
	elseif self == WorldMapCell.TerrainPoison then
		return "world/object/" .. WorldConst.TerrainPoisonRes[arg_12_2], WorldConst.TerrainPoisonRes[arg_12_2]
	end

	assert(false)

	return
end

function WorldConst.GetWindEffect()
	return "world/object/longjuanfeng", "longjuanfeng"
end

function WorldConst:GetBuffEffect()
	return "ui/" .. self, self
end

WorldConst.PoisonEffect = "san_low"

function WorldConst:ArrayEffectOrder(arg_15_1)
	local var_15_0 = {}

	table.insertto(var_15_0, (self:GetComponentsInChildren(typeof(Renderer), true):ToTable()))
	table.insertto(var_15_0, (self:GetComponentsInChildren(typeof(Canvas), true):ToTable()))

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		iter_15_1.sortingOrder = iter_15_1.sortingOrder + arg_15_1
	end

	return
end

WorldConst.Flag16Max = 65535
WorldConst.LOEffectA = 1
WorldConst.LOQuad = 1000
WorldConst.LOEffectB = 1001
WorldConst.LOItem = 2000
WorldConst.LOEffectC = 2001
WorldConst.LOCell = 3000
WorldConst.LOFleet = 3001
WorldConst.LOTop = 4000
WorldConst.WindScale = {
	0.5,
	0.5,
	0.75,
	0.75,
	1
}

function WorldConst:GetWindScale()
	local var_16_0

	if self then
		var_16_0 = WorldConst.WindScale[self] or 1
	end

	return Vector3(var_16_0, var_16_0, var_16_0)
end

WorldConst.BaseMoveDuration = 0.35

function WorldConst:GetTerrainMoveStepDuration()
	WorldConst.MoveStepDuration = WorldConst.MoveStepDuration or {
		[WorldMapCell.TerrainNone] = WorldConst.BaseMoveDuration,
		[WorldMapCell.TerrainWind] = WorldConst.BaseMoveDuration / 2,
		[WorldMapCell.TerrainStream] = WorldConst.BaseMoveDuration / 2,
		[WorldMapCell.TerrainIce] = WorldConst.BaseMoveDuration / 2,
		[WorldMapCell.TerrainFog] = WorldConst.BaseMoveDuration,
		[WorldMapCell.TerrainFire] = WorldConst.BaseMoveDuration,
		[WorldMapCell.TerrainPoison] = WorldConst.BaseMoveDuration
	}

	return WorldConst.MoveStepDuration[self]
end

WorldConst.UIEaseDuration = 0.5
WorldConst.UIEaseFasterDuration = 0.3
WorldConst.ModelSpine = 1
WorldConst.ModelPrefab = 2
WorldConst.ResBoxPrefab = "boxprefab/"
WorldConst.ResChapterPrefab = "chapter/"
WorldConst.DirType1 = 1
WorldConst.DirType2 = 2
WorldConst.DirType4 = 4

function WorldConst:CalcModelPosition(arg_18_1)
	return Vector3((self.config.area_pos[1] - arg_18_1.x / 2) / PIXEL_PER_UNIT, 0, (self.config.area_pos[2] - arg_18_1.y / 2) / PIXEL_PER_UNIT)
end

WorldConst.BrokenBuffId = pg.gameset.world_death_buff.key_value
WorldConst.MoveLimitBuffId = pg.gameset.world_move_buff_desc.key_value
WorldConst.DamageBuffList = pg.gameset.world_buff_morale.description

function WorldConst:ExtendPropertiesRatesFromBuffList(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		assert(iter_19_1.class == WorldBuff)

		if iter_19_1:IsValid() then
			for iter_19_2, iter_19_3 in ipairs(iter_19_1.config.buff_attr) do
				assert(iter_19_1.config.percent[iter_19_2] == 1)

				self[iter_19_3] = defaultValue(self[iter_19_3], 1) * (16 + iter_19_1.config.buff_effect[iter_19_2] * iter_19_1:GetFloor()) / 16
			end
		end
	end

	return
end

function WorldConst:AppendPropertiesFromBuffList(arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in ipairs(arg_20_2) do
		assert(iter_20_1.class == WorldBuff)

		if iter_20_1:IsValid() then
			for iter_20_2, iter_20_3 in ipairs(iter_20_1.config.buff_attr) do
				if iter_20_1.config.percent[iter_20_2] == 1 then
					arg_20_1[iter_20_3] = defaultValue(arg_20_1[iter_20_3], 0) + iter_20_1.config.buff_effect[iter_20_2] * iter_20_1:GetFloor()
				else
					self[iter_20_3] = defaultValue(self[iter_20_3], 0) + iter_20_1.config.buff_effect[iter_20_2] * iter_20_1:GetFloor()
				end
			end
		end
	end

	for iter_20_4, iter_20_5 in pairs(arg_20_1) do
		arg_20_1[iter_20_4] = 1 + iter_20_5 / 16
	end

	return
end

WorldConst.TaskTypeSubmitItem = 2
WorldConst.TaskTypeArrivePort = 6
WorldConst.TaskTypeFleetExpansion = 7
WorldConst.TaskTypePressingMap = 12
WorldConst.FleetRedeploy = 1
WorldConst.FleetExpansion = 2
WorldConst.QuadBlinkDuration = 1
WorldConst.QuadSpriteWhite = "cell_white"
WorldConst.TransportDisplayNormal = 0
WorldConst.TransportDisplayGuideEnable = 1
WorldConst.TransportDisplayGuideDanger = 2
WorldConst.TransportDisplayGuideForbid = 3

function WorldConst:CalcRelativeRectPos(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_2.x + arg_21_1.width / 2
	local var_21_1 = arg_21_2.x + arg_21_2.width - arg_21_1.width / 2
	local var_21_2 = arg_21_2.y + arg_21_1.height / 2
	local var_21_3 = arg_21_2.y + arg_21_2.height - arg_21_1.height / 2

	local function var_21_4(arg_22_0)
		return arg_22_0.x >= var_21_0 and arg_22_0.x <= var_21_1 and arg_22_0.y >= var_21_2 and arg_22_0.y <= var_21_3
	end

	local var_21_5 = Quaternion.Euler(0, 0, 10)

	for iter_21_0 = arg_21_3, 0, -50 do
		local var_21_6 = Vector3(iter_21_0, 0, 0)

		for iter_21_1 = 360 / 10, 1, -1 do
			var_21_6 = var_21_5 * var_21_6

			if var_21_4(self + var_21_6) then
				return self + var_21_6
			end
		end
	end

	return _.min({
		Vector2(arg_21_2.x + arg_21_1.width / 2, arg_21_2.y + arg_21_1.height / 2),
		Vector2(arg_21_2.x + arg_21_1.width / 2, arg_21_2.y + arg_21_2.height - arg_21_1.height / 2),
		Vector2(arg_21_2.x + arg_21_2.width - arg_21_1.width / 2, arg_21_2.y + arg_21_2.height - arg_21_1.height / 2),
		Vector2(arg_21_2.x + arg_21_2.width - arg_21_1.width / 2, arg_21_2.y + arg_21_1.height / 2)
	}, function(arg_23_0)
		return Vector2.Distance(arg_23_0, self)
	end)
end

function WorldConst:GetMapIconState()
	if self == 1 then
		return "normal"
	elseif self == 2 then
		return "danger"
	elseif self == 3 then
		return "danger"
	else
		assert(false, "config error:" .. self)
	end

	return
end

function WorldConst:HasDangerConfirm()
	if self == 1 then
		return false
	elseif self == 2 then
		return false
	elseif self == 3 then
		return true
	else
		assert(false, "config error:" .. self)
	end

	return
end

WorldConst.SystemCompass = 1
WorldConst.SystemMemo = 2
WorldConst.SystemInventory = 3
WorldConst.SystemWorldBoss = 4
WorldConst.SystemCollection = 5
WorldConst.SystemSubmarine = 6
WorldConst.SystemFleetDetail = 7
WorldConst.SystemWorldInfo = 8
WorldConst.SystemRedeploy = 9
WorldConst.SystemScanner = 10
WorldConst.SystemResource = 11
WorldConst.SystemOutMap = 12
WorldConst.SystemOrderRedeploy = WorldConst.SystemRedeploy
WorldConst.SystemOrderMaintenance = 13
WorldConst.SystemOrderFOV = 15
WorldConst.SystemOrderSubmarine = WorldConst.SystemSubmarine
WorldConst.SystemResetCountDown = 16
WorldConst.SystemResetExchange = 17
WorldConst.SystemResetShop = 18
WorldConst.SystemAutoFight_1 = 19
WorldConst.SystemAutoFight_2 = 20
WorldConst.SystemAutoSwitch = 21
WorldConst.SystemDailyTask = 22

function WorldConst:BuildHelpTips()
	local var_26_0 = i18n("world_stage_help")

	for iter_26_0, iter_26_1 in ipairs(pg.gameset.world_stage_help.description) do
		if self >= iter_26_1[1] then
			table.insert(var_26_0, 1, {
				icon = {
					path = "",
					atlas = iter_26_1[2]
				}
			})
		end
	end

	return var_26_0
end

WorldConst.AnimRadar = "RadarEffectUI"

function WorldConst:FindStageTemplates()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(pg.world_stage_template.all) do
		if pg.world_stage_template[iter_27_1].stage_key == self then
			table.insert(var_27_0, pg.world_stage_template[iter_27_1])
		end
	end

	return var_27_0
end

function WorldConst.GetRookieBattleLoseStory()
	return pg.gameset.world_story_special_2.description[1]
end

WorldConst.FOVMapSight = 1
WorldConst.FOVEventEffect = 2
WorldConst.GuideEnemyEnd = false

function WorldConst:IsWorldGuideEnemyId()
	if WorldConst.GuideEnemyEnd then
		return false
	end

	return table.contains(pg.gameset.world_guide_enemy_id.description, self)
end

function WorldConst:WorldLevelCorrect(arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(pg.gameset.world_expedition_level.description) do
		for iter_30_2, iter_30_3 in ipairs(iter_30_1[1]) do
			if arg_30_1 == iter_30_3 then
				self = self + iter_30_1[2]
			end
		end
	end

	return math.max(self, 1)
end

function WorldConst:GetAreaFocusPos()
	return Vector2(pg.world_regions_data[self].regions_pos[1], pg.world_regions_data[self].regions_pos[2])
end

function WorldConst.GetTransportBlockEvent()
	if not WorldConst.blockEventDic then
		WorldConst.blockEventDic = {}

		for iter_32_0, iter_32_1 in ipairs(pg.gameset.world_movelimit_event.description) do
			WorldConst.blockEventDic[iter_32_1] = true
		end
	end

	return WorldConst.blockEventDic
end

function WorldConst.GetTransportStoryEvent()
	if not WorldConst.blockStoryDic then
		WorldConst.blockStoryDic = {}

		for iter_33_0, iter_33_1 in ipairs(pg.gameset.world_transfer_eventlist.description) do
			WorldConst.blockStoryDic[iter_33_1] = true
		end
	end

	return WorldConst.blockStoryDic
end

function WorldConst:IsWorldHelpNew(arg_34_1)
	if arg_34_1 then
		PlayerPrefs.SetInt("world_help_progress", self)
		PlayerPrefs.Save()

		return false
	else
		local var_34_0 = PlayerPrefs.HasKey("world_help_progress") and PlayerPrefs.GetInt("world_help_progress") or 0

		if var_34_0 < self then
			for iter_34_0, iter_34_1 in ipairs(pg.world_help_data.all) do
				if self >= pg.world_help_data[iter_34_1].stage then
					if var_34_0 < pg.world_help_data[iter_34_1].stage then
						return true
					else
						for iter_34_2, iter_34_3 in ipairs(pg.world_help_data[iter_34_1].stage_help) do
							if var_34_0 < iter_34_3[1] and self >= iter_34_3[1] then
								return true
							end
						end
					end
				end
			end
		end

		return false
	end

	return
end

function WorldConst:ParsingBuffs()
	local var_35_0 = {}

	_.each(self, function(arg_36_0)
		local var_36_0 = WorldBuff.New()

		var_36_0:Setup({
			id = arg_36_0.id,
			floor = arg_36_0.stack,
			round = arg_36_0.round,
			step = arg_36_0.step
		})

		var_35_0[var_36_0.id] = var_36_0

		return
	end)

	return var_35_0
end

function WorldConst:CompareBuffs(arg_37_1)
	local var_37_0 = _.extend({}, self)
	local var_37_1 = {}
	local var_37_2 = _.extend({}, arg_37_1)

	for iter_37_0, iter_37_1 in pairs(var_37_0) do
		if var_37_2[iter_37_0] then
			var_37_1[iter_37_0] = var_37_0[iter_37_0]
			var_37_0[iter_37_0] = nil
			var_37_2[iter_37_0] = nil
		end
	end

	return {
		remove = var_37_0,
		continue = var_37_1,
		add = var_37_2
	}
end

function WorldConst:FetchWorldShip()
	local var_38_0 = nowWorld():GetShip(self)

	assert(var_38_0, "world ship not exist: " .. self)

	return var_38_0
end

function WorldConst:FetchShipVO()
	local var_39_0 = getProxy(BayProxy):getShipById(self)

	assert(var_39_0, "ship not exist: " .. self)

	return var_39_0
end

function WorldConst:FetchRawShipVO()
	local var_40_0 = getProxy(BayProxy):getRawData()[self]

	assert(var_40_0, "ship not exist: " .. self)

	return var_40_0
end

function WorldConst:ReqWorldCheck()
	local var_41_0 = {}

	if nowWorld().type == World.TypeBase then
		table.insert(var_41_0, function(arg_42_0)
			pg.ConnectionMgr.GetInstance():Send(33000, {
				type = 0
			}, 33001, function(arg_43_0)
				local var_43_0 = getProxy(WorldProxy)

				var_43_0:BuildWorld(World.TypeFull)
				var_43_0:NetFullUpdate(arg_43_0)
				arg_42_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_41_0, self)

	return
end

function WorldConst.ReqWorldForServer()
	pg.ConnectionMgr.GetInstance():Send(33000, {
		type = 1
	}, 33001, function(arg_45_0)
		return
	end)

	return
end

WorldConst.ObstacleConfig = {
	[0] = 2,
	3,
	7,
	0,
	6,
	1,
	4,
	5
}
WorldConst.ObstacleType = {
	"leave",
	"arrive",
	"pass"
}

function WorldConst:GetObstacleKey()
	return bit.lshift(1, #WorldConst.ObstacleType - table.indexof(WorldConst.ObstacleType, self))
end

function WorldConst:GetObstacleConfig(arg_47_1)
	return bit.band(WorldConst.ObstacleConfig[self], (WorldConst.GetObstacleKey(arg_47_1))) > 0
end

function WorldConst:RangeCheck(arg_48_1, arg_48_2)
	for iter_48_0 = self.row - arg_48_1, self.row + arg_48_1 do
		for iter_48_1 = self.column - arg_48_1, self.column + arg_48_1 do
			if WorldConst.InFOVRange(self.row, self.column, iter_48_0, iter_48_1, arg_48_1) then
				arg_48_2(iter_48_0, iter_48_1)
			end
		end
	end

	return
end

function WorldConst:CheckWorldStorySkip()
	local var_49_0 = table.contains(pg.gameset.world_quickmode_skiplua.description, self)

	if var_49_0 then
		var_49_0 = getProxy(SettingsProxy):GetWorldFlag("story_tips")
		var_49_0 = var_49_0 and pg.NewStoryMgr.GetInstance():IsPlayed(self)
	end

	return var_49_0
end

function WorldConst.GetNShopTimeStamp()
	if not WorldConst.nShopTimestamp then
		local var_50_0 = {}

		var_50_0.year, var_50_0.month, var_50_0.day = unpack(getGameset("world_newshop_date")[2])
		var_50_0.hour, var_50_0.min, var_50_0.sec = 0, 0, 0
		WorldConst.nShopTimestamp = pg.TimeMgr.GetInstance():Table2ServerTime({})
	end

	return WorldConst.nShopTimestamp
end

return WorldConst
