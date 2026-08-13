class = var_0_10000

local var_0_0 = "TowerClimbingGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "TowerClimbingUI"
end

function var_0_1.GetMGData(arg_2_0)
	local var_2_0 = arg_2_0.contextData.miniGameId

	getProxy = var_1_10002
	MiniGameProxy = var_1_10004

	local var_2_1 = var_1_10002(var_1_10004)
	local var_2_2 = var_2.GetMiniGameData(var_2_1, var_2_0)

	return var_2.clone(var_2_2)
end

function var_0_1.GetMGHubData(arg_3_0)
	local var_3_0 = arg_3_0.contextData.miniGameId

	getProxy = var_1_10002
	MiniGameProxy = var_1_10004

	local var_3_1 = var_1_10002(var_1_10004)

	return var_2.GetHubByGameId(var_3_1, var_3_0)
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "overview/back")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_4.Find(var_4_5, "overview/collection")

	local function var_4_7()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		TowerClimbingMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.ON_COLLECTION)

		return
	end

	SFX_PANEL = var_4_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_4_5)

	LOCK_TOWERCLIMBING_AWARD = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001

		local var_4_8 = arg_4_0._tf

		var_1_10001(var_3.Find(var_4_8, "overview/collection"), false)
	end

	return
end

function var_0_1.UpdateTip(arg_7_0)
	local var_7_0 = arg_7_0:GetMGData()

	TowerClimbingCollectionLayer = var_1_10002

	local var_7_1 = var_1_10002.New()

	var_2.SetData(var_7_1, var_7_0)

	_ = var_3

	local var_7_2 = var_3.any({
		1,
		2,
		3
	}, function(arg_8_0)
		local var_8_0 = var_0

		return var_1.GetAwardState(var_8_0, arg_8_0) == 1
	end)

	setActive = var_1_10004

	local var_7_3 = arg_7_0._tf

	var_1_10004(var_6.Find(var_7_3, "overview/collection/tip"), var_7_2)

	return
end

function var_0_1.Start(arg_9_0)
	TowerClimbingController = var_1_10001
	arg_9_0.controller = var_1_10001.New()

	local var_9_0 = arg_9_0.controller.view

	var_1.SetUI(var_9_0, arg_9_0._go)

	local function var_9_1(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_9_0
		local var_10_1 = var_3.emit

		TowerClimbingMediator = var_2_10006

		var_10_1(var_10_0, var_2_10006.ON_FINISH, arg_10_0, arg_10_2, arg_10_1)

		return
	end

	local function var_9_2(arg_11_0, arg_11_1)
		print = var_2_10002

		var_2_10002("record map score:", arg_11_0, arg_11_1)

		local var_11_0 = arg_9_0
		local var_11_1 = var_2.emit

		TowerClimbingMediator = var_5

		var_11_1(var_11_0, var_5.ON_RECORD_MAP_SCORE, arg_11_0, arg_11_1)

		return
	end

	local var_9_3 = arg_9_0.controller

	var_3.SetCallBack(var_9_3, var_9_1, var_9_2)

	local var_9_4 = arg_9_0:PackData()
	local var_9_5 = arg_9_0.controller

	var_4.SetUp(var_9_5, var_9_4)
	arg_9_0:UpdateTip()

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_12_0, arg_12_1)
	if arg_12_1.hubid == 9 then
		local var_12_0 = arg_12_1.cmd

		MiniGameOPCommand = var_1_10003

		if var_12_0 == var_1_10003.CMD_SPECIAL_GAME then
			local var_12_1 = arg_12_1.argList[1]

			MiniGameDataCreator = var_1_10003

			if var_12_1 == var_1_10003.TowerClimbingGameID and arg_12_1.argList[2] == 1 then
				arg_12_0:Start()

				goto label_12_0
			end
		end
	end

	if arg_12_1.hubid == 9 then
		local var_12_2 = arg_12_1.cmd

		MiniGameOPCommand = var_1_10003

		if var_12_2 ~= var_1_10003.CMD_COMPLETE then
			if arg_12_1.hubid == 9 then
				local var_12_3 = arg_12_1.cmd

				MiniGameOPCommand = var_1_10003

				if var_12_3 == var_1_10003.CMD_SPECIAL_GAME and (arg_12_1.argList[2] == 3 or arg_12_1.argList[2] == 4) then
					local var_12_4 = arg_12_0:PackData()
					local var_12_5 = arg_12_0.controller

					var_3.NetUpdateData(var_12_5, var_12_4)
					arg_12_0:UpdateTip()
				end
			end

			::label_12_0::

			return
		end
	end
