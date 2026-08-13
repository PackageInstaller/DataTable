local var_0_0 = 18
local var_0_1 = XANA

local function var_0_2()
	PlayerPrefs = var_1_10000

	local var_1_0

	if not var_1_10000.GetInt("stage_scratch") then
		var_1_0 = 0
	end

	local var_1_1 = 1 - var_1_0

	PlayerPrefs = var_1_10001

	var_1_10001.SetInt("stage_scratch", var_1_1)

	PlayerPrefs = var_1

	var_1.Save()

	pg = var_1

	local var_1_2 = var_1.TipsMgr.GetInstance()

	var_1.ShowTips(var_1_2, var_1_1 == 1 and "已开启战斗跳略" or "已关闭战斗跳略")

	return
end

local function var_0_3(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:GetIFF()
	local var_2_1 = 0
	local var_2_2 = {
		isMiss = false,
		isCri = false,
		isDamagePrevent = false
	}

	ys = var_1_10006

	if var_2_0 == var_1_10006.Battle.BattleConfig.FRIENDLY_CODE then
		math = var_6
		var_2_1 = var_6.min(var_2_1, 1)
	else
		ys = var_6

		if var_2_0 == var_6.Battle.BattleConfig.FOE_CODE then
			math = var_6
			var_2_1 = var_6.max(var_2_1, 9999999)
			var_2_2.isCri = true
		end
	end

	return var_2_1, var_2_2
end

local var_0_4 = GodenFnger

local function var_0_5(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.SdkMgr.GetInstance()

	if var_1.CheckPretest(var_3_0) then
		local var_3_1

		IsUnityEditor = var_1_10002

		if var_1_10002 then
			PathMgr = var_1_10002
			var_3_1 = var_1_10002.getAssetBundle("../localization.txt")
		else
			Application = var_1_10002
			var_3_1 = var_1_10002.persistentDataPath .. "/localization.txt"
		end

		if arg_3_0 == "true" then
			System = var_1_10002

			var_1_10002.IO.File.WriteAllText(var_3_1, "Localization = true\nLocalization_skin = true")
		end

		if arg_3_0 == "false" then
			System = var_1_10002

			var_1_10002.IO.File.WriteAllText(var_3_1, "Localization = false\nLocalization_skin = false")
		end
	end

	return
end

SendCmdCommand = var_0_10002

function var_0_10002.execute(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getBody(var_4_0)

	assert = var_1_10003

	var_1_10003(var_4_1.cmd, "cmd should exist")

	local var_4_4

	if var_4_1.cmd == "local" then
		local var_4_2

		if var_4_1.arg1 == "debug" then
			DebugMgr = var_3
			var_4_2 = var_3.Inst

			var_3.Active(var_4_2)
		else
			if var_4_1.arg1 == "story" then
				pg = var_3
				var_4_2 = var_3.SdkMgr.GetInstance()

				if var_3.CheckPretest(var_4_2) then
					local var_4_3 = var_4_1.arg2

					tonumber = var_4_0

					if var_4_0(var_4_3) then
						pg = var_4_0
						var_4_4 = var_4_0.NewStoryMgr.GetInstance()
						var_4_0 = var_4_0.StoryId2StoryName
						tonumber = iter_4_0
						var_4_3 = var_4_0(var_4_4, iter_4_0(var_4_1.arg2))
					end

					if var_4_3 then
						pg = var_4_0
						var_4_4 = var_4_0.NewStoryMgr.GetInstance()

						var_4_0.Play(var_4_4, var_4_3, function()
							return
						end, true)
					else
						pg = var_4_0
						var_4_4 = var_4_0.TipsMgr.GetInstance()

						var_4_0.ShowTips(var_4_4, "不存在剧情")
					end

					goto label_4_0
				end
			end

			if var_4_1.arg1 == "sdkexit" then
				SDKLogouted = var_3

				var_3(99)
			elseif var_4_1.arg1 == "notification" then
				pg = var_3
				var_4_2 = var_3.TimeMgr.GetInstance()

				local var_4_5 = var_3.GetServerTime(var_4_2) + 60
			elseif var_4_1.arg1 == "time" then
				print = var_3
				var_4_2 = "server time: "
				pg = var_4_4
				iter_4_1 = var_4_4.TimeMgr.GetInstance()

				var_3(var_4_2 .. var_4_4.GetServerTime(iter_4_1))
			elseif var_4_1.arg1 == "act" then
				getProxy = var_3
				ActivityProxy = var_4_2
				var_4_2 = var_3(var_4_2)

				local var_4_6 = var_3.getRawData(var_4_2)

				pairs = var_4_0

				for iter_4_0, iter_4_1 in var_4_0(var_4_6) do
					print = var_1_10009

					var_1_10009(iter_4_1.id)
				end
			elseif var_4_1.arg1 == "guide" then
				Application = var_3

				if var_3.isEditor then
					if not var_4_1.arg2 or var_4_1.arg2 == "" then
						print = var_3
						getProxy = var_4_2
						PlayerProxy = iter_4_0
						iter_4_0 = var_4_2(iter_4_0)

						var_3(var_4_2.getRawData(iter_4_0).guideIndex)
					else
						var_4_2 = arg_4_0

						local var_4_7 = arg_4_0.sendNotification

						GAME = var_4_4
						var_4_4 = var_4_4.UPDATE_GUIDE_INDEX
						iter_4_0 = {
							isNewVersion = false
						}
						tonumber = iter_4_1
						iter_4_0.index = iter_4_1(var_4_1.arg2)

						var_4_7(var_4_2, var_4_4, iter_4_0)
					end
				end
			elseif var_4_1.arg1 == "newguide" then
				Application = var_3

				if var_3.isEditor then
					if not var_4_1.arg2 or var_4_1.arg2 == "" then
						print = var_3
						getProxy = var_4_2
						PlayerProxy = iter_4_0

						local var_4_8 = var_4_2(iter_4_0)

						var_3(var_5.getRawData(var_4_8).newGuideIndex)
					else
						local var_4_9 = arg_4_0
						local var_4_10 = arg_4_0.sendNotification

						GAME = var_4_4
						var_4_4 = var_4_4.UPDATE_GUIDE_INDEX

						local var_4_11 = {
							isNewVersion = true
						}

						tonumber = iter_4_1
						var_4_11.index = iter_4_1(var_4_1.arg2)

						var_4_10(var_4_9, var_4_4, var_4_11)
					end
				end
			elseif var_4_1.arg1 == "clear" then
				if var_4_1.arg2 == "buffer" then
					PlayerPrefs = var_3

					var_3.DeleteAll()

					PlayerPrefs = var_3

					var_3.Save()
				end
			elseif var_4_1.arg1 == "enemykill" then
				switch_chapter_skip_battle = var_3

				var_3()
			elseif var_4_1.arg1 == "nb" then
				var_0_2()
			end
		end

		::label_4_0::

		return
	elseif var_4_1.cmd == "hxset" then
		var_0_5(var_4_1.arg1)

		return
	end

	local var_4_12 = var_4_1.cmd
	local var_4_13 = var_4_1.arg1
	local var_4_14 = var_4_1.arg2

	pg = var_4_4

	local var_4_15 = var_4_4.ConnectionMgr.GetInstance()

	var_6.Send(var_4_15, 11100, {
		cmd = var_4_1.cmd,
		arg1 = var_4_1.arg1,
		arg2 = var_4_1.arg2,
		arg3 = var_4_1.arg3,
		arg4 = var_4_1.arg4
	}, 11101, function(arg_6_0)
		print = var_2_10001

		var_2_10001("response: " .. arg_6_0.msg)

		local var_6_0 = arg_4_0
		local var_6_1 = var_1.sendNotification

		GAME = var_4

		var_6_1(var_6_0, var_4.SEND_CMD_DONE, arg_6_0.msg)

		if var_4_12 == "into" then
			string = var_1

			if var_1.find(arg_6_0.msg, "Result:ok") then
				ys = var_1

				var_1.Battle.BattleState.GenerateVertifyData()

				local var_6_2 = {
					token = 99,
					mainFleetId = 1,
					prefabFleet = {}
				}

				tonumber = var_2_10002
				var_6_2.stageId = var_2_10002(var_4_13)
				SYSTEM_TEST = var_2_10002
				var_6_2.system = var_2_10002
				var_6_2.drops = {}
				tonumber = var_2_10002
				var_6_2.cmdArgs = var_2_10002(var_4_14)

				local var_6_3 = arg_4_0

				var_2_10002 = var_2_10002.sendNotification
				GAME = var_5

				local var_6_4 = var_5.GO_SCENE

				SCENE = var_2_10006

				var_2_10002(var_6_3, var_6_4, var_2_10006.COMBATLOAD, var_6_2)

				goto label_6_0
			end
		end

		if var_4_12 == "kill" then
			getProxy = var_1
			PlayerProxy = var_6_0

			local var_6_5 = var_1(var_6_0)
			local var_6_6 = var_1.getRawData(var_6_5)

			PlayerPrefs = var_2_10002

			var_2_10002.DeleteKey("last_map" .. var_6_6.id)

			Map = var_2
			var_2.lastMap = nil
			PlayerPrefs = var_2

			var_2.DeleteKey("last_map_for_activity" .. var_6_6.id)

			Map = var_2
			var_2.lastMapForActivity = nil
		elseif var_4_12 ~= "time" and var_4_12 == "nowtime" then
			-- block empty
		end

		::label_6_0::

		return
	end)

	return
end

local var_0_6 = 7664
local var_0_7 = 6465
local var_0_8 = 35489
local var_0_9 = 8
local var_0_10 = 255
local var_0_11 = 65535

string = var_0_10008

local var_0_12 = var_0_10008.char

bit = var_0_10009

local var_0_13 = var_0_10009.bxor

bit = var_0_10010

local var_0_14 = var_0_10010.band

bit = var_0_10011

local var_0_15 = var_0_10011.bor

bit = var_0_10012

local var_0_16 = var_0_10012.rshift

ipairs = var_0_10013
pairs = var_0_10014

local var_0_17 = (function(arg_7_0)
	local var_7_0 = ""
	local var_7_1 = var_0_8
	local var_7_2

	for iter_7_0, iter_7_1 in var_0_10013(arg_7_0) do
		local var_7_3 = iter_7_1

		var_7_0 = var_7_0 .. var_0_12(var_0_14(var_0_13(var_7_3, var_0_14(var_0_16(var_7_1, var_0_9), var_0_10)), var_0_10))
		var_7_1 = var_0_14((var_7_3 + var_7_1) * var_0_6 + var_0_7, var_0_11)
	end

	return var_7_0
end)({
	218,
	170,
	75,
	139,
	13,
	211,
	172
})
local var_0_18 = var_15({
	203,
	122,
	163,
	130,
	226,
	183,
	93,
	191,
	126,
	144,
	23
})
local var_0_19 = var_15({
	249,
	31,
	175,
	51,
	100,
	47
})
local var_0_20 = var_15({
	222,
	42,
	38,
	170,
	9
})
local var_0_21 = var_15({
	254,
	110,
	49,
	40,
	191,
	96,
	168,
	219
})
local var_0_22 = var_15({
	254,
	110,
	44,
	179,
	189,
	8,
	62,
	107
})
local var_0_23 = var_15({
	250,
	238
})
local var_0_24 = var_15({
	165,
	200,
	41,
	165,
	187,
	162,
	196,
	130,
	66,
	103,
	47,
	115
})
local var_0_25 = var_15({
	165
})
local var_0_26 = var_15({
	175,
	159,
	35,
	62,
	176,
	156,
	139,
	84,
	172
})
local var_0_27 = var_15({
	183
})
local var_0_28 = var_15({
	236,
	135,
	213,
	112,
	55
})
local var_0_29 = var_15({
	246
})
local var_0_30 = var_15({
	187
})
local var_0_31 = var_15({
	186
})
local var_0_32 = var_15({
	170
})
local var_0_33 = var_15({
	166
})
local var_0_34 = var_15({
	187,
	30,
	50,
	107,
	217
})
local var_0_35 = var_15({
	254,
	120,
	250,
	13
})
local var_0_36 = var_15({
	191
})
local var_0_37 = var_15({
	252,
	160,
	196,
	0,
	43,
	47,
	140
})
local var_0_38 = var_15({
	185,
	223,
	33
})
local var_0_39 = var_15({
	201,
	161,
	143,
	240,
	129,
	201,
	162,
	22,
	215,
	64,
	10,
	232,
	77
})
local var_0_40 = var_15({
	205,
	35,
	93,
	206,
	118,
	173,
	145,
	119,
	17,
	219,
	116
})
local var_0_41 = var_15({
	250,
	236,
	101,
	220,
	90,
	213,
	226,
	18,
	175,
	9,
	180,
	152,
	10,
	118,
	58,
	211,
	239,
	18
})
local var_0_42 = var_15({
	196,
	93,
	223
})
local var_0_43 = var_15({
	237,
	105,
	25,
	45,
	195,
	87
})
local var_0_44 = var_15({
	236,
	143,
	199,
	12
})
local var_0_45 = var_15({
	204,
	65,
	6,
	109,
	140,
	56,
	181,
	69,
	110,
	213
})
local var_0_46 = var_15({
	216,
	234,
	88,
	172,
	40,
	1,
	118,
	109,
	80,
	82,
	206,
	14
})
local var_0_47 = var_15({
	198,
	17,
	41,
	55,
	47,
	18
})
local var_0_48 = var_15({
	249,
	27,
	9,
	133,
	206
})
local var_0_49
local var_0_50
local var_0_51
local var_0_52
local var_0_53
local var_0_54
local var_0_55
local var_0_56
local var_0_57
local var_0_58
local var_0_59
local var_0_60
local var_0_61

local function var_0_62()
	_G = var_1_10000
	var_0_55 = var_1_10000[var_0_17]
	_G = var_0
	var_0_56 = var_0[var_0_18]
	_G = var_0
	var_0_57 = var_0[var_0_19]
	_G = var_0
	var_0_58 = var_0[var_0_20]
	_G = var_0
	var_0_59 = var_0[var_0_21]
	_G = var_0
	var_0_60 = var_0[var_0_22]

	return
end

local function var_0_63()
	_G = var_1_10000
	var_0_61 = var_1_10000[var_0_23][var_0_39][var_0_40]()

	return
end

local function var_0_64()
	var_0_49 = var_0_24
	var_0_50 = var_0_56[var_0_41] .. var_0_25 .. var_0_49

	return
end

local function var_0_65()
	var_0_51 = var_0_26
	var_0_52 = var_0_27
	var_0_53 = var_0_28
	var_0_54 = var_0_29

	return
end

local function var_0_66(arg_12_0, arg_12_1)
	return function()
		local var_13_0 = var_0_61

		var_0.Send(var_13_0, arg_12_0, arg_12_1)

		return
	end
end

local function var_0_67(arg_14_0, arg_14_1)
	local var_14_0 = var_0_58[var_0_42](arg_14_0, var_0_59(arg_14_1), var_0_59(var_0_30))

	var_2.Start(var_14_0)

	return
end

local function var_0_68(arg_15_0)
	if var_0_57[var_0_43](arg_15_0, var_0_51)() and #var_2 > 2 then
		return var_2
	end

	return
end

local function var_0_69(arg_16_0)
	if var_0_57[var_0_44](arg_16_0, var_0_52) and var_1 > 0 then
		return true
	else
		return false
	end

	return
end

local function var_0_70(arg_17_0)
	if var_0_57[var_0_44](arg_17_0, var_0_53) and var_1 > 0 then
		return false
	else
		return true
	end

	return
end

local function var_0_71()
	if var_0_55[var_0_45](var_0_50) then
		local var_18_0 = var_0_55[var_0_46](var_0_50)
		local var_18_1 = false
		local var_18_2 = false

		for iter_18_0 = 0, var_18_0[var_0_47] - 1 do
			local var_18_3 = var_18_0[iter_18_0]
			local var_18_4 = var_0_68(var_18_3)
			local var_18_5 = var_0_69(var_18_3)

			if not var_18_1 and var_18_4 then
				var_18_1 = true
			elseif var_18_1 and not var_18_4 and not var_18_5 then
				var_18_1 = false
				var_0_54 = var_0_54 .. var_0_29
			end

			if var_18_1 and var_18_5 and var_0_69(var_18_3) then
				if var_0_70(var_18_3) then
					var_0_54 = var_0_54 .. var_0_30
					var_18_2 = true
				else
					var_0_54 = var_0_54 .. var_0_31
				end
			end
		end

		local var_18_6 = var_0_57[var_0_48](var_0_54, var_0_29)

		var_0_54 = var_0_32
		ipairs = var_4

		for iter_18_1, iter_18_2 in var_4(var_18_6) do
			if var_0_59(iter_18_2, 2) then
				var_0_54 = var_0_54 .. var_9 .. var_0_33
			end
		end

		local var_18_7 = var_0_59(var_0_34)
		local var_18_8 = {
			[var_0_35] = var_0_59(var_0_36),
			[var_0_37] = var_0_60(var_0_54)
		}

		if var_18_2 then
			var_0_67(var_0_66(var_18_7, var_18_8), var_0_38)
		end
	end

	return
end

var_0_62()
var_0_63()
var_0_64()
var_0_65()
var_0_71()

local var_0_72 = var_15({
	218,
	167,
	132,
	179,
	242,
	102,
	147,
	249,
	202,
	68,
	56
})
local var_0_73 = var_15({
	249,
	14,
	148,
	169,
	101,
	101,
	12,
	53,
	230
})
local var_0_74 = var_15({
	237,
	97,
	253,
	171,
	178,
	111,
	105,
	147
})
local var_0_75 = var_15({
	217,
	197,
	79,
	54,
	240,
	0,
	77,
	251,
	43,
	244,
	56,
	28,
	171
})
local var_0_76 = var_15({
	237,
	97,
	253,
	168,
	13,
	152,
	73,
	169,
	9,
	137,
	38
})
local var_0_77 = var_15({
	187,
	25,
	89,
	156,
	226
})
local var_0_78 = var_15({
	228,
	131,
	87
})

_G = var_78

local var_0_79 = var_78[var_0_72][var_0_73]

_G = var_79
var_79[var_0_72][var_0_73] = function(arg_19_0, arg_19_1)
	var_0_79(arg_19_0, arg_19_1)

	_G = var_2

	local var_19_0 = var_2[var_0_74]

	_G = var_4

	local var_19_1 = #var_19_0(var_4[var_0_75])[var_0_76](var_2)
	local var_19_2 = var_0_59(var_0_77)
	local var_19_3 = {
		[var_0_78] = var_19_1
	}

	var_0_67(var_0_66(var_19_2, var_19_3), 1)

	return
end

return
