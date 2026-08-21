ys = {}
pg = {}
cs = {}
pg._weak = setmetatable({}, {
	__mode = "k"
})
PLATFORM_CH = 1
PLATFORM_JP = 2
PLATFORM_KR = 3
PLATFORM_US = 4
PLATFORM_CHT = 5
PLATFORM_CODE = PLATFORM_CH
IsUnityEditor = UnityEngine.Application.isEditor

require("Include")
require("tolua.reflection")
tolua.loadassembly("Assembly-CSharp")
tolua.loadassembly("UnityEngine.UI")
tolua.loadassembly("Live2D.Cubism")
tolua.loadassembly("spine-unity")
math.randomseed(os.time())

CSharpVersion = NetConst.GatewayState

originalPrint("C# Ver... " .. CSharpVersion)

PLATFORM = LuaHelper.GetPlatformInt()
SDK_EXIT_CODE = 99

if not IsUnityEditor then
	function assert()
		return
	end
end

QualitySettings.vSyncCount = 0
QualitySettings.skinWeights = ReflectionHelp.RefGetField(typeof("UnityEngine.SkinWeights"), "Unlimited", nil)
tf(GameObject.Find("EventSystem")):GetComponent(typeof(EventSystem)).sendNavigationEvents = false

if IsUnityEditor then
	function luaIdeDebugFunc()
		breakInfoFun = require("LuaDebugjit")("localhost", 7003)
		time = Timer.New(breakInfoFun, 0.5, -1, 1)

		time:Start()
		print("luaIdeDebugFunc")

		return
	end
end

if (PLATFORM_CODE == PLATFORM_CH and CSharpVersion < 48 or PLATFORM_CODE == PLATFORM_CHT) and PLATFORM == 8 then
	pg.SdkMgr.GetInstance():InitSDK()
end

if PLATFORM_CODE == PLATFORM_CH then
	BilibiliSdkMgr.checkSimulator = false
end

pg.TimeMgr.GetInstance():Init()
pg.TimeMgr.GetInstance():_SetServerTime_(VersionMgr.Inst.timestamp, VersionMgr.Inst.monday0oclockTimestamp, VersionMgr.Inst.realStartUpTimeWhenSetServerTime)
pg.PushNotificationMgr.GetInstance():Init()

function OnApplicationPause(arg_3_0)
	originalPrint("OnApplicationPause: " .. tostring(arg_3_0))

	if not pg.m02 then
		return
	end

	if arg_3_0 then
		pg.m02:sendNotification(GAME.PAUSE_BATTLE)
		pg.PushNotificationMgr.GetInstance():PushAll()
	else
		pg.SdkMgr.GetInstance():BindCPU()
	end

	pg.SdkMgr.GetInstance():OnAppPauseForSDK(arg_3_0)
	pg.m02:sendNotification(GAME.ON_APPLICATION_PAUSE, arg_3_0)

	return
end