end

function var_0_1.GetTowerClimbingPageAndScore(arg_13_0)
	local var_13_0

	if not arg_13_0[1] then
		var_13_0 = {}
	end

	local var_13_1 = 3

	for iter_13_0 = #var_13_0 + 1, var_13_1 do
		table = var_1_10007

		var_1_10007.insert(var_13_0, {
			value = 0,
			value2 = 0,
			key = iter_13_0
		})
	end

	table = var_3

	var_3.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.key < arg_14_1.key
	end)

	local var_13_2 = var_0_1.GetAwardScores()
	local var_13_3 = 0
	local var_13_4 = 1

	ipairs = var_6

	for iter_13_1, iter_13_2 in var_6(var_13_0) do
		local var_13_5 = var_11[#var_13_2[iter_13_2.key]]

		if iter_13_2.value2 < var_13_5 or iter_13_1 == #var_13_0 and var_13_5 <= iter_13_2.value2 then
			var_13_3 = iter_13_2.value2
			var_13_4 = iter_13_2.key

			break
		end
	end

	local var_13_6 = {}
	local var_13_7

	if not arg_13_0[2] then
		var_13_7 = {}
	end

	local var_13_8 = 3

	for iter_13_3 = #var_13_7 + 1, var_13_8 do
		table = var_1_10013

		var_1_10013.insert(var_13_7, {
			value = 0,
			key = iter_13_3
		})
	end

	table = var_9

	var_9.sort(var_13_7, function(arg_15_0, arg_15_1)
		return arg_15_0.key < arg_15_1.key
	end)

	ipairs = var_9

	for iter_13_4, iter_13_5 in var_9(var_13_7) do
		var_13_6[iter_13_5.key] = iter_13_5.value
	end

	return var_13_3, var_13_4, var_13_6
end

function var_0_1.GetAwardScores()
	pg = var_1_10000

	local var_16_0 = var_1_10000.mini_game

	MiniGameDataCreator = var_1_10001

	local var_16_1 = var_16_0[var_1_10001.TowerClimbingGameID].simple_config_data

	_ = var_1

	return (var_1.map(var_16_1, function(arg_17_0)
		return arg_17_0[1]
	end))
end

function var_0_1.PackData(arg_18_0)
	local var_18_0 = arg_18_0._tf.rect.width
	local var_18_1 = arg_18_0._tf.rect.height
	local var_18_2 = arg_18_0:GetMGData()
	local var_18_3 = var_3.GetRuntimeData(var_18_2, "kvpElements")
	local var_18_4, var_18_5, var_18_6 = var_0_1.GetTowerClimbingPageAndScore(var_18_3)

	print = var_1_10007

	var_1_10007(var_18_4, "-", var_18_5)

	local var_18_7 = var_0_1.GetAwardScores()

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = var_18_0,
		screenHeight = var_18_1,
		higestscore = var_18_4,
		pageIndex = var_18_5,
		mapScores = var_18_6,
		awards = var_18_7
	}
end

function var_0_1.onBackPressed(arg_19_0)
	local var_19_0 = arg_19_0.controller

	if var_1.onBackPressed(var_19_0) then
		return
	end

	arg_19_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_20_0)
	local var_20_0 = arg_20_0.controller

	var_1.Dispose(var_20_0)

	return
end

return var_0_1
