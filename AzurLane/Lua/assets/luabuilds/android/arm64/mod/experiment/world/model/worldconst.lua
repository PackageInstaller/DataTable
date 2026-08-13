class = var_0_10000

local var_0_0 = var_0_10000("WorldConst")

var_0_0.Debug = false

function var_0_0.Print(...)
	if var_0_0.Debug then
		warning = var_0

		var_0(...)
	end

	return
end

function var_0_0.DebugPrintAttachmentCell(arg_2_0, arg_2_1)
	if not var_0_0.Debug then
		return
	end

	warning = var_2

	var_2(arg_2_0)

	pairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1) do
		warning = var_1_10007

		var_1_10007(iter_2_0, #iter_2_1.attachmentList)

		ipairs = var_1_10007

		for iter_2_2, iter_2_3 in var_1_10007(iter_2_1.attachmentList) do
			warning = var_1_10012

			var_1_10012(iter_2_3:DebugPrint())
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
pairs = var_1

for iter_0_0, iter_0_1 in var_1(var_0_0.ReqName) do
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
		assert = var_1

		var_1(false, "without this dir " .. arg_4_0)
	end

	return
end

Vector3 = var_1
var_0_0.DefaultMapOffset = var_1(0, -1000, -1000)

function var_0_0.InFOVRange(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_4 = arg_5_4 or var_0_0.GetFOVRadius()

	return (arg_5_0 - arg_5_2) * (arg_5_0 - arg_5_2) + (arg_5_1 - arg_5_3) * (arg_5_1 - arg_5_3) <= arg_5_4 * arg_5_4
end

function var_0_0.GetFOVRadius()
	pg = var_1_10000

	return var_1_10000.gameset.world_move_initial_view.key_value
end

function var_0_0.IsRookieMap(arg_7_0)
	_ = var_1_10001

	local var_7_0 = var_1_10001.any

	pg = var_1_10003

	return var_7_0(var_1_10003.gameset.world_guide_map_list.description, function(arg_8_0)
		return arg_7_0 == arg_8_0
	end)
end

function var_0_0.GetRealmRookieId(arg_9_0)
	assert = var_1_10001

	var_1_10001(arg_9_0 and arg_9_0 > 0)

	unpack = var_1_10001
	pg = var_3

	return var_1_10001(var_3.gameset.world_default_entrance.description[arg_9_0])
end

function var_0_0.ParseConfigDir(arg_10_0, arg_10_1)
	if arg_10_0 == -1 then
		WorldConst = var_1_10002

		return var_1_10002.DirUp
	elseif arg_10_0 == 1 then
		WorldConst = var_1_10002

		return var_1_10002.DirDown
	elseif arg_10_1 == -1 then
		WorldConst = var_1_10002

		return var_1_10002.DirLeft
	elseif arg_10_1 == 1 then
		WorldConst = var_1_10002

		return var_1_10002.DirRight
	end

	assert = var_1_10002

	var_1_10002(false)

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
	WorldMapCell = var_1_10003

	local var_12_0

	if arg_12_0 == var_1_10003.TerrainStream then
		var_12_0 = var_0_0.TerrainStreamRes[arg_12_1]

		return "world/object/" .. var_12_0, var_12_0
	else
		WorldMapCell = var_12_0

		if arg_12_0 == var_12_0.TerrainWind then
			var_12_0 = var_0_0.TerrainWindRes[arg_12_1]

			return "world/object/" .. var_12_0, var_12_0
		else
			WorldMapCell = var_12_0

			if arg_12_0 == var_12_0.TerrainIce then
				return "world/object/ice", "ice"
			else
				WorldMapCell = var_12_0

				if arg_12_0 == var_12_0.TerrainPoison then
					var_12_0 = var_0_0.TerrainPoisonRes[arg_12_2]

					return "world/object/" .. var_12_0, var_12_0
				end
			end
		end
	end

	assert = var_12_0

	var_12_0(false)

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
	local var_15_0 = {}
	local var_15_1 = arg_15_0
	local var_15_2 = arg_15_0.GetComponentsInChildren

	typeof = var_1_10006
	Renderer = var_1_10008

	local var_15_3 = var_15_2(var_15_1, var_1_10006(var_1_10008), true)
	local var_15_4 = var_3.ToTable(var_15_3)

	table = var_1_10004

	var_1_10004.insertto(var_15_0, var_15_4)

	local var_15_5 = arg_15_0
	local var_15_6 = arg_15_0.GetComponentsInChildren

	typeof = var_7
	Canvas = var_1_10009

	local var_15_7 = var_15_6(var_15_5, var_7(var_1_10009), true)
	local var_15_8 = var_4.ToTable(var_15_7)

	table = var_15_3

	var_15_3.insertto(var_15_0, var_15_8)

	ipairs = var_5

	for iter_15_0, iter_15_1 in var_5(var_15_0) do
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
	local var_16_0

	if not arg_16_0 or not var_0_0.WindScale[arg_16_0] then
		var_16_0 = 1
	end

	Vector3 = var_1_10002

	return var_1_10002(var_16_0, var_16_0, var_16_0)
end

var_0_0.BaseMoveDuration = 0.35

function var_0_0.GetTerrainMoveStepDuration(arg_17_0)
	local var_17_0 = var_0_0
	local var_17_1

	if not var_0_0.MoveStepDuration then
		var_17_1 = {}
		WorldMapCell = var_1_10003
		var_17_1[var_1_10003.TerrainNone] = var_0_0.BaseMoveDuration
		WorldMapCell = var_3
		var_17_1[var_3.TerrainWind] = var_0_0.BaseMoveDuration / 2
		WorldMapCell = var_3
		var_17_1[var_3.TerrainStream] = var_0_0.BaseMoveDuration / 2
		WorldMapCell = var_3
		var_17_1[var_3.TerrainIce] = var_0_0.BaseMoveDuration / 2
		WorldMapCell = var_3
		var_17_1[var_3.TerrainFog] = var_0_0.BaseMoveDuration
		WorldMapCell = var_3
		var_17_1[var_3.TerrainFire] = var_0_0.BaseMoveDuration
		WorldMapCell = var_3
		var_17_1[var_3.TerrainPoison] = var_0_0.BaseMoveDuration
	end

	var_17_0.MoveStepDuration = var_17_1

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
	Vector3 = var_1_10002

	local var_18_0 = arg_18_0.config.area_pos[1] - arg_18_1.x / 2

	PIXEL_PER_UNIT = var_5

	local var_18_1 = var_18_0 / var_5
	local var_18_2 = 0
	local var_18_3 = arg_18_0.config.area_pos[2] - arg_18_1.y / 2

	PIXEL_PER_UNIT = var_7

	return var_1_10002(var_18_1, var_18_2, var_18_3 / var_7)
end

pg = var_1
var_0_0.BrokenBuffId = var_1.gameset.world_death_buff.key_value
pg = var_1
var_0_0.MoveLimitBuffId = var_1.gameset.world_move_buff_desc.key_value
pg = var_1
var_0_0.DamageBuffList = var_1.gameset.world_buff_morale.description

function var_0_0.ExtendPropertiesRatesFromBuffList(arg_19_0, arg_19_1)
	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_1) do
		assert = var_1_10007

		local var_19_0 = iter_19_1.class

		WorldBuff = iter_19_2

		var_1_10007(var_19_0 == iter_19_2)

		if iter_19_1:IsValid() then
			ipairs = var_1_10007

			for iter_19_2, iter_19_3 in var_1_10007(iter_19_1.config.buff_attr) do
				assert = var_1_10012

				var_1_10012(iter_19_1.config.percent[iter_19_2] == 1)

				defaultValue = var_1_10012
				arg_19_0[iter_19_3] = var_1_10012(arg_19_0[iter_19_3], 1) * (16 + iter_19_1.config.buff_effect[iter_19_2] * iter_19_1:GetFloor()) / 16
			end
		end
	end

	return
end

function var_0_0.AppendPropertiesFromBuffList(arg_20_0, arg_20_1, arg_20_2)
	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_2) do
		assert = var_1_10008

		local var_20_0 = iter_20_1.class

		WorldBuff = iter_20_2

		var_1_10008(var_20_0 == iter_20_2)

		if iter_20_1:IsValid() then
			ipairs = var_1_10008

			for iter_20_2, iter_20_3 in var_1_10008(iter_20_1.config.buff_attr) do
				if iter_20_1.config.percent[iter_20_2] == 1 then
					defaultValue = var_13
					arg_20_1[iter_20_3] = var_13(arg_20_1[iter_20_3], 0) + iter_20_1.config.buff_effect[iter_20_2] * iter_20_1:GetFloor()
				else
					defaultValue = var_13
					arg_20_0[iter_20_3] = var_13(arg_20_0[iter_20_3], 0) + iter_20_1.config.buff_effect[iter_20_2] * iter_20_1:GetFloor()
				end
			end
		end
	end

	pairs = var_3

	for iter_20_4, iter_20_5 in var_3(arg_20_1) do
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

	local function var_21_4(arg_22_0)
		return arg_22_0.x >= var_21_0 and arg_22_0.x <= var_21_1 and arg_22_0.y >= var_21_2 and arg_22_0.y <= var_21_3
	end

	local var_21_5 = 10

	Quaternion = var_1_10010

	local var_21_6 = var_1_10010.Euler(0, 0, var_21_5)

	for iter_21_0 = arg_21_3, 0, -50 do
		Vector3 = var_1_10015
		var_1_10015 = var_1_10015(iter_21_0, 0, 0)

		for iter_21_1 = 360 / var_21_5, 1, -1 do
			var_1_10015 = var_21_6 * var_1_10015

			if var_21_4(arg_21_0 + var_1_10015) then
				return arg_21_0 + var_1_10015
			end
		end
	end

	_ = var_11

	local var_21_7 = var_11.min
	local var_21_8 = {}

	Vector2 = iter_21_0
	var_21_8[1] = iter_21_0(var_21_0, var_21_2)
	Vector2 = var_14
	var_21_8[2] = var_14(var_21_0, var_21_3)
	Vector2 = var_14
	var_21_8[3] = var_14(var_21_1, var_21_3)
	Vector2 = var_14
	var_21_8[4] = var_14(var_21_1, var_21_2)

	return var_21_7(var_21_8, function(arg_23_0)
		Vector2 = var_2_10001

		return var_2_10001.Distance(arg_23_0, arg_21_0)
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
		assert = var_1_10001

		var_1_10001(false, "config error:" .. arg_24_0)
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
		assert = var_1_10001

		var_1_10001(false, "config error:" .. arg_25_0)
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
	i18n = var_1_10001

	local var_26_0 = var_1_10001("world_stage_help")

	pg = var_1_10002

	local var_26_1 = var_1_10002.gameset.world_stage_help.description
	local var_26_2 = 1

	ipairs = var_1_10004

	for iter_26_0, iter_26_1 in var_1_10004(var_26_1) do
		if iter_26_1[1] <= arg_26_0 then
			table = var_9

			var_9.insert(var_26_0, var_26_2, {
				icon = {
					path = "",
					atlas = iter_26_1[2]
				}
			})

			var_26_2 = var_26_2 + 1
		end
	end

	return var_26_0
end

var_0_0.AnimRadar = "RadarEffectUI"

function var_0_0.FindStageTemplates(arg_27_0)
	local var_27_0 = {}

	ipairs = var_1_10002
	pg = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10002(var_1_10004.world_stage_template.all) do
		pg = var_1_10007

		if var_1_10007.world_stage_template[iter_27_1].stage_key == arg_27_0 then
			table = var_8

			var_8.insert(var_27_0, var_1_10007)
		end
	end

	return var_27_0
end

function var_0_0.GetRookieBattleLoseStory()
	pg = var_1_10000

	return var_1_10000.gameset.world_story_special_2.description[1]
end

var_0_0.FOVMapSight = 1
var_0_0.FOVEventEffect = 2
var_0_0.GuideEnemyEnd = false

function var_0_0.IsWorldGuideEnemyId(arg_29_0)
	if var_0_0.GuideEnemyEnd then
		return false
	end

	pg = var_1

	local var_29_0 = var_1.gameset.world_guide_enemy_id.description

	table = var_1_10002

	return var_1_10002.contains(var_29_0, arg_29_0)
end

function var_0_0.WorldLevelCorrect(arg_30_0, arg_30_1)
	ipairs = var_1_10002
	pg = var_1_10004

	for iter_30_0, iter_30_1 in var_1_10002(var_1_10004.gameset.world_expedition_level.description) do
		ipairs = var_1_10007

		for iter_30_2, iter_30_3 in var_1_10007(iter_30_1[1]) do
			if arg_30_1 == iter_30_3 then
				arg_30_0 = arg_30_0 + iter_30_1[2]
			end
		end
	end

	math = var_2

	return var_2.max(arg_30_0, 1)
end

function var_0_0.GetAreaFocusPos(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.world_regions_data[arg_31_0].regions_pos

	Vector2 = var_1_10002

	return var_1_10002(var_31_0[1], var_31_0[2])
end

function var_0_0.GetTransportBlockEvent()
	if not var_0_0.blockEventDic then
		local var_32_0 = var_0_0

		var_32_0.blockEventDic = {}
		ipairs = var_32_0
		pg = var_1_10002

		for iter_32_0, iter_32_1 in var_32_0(var_1_10002.gameset.world_movelimit_event.description) do
			var_0_0.blockEventDic[iter_32_1] = true
		end
	end

	return var_0_0.blockEventDic
end

function var_0_0.GetTransportStoryEvent()
	if not var_0_0.blockStoryDic then
		local var_33_0 = var_0_0

		var_33_0.blockStoryDic = {}
		ipairs = var_33_0
		pg = var_1_10002

		for iter_33_0, iter_33_1 in var_33_0(var_1_10002.gameset.world_transfer_eventlist.description) do
			var_0_0.blockStoryDic[iter_33_1] = true
		end
	end

	return var_0_0.blockStoryDic
end

function var_0_0.IsWorldHelpNew(arg_34_0, arg_34_1)
	if arg_34_1 then
		PlayerPrefs = var_1_10002

		var_1_10002.SetInt("world_help_progress", arg_34_0)

		PlayerPrefs = var_1_10002

		var_1_10002.Save()

		do return false end

		goto label_34_0
	end

	PlayerPrefs = var_1_10002

	if var_1_10002.HasKey("world_help_progress") then
		PlayerPrefs = var_2

		do
			local var_34_0

			if not var_2.GetInt("world_help_progress") then
				var_34_0 = 0
			end

			if var_34_0 < arg_34_0 then
				ipairs = var_1_10003
				pg = var_1_10005

				for iter_34_0, iter_34_1 in var_1_10003(var_1_10005.world_help_data.all) do
					pg = var_1_10008

					if arg_34_0 >= var_1_10008.world_help_data[iter_34_1].stage then
						if var_34_0 < var_1_10008.stage then
							return true
						else
							ipairs = var_9

							for iter_34_2, iter_34_3 in var_9(var_1_10008.stage_help) do
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

		::label_34_0::

		return
	end
end

function var_0_0.ParsingBuffs(arg_35_0)
	local var_35_0 = {}

	_ = var_1_10002

	var_1_10002.each(arg_35_0, function(arg_36_0)
		WorldBuff = var_2_10001

		local var_36_0 = var_2_10001.New()

		var_1.Setup(var_36_0, {
			id = arg_36_0.id,
			floor = arg_36_0.stack,
			round = arg_36_0.round,
			step = arg_36_0.step
		})

		var_35_0[var_1.id] = var_1

		return
	end)

	return var_35_0
end

function var_0_0.CompareBuffs(arg_37_0, arg_37_1)
	_ = var_1_10002

	local var_37_0 = var_1_10002.extend({}, arg_37_0)
	local var_37_1 = {}

	_ = var_4

	local var_37_2 = var_4.extend({}, arg_37_1)

	pairs = var_5

	for iter_37_0, iter_37_1 in var_5(var_37_0) do
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

function var_0_0.FetchWorldShip(arg_38_0)
	nowWorld = var_1_10001

	local var_38_0 = var_1_10001()
	local var_38_1 = var_1.GetShip(var_38_0, arg_38_0)

	assert = var_1_10002

	var_1_10002(var_38_1, "world ship not exist: " .. arg_38_0)

	return var_38_1
end

function var_0_0.FetchShipVO(arg_39_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_39_0 = var_1_10001(var_1_10003)
	local var_39_1 = var_1.getShipById(var_39_0, arg_39_0)

	assert = var_1_10003

	var_1_10003(var_39_1, "ship not exist: " .. arg_39_0)

	return var_39_1
end

function var_0_0.FetchRawShipVO(arg_40_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_40_0 = var_1_10001(var_1_10003)
	local var_40_1 = var_1.getRawData(var_40_0)[arg_40_0]

	assert = var_1_10003

	var_1_10003(var_40_1, "ship not exist: " .. arg_40_0)

	return var_40_1
end

function var_0_0.ReqWorldCheck(arg_41_0)
	local var_41_0 = {}

	nowWorld = var_1_10002

	local var_41_1 = var_1_10002().type

	World = var_1_10003

	if var_41_1 == var_1_10003.TypeBase then
		table = var_41_1

		var_41_1.insert(var_41_0, function(arg_42_0)
			pg = var_2_10001

			local var_42_0 = var_2_10001.ConnectionMgr.GetInstance()

			var_1.Send(var_42_0, 33000, {
				type = 0
			}, 33001, function(arg_43_0)
				getProxy = var_3_10001
				WorldProxy = var_3_10003

				local var_43_0 = var_3_10001(var_3_10003)
				local var_43_1 = var_1.BuildWorld

				World = var_3_10005

				var_43_1(var_43_0, var_3_10005.TypeFull)
				var_1:NetFullUpdate(arg_43_0)
				arg_42_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_41_1

	var_41_1(var_41_0, arg_41_0)

	return
end

function var_0_0.ReqWorldForServer()
	pg = var_1_10000

	local var_44_0 = var_1_10000.ConnectionMgr.GetInstance()

	var_0.Send(var_44_0, 33000, {
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
	bit = var_1_10001

	local var_46_0 = var_1_10001.lshift
	local var_46_1 = 1
	local var_46_2 = #var_0_0.ObstacleType

	table = var_1_10005

	return var_46_0(var_46_1, var_46_2 - var_1_10005.indexof(var_0_0.ObstacleType, arg_46_0))
end

function var_0_0.GetObstacleConfig(arg_47_0, arg_47_1)
	local var_47_0 = var_0_0.GetObstacleKey(arg_47_1)

	bit = var_1_10003

	return var_1_10003.band(var_0_0.ObstacleConfig[arg_47_0], var_47_0) > 0
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
	table = var_1_10001

	local var_49_0 = var_1_10001.contains

	pg = var_1_10003

	local var_49_3

	if var_49_0(var_1_10003.gameset.world_quickmode_skiplua.description, arg_49_0) then
		getProxy = var_49_3
		SettingsProxy = var_3

		local var_49_1 = var_49_3(var_3)

		if var_49_3.GetWorldFlag(var_49_1, "story_tips") then
			pg = var_49_3

			local var_49_2 = var_49_3.NewStoryMgr.GetInstance()

			var_49_3 = var_49_3.IsPlayed(var_49_2, arg_49_0)
		end
	end

	return var_49_3
end

function var_0_0.GetNShopTimeStamp()
	if not var_0_0.nShopTimestamp then
		local var_50_0 = {}

		unpack = var_1_10001
		getGameset = var_1_10003
		var_50_0.year, var_50_0.month, var_50_0.day = var_1_10001(var_1_10003("world_newshop_date")[2])

		local var_50_1 = 0
		local var_50_2 = 0

		var_50_0.sec = 0
		var_50_0.min = var_50_2
		var_50_0.hour = var_50_1

		local var_50_3 = var_0_0

		pg = var_50_2

		local var_50_4 = var_50_2.TimeMgr.GetInstance()

		var_50_3.nShopTimestamp = var_2.Table2ServerTime(var_50_4, var_50_0)
	end

	return var_0_0.nShopTimestamp
end

return var_0_0
