function PreloadNewChessAsset()
	for iter_1_0, iter_1_1 in pairs((BattleTeamData:GetSingleTeam((NewWarChessData:GetCurrentActivity())))) do
		if iter_1_1 ~= 0 then
			local var_1_1 = manager.resourcePool:Get("Char/" .. HeroTools.HeroUsingSkinInfo(iter_1_1).ui_modelId, ASSET_TYPE.TPOSE)

			Timer.New(function()
				manager.resourcePool:DestroyOrReturn(var_1_1, ASSET_TYPE.TPOSE)
			end, 0.1, 1):Start()
		end
	end
end

function OnEnterNewChessScene()
	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()

	if _G.OnLoadedCallBackPre_ then
		_G.OnLoadedCallBackPre_()
	end

	if _G.OnLoadedCallBack_ then
		_G.OnLoadedCallBack_()

		_G.OnLoadedCallBack_ = nil
	end

	NewChessLuaBridge.LookAtPlayer()

	local var_3_0 = NewWarChessData:GetCurrentWarChessMapData()

	SceneManager.SetActiveScene((SceneManager.GetSceneByName(NewWarChessLevelCfg[var_3_0.mapId].scene_id)))
	manager.windowBar:SetWhereTag("newchess")

	if manager.NewChessManager == nil then
		manager.NewChessManager = NewWarChessMain.GetInstance()

		manager.NewChessManager:SetUp(var_3_0.mapId)
	end

	manager.NewChessManager:CreateSupportModule()

	if NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FIRST_IN") == 0 then
		gameContext:Go("/newWarChessEnterView")
	else
		local var_3_1, var_3_2, var_3_3 = NewWarChessData:GetCurChanceID()

		if var_3_1 ~= 0 then
			manager.NewChessManager:SetChanceInteract(true, NewChessLuaBridge.GetNewGridData(var_3_2, var_3_3))
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = var_3_1
			})
		elseif manager.NewChessManager:IsBattleBack() then
			manager.NewChessManager:BattleFinish()
		else
			gameContext:Go("/newWarChessHome")
		end
	end
end

function NewChessWantToMove(arg_4_0, arg_4_1)
	NewWarChessAction.RoleMoveByPos({
		x = arg_4_0,
		z = arg_4_1
	}, function(arg_5_0)
		if arg_5_0 then
			NewChessLuaBridge.MoveRoleLogicPosition(arg_4_0, arg_4_1)
		else
			manager.NewChessManager:ClearEndPoint()
			NewChessLuaBridge.FixRolePositon()
		end
	end)
end

function NewChessWalkOutNode(arg_6_0)
	manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_WALK_OUT, {
		gridData = arg_6_0
	})
end

function NewChessWalkIntoNode(arg_7_0, arg_7_1, arg_7_2)
	manager.NewChessManager:ClearGridSelectEffect(arg_7_0.x, arg_7_0.z)
	manager.NewChessManager:SetPosition(arg_7_0.x, arg_7_0.z)
	manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_WALK_INTO_OBJECT, {
		gridData = arg_7_0
	})
	manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_WALK_INTO, {
		gridData = arg_7_0,
		isTelePort = arg_7_1,
		dir = arg_7_2
	})
	manager.NewChessManager:StartExecuteEvent()
end

function NewChessWalkEnd()
	manager.NewChessManager:OnMoveEnd()

	if manager.NewChessManager:IsExecuting() then
		if manager.NewChessManager:GetPosition()[1] == manager.NewChessManager.ExecutingChess_.x and manager.NewChessManager:GetPosition()[2] == manager.NewChessManager.ExecutingChess_.z then
			if manager.NewChessManager.ExecutingChess_.objectTypeID ~= 0 and NewWarChessThingCfg[manager.NewChessManager.ExecutingChess_.objectTypeID].walkable == 1 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT_OBJECT, {})
			end

			if NewWarChessHexCfg[manager.NewChessManager.ExecutingChess_.typeID].walkable == 1 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT, {})
			end
		else
			local var_8_0 = manager.NewChessManager.ExecutingChess_.typeID

			if manager.NewChessManager.ExecutingChess_.objectTypeID ~= 0 and NewWarChessThingCfg[manager.NewChessManager.ExecutingChess_.objectTypeID].walkable == 0 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT_OBJECT, {})
			end

			if NewWarChessHexCfg[var_8_0].walkable == 0 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT, {})
			end
		end
	end
