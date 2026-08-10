function OnEnterChessScene()
	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()
	gameContext:SetSystemLayer("battle")

	if _G.OnLoadedCallBackPre_ then
		_G.OnLoadedCallBackPre_()
	end

	if _G.OnLoadedCallBack_ then
		_G.OnLoadedCallBack_()

		_G.OnLoadedCallBack_ = nil
	end

	ChessLuaBridge.LookAtPlayer()

	manager.ChessManager = ChessMain.GetInstance()

	local var_1_0 = WarChessData:GetCurrentWarChessMapData()
	local var_1_1 = ChapterCfg[var_1_0.mapId]

	if var_1_1 and var_1_1.cue_sheet ~= "" then
		manager.audio:PlayBGM(var_1_1.cue_sheet, var_1_1.cue_name, var_1_1.awb)
	end

	local var_1_2 = SceneManager.GetSceneByName(WarchessLevelCfg[var_1_0.mapId].scene_id)

	SceneManager.SetActiveScene(var_1_2)
	manager.ChessManager:SetUp(var_1_0.mapId)
	gameContext:Go("/warHome", {
		mapId = var_1_0.mapId
	})
	manager.windowBar:SetWhereTag("chess")

	if WarChessData:IsAboutToStart() then
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_START, {})
	end
end

function PreloadChessAsset()
	local var_2_0 = WarChessData:GetCurrentActivity()
	local var_2_1
	local var_2_2 = BattleTeamData:GetSingleTeam(var_2_0)

	for iter_2_0, iter_2_1 in pairs(var_2_2) do
		if iter_2_1 ~= 0 then
			local var_2_3 = HeroTools.HeroUsingSkinInfo(iter_2_1).ui_modelId
			local var_2_4 = manager.resourcePool:Get("Char/" .. var_2_3, ASSET_TYPE.TPOSE)

			Timer.New(function()
				manager.resourcePool:DestroyOrReturn(var_2_4, ASSET_TYPE.TPOSE)
			end, 0.1, 1):Start()
		end
	end
end

function GridClick(arg_4_0, arg_4_1, arg_4_2)
	CheckManagers()

	if manager.ChessManager.forceBattle:IsForcingBattle() then
		manager.ChessManager.forceBattle:ForceEnterBossBattle()

		return
	end

	if not ChessTools.IsInteract(arg_4_0.typeID, arg_4_0.status) and not ChessTools.IsMove(arg_4_0.typeID, arg_4_0.status) then
		return
	end

	manager.ChessManager:SetGridSelectOutline(arg_4_0.x, arg_4_0.z, true)
	OperationRecorder.Record("chess", "grid")

	if not manager.ChessManager.current:IsDetector() and not arg_4_2 and arg_4_1.Length >= 1 then
		for iter_4_0 = 0, arg_4_1.Length - 1 do
			local var_4_0 = arg_4_1[iter_4_0].typeID
			local var_4_1 = arg_4_1[iter_4_0].status
			local var_4_2 = ChessTools.WayFindingWeight(var_4_0, var_4_1)

			if var_4_2 == 999 and iter_4_0 ~= arg_4_1.Length - 1 and iter_4_0 ~= 0 then
				arg_4_2 = true

				break
			end

			if var_4_2 == 999 and iter_4_0 == arg_4_1.Length - 1 and (arg_4_1[iter_4_0].x ~= arg_4_0.x or arg_4_1[iter_4_0].z ~= arg_4_0.z) then
				arg_4_2 = true

				break
			end
		end
	end

	if manager.ChessManager.current:IsDetector() and not arg_4_2 and arg_4_1.Length >= 1 then
		local var_4_3 = arg_4_0.typeID
		local var_4_4 = arg_4_0.status
		local var_4_5 = ChessTools.IsMove(var_4_3, var_4_4)
		local var_4_6 = WarChessData:GetCurrentIndex()
		local var_4_7 = arg_4_0.x - var_4_6.x
		local var_4_8 = arg_4_0.z - var_4_6.z

		if var_4_5 and not ChessTools.IsInRange(var_4_7, var_4_8, 1) then
			arg_4_2 = true
		end
	end

	if not arg_4_2 and arg_4_1.Length >= 1 then
		local var_4_9 = {}

		for iter_4_1 = 0, arg_4_1.Length - 1 do
			table.insert(var_4_9, {
				x = arg_4_1[iter_4_1].x,
				z = arg_4_1[iter_4_1].z
			})
		end

		if manager.ChessManager.current:IsDetector() then
			WarChessData:SetDetectorPos(var_4_9[#var_4_9].x, var_4_9[#var_4_9].z)
		end

		manager.ChessManager:CachePath(var_4_9)
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_CLICK, {
			gridData = arg_4_0,
			pathList = arg_4_1,
			isError = arg_4_2
		})
	else
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_CLICK, {
			gridData = arg_4_0,
			pathList = arg_4_1,
			isError = arg_4_2
		})
	end
