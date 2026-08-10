function OnEnterChessBoardScene()
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

	ChessBoardLuaBridge.LookAtPlayer()

	local var_1_0 = ChessBoardData:GetCurrentChessBoardMapData()
	local var_1_1 = SceneManager.GetSceneByName(ChessBoardLevelCfg[var_1_0.mapId].scene_id)

	SceneManager.SetActiveScene(var_1_1)
	manager.windowBar:SetWhereTag("chessBoard")

	if manager.ChessBoardManager == nil then
		manager.ChessBoardManager = ChessBoardManager.GetInstance()

		manager.ChessBoardManager:SetUp(var_1_0)
	end

	manager.ChessBoardManager:CreateSupportModule()

	if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FIRST_MAP") == 0 then
		local var_1_2 = ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapID()].eventpool_id

		if var_1_2 > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_1_2].player_params) then
			manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.FIRST_ENTER_MAP, {}, 0, -1)
			manager.ChessBoardManager:StartExecuteEvent(function()
				manager.ChessBoardManager:SetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FIRST_MAP", 1)
				gameContext:Go("/chessBoardHomeView")
			end)
			manager.ChessBoardManager:SetIsCanUseProp(true)
		else
			manager.ChessBoardManager:SetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FIRST_MAP", 1)
			gameContext:Go("/chessBoardHomeView")
		end
	elseif manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") == 1 then
		gameContext:Go("/chessBoardOverView")
	else
		local var_1_3 = manager.ChessBoardManager:GetCurChanceInfo()

		if manager.ChessBoardManager:IsBattleBack() then
			manager.ChessBoardManager:BattleFinish()
		elseif var_1_3.chanceID > 0 then
			if var_1_3.isUnLock == 1 then
				ChessBoardTools.OpenChanceView(var_1_3.chanceID, true)
			else
				JumpTools.OpenPageByJump("/chessBoardChanceView", {
					viewType = ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE
				})
			end
		else
			gameContext:Go("/chessBoardHomeView")
			manager.ChessBoardManager:ReconnectionTmpListProp(nil, function()
				local var_3_0 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE")

				if var_3_0 == ChessBoardConst.CHESSBOARDSTATUS_ENUM.START_MOVE or var_3_0 == ChessBoardConst.CHESSBOARDSTATUS_ENUM.MOVING then
					manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, true)
				elseif var_3_0 == ChessBoardConst.CHESSBOARDSTATUS_ENUM.END_MOVE then
					ChessBoardAction.HeroMoveEnd(function()
						manager.ChessBoardManager:OnHeroTurnEnd()
					end)
				elseif var_3_0 == ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START then
					manager.ChessBoardManager:EffectShow(ChessBoardConst.EFFECT_TYPE.NORMAL_ARROW)
					manager.ChessBoardManager:SetIsCanUseProp(true)
				end
			end)
		end
	end
end

function ChessBoardSelectMovePos(arg_5_0, arg_5_1)
	manager.ChessBoardManager:SelectMovePos(arg_5_0, arg_5_1)
end

function ChessBoardSelectNpcPos(arg_6_0, arg_6_1)
	manager.ChessBoardManager:SelectNpcPos(arg_6_0, arg_6_1)
end

function ChessBoardSelectMapPos(arg_7_0, arg_7_1)
	manager.ChessBoardManager:SelectMapPos(arg_7_0, arg_7_1)
end

function ChessBoardCheckMapGrid(arg_8_0, arg_8_1)
	manager.ChessBoardManager:SelectMapGrid(arg_8_0, arg_8_1)
end

function OnExitChessBoardScene()
	if manager.ChessBoardManager then
		manager.ChessBoardManager:DisposeSupportModule()
	end
end

function OnChessBoardCameraMove()
	manager.notify:CallUpdateFunc(CHESSBOARD_CAMERA_MOVE, true)
end

function OnChessBoardCameraZoomScale()
	manager.notify:CallUpdateFunc(CHESSBOARD_CAMERA_ZOOM_SCALE)
end

function ChessBoardGetIsFastModule()
	if ChessBoardData:GetIsFastModule() then
		return true
	else
		return false
	end
end
