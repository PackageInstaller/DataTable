return {
	{
		function()
			manager.ChessManager:ExecuteMove()
		end
	},
	{
		function(arg_2_0)
			manager.ChessManager:SetInteractChess(arg_2_0)
			manager.ChessManager:ExecuteMove()
		end
	},
	{
		function(arg_3_0, arg_3_1, arg_3_2)
			local var_3_0 = arg_3_2 and "cantReach" or "btn"
			local var_3_1 = arg_3_0

			TimeTools.StartAfterSeconds(0.1, function()
				gameContext:Go("/chessMessageBtn", {
					logId = arg_3_1,
					style = var_3_0,
					checkCallBack = function()
						manager.ChessManager:SetInteractChess(var_3_1)
						manager.ChessManager:ExecuteMove()
					end,
					cancelCallBack = function()
						manager.ChessManager:SetGridSelectOutline(nil, nil, false)
					end
				})
			end, {})
		end
	},
	{
		function(arg_7_0, arg_7_1, arg_7_2)
			local var_7_0 = arg_7_0

			TimeTools.StartAfterSeconds(0.1, function()
				gameContext:Go("/chessMessageBtn", {
					style = "no",
					logId = arg_7_1,
					checkCallBack = function()
						return
					end,
					cancelCallBack = function()
						if arg_7_2 then
							ShowTips("CANNOT_GO")
						else
							manager.ChessManager:SetInteractChess(var_7_0)
							manager.ChessManager:ExecuteMove()
						end
					end
				})
			end, {})
		end
	},
	[10000] = {
		[9] = function()
			return manager.ChessManager:DoNextEvent()
		end
	},
	[10101] = {
		[9] = function(arg_12_0)
			local var_12_0 = manager.ChessManager:GetExecutingChess()
			local var_12_1 = WarChessData:GetGridLua(var_12_0.x, var_12_0.z)

			WarChessAction.AddLog(var_12_0.x, var_12_0.z, (var_12_1 or nil) and (var_12_1.tag or 0), arg_12_0)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10102] = {
		function(arg_13_0)
			return
		end,
		GLOBAL = function(arg_14_0)
			return
		end
	},
	[10103] = {
		[9] = function(arg_15_0)
			manager.story:StartChessStoryLine(arg_15_0, function(arg_16_0)
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10104] = {
		[9] = function(arg_17_0)
			local var_17_0 = {}
			local var_17_1 = arg_17_0

			function var_17_0.checkEnd()
				if var_17_1 == 0 then
					var_17_0 = nil

					return manager.ChessManager:DoNextEvent()
				else
					var_17_0.showMessage()
				end
			end

			function var_17_0.showMessage()
				gameContext:Go("/chessMessageBtn", {
					style = "no",
					logId = var_17_1,
					checkCallBack = function()
						return
					end,
					cancelCallBack = function()
						var_17_0.checkEnd()
					end
				})

				var_17_1 = WarchessContentCfg[var_17_1].next
			end

			var_17_0.showMessage()
		end
	},
	[10105] = {
		[9] = function(arg_22_0)
			JumpTools.OpenPageByJump("/chessLetter", {
				ID = arg_22_0,
				callBack = function()
					return manager.ChessManager:DoNextEvent()
				end
			})
		end
	},
	[10106] = {
		[9] = function(arg_24_0)
			local var_24_0 = manager.ChessManager:GetExecutingChess()
			local var_24_1 = WarChessData:GetGridLua(var_24_0.x, var_24_0.z)

			if WarChessData:IsEventExecute(10106, var_24_0.x, var_24_0.z, var_24_1.tag) then
				return manager.ChessManager:DoNextEvent()
			else
				manager.story:StartChessStoryLine(arg_24_0, function(arg_25_0)
					WarChessData:SetEventExecute(10106, var_24_0.x, var_24_0.z, var_24_1.tag)

					return manager.ChessManager:DoNextEvent()
				end)
			end
		end
	},
	[10107] = {
		[9] = function(arg_26_0)
			manager.story:StartChessStoryWithBackground(arg_26_0, function(arg_27_0)
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10108] = {
		[9] = function(arg_28_0)
			gameContext:Go("chessMenu", {
				callback = function()
					return manager.ChessManager:DoNextEvent()
				end
			})
		end
	},
	[10201] = {
		[9] = function(arg_30_0, arg_30_1)
			if not BattleChessStageCfg[arg_30_0] then
				-- block empty
			end

			if arg_30_1[1] == 0 then
				WarChessData:SetTemporaryData("battle" .. manager.story.BEFORE, nil)
			else
				WarChessData:SetTemporaryData("battle" .. manager.story.BEFORE, arg_30_1[1])
			end

			if arg_30_1[2] == 0 then
				WarChessData:SetTemporaryData("battle" .. manager.story.WIN, nil)
			else
				WarChessData:SetTemporaryData("battle" .. manager.story.WIN, arg_30_1[2])
			end

			local var_30_0 = manager.ChessManager:GetExecutingChess()
			local var_30_1 = WarChessData:GetGridLua(var_30_0.x, var_30_0.z)

			if var_30_1 then
				if WarChessData:GetBattleIsFinish(var_30_0.x, var_30_0.z, var_30_1.tag or 0) then
					gameContext:Go("/chessBattlePop", {
						content = GetTips("SKIP_BATTLE_2"),
						OkCallback = function()
							WarChessAction.SkipBattle({
								x = var_30_0.x,
								z = var_30_0.z
							})
							manager.ChessManager:ExecutingCreatedChess(ChessConst.EVENT.AFTER_BATTLE)
							manager.ChessManager:DoNextEvent()
						end,
						CancelCallback = function()
							manager.ChessManager:BattleStart()
							gameContext:Go("/sectionSelectHero", {
								section = arg_30_0,
								sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS,
								activityID = WarChessData:GetCurrentActivity(),
								customBarList = {
									BACK_BAR
								}
							})
						end,
						MaskCallback = function()
							manager.ChessManager:EventsEnd()
						end
					})

					goto label_30_0
				end
			end

			manager.ChessManager:BattleStart()
			gameContext:Go("/sectionSelectHero", {
				section = arg_30_0,
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS,
				activityID = WarChessData:GetCurrentActivity(),
				customBarList = {
					BACK_BAR
				}
			})

			::label_30_0::
		end
	},
	[10202] = {
		[9] = function()
			local var_34_0 = WarChessData:GetTemporaryData(ChessConst.TEMPORARY_KEY.TREASURE)

			if not var_34_0 then
				manager.net:RegistPushWaiting(49011, function()
					JumpTools.OpenPageByJump("chessChoose", {
						state = WarChessData:GetTemporaryData(ChessConst.TEMPORARY_KEY.TREASURE)
					})
				end)
			else
				JumpTools.OpenPageByJump("chessChoose", {
					state = var_34_0
				})
			end
		end
	},
	[10203] = {
		[9] = function(arg_36_0)
			local var_36_0 = manager.ChessManager:GetExecutingChess()

			if WarChessData:IsEventExecute(ChessConst.BOX.SMALL, var_36_0.x, var_36_0.z, WarChessData:GetGridLua(var_36_0.x, var_36_0.z).tag) then
				ShowTips("ERROR_CHESS_REWARD_HAS_RECEIVED")

				return manager.ChessManager:DoNextEvent()
			end

			getReward(getRewardFromDropCfg(arg_36_0, true), nil, function()
				WarChessData:AddBoxNum(WarChessData:GetCurrentWarChessMapData().mapId, ChessConst.BOX.SMALL)

				return manager.ChessManager:DoNextEvent()
			end, false)
		end
	},
	[10204] = {
		[9] = function(arg_38_0)
			local var_38_0 = manager.ChessManager:GetExecutingChess()

			if WarChessData:IsEventExecute(ChessConst.BOX.BIG, var_38_0.x, var_38_0.z, WarChessData:GetGridLua(var_38_0.x, var_38_0.z).tag) then
				ShowTips("ERROR_CHESS_REWARD_HAS_RECEIVED")

				return manager.ChessManager:DoNextEvent()
			end

			getReward(getRewardFromDropCfg(arg_38_0, true), nil, function()
				WarChessData:AddBoxNum(WarChessData:GetCurrentWarChessMapData().mapId, ChessConst.BOX.BIG)

				return manager.ChessManager:DoNextEvent()
			end, false)
		end
	},
	[10301] = {
		[9] = function(arg_40_0)
			local var_40_0 = manager.ChessManager:GetExecutingChess()

			manager.ChessManager:ChangeGridByIndex(var_40_0.x, var_40_0.z, arg_40_0, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10302] = {
		[9] = function(arg_42_0, arg_42_1, arg_42_2)
			manager.ChessManager:ChangeGridByIndex(arg_42_0, arg_42_1, arg_42_2, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10303] = {
		[9] = function(arg_44_0)
			local var_44_0 = manager.ChessManager:GetExecutingChess()

			manager.ChessManager:ChangeGridStatus(var_44_0.x, var_44_0.z, ChessTools.GetExtendID(arg_44_0, ChessLuaBridge.GetGridData(var_44_0.x, var_44_0.z).status), function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10304] = {
		[9] = function(arg_46_0, arg_46_1, arg_46_2)
			manager.ChessManager:ChangeGridStatus(arg_46_0, arg_46_1, ChessTools.GetExtendID(arg_46_2, ChessLuaBridge.GetGridData(arg_46_0, arg_46_1).status), function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10305] = {
		[9] = function(arg_48_0, arg_48_1)
			local var_48_0 = manager.ChessManager:GetExecutingChess()

			manager.ChessManager:ChangeGridDirection(var_48_0.x, var_48_0.z, arg_48_0, arg_48_1, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10306] = {
		[9] = function(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
			local var_50_0 = ChessLuaBridge.GetGridData(arg_50_0, arg_50_1)

			if var_50_0.typeID == 20110 or var_50_0.typeID == 20111 then
				manager.audio:PlayEffect("se_story_activity_2_1_4", "se_story_activity_2_1_4_warchess_pipe_move", "")
			end

			manager.ChessManager:ChangeGridDirection(arg_50_0, arg_50_1, arg_50_2, arg_50_3, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10307] = {
		[9] = function(arg_52_0)
			local var_52_0 = manager.ChessManager:GetExecutingChess()

			manager.ChessManager:PlayGridAnimation(var_52_0.x, var_52_0.z, arg_52_0, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10308] = {
		[9] = function(arg_54_0)
			local var_54_0 = manager.ChessManager:GetExecutingChess()
			local var_54_1 = ChessTools.GetExtendID(arg_54_0, ChessLuaBridge.GetGridData(var_54_0.x, var_54_0.z).status)

			ChessLuaBridge.ChangeGridStatus(var_54_0.x, var_54_0.z, var_54_1)
			WarChessData:ChangeGridStatusLua(var_54_0.x, var_54_0.z, var_54_1)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10309] = {
		[9] = function(arg_55_0, arg_55_1, arg_55_2)
			local var_55_0 = ChessTools.GetExtendID(arg_55_2, ChessLuaBridge.GetGridData(arg_55_0, arg_55_1).status)

			ChessLuaBridge.ChangeGridStatus(arg_55_0, arg_55_1, var_55_0)
			WarChessData:ChangeGridStatusLua(arg_55_0, arg_55_1, var_55_0)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10401] = {
		[9] = function(arg_56_0)
			WarChessAction.AddAllHp(arg_56_0 * 100)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10402] = {
		[2] = function(arg_57_0)
			manager.ChessManager:StopMove()
			WarChessAction.AddAllHp(-arg_57_0 * 100)

			return manager.ChessManager:DoNextEvent()
		end,
		[9] = function(arg_58_0)
			WarChessAction.AddAllHp(-arg_58_0 * 100)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10403] = {
		[9] = function(arg_59_0, arg_59_1)
			ChessLuaBridge.LookAtPlayer()
			ChessLuaBridge.TelePortRoleToPosition(arg_59_0, arg_59_1)
			manager.ChessManager:StopMove()

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10404] = {
		[9] = function()
			local var_60_0 = manager.ChessManager:GetExecutingChess()
			local var_60_1 = {}

			for iter_60_0, iter_60_1 in pairs((WarChessData:GetHeroList())) do
				if iter_60_1 <= 0 then
					table.insert(var_60_1, iter_60_0)
				end
			end

			if #var_60_1 > 0 then
				gameContext:Go("chessRevive", {
					x = var_60_0.x,
					z = var_60_0.z,
					callback = function()
						return manager.ChessManager:DoNextEvent()
					end
				})
			else
				manager.ChessManager:EventsEnd()
			end
		end
	},
	[10501] = {
		[9] = function(arg_62_0, arg_62_1)
			WarChessData:ModifyItemData(arg_62_0, arg_62_1)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10502] = {
		[9] = function(arg_63_0, arg_63_1, arg_63_2)
			local var_63_0 = WarChessData:GetItemData()[arg_63_0]

			if var_63_0 and arg_63_1 <= var_63_0 then
				WarChessData:ModifyItemData(arg_63_0, -arg_63_1)

				local var_63_1 = manager.ChessManager:GetExecutingChess()

				manager.ChessManager:ChangeGridStatus(var_63_1.x, var_63_1.z, arg_63_2, function()
					return manager.ChessManager:DoNextEvent()
				end)
			else
				return manager.ChessManager:EventsEnd()
			end
		end
	},
	[10901] = {
		[9] = function(arg_65_0, arg_65_1)
			local var_65_0 = manager.ChessManager:GetExecutingChess()

			if arg_65_0 >= WarChessData:GetGridAttribute(var_65_0.x, var_65_0.z)[1] then
				manager.ChessManager:ChangeGridByIndex(var_65_0.x, var_65_0.z, arg_65_1, function()
					return manager.ChessManager:DoNextEvent()
				end)
			else
				return manager.ChessManager:EventsEnd()
			end
		end,
		AFTER_BATTLE = function(arg_67_0, arg_67_1, arg_67_2)
			local var_67_0 = WarChessData:GetGridAttribute(arg_67_1.x, arg_67_1.z)

			var_67_0[1] = (var_67_0[1] or 0) + 1
		end
	},
	[10902] = {
		[9] = function(arg_68_0)
			local var_68_0 = WarChessData:GetGlobalEventByType(8)

			if not var_68_0 or table.length(var_68_0) <= 0 then
				return manager.ChessManager:DoNextEvent()
			end

			for iter_68_0, iter_68_1 in pairs(var_68_0) do
				iter_68_1 = iter_68_1 + arg_68_0

				WarChessData:SetGlobalEventProgress(ChessConst.GLOBAL.TALLY, iter_68_0, iter_68_1)
			end

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10601] = {
		[9] = function(arg_69_0)
			local var_69_0 = manager.ChessManager:GetExecutingChess().status

			for iter_69_0, iter_69_1 in ipairs(arg_69_0) do
				if var_69_0 == iter_69_1[1] then
					manager.ChessManager:InsertEventQueue((ChessTools.ParseEventPollCfg(iter_69_1[2])))

					return manager.ChessManager:DoNextEvent()
				end
			end
		end
	},
	[10602] = {
		[9] = function(arg_70_0)
			local var_70_0 = manager.ChessManager:GetExecutingChess()
			local var_70_1 = {}

			arg_70_0 = ChessTools.ParseEventPollCfg(arg_70_0)

			for iter_70_0 = 1, #arg_70_0 do
				if arg_70_0[iter_70_0].eventID == 10304 then
					local var_70_2, var_70_3, var_70_4 = unpack(arg_70_0[iter_70_0].params)
					local var_70_5 = ChessTools.GetExtendID(var_70_4, ChessLuaBridge.GetGridData(var_70_2, var_70_3).status)

					WarChessData:ChangeGridStatusLua(var_70_2, var_70_3, var_70_5)
					table.insert(var_70_1, {
						style = 1,
						x = var_70_2,
						z = var_70_3,
						param = var_70_5
					})
				elseif arg_70_0[iter_70_0].eventID == 10303 then
					local var_70_6 = ChessTools.GetExtendID(unpack(arg_70_0[iter_70_0].params), ChessLuaBridge.GetGridData(var_70_0.x, var_70_0.z).status)

					WarChessData:ChangeGridStatusLua(var_70_0.x, var_70_0.z, var_70_6)
					table.insert(var_70_1, {
						style = 1,
						x = var_70_0.x,
						z = var_70_0.z,
						param = var_70_6
					})
				elseif arg_70_0[iter_70_0].eventID == 10302 then
					local var_70_7, var_70_8, var_70_9 = unpack(arg_70_0[iter_70_0].params)

					WarChessData:ChangeGridLua(var_70_7, var_70_8, var_70_9)
					table.insert(var_70_1, {
						style = 2,
						x = var_70_7,
						z = var_70_8,
						param = var_70_9
					})
				elseif arg_70_0[iter_70_0].eventID == 10301 then
					local var_70_10 = unpack(arg_70_0[iter_70_0].params)

					WarChessData:ChangeGridLua(var_70_0.x, var_70_0.z, var_70_10)
					table.insert(var_70_1, {
						style = 2,
						x = var_70_0.x,
						z = var_70_0.z,
						param = var_70_10
					})
				elseif arg_70_0[iter_70_0].eventID == 10305 then
					local var_70_11 = manager.ChessManager:GetExecutingChess()
					local var_70_12, var_70_13 = unpack(arg_70_0[iter_70_0].params)

					WarChessData:ChangeGridDirection(var_70_11.x, var_70_11.z, var_70_12)
					table.insert(var_70_1, {
						style = 3,
						x = var_70_11.x,
						z = var_70_11.z,
						param = {
							var_70_12,
							var_70_13
						}
					})
				elseif arg_70_0[iter_70_0].eventID == 10306 then
					local var_70_14, var_70_15, var_70_16, var_70_17 = unpack(arg_70_0[iter_70_0].params)

					WarChessData:ChangeGridDirection(var_70_14, var_70_15, var_70_16)
					table.insert(var_70_1, {
						style = 3,
						x = var_70_14,
						z = var_70_15,
						param = {
							var_70_16,
							var_70_17
						}
					})
				end

				if not var_70_1[iter_70_0].extentID then
					print("错误的extentID" .. var_70_1[iter_70_0].x, var_70_1[iter_70_0].z)
				end
			end

			manager.ChessManager:ChangeGridByList(var_70_1, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10603] = {
		[9] = function(arg_72_0, arg_72_1, arg_72_2)
			local var_72_0 = ChessLuaBridge.GetGridData(arg_72_0, arg_72_1).status

			for iter_72_0, iter_72_1 in ipairs(arg_72_2) do
				if var_72_0 == iter_72_1[1] then
					manager.ChessManager:InsertEventQueue((ChessTools.ParseEventPollCfg(iter_72_1[2])))

					return manager.ChessManager:DoNextEvent()
				end
			end
		end
	},
	[10701] = {
		[9] = function(arg_73_0, arg_73_1)
			manager.ChessManager:MoveToTarget(arg_73_0, arg_73_1, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10702] = {
		[9] = function()
			manager.ChessManager:LookAtPlayer(function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10703] = {
		[9] = function(arg_77_0, arg_77_1, arg_77_2)
			manager.ChessManager:LookForSeconds(arg_77_0, arg_77_1, arg_77_2, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10801] = {
		[9] = function(arg_79_0)
			ChessTools.DoSpecialEvent(arg_79_0)
		end
	},
	[11001] = {
		[9] = function(arg_80_0, arg_80_1)
			if WarChessData:GetButterFlyPos() then
				ChessLuaBridge.MoveGuider(arg_80_0, arg_80_1)
			else
				ChessLuaBridge.InitGuider(WarChessTools.GetGuiderAssetPath(WarChessData:GetCurrentWarChessMapData().mapId), arg_80_0, arg_80_1)
			end

			WarChessData:SetButterFlyPos({
				arg_80_0,
				arg_80_1
			})

			return manager.ChessManager:DoNextEvent()
		end
	},
	[11002] = {
		[9] = function(arg_81_0)
			if not WarChessData:GetButterFlyPos() then
				return manager.ChessManager:DoNextEvent()
			end

			local var_81_0 = {}
			local var_81_1 = {}

			for iter_81_0, iter_81_1 in ipairs(arg_81_0) do
				if math.fmod(iter_81_0, 2) == 0 then
					table.insert(var_81_1, iter_81_1)
				else
					table.insert(var_81_0, iter_81_1)
				end
			end

			if #var_81_0 ~= #var_81_1 then
				-- block empty
			end

			ChessLuaBridge.MoveGuiderAlongPath(var_81_0, var_81_1)
			WarChessData:SetButterFlyPos({
				var_81_0[#var_81_0],
				var_81_1[#var_81_1]
			})

			return manager.ChessManager:DoNextEvent()
		end
	},
	[11003] = {
		[9] = function(arg_82_0)
			local var_82_0 = manager.ChessManager:GetExecutingChess()
			local var_82_1 = WarChessData:GetGridDirection(var_82_0.x, var_82_0.z)
			local var_82_2 = math.fmod(manager.ChessManager:GetBulletDirection() + var_82_1, 6)
			local var_82_3

			if var_82_2 < 0 and not (var_82_2 + 6) then
				var_82_3 = math.max(arg_82_0[1], arg_82_0[2])
			end

			local var_82_4 = math.min(arg_82_0[1], arg_82_0[2])

			if var_82_4 >= 0 and var_82_4 <= 5 and var_82_3 >= 0 and var_82_3 > 5 then
				-- block empty
			end

			local var_82_5 = math.abs(var_82_4 - var_82_3)
			local var_82_6
			local var_82_7

			if var_82_5 == 1 then
				var_82_6 = var_82_4
				var_82_7 = var_82_3
			elseif var_82_5 == 4 then
				var_82_6 = var_82_3
				var_82_7 = var_82_4
			end

			local function var_82_8(arg_83_0)
				if arg_83_0 == var_82_6 then
					return "0"
				elseif arg_83_0 == var_82_7 then
					return "1"
				end
			end

			if var_82_2 == var_82_4 then
				local var_82_9 = math.fmod(var_82_3 - var_82_1, 6)

				var_82_9 = var_82_9 < 0 and var_82_9 + 6 or var_82_9

				manager.ChessManager:BulletContinue()
				manager.ChessManager:DoNextEvent()
				ChessLuaBridge.PlayGridAnimation(var_82_0.x, var_82_0.z, var_82_8(var_82_2), function()
					ChessLuaBridge.FireBullet(var_82_0.x, var_82_0.z, math.fmod(var_82_9, 6))
				end)

				return
			end

			if var_82_2 == var_82_3 then
				local var_82_10 = math.fmod(var_82_4 - var_82_1, 6)

				var_82_10 = var_82_10 < 0 and var_82_10 + 6 or var_82_10

				manager.ChessManager:BulletContinue()
				manager.ChessManager:DoNextEvent()
				ChessLuaBridge.PlayGridAnimation(var_82_0.x, var_82_0.z, var_82_8(var_82_2), function()
					ChessLuaBridge.FireBullet(var_82_0.x, var_82_0.z, var_82_10)
				end)

				return
			end

			manager.ChessManager:DoNextEvent()
		end
	},
	[10205] = {
		[2] = function(arg_86_0)
			manager.ChessManager:StopMove()
			gameContext:Go("/chessDebuffPop", {
				data = arg_86_0
			})
			WarChessData:ModifyArtifactData(arg_86_0, 1)
		end,
		[9] = function(arg_87_0)
			gameContext:Go("/chessDebuffPop", {
				data = arg_87_0
			})
			WarChessData:ModifyArtifactData(arg_87_0, 1)
		end
	},
	[10206] = {
		[9] = function()
			JumpTools.OpenPageByJump("chessPurify")
		end
	},
	[10207] = {
		[9] = function(arg_89_0, arg_89_1, arg_89_2)
			local function var_89_0()
				manager.ChessManager:BattleStart(arg_89_0)

				local var_90_0 = manager.ChessManager:GetExecutingChess()

				gameContext:Go("/chessMutiView", {
					times = arg_89_0,
					battleList = arg_89_1,
					activityID = WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].type,
					xz = {
						x = var_90_0.x,
						z = var_90_0.z
					},
					typeList = arg_89_2
				})
			end

			local var_89_1 = manager.ChessManager:GetExecutingChess()
			local var_89_2 = WarChessData:GetGridLua(var_89_1.x, var_89_1.z)

			if var_89_2 then
				if WarChessData:GetMutiBattleIsFinish(var_89_1.x, var_89_1.z, var_89_2.tag or 0) then
					gameContext:Go("/chessBattlePop", {
						content = GetTips("SKIP_BATTLE_2"),
						OkCallback = function()
							WarChessAction.SkipBattle({
								x = var_89_1.x,
								z = var_89_1.z
							})
							manager.ChessManager:DoNextEvent()
						end,
						CancelCallback = function()
							var_89_0()
						end,
						MaskCallback = function()
							manager.ChessManager:EventsEnd()
						end
					})

					goto label_89_0
				end
			end

			var_89_0()

			::label_89_0::
		end
	},
	[11004] = {
		[9] = function(arg_94_0)
			local var_94_0 = manager.ChessManager:GetExecutingChess()

			WarChessData:GetGridAttribute(var_94_0.x, var_94_0.z)[1] = arg_94_0

			return manager.ChessManager:DoNextEvent()
		end
	},
	[11005] = {
		[9] = function(arg_95_0, arg_95_1)
			local var_95_0 = manager.ChessManager:GetExecutingChess()

			if arg_95_0 >= (WarChessData:GetGridAttribute(var_95_0.x, var_95_0.z)[1] or 0) then
				manager.ChessManager:ChangeGridStatus(var_95_0.x, var_95_0.z, arg_95_1, function()
					return manager.ChessManager:DoNextEvent()
				end)
			else
				return manager.ChessManager:DoNextEvent()
			end
		end
	},
	[11006] = {
		[9] = function()
			local var_97_0 = manager.ChessManager:GetExecutingChess()
			local var_97_1 = WarChessData:GetGridAttribute(var_97_0.x, var_97_0.z)
			local var_97_2 = math.min(ChessConst.BULLET_MAX - WarChessData:GetBulletNum(), var_97_1[1])

			var_97_1[1] = var_97_1[1] - var_97_2

			WarChessData:ModifyItemData(ChessConst.BULLET, var_97_2)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[12001] = {
		[9] = function()
			manager.ChessManager:ClearGlobalEventByType(ChessConst.GLOBAL.COUNT_STEP)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[12002] = {
		[9] = function()
			manager.ChessManager:ClearGlobalEventByType(ChessConst.GLOBAL.ORDER_EVENT)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[12003] = {
		[9] = function(arg_100_0)
			manager.ChessManager:InsertGlobalEventList(arg_100_0)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[13001] = {
		[9] = function()
			local var_101_0 = manager.ChessManager:GetExecutingChess()
			local var_101_1 = math.fmod(6 - WarChessData:GetGridDirection(var_101_0.x, var_101_0.z), 6)

			if var_101_1 >= 0 and var_101_1 > 5 then
				-- block empty
			end

			if manager.ChessManager.current:IsCurrentPatch() then
				manager.ChessManager.current:SlideByDirection(var_101_1)
			else
				manager.ChessManager:StopMove()
				manager.ChessManager.current:AboutToSlide(var_101_1)
			end

			return manager.ChessManager:DoNextEvent()
		end
	},
	[13002] = {
		[9] = function(arg_102_0)
			ChessLuaBridge.SetChessInputEnable(false)
			manager.ChessManager.forceBattle:ForceEnterBossBattle(arg_102_0)
		end
	},
	[13003] = {
		[9] = function(arg_103_0, arg_103_1)
			local var_103_0 = arg_103_0[1]
			local var_103_1 = arg_103_0[2]
			local var_103_2 = WarChessData:GetBossPos()
			local var_103_3 = WarChessData:GetCurrentIndex()

			if var_103_3.x == arg_103_0[1] and var_103_3.z == var_103_1 then
				for iter_103_0 = 0, 5 do
					local var_103_4, var_103_5 = ChessTools.GetPosViaDir(var_103_0, var_103_1, iter_103_0)
					local var_103_6 = ChessLuaBridge.GetGridData(var_103_4, var_103_5)

					if var_103_6 and WarchessHexCfg[var_103_6.typeID].interact == 0 then
						var_103_1 = var_103_5
						var_103_0 = var_103_4

						break
					end
				end
			end

			if #var_103_2 > 1 then
				manager.ChessManager:ChangeGridByGridData(var_103_2[1], var_103_2[2], ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(var_103_2[1], var_103_2[2]))), function()
					WarChessData:ModifyBossPos(var_103_0, var_103_1)
					manager.ChessManager:ChangeGridByIndex(var_103_0, var_103_1, arg_103_1, function()
						return manager.ChessManager:DoNextEvent()
					end)
				end)
			else
				WarChessData:ModifyBossPos(var_103_0, var_103_1)
				manager.ChessManager:ChangeGridByIndex(var_103_0, var_103_1, arg_103_1, function()
					return manager.ChessManager:DoNextEvent()
				end)
			end
		end
	},
	[13004] = {
		[9] = function()
			local var_107_0 = WarChessData:GetBossPos()

			if #var_107_0 < 1 then
				return manager.ChessManager:DoNextEvent()
			end

			manager.ChessManager:ChangeGridByGridData(var_107_0[1], var_107_0[2], ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(var_107_0[1], var_107_0[2]))), function()
				WarChessData:ModifyBossPos()

				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[13005] = {
		[9] = function()
			manager.ChessManager:StopMove()

			return manager.ChessManager:DoNextEvent()
		end
	},
	[13006] = {
		[2] = function(arg_110_0)
			WarChessAction.CostShipHp(-arg_110_0)
			manager.ChessManager:StopMove()

			local var_110_0 = WarChessData:GetShipHp()

			if var_110_0 and var_110_0 <= 0 then
				manager.ChessManager.current:AboutToDie(1)

				return
			end

			return manager.ChessManager:DoNextEvent()
		end,
		[5] = function(arg_111_0)
			WarChessAction.CostShipHp(-arg_111_0)
			manager.ChessManager:StopMove()

			local var_111_0 = WarChessData:GetShipHp()

			if var_111_0 and var_111_0 <= 0 then
				manager.ChessManager.current:AboutToDie(1)

				return
			end

			return manager.ChessManager:DoNextEvent()
		end,
		[9] = function(arg_112_0)
			WarChessAction.CostShipHp(-arg_112_0)
			manager.ChessManager:StopMove()

			if manager.ChessManager.current:ShipImmediatelyDie() then
				return
			end

			return manager.ChessManager:DoNextEvent()
		end
	},
	[13007] = {
		[9] = function(arg_113_0, arg_113_1, arg_113_2)
			local var_113_0 = WarChessData:GetCurrentIndex()

			for iter_113_0 = -arg_113_1, arg_113_1 do
				for iter_113_1 = math.max(-arg_113_1, iter_113_0 - arg_113_1), math.min(arg_113_1, iter_113_0 + arg_113_1) do
					if WarchessHexCfg[ChessLuaBridge.GetGridData(arg_113_0[1] + iter_113_0, arg_113_0[2] + iter_113_1).typeID].unchanged_hex == 1 then
						if arg_113_2 ~= 0 then
							ChessLuaBridge.ChangeGridByIndex(arg_113_0[1] + iter_113_0, arg_113_0[2] + iter_113_1, arg_113_2)
							WarChessData:ChangeGridLua(arg_113_0[1] + iter_113_0, arg_113_0[2] + iter_113_1, arg_113_2)
						else
							local var_113_1 = WarChessData:GetJsonData(arg_113_0[1] + iter_113_0, arg_113_0[2] + iter_113_1)

							ChessLuaBridge.ChangeGrid(arg_113_0[1] + iter_113_0, arg_113_0[2] + iter_113_1, (ChessTools.CreateChessDataViaJson(var_113_1)))
							WarChessData:ChangeGridLua(arg_113_0[1] + iter_113_0, arg_113_0[2] + iter_113_1, 0)

							if var_113_0.x == arg_113_0[1] + iter_113_0 and var_113_0.z == arg_113_0[2] + iter_113_1 and var_113_1.paramList[1] then
								local var_113_2 = ChessTools.ParseEventPollCfg(WarchessEventPoolCfg[var_113_1.paramList[1]].event_group)

								manager.ChessManager.current:CurrentPatch()
								manager.ChessManager:InsertEventQueue(var_113_2)
							end
						end
					end
				end
			end

			return manager.ChessManager:DoNextEvent()
		end
	},
	[13008] = {
		[9] = function(arg_114_0, arg_114_1, arg_114_2)
			error("未实现13008")

			return manager.ChessManager:DoNextEvent()
		end
	},
	[13009] = {
		[9] = function()
			local var_115_0 = WarChessData:GetBossPos()

			if #var_115_0 <= 0 then
				return manager.ChessManager:DoNextEvent()
			end

			manager.ChessManager:InsertEventQueue((ChessTools.ParseEventPollCfg(WarchessEventPoolCfg[ChessLuaBridge.GetGridData(var_115_0[1], var_115_0[2]).paramList[0]].event_group)))
			manager.ChessManager:StopMove()
			WarChessAction.ForceBattle({
				x = var_115_0[1],
				z = var_115_0[2]
			}, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[13010] = {
		[9] = function()
			manager.ChessManager.current:ChessSuccess()
		end
	},
	[15002] = {
		[9] = function(arg_118_0)
			manager.ChessManager:ClearGlobalEventByType(arg_118_0)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10310] = {
		[9] = function(arg_119_0)
			local var_119_0 = manager.ChessManager:GetExecutingChess()

			manager.ChessManager:ChangeGridByIndexWithOutLook(var_119_0.x, var_119_0.z, arg_119_0, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[10311] = {
		[9] = function(arg_121_0, arg_121_1, arg_121_2)
			ChessLuaBridge.ChangeGridByIndex(arg_121_0, arg_121_1, arg_121_2)
			WarChessData:ChangeGridLua(arg_121_0, arg_121_1, arg_121_2)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[10405] = {
		[9] = function()
			manager.ChessManager:StopMove()

			return manager.ChessManager:DoNextEvent()
		end
	},
	[16001] = {
		[9] = function(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
			local var_123_0 = manager.ChessManager:GetExecutingChess()

			WarChessData:SetCacheExtendID("floor", arg_123_0)
			WarChessData:SetCacheExtendID("stone_1", arg_123_1)
			WarChessData:SetCacheExtendID("stone_2", arg_123_2)
			WarChessData:SetCacheExtendID("stoneAndHole", arg_123_3)
			manager.ChessManager:StoneStartToMove(var_123_0.x, var_123_0.z)

			return manager.ChessManager:DoNextEvent()
		end
	},
	[16002] = {
		[7] = function(arg_124_0, arg_124_1, arg_124_2, arg_124_3)
			local var_124_0 = WarChessData:GetCacheGridData()
			local var_124_1 = var_124_0.status == 1 and arg_124_1 or arg_124_3
			local var_124_2 = manager.ChessManager:GetExecutingChess()
			local var_124_3 = var_124_2.x
			local var_124_4 = var_124_2.z
			local var_124_5 = WarChessData:GetGridAttribute(var_124_0.x, var_124_0.z)

			if var_124_1 < 0 then
				if var_124_5[3] and var_124_5[3] ~= 0 then
					WarChessData:ChangeGridLua(var_124_0.x, var_124_0.z, var_124_5[3])
					ChessLuaBridge.ChangeGridByIndex(var_124_0.x, var_124_0.z, var_124_5[3])
					ChessLuaBridge.ClearStoneCache()
				else
					local var_124_6 = ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(var_124_0.x, var_124_0.z)))

					WarChessData:ChangeGridLua(var_124_0.x, var_124_0.z, 0)
					ChessLuaBridge.ChangeGrid(var_124_0.x, var_124_0.z, var_124_6)
					ChessLuaBridge.ClearStoneCache()
				end

				if arg_124_2 < 0 then
					manager.ChessManager:ChangeGridByIndexWithOutLook(var_124_3, var_124_4, arg_124_0, function()
						return manager.ChessManager:DoNextEvent()
					end)
				else
					manager.ChessManager:PlayGridAnimation(var_124_3, var_124_4, arg_124_2, function()
						manager.ChessManager:ChangeGridByIndexWithOutLook(var_124_3, var_124_4, arg_124_0, function()
							return manager.ChessManager:DoNextEvent()
						end)
					end)
				end
			else
				manager.ChessManager:PlayGridAnimation(var_124_0.x, var_124_0.z, var_124_1, function()
					if var_124_5[3] and var_124_5[3] ~= 0 then
						WarChessData:ChangeGridLua(var_124_0.x, var_124_0.z, var_124_5[3])
						ChessLuaBridge.ChangeGridByIndex(var_124_0.x, var_124_0.z, var_124_5[3])
						ChessLuaBridge.ClearStoneCache()
					else
						local var_128_0 = ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(var_124_0.x, var_124_0.z)))

						WarChessData:ChangeGridLua(var_124_0.x, var_124_0.z, 0)
						ChessLuaBridge.ChangeGrid(var_124_0.x, var_124_0.z, var_128_0)
						ChessLuaBridge.ClearStoneCache()
					end

					if arg_124_2 < 0 then
						manager.ChessManager:ChangeGridByIndexWithOutLook(var_124_3, var_124_4, arg_124_0, function()
							return manager.ChessManager:DoNextEvent()
						end)
					else
						manager.ChessManager:PlayGridAnimation(var_124_3, var_124_4, arg_124_2, function()
							manager.ChessManager:ChangeGridByIndexWithOutLook(var_124_3, var_124_4, arg_124_0, function()
								return manager.ChessManager:DoNextEvent()
							end)
						end)
					end
				end)
			end
		end
	},
	[16003] = {
		[7] = function(arg_132_0)
			local var_132_0 = WarChessData:GetCacheGridData()
			local var_132_1 = ChessTools.GetStoneNextState(var_132_0.status, arg_132_0)

			WarChessData:ChangeGridStatusLua(var_132_0.x, var_132_0.z, var_132_1)
			manager.ChessManager:ChangeGridStatus(var_132_0.x, var_132_0.z, var_132_1, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[16004] = {
		[9] = function(arg_134_0, arg_134_1)
			local var_134_0 = manager.ChessManager:GetExecutingChess()

			for iter_134_0 = -arg_134_0, arg_134_0 do
				for iter_134_1 = math.max(-arg_134_0, iter_134_0 - arg_134_0), math.min(arg_134_0, iter_134_0 + arg_134_0) do
					local var_134_1 = ChessLuaBridge.GetGridData(var_134_0.x + iter_134_0, var_134_0.z + iter_134_1)

					if var_134_1.typeID == ChessConst.STONE_GRID_ID then
						local var_134_2 = ChessTools.GetStoneNextState(var_134_1.status, arg_134_1)

						WarChessData:ChangeGridStatusLua(var_134_0.x + iter_134_0, var_134_0.z + iter_134_1, var_134_2)
						ChessLuaBridge.ChangeGridStatus(var_134_0.x + iter_134_0, var_134_0.z + iter_134_1, var_134_2)
					end
				end
			end

			return manager.ChessManager:DoNextEvent()
		end
	},
	[16005] = {
		[7] = function(arg_135_0, arg_135_1, arg_135_2)
			local var_135_0 = WarChessData:GetCacheGridData()
			local var_135_1 = manager.ChessManager:GetExecutingChess()
			local var_135_2 = var_135_1.x
			local var_135_3 = var_135_1.z
			local var_135_4 = WarChessData:GetGridAttribute(var_135_0.x, var_135_0.z)

			if arg_135_1 < 0 then
				if var_135_4[3] and var_135_4[3] ~= 0 then
					WarChessData:ChangeGridLua(var_135_0.x, var_135_0.z, var_135_4[3])
					ChessLuaBridge.ChangeGridByIndex(var_135_0.x, var_135_0.z, var_135_4[3])
					ChessLuaBridge.ClearStoneCache()
				else
					local var_135_5 = ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(var_135_0.x, var_135_0.z)))

					WarChessData:ChangeGridLua(var_135_0.x, var_135_0.z, 0)
					ChessLuaBridge.ChangeGrid(var_135_0.x, var_135_0.z, var_135_5)
					ChessLuaBridge.ClearStoneCache()
				end

				if arg_135_2 < 0 then
					manager.ChessManager:ChangeGridByIndexWithOutLook(var_135_2, var_135_3, arg_135_0, function()
						return manager.ChessManager:DoNextEvent()
					end)
				else
					manager.ChessManager:PlayGridAnimation(var_135_2, var_135_3, arg_135_2, function()
						manager.ChessManager:ChangeGridByIndexWithOutLook(var_135_2, var_135_3, arg_135_0, function()
							return manager.ChessManager:DoNextEvent()
						end)
					end)
				end
			else
				manager.ChessManager:PlayGridAnimation(var_135_0.x, var_135_0.z, arg_135_1, function()
					if var_135_4[3] and var_135_4[3] ~= 0 then
						WarChessData:ChangeGridLua(var_135_0.x, var_135_0.z, var_135_4[3])
						ChessLuaBridge.ChangeGridByIndex(var_135_0.x, var_135_0.z, var_135_4[3])
						ChessLuaBridge.ClearStoneCache()
					else
						local var_139_0 = ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(var_135_0.x, var_135_0.z)))

						WarChessData:ChangeGridLua(var_135_0.x, var_135_0.z, 0)
						ChessLuaBridge.ChangeGrid(var_135_0.x, var_135_0.z, var_139_0)
						ChessLuaBridge.ClearStoneCache()
					end

					if arg_135_2 < 0 then
						manager.ChessManager:ChangeGridByIndexWithOutLook(var_135_2, var_135_3, arg_135_0, function()
							return manager.ChessManager:DoNextEvent()
						end)
					else
						manager.ChessManager:PlayGridAnimation(var_135_2, var_135_3, arg_135_2, function()
							manager.ChessManager:ChangeGridByIndexWithOutLook(var_135_2, var_135_3, arg_135_0, function()
								return manager.ChessManager:DoNextEvent()
							end)
						end)
					end
				end)
			end
		end
	},
	[16006] = {
		[9] = function(arg_143_0, arg_143_1)
			for iter_143_0, iter_143_1 in pairs((WarChessData:GetMapChangeInfo())) do
				if iter_143_1.attribute[1] and iter_143_1.attribute[2] then
					for iter_143_2, iter_143_3 in pairs(arg_143_0) do
						if iter_143_1.attribute[1] == iter_143_3[1] and iter_143_1.attribute[2] == iter_143_3[2] then
							if iter_143_1.attribute[3] and iter_143_1.attribute[3] ~= 0 then
								ChessLuaBridge.ChangeGridByIndex(iter_143_1.pos.x, iter_143_1.pos.z, iter_143_1.attribute[3])
								WarChessData:ChangeGridLua(iter_143_1.pos.x, iter_143_1.pos.z, iter_143_1.attribute[3])
							else
								ChessLuaBridge.ChangeGrid(iter_143_1.pos.x, iter_143_1.pos.z, (ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(iter_143_1.pos.x, iter_143_1.pos.z)))))
								WarChessData:ChangeGridLua(iter_143_1.pos.x, iter_143_1.pos.z, 0)

								break
							end
						end
					end
				end
			end

			for iter_143_4, iter_143_5 in pairs(arg_143_1) do
				if WarChessData:GetGridIsChanged(iter_143_5[1], iter_143_5[2]) then
					local var_143_0 = ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(iter_143_5[1], iter_143_5[2])))

					WarChessData:ChangeGridLua(iter_143_5[1], iter_143_5[2], 0)
					ChessLuaBridge.ChangeGrid(iter_143_5[1], iter_143_5[2], var_143_0)
				end
			end

			for iter_143_6, iter_143_7 in pairs(arg_143_0) do
				WarChessData:ChangeGridLua(iter_143_7[1], iter_143_7[2], iter_143_7[3])
				ChessLuaBridge.ChangeGridByIndex(iter_143_7[1], iter_143_7[2], iter_143_7[3])
			end

			return manager.ChessManager:DoNextEvent()
		end
	},
	[16007] = {
		[9] = function(arg_144_0, arg_144_1, arg_144_2)
			manager.ChessManager:PlayGridAnimation(arg_144_0, arg_144_1, arg_144_2, function()
				return manager.ChessManager:DoNextEvent()
			end)
		end
	},
	[16008] = {
		[9] = function()
			return manager.ChessManager:DoNextEvent()
		end
	}
}
