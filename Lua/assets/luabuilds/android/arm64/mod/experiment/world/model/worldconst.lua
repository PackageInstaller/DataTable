local var_0_0 = class("WorldConst")

var_0_0.Debug = false

function var_0_0.Print(...)
	if var_0_0.Debug then
		warning(...)
	end

	return
end

function var_0_0.DebugPrintAttachmentCell(arg_2_0, arg_2_1)
	if not var_0_0.Debug then
		return
	end

	warning(arg_2_0)

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		warning(iter_2_0, #iter_2_1.attachmentList)

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.attachmentList) do
			warning(iter_2_3:DebugPrint())
		end
	end

	return
end

var_0_0.DefaultAtlas = 1

function var_0_0.GetProgressAtlas(arg_3_0)
	return var_0_0.DefaultAtlas
end

var_0_0.MaxRow = 30
var_0_0.MaxColumn = 30
var_0_0.LineCross = 2
var_0_0.ActionIdle = "normal"
var_0_0.ActionMove = "move"
var_0_0.ActionDrag = "tuozhuai"
var_0_0.ActionYun = "yun"
var_0_0.ActionVanish = "vanish"
var_0_0.ActionAppear = "appear"
var_0_0.AutoFightLoopCountLimit = 25
var_0_0.EnemySize = {
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
var_0_0.ResourceID = 3002
var_0_0.SwitchPlainingItemId = 120
var_0_0.ReqName = {
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

for iter_0_0, iter_0_1 in pairs(var_0_0.ReqName) do
	var_0_0[iter_0_1] = iter_0_0
end

var_0_0.OpActionFleetMove = -100
var_0_0.OpActionAttachmentMove = -101
var_0_0.OpActionAttachmentAnim = -102
var_0_0.OpActionNextRound = -103
var_0_0.OpActionEventOp = -104
var_0_0.OpActionMoveStep = -105
var_0_0.OpActionUpdate = -106
var_0_0.OpActionFleetAnim = -107
var_0_0.OpActionEventEffect = -108
var_0_0.OpActionTaskGoto = -109
var_0_0.OpActionCameraMove = -110
var_0_0.OpActionTrapGravityAnim = -111
var_0_0.RoundPlayer = 0
var_0_0.RoundElse = 1
var_0_0.DirNone = 0
var_0_0.DirUp = 1
var_0_0.DirRight = 2
var_0_0.DirDown = 3
var_0_0.DirLeft = 4

function var_0_0.DirToLine(arg_4_0)
	if arg_4_0 == var_0_0.DirNone then
		return {
			row = 0,
			column = 0
		}
	elseif arg_4_0 == var_0_0.DirUp then
		return {
			row = -1,
			column = 0
		}
	elseif arg_4_0 == var_0_0.DirRight then
		return {
			row = 0,
			column = 1
		}
	elseif arg_4_0 == var_0_0.DirDown then
		return {
			row = 1,
			column = 0
		}
	elseif arg_4_0 == var_0_0.DirLeft then
		return {
			row = 0,
			column = -1
		}
	else
		assert(false, "without this dir " .. arg_4_0)
	end

	return
end

var_0_0.DefaultMapOffset = Vector3(0, -1000, -1000)

function var_0_0.InFOVRange(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_4 = arg_5_4 or var_0_0.GetFOVRadius()

	return (arg_5_0 - arg_5_2) * (arg_5_0 - arg_5_2) + (arg_5_1 - arg_5_3) * (arg_5_1 - arg_5_3) <= arg_5_4 * arg_5_4
end

function var_0_0.GetFOVRadius()
	return pg.gameset.world_move_initial_view.key_value
end

function var_0_0.IsRookieMap(arg_7_0)
	return _.any(pg.gameset.world_guide_map_list.description, function(arg_8_0)
		return arg_7_0 == arg_8_0
	end)
end

function var_0_0.GetRealmRookieId(arg_9_0)
	assert(arg_9_0 and arg_9_0 > 0)

	return unpack(pg.gameset.world_default_entrance.description[arg_9_0])
end

function var_0_0.ParseConfigDir(arg_10_0, arg_10_1)
	if arg_10_0 == -1 then
		return WorldConst.DirUp
	elseif arg_10_0 == 1 then
		return WorldConst.DirDown
	elseif arg_10_1 == -1 then
		return WorldConst.DirLeft
	elseif arg_10_1 == 1 then
		return WorldConst.DirRight
	end

	assert(false)

	return
end

function var_0_0.Pos2FogRes(arg_11_0, arg_11_1)
	arg_11_0 = arg_11_0 % 3
	arg_11_1 = arg_11_1 % 3

	return "miwu0" .. arg_11_0 * 3 + arg_11_1 + 1
end

var_0_0.TerrainStreamRes = {
	"yangliu_shang",
	"yangliu_you",
	"yangliu_xia",
	"yangliu_zuo"
}
var_0_0.TerrainWindRes = {
	"longjuanfeng_shang",
	"longjuanfeng_you",
	"longjuanfeng_xia",
	"longjuanfeng_zuo"
}
var_0_0.TerrainPoisonRes = {
	"poison01",
	"poison02"
}

function var_0_0.GetTerrainEffectRes(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0 == WorldMapCell.TerrainStream then
		return "world/object/" .. var_0_0.TerrainStreamRes[arg_12_1], var_0_0.TerrainStreamRes[arg_12_1]
	elseif arg_12_0 == WorldMapCell.TerrainWind then
		return "world/object/" .. var_0_0.TerrainWindRes[arg_12_1], var_0_0.TerrainWindRes[arg_12_1]
	elseif arg_12_0 == WorldMapCell.TerrainIce then
		return "world/object/ice", "ice"
	elseif arg_12_0 == WorldMapCell.TerrainPoison then
		return "world/object/" .. var_0_0.TerrainPoisonRes[arg_12_2], var_0_0.TerrainPoisonRes[arg_12_2]
	end

	assert(false)

	return
end

function var_0_0.GetWindEffect()
	return "world/object/longjuanfeng", "longjuanfeng"
end

function var_0_0.GetBuffEffect(arg_14_0)
	return "ui/" .. arg_14_0, arg_14_0
end

var_0_0.PoisonEffect = "san_low"

function var_0_0.ArrayEffectOrder(arg_15_0, arg_15_1)
	table.insertto({}, (arg_15_0:GetComponentsInChildren(typeof(Renderer), true):ToTable()))
	table.insertto({}, (arg_15_0:GetComponentsInChildren(typeof(Canvas), true):ToTable()))

	for iter_15_0, iter_15_1 in ipairs({}) do
		iter_15_1.sortingOrder = iter_15_1.sortingOrder + arg_15_1
	end

	return
end

var_0_0.Flag16Max = 65535
var_0_0.LOEffectA = 1
var_0_0.LOQuad = 1000
var_0_0.LOEffectB = 1001
var_0_0.LOItem = 2000
var_0_0.LOEffectC = 2001
var_0_0.LOCell = 3000
var_0_0.LOFleet = 3001
var_0_0.LOTop = 4000
var_0_0.WindScale = {
	0.5,
	0.5,
	0.75,
	0.75,
	1
}

function var_0_0.GetWindScale(arg_16_0)
	if arg_16_0 then
		local var_16_0 = var_0_0.WindScale[arg_16_0] or 1

		return Vector3(var_16_0, var_16_0, var_16_0)
	end
end

var_0_0.BaseMoveDuration = 0.35

function var_0_0.GetTerrainMoveStepDuration(arg_17_0)
	var_0_0.MoveStepDuration = var_0_0.MoveStepDuration or {
		[WorldMapCell.TerrainNone] = var_0_0.BaseMoveDuration,
		[WorldMapCell.TerrainWind] = var_0_0.BaseMoveDuration / 2,
		[WorldMapCell.TerrainStream] = var_0_0.BaseMoveDuration / 2,
		[WorldMapCell.TerrainIce] = var_0_0.BaseMoveDuration / 2,
		[WorldMapCell.TerrainFog] = var_0_0.BaseMoveDuration,
		[WorldMapCell.TerrainFire] = var_0_0.BaseMoveDuration,
		[WorldMapCell.TerrainPoison] = var_0_0.BaseMoveDuration
	}

	return var_0_0.MoveStepDuration[arg_17_0]
end

var_0_0.UIEaseDuration = 0.5
var_0_0.UIEaseFasterDuration = 0.3
var_0_0.ModelSpine = 1
var_0_0.ModelPrefab = 2
var_0_0.ResBoxPrefab = "boxprefab/"
var_0_0.ResChapterPrefab = "chapter/"
var_0_0.DirType1 = 1
var_0_0.DirType2 = 2
var_0_0.DirType4 = 4

function var_0_0.CalcModelPosition(arg_18_0, arg_18_1)
	return Vector3((arg_18_0.config.area_pos[1] - arg_18_1.x / 2) / PIXEL_PER_UNIT, 0, (arg_18_0.config.area_pos[2] - arg_18_1.y / 2) / PIXEL_PER_UNIT)
end

var_0_0.BrokenBuffId = pg.gameset.world_death_buff.key_value
var_0_0.MoveLimitBuffId = pg.gameset.world_move_buff_desc.key_value
var_0_0.DamageBuffList = pg.gameset.world_buff_morale.description

function var_0_0.ExtendPropertiesRatesFromBuffList(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		assert(iter_19_1.class == WorldBuff)

		if iter_19_1:IsValid() then
			for iter_19_2, iter_19_3 in ipairs(iter_19_1.config.buff_attr) do
				assert(iter_19_1.config.percent[iter_19_2] == 1)

				arg_19_0[iter_19_3] = defaultValue(arg_19_0[iter_19_3], 1) * (16 + iter_19_1.config.buff_effect[iter_19_2] * iter_19_1:GetFloor()) / 16
			end
		end
	end

	return
end

function var_0_0.AppendPropertiesFromBuffList(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in ipairs(arg_20_2) do
		assert(iter_20_1.class == WorldBuff)

		if iter_20_1:IsValid() then
			for iter_20_2, iter_20_3 in ipairs(iter_20_1.config.buff_attr) do
				if iter_20_1.config.percent[iter_20_2] == 1 then
					arg_20_1[iter_20_3] = defaultValue(arg_20_1[iter_20_3], 0) + iter_20_1.config.buff_effect[iter_20_2] * iter_20_1:GetFloor()
				else
					arg_20_0[iter_20_3] = defaultValue(arg_20_0[iter_20_3], 0) + iter_20_1.config.buff_effect[iter_20_2] * iter_20_1:GetFloor()
				end
			end
		end
	end

	for iter_20_4, iter_20_5 in pairs(arg_20_1) do
		arg_20_1[iter_20_4] = 1 + iter_20_5 / 16
	end

	return
end

var_0_0.TaskTypeSubmitItem = 2
var_0_0.TaskTypeArrivePort = 6
var_0_0.TaskTypeFleetExpansion = 7
var_0_0.TaskTypePressingMap = 12
var_0_0.FleetRedeploy = 1
var_0_0.FleetExpansion = 2
var_0_0.QuadBlinkDuration = 1
var_0_0.QuadSpriteWhite = "cell_white"
var_0_0.TransportDisplayNormal = 0
var_0_0.TransportDisplayGuideEnable = 1
var_0_0.TransportDisplayGuideDanger = 2
var_0_0.TransportDisplayGuideForbid = 3

function var_0_0.CalcRelativeRectPos(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_2.x + arg_21_1.width / 2
	local var_21_1 = arg_21_2.x + arg_21_2.width - arg_21_1.width / 2
	local var_21_2 = arg_21_2.y + arg_21_1.height / 2
	local var_21_3 = arg_21_2.y + arg_21_2.height - arg_21_1.height / 2
	local var_21_4 = Quaternion.Euler(0, 0, 10)

	for iter_21_0 = arg_21_3, 0, -50 do
		local var_21_5 = Vector3(iter_21_0, 0, 0)

		for iter_21_1 = 360 / 10, 1, -1 do
			var_21_5 = var_21_4 * var_21_5

			if (function(arg_22_0)
				return arg_22_0.x >= var_21_0 and arg_22_0.x <= var_21_1 and arg_22_0.y >= var_21_2 and arg_22_0.y <= var_21_3
			end)(arg_21_0 + var_21_5) then
				return arg_21_0 + var_21_5
			end
		end
	end

	return _.min({
		Vector2(arg_21_2.x + arg_21_1.width / 2, arg_21_2.y + arg_21_1.height / 2),
		Vector2(arg_21_2.x + arg_21_1.width / 2, arg_21_2.y + arg_21_2.height - arg_21_1.height / 2),
		Vector2(arg_21_2.x + arg_21_2.width - arg_21_1.width / 2, arg_21_2.y + arg_21_2.height - arg_21_1.height / 2),
		Vector2(arg_21_2.x + arg_21_2.width - arg_21_1.width / 2, arg_21_2.y + arg_21_1.height / 2)
	}, function(arg_23_0)
		return Vector2.Distance(arg_23_0, arg_21_0)
	end)
end

function var_0_0.GetMapIconState(arg_24_0)
	if arg_24_0 == 1 then
		return "normal"
	elseif arg_24_0 == 2 then
		return "danger"
	elseif arg_24_0 == 3 then
		return "danger"
	else
		assert(false, "config error:" .. arg_24_0)
	end

	return
end

function var_0_0.HasDangerConfirm(arg_25_0)
	if arg_25_0 == 1 then
		return false
	elseif arg_25_0 == 2 then
		return false
	elseif arg_25_0 == 3 then
		return true
	else
		assert(false, "config error:" .. arg_25_0)
	end

	return
end

var_0_0.SystemCompass = 1
var_0_0.SystemMemo = 2
var_0_0.SystemInventory = 3
var_0_0.SystemWorldBoss = 4
var_0_0.SystemCollection = 5
var_0_0.SystemSubmarine = 6
var_0_0.SystemFleetDetail = 7
var_0_0.SystemWorldInfo = 8
var_0_0.SystemRedeploy = 9
var_0_0.SystemScanner = 10
var_0_0.SystemResource = 11
var_0_0.SystemOutMap = 12
var_0_0.SystemOrderRedeploy = var_0_0.SystemRedeploy
var_0_0.SystemOrderMaintenance = 13
var_0_0.SystemOrderFOV = 15
var_0_0.SystemOrderSubmarine = var_0_0.SystemSubmarine
var_0_0.SystemResetCountDown = 16
var_0_0.SystemResetExchange = 17
var_0_0.SystemResetShop = 18
var_0_0.SystemAutoFight_1 = 19
var_0_0.SystemAutoFight_2 = 20
var_0_0.SystemAutoSwitch = 21
var_0_0.SystemDailyTask = 22

function var_0_0.BuildHelpTips(arg_26_0)
	local var_26_0 = i18n("world_stage_help")

	for iter_26_0, iter_26_1 in ipairs(pg.gameset.world_stage_help.description) do
		local var_26_1

		if arg_26_0 >= iter_26_1[1] then
			table.insert(var_26_0, 1, {
				icon = {
					path = "",
					atlas = iter_26_1[2]
				}
			})

			var_26_1 = 1 + 1
		end
	end

	return var_26_0
end

var_0_0.AnimRadar = "RadarEffectUI"

function var_0_0.FindStageTemplates(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(pg.world_stage_template.all) do
		if pg.world_stage_template[iter_27_1].stage_key == arg_27_0 then
			table.insert({}, pg.world_stage_template[iter_27_1])
		end
	end

	return {}
end

function var_0_0.GetRookieBattleLoseStory()
	return pg.gameset.world_story_special_2.description[1]
end

var_0_0.FOVMapSight = 1
var_0_0.FOVEventEffect = 2
var_0_0.GuideEnemyEnd = false

function var_0_0.IsWorldGuideEnemyId(arg_29_0)
	if var_0_0.GuideEnemyEnd then
		return false
	end

	return table.contains(pg.gameset.world_guide_enemy_id.description, arg_29_0)
end

function var_0_0.WorldLevelCorrect(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(pg.gameset.world_expedition_level.description) do
		for iter_30_2, iter_30_3 in ipairs(iter_30_1[1]) do
			if arg_30_1 == iter_30_3 then
				arg_30_0 = arg_30_0 + iter_30_1[2]
			end
		end
	end

	return math.max(arg_30_0, 1)
end

function var_0_0.GetAreaFocusPos(arg_31_0)
	return Vector2(pg.world_regions_data[arg_31_0].regions_pos[1], pg.world_regions_data[arg_31_0].regions_pos[2])
end

function var_0_0.GetTransportBlockEvent()
	if not var_0_0.blockEventDic then
		var_0_0.blockEventDic = {}

		for iter_32_0, iter_32_1 in ipairs(pg.gameset.world_movelimit_event.description) do
			var_0_0.blockEventDic[iter_32_1] = true
		end
	end

	return var_0_0.blockEventDic
end

function var_0_0.GetTransportStoryEvent()
	if not var_0_0.blockStoryDic then
		var_0_0.blockStoryDic = {}

		for iter_33_0, iter_33_1 in ipairs(pg.gameset.world_transfer_eventlist.description) do
			var_0_0.blockStoryDic[iter_33_1] = true
		end
	end

	return var_0_0.blockStoryDic
end

function var_0_0.IsWorldHelpNew(arg_34_0, arg_34_1)
	if arg_34_1 then
		PlayerPrefs.SetInt("world_help_progress", arg_34_0)
		PlayerPrefs.Save()

		return false
	else
		local var_34_0 = PlayerPrefs.HasKey("world_help_progress") and PlayerPrefs.GetInt("world_help_progress") or 0

		if var_34_0 < arg_34_0 then
			for iter_34_0, iter_34_1 in ipairs(pg.world_help_data.all) do
				if arg_34_0 >= pg.world_help_data[iter_34_1].stage then
					if var_34_0 < pg.world_help_data[iter_34_1].stage then
						return true
					else
						for iter_34_2, iter_34_3 in ipairs(pg.world_help_data[iter_34_1].stage_help) do
							if var_34_0 < iter_34_3[1] and arg_34_0 >= iter_34_3[1] then
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

function var_0_0.ParsingBuffs(arg_35_0)
	local var_35_0 = {}

	_.each(arg_35_0, function(arg_36_0)
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

	return {}
end

function var_0_0.CompareBuffs(arg_37_0, arg_37_1)
	local var_37_0 = _.extend({}, arg_37_0)
	local var_37_1 = _.extend({}, arg_37_1)

	for iter_37_0, iter_37_1 in pairs(var_37_0) do
		if var_37_1[iter_37_0] then
			({})[iter_37_0] = var_37_0[iter_37_0]
			var_37_0[iter_37_0] = nil
			var_37_1[iter_37_0] = nil
		end
	end

	return {
		remove = var_37_0,
		continue = {},
		add = var_37_1
	}
end

function var_0_0.FetchWorldShip(arg_38_0)
	local var_38_0 = nowWorld():GetShip(arg_38_0)

	assert(var_38_0, "world ship not exist: " .. arg_38_0)

	return var_38_0
end

function var_0_0.FetchShipVO(arg_39_0)
	local var_39_0 = getProxy(BayProxy):getShipById(arg_39_0)

	assert(var_39_0, "ship not exist: " .. arg_39_0)

	return var_39_0
end

function var_0_0.FetchRawShipVO(arg_40_0)
	local var_40_0 = getProxy(BayProxy):getRawData()[arg_40_0]

	assert(var_40_0, "ship not exist: " .. arg_40_0)

	return var_40_0
end

function var_0_0.ReqWorldCheck(arg_41_0)
	if nowWorld().type == World.TypeBase then
		table.insert({}, function(arg_42_0)
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

	seriesAsync({}, arg_41_0)

	return
end

function var_0_0.ReqWorldForServer()
	pg.ConnectionMgr.GetInstance():Send(33000, {
		type = 1
	}, 33001, function(arg_45_0)
		return
	end)

	return
end

var_0_0.ObstacleConfig = {
	[0] = 2,
	3,
	7,
	0,
	6,
	1,
	4,
	5
}
var_0_0.ObstacleType = {
	"leave",
	"arrive",
	"pass"
}

function var_0_0.GetObstacleKey(arg_46_0)
	return bit.lshift(1, #var_0_0.ObstacleType - table.indexof(var_0_0.ObstacleType, arg_46_0))
end

function var_0_0.GetObstacleConfig(arg_47_0, arg_47_1)
	return bit.band(var_0_0.ObstacleConfig[arg_47_0], (var_0_0.GetObstacleKey(arg_47_1))) > 0
end

function var_0_0.RangeCheck(arg_48_0, arg_48_1, arg_48_2)
	for iter_48_0 = arg_48_0.row - arg_48_1, arg_48_0.row + arg_48_1 do
		for iter_48_1 = arg_48_0.column - arg_48_1, arg_48_0.column + arg_48_1 do
			if var_0_0.InFOVRange(arg_48_0.row, arg_48_0.column, iter_48_0, iter_48_1, arg_48_1) then
				arg_48_2(iter_48_0, iter_48_1)
			end
		end
	end

	return
end

function var_0_0.CheckWorldStorySkip(arg_49_0)
	local var_49_0 = table.contains(pg.gameset.world_quickmode_skiplua.description, arg_49_0)

	if var_49_0 then
		var_49_0 = getProxy(SettingsProxy):GetWorldFlag("story_tips")
		var_49_0 = var_49_0 and pg.NewStoryMgr.GetInstance():IsPlayed(arg_49_0)
	end

	return var_49_0
end

function var_0_0.GetNShopTimeStamp()
	if not var_0_0.nShopTimestamp then
		local var_50_0 = {}

		var_50_0.year, var_50_0.month, var_50_0.day = unpack(getGameset("world_newshop_date")[2])
		var_50_0.hour, var_50_0.min, var_50_0.sec = 0, 0, 0
		var_0_0.nShopTimestamp = pg.TimeMgr.GetInstance():Table2ServerTime({})
	end

	return var_0_0.nShopTimestamp
end

return var_0_0