function OnApplicationExit()
	originalPrint("OnApplicationExit")

	if pg.GameTrackerMgr then
		pg.GameTrackerMgr.GetInstance():Synchronization()
	end

	local var_4_0 = pg.FileDownloadMgr.GetInstance()

	if var_4_0:IsRunning() then
		return
	end

	local var_4_1 = pg.NewStoryMgr.GetInstance()

	if var_4_1:IsRunning() then
		pg.NewStoryMgr.GetInstance():ForEscPress()

		return
	end

	local var_4_2 = pg.NewGuideMgr.GetInstance()

	if var_4_2:IsBusy() then
		return
	end

	local var_4_3 = pg.PerformMgr.GetInstance()

	if var_4_3:IsRunning() then
		return
	end

	local var_4_4 = ys.Battle.BattleState.GetInstance()

	if var_4_4 and var_4_4:GetState() == var_4_4.BATTLE_STATE_FIGHT and not var_4_4:IsPause() then
		pg.m02:sendNotification(GAME.PAUSE_BATTLE)

		return
	end

	local var_4_5 = pg.UIMgr.GetInstance()

	if not var_4_5._loadPanel or var_4_5:LoadingRetainCount() ~= 0 then
		return
	end

	local var_4_6 = pg.SceneAnimMgr.GetInstance()

	if var_4_6:IsPlaying() then
		return
	end

	local var_4_7 = pg.MsgboxMgr.GetInstance()
	local var_4_8 = var_4_7 and var_4_7:getMsgBoxOb()
	local var_4_9 = pg.NewStoryMgr.GetInstance()

	if var_4_9 and var_4_9:IsRunning() then
		if var_4_8 and var_4_8.activeSelf then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
			triggerButton(var_4_7._closeBtn)
		end

		return
	end

	if not pg.m02 then
		return
	end

	local var_4_11 = var_4_10:retrieveProxy(ContextProxy.__cname)

	if not var_4_11 then
		return
	end

	local var_4_12 = var_4_11:getCurrentContext()

	if not var_4_12 then
		return
	end

	local var_4_13 = pg.ShareMgr.GetInstance()

	if var_4_13.go and isActive(var_4_13.go) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(var_4_13.panel:Find("main/top/btnBack"))

		return
	end

	local var_4_14 = var_4_10:retrieveMediator(var_4_12:retriveLastChild().mediator.__cname)

	if not var_4_14 or not var_4_14.viewComponent then
		return
	end

	local var_4_16 = -1
	local var_4_17

	if var_4_8 and var_4_8.activeSelf then
		var_4_17 = var_4_8.transform.parent
		var_4_16 = var_4_8.transform:GetSiblingIndex()
	end

	if pg.playerResUI:checkBackPressed() then
		return
	end

	if var_4_14.viewComponent._tf.parent == var_4_17 and var_4_16 < var_4_14.viewComponent._tf:GetSiblingIndex() then
		var_4_15:onBackPressed()

		return
	end

	if var_4_8 and var_4_8.activeSelf then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(var_4_7._closeBtn)

		return
	end

	local var_4_18 = checkExist(pg.NewStyleMsgboxMgr.GetInstance(), {
		"_tf"
	})

	if var_4_18 and isActive(var_4_18) then
		pg.NewStyleMsgboxMgr.GetInstance():Hide()

		return
	end

	local var_4_19 = nowWorld()

	if var_4_19 and var_4_19.staminaMgr:IsShowing() then
		var_4_19.staminaMgr:Hide()

		return
	end

	var_4_15:onBackPressed()

	return
end

function OnReceiveMemoryWarning()
	return
end

function PressBack()
	if not IsNil(pg.MsgboxMgr.GetInstance()._go) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("confirm_app_exit"),
			onYes = function()
				Application.Quit()

				return
			end
		})
	end

	return
end

local var_0_0 = os.clock()

