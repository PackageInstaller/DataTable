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

	if ChapterCfg[var_1_0.mapId] and ChapterCfg[var_1_0.mapId].cue_sheet ~= "" then
		manager.audio:PlayBGM(ChapterCfg[var_1_0.mapId].cue_sheet, ChapterCfg[var_1_0.mapId].cue_name, ChapterCfg[var_1_0.mapId].awb)
	end

	SceneManager.SetActiveScene((SceneManager.GetSceneByName(WarchessLevelCfg[var_1_0.mapId].scene_id)))
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
	for iter_2_0, iter_2_1 in pairs((BattleTeamData:GetSingleTeam((WarChessData:GetCurrentActivity())))) do
		if iter_2_1 ~= 0 then
			local var_2_1 = manager.resourcePool:Get("Char/" .. HeroTools.HeroUsingSkinInfo(iter_2_1).ui_modelId, ASSET_TYPE.TPOSE)

			Timer.New(function()
				manager.resourcePool:DestroyOrReturn(var_2_1, ASSET_TYPE.TPOSE)
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
			local var_4_0 = ChessTools.WayFindingWeight(arg_4_1[iter_4_0].typeID, arg_4_1[iter_4_0].status)

			if var_4_0 == 999 and iter_4_0 ~= arg_4_1.Length - 1 and iter_4_0 ~= 0 then
				arg_4_2 = true

				break
			end

			if var_4_0 == 999 and iter_4_0 == arg_4_1.Length - 1 and (arg_4_1[iter_4_0].x ~= arg_4_0.x or arg_4_1[iter_4_0].z ~= arg_4_0.z) then
				arg_4_2 = true

				break
			end
		end
	end

	if manager.ChessManager.current:IsDetector() and not arg_4_2 and arg_4_1.Length >= 1 then
		local var_4_1 = WarChessData:GetCurrentIndex()

		if ChessTools.IsMove(arg_4_0.typeID, arg_4_0.status) and not ChessTools.IsInRange(arg_4_0.x - var_4_1.x, arg_4_0.z - var_4_1.z, 1) then
			arg_4_2 = true
		end
	end

	if not arg_4_2 and arg_4_1.Length >= 1 then
		local var_4_2 = {}

		for iter_4_1 = 0, arg_4_1.Length - 1 do
			table.insert(var_4_2, {
				x = arg_4_1[iter_4_1].x,
				z = arg_4_1[iter_4_1].z
			})
		end

		if manager.ChessManager.current:IsDetector() then
			WarChessData:SetDetectorPos(var_4_2[#var_4_2].x, var_4_2[#var_4_2].z)
		end

		manager.ChessManager:CachePath(var_4_2)
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

	if var_7_0 then
		return (manager.ChessManager:ExecuteChessTiming((manager.ChessManager.current:IsCurrentState() or nil) and (ChessConst.TIMING_CURRENT or ChessConst.TIMING_WALK), {
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

	OpenPageUntilLoaded(WarChessData:GetTemporaryData("url"), (WarChessData:GetTemporaryData("urlParams")))

	if arg_11_0 then
		WarChessAction.FinishExplore()
	else
		local var_11_1 = WarChessData:GetCurrentWarChessMapData()
		local var_11_2 = {}

		for iter_11_0, iter_11_1 in pairs(WarChessData:GetItemData()) do
			table.insert(var_11_2, {
				iter_11_0,
				iter_11_1
			})
		end

		local var_11_3 = {}

		for iter_11_2, iter_11_3 in pairs(WarChessData:GetHeroList()) do
			table.insert(var_11_3, {
				iter_11_2,
				iter_11_3
			})
		end

		local var_11_4 = {}

		for iter_11_4, iter_11_5 in pairs(WarChessData:GetArtifactData()) do
			table.insert(var_11_4, iter_11_4)
		end

		local var_11_5 = {}

		for iter_11_6, iter_11_7 in ipairs(var_11_1.log) do
			table.insert(var_11_5, iter_11_7.log)
		end

		SDKTools.SendMessageToSDK("chess_leave", {
			map_id = var_11_1.mapId,
			location_id = {
				var_11_1.bronPos.x,
				var_11_1.bronPos.z
			},
			log = var_11_5,
			smallbox = WarChessData:GetBoxNum(var_11_1.mapId, ChessConst.BOX.SMALL),
			bigbox = WarChessData:GetBoxNum(var_11_1.mapId, ChessConst.BOX.BIG),
			key_own = var_11_2,
			hero_blood = var_11_3,
			relic_exsiting = var_11_4,
			progress = ChessTools.GetProgress(var_11_1.mapId),
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

	if not WarchessEventPoolCfg[arg_13_3.paramList[0]] then
		-- block empty
	end

	if WarchessEventPoolCfg[arg_13_3.paramList[0]].event_group_second == "" then
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
			WarChessData:SetGridAttribute(arg_15_1.x, arg_15_1.z, {
				arg_15_0.x,
				arg_15_0.z,
				var_15_1
			})
		else
			WarChessData:SetGridAttribute(arg_15_1.x, arg_15_1.z, {
				var_15_0[1],
				var_15_0[2],
				var_15_1
			})
		end

		if var_15_0[3] and var_15_0[3] ~= 0 then
			WarChessData:ChangeGridLua(arg_15_0.x, arg_15_0.z, var_15_0[3])
			ChessLuaBridge.ChangeGridByIndex(arg_15_0.x, arg_15_0.z, var_15_0[3])
		else
			local var_15_3 = ChessTools.CreateChessDataViaJson((WarChessData:GetJsonData(arg_15_0.x, arg_15_0.z)))

			WarChessData:ChangeGridLua(arg_15_0.x, arg_15_0.z, 0)
			ChessLuaBridge.ChangeGrid(arg_15_0.x, arg_15_0.z, var_15_3)
		end
	end

	WarChessData:ClearCacheGridData()
end
