local cjson = require("cjson")
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
		return (cjson.decode((AssetEx.LoadText("Map/NewChess/JsonMap/" .. arg_2_0 .. ".json"))))
	end,
	GetInteractStyle = function(arg_3_0)
		return 0
	end
}

function var_0_3:ParseParameter()
	if self.Length <= 0 then
		return {}
	end

	local var_4_0 = {}

	for iter_4_0 = 0, self.Length - 1 do
		var_4_0[iter_4_0] = {}

		if not NewWarChessEventPoolCfg[self[iter_4_0]] or not self[iter_4_0] then
			-- block empty
		elseif not NewWarChessEventPoolCfg[self[iter_4_0]].params or NewWarChessEventPoolCfg[self[iter_4_0]].params == "" then
			-- block empty
		else
			var_4_0[iter_4_0] = var_0_3.ParseEventPollCfg(NewWarChessEventPoolCfg[self[iter_4_0]].params)
		end
	end

	return var_4_0
end

function var_0_3.ParseParameterLua(arg_5_0)
	if not NewWarChessEventPoolCfg[arg_5_0] or not arg_5_0 then
		-- block empty
	elseif not NewWarChessEventPoolCfg[arg_5_0].params or NewWarChessEventPoolCfg[arg_5_0].params == "" then
		-- block empty
	else
		return var_0_3.ParseEventPollCfg(NewWarChessEventPoolCfg[arg_5_0].params)
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
	local var_7_0 = {
		objecttag = 0,
		tag = 0,
		pos = {
			x = arg_7_0,
			z = arg_7_1
		}
	}

	var_7_0.direction = (arg_7_2[arg_7_3].rotationY or 0) / 60
	var_7_0.status = arg_7_2[arg_7_3].status
	var_7_0.objectdirection = (arg_7_2[arg_7_3].ObjectRotationY or 0) / 60
	var_7_0.attribute = {}

	return var_7_0
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

function var_0_3:GetDiceEventDes(arg_10_1, arg_10_2)
	if NewWarChessDiceEventTypeCfg[self.diceevent_type] then
		if arg_10_2 then
			return string.format(self.des, unpack((NewChessEventConfig.DiceTypeFunc[NewWarChessDiceEventTypeCfg[self.diceevent_type].param[1]](NewWarChessDiceEventTypeCfg[self.diceevent_type].param, arg_10_1))), "%")
		else
			return string.format(self.des, NewWarChessDiceEventTypeCfg[self.diceevent_type].description, "")
		end
	end

	return self.des
end

function var_0_3:GetChanceDes()
	if type(self.des_params) == "table" and self.des_params[1] then
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(self.des_params) do
			table.insert(var_11_0, NewWarChessData:GetAttribute(iter_11_1))
		end

		return string.format(self.description, unpack(var_11_0))
	end

	return self.description
end

function var_0_3:GetBuffDes()
	if type(NewWarChessBuffPoolCfg[self.buffPoolID].des_params) == "table" and NewWarChessBuffPoolCfg[self.buffPoolID].des_params[1] then
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs(NewWarChessBuffPoolCfg[self.buffPoolID].des_params) do
			if iter_12_1 == 1 then
				table.insert(var_12_0, self.CurUpdateRound)
			elseif iter_12_1 == 2 then
				table.insert(var_12_0, self.CurRemainRound)
			end
		end

		return string.format(NewWarChessBuffPoolCfg[self.buffPoolID].description, unpack(var_12_0))
	end

	return NewWarChessBuffPoolCfg[self.buffPoolID].description
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
		OpenPageUntilLoaded(NewWarChessData:GetTemporaryData("url"), (NewWarChessData:GetTemporaryData("urlParams")))
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
				var_15_1.penalty = iter_15_1.penalty < 0 and 0 or iter_15_1.penalty
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
			local var_15_3 = NewWarChessThingConfig.New()

			var_15_3.thingID = NewWarChessThingCfg[iter_15_3].id
			var_15_3.walkable = NewWarChessThingCfg[iter_15_3].walkable

			table.insert(var_15_2, var_15_3)
		end

		NewWarChessThingCfg.AllThingConfig = var_15_2

		local var_15_4 = NewChessConfigData.New()

		var_15_4.GridConfig = NewWarChessHexCfg.AllGridConfig
		var_15_4.ThingConfig = NewWarChessThingCfg.AllThingConfig

		local var_15_5 = NewWarChessData:GetCurrentActivity()
		local var_15_6 = var_0_3.GetNewWarChessGameSetting("new_warchess_conveyor_list", var_15_5)

		var_15_4.ConveyorIDList = type(var_15_6) == "table" and #var_15_6 > 0 and var_15_6 or {
			0
		}

		local var_15_7 = var_0_3.GetNewWarChessGameSetting("new_warchess_reverse_conveyor_list", var_15_5)

		var_15_4.ReverseConveyorIDList = type(var_15_7) == "table" and #var_15_7 > 0 and var_15_7 or {
			0
		}

		NewChessLuaBridge.InitNewChessConfigData(var_15_4)

		var_0_2 = true
	end
end

return var_0_3
