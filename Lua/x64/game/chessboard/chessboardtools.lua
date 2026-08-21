local var_0_0 = require("cjson")
local var_0_1 = false

return {
	dirToPos = {
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
	},
	EnterChessMap = function(arg_1_0)
		local var_1_0, var_1_1 = gameContext:GetLastHistoryAndParams()

		ChessBoardData:SetTemporaryData("url", var_1_0)
		ChessBoardData:SetTemporaryData("urlParams", var_1_1)
		ChessBoardData:SetTemporaryData("playEnterAni", true)
		ChessBoardAction.EnterChessBoard(arg_1_0)
	end,
	LoadMap = function(arg_2_0)
		local var_2_0
		local var_2_1 = AssetEx.LoadText("Map/ChessBoard/JsonMap/" .. arg_2_0 .. ".json")

		return (var_0_0.decode(var_2_1))
	end,
	CreateChessBoardLuaGridData = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		return {
			thingtag = 0,
			tag = 0,
			pos = {
				x = arg_3_0,
				z = arg_3_1
			},
			rotationY = (arg_3_2[arg_3_3].rotationY or 0) / 60,
			status = arg_3_2[arg_3_3].status,
			thingRotationY = (arg_3_2[arg_3_3].thingRotationY or 0) / 60
		}
	end,
	TwoDToOneD = function(arg_4_0, arg_4_1)
		return arg_4_1 * 1000 + arg_4_0
	end,
	ExitChessBoardScene = function(arg_5_0)
		manager.windowBar:ClearWhereTag()
		manager.audio:StopEffect()
		ChessBoardLuaBridge.ExitChessBoard()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		if arg_5_0 then
			OpenPageUntilLoaded("/home", {})
		else
			local var_5_0 = ChessBoardData:GetTemporaryData("url")
			local var_5_1 = ChessBoardData:GetTemporaryData("urlParams")

			OpenPageUntilLoaded(var_5_0, var_5_1)
		end

		if manager.ChessBoardManager then
			manager.ChessBoardManager:Dispose()

			manager.ChessBoardManager = nil
		end
	end,
	GetChessBoardGameSetting = function(arg_6_0, arg_6_1)
		if arg_6_1 == nil or ChessBoardGameSettingCfg[arg_6_1] == nil then
			arg_6_1 = ChessBoardConst.CHESSBOARD_TEMPLATE_DEFULT
		end

		return ChessBoardGameSettingCfg[arg_6_1][arg_6_0]
	end,
	InitChessBoardConfig = function()
		if var_0_1 == false then
			local var_7_0 = {}

			for iter_7_0, iter_7_1 in pairs(ChessBoardHexCfg) do
				if iter_7_1.id then
					local var_7_1 = ChessBoardGridConfig.New()

					var_7_1.id = iter_7_1.id
					var_7_1.walkable = iter_7_1.walkable
					var_7_1.updatable = iter_7_1.updatable

					table.insert(var_7_0, var_7_1)
				end
			end

			local var_7_2 = {}

			for iter_7_2, iter_7_3 in pairs(ChessBoardThingCfg.all) do
				local var_7_3 = ChessBoardThingCfg[iter_7_3]
				local var_7_4 = ChessBoardThingConfig.New()

				var_7_4.thingID = var_7_3.id
				var_7_4.fixWalkable = var_7_3.fix_walkable
				var_7_4.destoryable = var_7_3.destoryable

				table.insert(var_7_2, var_7_4)
			end

			local var_7_5 = ChessBoardConfigData.New()

			var_7_5.GridConfig = var_7_0
			var_7_5.ThingConfig = var_7_2

			ChessBoardLuaBridge.InitChessBoardConfigData(var_7_5)

			var_0_1 = true
		end
	end,
	StartChanceGame = function(arg_8_0)
		local var_8_0 = ChessBoardChanceCfg[arg_8_0]

		if var_8_0.type == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE then
			WhackMoleAction.LaunchBattle(var_8_0.params[1])
		elseif var_8_0.type == ChessBoardConst.CHANCE_TYPE.BLISTER then
			local var_8_1 = var_8_0.params[1]
			local var_8_2 = ActivityBubbleCfg[var_8_1]

			BlisterGameData:SavePassId(var_8_1)
			BlisterGameAction.PlayGame(var_8_2.map)
		elseif var_8_0.type == ChessBoardConst.CHANCE_TYPE.RHYTHM then
			ActivityRhythmGameTools.StartBattle(nil, var_8_0.params[1], nil, true)
		elseif var_8_0.type == ChessBoardConst.CHANCE_TYPE.QTE then
			JumpTools.OpenPageByJump("/chessBoardQTEGameView")
		elseif var_8_0.type == ChessBoardConst.CHANCE_TYPE.BATTLE then
			local var_8_3 = var_8_0.params[1]
			local var_8_4 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.CHESS_BOARD, var_8_3)

			BattleController.GetInstance():LaunchBattle(var_8_4)
		elseif var_8_0.type == ChessBoardConst.CHANCE_TYPE.DUCK then
			local var_8_5 = var_8_0.params[1]
			local var_8_6 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK, var_8_5, {
				notActivity = true
			})

			BattleController.GetInstance():LaunchBattle(var_8_6)
		elseif var_8_0.type == ChessBoardConst.CHANCE_TYPE.MONSTER_COSPLAY then
			local var_8_7 = var_8_0.params[1]
			local var_8_8 = var_8_0.params[2]
			local var_8_9 = BattleActivityMonsterCosplayCfg[var_8_7]
			local var_8_10 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY, var_8_7, {
				notActivity = true,
				monsterID = var_8_8,
				levelID = var_8_9.level
			})

			BattleController.GetInstance():LaunchBattle(var_8_10)
		elseif var_8_0.type == ChessBoardConst.CHANCE_TYPE.TANGRAM then
			local var_8_11 = var_8_0.params[1]

			JumpTools.OpenPageByJump("/tangramGameStageView", {
				stageID = var_8_11
			})
		end
	end,
	OpenChanceView = function(arg_9_0, arg_9_1)
		local var_9_0 = ChessBoardChanceCfg[arg_9_0]

		if var_9_0.type == ChessBoardConst.CHANCE_TYPE.SHOP then
			JumpTools.OpenPageByJump("/chessBoardShopView")
		elseif var_9_0.type == ChessBoardConst.CHANCE_TYPE.PROP then
			if arg_9_1 then
				gameContext:Go("/chessBoardHomeView")
			end

			manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.EVENT_TIPS, {
				callback = function()
					manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HAPPY)

					local var_10_0 = manager.ChessBoardManager:GetCurChanceInfo().chancePropList

					for iter_10_0, iter_10_1 in pairs(var_10_0 or {}) do
						ChessBoardData:FixHeroTmpAddProp(iter_10_1)
					end

					ChessBoardAction.FinishChance(arg_9_0, 0, 0)
				end,
				eventType = ChessBoardConst.EVENT_TIPS_TYPE.PROP
			})
		elseif var_9_0.type == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or var_9_0.type == ChessBoardConst.CHANCE_TYPE.BLISTER or var_9_0.type == ChessBoardConst.CHANCE_TYPE.RHYTHM or var_9_0.type == ChessBoardConst.CHANCE_TYPE.BATTLE or var_9_0.type == ChessBoardConst.CHANCE_TYPE.DUCK or var_9_0.type == ChessBoardConst.CHANCE_TYPE.MONSTER_COSPLAY or var_9_0.type == ChessBoardConst.CHANCE_TYPE.TANGRAM then
			JumpTools.OpenPageByJump("/chessBoardBattleChanceView", {
				chanceID = arg_9_0
			})
		elseif var_9_0.type == ChessBoardConst.CHANCE_TYPE.QTE then
			manager.ChessBoardManager:BattleStart(arg_9_0)
			ChessBoardTools.StartChanceGame(arg_9_0)
		elseif var_9_0.type == ChessBoardConst.CHANCE_TYPE.TELEPORT then
			JumpTools.OpenPageByJump("/chessBoardChanceView")
		elseif var_9_0.type == ChessBoardConst.CHANCE_TYPE.RANDON then
			if arg_9_1 then
				gameContext:Go("/chessBoardHomeView")
			end

			manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.EVENT_TIPS, {
				callback = function()
					JumpTools.OpenPageByJump("/chessBoardChanceView")
				end,
				eventType = ChessBoardConst.EVENT_TIPS_TYPE.RANDOM
			})
		elseif var_9_0.type == ChessBoardConst.CHANCE_TYPE.TARGET then
			if arg_9_1 then
				gameContext:Go("/chessBoardHomeView")
			end

			ChessBoardAction.FinishChance(arg_9_0, 0, 0)
		elseif var_9_0.type == ChessBoardConst.CHANCE_TYPE.ARENA then
			if arg_9_1 then
				gameContext:Go("/chessBoardHomeView")
			end

			manager.ChessBoardManager:StartArenaChance()
		end
	end,
	PropChance = function(arg_12_0)
		local var_12_0 = manager.ChessBoardManager:GetCurChanceInfo()
		local var_12_1 = var_12_0.chanceID
		local var_12_2 = ChessBoardChanceCfg[var_12_1].type
		local var_12_3 = {}
		local var_12_4 = 0

		if var_12_2 == ChessBoardConst.CHANCE_TYPE.QTE then
			var_12_4 = manager.ChessBoardManager.battlePoint_

			local var_12_5 = ChessBoardChanceCfg[var_12_1].params[2]
			local var_12_6 = 0

			for iter_12_0, iter_12_1 in pairs(var_12_5 or {}) do
				if iter_12_1[1] == var_12_4 then
					var_12_6 = iter_12_1[2]

					break
				end
			end

			for iter_12_2 = 1, var_12_6 do
				if var_12_0.chancePropList[iter_12_2] then
					table.insert(var_12_3, var_12_0.chancePropList[iter_12_2])
				end
			end
		else
			var_12_3 = var_12_0.chancePropList
		end

		arg_12_0 = arg_12_0 or 1

		if var_12_3[arg_12_0] then
			ChessBoardTools.RealyPropChance(var_12_3[arg_12_0], var_12_1, arg_12_0)
		else
			ChessBoardAction.FinishChance(var_12_1, 0, var_12_4)
		end
	end,
	RealyPropChance = function(arg_13_0, arg_13_1, arg_13_2)
		if #manager.ChessBoardManager:GetHeroProp() >= 6 then
			JumpTools.OpenPageByJump("/ChessBoardPropView", {
				propID = arg_13_0,
				viewType = ChessBoardConst.VIEW_TYPE.CHANGE_PROP,
				changePropCallback = function(arg_14_0)
					ChessBoardTools.SendPropChance(arg_13_0, arg_13_1, arg_13_2, arg_14_0)
				end,
				giveUpPropCallback = function()
					ChessBoardAction.GiveUpProp(arg_13_0)
					gameContext:Go("/chessBoardHomeView")
					ChessBoardTools.PropChance(arg_13_2 + 1)
				end
			})
		else
			ChessBoardTools.SendPropChance(arg_13_0, arg_13_1, arg_13_2)
		end
	end,
	SendPropChance = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		gameContext:Go("/chessBoardHomeView")
		manager.ChessBoardManager:AddTmpHeroProp(arg_16_0, arg_16_3)

		if arg_16_4 then
			arg_16_4()
		end

		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.GET_PROP, {
			isGet = true,
			propID = arg_16_0,
			callback = function()
				ChessBoardTools.PropChance(arg_16_2 + 1)
			end
		})
	end,
	GetChanceImage = function(arg_18_0)
		return pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_Eventicon/" .. arg_18_0)
	end,
	GetPropImage = function(arg_19_0)
		return getSprite("Atlas/ChessBoardPropIconAtlas", arg_19_0)
	end,
	GetBuffImage = function(arg_20_0)
		local var_20_0 = ChessBoardBuffPoolCfg[arg_20_0]

		return pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_Buff/" .. var_20_0.icon)
	end,
	CSharpMapIndexToXZ = function(arg_21_0, arg_21_1)
		local var_21_0
		local var_21_1
		local var_21_2 = arg_21_0 % arg_21_1
		local var_21_3 = (arg_21_0 - var_21_2) / arg_21_1

		return var_21_2, var_21_3
	end,
	AxialToCubeCoord = function(arg_22_0, arg_22_1)
		return {
			x = -arg_22_0,
			z = arg_22_1,
			y = arg_22_0 - arg_22_1
		}
	end,
	CubeToAxialCoord = function(arg_23_0, arg_23_1, arg_23_2)
		return {
			x = -arg_23_0,
			y = arg_23_2
		}
	end,
	ChessBoardMessageBox = function(arg_24_0)
		ShowMessageBox({
			title = arg_24_0.title,
			content = arg_24_0.content,
			OkCallback = arg_24_0.OkCallback
		})
	end
}
