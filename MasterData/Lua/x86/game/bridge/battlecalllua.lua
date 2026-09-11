BattleCooperationCallLua = require("game/bridge/BattleCooperationCallLua")

local BattleResultGotoHandler = require("game/bridge/BattleSettlementStrategy/BattleResultGotoHandler")

BattleResultGotoHandler:Init()

local var_0_1 = false
local var_0_2

function ShowBattlePausePage(arg_1_0, arg_1_1)
	local var_1_0 = BattleController.GetInstance():GetBattleStageData()

	if not BattleFieldData:IsInBattle() and BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= var_1_0:GetType() then
		return
	end

	CheckManagers()

	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= var_1_0:GetType() then
		gameContext.oldRoutes_ = {}
	end

	local var_1_1 = BattleInstance.CaculateStarMission(var_1_0, arg_1_0)
	local var_1_2 = var_1_0:GetType()
	local var_1_3 = SettingConst.SETTING_TYPE.BATTLE_OTHER

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == var_1_2 then
		var_1_3 = SettingConst.SETTING_TYPE.BATTLE_MAIN
	end

	LuaForCursor.SwitchCursor(true)

	if var_1_2 == BattleConst.STAGE_TYPE_NEW.SEA_WARFARE then
		gameContext:Go("/qWorldComfirmView_4_0", {
			title = GetTips("PROMPT"),
			content = GetTips("SEA_WARFARE_QUIT_TIPS"),
			cancelCallback = function()
				gameContext:DestroyCurRoutes()
				LuaExchangeHelper.ContinueGame()
			end,
			comfirmCallback = function()
				LuaExchangeHelper.GameOver(3)
			end
		})
	elseif var_1_2 == BattleConst.STAGE_TYPE_NEW.ASH_BATTLE then
		local var_1_4 = AshSystemAction:GetLastBattleData()

		ShowMessageBox({
			prefabPath = "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_Com_PopUI",
			title = GetTips("PROMPT"),
			content = GetTips("ASH_BATTLE_BACK_TIP"),
			OkCallback = function()
				gameContext:DestroyCurRoutes()
				LuaExchangeHelper.GameOver(3)
			end,
			CancelCallback = function()
				gameContext:DestroyCurRoutes()
				LuaExchangeHelper.ContinueGame()
			end,
			RestartCallback = function()
				LuaExchangeHelper.GameOver(2, CustomLoadingConst.ASHGAME_Loading)
				AshSystemAction:LaunchBattle(var_1_4.stageId, var_1_4.skill, var_1_4.item, var_1_4.weapon, true)
				LuaForCursor.SwitchCursor(false)
			end
		})
	else
		local var_1_5 = "/setting"

		if var_1_2 == BattleConst.STAGE_TYPE_NEW.POLYHEDRON and #gameContext:GetCurHistory() <= 0 then
			var_1_5 = "/polyhedronBlank/polyhedronBattle" .. var_1_5
		end

		gameContext:Go(var_1_5, {
			setType = var_1_3,
			section = var_1_0:GetStageId(),
			result = arg_1_0,
			starMissionData = var_1_1,
			newbie = arg_1_1,
			stageData = var_1_0
		})
	end

	OperationRecorder.Record("BattleCallLua", "combat_pause")
end

local var_0_3 = 202005
local var_0_4 = 200005

_G.BATTLE_SERVER_ERROR_TIME = 0