end

function ClickRole(arg_5_0)
	print("ClickRole")
end

function SetUpChess()
	manager.ChessManager.current:ExtendSetup()
end

function WalkIntoNode(arg_7_0)
	if manager.ChessManager.current:IsDetector() then
		return false
	end

	local var_7_0 = manager.ChessManager:SetPosition(arg_7_0.x, arg_7_0.z)
	local var_7_1 = manager.ChessManager.current:IsCurrentState() and ChessConst.TIMING_CURRENT or ChessConst.TIMING_WALK
	local var_7_2

	if var_7_0 then
		return (manager.ChessManager:ExecuteChessTiming(var_7_1, {
			gridData = arg_7_0
		}))
	else
		return false
	end
end

function SlideEnd(arg_8_0)
	local var_8_0 = manager.ChessManager.current:IsAboutToSlide()

	if var_8_0 then
		return manager.ChessManager.current:SlideByDirectionInCurrentState(var_8_0)
	end

	if arg_8_0 and arg_8_0.paramList.Length > 0 then
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_CURRENT_HIT, {
			gridData = arg_8_0
		})
	end

	manager.ChessManager.current:CurrentEnd()
	manager.ChessManager.current:AboutToDie(2)
end

function WalkEnd()
	if manager.ChessManager.current:IsCurrentState() then
		return
	end

	manager.ChessManager:OnMoveEnd()

	local var_9_0 = manager.ChessManager.current:IsAboutToSlide()

	if var_9_0 then
		return manager.ChessManager.current:SlideByDirection(var_9_0)
	end

	if manager.ChessManager:IsExecuting() then
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_INTERACT, {})
	end

	manager.ChessManager.current:AboutToDie(2)
end

function FogOpen(arg_10_0)
	WarChessData:ChangeFogInfo(arg_10_0)
end

function OnExitChessScene(arg_11_0)
	manager.windowBar:ClearWhereTag()
	DestroyLua()
	LuaExchangeHelper.GoToMain()

	local var_11_0 = WarChessData:GetChapterClientID()
	local var_11_1 = WarChessData:GetTemporaryData("url")
	local var_11_2 = WarChessData:GetTemporaryData("urlParams")

	OpenPageUntilLoaded(var_11_1, var_11_2)

	if arg_11_0 then
		WarChessAction.FinishExplore()
	else
		local var_11_3 = WarChessData:GetCurrentWarChessMapData()
		local var_11_4 = {}

		for iter_11_0, iter_11_1 in pairs(WarChessData:GetItemData()) do
			table.insert(var_11_4, {
				iter_11_0,
				iter_11_1
			})
		end

		local var_11_5 = {}

		for iter_11_2, iter_11_3 in pairs(WarChessData:GetHeroList()) do
			table.insert(var_11_5, {
				iter_11_2,
				iter_11_3
			})
		end

		local var_11_6 = {}

		for iter_11_4, iter_11_5 in pairs(WarChessData:GetArtifactData()) do
			table.insert(var_11_6, iter_11_4)
		end

		local var_11_7 = {}

		for iter_11_6, iter_11_7 in ipairs(var_11_3.log) do
			table.insert(var_11_7, iter_11_7.log)
		end

		SDKTools.SendMessageToSDK("chess_leave", {
			map_id = var_11_3.mapId,
			location_id = {
				var_11_3.bronPos.x,
				var_11_3.bronPos.z
			},
			log = var_11_7,
			smallbox = WarChessData:GetBoxNum(var_11_3.mapId, ChessConst.BOX.SMALL),
			bigbox = WarChessData:GetBoxNum(var_11_3.mapId, ChessConst.BOX.BIG),
			key_own = var_11_4,
			hero_blood = var_11_5,
			relic_exsiting = var_11_6,
			progress = ChessTools.GetProgress(var_11_3.mapId),
			use_seconds = manager.time:GetServerTime() - WarChessData:GetStartTime()
		})
	end

	manager.ChessManager:Dispose()

	manager.ChessManager = nil
