local var_0_0 = require("cjson")
local var_0_1 = {
	[0] = {
		1,
		1
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		0
	}
}
local var_0_2 = false
local var_0_3 = {
	EnterChessMap = function(arg_1_0, arg_1_1)
		local var_1_0, var_1_1 = gameContext:GetLastHistoryAndParams()

		NewWarChessData:SetTemporaryData("url", var_1_0)
		NewWarChessData:SetTemporaryData("urlParams", var_1_1)
		NewWarChessData:SetTemporaryData("playEnterAni", true)
		NewWarChessAction.EnterNewWarChess(arg_1_0)
	end,
	LoadMap = function(arg_2_0)
		local var_2_0
		local var_2_1 = AssetEx.LoadText("Map/NewChess/JsonMap/" .. arg_2_0 .. ".json")

		return (var_0_0.decode(var_2_1))
	end,
	GetInteractStyle = function(arg_3_0)
		return 0
	end
}

function var_0_3.ParseParameter(arg_4_0)
	if arg_4_0.Length <= 0 then
		return {}
	end

	local var_4_0 = {}

	for iter_4_0 = 0, arg_4_0.Length - 1 do
		var_4_0[iter_4_0] = {}

		local var_4_1
		local var_4_2 = arg_4_0[iter_4_0]

		if not NewWarChessEventPoolCfg[var_4_2] or not var_4_2 then
			-- block empty
		else
			local var_4_3
			local var_4_4 = NewWarChessEventPoolCfg[var_4_2].params

			if not var_4_4 or var_4_4 == "" then
				-- block empty
			else
				var_4_0[iter_4_0] = var_0_3.ParseEventPollCfg(var_4_4)
			end
		end
	end

	return var_4_0
end

function var_0_3.ParseParameterLua(arg_5_0)
	if not NewWarChessEventPoolCfg[arg_5_0] or not arg_5_0 then
		-- block empty
	else
		local var_5_0
		local var_5_1 = NewWarChessEventPoolCfg[arg_5_0].params

		if not var_5_1 or var_5_1 == "" then
			-- block empty
		else
			return var_0_3.ParseEventPollCfg(var_5_1)
		end
	end
end