function BattleServerConnectError(arg_7_0, arg_7_1)
	BattleServerConnectErrorLog(arg_7_0, arg_7_1)

	if arg_7_0 == var_0_4 then
		LuaExchangeHelper.EndWaitReadyAck()
		CheckManagers()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("COOPERATION_NOT_JOIN_AFTER_OTHERS_READY"),
			OkCallback = function()
				gameContext:DestroyCurRoutes()
				CooperationAction.LeaveCooperationBattle(function(arg_9_0)
					BattleInstance.QuitBattle(BattleController.GetInstance():GetBattleStageData(), true)
				end, (BattleFieldData:GetServerBattleID()))
			end
		})

		return
	end

	if arg_7_0 ~= var_0_3 then
		CheckManagers()

		function BattleCallLuaCallBack()
			print("与战斗服连接出现错误，玩家白打，返回登录界面")
		end
	end

	_G.BATTLE_SERVER_ERROR_TIME = _G.BATTLE_SERVER_ERROR_TIME + 1

	ConnectionHelper.OnBattleServerConnectError(arg_7_0, _G.BATTLE_SERVER_ERROR_TIME)
end

function BattleServerConnectErrorLog(arg_11_0, arg_11_1)
	pcall(function()
		local var_12_0 = BattleFieldData:GetServerBattleID() or 0

		arg_11_1 = arg_11_1 or 0

		Debug.LogError("BattleServerConnectError by errorCode : " .. arg_11_0 .. "  serverBattleID : " .. var_12_0 .. "  localConn : " .. arg_11_1)

		local var_12_1, var_12_2 = BattleFieldData:GetBattleServerIPAndPort()
		local var_12_3 = string.format("{\"messageType\" : \"SubmitEvent\", \"eventId\" : \"battle_server_connect_error\", \"errorCode\" : \"%s\", \"battle_id_str\" : \"%s\", \"#device_id\" : \"%s\", \"#account_id\" : \"%s\", \"localConn\" : \"%s\", \"battle_server_ip\" : \"%s\", \"battle_server_port\" : \"%s\", \"#os\" : \"%s\", \"#server_time\" : \"%s\", \"#zone_offset\" : \"%s\", \"#device_model\" : \"%s\", \"#manufacturer\" : \"%s\", \"#os_version\" : \"%s\", \"#carrier\" : \"%s\", \"client_vs\" : \"%s\", \"resource_vs\" : \"%s\"}", tostring(arg_11_0), tostring(var_12_0), _G.TMP_MAC_ADDRESS or "", tostring(USER_ID), tostring(arg_11_1), tostring(var_12_1), tostring(var_12_2), _G.AnalyticsPresetProperties["#os"], tostring(manager.time:GetServerTime()), _G.AnalyticsPresetProperties["#zone_offset"], _G.AnalyticsPresetProperties["#device_model"], _G.AnalyticsPresetProperties["#manufacturer"], _G.AnalyticsPresetProperties["#os_version"], _G.AnalyticsPresetProperties["#carrier"], tostring(LuaForUtil.GetClientVersion()), tostring(LuaForUtil.GetResourceVersion()))

		print(var_12_3)
		GameToSDK.SendMessage(var_12_3)
	end)
end

function ShowStory(arg_13_0, arg_13_1, arg_13_2)
	CheckManagers()

	gameContext.oldRoutes_ = {}

	manager.gc:Collect()
	Resources.UnloadUnusedAssets()
	manager.story:StartBattleStory(arg_13_0, function()
		gameContext:DestroyCurRoutes()
		LuaExchangeHelper.ActionInvoke(arg_13_2)
		manager.gc:Collect()
		DestroyLua()
		gameContext:SetSystemLayer("battle")
		Resources.UnloadUnusedAssets()
	end, arg_13_1)
end

function GetMardukePlane()
	return TowerGameData:GetCanUsePlane()
end

