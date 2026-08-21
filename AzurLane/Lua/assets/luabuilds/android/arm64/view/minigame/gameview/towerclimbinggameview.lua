local var_0_0 = class("TowerClimbingGameView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "TowerClimbingUI"
end

function var_0_0.GetMGData(arg_2_0)
	return getProxy(MiniGameProxy):GetMiniGameData(arg_2_0.contextData.miniGameId):clone()
end

function var_0_0.GetMGHubData(arg_3_0)
	return getProxy(MiniGameProxy):GetHubByGameId(arg_3_0.contextData.miniGameId)
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("overview/back"), function()
		arg_4_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0._tf:Find("overview/collection"), function()
		arg_4_0:emit(TowerClimbingMediator.ON_COLLECTION)

		return
	end, SFX_PANEL)

	if LOCK_TOWERCLIMBING_AWARD then
		setActive(arg_4_0._tf:Find("overview/collection"), false)
	end

	return
end

function var_0_0.UpdateTip(arg_7_0)
	local var_7_0 = TowerClimbingCollectionLayer.New()

	TowerClimbingCollectionLayer.New():SetData((arg_7_0:GetMGData()))
	setActive(arg_7_0._tf:Find("overview/collection/tip"), (_.any({
		1,
		2,
		3
	}, function(arg_8_0)
		return var_7_0:GetAwardState(arg_8_0) == 1
	end)))

	return
end

function var_0_0.Start(arg_9_0)
	arg_9_0.controller = TowerClimbingController.New()

	arg_9_0.controller.view:SetUI(arg_9_0._go)
	arg_9_0.controller:SetCallBack(function(arg_10_0, arg_10_1, arg_10_2)
		arg_9_0:emit(TowerClimbingMediator.ON_FINISH, arg_10_0, arg_10_2, arg_10_1)

		return
	end, function(arg_11_0, arg_11_1)
		print("record map score:", arg_11_0, arg_11_1)
		arg_9_0:emit(TowerClimbingMediator.ON_RECORD_MAP_SCORE, arg_11_0, arg_11_1)

		return
	end)
	arg_9_0.controller:SetUp((arg_9_0:PackData()))
	arg_9_0:UpdateTip()

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_12_0, arg_12_1)
	if arg_12_1.hubid == 9 and arg_12_1.cmd == MiniGameOPCommand.CMD_SPECIAL_GAME and arg_12_1.argList[1] == MiniGameDataCreator.TowerClimbingGameID and arg_12_1.argList[2] == 1 then
		arg_12_0:Start()

		goto label_12_0
	end

	::label_12_0::

	if arg_12_1.hubid ~= 9 or arg_12_1.cmd ~= MiniGameOPCommand.CMD_COMPLETE then
		if arg_12_1.hubid == 9 and arg_12_1.cmd == MiniGameOPCommand.CMD_SPECIAL_GAME then
			if arg_12_1.argList[2] ~= 3 then
				if arg_12_1.argList[2] == 4 then
					arg_12_0.controller:NetUpdateData((arg_12_0:PackData()))
					arg_12_0:UpdateTip()
				end

				return
			end
		end
	end
end

function var_0_0.GetTowerClimbingPageAndScore(arg_13_0)
	local var_13_0 = arg_13_0[1] or {}

	for iter_13_0 = #var_13_0 + 1, 3 do
		table.insert(var_13_0, {
			value = 0,
			value2 = 0,
			key = iter_13_0
		})
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.key < arg_14_1.key
	end)

	local var_13_1 = var_0_0.GetAwardScores()
	local var_13_2 = 0
	local var_13_3 = 1

	for iter_13_1, iter_13_2 in ipairs(var_13_0) do
		if var_13_1[iter_13_2.key][#var_13_1[iter_13_2.key]] > iter_13_2.value2 or iter_13_1 == #var_13_0 and var_13_1[iter_13_2.key][#var_13_1[iter_13_2.key]] <= iter_13_2.value2 then
			var_13_2 = iter_13_2.value2
			var_13_3 = iter_13_2.key

			break
		end
	end

	local var_13_4 = {}
	local var_13_5 = arg_13_0[2] or {}

	for iter_13_3 = #var_13_5 + 1, 3 do
		table.insert(var_13_5, {
			value = 0,
			key = iter_13_3
		})
	end

	table.sort(var_13_5, function(arg_15_0, arg_15_1)
		return arg_15_0.key < arg_15_1.key
	end)

	for iter_13_4, iter_13_5 in ipairs(var_13_5) do
		var_13_4[iter_13_5.key] = iter_13_5.value
	end

	return var_13_2, var_13_3, var_13_4
end

function var_0_0.GetAwardScores()
	return (_.map(pg.mini_game[MiniGameDataCreator.TowerClimbingGameID].simple_config_data, function(arg_17_0)
		return arg_17_0[1]
	end))
end

function var_0_0.PackData(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = var_0_0.GetTowerClimbingPageAndScore((arg_18_0:GetMGData():GetRuntimeData("kvpElements")))

	print(var_18_0, "-", var_18_1)

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = arg_18_0._tf.rect.width,
		screenHeight = arg_18_0._tf.rect.height,
		higestscore = var_18_0,
		pageIndex = var_18_1,
		mapScores = var_18_2,
		awards = var_0_0.GetAwardScores()
	}
end

function var_0_0.onBackPressed(arg_19_0)
	if arg_19_0.controller:onBackPressed() then
		return
	end

	arg_19_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.willExit(arg_20_0)
	arg_20_0.controller:Dispose()

	return
end

return var_0_0
