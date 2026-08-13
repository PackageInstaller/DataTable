class = var_0_10000

local var_0_0 = "LogoutCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	if not var_1_0.proxyRegister then
		return
	end

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.sendNotification

	GAME = var_1_10005

	var_1_3(var_1_2, var_1_10005.WILL_LOGOUT)

	PLATFORM = var_1_3
	PLATFORM_WINDOWSEDITOR = var_1_2

	if var_1_3 ~= var_1_2 then
		PLATFORM_CHT = var_1_3
		PLATFORM_CODE = var_1_2

		if var_1_3 == var_1_2 then
			var_1_3 = var_1_1.code
			SDK_EXIT_CODE = var_1_2

			if var_1_3 ~= var_1_2 then
				pg = var_1_3

				local var_1_4 = var_1_3.SdkMgr.GetInstance()

				var_1_3.LogoutSDK(var_1_4)

				return
			end
		end
	end

	LOCK_ISLAND_DISPLAY = var_1_3

	if not var_1_3 then
		pg = var_1_3

		local var_1_5 = var_1_3.IslandVisitorNotificationMgr.GetInstance()

		var_1_3.Quit(var_1_5)
	end

	pg = var_1_3

	local var_1_6 = var_1_3.TrackerMgr.GetInstance()
	local var_1_7 = var_3.Tracking

	TRACKING_ROLE_LOGOUT = var_5

	var_1_7(var_1_6, var_5)

	pg = var_1_7

	local var_1_8 = var_1_7.GameTrackerMgr.GetInstance()

	var_3.Synchronization(var_1_8)

	ys = var_3

	local var_1_9 = var_3.Battle.BattleState.GetInstance()
	local var_1_10 = var_3.GetState(var_1_9)

	ys = var_1_9

	if var_1_10 ~= var_1_9.Battle.BattleState.BATTLE_STATE_IDLE then
		warning = var_5

		var_5("stop and clean battle.")
		var_3:Stop("kick")
	end

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.sendNotification

	GAME = var_1_10007

	var_1_12(var_1_11, var_1_10007.STOP_BATTLE_LOADING, {})

	pg = var_1_12

	local var_1_13 = var_1_12.NewStoryMgr.GetInstance()

	var_5.Quit(var_1_13)

	pg = var_5

	local var_1_14 = var_5.PerformMgr.GetInstance()

	var_5.Quit(var_1_14)

	pg = var_5

	if var_5.MsgboxMgr.GetInstance()._go.activeSelf then
		pg = var_5
		var_1_14 = var_5.MsgboxMgr.GetInstance()

		var_5.hide(var_1_14)
	end

	getProxy = var_5
	SettingsProxy = var_1_14

	local var_1_15 = var_5(var_1_14)

	var_5.Reset(var_1_15)

	originalPrint = var_6

	local var_1_16 = "disconnect from server...-"

	tostring = var_8

	var_6(var_1_16 .. var_8(var_1_1.code))

	pg = var_6

	local var_1_17 = var_6.ConnectionMgr.GetInstance()

	var_6.Disconnect(var_1_17)

	BillboardMediator = var_6
	var_6.time = nil
	Map = var_6
	var_6.lastMap = nil
	Map = var_6
	var_6.lastMapForActivity = nil
	BuildShipScene = var_6
	var_6.projectName = nil
	DockyardScene = var_6
	var_6.selectAsc = nil
	DockyardScene = var_6
	var_6.sortIndex = nil
	DockyardScene = var_6
	var_6.typeIndex = nil
	DockyardScene = var_6
	var_6.campIndex = nil
	DockyardScene = var_6
	var_6.rarityIndex = nil
	DockyardScene = var_6
	var_6.extraIndex = nil
	DockyardScene = var_6
	var_6.commonTag = nil
	LevelMediator2 = var_6
	var_6.prevRefreshBossTimeTime = nil
	ActivityMainScene = var_6
	var_6.FetchReturnersTime = nil
	ActivityMainScene = var_6
	var_6.Data2Time = nil
	MainSkinDiscountItemTipSequence = var_6
	var_6.TipFlag = nil

	local var_1_18

	pg = COMBAT_SKIN_KEY

	local var_1_19 = var_6.BrightnessMgr.GetInstance()

	var_6.ExitManualMode(var_1_19)

	pg = var_6

	local var_1_20 = var_6.SeriesGuideMgr.GetInstance()

	var_6.dispose(var_1_20)

	pg = var_6

	local var_1_21 = var_6.NewGuideMgr.GetInstance()

	var_6.Exit(var_1_21)

	PoolMgr = var_6

	local var_1_22 = var_6.GetInstance()

	var_6.DestroyAllPrefab(var_1_22)

	pg = var_6

	local var_1_23 = var_6.GuildMsgBoxMgr.GetInstance()

	var_6.Hide(var_1_23)

	getProxy = var_6
	UserProxy = var_1_23

	if var_6(var_1_23) then
		if var_6:getRawData() then
			var_1_23:clear()
		end

		var_6:SetLoginedFlag(false)
	end

	Context = var_1_23

	local var_1_24 = var_1_23.New()

	var_7.extendData(var_1_24, var_1_1)

	SCENE = var_8

	local var_1_25 = var_8.SetSceneInfo
	local var_1_26 = var_7

	SCENE = var_10

	var_1_25(var_1_26, var_10.LOGIN)

	local var_1_27 = arg_1_0
	local var_1_28 = arg_1_0.sendNotification

	GAME = var_10

	var_1_28(var_1_27, var_10.LOAD_SCENE, {
		context = var_7,
		callback = function()
			pg = var_2_10000

			if var_2_10000.proxyRegister then
				pg = var_0

				local var_2_0 = var_0.proxyRegister

				var_0.Stop(var_2_0)

				pg = var_0

				local var_2_1 = var_0.proxyRegister

				var_0.RemoveProxy(var_2_1, arg_1_0.facade)

				pg = var_0
				var_0.proxyRegister = nil
			end

			local var_2_2 = arg_1_0.facade
			local var_2_3 = var_0.removeCommand

			GAME = var_2_10002

			var_2_3(var_2_2, var_2_10002.LOAD_SCENE_DONE)

			return
		end
	})

	local var_1_29 = var_1_1.code

	SDK_EXIT_CODE = var_1_27

	if var_1_29 ~= var_1_27 then
		pg = var_1_29

		local var_1_30 = var_1_29.SdkMgr.GetInstance()

		var_8.LogoutSDK(var_1_30, var_1_1.code)
	end

	return
end

return var_0_1