seriesAsync({
	function(arg_8_0)
		pg.ShaderMgr.GetInstance():Init(arg_8_0)

		return
	end,
	function(arg_9_0)
		require("HybridCLRConst")
		Sandystar.HybridCLRTool.HybridCLRHelper.LoadPatchDLL(Application.streamingAssetsPath .. "/AssetBundles/hybridclr/patch/", HybridCLRConst.PatchDllList)
		Sandystar.HybridCLRTool.HybridCLRHelper.LoadHotfixDLL(Application.persistentDataPath .. "/AssetBundles/hybridclr/hotfix/", HybridCLRConst.HotfixDllList)
		Sandystar.HybridCLRTool.HybridCLRHelper.SetFinishCallback(function()
			GraphicsInterface = BLHX.Rendering.GraphicsInterface

			GraphicSettingConst.ClearPlayerPrefs()
			GraphicSettingConst.InitDefautQuality()
			arg_9_0()

			return
		end)

		return
	end,
	function(arg_11_0)
		parallelAsync({
			function(arg_12_0)
				pg.LayerWeightMgr.GetInstance():Init(arg_12_0)

				return
			end,
			function(arg_13_0)
				pg.UIMgr.GetInstance():Init(arg_13_0)

				return
			end,
			function(arg_14_0)
				pg.CriMgr.GetInstance():Init(arg_14_0)

				return
			end
		}, arg_11_0)

		return
	end,
	function(arg_15_0)
		parallelAsync({
			function(arg_16_0)
				pg.FontMgr.GetInstance():Init(arg_16_0)

				return
			end,
			function(arg_17_0)
				pg.PoolMgr.GetInstance():Init(arg_17_0)

				return
			end,
			function(arg_18_0)
				pg.TipsMgr.GetInstance():Init(arg_18_0)

				return
			end,
			function(arg_19_0)
				pg.MsgboxMgr.GetInstance():Init(arg_19_0)

				return
			end,
			function(arg_20_0)
				pg.NewStyleMsgboxMgr.GetInstance():Init(arg_20_0)

				return
			end,
			function(arg_21_0)
				pg.SystemOpenMgr.GetInstance():Init(arg_21_0)

				return
			end,
			function(arg_22_0)
				pg.SystemGuideMgr.GetInstance():Init(arg_22_0)

				return
			end,
			function(arg_23_0)
				pg.NewGuideMgr.GetInstance():Init(arg_23_0)

				return
			end,
			function(arg_24_0)
				pg.ToastMgr.GetInstance():Init(arg_24_0)

				return
			end,
			function(arg_25_0)
				pg.WorldToastMgr.GetInstance():Init(arg_25_0)

				return
			end,
			function(arg_26_0)
				pg.SecondaryPWDMgr.GetInstance():Init(arg_26_0)

				return
			end,
			function(arg_27_0)
				pg.ShipFlagMgr.GetInstance():Init(arg_27_0)

				return
			end,
			function(arg_28_0)
				pg.NewStoryMgr.GetInstance():Init(arg_28_0)

				return
			end,
			function(arg_29_0)
				pg.EasyRedDotMgr.GetInstance():Init(arg_29_0)

				return
			end,
			function(arg_30_0)
				pg.UserAgreementMgr.GetInstance():Init(arg_30_0)

				return
			end,
			function(arg_31_0)
				pg.BrightnessMgr.GetInstance():Init(arg_31_0)

				return
			end,
			function(arg_32_0)
				pg.ConfigTablePreloadMgr.GetInstance():Init(arg_32_0)

				return
			end,
			function(arg_33_0)
				pg.CameraFixMgr.GetInstance():Init(arg_33_0)

				return
			end,
			function(arg_34_0)
				pg.BgmMgr.GetInstance():Init(arg_34_0)

				return
			end,
			function(arg_35_0)
				pg.SettingsGroupMgr.GetInstance():Init()
				pg.FileDownloadMgr.GetInstance():Init(arg_35_0)

				return
			end,
			function(arg_36_0)
				pg.RepairResMgr.GetInstance():Init(arg_36_0)

				return
			end,
			function(arg_37_0)
				pg.NodeCanvasMgr.GetInstance():Init(arg_37_0)

				return
			end,
			function(arg_38_0)
				pg.SceneAnimMgr.GetInstance():Init(arg_38_0)

				return
			end,
			function(arg_39_0)
				pg.PerformMgr.GetInstance():Init(arg_39_0)

				return
			end,
			function(arg_40_0)
				pg.ClickEffectMgr.GetInstance():Init(arg_40_0)

				return
			end,
			function(arg_41_0)
				pg.CameraRTMgr.GetInstance():Init(arg_41_0)

				return
			end,
			function(arg_42_0)
				pg.GameTrackerMgr.GetInstance():Init(arg_42_0)

				return
			end,
			function(arg_43_0)
				pg.GMTMgr.GetInstance():Init(arg_43_0)

				return
			end,
			function(arg_44_0)
				pg.ChangeSkinMgr.GetInstance():Init(arg_44_0)

				return
			end,
			function(arg_45_0)
				if LOCK_ISLAND_DISPLAY then
					arg_45_0()
				else
					pg.IslandVisitorNotificationMgr.GetInstance():Init(arg_45_0)
				end

				return
			end
		}, arg_15_0)

		return
	end
}, function(arg_46_0)
	pg.SdkMgr.GetInstance():QueryWithProduct()
	print("loading cost: " .. os.clock() - var_0_0)
	VersionMgr.Inst:DestroyUI()

	local var_46_0 = GameObject.Find("OverlayCamera/Overlay/UIMain/ServerChoosePanel")

	if not IsNil(var_46_0) then
		Object.Destroy(var_46_0)
	end

	Screen.sleepTimeout = SleepTimeout.SystemSetting

	pg.UIMgr.GetInstance():displayLoadingBG(true)

	if arg_46_0 then
		pg.UIMgr.GetInstance():Loading(arg_46_0)
		error(arg_46_0)

		return
	end

	pg.SdkMgr.GetInstance():BindCPU()

	pg.m02 = pm.Facade.getInstance("m02")

	pg.m02:registerCommand(GAME.STARTUP, StartupCommand)
	pg.m02:sendNotification(GAME.STARTUP)

	pg.playerResUI = PlayerResUI.New()

	pg.SdkMgr.GetInstance():GoSDkLoginScene()
	pg.UIMgr.GetInstance():AddDebugButton("Device Info", function()
		originalPrint("+++++++++++graphicsDeviceVendorID:" .. SystemInfo.graphicsDeviceVendorID)
		DevicePerformanceUtil.GetDevicePerformanceLevel()
		originalPrint("CPU核心:" .. SystemInfo.processorCount)
		originalPrint("显存:" .. SystemInfo.graphicsMemorySize)
		originalPrint("内存:" .. SystemInfo.systemMemorySize)
		originalPrint("主频:" .. SystemInfo.processorFrequency)
		originalPrint("+++++++++++")

		return
	end)

	return
end)

return