function SendQuitBattle(arg_16_0, arg_16_1)
	var_0_1 = arg_16_1

	manager.uiInit()

	gameContext.oldRoutes_ = {}

	print("客户端战斗结束，准备向服务端请求战斗结果")

	local var_16_0 = BattleController.GetInstance():GetBattleStageData()

	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= var_16_0:GetType() then
		BattleInstance.hideBattlePanel()
	end

	gameContext:SetSystemLayer("battleResult")

	_G.PrintAllOpen_ = true

	print("开启心跳包打印，用于监测网络状态")
	print("网络连接状态是否可用：", Application.internetReachability ~= UnityEngine.NetworkReachability.NotReachable)
	print("网络连接状态是否为局域网：", Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork)

	local var_16_1 = BattleFieldData:GetServerBattleID()

	SDKTools.SendMessageToSDK("load_time_before_battle", {
		combat_id = var_16_0:GetStageId(),
		battle_id = var_16_1,
		use_milliseconds = arg_16_0.loadMilliseconds,
		battle_version = LuaForUtil.GetBattleVersion()
	})
	manager.achievementTips:FliteAchievementType({
		AchievementConst.AchievementType.MISSION,
		AchievementConst.AchievementType.BATTLE
	})

	local var_16_2 = GetOldPlayerExp()

	if var_16_0:GetIsCooperation() then
		manager.net:SendWithLoadingNew(54110, {
			battle_id = var_16_1
		}, 54111, function(arg_17_0, arg_17_1)
			BattleFieldData:FishCooperationBattle(arg_17_0)
			gameContext:DestroyCurRoutes()
			BattleCooperationCallLua.GotoTeam(var_16_1, arg_17_0.battle_result, arg_17_0.result, var_16_2)
		end)
	else
		manager.net:SendWithLoadingNew(54032, {
			battle_id = var_16_1
		}, 54033, function(arg_18_0, arg_18_1)
			BattleFieldData:FinishBattle(arg_18_0)
			gameContext:DestroyCurRoutes()
			GotoTeam(var_16_1, arg_18_0.battle_result, arg_18_0.result, var_16_2)
		end)
	end

	BattleCallLuaWaitLoading = true

	local var_16_3 = {
		["Atlas/BattleSettlement"] = 20,
		["Atlas/NewBattleSettlement"] = 20
	}

	PreLoadAsset(var_16_3, 0, function()
		for iter_19_0, iter_19_1 in pairs(var_16_3) do
			LuaForUtil.PreLoadAtlas(iter_19_0)
		end

		BattleCallLuaWaitLoading = false

		if BattleCallLuaCallBack and not BattleCallLuaCallBackWait then
			BattleCallLuaCallBack()

			BattleCallLuaCallBack = nil
		end
	end, true)
end