end

function OnCameraMove()
	manager.notify:CallUpdateFunc(CAMERA_MOVE, true)
end

function OnBulletHit(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_3 then
		manager.ChessManager:OnBulletEnd()
		ChessLuaBridge.LookAtPlayer()

		return
	end

	if arg_13_3.paramList.Length <= 0 then
		manager.ChessManager:OnBulletEnd()
		ChessLuaBridge.LookAtPlayer()

		return
	end

	local var_13_0 = arg_13_3.paramList[0]

	if not WarchessEventPoolCfg[var_13_0] then
		-- block empty
	end

	if WarchessEventPoolCfg[var_13_0].event_group_second == "" then
		manager.ChessManager:OnBulletEnd()
		ChessLuaBridge.LookAtPlayer()

		return
	end

	manager.ChessManager:SetBulletDirection(arg_13_2)
	manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_HIT, {
		gridData = arg_13_3
	})
	manager.ChessManager:OnBulletEnd()
end

function OnStoneInteract(arg_14_0, arg_14_1)
	if ChessTools.IsStoneInteract(arg_14_1.typeID, arg_14_1.status, arg_14_0.status) then
		WarChessData:CacheGridData(arg_14_0)
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_STONE_MOVE, {
			gridData = arg_14_1
		})
	else
		ChessLuaBridge.StoneContinueMove()
	end
end

function OnStoneMoveEnd(arg_15_0, arg_15_1)
	manager.ChessManager:HideBlocker()
	ChessLuaBridge.LookAtPlayer()

	if arg_15_1 ~= nil then
		local var_15_0 = WarChessData:GetGridAttribute(arg_15_0.x, arg_15_0.z)
		local var_15_1 = WarChessData:GetGridLua(arg_15_1.x, arg_15_1.z).tag
		local var_15_2 = ChessTools.GetExtendIDByStoneStatus(arg_15_0.status)

		if arg_15_1.typeID == ChessConst.HOLE_GRID_ID then
			var_15_2 = WarChessData:GetCacheExtendID("stoneAndHole")
		end

		WarChessData:ChangeGridLua(arg_15_1.x, arg_15_1.z, var_15_2)
		ChessLuaBridge.ChangeGridByIndex(arg_15_1.x, arg_15_1.z, var_15_2)

		if var_15_0[1] == nil and var_15_0[2] == nil then
			local var_15_3 = {
				arg_15_0.x,
				arg_15_0.z,
				var_15_1
			}

			WarChessData:SetGridAttribute(arg_15_1.x, arg_15_1.z, var_15_3)
		else
			local var_15_4 = {
				var_15_0[1],
				var_15_0[2],
				var_15_1
			}

			WarChessData:SetGridAttribute(arg_15_1.x, arg_15_1.z, var_15_4)
		end

		if var_15_0[3] and var_15_0[3] ~= 0 then
			WarChessData:ChangeGridLua(arg_15_0.x, arg_15_0.z, var_15_0[3])
			ChessLuaBridge.ChangeGridByIndex(arg_15_0.x, arg_15_0.z, var_15_0[3])
		else
			local var_15_5 = WarChessData:GetJsonData(arg_15_0.x, arg_15_0.z)
			local var_15_6 = ChessTools.CreateChessDataViaJson(var_15_5)

			WarChessData:ChangeGridLua(arg_15_0.x, arg_15_0.z, 0)
			ChessLuaBridge.ChangeGrid(arg_15_0.x, arg_15_0.z, var_15_6)
		end
	end

	WarChessData:ClearCacheGridData()
end
