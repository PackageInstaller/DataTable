local cjson = require("cjson")
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
		return (cjson.decode((AssetEx.LoadText("Map/ChessBoard/JsonMap/" .. arg_2_0 .. ".json"))))
	end,
	CreateChessBoardLuaGridData = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = {
			thingtag = 0,
			tag = 0,
			pos = {
				x = arg_3_0,
				z = arg_3_1
			}
		}

		var_3_0.rotationY = (arg_3_2[arg_3_3].rotationY or 0) / 60
		var_3_0.status = arg_3_2[arg_3_3].status
		var_3_0.thingRotationY = (arg_3_2[arg_3_3].thingRotationY or 0) / 60

		return var_3_0
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
			OpenPageUntilLoaded(ChessBoardData:GetTemporaryData("url"), (ChessBoardData:GetTemporaryData("urlParams")))
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
				local var_7_3 = ChessBoardThingConfig.New()

				var_7_3.thingID = ChessBoardThingCfg[iter_7_3].id
				var_7_3.fixWalkable = ChessBoardThingCfg[iter_7_3].fix_walkable
				var_7_3.destoryable = ChessBoardThingCfg[iter_7_3].destoryable

				table.insert(var_7_2, var_7_3)
			end

			local var_7_4 = ChessBoardConfigData.New()

			var_7_4.GridConfig = var_7_0
			var_7_4.ThingConfig = var_7_2

			ChessBoardLuaBridge.InitChessBoardConfigData(var_7_4)

			var_0_1 = true
		end
	end,
	StartChanceGame = function(arg_8_0)
		if ChessBoardChanceCfg[arg_8_0].type == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE then
			WhackMoleAction.LaunchBattle(ChessBoardChanceCfg[arg_8_0].params[1])
		elseif ChessBoardChanceCfg[arg_8_0].type == ChessBoardConst.CHANCE_TYPE.BLISTER then
			BlisterGameData:SavePassId(ChessBoardChanceCfg[arg_8_0].params[1])
			BlisterGameAction.PlayGame(ActivityBubbleCfg[ChessBoardChanceCfg[arg_8_0].params[1]].map)
		elseif ChessBoardChanceCfg[arg_8_0].type == ChessBoardConst.CHANCE_TYPE.RHYTHM then
			ActivityRhythmGameTools.StartBattle(nil, ChessBoardChanceCfg[arg_8_0].params[1], nil, true)
		elseif ChessBoardChanceCfg[arg_8_0].type == ChessBoardConst.CHANCE_TYPE.QTE then
			JumpTools.OpenPageByJump("/chessBoardQTEGameView")
		elseif ChessBoardChanceCfg[arg_8_0].type == ChessBoardConst.CHANCE_TYPE.BATTLE then
			BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.CHESS_BOARD, ChessBoardChanceCfg[arg_8_0].params[1])))
		elseif ChessBoardChanceCfg[arg_8_0].type == ChessBoardConst.CHANCE_TYPE.DUCK then
			BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK, ChessBoardChanceCfg[arg_8_0].params[1], {
				notActivity = true
			})))
		elseif ChessBoardChanceCfg[arg_8_0].type == ChessBoardConst.CHANCE_TYPE.MONSTER_COSPLAY then
			BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY, ChessBoardChanceCfg[arg_8_0].params[1], {
				notActivity = true,
				monsterID = ChessBoardChanceCfg[arg_8_0].params[2],
				levelID = BattleActivityMonsterCosplayCfg[ChessBoardChanceCfg[arg_8_0].params[1]].level
			})))
		elseif ChessBoardChanceCfg[arg_8_0].type == ChessBoardConst.CHANCE_TYPE.TANGRAM then
			JumpTools.OpenPageByJump("/tangramGameStageView", {
				stageID = ChessBoardChanceCfg[arg_8_0].params[1]
			})
		end
	end,
	OpenChanceView = function(arg_9_0, arg_9_1)
		if ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.SHOP then
			JumpTools.OpenPageByJump("/chessBoardShopView")
		elseif ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.PROP then
			if arg_9_1 then
				gameContext:Go("/chessBoardHomeView")
			end

			manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.EVENT_TIPS, {
				callback = function()
					manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HAPPY)

					for iter_10_0, iter_10_1 in pairs(manager.ChessBoardManager:GetCurChanceInfo().chancePropList or {}) do
						ChessBoardData:FixHeroTmpAddProp(iter_10_1)
					end

					ChessBoardAction.FinishChance(arg_9_0, 0, 0)
				end,
				eventType = ChessBoardConst.EVENT_TIPS_TYPE.PROP
			})
		elseif ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.BLISTER or ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.RHYTHM or ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.BATTLE or ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.DUCK or ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.MONSTER_COSPLAY or ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.TANGRAM then
			JumpTools.OpenPageByJump("/chessBoardBattleChanceView", {
				chanceID = arg_9_0
			})
		elseif ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.QTE then
			manager.ChessBoardManager:BattleStart(arg_9_0)
			ChessBoardTools.StartChanceGame(arg_9_0)
		elseif ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.TELEPORT then
			JumpTools.OpenPageByJump("/chessBoardChanceView")
		elseif ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.RANDON then
			if arg_9_1 then
				gameContext:Go("/chessBoardHomeView")
			end

			manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.EVENT_TIPS, {
				callback = function()
					JumpTools.OpenPageByJump("/chessBoardChanceView")
				end,
				eventType = ChessBoardConst.EVENT_TIPS_TYPE.RANDOM
			})
		elseif ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.TARGET then
			if arg_9_1 then
				gameContext:Go("/chessBoardHomeView")
			end

			ChessBoardAction.FinishChance(arg_9_0, 0, 0)
		elseif ChessBoardChanceCfg[arg_9_0].type == ChessBoardConst.CHANCE_TYPE.ARENA then
			if arg_9_1 then
				gameContext:Go("/chessBoardHomeView")
			end

			manager.ChessBoardManager:StartArenaChance()
		end
	end,
	PropChance = function(arg_12_0)
		local var_12_0 = manager.ChessBoardManager:GetCurChanceInfo()
		local var_12_1 = var_12_0.chanceID
		local var_12_2 = {}
		local var_12_3 = 0

		if ChessBoardChanceCfg[var_12_0.chanceID].type == ChessBoardConst.CHANCE_TYPE.QTE then
			var_12_3 = manager.ChessBoardManager.battlePoint_

			local var_12_4 = 0

			for iter_12_0, iter_12_1 in pairs(ChessBoardChanceCfg[var_12_1].params[2] or {}) do
				if iter_12_1[1] == var_12_3 then
					var_12_4 = iter_12_1[2]

					break
				end
			end

			for iter_12_2 = 1, var_12_4 do
				if var_12_0.chancePropList[iter_12_2] then
					table.insert(var_12_2, var_12_0.chancePropList[iter_12_2])
				end
			end
		else
			var_12_2 = var_12_0.chancePropList
		end

		arg_12_0 = arg_12_0 or 1

		if var_12_2[arg_12_0] then
			ChessBoardTools.RealyPropChance(var_12_2[arg_12_0], var_12_1, arg_12_0)
		else
			ChessBoardAction.FinishChance(var_12_1, 0, var_12_3)
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
		return pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_Buff/" .. ChessBoardBuffPoolCfg[arg_20_0].icon)
	end,
	CSharpMapIndexToXZ = function(arg_21_0, arg_21_1)
		return arg_21_0 % arg_21_1, (arg_21_0 - arg_21_0 % arg_21_1) / arg_21_1
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
	ChessBoardMessageBox = function(self)
		ShowMessageBox({
			title = self.title,
			content = self.content,
			OkCallback = self.OkCallback
		})
	end
}