function var_0_3.ParseEventPollCfg(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		var_6_0[iter_6_0] = {}
		var_6_0[iter_6_0].params = {}

		table.insert(var_6_0[iter_6_0].params, {})

		for iter_6_2 = 1, #iter_6_1 do
			if iter_6_2 == 1 then
				var_6_0[iter_6_0].eventID = iter_6_1[iter_6_2]
			else
				var_6_0[iter_6_0].params[#var_6_0[iter_6_0].params + 1] = iter_6_1[iter_6_2]
			end
		end
	end

	return var_6_0
end

function var_0_3.CreateChessData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return {
		objecttag = 0,
		tag = 0,
		pos = {
			x = arg_7_0,
			z = arg_7_1
		},
		direction = (arg_7_2[arg_7_3].rotationY or 0) / 60,
		status = arg_7_2[arg_7_3].status,
		objectdirection = (arg_7_2[arg_7_3].ObjectRotationY or 0) / 60,
		attribute = {}
	}
end

function var_0_3.TwoDToOneD(arg_8_0, arg_8_1)
	return arg_8_1 * 1000 + arg_8_0
end

function var_0_3.GetMovePointText(arg_9_0)
	if arg_9_0 then
		return string.format("%d<color=#949494>/%d</color>", arg_9_0, NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.max)
	else
		return string.format("%d<color=#949494>/%d</color>", 0, NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.max)
	end
end

function var_0_3.GetDiceEventDes(arg_10_0, arg_10_1, arg_10_2)
	if NewWarChessDiceEventTypeCfg[arg_10_0.diceevent_type] then
		local var_10_0 = arg_10_0.des

		if arg_10_2 then
			local var_10_1 = NewWarChessDiceEventTypeCfg[arg_10_0.diceevent_type].param
			local var_10_2 = NewChessEventConfig.DiceTypeFunc[var_10_1[1]](var_10_1, arg_10_1)

			return string.format(var_10_0, unpack(var_10_2), "%")
		else
			return string.format(var_10_0, NewWarChessDiceEventTypeCfg[arg_10_0.diceevent_type].description, "")
		end
	end

	return arg_10_0.des
end

function var_0_3.GetChanceDes(arg_11_0)
	local var_11_0 = arg_11_0.description

	if type(arg_11_0.des_params) == "table" and arg_11_0.des_params[1] then
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in pairs(arg_11_0.des_params) do
			table.insert(var_11_1, NewWarChessData:GetAttribute(iter_11_1))
		end

		return string.format(var_11_0, unpack(var_11_1))
	end

	return var_11_0
end

function var_0_3.GetBuffDes(arg_12_0)
	local var_12_0 = NewWarChessBuffPoolCfg[arg_12_0.buffPoolID]
	local var_12_1 = var_12_0.description

	if type(var_12_0.des_params) == "table" and var_12_0.des_params[1] then
		local var_12_2 = {}

		for iter_12_0, iter_12_1 in pairs(var_12_0.des_params) do
			if iter_12_1 == 1 then
				table.insert(var_12_2, arg_12_0.CurUpdateRound)
			elseif iter_12_1 == 2 then
				table.insert(var_12_2, arg_12_0.CurRemainRound)
			end
		end

		return string.format(var_12_1, unpack(var_12_2))
	end

	return var_12_1
end

function var_0_3.ExitNewChessScene(arg_13_0)
	manager.windowBar:ClearWhereTag()
	NewWarChessData:SaveDataToSystem()
	NewWarChessAction.UpdateNewWarChessRedPoint()
	manager.audio:StopEffect()
	NewChessLuaBridge.ExitNewWarChess()
	DestroyLua()
	LuaExchangeHelper.GoToMain()

	if arg_13_0 then
		OpenPageUntilLoaded("/home", {})
	else
		local var_13_0 = NewWarChessData:GetTemporaryData("url")
		local var_13_1 = NewWarChessData:GetTemporaryData("urlParams")

		OpenPageUntilLoaded(var_13_0, var_13_1)
	end

	if manager.NewChessManager then
		manager.NewChessManager:Dispose()

		manager.NewChessManager = nil
	end
end

function var_0_3.GetNewWarChessGameSetting(arg_14_0, arg_14_1)
	if arg_14_1 == nil or NewWarChessGameSettingCfg[arg_14_1] == nil then
		arg_14_1 = NewChessConst.NEW_WARCHESS_TEMPLATE_DEFULT
	end

	return NewWarChessGameSettingCfg[arg_14_1][arg_14_0]
end

function var_0_3.InitNewChessConfig()
	if var_0_2 == false then
		local var_15_0 = {}

		for iter_15_0, iter_15_1 in pairs(NewWarChessHexCfg) do
			if iter_15_1.id then
				local var_15_1 = NewGridConfig.New()

				var_15_1.id = iter_15_1.id
				var_15_1.walkable = iter_15_1.walkable

				if iter_15_1.penalty < 0 then
					var_15_1.penalty = 0
				else
					var_15_1.penalty = iter_15_1.penalty
				end

				var_15_1.height = iter_15_1.height
				var_15_1.fogAddRange = iter_15_1.foglength
				var_15_1.mapLayer = iter_15_1.maplayer
				var_15_1.isHide = iter_15_1.ishide

				table.insert(var_15_0, var_15_1)
			end
		end

		NewWarChessHexCfg.AllGridConfig = var_15_0

		local var_15_2 = {}

		for iter_15_2, iter_15_3 in pairs(NewWarChessThingCfg.all) do
			local var_15_3 = NewWarChessThingCfg[iter_15_3]
			local var_15_4 = NewWarChessThingConfig.New()

			var_15_4.thingID = var_15_3.id
			var_15_4.walkable = var_15_3.walkable

			table.insert(var_15_2, var_15_4)
		end

		NewWarChessThingCfg.AllThingConfig = var_15_2

		local var_15_5 = NewChessConfigData.New()

		var_15_5.GridConfig = NewWarChessHexCfg.AllGridConfig
		var_15_5.ThingConfig = NewWarChessThingCfg.AllThingConfig

		local var_15_6 = NewWarChessData:GetCurrentActivity()
		local var_15_7 = var_0_3.GetNewWarChessGameSetting("new_warchess_conveyor_list", var_15_6)

		if type(var_15_7) == "table" and #var_15_7 > 0 then
			var_15_5.ConveyorIDList = var_15_7
		else
			var_15_5.ConveyorIDList = {
				0
			}
		end

		local var_15_8 = var_0_3.GetNewWarChessGameSetting("new_warchess_reverse_conveyor_list", var_15_6)

		if type(var_15_8) == "table" and #var_15_8 > 0 then
			var_15_5.ReverseConveyorIDList = var_15_8
		else
			var_15_5.ReverseConveyorIDList = {
				0
			}
		end

		NewChessLuaBridge.InitNewChessConfigData(var_15_5)

		var_0_2 = true
	end
end

return var_0_3