end

function NewChessFogOpen(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}

	if arg_9_2 ~= nil then
		for iter_9_0 = 0, arg_9_2.Length - 1 do
			table.insert(var_9_0, {
				x = arg_9_2[iter_9_0],
				z = arg_9_3[iter_9_0]
			})
		end
	end

	NewWarChessAction.OpenFogByPos({
		x = arg_9_0,
		z = arg_9_1
	}, var_9_0)
end

function NewChessGridClick(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	CheckManagers()

	if arg_10_4 then
		manager.NewChessManager:SetInteractChess(arg_10_0)

		if arg_10_0.objectTypeID ~= 0 and NewWarChessThingCfg[arg_10_0.objectTypeID].walkable == 1 then
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT_OBJECT, {})
		end

		if NewWarChessHexCfg[arg_10_0.typeID].walkable == 1 then
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT, {})
		end

		manager.NewChessManager:StartExecuteEvent()
	else
		if false or arg_10_1 == nil then
			manager.NewChessManager:ClearEndPoint()
			ShowTips("ACTIVITY_NEW_WARCHESS_CAN_NOT_ARRIVE")

			return
		end

		if arg_10_1.Length > 1 then
			local var_10_0 = {}
			local var_10_1 = 0

			for iter_10_0 = 0, arg_10_1.Length - 1 do
				table.insert(var_10_0, {
					x = arg_10_1[iter_10_0].x,
					z = arg_10_1[iter_10_0].z
				})

				if iter_10_0 > 0 then
					var_10_1 = var_10_1 + NewWarChessHexCfg[arg_10_1[iter_10_0].typeID].penalty
				end
			end

			if arg_10_0.objectClickParamList and arg_10_0.objectClickParamList.Length > 0 or arg_10_0.clickParamList and arg_10_0.clickParamList.Length > 0 then
				manager.NewChessManager:SetInteractChess(arg_10_0)
				manager.NewChessManager:ShowPathEffect(var_10_1, arg_10_2.x, arg_10_2.y)
			else
				manager.NewChessManager:ClearInteractChess()
				manager.NewChessManager:ShowPathEffect(var_10_1, arg_10_2.x, arg_10_2.y)
			end
		elseif arg_10_1.Length == 1 then
			manager.NewChessManager:ClearEndPoint()
			manager.NewChessManager:SetInteractChess(arg_10_0)

			if arg_10_0.objectTypeID ~= 0 and NewWarChessThingCfg[arg_10_0.objectTypeID].walkable == 0 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT_OBJECT, {})
			end

			if NewWarChessHexCfg[arg_10_0.typeID].walkable == 0 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT, {})
			end

			manager.NewChessManager:StartExecuteEvent()
		elseif arg_10_0.objectClickParamList and arg_10_0.objectClickParamList.Length > 0 or arg_10_0.clickParamList and arg_10_0.clickParamList.Length > 0 then
			manager.NewChessManager:SetInteractChess(arg_10_0)
			manager.NewChessManager:ShowPathEffect(cost, arg_10_2.x, arg_10_2.y)
		else
			manager.NewChessManager:ClearInteractChess()
			manager.NewChessManager:ShowPathEffect(cost, arg_10_2.x, arg_10_2.y)
		end
	end
end

function NewChessGridFarClick(arg_11_0, arg_11_1)
	manager.NewChessManager:ClearEndPoint()
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.FARCLICK, 0, arg_11_1.x, arg_11_1.y, function()
		NewWarChessAction.ClickGrid(arg_11_0.x, arg_11_0.z, true, function()
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_FARCLICK_OBJECT, {
				gridData = arg_11_0
			})
			manager.NewChessManager:StartExecuteEvent()
		end)
	end)
end

function OnNewChessCameraMove()
	manager.NewChessManager:ClearEndPoint()
	manager.notify:CallUpdateFunc(NEWWARCHESS_CAMERA_MOVE, true)
end

function GetPlayerOpenFogLength()
	return NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FOG_LENGTH")
end

function OnExitNewChessScene()
	if manager.NewChessManager then
		manager.NewChessManager:DisposeSupportModule()
	end
end