function GotoTeam(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	print("服务端战斗数据返回")
	print("收到服务器的消息，获取到新的战斗结果(0:战斗进行中,1:胜利,2:失败,3：主动退出):", arg_20_1.result)

	if arg_20_1.result > BattleConst.BATTLE_RESULT.UNFINISHED and arg_20_1.result <= BattleConst.BATTLE_RESULT.QUIT then
		local var_20_0 = BattleController.GetInstance():GetBattleStageData()

		print("BattleCallLua.进入目标结算stage: " .. var_20_0:GetType())

		local var_20_1, var_20_2 = CollectHeroExpChange(var_20_0)

		if isSuccess(arg_20_1.result - 1) and not var_0_1 then
			CheckBattleResultNeedAddHeroExp()
		end

		goToResult(arg_20_1.result - 1, arg_20_1.star_list, {
			challengedNumber = arg_20_1.clear_times,
			clear_times = arg_20_1.clear_times,
			oldPlayerEXPInfo = arg_20_3,
			heroDataCollect = var_20_1,
			errorCode = arg_20_2
		}, var_20_0)
		GetBattleResultNeedAddHeroExp()
	end
end

function goToResult(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	_G.PrintAllOpen_ = false

	print("关闭心跳包打印，用于监测网络状态")
	SetForceShowQuanquan(false)

	if _G.CannotConnectTimer then
		_G.CannotConnectTimer:Stop()

		_G.CannotConnectTimer = nil
	end

	ViewAnimationManager.isReturnFromBattle = true

	BattleResultGotoHandler:GotoResult(arg_21_3, arg_21_0, arg_21_1, arg_21_2, var_0_1)

	if not BattleCallLuaCallBackWait and not BattleCallLuaWaitLoading then
		BattleCallLuaCallBack()

		BattleCallLuaCallBack = nil
	end
end

function ShowSettlement()
	print("收到允许弹出结算界面通知（因为可能在播放胜利动作中）")

	if _G.CannotConnectTimer then
		_G.CannotConnectTimer:Stop()

		_G.CannotConnectTimer = nil
	end

	BattleCallLuaCallBackWait = false

	if BattleCallLuaCallBack and not BattleCallLuaWaitLoading then
		manager.achievementTips:Hide(true)
		BattleResultGotoHandler:SnapShot()

		if BattleResultGotoHandler.shotTimer then
			BattleResultGotoHandler.shotTimer:Stop()

			BattleResultGotoHandler.shotTimer = nil
		end

		BattleResultGotoHandler.shotTimer = FrameTimer.New(function()
			BattleCallLuaCallBack()

			BattleCallLuaCallBack = nil

			manager.achievementTips:Hide(false)
		end, 1, 1)

		BattleResultGotoHandler.shotTimer:Start()
	else
		CheckManagers()

		if not ConnectionHelper.GetIsDealWithError() then
			SetForceShowQuanquan(true)
		end

		_G.CannotConnectTimer = Timer.New(function()
			ConnectionHelper.ShowReturnToLoginTip()
		end, 600, 1)

		_G.CannotConnectTimer:Start()
	end
end

function GetResultReward()
	local var_25_0 = {}
	local var_25_1 = {}
	local var_25_2 = {}

	for iter_25_0, iter_25_1 in ipairs(BattleFieldData:GetBattleResultData().dropList) do
		var_25_1[iter_25_1.battleTimes] = {}
		var_25_2[iter_25_1.battleTimes] = {}

		for iter_25_2, iter_25_3 in ipairs(iter_25_1.rewardItems) do
			print(string.format("服务端发下第%s次物品数据id:", iter_25_1.battleTimes), iter_25_3.id, "num:", iter_25_3.num)
			table.insert(var_25_1[iter_25_1.battleTimes], {
				iter_25_3.id,
				iter_25_3.num
			})
			table.insert(var_25_0, {
				iter_25_3.id,
				iter_25_3.num
			})
		end

		for iter_25_4, iter_25_5 in ipairs(iter_25_1.extraReward) do
			print(string.format("服务端发下第%s次物品数据id:", iter_25_1.battleTimes), iter_25_5.id, "num:", iter_25_5.num)
			table.insert(var_25_2[iter_25_1.battleTimes], {
				iter_25_5.id,
				iter_25_5.num
			})
			table.insert(var_25_0, {
				iter_25_5.id,
				iter_25_5.num
			})
		end
	end

	return var_25_0, var_25_1, var_25_2
end

function EndBattleLogic(arg_26_0)
	manager.guide:OnBattleFinish(arg_26_0)
	manager.achievementTips:FliteAchievementType({})
end

function GetAbyssBossPhase()
	return AbyssData:GetCurrentBossPhase()
end

function OnQuitBattleSuccess()
	manager.notify:Invoke(BULLETIN_QUITBATTLE)
end

function GetOldPlayerExp()
	local var_29_0 = PlayerData:GetPlayerInfo()

	if var_29_0 then
		local var_29_1 = {}

		var_29_1.userLevel = var_29_0.userLevel or 0
		var_29_1.remain_exp = var_29_0.remain_exp or 0
		var_29_1.total_exp = var_29_0.total_exp or 0

		return var_29_1
	else
		return {
			userLevel = 0,
			total_exp = 0,
			remain_exp = 0
		}
	end
end

function CollectHeroExpChange(arg_30_0)
	local var_30_0, var_30_1 = arg_30_0:GetHeroTeam()
	local var_30_2 = arg_30_0:GetSystemHeroTeam()
	local var_30_3 = arg_30_0:GetAssistHeroOwnerList()
	local var_30_4 = {}
	local var_30_5 = {}

	if var_30_0[2] == 0 then
		table.remove(var_30_0, 2)
		table.remove(var_30_1, 2)
		table.insert(var_30_0, 0)
		table.insert(var_30_1, 0)
	end

	for iter_30_0 = 1, 3 do
		var_30_5[iter_30_0] = {}

		if not var_30_0[iter_30_0] or var_30_0[iter_30_0] == 0 then
			var_30_5[iter_30_0] = nil
		else
			local var_30_6 = arg_30_0:GetHeroDataByPos(iter_30_0)

			if var_30_6 and not var_30_2[iter_30_0] and (var_30_1[iter_30_0] == 0 or table.isEmpty(var_30_1)) and (var_30_3 and (var_30_3[iter_30_0] == "0" or var_30_3[iter_30_0] ~= "0" and var_30_3[iter_30_0] == PlayerData:GetPlayerInfo().userID) or table.isEmpty(var_30_3)) and NeedAddExpWithoutBlack(arg_30_0) then
				local var_30_7 = var_30_6.exp - LvTools.LevelToExp(var_30_6.level, "hero_level_exp1")
				local var_30_8 = LvTools.GetMaxTotalExp("hero_level_exp1") - var_30_6.exp

				if var_30_8 < 0 then
					var_30_8 = 0
				end

				local var_30_9 = arg_30_0:GetAddHeroExp() * arg_30_0:GetMultiple()
				local var_30_10 = arg_30_0:GetActivityID()
				local var_30_11 = ActivityData:GetActivityData(var_30_10)
				local var_30_12 = math.min((var_30_10 ~= 0 and (not var_30_11 or not var_30_11:IsActivitying()) or nil) and 0, var_30_8)
				local var_30_13, var_30_14, var_30_15, var_30_16, var_30_17 = LvTools.CheckHeroExp(var_30_6.level, var_30_6.exp + var_30_12, (HeroTools.GetHeroCurrentMaxLevel(var_30_6)))

				table.insert(var_30_4, {
					id = var_30_6.id,
					newLv = var_30_13,
					newExp = var_30_6.exp + (var_30_12 - var_30_17)
				})

				var_30_5[iter_30_0] = {
					oldLv = var_30_6.level,
					newLv = var_30_13,
					oldPersent = math.min(math.floor(var_30_7 / GameLevelSetting[var_30_6.level].hero_level_exp1 * 1000) / 1000, 0.9999),
					newPersent = math.min(math.floor(var_30_14 / GameLevelSetting[var_30_13].hero_level_exp1 * 1000) / 1000, 0.9999)
				}
			else
				var_30_5[iter_30_0] = nil
			end
		end
	end

	var_0_2 = var_30_4

	return var_30_5 or {}
end

function CheckBattleResultNeedAddHeroExp()
	if var_0_2 then
		for iter_31_0, iter_31_1 in ipairs(var_0_2) do
			HeroAction.AddHeroExpSuccess(iter_31_1.id, iter_31_1.newLv, iter_31_1.newExp)
		end

		var_0_2 = nil
	end
end

function GetBattleResultNeedAddHeroExp()
	var_0_2 = nil

	return var_0_2
end

function NeedAddExpWithoutBlack(arg_33_0)
	if not arg_33_0 then
		return false
	end

	local var_33_0 = arg_33_0:GetType()

	if var_33_0 == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		return false
	end

	if var_33_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_33_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		return BattleInstance.NeedAddExp(arg_33_0)
	end

	if var_33_0 == BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME then
		return false
	end

	if var_33_0 == BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE then
		return false
	end

	return true
end

function GetBattleResultSnapShot()
	return BattleResultGotoHandler:GetSnapShot()
end

function ReleaseBattleResultSnapshot()
	pcall(function()
		if BattleResultGotoHandler ~= nil then
			BattleResultGotoHandler:ReleaseSnapShot()
		end
	end)
end
